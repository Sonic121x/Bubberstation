/obj/item/clothing/head/helmet/monkey_sentience
	name = "猴子智力放大头盔"
	desc = "一顶内嵌电路、十分易碎的头盔，用于将猴子的智力提升到更高水平。你看到好几个警告标签……"
	icon_state = "monkeymind"
	inhand_icon_state = null
	strip_delay = 100
	armor_type = /datum/armor/helmet_monkey_sentience
	var/mob/living/carbon/human/magnification = null ///if the helmet is on a valid target (just works like a normal helmet if not (cargo please stop))
	var/polling = FALSE///if the helmet is currently polling for targets (special code for removal)
	var/light_colors = 1 ///which icon state color this is (red, blue, yellow)
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
/datum/armor/helmet_monkey_sentience
	melee = 5
	bomb = 25
	fire = 50
	acid = 50

/obj/item/clothing/head/helmet/monkey_sentience/Initialize(mapload)
	. = ..()
	light_colors = rand(1,3)
	update_appearance()

/obj/item/clothing/head/helmet/monkey_sentience/examine(mob/user)
	. = ..()
	. += span_boldwarning("——警告：从实验对象头上取下头盔可能导致：——")
	. += span_warning("鲜血狂怒")
	. += span_warning("脑死亡")
	. += span_warning("原始基因激活")
	. += span_warning("基因构成整体易解体")
	. += span_boldnotice("请咨询你的首席医疗官，确认智力放大是否适合你。")

/obj/item/clothing/head/helmet/monkey_sentience/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][light_colors][magnification ? "up" : null]"

/obj/item/clothing/head/helmet/monkey_sentience/equipped(mob/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_HEAD))
		return
	if(istype(user, /mob/living/carbon/human/dummy)) // Prevents ghosts from being polled when the helmet is put on a dummy.
		return
	if(!ismonkey(user) || user.ckey)
		var/mob/living/something = user
		to_chat(something, span_boldnotice("你感到后脑勺传来一阵刺痛，持续了片刻。"))
		something.apply_damage(5, BRUTE, BODY_ZONE_HEAD, FALSE, FALSE, FALSE) // notably: no damage resist (it's in your helmet), no damage spread (it's in your helmet)
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 30, TRUE)
		return
	if(!(GLOB.ghost_role_flags & GHOSTROLE_STATION_SENTIENCE))
		say("错误：中央指挥部已在本星区暂时禁用猴子智能头盔。最近的合法星区：253.7 万光年之外。")
		return
	magnification = user // this polls ghosts
	visible_message(span_warning("[src] 通电启动了！"))
	playsound(src, 'sound/machines/ping.ogg', 30, TRUE)
	RegisterSignal(magnification, COMSIG_SPECIES_LOSS, PROC_REF(make_fall_off))
	INVOKE_ASYNC(src, TYPE_PROC_REF(/obj/item/clothing/head/helmet/monkey_sentience, connect), user)

/obj/item/clothing/head/helmet/monkey_sentience/proc/connect(mob/user)
	polling = TRUE
	var/mob/chosen = SSpolling.poll_ghosts_for_target("你想扮演一只被智力放大的猴子吗？", ROLE_MONKEY_HELMET, poll_time = 5 SECONDS, checked_target = magnification, ignore_category = POLL_IGNORE_MONKEY_HELMET)
	polling = FALSE
	if(!magnification)
		return
	if(!chosen)
		UnregisterSignal(magnification, COMSIG_SPECIES_LOSS)
		magnification = null
		visible_message(span_notice("[src] 归于沉寂，掉在了地上。也许你该稍后再试？"))
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 30, TRUE)
		user.dropItemToGround(src)
		return

	magnification.key = chosen.key
	playsound(src, 'sound/machines/microwave/microwave-end.ogg', 100, FALSE)
	to_chat(magnification, span_notice("你是一只被智力放大的猴子！用生命保护你的头盔——一旦失去头盔，你的智能也会随之消失！"))
	var/policy = get_policy(ROLE_MONKEY_HELMET)
	if(policy)
		to_chat(magnification, policy)
	icon_state = "[icon_state]up"
	REMOVE_TRAIT(magnification, TRAIT_PRIMITIVE, SPECIES_TRAIT) // Monkeys with sentience should be able to use less primitive tools.

/obj/item/clothing/head/helmet/monkey_sentience/Destroy()
	if(magnification)
		ADD_TRAIT(magnification, TRAIT_PRIMITIVE, SPECIES_TRAIT)
		magnification = null
	return ..()

/obj/item/clothing/head/helmet/monkey_sentience/proc/disconnect()
	if(!magnification) // not put on a viable head
		return
	// either used up correctly or taken off before polling finished (punish this by having a chance to gib the monkey?)
	UnregisterSignal(magnification, COMSIG_SPECIES_LOSS)
	playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 30, TRUE)
	ADD_TRAIT(magnification, TRAIT_PRIMITIVE, SPECIES_TRAIT) // We removed it, now that they're back to being dumb, add the trait again.
	if(!polling)// put on a viable head, but taken off after polling finished.
		if(magnification.client)
			to_chat(magnification, span_userdanger("你感到那一丝智能被生生剥离，周围的一切都暗淡下来……"))
			magnification.ghostize(FALSE)
		if(prob(10))
			switch(rand(1, 4))
				if(1) // blood rage
					var/datum/ai_controller/monkey/monky_controller = magnification.ai_controller
					monky_controller.set_trip_mode(mode = FALSE)
					monky_controller.set_blackboard_key(BB_MONKEY_AGGRESSIVE, TRUE)
				if(2) // brain death
					magnification.apply_damage(500, BRAIN, BODY_ZONE_HEAD, FALSE, FALSE, FALSE)
				if(3) // primal gene (gorilla)
					magnification.gorillize()
				if(4) // genetic mass susceptibility (gib)
					magnification.investigate_log("因智能头盔在错误时机被摘下而被炸成了碎肉。", INVESTIGATE_DEATHS)
					magnification.gib()
	magnification = null

/obj/item/clothing/head/helmet/monkey_sentience/dropped(mob/user)
	. = ..()
	disconnect()

/obj/item/clothing/head/helmet/monkey_sentience/proc/make_fall_off()
	SIGNAL_HANDLER
	if(magnification)
		visible_message(span_warning("随着 [magnification] 改变形态，[src] 从它头上掉了下来！"))
		magnification.dropItemToGround(src)
