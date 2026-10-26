/datum/component/vore
	var/ui_editing_lookuptable = FALSE
	var/rate_limit_belly_creation = 0

/datum/component/vore/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VorePanel", "吞食面板")
		ui.open()

/datum/component/vore/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	// Only parent can edit us
	if(user != parent)
		. = min(., UI_UPDATE)

/datum/component/vore/ui_state(mob/user)
	return GLOB.conscious_state

/datum/component/vore/ui_static_data(mob/user)
	var/list/data = list()

	data["max_bellies"] = MAX_BELLIES
	data["max_prey"] = MAX_PREY
	data["max_verb_length"] = MAX_VERB_LENGTH
	data["max_vore_message_length"] = MAX_VORE_MESSAGE_LENGTH
	data["min_vore_message_length"] = MIN_VORE_MESSAGE_LENGTH

	data["max_burn_damage"] = MAX_BURN_DAMAGE
	data["max_brute_damage"] = MAX_BRUTE_DAMAGE
	data["max_escape_time"] = MAX_ESCAPE_TIME
	data["min_escape_time"] = MIN_ESCAPE_TIME

	data["character_slots"] = null
	data["vore_slots"] = null
	data["lookup_table"] = null

	var/list/overlay_data = list()
	for(var/atom/movable/screen/fullscreen/carrier/vore/type as anything in subtypesof(/atom/movable/screen/fullscreen/carrier/vore))
		UNTYPED_LIST_ADD(overlay_data, list(
			"path" = type,
			"name" = initial(type.name),
			"icon" = initial(type.icon),
			"icon_state" = initial(type.icon_state),
			"recolorable" = initial(type.recolorable),
		))
	data["available_overlays"] = overlay_data

	if(ui_editing_lookuptable)
		var/datum/vore_preferences/vore_prefs = user.client.get_vore_prefs()
		if(!vore_prefs)
			return data

		data["character_slots"] = user.client.prefs.create_character_profiles()
		data["vore_slots"] = vore_prefs.generate_slot_choice_list()
		data["lookup_table"] = vore_prefs.get_lookup_table()

	return data

/datum/component/vore/ui_data(mob/user)
	var/list/data = list()

	data["selected_belly"] = LAZYFIND(vore_bellies, selected_belly)

	var/list/bellies = list()

	var/index = 0
	for(var/obj/vore_belly/belly as anything in vore_bellies)
		index++
		UNTYPED_LIST_ADD(bellies, list("index" = index) + belly.ui_data(user))

	data["bellies"] = bellies

	// Always their own prefs
	var/datum/vore_preferences/vore_prefs = user.get_vore_prefs()
	if(vore_prefs)
		data += vore_prefs.ui_data(user)

	data["inside"] = null
	if(istype(user.loc, /obj/vore_belly))
		var/obj/vore_belly/tummy = user.loc
		data["inside"] = tummy.ui_data(user)

	data["not_our_owner"] = (user.ckey != our_owner_ckey)

	return data

