/client/proc/cmd_mass_modify_object_variables(datum/target, var_name)
	if(tgui_alert(src, "你确定要批量修改 [var_name] 变量的每一个实例吗？若不清楚自己在做什么，这可能会把一切搞崩。", "慢着，头儿！", list("Yes", "No"), 60 SECONDS) != "Yes")
		return

	if(!check_rights(R_VAREDIT))
		return

	/// if false get only the strict type, get all subtypes too otherwise
	var/strict_type = FALSE
	if(target?.type)
		strict_type = vv_subtype_prompt(target.type)

	massmodify_variables(target, var_name, strict_type)
	BLACKBOX_LOG_ADMIN_VERB("Mass Edit Variables")

/client/proc/massmodify_variables(datum/target, var_name = "", strict_type = FALSE)
	if(!check_rights(R_VAREDIT))
		return
	if(!istype(target))
		return

	var/variable = ""
	if(!var_name)
		var/list/names = list()
		for (var/V in target.vars)
			names += V

		names = sort_list(names)

		variable = input(src, "哪个变量？", "变量") as null|anything in names
	else
		variable = var_name

	if(!variable || !target.can_vv_get(variable))
		return
	var/default
	var/var_value = target.vars[variable]

	if(variable in GLOB.VVckey_edit)
		to_chat(src, "禁止批量修改 ckey，这会让所有人的客户端崩溃，你个笨蛋。", confidential = TRUE)
		return
	if(variable in GLOB.VVlocked)
		if(!check_rights(R_DEBUG))
			return
	if(variable in GLOB.VVicon_edit_lock)
		if(!check_rights(R_FUN|R_DEBUG))
			return
	if(variable in GLOB.VVpixelmovement)
		if(!check_rights(R_DEBUG))
			return
		var/prompt = tgui_alert(src, "修改此变量可能会让本回合余下时间内无法修复地破坏贴图滑动。此操作无法撤销！", "危险", list("ABORT ", "Continue", " ABORT"))
		if (prompt != "Continue")
			return

	default = vv_get_class(variable, var_value)

	if(isnull(default))
		to_chat(src, "无法确定变量类型。", confidential = TRUE)
	else
		to_chat(src, "变量类型似乎为 <b>[uppertext(default)]</b>。", confidential = TRUE)

	to_chat(src, "变量内容：[var_value]", confidential = TRUE)

	if(default == VV_NUM)
		var/dir_text = ""
		if(var_value > 0 && var_value < 16)
			if(var_value & 1)
				dir_text += "北"
			if(var_value & 2)
				dir_text += "南"
			if(var_value & 4)
				dir_text += "东"
			if(var_value & 8)
				dir_text += "西"

		if(dir_text)
			to_chat(src, "如果这是方向值，则方向为：[dir_text]", confidential = TRUE)

	var/value = vv_get_value(default_class = default)
	var/new_value = value["value"]
	var/class = value["class"]

	if(!class || !new_value == null && class != VV_NULL)
		return

	if (class == VV_MESSAGE)
		class = VV_TEXT

	if (value["type"])
		class = VV_NEW_TYPE

	var/original_name = "[target]"

	var/rejected = 0
	var/accepted = 0

	switch(class)
		if(VV_RESTORE_DEFAULT)
			to_chat(src, "正在查找对象……", confidential = TRUE)
			var/list/items = get_all_of_type(target.type, strict_type)
			to_chat(src, "正在修改 [items.len] 个对象……", confidential = TRUE)
			for(var/thing in items)
				if (!thing)
					continue
				var/datum/D = thing
				if (D.vv_edit_var(variable, initial(D.vars[variable])) != FALSE)
					accepted++
				else
					rejected++
				CHECK_TICK

		if(VV_TEXT)
			var/list/varsvars = vv_parse_text(target, new_value)
			var/pre_processing = new_value
			var/unique
			if (varsvars?.len)
				unique = tgui_alert(src, "对每个实例分别处理变量，还是全部使用相同值？", "变量关联", list("Unique", "Same"))
				if(unique == "Unique")
					unique = TRUE
				else
					unique = FALSE
					for(var/V in varsvars)
						new_value = replacetext(new_value,"\[[V]]","[target.vars[V]]")

			to_chat(src, "正在查找对象……", confidential = TRUE)
			var/list/items = get_all_of_type(target.type, strict_type)
			to_chat(src, "正在修改 [items.len] 个对象……", confidential = TRUE)
			for(var/thing in items)
				if (!thing)
					continue
				var/datum/D = thing
				if(unique)
					new_value = pre_processing
					for(var/V in varsvars)
						new_value = replacetext(new_value,"\[[V]]","[D.vars[V]]")

				if (D.vv_edit_var(variable, new_value) != FALSE)
					accepted++
				else
					rejected++
				CHECK_TICK

		if (VV_NEW_TYPE)
			var/many = tgui_alert(src, "只创建一个 [value["type"]] 分配给每个对象，还是为每个对象各创建一个新的？", "数量", list("One", "Many", "Cancel"))
			if (many == "Cancel")
				return
			if (many == "Many")
				many = TRUE
			else
				many = FALSE

			var/type = value["type"]
			to_chat(src, "正在查找对象……", confidential = TRUE)
			var/list/items = get_all_of_type(target.type, strict_type)
			to_chat(src, "正在修改 [items.len] 个对象……", confidential = TRUE)
			for(var/thing in items)
				if (!thing)
					continue
				var/datum/D = thing
				if(many && !new_value)
					new_value = new type()

				if (D.vv_edit_var(variable, new_value) != FALSE)
					accepted++
				else
					rejected++
				new_value = null
				CHECK_TICK

		else
			to_chat(src, "正在查找对象……", confidential = TRUE)
			var/list/items = get_all_of_type(target.type, strict_type)
			to_chat(src, "正在修改 [items.len] 个对象……", confidential = TRUE)
			for(var/thing in items)
				if (!thing)
					continue
				var/datum/D = thing
				if (D.vv_edit_var(variable, new_value) != FALSE)
					accepted++
				else
					rejected++
				CHECK_TICK


	var/count = rejected+accepted
	if (!count)
		to_chat(src, "未找到任何对象", confidential = TRUE)
		return
	if (!accepted)
		to_chat(src, "所有对象都拒绝了你的修改", confidential = TRUE)
		return
	if (rejected)
		to_chat(src, "[count] 个对象中有 [rejected] 个拒绝了你的修改", confidential = TRUE)

	log_world("### MassVarEdit by [src]: [target.type] (A/R [accepted]/[rejected]) [variable]=[html_encode("[target.vars[variable]]")]([list2params(value)])")
	log_admin("[key_name(src)] 批量将 [original_name] 的 [variable] 修改为 [target.vars[variable]]（已修改 [accepted] 个对象）")
	message_admins("[key_name_admin(src)] 批量将 [original_name] 的 [variable] 修改为 [target.vars[variable]]（已修改 [accepted] 个对象）")

