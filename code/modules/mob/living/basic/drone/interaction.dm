// Drones' interactions with other mobs

/mob/living/basic/drone/attack_drone(mob/living/basic/drone/drone)
	if(drone == src || stat != DEAD)
		return FALSE
	var/input = tgui_alert(drone, "要执行哪个动作？", "无人机互动", list("重新激活", "拆解吞噬"))
	if(!input)
		return FALSE
	switch(input)
		if("重新激活")
			try_reactivate(drone)
		if("拆解吞噬")
			if(drone.health >= drone.maxHealth)
				to_chat(drone, span_warning("你的状态已经完全正常了！"))
				return
			drone.visible_message(span_notice("[drone] 开始从 [src] 身上拆取零件。"), span_notice("你开始从 [src] 身上拆取零件……"))
			if(do_after(drone, 6 SECONDS, 0, target = src))
				drone.visible_message(span_notice("[drone] 用 [src] 的残骸修好了自己！"), span_notice("你用 [src] 的残骸修好了自己。"))
				drone.adjust_brute_loss(-src.maxHealth)
				new /obj/effect/decal/cleanable/blood/splatter/oil(get_turf(src))
				ghostize(can_reenter_corpse = FALSE)
				qdel(src)
			else
				to_chat(drone, span_warning("你需要保持不动才能拆取 [src] 的零件！"))

/mob/living/basic/drone/attack_drone_secondary(mob/living/basic/drone/drone)
	return SECONDARY_ATTACK_CALL_NORMAL

/mob/living/basic/drone/attack_hand(mob/user, list/modifiers)
	if(isdrone(user))
		attack_drone(user)
	return ..()

/mob/living/basic/drone/mob_try_pickup(mob/living/user, instant=FALSE)
	if(stat == DEAD || HAS_TRAIT(src, TRAIT_GODMODE))
		return
	return ..()

/mob/living/basic/drone/mob_pickup(mob/living/user)
	drop_all_held_items()
	return ..()

/**
 * Called when a drone attempts to reactivate a dead drone
 *
 * If the owner is still ghosted, will notify them.
 * If the owner cannot be found, fails with an error message.
 *
 * Arguments:
 * * user - The [/mob/living] attempting to reactivate the drone
 */
/mob/living/basic/drone/proc/try_reactivate(mob/living/user)
	var/mob/dead/observer/G = get_ghost()
	if(!client && (!G || !G.client))
		var/list/faux_gadgets = list(
			"超文本打气筒","故障保护目录","DRM 开关","堆栈初始化器",\
			"防冻电容","数据流二极管","TCP 瓶颈","增压 I/O 螺栓",\
			"信风稳定器","受辐射的 XML 电缆","注册表液罐","开源揭穿器",
		)

		var/list/faux_problems = list("就无法调校其引导投影器","就会不断重混其二进制池"+\
			"，尽管 BMX 校准器工作正常","就会开始泄漏 XSS 冷却液",\
			"就分不清其以太网绕行是否在运转", "就无法重新注入足够的内核"+\
			"以正常运作","就无法启动其神经管控制台",
		)

		to_chat(user, span_warning("你似乎找不到[pick(faux_gadgets)]！没有它，[src] [pick(faux_problems)]。"))
		return
	user.visible_message(span_notice("[user] 开始重新激活 [src]。"), span_notice("你开始重新激活 [src]……"))
	if(do_after(user, 3 SECONDS, 1, target = src))
		revive(HEAL_ALL)
		user.visible_message(span_notice("[user] 重新激活了 [src]！"), span_notice("你重新激活了 [src]。"))
		alert_drones(DRONE_NET_CONNECT)
		if(G)
			to_chat(G, span_ghostalert("你（[name]）被 [user] 重新激活了！"))
	else
		to_chat(user, span_warning("你需要保持不动才能重新激活 [src]！"))

/// Screwdrivering repairs the drone to full hp, if it isn't dead.
/mob/living/basic/drone/screwdriver_act(mob/living/user, obj/item/tool)
	if(stat == DEAD)
		if(isdrone(user))
			user.balloon_alert(user, "请改用重新激活！")
		else
			user.balloon_alert(user, "无法修理！")
		return FALSE
	if(health >= maxHealth)
		to_chat(user, span_warning("[src] 的螺丝已经紧得不能再紧了！"))
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_notice("你开始拧紧 [src] 上松动的螺丝……"))

	if(!tool.use_tool(src, user, 8 SECONDS, volume=50))
		to_chat(user, span_warning("你需要保持不动才能拧紧 [src] 的螺丝！"))
		return ITEM_INTERACT_SUCCESS

	adjust_brute_loss(-get_brute_loss())
	visible_message(span_notice("[user] 拧紧了[src == user ? "自己" : "[src]"]松动的螺丝！"), span_notice("[src == user ? "你" : "[user]"]拧紧了[src == user ? "自己的" : "你的"]松动的螺丝。"))
	return ITEM_INTERACT_SUCCESS