/datum/component/vore/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/living/living_parent = parent
	if(usr != living_parent)
		stack_trace("Vore component ui_act triggered by [key_name(usr)] who IS NOT OUR PARENT [key_name(living_parent)]")
		return

	switch(action)
		if("create_belly")
			if(!COOLDOWN_FINISHED(src, rate_limit_belly_creation))
				to_chat(living_parent, span_warning("现在无法创建更多腹腔，请在 [COOLDOWN_TIMELEFT(src, rate_limit_belly_creation) / 10] 秒后重试。"))
				return
			if(LAZYLEN(vore_bellies) >= MAX_BELLIES)
				to_chat(living_parent, span_warning("你最多只能拥有 [MAX_BELLIES] 个腹腔。"))
				return TRUE
			create_default_belly()
			COOLDOWN_START(src, rate_limit_belly_creation, BELLY_CREATION_COOLDOWN)
			. = TRUE
		if("select_belly")
			var/obj/vore_belly/new_selected = locate(params["ref"])
			if(istype(new_selected) && new_selected.owner == src)
				selected_belly = new_selected
				to_chat(living_parent, span_notice("猎物现在将进入 [selected_belly]。"))
			. = TRUE
		if("click_prey")
			var/mob/prey = locate(params["ref"])
			if(istype(prey))
				click_prey(prey)
			. = TRUE
		if("edit_belly")
			var/obj/vore_belly/target = locate(params["ref"])
			if(!istype(target))
				return
			if(target.owner != src)
				return
			target.ui_modify_var(params["var"], params["value"])
			save_bellies()
			. = TRUE
		if("test_sound")
			var/obj/vore_belly/target = locate(params["ref"])
			if(!istype(target))
				return
			if(target.owner != src)
				return
			switch(params["sound"])
				if("insert_sound")
					SEND_SOUND(living_parent, sound(target.get_insert_sound()))
				if("release_sound")
					SEND_SOUND(living_parent, sound(target.get_release_sound()))
		if("set_pref")
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				to_chat(living_parent, span_danger("吞食偏好无法载入，因此无法保存。"))
				return

			var/key = params["key"]
			var/value = params["value"]

			var/datum/vore_pref/P = GLOB.vore_preference_entries_by_key[key]
			if(!istype(P))
				CRASH("Bad pref key: [key]")

			if(!vore_prefs.write_preference(P, value))
				CRASH("Couldn't write value for [key] ([P]) ([value])")
			. = TRUE
		if("move_belly")
			var/obj/vore_belly/target = locate(params["ref"])
			if(!istype(target))
				return
			if(target.owner != src)
				return
			var/index = vore_bellies.Find(target)
			if(!index)
				return

			var/dir = params["dir"]
			if(dir == "up" && index > 1)
				vore_bellies.Swap(index - 1, index)
			else if(index < LAZYLEN(vore_bellies))
				vore_bellies.Swap(index, index + 1)

			save_bellies()
			. = TRUE
		if("delete_belly")
			var/obj/vore_belly/target = locate(params["ref"])
			if(!istype(target))
				return
			if(target.owner != src)
				return
			if(LAZYLEN(vore_bellies) == 1)
				to_chat(living_parent, span_danger("不能删除最后一个腹腔，请修改它或新建一个来替代。"))
				return

			qdel(target)
			save_bellies()
			. = TRUE
		if("belly_backups")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("无法对不属于你的吞食组件执行此操作。"))
				return
			download_belly_backup()
			. = TRUE
		if("load_slot")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("无法对不属于你的吞食组件执行此操作。"))
				return
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				return

			// returns true if the user doesn't decline to load a slot
			if(vore_prefs.load_slot())
				clear_bellies()
				load_bellies_from_prefs()
			. = TRUE
		if("set_slot_name")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("无法对不属于你的吞食组件执行此操作。"))
				return
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				return

			var/name = permissive_sanitize_name(params["name"])
			vore_prefs.set_slot_name(name)
			. = TRUE
		if("copy_to_slot")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("无法对不属于你的吞食组件执行此操作。"))
				return
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				return

			var/slot_to_save_over = vore_prefs.copy_to_slot()
			if(slot_to_save_over != null)
				save_bellies(slot_to_save_over)
				to_chat(living_parent, span_notice("已将腹腔配置复制到槽位 [slot_to_save_over]。"))
			. = TRUE
		if("toggle_lookup_data")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("无法对不属于你的吞食组件执行此操作。"))
				return
			ui_editing_lookuptable = !ui_editing_lookuptable
			update_static_data(living_parent, ui)
			. = TRUE
		if("set_lookup_table_entry")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("无法对不属于你的吞食组件执行此操作。"))
				return
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				return
			var/from_slot = params["from"]
			var/to_slot = text2num(params["to"])
			if(isnull(to_slot))
				return

			var/list/lookup_table = vore_prefs.get_lookup_table()
			lookup_table["[from_slot]"] = to_slot
			vore_prefs.set_lookup_table(lookup_table)
			update_static_data(living_parent, ui)

			. = TRUE
		if("delete_lookup_table_entry")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("无法对不属于你的吞食组件执行此操作。"))
				return
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				return
			var/slot_to_delete = "[params["slot_to_delete"]]"

			var/list/lookup_table = vore_prefs.get_lookup_table()
			lookup_table -= slot_to_delete
			vore_prefs.set_lookup_table(lookup_table)
			update_static_data(living_parent, ui)

			. = TRUE
		if("import_bellies")
			if(!COOLDOWN_FINISHED(src, rate_limit_belly_creation))
				to_chat(living_parent, span_warning("现在无法创建更多腹腔，请在 [COOLDOWN_TIMELEFT(src, rate_limit_belly_creation) / 10] 秒后重试。"))
				return

			// Nearly straight from CHOMP
			var/panel_choice = tgui_input_list(living_parent, "导入腹腔（注意：对 VRDB 的支持十分有限）", "选择选项", list("从 JSON 导入所有腹腔", "从 JSON 导入一个腹腔"))
			if(!panel_choice)
				return
			var/pickOne = FALSE
			if(panel_choice == "从 JSON 导入一个腹腔")
				pickOne = TRUE
			var/input_file = input(living_parent, "请选择有效的 JSON 文件进行导入。", "导入腹腔") as file
			var/input_data
			try
				var/text = file2text(input_file)

				if(LAZYLEN(text) > MAX_JSON_CHARACTERS)
					CRASH("提供的文件过大，无法解析。")

				input_data = json_decode(text)

				if(!islist(input_data))
					CRASH("提供的文件不是有效的 JSON 文件！")

				if(LAZYLEN(input_data) > MAX_JSON_ENTRIES)
					CRASH("提供的文件过大，无法解析。")

				var/is_vrdb = detect_vrdb(input_data)
				if(is_vrdb)
					to_chat(living_parent, span_danger("警告：此文件将按 VRDB 文件解析。转换仅尽力而为，结果可能不尽如人意。"))
				else
					if(input_data["db_repo"] != VORE_DB_REPO)
						CRASH("无法加载文件：db_repo 应为‘[VORE_DB_REPO]’，实际为‘[input_data["db_repo"]]’")

					if(input_data["db_version"] != VORE_DB_VERSION)
						CRASH("无法加载文件：db_version 应为‘[VORE_DB_VERSION]’，实际为‘[input_data["db_version"]]’")

				var/list/bellies_to_import = is_vrdb ? input_data : input_data["bellies"]

				if(LAZYLEN(bellies_to_import) < 1)
					CRASH("未找到任何腹腔！")

				if(pickOne)
					var/list/choices = list()
					var/index = 0
					var/list/repeat_items = list()
					for(var/list/V in bellies_to_import)
						index++
						var/name = V["name"]
						if(!istext(name))
							name = "<未命名>"
						name = avoid_assoc_duplicate_keys(name, repeat_items)
						choices[name] = index
					var/picked = tgui_input_list(living_parent, "导入腹腔", "选择哪个腹腔？", choices)
					if(picked)
						bellies_to_import = list(bellies_to_import[choices[picked]])

				var/current_belly_count = LAZYLEN(vore_bellies)
				var/amount_to_import = min(LAZYLEN(bellies_to_import), MAX_BELLIES - LAZYLEN(current_belly_count))
				if(amount_to_import != LAZYLEN(bellies_to_import))
					to_chat(living_parent, span_warning("选择导入的腹腔过多，只会导入前 [amount_to_import] 个。"))

				for(var/i in 1 to amount_to_import)
					var/list/belly = bellies_to_import[i]
					var/obj/vore_belly/new_belly = new /obj/vore_belly(parent, src)
					new_belly.deserialize(belly)
					CHECK_TICK

				// Directly scale cooldown with how much they're creating
				COOLDOWN_START(src, rate_limit_belly_creation, BELLY_CREATION_COOLDOWN * amount_to_import)
				to_chat(living_parent, span_notice("腹腔导入完毕！"))
				save_bellies()
			catch(var/exception/e)
				tgui_alert(living_parent, "提供的文件含有错误：[e]", "错误！")
				return FALSE

			. = TRUE
		if("export_bellies")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("无法对不属于你的吞食组件执行此操作。"))
				return
			var/datum/vore_preferences/vore_prefs = get_parent_vore_prefs()
			if(!vore_prefs)
				return
			vore_prefs.export_slot()
			. = TRUE
		if("test_fullscreen")
			if(living_parent.screens["vore"])
				to_chat(living_parent, span_warning("已有腹腔全屏效果显示时，无法预览另一个。"))
				return
			if(!living_parent.wants_vore_fullscreen())
				to_chat(living_parent, span_warning("偏好设置关闭时，无法预览腹腔全屏效果。"))
				return
			// We need a belly for this to be relative to, for recoloring
			var/obj/vore_belly/target = locate(params["ref"])
			if(!istype(target))
				return
			if(target.owner != src)
				return
			target.show_fullscreen(living_parent)
			addtimer(CALLBACK(src, PROC_REF(reset_vore_fullscreen)), 2 SECONDS)
			. = TRUE

