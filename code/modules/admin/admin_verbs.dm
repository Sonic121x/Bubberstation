
#define STEALTH_MODE_TRAIT "stealth_mode"

/client/proc/add_admin_verbs()
	control_freak = CONTROL_FREAK_SKIN | CONTROL_FREAK_MACROS
	SSadmin_verbs.assosciate_admin(src)

/client/proc/remove_admin_verbs()
	control_freak = initial(control_freak)
	SSadmin_verbs.deassosciate_admin(src)

ADMIN_VERB(hide_verbs, R_NONE, "管理员指令 - 全部隐藏", "隐藏你的大部分管理员指令。", ADMIN_CATEGORY_MAIN)
	user.remove_admin_verbs()
	ASSIGN_GAME_VERB(user, /client, show_verbs)

	to_chat(user, span_interface("你的几乎所有管理员指令都已隐藏。"), confidential = TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Hide All Adminverbs")

ADMIN_VERB(admin_ghost, R_ADMIN, "管理员幽灵", "变成幽灵，且不会进入 DNR 状态。", ADMIN_CATEGORY_GAME)
	. = TRUE
	if(isobserver(user.mob))
		//re-enter
		var/mob/dead/observer/ghost = user.mob
		if(!ghost.mind || !ghost.mind.current) //won't do anything if there is no body
			return FALSE
		if(!ghost.can_reenter_corpse)
			log_admin("[key_name(user)] 重新进入了尸体")
			message_admins("[key_name_admin(user)] 重新进入了尸体")
		ghost.can_reenter_corpse = 1 //force re-entering even when otherwise not possible
		ghost.reenter_corpse()
		BLACKBOX_LOG_ADMIN_VERB("Admin Reenter")
	else if(isnewplayer(user.mob))
		to_chat(user, span_warning("错误：管理员幽灵：无法在大厅中变成管理员幽灵。请先加入游戏或观察。"), confidential = TRUE)
		return FALSE
	else
		//ghostize
		log_admin("[key_name(user)] 使用管理员幽灵变成了幽灵。")
		message_admins("[key_name_admin(user)] 使用管理员幽灵变成了幽灵。")
		var/mob/body = user.mob
		var/mob/dead/observer/ghost = body.ghostize(TRUE, TRUE)
		user.init_verbs()
		if(body && !body.key)
			body.key = "@[user.key]" //Haaaaaaaack. But the people have spoken. If it breaks; blame adminbus
		// Carry over invisimin to their aghost
		var/is_stealth_mode = user.holder.fakekey
		var/is_invisimin = HAS_TRAIT_FROM(body, TRAIT_INVISIMIN, ADMIN_TRAIT)
		if(is_stealth_mode || is_invisimin)
			if(is_invisimin)
				ADD_TRAIT(ghost, TRAIT_INVISIMIN, ADMIN_TRAIT)
				ghost.SetInvisibility(INVISIBILITY_ADMIN, INVISIBILITY_SOURCE_INVISIMIN, INVISIBILITY_PRIORITY_ADMIN)
			else
				ghost.SetInvisibility(INVISIBILITY_ABSTRACT, INVISIBILITY_SOURCE_STEALTHMODE, INVISIBILITY_PRIORITY_ADMIN)
				ghost.name = " "
				ghost.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
			ghost.alpha = 0
			ghost.remove_from_all_data_huds()
			ADD_TRAIT(ghost, TRAIT_ORBITING_FORBIDDEN, is_invisimin ? ADMIN_TRAIT : STEALTH_MODE_TRAIT)
			QDEL_NULL(ghost.orbiters)

		BLACKBOX_LOG_ADMIN_VERB("Admin Ghost")

ADMIN_VERB(invisimin, R_ADMIN, "隐身模式", "切换类似幽灵的隐身效果。", ADMIN_CATEGORY_GAME)
	// Toggle OFF
	if(HAS_TRAIT(user.mob, TRAIT_INVISIMIN))
		user.mob.remove_traits(list(
				TRAIT_INVISIMIN,
				TRAIT_ORBITING_FORBIDDEN,
				TRAIT_MOVE_PHASING,
				TRAIT_PIERCEIMMUNE,
				TRAIT_INVISIBLE_TO_CAMERA,
			), ADMIN_TRAIT)
		user.mob.add_to_all_human_data_huds()
		user.mob.RemoveInvisibility(INVISIBILITY_SOURCE_INVISIMIN)
		to_chat(user, span_adminnotice(span_bold("隐身模式关闭。隐身状态已重置。")), confidential = TRUE)
		if(isobserver(user.mob) && !user.holder.fakekey) // Set the alpha back if we're not still stealth mode
			user.mob.alpha = initial(user.mob.alpha)
		return

	// Toggle ON
	user.mob.add_traits(list(
			TRAIT_INVISIMIN,
			TRAIT_ORBITING_FORBIDDEN,
			TRAIT_MOVE_PHASING,
			TRAIT_PIERCEIMMUNE,
			TRAIT_INVISIBLE_TO_CAMERA,
		), ADMIN_TRAIT)
	user.mob.remove_from_all_data_huds()
	user.mob.SetInvisibility(INVISIBILITY_ADMIN, INVISIBILITY_SOURCE_INVISIMIN, INVISIBILITY_PRIORITY_ADMIN)
	if(isobserver(user.mob))
		user.mob.alpha = 0
	QDEL_NULL(user.mob.orbiters)
	to_chat(user, span_adminnotice(span_bold("隐身模式开启。你现在对玩家和幽灵都不可见。")), confidential = TRUE)

ADMIN_VERB(toggle_admin_esp, R_ADMIN, "切换管理员 ESP", "切换是否能看到幽灵和隐身者。", ADMIN_CATEGORY_GAME)
	// Toggle OFF
	if(HAS_TRAIT(user.mob, TRAIT_ADMIN_ESP))
		if(isliving(user.mob))
			var/mob/living/living_user = user.mob
			living_user.remove_status_effect(/datum/status_effect/admin_esp)
		else if(isobserver(user.mob))
			user.mob.set_invis_see(SEE_INVISIBLE_OBSERVER)
		else
			user.mob.set_invis_see(SEE_INVISIBLE_LIVING)
		REMOVE_TRAIT(user.mob, TRAIT_ADMIN_ESP, ADMIN_TRAIT)
		to_chat(user.mob, span_adminnotice("管理员 ESP 关闭。你将不再看到[isliving(user.mob) ? "幽灵或 " : ""]隐身者。"), confidential = TRUE)
		return

	// Toggle ON
	if(isliving(user.mob))
		var/mob/living/living_user = user.mob
		living_user.apply_status_effect(/datum/status_effect/admin_esp)
	else if(ismob(user.mob))
		user.mob.set_invis_see(SEE_INVISIBLE_ADMIN)
	else
		to_chat(user.mob, span_warning("管理员 ESP 只有在你处于某个生物体内时才有效！"), confidential = TRUE)
		return

	ADD_TRAIT(user.mob, TRAIT_ADMIN_ESP, ADMIN_TRAIT)
	to_chat(user.mob, span_adminnotice("管理员 ESP 开启。你现在能看到[isliving(user.mob) ? "幽灵和 " : ""]隐身者。"), confidential = TRUE)

ADMIN_VERB(check_antagonists, R_ADMIN, "检查反派", "查看本回合的所有反派。", ADMIN_CATEGORY_GAME)
	user.holder.check_antagonists()
	log_admin("[key_name(user)] 检查了反派。")
	if(!isobserver(user.mob) && SSticker.HasRoundStarted())
		message_admins("[key_name_admin(user)] 检查了反派。")
	BLACKBOX_LOG_ADMIN_VERB("Check Antagonists")

ADMIN_VERB(list_bombers, R_ADMIN, "列出炸弹制造者", "查看所有炸弹及其可能的凶手。", ADMIN_CATEGORY_GAME)
	user.holder.list_bombers()
	BLACKBOX_LOG_ADMIN_VERB("List Bombers")

ADMIN_VERB(list_signalers, R_ADMIN, "列出信号器", "查看所有信号器。", ADMIN_CATEGORY_GAME)
	user.holder.list_signalers()
	BLACKBOX_LOG_ADMIN_VERB("List Signalers")

ADMIN_VERB(list_law_changes, R_ADMIN, "列出法则变更", "查看所有 AI 法则变更。", ADMIN_CATEGORY_DEBUG)
	user.holder.list_law_changes()
	BLACKBOX_LOG_ADMIN_VERB("List Law Changes")

ADMIN_VERB(show_manifest, R_ADMIN, "显示船员名册", "查看本班次的船员名册。", ADMIN_CATEGORY_DEBUG)
	user.holder.show_manifest()
	BLACKBOX_LOG_ADMIN_VERB("Show Manifest")

ADMIN_VERB(list_dna, R_ADMIN, "列出 DNA", "查看 DNA。", ADMIN_CATEGORY_DEBUG)
	user.holder.list_dna()
	BLACKBOX_LOG_ADMIN_VERB("List DNA")

ADMIN_VERB(list_fingerprints, R_ADMIN, "列出指纹", "查看指纹。", ADMIN_CATEGORY_DEBUG)
	user.holder.list_fingerprints()
	BLACKBOX_LOG_ADMIN_VERB("List Fingerprints")

ADMIN_VERB(ban_panel, R_BAN, "封禁面板", "在此封禁玩家。", ADMIN_CATEGORY_MAIN)
	user.holder.ban_panel()
	BLACKBOX_LOG_ADMIN_VERB("Banning Panel")

ADMIN_VERB(unban_panel, R_BAN, "解封面板", "在此解封玩家。", ADMIN_CATEGORY_MAIN)
	user.holder.unban_panel()
	BLACKBOX_LOG_ADMIN_VERB("Unbanning Panel")

ADMIN_VERB(game_panel, R_ADMIN, "游戏面板", "查看游戏状态。", ADMIN_CATEGORY_GAME)
	user.holder.Game()
	BLACKBOX_LOG_ADMIN_VERB("Game Panel")

ADMIN_VERB(poll_panel, R_POLL, "服务器投票管理", "查看并管理投票。", ADMIN_CATEGORY_MAIN)
	user.holder.poll_list_panel()
	BLACKBOX_LOG_ADMIN_VERB("Server Poll Management")

/// Returns this client's stealthed ckey
/client/proc/getStealthKey()
	return GLOB.stealthminID[ckey]

/// Takes a stealthed ckey as input, returns the true key it represents
/proc/findTrueKey(stealth_key)
	if(!stealth_key)
		return
	for(var/potentialKey in GLOB.stealthminID)
		if(GLOB.stealthminID[potentialKey] == stealth_key)
			return potentialKey

/// Hands back a stealth ckey to use, guarenteed to be unique
/proc/generateStealthCkey()
	var/guess = rand(0, 1000)
	var/text_guess
	var/valid_found = FALSE
	while(valid_found == FALSE)
		valid_found = TRUE
		text_guess = "@[num2text(guess)]"
		// We take a guess at some number, and if it's not in the existing stealthmin list we exit
		for(var/key in GLOB.stealthminID)
			// If it is in the list tho, we up one number, and redo the loop
			if(GLOB.stealthminID[key] == text_guess)
				guess += 1
				valid_found = FALSE
				break

	return text_guess

/client/proc/createStealthKey()
	GLOB.stealthminID["[ckey]"] = generateStealthCkey()

ADMIN_VERB(stealth, R_STEALTH, "潜行模式", "切换潜行。", ADMIN_CATEGORY_MAIN)
	if(user.holder.fakekey)
		user.disable_stealth_mode()
	else
		user.enable_stealth_mode()

	BLACKBOX_LOG_ADMIN_VERB("Stealth Mode")

/client/proc/enable_stealth_mode()
	var/new_key = ckeyEx(stripped_input(usr, "输入你想要的显示名称。", "伪装密钥", key, 26))
	if(!new_key)
		return
	holder.fakekey = new_key
	createStealthKey()
	if(isobserver(mob))
		mob.SetInvisibility(INVISIBILITY_ABSTRACT, INVISIBILITY_SOURCE_STEALTHMODE, INVISIBILITY_PRIORITY_ADMIN)
		mob.alpha = 0 //JUUUUST IN CASE
		mob.name = " "
		mob.mouse_opacity = MOUSE_OPACITY_TRANSPARENT

	ADD_TRAIT(mob, TRAIT_ORBITING_FORBIDDEN, STEALTH_MODE_TRAIT)
	QDEL_NULL(mob.orbiters)

	log_admin("[key_name(usr)] 开启了潜行模式")
	message_admins("[key_name_admin(usr)] 开启了潜行模式")

/client/proc/disable_stealth_mode()
	holder.fakekey = null
	if(isobserver(mob))
		mob.RemoveInvisibility(INVISIBILITY_SOURCE_STEALTHMODE)
		if(!HAS_TRAIT_FROM(mob, TRAIT_INVISIMIN, ADMIN_TRAIT)) // Don't reset our alpha if we're also invisimin'd
			mob.alpha = initial(mob.alpha)
		if(mob.mind)
			if(mob.mind.ghostname)
				mob.name = mob.mind.ghostname
			else
				mob.name = mob.mind.name
		else
			mob.name = mob.real_name
		mob.mouse_opacity = initial(mob.mouse_opacity)

	REMOVE_TRAIT(mob, TRAIT_ORBITING_FORBIDDEN, STEALTH_MODE_TRAIT)

	log_admin("[key_name(usr)] 关闭了潜行模式")
	message_admins("[key_name_admin(usr)] 关闭了潜行模式")

ADMIN_VERB(drop_bomb, R_FUN, "投放炸弹", "在你所在位置引发一场威力可调的爆炸", ADMIN_CATEGORY_FUN)
	var/list/choices = list("Small Bomb (1, 2, 3, 3)", "Medium Bomb (2, 3, 4, 4)", "Big Bomb (3, 5, 7, 5)", "Maxcap", "Custom Bomb")
	var/choice = tgui_input_list(user, "你想制造多大的爆炸？注意：你可以用“配置/发射补给舱”指令以符合角色的方式（使用巡航导弹！）快速完成这一切。警告：这些爆炸会无视最大上限", "投放炸弹", choices)
	if(isnull(choice))
		return
	var/turf/epicenter = user.mob.loc

	switch(choice)
		if("Small Bomb (1, 2, 3, 3)")
			explosion(epicenter, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 3, flash_range = 3, adminlog = TRUE, ignorecap = TRUE, explosion_cause = user.mob)
		if("Medium Bomb (2, 3, 4, 4)")
			explosion(epicenter, devastation_range = 2, heavy_impact_range = 3, light_impact_range = 4, flash_range = 4, adminlog = TRUE, ignorecap = TRUE, explosion_cause = user.mob)
		if("Big Bomb (3, 5, 7, 5)")
			explosion(epicenter, devastation_range = 3, heavy_impact_range = 5, light_impact_range = 7, flash_range = 5, adminlog = TRUE, ignorecap = TRUE, explosion_cause = user.mob)
		if("Maxcap")
			explosion(epicenter, devastation_range = GLOB.MAX_EX_DEVESTATION_RANGE, heavy_impact_range = GLOB.MAX_EX_HEAVY_RANGE, light_impact_range = GLOB.MAX_EX_LIGHT_RANGE, flash_range = GLOB.MAX_EX_FLASH_RANGE, adminlog = TRUE, ignorecap = TRUE, explosion_cause = user.mob)
		if("Custom Bomb")
			var/range_devastation = input(user, "毁灭范围（以格为单位）：") as null|num
			if(range_devastation == null)
				return
			var/range_heavy = input(user, "重度冲击范围（以格为单位）：") as null|num
			if(range_heavy == null)
				return
			var/range_light = input(user, "轻度冲击范围（以格为单位）：") as null|num
			if(range_light == null)
				return
			var/range_flash = input(user, "闪光范围（以格为单位）：") as null|num
			if(range_flash == null)
				return
			if(range_devastation > GLOB.MAX_EX_DEVESTATION_RANGE || range_heavy > GLOB.MAX_EX_HEAVY_RANGE || range_light > GLOB.MAX_EX_LIGHT_RANGE || range_flash > GLOB.MAX_EX_FLASH_RANGE)
				if(tgui_alert(user, "炸弹超过了最大上限。是否继续？",,list("Yes","No")) != "Yes")
					return
			epicenter = get_turf(user.mob) //We need to reupdate as they may have moved again
			explosion(epicenter, devastation_range = range_devastation, heavy_impact_range = range_heavy, light_impact_range = range_light, flash_range = range_flash, adminlog = TRUE, ignorecap = TRUE, explosion_cause = user.mob)
	message_admins("[ADMIN_LOOKUPFLW(user.mob)] 在 [epicenter.loc] 制造了一场管理员爆炸。")
	log_admin("[key_name(user)] 在 [epicenter.loc] 制造了一场管理员爆炸。")
	BLACKBOX_LOG_ADMIN_VERB("Drop Bomb")

ADMIN_VERB(drop_bomb_dynex, R_FUN, "投放动态爆炸炸弹", "在你所在位置引发一场威力可调的爆炸。", ADMIN_CATEGORY_FUN)
	var/ex_power = input(user, "爆炸威力：") as null|num
	var/turf/epicenter = get_turf(user.mob)
	if(!ex_power || !epicenter)
		return
	dyn_explosion(epicenter, ex_power)
	message_admins("[ADMIN_LOOKUPFLW(user.mob)] 在 [epicenter.loc] 制造了一场管理员爆炸。")
	log_admin("[key_name(user)] 在 [epicenter.loc] 制造了一场管理员爆炸。")
	BLACKBOX_LOG_ADMIN_VERB("Drop Dynamic Bomb")

ADMIN_VERB(get_dynex_range, R_FUN, "获取动态爆炸范围", "根据爆炸威力估算炸弹的范围。", ADMIN_CATEGORY_DEBUG)
	var/ex_power = input(user, "爆炸威力：") as null|num
	if (isnull(ex_power))
		return
	var/range = round((2 * ex_power)**GLOB.DYN_EX_SCALE)
	to_chat(user, "预估爆炸范围：（毁灭：[round(range*0.25)]，重度：[round(range*0.5)]，轻度：[round(range)]）", confidential = TRUE)

ADMIN_VERB(get_dynex_power, R_FUN, "获取动态爆炸威力", "估算炸弹达到指定范围所需的威力。", ADMIN_CATEGORY_DEBUG)
	var/ex_range = input(user, "轻度爆炸范围：") as null|num
	if (isnull(ex_range))
		return
	var/power = (0.5 * ex_range)**(1/GLOB.DYN_EX_SCALE)
	to_chat(user, "预估爆炸威力：[power]", confidential = TRUE)

ADMIN_VERB(set_dynex_scale, R_FUN, "设置动态爆炸系数", "设置动态爆炸的缩放系数。默认 0.5。", ADMIN_CATEGORY_DEBUG)
	var/ex_scale = input(user, "新的动态爆炸系数：") as null|num
	if(!ex_scale)
		return
	GLOB.DYN_EX_SCALE = ex_scale
	log_admin("[key_name(user)] 修改了动态爆炸系数：[ex_scale]")
	message_admins("[key_name_admin(user)] 修改了动态爆炸系数：[ex_scale]")

ADMIN_VERB(atmos_control, R_DEBUG|R_SERVER, "大气控制面板", "打开大气控制面板。", ADMIN_CATEGORY_DEBUG)
	SSair.ui_interact(user.mob)

ADMIN_VERB(reload_cards, R_DEBUG, "重新加载卡牌", "重新加载所有 TCG 卡牌。", ADMIN_CATEGORY_DEBUG)
	if(!SStrading_card_game.loaded)
		message_admins("卡牌子系统当前未加载")
		return
	SStrading_card_game.reloadAllCardFiles()

ADMIN_VERB(validate_cards, R_DEBUG, "校验卡牌", "校验卡牌设置。", ADMIN_CATEGORY_DEBUG)
	if(!SStrading_card_game.loaded)
		message_admins("卡牌子系统当前未加载")
		return
	var/message = SStrading_card_game.check_cardpacks(SStrading_card_game.card_packs)
	message += SStrading_card_game.check_card_datums()
	if(message)
		message_admins(message)
	else
		message_admins("未发现卡牌稀有度或覆盖项中的错误。")

ADMIN_VERB(test_cardpack_distribution, R_DEBUG, "测试卡包分布", "测试某个卡包的分布。", ADMIN_CATEGORY_DEBUG)
	if(!SStrading_card_game.loaded)
		message_admins("卡牌子系统当前未加载")
		return
	var/pack = tgui_input_list(user, "我们要测试哪个卡包？", "你搞砸了，对吧", sort_list(SStrading_card_game.card_packs))
	if(!pack)
		return
	var/batch_count = tgui_input_number(user, "我们要打开它多少次？", "别担心，我理解")
	var/batch_size = tgui_input_number(user, "每批多少张卡？", "希望你还记得检查校验结果")
	var/guar = tgui_input_number(user, "是否使用卡包的保底稀有度？如果使用，用几张？", "我们都经历过。老兄，你真该看看以前的系统")
	SStrading_card_game.check_card_distribution(pack, batch_size, batch_count, guar)

ADMIN_VERB(print_cards, R_DEBUG, "打印卡牌", "将所有卡牌打印到聊天栏。", ADMIN_CATEGORY_DEBUG)
	SStrading_card_game.printAllCards()

ADMIN_VERB(give_mob_action, R_FUN, "赋予生物技能", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(ability_recipient, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	var/static/list/all_mob_actions = sort_list(subtypesof(/datum/action/cooldown/mob_cooldown), GLOBAL_PROC_REF(cmp_typepaths_asc))
	var/static/list/actions_by_name = list()
	if (!length(actions_by_name))
		for (var/datum/action/cooldown/mob_cooldown as anything in all_mob_actions)
			actions_by_name["[initial(mob_cooldown.name)] ([mob_cooldown])"] = mob_cooldown

	var/ability = tgui_input_list(user, "选择一项技能", "技能", actions_by_name)
	if(isnull(ability))
		return

	var/ability_type = actions_by_name[ability]
	var/datum/action/cooldown/mob_cooldown/add_ability

	var/make_sequence = tgui_alert(user, "你希望该技能是一组多项技能的连招吗？", "连招技能", list("Yes", "No"))
	if(make_sequence == "Yes")
		add_ability = new /datum/action/cooldown/mob_cooldown(ability_recipient)
		add_ability.sequence_actions = list()
		while(!isnull(ability_type))
			var/ability_delay = tgui_input_number(user, "输入连招中下一项技能使用前的延迟秒数", "技能延迟", 2)
			if(isnull(ability_delay) || ability_delay < 0)
				ability_delay = 0
			add_ability.sequence_actions[ability_type] = ability_delay * 1 SECONDS
			ability = tgui_input_list(user, "选择新的连招技能", "连招技能", actions_by_name)
			ability_type = actions_by_name[ability]
		var/ability_cooldown = tgui_input_number(user, "输入连招技能的冷却时间（秒）", "技能冷却", 2)
		if(isnull(ability_cooldown) || ability_cooldown < 0)
			ability_cooldown = 2
		add_ability.cooldown_time = ability_cooldown * 1 SECONDS
		var/ability_melee_cooldown = tgui_input_number(user, "输入技能的近战冷却时间（秒）", "近战冷却", 2)
		if(isnull(ability_melee_cooldown) || ability_melee_cooldown < 0)
			ability_melee_cooldown = 2
		add_ability.melee_cooldown_time = ability_melee_cooldown * 1 SECONDS
		add_ability.name = tgui_input_text(user, "输入技能名称", "技能名称", "通用技能", max_length = MAX_NAME_LEN)
		add_ability.create_sequence_actions()
	else
		add_ability = new ability_type(ability_recipient)

	if(isnull(ability_recipient))
		return
	add_ability.Grant(ability_recipient)

	message_admins("[key_name_admin(user)] 给生物 [ability_recipient] 添加了生物技能 [ability_type]。")
	log_admin("[key_name(user)] 给生物 [ability_recipient] 添加了生物技能 [ability_type]。")
	BLACKBOX_LOG_ADMIN_VERB("Add Mob Ability")

ADMIN_VERB(remove_mob_action, R_FUN, "移除生物技能", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(removal_target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	var/list/target_abilities = list()
	for(var/datum/action/cooldown/mob_cooldown/ability in removal_target.actions)
		target_abilities[ability.name] = ability

	if(!length(target_abilities))
		return

	var/chosen_ability = tgui_input_list(user, "选择要从 [removal_target] 移除的技能", "移除力量", sort_list(target_abilities))
	if(isnull(chosen_ability))
		return
	var/datum/action/cooldown/mob_cooldown/to_remove = target_abilities[chosen_ability]
	if(!istype(to_remove))
		return

	qdel(to_remove)
	log_admin("[key_name(user)] 从 [key_name(removal_target)] 移除了技能 [chosen_ability]。")
	message_admins("[key_name_admin(user)] 从 [key_name_admin(removal_target)] 移除了技能 [chosen_ability]。")
	BLACKBOX_LOG_ADMIN_VERB("Remove Mob Ability")

ADMIN_VERB(give_spell, R_FUN, "赋予法术", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(spell_recipient, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	var/which = tgui_alert(user, "按名称选择还是按类型路径选择？", "选择方式", list("Name", "Typepath"))
	if(!which)
		return
	if(QDELETED(spell_recipient))
		to_chat(user, span_warning("目标法术接收者已不存在。"))
		return

	var/list/spell_list = list()
	for(var/datum/action/cooldown/spell/to_add as anything in subtypesof(/datum/action/cooldown/spell))
		var/spell_name = initial(to_add.name)
		if(spell_name == "Spell") // abstract or un-named spells should be skipped.
			continue

		if(which == "Name")
			spell_list[spell_name] = to_add
		else
			spell_list += to_add

	var/chosen_spell = tgui_input_list(user, "选择要赋予 [spell_recipient] 的法术", "阿布拉卡达布拉", sort_list(spell_list))
	if(isnull(chosen_spell))
		return
	var/datum/action/cooldown/spell/spell_path = which == "Typepath" ? chosen_spell : spell_list[chosen_spell]
	if(!ispath(spell_path))
		return

	var/robeless = (tgui_alert(user, "你希望强制该法术无需法袍即可施放吗？", "无袍施法？", list("Force Robeless", "Use Spell Setting")) == "Force Robeless")

	if(QDELETED(spell_recipient))
		to_chat(user, span_warning("目标法术接收者已不存在。"))
		return

	BLACKBOX_LOG_ADMIN_VERB("Give Spell")
	log_admin("[key_name(user)] 赋予 [key_name(spell_recipient)] 法术 [chosen_spell][robeless ? "（强制无袍）" : ""]。")
	message_admins("[key_name_admin(user)] 赋予 [key_name_admin(spell_recipient)] 法术 [chosen_spell][robeless ? "（强制无袍）" : ""]。")

	var/datum/action/cooldown/spell/new_spell = new spell_path(spell_recipient.mind || spell_recipient)

	if(robeless)
		new_spell.spell_requirements &= ~SPELL_REQUIRES_WIZARD_GARB

	new_spell.Grant(spell_recipient)

	if(!spell_recipient.mind)
		to_chat(user, span_userdanger("赋予无意识生物的法术将归属于该生物本身而非其意识，\
			因此当其意识更换身体（例如心灵互换）时不会随之转移。"))

ADMIN_VERB(remove_spell, R_FUN, "移除法术", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(removal_target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	var/list/target_spell_list = list()
	for(var/datum/action/cooldown/spell/spell in removal_target.actions)
		target_spell_list[spell.name] = spell

	if(!length(target_spell_list))
		return

	var/chosen_spell = tgui_input_list(user, "选择要从 [removal_target] 移除的法术", "阿布拉卡达布拉", sort_list(target_spell_list))
	if(isnull(chosen_spell))
		return
	var/datum/action/cooldown/spell/to_remove = target_spell_list[chosen_spell]
	if(!istype(to_remove))
		return

	qdel(to_remove)
	log_admin("[key_name(user)] 从 [key_name(removal_target)] 移除了法术 [chosen_spell]。")
	message_admins("[key_name_admin(user)] 从 [key_name_admin(removal_target)] 移除了法术 [chosen_spell]。")
	BLACKBOX_LOG_ADMIN_VERB("Remove Spell")

ADMIN_VERB(give_disease, R_FUN, "赋予疾病", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(victim, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob/living)
	var/datum/disease/disease = tgui_input_list(user, "选择要赋予那个家伙的疾病", "阿嚏", sort_list(SSdisease.diseases, GLOBAL_PROC_REF(cmp_typepaths_asc)))
	if(!disease)
		return
	victim.ForceContractDisease(new disease, FALSE, TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Give Disease")
	log_admin("[key_name(user)] 使 [key_name(victim)] 感染了疾病 [disease]。")
	message_admins(span_adminnotice("[key_name_admin(user)] 使 [key_name_admin(victim)] 感染了疾病 [disease]。"))

ADMIN_VERB_AND_CONTEXT_MENU(object_say, R_FUN, "物件发言", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN, /obj)
	VERB_ARG_TYPED(speaker, VERB_ARG_TYPE_OBJ, VERB_ARG_SOURCE_WORLD, /obj)
	var/message = tgui_input_text(user, "你想让消息内容是什么？", "发出声音", encode = FALSE)
	if(!message)
		return
	speaker.say(message, sanitize = FALSE)
	log_admin("[key_name(user)] 让位于 [AREACOORD(speaker)] 的 [speaker] 说出“[message]”")
	message_admins(span_adminnotice("[key_name_admin(user)] 让位于 [AREACOORD(speaker)] 的 [speaker] 说出“[message]”"))
	BLACKBOX_LOG_ADMIN_VERB("Object Say")

ADMIN_VERB(build_mode_self, R_BUILD, "切换自身建造模式", "切换你自己的建造模式。", ADMIN_CATEGORY_EVENTS)
	togglebuildmode(user.mob) // why is this a global proc???
	BLACKBOX_LOG_ADMIN_VERB("Toggle Build Mode")

ADMIN_VERB(check_ai_laws, R_ADMIN, "检查 AI 法则", "查看当前 AI 法则。", ADMIN_CATEGORY_GAME)
	user.holder.output_ai_laws()

ADMIN_VERB(manage_sect, R_ADMIN, "管理宗教派别", "管理牧师的宗教。", ADMIN_CATEGORY_GAME)
	if (!isnull(GLOB.religious_sect))
		var/you_sure = tgui_alert(
			user,
			"牧师已经选择了[GLOB.religious_sect.name]，要覆盖其选择吗？",
			"替换神明？",
			list("Yes", "Cancel"),
		)
		if (you_sure != "Yes")
			return

	var/static/list/choices = list()
	if (!length(choices))
		choices["nothing"] = null
		for(var/datum/religion_sect/sect as anything in subtypesof(/datum/religion_sect))
			choices[initial(sect.name)] = sect
	var/choice = tgui_input_list(user, "设置新的牧师派别", "神明选择器", choices)
	if(isnull(choice))
		return
	if(choice == "nothing")
		reset_religious_sect()
		return
	set_new_religious_sect(choices[choice], reset_existing = TRUE)

ADMIN_VERB(deadmin, R_NONE, "取消管理员", "卸下你的管理员权限。", ADMIN_CATEGORY_MAIN)
	user.holder.deactivate()
	to_chat(user, span_interface("你现在是一名普通玩家。"))
	log_admin("[key_name(user)] 取消了自己的管理员身份。")
	message_admins("[key_name_admin(user)] 取消了自己的管理员身份。")
	BLACKBOX_LOG_ADMIN_VERB("Deadmin")

ADMIN_VERB(populate_world, R_DEBUG, "填充世界", "用测试生物填充世界。", ADMIN_CATEGORY_DEBUG)
	VERB_ARG(amount, VERB_ARG_TYPE_NUM, VERB_ARG_SOURCE_INPUT)
	for (var/i in 1 to amount)
		var/turf/tile = get_safe_random_station_turf_equal_weight()
		var/mob/living/carbon/human/hooman = new(tile)
		hooman.equipOutfit(pick(subtypesof(/datum/outfit)))
		testing("Spawned test mob at [get_area_name(tile, TRUE)] ([tile.x],[tile.y],[tile.z])")

ADMIN_VERB(toggle_ai_interact, R_ADMIN, "切换管理员 AI 交互", "允许你以幽灵身份像 AI 一样与大多数机器交互。", ADMIN_CATEGORY_GAME)
	var/doesnt_have_silicon_access = !HAS_TRAIT_FROM(user, TRAIT_AI_ACCESS, ADMIN_TRAIT)
	if(doesnt_have_silicon_access)
		ADD_TRAIT(user, TRAIT_AI_ACCESS, ADMIN_TRAIT)
	else
		REMOVE_TRAIT(user, TRAIT_AI_ACCESS, ADMIN_TRAIT)

	log_admin("[key_name(user)] [doesnt_have_silicon_access ? "开启" : "关闭"]了管理员 AI 交互")
	message_admins("[key_name_admin(user)] [doesnt_have_silicon_access ? "开启" : "关闭"]了其 AI 交互")

ADMIN_VERB(debug_statpanel, R_DEBUG, "调试状态面板", "切换状态面板的本地调试。", ADMIN_CATEGORY_DEBUG)
	user.stat_panel.send_message("create_debug")

ADMIN_VERB(display_sendmaps, R_DEBUG, "发送地图性能分析", "查看性能分析。", ADMIN_CATEGORY_DEBUG)
	user << link("?debug=profile&type=sendmaps&window=test")

ADMIN_VERB(spawn_debug_full_crew, R_DEBUG, "生成调试用完整船员", "为空间站生成一整套船员，填充数据核心并分配意识与职业。", ADMIN_CATEGORY_DEBUG)
	if(SSticker.current_state != GAME_STATE_PLAYING)
		to_chat(user, "你只应在回合已设置并开始后使用此功能。")
		return

	// Two input checks here to make sure people are certain when they're using this.
	if(tgui_alert(user, "此命令会创建一批假船员，带有意识、职业和数据核心记录，这需要一些时间并会填满船员名册。", "生成船员", list("Yes", "Cancel")) != "Yes")
		return

	if(!user.is_localhost() && tgui_alert(user, "你不在本机上！确定要继续吗？", "生成船员（请确认）", list("Yes", "Cancel")) != "Yes")
		return

	// Find the observer spawn, so we have a place to dump the dummies.
	var/obj/effect/landmark/observer_start/observer_point = locate(/obj/effect/landmark/observer_start) in GLOB.landmarks_list
	var/turf/destination = get_turf(observer_point)
	if(!destination)
		to_chat(user, "找不到观察者出生点，无法安置这些假人。")
		return

	// Okay, now go through all nameable occupations.
	// Pick out all jobs that have JOB_CREW_MEMBER set.
	// Then, spawn a human and slap a person into it.
	var/number_made = 0
	for(var/rank in SSjob.name_occupations)
		var/datum/job/job = SSjob.get_job(rank)

		// JOB_CREW_MEMBER is all jobs that pretty much aren't silicon
		if(!(job.job_flags & JOB_CREW_MEMBER))
			continue

		// Create our new_player for this job and set up its mind.
		var/mob/dead/new_player/new_guy = new()
		new_guy.mind_initialize()
		new_guy.mind.name = "[rank] 假人"

		// Assign the rank to the new player dummy.
		if(!SSjob.assign_role(new_guy, job, do_eligibility_checks = FALSE))
			qdel(new_guy)
			to_chat(user, "[rank] 无法生成。")
			continue

		// It's got a job, spawn in a human and shove it in the human.
		var/mob/living/carbon/human/character = new(destination)
		character.name = new_guy.mind.name
		new_guy.mind.transfer_to(character)
		qdel(new_guy)

		// Then equip up the human with job gear.
		SSjob.equip_rank(character, job)
		job.after_latejoin_spawn(character)

		// Finally, ensure the minds are tracked and in the manifest.
		SSticker.minds += character.mind
		if(ishuman(character))
			GLOB.manifest.inject(character)

		number_made++
		CHECK_TICK

	to_chat(user, "已创建 [number_made] 名船员。")

ADMIN_VERB(debug_spell_requirements, R_DEBUG, "调试法术需求", "查看所有法术及其需求。", ADMIN_CATEGORY_DEBUG)
	var/header = "<tr><th>名称</th> <th>需求</th>"
	var/all_requirements = list()
	for(var/datum/action/cooldown/spell/spell as anything in typesof(/datum/action/cooldown/spell))
		if(initial(spell.name) == "Spell")
			continue

		var/list/real_reqs = list()
		var/reqs = initial(spell.spell_requirements)
		if(reqs & SPELL_CASTABLE_AS_BRAIN)
			real_reqs += "可作为大脑施放"
		if(reqs & SPELL_REQUIRES_HUMAN)
			real_reqs += "必须是人类"
		if(reqs & SPELL_REQUIRES_MIME_VOW)
			real_reqs += "必须处于默剧状态"
		if(reqs & SPELL_REQUIRES_MIND)
			real_reqs += "必须有意识"
		if(reqs & SPELL_REQUIRES_NO_ANTIMAGIC)
			real_reqs += "必须没有反魔法"
		if(reqs & SPELL_REQUIRES_STATION)
			real_reqs += "必须位于空间站所在 Z 层"
		if(reqs & SPELL_REQUIRES_WIZARD_GARB)
			real_reqs += "必须穿着巫师衣物"

		all_requirements += "<tr><td>[initial(spell.name)]</td> <td>[english_list(real_reqs, "无需求")]</td></tr>"

	var/page_style = "<style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style>"
	var/page_contents = "[page_style]<table style=\"width:100%\">[header][jointext(all_requirements, "")]</table>"
	var/datum/browser/popup = new(user.mob, "spellreqs", "法术需求", 600, 400)
	popup.set_content(page_contents)
	popup.open()

ADMIN_VERB(load_lazy_template, R_ADMIN, "加载/跳转懒加载模板", "加载懒加载模板和/或跳转到该模板。", ADMIN_CATEGORY_EVENTS)
	var/list/choices = LAZY_TEMPLATE_KEY_LIST_ALL()
	var/choice = tgui_input_list(user, "密钥？", "懒加载器", choices)
	var/teleport_to_template = tgui_input_list(user, "加载后跳转到模板？", "去哪里？", list("Yes", "No"))
	if(!choice)
		return

	choice = choices[choice]
	if(!choice)
		to_chat(user, span_warning("找不到该密钥对应的模板，请上报此问题！"))
		return

	var/already_loaded = LAZYACCESS(SSmapping.loaded_lazy_templates, choice)
	var/force_load = FALSE
	if(already_loaded && (tgui_alert(user, "模板已加载。", "", list("Jump", "Load Again")) == "Load Again"))
		force_load = TRUE

	var/datum/turf_reservation/reservation = SSmapping.lazy_load_template(choice, force = force_load)
	if(!reservation)
		to_chat(user, span_boldwarning("加载模板失败！"))
		return

	if(teleport_to_template == "Yes")
		if(!isobserver(user.mob))
			SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/admin_ghost)
		user.mob.forceMove(reservation.bottom_left_turfs[1])
		to_chat(user, span_boldnicegreen("模板已加载，你已被移动到预留区域的左下角。"))

	message_admins("[key_name_admin(user)] 加载了懒加载模板“[choice]”")

ADMIN_VERB(library_control, R_BAN, "图书馆管理", "列出并管理图书馆。", ADMIN_CATEGORY_MAIN)
	if(!user.holder.library_manager)
		user.holder.library_manager = new
	user.holder.library_manager.ui_interact(user.mob)
	BLACKBOX_LOG_ADMIN_VERB("Library Management")

ADMIN_VERB(create_mob_worm, R_FUN, "创建生物链条", "将一个链式生物列表附着到你标记的生物上。", ADMIN_CATEGORY_FUN)
	if(!isliving(user.holder.marked_datum))
		to_chat(user, span_warning("错误：请先标记一个要附着生物的目标生物。"))
		return
	var/mob/living/head = user.holder.marked_datum

	var/attempted_target_path = tgui_input_text(
		user,
		"输入你想作为链条起点的生物类型路径。",
		"类型路径",
		"[/mob/living/basic/pet/dog/corgi/ian]",
	)

	if (isnull(attempted_target_path))
		return //The user pressed "Cancel"

	var/desired_mob = text2path(attempted_target_path)
	if(!ispath(desired_mob))
		desired_mob = pick_closest_path(attempted_target_path, make_types_fancy(subtypesof(/mob/living)))
	if(isnull(desired_mob) || !ispath(desired_mob) || QDELETED(head))
		return //The user pressed "Cancel"

	var/amount = tgui_input_number(user, "我们的尾巴要多长？", "链虫配置器", default = 3, min_value = 1)
	if (isnull(amount) || amount < 1 || QDELETED(head))
		return
	head.AddComponent(/datum/component/mob_chain)
	var/mob/living/previous = head
	for (var/i in 1 to amount)
		var/mob/living/segment = new desired_mob(head.drop_location())
		if (QDELETED(segment)) // ffs mobs which replace themselves with other mobs
			i--
			continue
		ADD_TRAIT(segment, TRAIT_PERMANENTLY_MORTAL, INNATE_TRAIT)
		QDEL_NULL(segment.ai_controller)
		segment.AddComponent(/datum/component/mob_chain, front = previous)
		previous = segment

ADMIN_VERB(give_ai_controller, R_FUN, "赋予 AI 控制器", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(my_guy, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob/living)
	var/static/list/controllers = subtypesof(/datum/admin_ai_template)
	var/static/list/controllers_by_name = list()
	if (!length(controllers_by_name))
		for (var/datum/admin_ai_template/template as anything in controllers)
			controllers_by_name["[initial(template.name)]"] = template

	var/chosen = tgui_input_list(user, "我们要应用哪个模板？", "选择模板", controllers_by_name)
	if (isnull(chosen))
		return

	var/chosen_type = controllers_by_name[chosen]
	var/datum/admin_ai_template/using_template = new chosen_type
	using_template.apply(my_guy, user)

ADMIN_VERB(clear_legacy_asset_cache, R_DEBUG, "清除旧版资源缓存", "清除旧版资源缓存，并立即重新生成（可能造成卡顿）。", ADMIN_CATEGORY_DEBUG)
	if(!CONFIG_GET(flag/cache_assets))
		to_chat(user, span_warning("配置中已禁用资源缓存！"))
		return
	var/regenerated = 0
	for(var/datum/asset/target_spritesheet as anything in valid_subtypesof(/datum/asset))
		if(!initial(target_spritesheet.cross_round_cachable))
			continue
		var/datum/asset/asset_datum = GLOB.asset_datums[target_spritesheet]
		asset_datum.regenerate()
		regenerated++
	to_chat(user, span_notice("已重新生成 [regenerated] 项资源。"))

ADMIN_VERB(clear_smart_asset_cache, R_DEBUG, "清除智能资源缓存", "清除智能资源缓存，使其在下一回合重新生成。", ADMIN_CATEGORY_DEBUG)
	if(!CONFIG_GET(flag/smart_cache_assets))
		to_chat(user, span_warning("配置中已禁用智能资源缓存！"))
		return
	var/cleared = 0
	for(var/datum/asset/spritesheet_batched/target_spritesheet as anything in valid_subtypesof(/datum/asset/spritesheet_batched))
		fdel("[ASSET_CROSS_ROUND_SMART_CACHE_DIRECTORY]/spritesheet_cache.[initial(target_spritesheet.name)].json")
		cleared++
	to_chat(user, span_notice("已清除 [cleared] 项资源。"))

ADMIN_VERB(open_event_logger, R_DEBUG, "打开事件记录器", "打开事件记录器界面。", ADMIN_CATEGORY_DEBUG)
	GLOB.event_logger.ui_interact(user.mob)

ADMIN_VERB(view_behavior_tree, R_DEBUG, "查看行为树", "检查某个生物 AI 的行为树。", ADMIN_CATEGORY_DEBUG)
	GLOB.bt_viewer.ui_interact(user.mob)

ADMIN_VERB(new_blackmarket_item, R_BUILD, "创建黑市物品", "向黑市添加一件可购买的物品。", ADMIN_CATEGORY_EVENTS)
	VERB_ARG(object, VERB_ARG_TYPE_TYPEPATH, VERB_ARG_SOURCE_INPUT)
	if(!object)
		to_chat(user, span_boldwarning("失败！请提供完整或部分类型路径！"))
		return
	//first: have admins select a typepath for the item they want to offer.
	var/obj/chosen = pick_closest_path(object, make_types_fancy(subtypesof(/obj)))
	// second: poll admins for the name, description, price, and quantity.
	if(isnull(chosen))
		return
	var/name = tgui_input_text(user, "要出售的物品名称？", "物品上架名称", "奥术物件", max_length = MAX_NAME_LEN)
	if(isnull(name))
		return
	var/description = tgui_input_text(user, "要出售的物品的自定义描述？", "物品上架描述", "[chosen::desc]", max_length = 200)
	if(isnull(description))
		return
	var/price = tgui_input_number(user, "物品上架价格？", "物品上架价格", max_value = INFINITY, min_value = 1, round_value = TRUE)
	if(isnull(price))
		return
	var/quantity = tgui_input_number(user, "要出售的物品数量？", "物品上架数量", default = 1, max_value = 100, min_value = 1, round_value = TRUE)
	if(isnull(quantity))
		return
	//lastly: pick a category for the item to go under
	var/category = tgui_input_list(user, "物品归入哪个分类？", "物品上架分类", BLACKMARKET_CATEGORIES)
	if(isnull(category))
		return

	var/datum/market_item/admin_item = new /datum/market_item()
	// Making a note here that we don't need to assign to blackmarket because we still only have one market type, but if we ever start using multiple we'll want to poll admins.
	admin_item.item = chosen
	SSblackbox.record_feedback("tally", "admin blackmarket items", 1, chosen)

	admin_item.name = name
	admin_item.desc = description
	admin_item.price = price
	admin_item.stock = quantity
	admin_item.category = category
	admin_item.restockable = FALSE

	SSmarket.admin_items_spawned++
	admin_item.identifier = "admin_[SSmarket.admin_items_spawned]"

	SSmarket.initialize_admin_item(admin_item)
	log_admin("[key_name(user)] 创建了新的黑市物品：[name]（[chosen]），价格 [price] 信用点，数量 [quantity]。")
	message_admins("[key_name(user)] 创建了新的黑市物品：[name]（[chosen]），价格 [price] 信用点，数量 [quantity]。")

	BLACKBOX_LOG_ADMIN_VERB("Create Black Market Item")


#undef STEALTH_MODE_TRAIT