//not using global lists as vv is a debug function and debug functions should rely on as less things as possible.
/proc/get_all_of_type(T, subtypes = TRUE)
	var/list/typecache = list()
	typecache[T] = 1
	if (subtypes)
		typecache = typecacheof(typecache)
	. = list()
	if (ispath(T, /mob))
		for(var/mob/thing in world)
			if (typecache[thing.type])
				. += thing
			CHECK_TICK

	else if (ispath(T, /obj/machinery/door))
		for(var/obj/machinery/door/thing in world)
			if (typecache[thing.type])
				. += thing
			CHECK_TICK

	else if (ispath(T, /obj/machinery))
		for(var/obj/machinery/thing in world)
			if (typecache[thing.type])
				. += thing
			CHECK_TICK

	else if (ispath(T, /obj/item))
		for(var/obj/item/thing in world)
			if (typecache[thing.type])
				. += thing
			CHECK_TICK

	else if (ispath(T, /obj))
		for(var/obj/thing in world)
			if (typecache[thing.type])
				. += thing
			CHECK_TICK

	else if (ispath(T, /atom/movable))
		for(var/atom/movable/thing in world)
			if (typecache[thing.type])
				. += thing
			CHECK_TICK

	else if (ispath(T, /turf))
		for(var/turf/thing in world)
			if (typecache[thing.type])
				. += thing
			CHECK_TICK

	else if (ispath(T, /atom))
		for(var/atom/thing in world)
			if (typecache[thing.type])
				. += thing
			CHECK_TICK

	else if (ispath(T, /client))
		for(var/client/thing in GLOB.clients)
			if (typecache[thing.type])
				. += thing
			CHECK_TICK

	else if (ispath(T, /datum))
		for(var/datum/thing)
			if (typecache[thing.type])
				. += thing
			CHECK_TICK

	else
		for(var/datum/thing in world)
			if (typecache[thing.type])
				. += thing
			CHECK_TICK