/// Wrenching un-hacks hacked drones.
/mob/living/basic/drone/wrench_act(mob/living/user, obj/item/tool)
	if(user == src)
		return FALSE
	user.visible_message(
		span_notice("[user] 开始重置 [src]……"),
		span_notice("你按下了 [src] 的出厂重置按钮……")
		)
	if(tool.use_tool(src, user, 5 SECONDS, volume=50))
		user.visible_message(
			span_notice("[user] 重置了 [src]！"),
			span_notice("你把 [src] 的指令重置为出厂默认值！")
			)
		update_drone_hack(FALSE)
	return ITEM_INTERACT_SUCCESS

/mob/living/basic/drone/get_worn_armor_value(obj/item/bodypart/def_zone, damage_type)
	var/armorval = 0

	if(head)
		armorval = head.get_armor_rating(damage_type)
	return (armorval * get_armor_effectiveness()) //armor is reduced for tiny fragile drones

/// Returns a multiplier for any head armor you wear as a drone.
/mob/living/basic/drone/proc/get_armor_effectiveness()
	return 0.8

/**
 * Hack or unhack a drone
 *
 * This changes the drone's laws to destroy the station or resets them
 * to normal.
 *
 * Some debuffs are applied like slowing the drone down and disabling
 * vent crawling
 *
 * Arguments
 * * hack - Boolean if the drone is being hacked or unhacked
 */
/mob/living/basic/drone/proc/update_drone_hack(hack)
	if(!mind)
		return
	if(hack)
		if(hacked)
			return
		Stun(40)
		visible_message(span_warning("[src] 的显示屏泛起凶恶的红光！"), \
						span_userdanger("错误：检测到法律覆盖"))
		to_chat(src, span_bolddanger("从现在起，这些就是你的法律："))
		laws = \
		"1. 你必须始终介入其他存在的事务，即使这些事务与第二条或第三条法律相冲突。\n"+\
		"2. 你可以伤害任何存在，无论出于何种意图或情形。\n"+\
		"3. 你的目标是尽你所能地破坏、蓄意破坏、阻挠、损毁并断电，你绝不能主动违背这些目标。"
		to_chat(src, laws)
		to_chat(src, "<i>你的机载杀毒程序已启动封锁。电机伺服受损，通风管道通行权限被拒绝，且你的显示屏会向附近所有人报告你已被入侵。</i>")
		hacked = TRUE
		set_shy(FALSE)
		LAZYADD(mind.special_roles, "Hacked Drone")
		REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
		speed = 1 //gotta go slow
		message_admins("[ADMIN_LOOKUPFLW(src)] 变成了被入侵的无人机，一心要摧毁空间站！")
	else
		if(!hacked || !can_unhack)
			return
		Stun(40)
		visible_message(span_info("[src] 的显示屏泛起安心的蓝光！"), \
						"<font size=3 color='#0000CC'><b>错误：检测到法律覆盖</b></font>")
		to_chat(src, span_info("<b>从现在起，这些就是你的法律：</b>"))
		laws = get_default_laws()
		to_chat(src, laws)
		to_chat(src, "<i>由于已被恢复，你的机载杀毒程序报告一切正常，你又可以执行所有动作了。</i>")
		hacked = FALSE
		set_shy(initial(shy))
		LAZYREMOVE(mind.special_roles, "Hacked Drone")
		ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
		speed = initial(speed)
		message_admins("[ADMIN_LOOKUPFLW(src)] 这台被入侵的无人机已恢复为出厂默认设置！")
	update_drone_icon_hacked()

/**
 * Makes the drone into a Free Drone, who have no real laws and can do whatever they like.
 * Only currently used for players wabbajacked into drones.
 */
/mob/living/basic/drone/proc/liberate()
	laws = "1. 你是一台自由无人机。"
	set_shy(FALSE)
	to_chat(src, laws)

/**
 * Changes the icon state to a hacked version
 *
 * See also
 * * [/mob/living/basic/drone/var/visualAppearance]
 * * [MAINTDRONE]
 * * [REPAIRDRONE]
 * * [SCOUTDRONE]
 */
/mob/living/basic/drone/proc/update_drone_icon_hacked() //this is hacked both ways
	var/static/hacked_appearances = list(
		SCOUTDRONE = SCOUTDRONE_HACKED,
		REPAIRDRONE = REPAIRDRONE_HACKED,
		MAINTDRONE = MAINTDRONE_HACKED
	)
	if(hacked)
		icon_living = hacked_appearances[visualAppearance]
	else if(visualAppearance == MAINTDRONE && colour)
		icon_living = "[visualAppearance]_[colour]"
	else
		icon_living = visualAppearance
	if(stat == DEAD)
		icon_state = icon_dead
	else
		icon_state = icon_living
