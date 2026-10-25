ADMIN_VERB(admin_explosion, R_ADMIN|R_FUN, "爆炸", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(orignator, VERB_ARG_TYPE_OBJ | VERB_ARG_TYPE_TURF | VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /atom)
	var/devastation = input(user, "总毁灭范围。-1 表示无", "输入")  as num|null
	if(devastation == null)
		return
	var/heavy = input(user, "重度冲击范围。-1 表示无", "输入")  as num|null
	if(heavy == null)
		return
	var/light = input(user, "轻度冲击范围。-1 表示无", "输入")  as num|null
	if(light == null)
		return
	var/flash = input(user, "闪光范围。-1 表示无", "输入")  as num|null
	if(flash == null)
		return
	var/flames = input(user, "火焰范围。-1 表示无", "输入")  as num|null
	if(flames == null)
		return

	if ((devastation != -1) || (heavy != -1) || (light != -1) || (flash != -1) || (flames != -1))
		if ((devastation > 20) || (heavy > 20) || (light > 20) || (flames > 20))
			if (tgui_alert(user, "你确定要这么做吗？这会非常卡。", "确认", list("Yes", "No")) == "No")
				return

		explosion(orignator, devastation, heavy, light, flames, flash, explosion_cause = user.mob)
		log_admin("[key_name(user)] 在 [AREACOORD(orignator)] 制造了一场爆炸（[devastation],[heavy],[light],[flames]）")
		message_admins("[key_name_admin(user)] 在 [AREACOORD(orignator)] 制造了一场爆炸（[devastation],[heavy],[light],[flames]）")
		BLACKBOX_LOG_ADMIN_VERB("Explosion")

ADMIN_VERB(admin_emp, R_ADMIN|R_FUN, "电磁脉冲", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(orignator, VERB_ARG_TYPE_OBJ | VERB_ARG_TYPE_TURF | VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /atom)
	var/heavy = input(user, "重度脉冲范围。", "输入")  as num|null
	if(heavy == null)
		return
	var/light = input(user, "轻度脉冲范围。", "输入")  as num|null
	if(light == null)
		return

	if (heavy || light)
		empulse(orignator, heavy, light)
		log_admin("[key_name(user)] 在 [AREACOORD(orignator)] 制造了一次电磁脉冲（[heavy],[light]）")
		message_admins("[key_name_admin(user)] 在 [AREACOORD(orignator)] 制造了一次电磁脉冲（[heavy],[light]）")
		BLACKBOX_LOG_ADMIN_VERB("EM Pulse")

ADMIN_VERB(gib_them, R_ADMIN, "碎尸", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(victim, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	var/confirm = tgui_alert(user, "要掉落大脑吗？", "确认", list("Yes", "No","Cancel")) || "Cancel"
	if(confirm == "Cancel")
		return
	//Due to the delay here its easy for something to have happened to the mob
	if(isnull(victim))
		return

	log_admin("[key_name(user)] 把 [key_name(victim)] 碎尸了")
	message_admins("[key_name_admin(user)] 把 [key_name_admin(victim)] 碎尸了")

	if(isobserver(victim))
		new /obj/effect/gibspawner/generic(get_turf(victim))
		return

	var/mob/living/living_victim = victim
	if (istype(living_victim))
		living_victim.investigate_log("被管理员碎尸了。", INVESTIGATE_DEATHS)
		if(confirm == "Yes")
			living_victim.gib(DROP_ALL_REMAINS)
		else
			living_victim.gib(DROP_ORGANS|DROP_BODYPARTS)

	BLACKBOX_LOG_ADMIN_VERB("Gib")

ADMIN_VERB(gib_self, R_ADMIN, "自我碎尸", "把你自己也享受一遍你给他人的待遇。", ADMIN_CATEGORY_FUN)
	var/confirm = tgui_alert(user, "你确定？", "确认", list("Yes", "No"))
	if(confirm != "Yes")
		return
	log_admin("[key_name(user)] 使用了自我碎尸。")
	message_admins(span_adminnotice("[key_name_admin(user)] 使用了自我碎尸。"))
	BLACKBOX_LOG_ADMIN_VERB("Gib Self")

	var/mob/living/ourself = user.mob
	if (istype(ourself))
		ourself.gib()

ADMIN_VERB(dust_self, R_ADMIN, "自我化灰", "把你自己也享受一遍你给他人的待遇。", ADMIN_CATEGORY_FUN)
	var/confirm = tgui_alert(user, "你确定？", "确认", list("Yes", "No"))
	if(confirm != "Yes")
		return
	log_admin("[key_name(user)] 使用了自我化灰。")
	message_admins(span_adminnotice("[key_name_admin(user)] 使用了自我化灰。"))
	BLACKBOX_LOG_ADMIN_VERB("Dust Self")

	var/mob/living/ourself = user.mob
	if (istype(ourself))
		ourself.dust(just_ash = FALSE, drop_items = FALSE, force = TRUE)

ADMIN_VERB(everyone_random, R_SERVER, "让所有人随机化", "让每个人都拥有随机外观。", ADMIN_CATEGORY_FUN)
	if(SSticker.HasRoundStarted())
		to_chat(user, "不行，你不能这么做，游戏已经开始了。此功能仅在回合开始前有效！", confidential = TRUE)
		return

	var/frn = CONFIG_GET(flag/force_random_names)
	if(frn)
		CONFIG_SET(flag/force_random_names, FALSE)
		message_admins("管理员 [key_name_admin(user)] 关闭了“人人独特”模式。")
		to_chat(user, "已关闭。", confidential = TRUE)
		return

	var/notifyplayers = tgui_alert(user, "要向玩家发送通知吗？", "选项", list("Yes", "No", "Cancel")) || "Cancel"
	if(notifyplayers == "Cancel")
		return

	log_admin("管理员 [key_name(user)] 强制所有玩家使用随机外观。")
	message_admins("管理员 [key_name_admin(user)] 强制所有玩家使用随机外观。")

	if(notifyplayers == "Yes")
		to_chat(world, span_adminnotice("管理员 [user.key] 强制所有玩家使用完全随机的身份！"), confidential = TRUE)

	to_chat(user, "<i>记住：只要回合还没开始，你随时可以再次使用该命令来关闭随机化</i>。", confidential = TRUE)

	CONFIG_SET(flag/force_random_names, TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Make Everyone Random")

ADMIN_VERB(mass_zombie_infection, R_ADMIN, "大规模丧尸感染", "让所有人类感染一种潜伏器官，使其在死亡时变成丧尸。", ADMIN_CATEGORY_FUN)
	var/confirm = tgui_alert(user, "请确认你要为所有人类植入潜伏的丧尸器官？", "确认丧尸", list("Yes", "No"))
	if(confirm != "Yes")
		return

	for(var/i in GLOB.human_list)
		var/mob/living/carbon/human/H = i
		new /obj/item/organ/zombie_infection/nodamage(H)

	message_admins("[key_name_admin(user)] 为所有人类植入了潜伏的丧尸感染。")
	log_admin("[key_name(user)] 为所有人类植入了潜伏的丧尸感染。")
	BLACKBOX_LOG_ADMIN_VERB("Mass Zombie Infection")

ADMIN_VERB(mass_zombie_cure, R_ADMIN, "大规模丧尸治愈", "移除所有人类的丧尸感染，使其恢复正常。", ADMIN_CATEGORY_FUN)
	var/confirm = tgui_alert(user, "请确认你要治愈所有丧尸？", "确认丧尸治愈", list("Yes", "No"))
	if(confirm != "Yes")
		return

	for(var/obj/item/organ/zombie_infection/nodamage/I in GLOB.zombie_infection_list)
		qdel(I)

	message_admins("[key_name_admin(user)] 治愈了所有丧尸。")
	log_admin("[key_name(user)] 治愈了所有丧尸。")
	BLACKBOX_LOG_ADMIN_VERB("Mass Zombie Cure")

ADMIN_VERB(polymorph_all, R_ADMIN, "全体变形", "对每一个生物施加变化之杖的效果。", ADMIN_CATEGORY_FUN)
	var/confirm = tgui_alert(user, "请确认你要对全部生物施放变形？", "确认变形", list("Yes", "No"))
	if(confirm != "Yes")
		return

	var/list/mobs = shuffle(GLOB.alive_mob_list.Copy()) // might change while iterating
	var/who_did_it = key_name_admin(user)

	message_admins("[key_name_admin(user)] 开始对全部活体生物施放变形。")
	log_admin("[key_name(user)] 对全部活体生物施放了变形。")
	BLACKBOX_LOG_ADMIN_VERB("Polymorph All")

	for(var/mob/living/M in mobs)
		CHECK_TICK

		if(!M)
			continue

		M.audible_message(span_hear("……瓦巴杰克……瓦巴杰克……"))
		playsound(M.loc, 'sound/effects/magic/staff_change.ogg', 50, TRUE, -1)

		M.wabbajack()

	message_admins("由 [who_did_it] 发起的大规模变形已完成。")

/// Allow admin to mass add or remove a trait across all mobs
ADMIN_VERB(mass_modify_traits, R_FUN, "批量修改特质", "为每个生物添加或移除一项特质。", ADMIN_CATEGORY_FUN)

	var/choice = tgui_alert(user, "添加还是移除特质？", "批量添加/移除特质", list("Add", "Remove"))
	if(isnull(choice))
		return
	var/is_add = (choice == "Add")
	var/lower_choice = is_add ? "添加" : "移除"

	// Build list of valid traits that can be applied to mobs
	var/list/available_traits = list()
	for(var/key in GLOB.admin_visible_traits)
		if(ispath(/mob, key)) // so we get atom and atom/movable traits too, which doing (istype(key, /mob)) would skip
			available_traits += GLOB.admin_visible_traits[key]
	if(!length(available_traits))
		return

	available_traits = sort_list(available_traits, GLOBAL_PROC_REF(cmp_typepaths_asc)) // sort alphabetically

	var/mob_trait = tgui_input_list(user, "选择要[lower_choice]的特质。", "批量[lower_choice]特质", available_traits)
	if(isnull(mob_trait))
		return
	mob_trait = available_traits[mob_trait]

	var/target_scope = tgui_alert(user, "将[is_add ? "添加" : "移除"]应用到全部生物，还是仅有玩家客户端的生物？", "范围", list("All", "Cliented"))
	if(!target_scope)
		return
	var/cliented_only = (target_scope == "Cliented")

	// So we get readable trait name to display in the uis
	if(!GLOB.admin_trait_name_map)
		GLOB.admin_trait_name_map = generate_admin_trait_name_map()
	var/trait_name = GLOB.admin_trait_name_map[mob_trait] || mob_trait

	// Ask for confirmation first
	var/action_word = is_add ? "为" : "从"
	var/confirm = tgui_alert(
		user,
		"请确认你要[action_word]每个[cliented_only ? "有玩家的" : ""]生物[lower_choice] [trait_name]？",
		"确认批量[is_add ? "添加" : "移除"]特质",
		list("Yes", "No")
	)
	if(confirm != "Yes")
		return

	// Perform operation
	var/affected = 0
	if(is_add) // Adding trait
		var/needs_movetype = GLOB.movement_type_trait_to_flag[mob_trait]
		for(var/mob/mob_to_modify as anything in GLOB.alive_mob_list)
			if(cliented_only && !mob_to_modify.client)
				continue
			if(needs_movetype)
				mob_to_modify.AddElement(/datum/element/movetype_handler)
			ADD_TRAIT(mob_to_modify, mob_trait, TRAIT_ADMIN_GRANTED)
			affected++

	else // Removing trait
		var/source = null
		var/remove_mode = tgui_alert(user, "要从指定来源移除吗？", "批量移除特质", list("All", "Admin-Granted Traits", "Specific"))
		if(isnull(remove_mode))
			return

		switch(remove_mode)
			if("Admin-Granted Traits") source = TRAIT_ADMIN_GRANTED
			if("Specific")
				source = LOWER_TEXT(tgui_input_text(user, "输入来源", "批量移除特质", max_length = MAX_NAME_LEN))
				if(isnull(source))
					return

		for(var/mob/mob_to_modify as anything in GLOB.alive_mob_list)
			if(cliented_only && !mob_to_modify.client)
				continue
			REMOVE_TRAIT(mob_to_modify, mob_trait, source)
			affected++

	if(affected)
		var/plural = "个生物"
		var/log_msg = "[key_name_admin(user)] 批量[is_add ? "添加" : "移除"]了 [trait_name]，影响 [affected] [plural]。"
		message_admins(log_msg)
		log_admin(log_msg)

/// Returns only traits that apply to mobs
/proc/get_mob_admin_traits()
	var/list/out = list()
	for(var/key in GLOB.admin_visible_traits)
		if(ispath(key, /mob)) // key is a mob type or subtype
			out += GLOB.admin_visible_traits[key]
	return out

ADMIN_VERB_AND_CONTEXT_MENU(admin_smite, R_ADMIN|R_FUN, "天罚", "以神圣之力惩罚一名玩家。", ADMIN_CATEGORY_FUN, /mob/living)
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob/living)
	var/punishment = tgui_input_list(user, "选择一项惩罚", "神圣惩罚", GLOB.smites)

	if(QDELETED(target) || !punishment)
		return

	var/smite_path = GLOB.smites[punishment]
	var/datum/smite/smite = new smite_path
	var/configuration_success = smite.configure(user)
	if (configuration_success == FALSE)
		return
	smite.do_effect(user, target)

/// "Turns" people into objects. Really, we just add them to the contents of the item.
/proc/objectify(atom/movable/target, path_or_instance)
	var/atom/tomb
	if(ispath(path_or_instance))
		tomb = new path_or_instance(get_turf(target))
	else
		tomb = path_or_instance
	target.forceMove(tomb)
	target.AddComponent(/datum/component/itembound, tomb)

/**
 * firing_squad is a proc for the :B:erforate smite to shoot each individual bullet at them, so that we can add actual delays without sleep() nonsense
 *
 * Hilariously, if you drag someone away mid smite, the bullets will still chase after them from the original spot, possibly hitting other people. Too funny to fix imo
 *
 * Arguments:
 * * target- guy we're shooting obviously
 * * source_turf- where the bullet begins, preferably on a turf next to the target
 * * body_zone- which bodypart we're aiming for, if there is one there
 * * wound_bonus- the wounding power we're assigning to the bullet, since we don't care about the base one
 * * damage- the damage we're assigning to the bullet, since we don't care about the base one
 */
/proc/firing_squad(mob/living/carbon/target, turf/source_turf, body_zone, wound_bonus, damage)
	if(!target.get_bodypart(body_zone))
		return
	playsound(target, 'sound/items/weapons/gun/revolver/shot.ogg', 100)
	var/obj/projectile/bullet/smite/divine_wrath = new(source_turf)
	divine_wrath.damage = damage
	divine_wrath.wound_bonus = wound_bonus
	divine_wrath.original = target
	divine_wrath.def_zone = body_zone
	divine_wrath.spread = 0
	divine_wrath.aim_projectile(target, source_turf)
	divine_wrath.fire()

/client/proc/punish_log(whom, punishment)
	var/msg = "[key_name_admin(src)] 以 [punishment] 惩罚了 [key_name_admin(whom)]。"
	message_admins(msg)
	admin_ticket_log(whom, msg)
	log_admin("[key_name(src)] 以 [punishment] 惩罚了 [key_name(whom)]。")