/datum/component/vore/proc/reset_vore_fullscreen()
	var/mob/living/living_parent = parent
	living_parent.clear_fullscreen("vore", 1 SECONDS)

/datum/component/vore/proc/click_prey(mob/living/prey)
	var/mob/living/living_parent = parent

	if(prey == living_parent)
		living_parent.examinate(living_parent)
		return

	var/obj/vore_belly/prey_loc = prey.loc
	if(!istype(prey_loc))
		return

	// We are prey next to them
	if(prey_loc == living_parent.loc)
		click_fellow_prey(prey)
	// We ate them
	else if(prey_loc.owner == src)
		click_our_prey(prey)

/datum/component/vore/proc/click_fellow_prey(mob/living/prey)
	var/obj/vore_belly/prey_loc = prey.loc
	var/mob/living/pred = prey_loc.owner.parent
	var/mob/living/living_parent = parent

	var/list/options = list("查看")

	// If not absorbed, able to do these
	if(!HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE) && !HAS_TRAIT_FROM(living_parent, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
		options += list("互动", "帮助逃出")

	var/what_to_do = tgui_alert(living_parent, "你想对 [prey] 做什么？", "猎物选项", options)
	// We have to check all of the conditions inside each of these branches because things could have changed while the
	// dialog was open.
	switch(what_to_do)
		if("查看")
			living_parent.examinate(prey)
		if("互动")
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, "[prey] 已被吸收，无法帮助。")
				return
			if(HAS_TRAIT_FROM(living_parent, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, "你已被吸收，无法帮助别人逃出。")
				return
			living_parent.CtrlShiftClickOn(prey)
		if("帮助逃出")
			if(HAS_TRAIT_FROM(living_parent, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, "你已被吸收，无法帮助别人逃出。")
				return
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, "[prey] 已被吸收，无法帮助。")
				return
			// If they're otherwise incapacitated
			if(living_parent.incapacitated)
				return

			to_chat(living_parent, span_notice(span_green("你开始把 [prey] 向外推，帮助逃脱！")))
			to_chat(prey, span_notice("[living_parent] 开始把你向外推，帮助你逃脱！"))
			to_chat(pred, span_warning("有人正试图从你体内逃走！"))

			if(do_after(living_parent, 5 SECONDS, pred, timed_action_flags = IGNORE_TARGET_LOC_CHANGE) && prob(33))
				if(prey.loc != prey_loc)
					return
				prey_loc.release(prey)
				to_chat(living_parent, span_notice(span_green("你成功帮助 [prey] 脱离险境！")))
				to_chat(prey,  span_notice(span_green("[living_parent] 把你推了出去！")))
				to_chat(pred, span_alert("[prey] 强行挣脱了你身体的束缚！"))
			else
				to_chat(living_parent, span_alert("尽管你尽力了，[prey] 还是滑了回去。"))
				to_chat(prey, span_alert("即使有 [living_parent] 帮忙，你还是再次滑回了里面。"))
				to_chat(pred, span_notice(span_green("你的身体利落地将 [prey] 挤回了原位。")))

/datum/component/vore/proc/click_our_prey(mob/living/prey)
	var/obj/vore_belly/prey_loc = prey.loc
	var/mob/living/living_parent = parent

	var/list/options = list("查看")

	if(!HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
		options += list("排出", "转移", "消化", "吸收")
	else
		options += "解除吸收"
		if(living_parent.ckey == our_owner_ckey)
			options += "移交控制权"

	var/what_to_do = tgui_input_list(living_parent, "你想对 [prey] 做什么？", "猎物选项", options)
	// We have to check all of the conditions inside each of these branches because things could have changed while the
	// dialog was open.
	switch(what_to_do)
		if("查看")
			living_parent.examinate(prey)
		if("排出")
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("无法排出已被吸收的猎物。"))
				return
			#ifdef VORE_EJECT_DELAY
			to_chat(living_parent, span_notice("你开始将 [prey] 从自己的[LOWER_TEXT(prey_loc.name)]中挤出去……"))
			to_chat(prey, span_notice("[living_parent] 开始将你从[LOWER_TEXT(prey_loc.name)]中挤出去……"))
			if(!do_after(living_parent, VORE_EJECT_DELAY, interaction_key = "vore_eject"))
				return
			#endif
			prey_loc.release(prey)
		if("转移")
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("无法转移已被吸收的猎物。"))
				return
			var/obj/vore_belly/which_belly = tgui_input_list(living_parent, "你想将猎物转移至哪个腹腔？", "腹腔转移", vore_bellies)
			if(which_belly && prey.loc == prey_loc)
				prey.forceMove(which_belly)
		if("消化")
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("无法消化已被吸收的猎物。"))
				return
			if(!REQUIRES_PLAYER && !prey.mind)
				prey_loc.digestion_death(prey)
				return
			var/datum/vore_preferences/prey_vore_prefs = prey.get_vore_prefs()
			if(!prey_vore_prefs)
				to_chat(living_parent, span_warning("[prey] 不愿被消化。"))
				return
			if(!prey_vore_prefs.read_preference(/datum/vore_pref/toggle/digestion) || !prey_vore_prefs.read_preference(/datum/vore_pref/toggle/digestion_qdel))
				to_chat(living_parent, span_warning("[prey] 不愿被消化。"))
				return

			var/consents = tgui_alert(prey, "[living_parent] 想立刻消化你，你同意吗？", "立即消化", list("否", "是"))
			if(consents == "是")
				if(!prey_loc.digestion_death(prey))
					to_chat(living_parent, span_warning("[prey] 不愿被彻底消化。"))
			else
				to_chat(living_parent, span_warning("[prey] 未在弹窗中表示同意。"))
		if("吸收")
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("[prey] 已被吸收！"))
				return
			if(!prey.vore_can_absorb())
				to_chat(living_parent, "[prey] 不愿被吸收。")
				return
			var/consents = tgui_alert(prey, "[living_parent] 想立刻吸收你，你同意吗？", "立即吸收", list("否", "是"))
			if(consents == "是")
				// Get the nutrition
				var/nutrition = prey.nutrition - ABSORB_NUTRITION_BARRIER
				if(nutrition > 0)
					prey.set_nutrition(ABSORB_NUTRITION_BARRIER)
					living_parent.adjust_nutrition(nutrition)
				if(!prey_loc.absorb(prey))
					to_chat(living_parent, "[prey] 不愿被吸收。")
			else
				to_chat(living_parent, span_warning("[prey] 未在弹窗中表示同意。"))
		if("解除吸收")
			if(!HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("[prey] 并未被吸收！"))
				return
			if(living_parent.nutrition < ABSORB_NUTRITION_BARRIER)
				to_chat(living_parent, span_warning("你太饿了，无法重塑 [prey]。"))
				return
			living_parent.adjust_nutrition(-ABSORB_NUTRITION_BARRIER)
			prey_loc.unabsorb(prey)
		if("移交控制权")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("无法对不属于你的吞食组件执行此操作。"))
				return

			if(!HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("必须先吸收 [prey]，才能移交控制权。"))
				return

			var/consents = tgui_alert(prey, "[living_parent] 想让你控制其身体，你同意吗？", "猎物控制权", list("否", "是"))
			if(consents == "是")
				living_parent.AddComponent(/datum/component/absorb_control, prey)
