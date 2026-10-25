/mob/living/silicon/ai/blob_act(obj/structure/blob/B)
	if (stat != DEAD)
		adjust_brute_loss(60)
		return TRUE
	return FALSE

/mob/living/silicon/ai/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	disconnect_shell()
	if (prob(30))
		switch(pick(1,2))
			if(1)
				view_core()
			if(2)
				SSshuttle.requestEvac(src,"警报：AI 核心内检测到能量涌动！空间站完整性可能受损！正在启动——%m091#ar-BZZT")

/mob/living/silicon/ai/ex_act(severity, target)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			investigate_log("被爆炸撕成了碎块。", INVESTIGATE_DEATHS)
			gib(DROP_ALL_REMAINS)
		if(EXPLODE_HEAVY)
			if (stat != DEAD)
				adjust_brute_loss(60)
				adjust_fire_loss(60)
		if(EXPLODE_LIGHT)
			if (stat != DEAD)
				adjust_brute_loss(30)

	return TRUE

/mob/living/silicon/ai/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0, visual = 0, type = /atom/movable/screen/fullscreen/flash, length = 25)
	return // no eyes, no flashing

/mob/living/silicon/ai/emag_act(mob/user, obj/item/card/emag/emag_card) ///emags access panel lock, so you can crowbar it without robotics access or consent
	. = ..()
	if(emagged)
		balloon_alert(user, "访问面板锁已经短路了！")
		return
	balloon_alert(user, "访问面板锁已短路")
	var/message = (user ? "[user] 短路了你的访问面板锁！" : "你的访问面板锁被短路了！")
	to_chat(src, span_warning(message))
	do_sparks(3, FALSE, src) // just a bit of extra "oh shit" to the ai - might grab its attention
	emagged = TRUE
	return TRUE

/mob/living/silicon/ai/wrench_act(mob/living/user, obj/item/tool)
	if(!incapacitated && (client || deployed_shell?.client))
		// alive and well AIs control their floor bolts
		balloon_alert(user, "AI 的固定螺栓电机在抵抗！")
		return ITEM_INTERACT_BLOCKING
	balloon_alert(user, "[!is_anchored ? "正在拧紧" : "正在拧松"]螺栓……")
	balloon_alert(src, "螺栓正在被[!is_anchored ? "拧紧" : "拧松"]……")
	if(!tool.use_tool(src, user, 4 SECONDS))
		return ITEM_INTERACT_SUCCESS
	flip_anchored()
	balloon_alert(user, "螺栓已[is_anchored ? "拧紧" : "拧松"]")
	balloon_alert(src, "螺栓已[is_anchored ? "拧紧" : "拧松"]")
	return ITEM_INTERACT_SUCCESS

/mob/living/silicon/ai/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(user.combat_mode)
		return
	if(!is_anchored)
		balloon_alert(user, "请先用螺栓固定！")
		return ITEM_INTERACT_SUCCESS
	if(opened)
		if(emagged)
			balloon_alert(user, "访问面板锁已损坏！")
			return ITEM_INTERACT_SUCCESS
		balloon_alert(user, "正在关闭访问面板……")
		balloon_alert(src, "访问面板正在关闭……")
		if(!tool.use_tool(src, user, 5 SECONDS))
			return ITEM_INTERACT_SUCCESS
		balloon_alert(src, "访问面板已关闭")
		balloon_alert(user, "访问面板已关闭")
		opened = FALSE
		return ITEM_INTERACT_SUCCESS
	if(stat == DEAD)
		to_chat(user, span_warning("访问面板看起来已损坏，你试着把盖板撬松。"))
	else
		var/consent
		var/consent_override = FALSE
		if(ishuman(user))
			var/mob/living/carbon/human/human_user = user
			if(human_user.wear_id)
				var/list/access = human_user.wear_id.GetAccess()
				if(ACCESS_ROBOTICS in access)
					consent_override = TRUE
		if(mind)
			consent = tgui_alert(src, "[user] 正试图打开你的访问面板，要解锁盖板吗？", "AI 访问面板", list("是", "否"))
			if(consent == "否" && !consent_override && !emagged)
				to_chat(user, span_notice("[src] 拒绝解锁其访问面板。"))
				return ITEM_INTERACT_SUCCESS
			if(consent != "是" && (consent_override || emagged))
				to_chat(user, span_warning("[src] 拒绝解锁其访问面板……于是你[!emagged ? "刷了 ID 卡，" : ""]还是把它打开了！"))
		else
			if(!consent_override && !emagged)
				to_chat(user, span_notice("[src] 没有回应你解锁其访问面板盖锁的请求。"))
				return ITEM_INTERACT_SUCCESS
			else
				to_chat(user, span_notice("[src] 没有回应你解锁其访问面板盖锁的请求。你[!emagged ? "刷了 ID 卡，" : ""]还是把它打开了。"))

	balloon_alert(user, "正在撬开访问面板……")
	balloon_alert(src, "访问面板正在被撬开……")
	if(!tool.use_tool(src, user, (stat == DEAD ? 40 SECONDS : 5 SECONDS)))
		return ITEM_INTERACT_SUCCESS
	balloon_alert(src, "访问面板已打开")
	balloon_alert(user, "访问面板已打开")
	opened = TRUE
	return ITEM_INTERACT_SUCCESS

/mob/living/silicon/ai/wirecutter_act(mob/living/user, obj/item/tool)
	. = ..()
	if(user.combat_mode)
		return
	if(!is_anchored)
		balloon_alert(user, "请先用螺栓固定！")
		return ITEM_INTERACT_SUCCESS
	if(!opened)
		balloon_alert(user, "请先打开访问面板！")
		return ITEM_INTERACT_SUCCESS
	balloon_alert(src, "神经网络正在断开连接……")
	balloon_alert(user, "正在断开神经网络……")
	if(!tool.use_tool(src, user, (stat == DEAD ? 5 SECONDS : 40 SECONDS)))
		return ITEM_INTERACT_SUCCESS
	if(IS_MALF_AI(src))
		to_chat(user, span_userdanger("线缆内部的电压骤然升高！"))
		user.electrocute_act(120, src)
		opened = FALSE
		return ITEM_INTERACT_SUCCESS
	to_chat(src, span_danger("你感到极度困惑、迷失方向。"))
	var/atom/ai_structure = ai_mob_to_structure()
	ai_structure.balloon_alert(user, "神经网络已断开")
	return ITEM_INTERACT_SUCCESS

/mob/living/silicon/ai/attack_effects(damage_done, hit_zone, armor_block, obj/item/attacking_item, mob/living/attacker)
	if(damage_done > 0 && attacking_item.damtype != STAMINA && stat != DEAD)
		spark_system.start()
		. = TRUE
	return ..() || .
