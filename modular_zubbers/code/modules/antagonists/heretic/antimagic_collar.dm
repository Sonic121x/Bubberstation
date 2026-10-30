/obj/item/clothing/neck/antimagic_collar
	name = "\improper 离实项圈"
	desc = "一种笨重的反魔法项圈，能触及并切断任何地方与漫宿相连的丝线。"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "antimagic_collar"
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	worn_icon_state = "antimagic_collar"
	inhand_icon_state = "reverse_bear_trap"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.25,
	)

	armor_type = /datum/armor/antimagic_collar
	equip_delay_self = 6 SECONDS
	equip_delay_other = 8 SECONDS
	repairable_by = /obj/item/stack/sheet/bluespace_crystal

	speech_span = SPAN_ROBOT

	max_integrity = 100
	integrity_failure = 0.5

	clothing_traits = list(TRAIT_MANSUS_INHIBITION)

	var/obj/item/radio/headset/radio

	var/set_id = "UNSET"
	var/locked = FALSE
	var/broken = FALSE

	var/static/list/emp_heavy_results = list(
		"zap" = 50,
		"burn" = 50,
		"unlock" = 20,
	)

/datum/armor/antimagic_collar
	acid = 50
	fire = 75
	bomb = 50

/obj/item/clothing/neck/antimagic_collar/Destroy()
	. = ..()

	QDEL_NULL(radio)

/obj/item/clothing/neck/antimagic_collar/Initialize(mapload)
	. = ..()

	radio = new /obj/item/radio/headset/headset_sec(src)
	ADD_TRAIT(src, TRAIT_NO_STRIP, REF(src))
	ADD_TRAIT(src, TRAIT_DANGEROUS_EQUIP, INNATE_TRAIT)

/obj/item/clothing/neck/antimagic_collar/create_moth_snack()
	return null

/obj/item/clothing/neck/antimagic_collar/attack_self(mob/user, modifiers)
	var/new_id = tgui_input_text(user, "输入新编号。", "输入编号", timeout = 20 SECONDS, max_length = 100)

	if (!new_id)
		balloon_alert(user, "编号无效！")
		return FALSE

	set_id = new_id
	balloon_alert(user, "编号已设为[set_id]")
	return TRUE

/obj/item/clothing/neck/antimagic_collar/examine(mob/user)
	. = ..()

	. += span_boldnotice("戴在颈部时，可阻止侍徒使用大多数法术和全部仪式。")
	. += span_boldnotice("拿在手中使用可设置编号。当前编号：[set_id == "UNSET" ? "未设置" : set_id]。")
	. += span_notice("酸液和火焰可以使其失效，强力电磁脉冲可以将其解锁。")
	. += span_warning("用钥匙解锁时会向安保频道广播！不过，如果通讯受到干扰……")
	. += "" // hr
	. += span_notice("它似乎[locked ? "已上锁" : "未上锁"]。")
	if (broken)
		. += span_boldwarning("它已经损坏，目前无法工作！")
	else
		var/hp_left = get_integrity() - (max_integrity * integrity_failure)
		. += span_notice("再损失[EXAMINE_HINT("[hp_left]")]点耐久就会损坏。")

/obj/item/clothing/neck/antimagic_collar/equipped(mob/living/user, slot)
	. = ..()

	if (slot == ITEM_SLOT_NECK)
		if (IS_HERETIC(user) && !broken)
			to_chat(loc, span_userdanger("你感到自己与漫宿的联系逐渐减弱，最终消失！"))
		if (!locked)
			toggle_lock(TRUE)
			visible_message(span_warning("[src]自动上锁了！"))

/obj/item/clothing/neck/antimagic_collar/atom_break(damage_flag)
	. = ..()

	name = "[name]（已损坏！）"
	playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50)
	broken = TRUE
	if (isliving(loc))
		var/mob/living/wearer = loc
		do_sparks(3)
		say("检测到抑制功能失效！请检查项圈是否损坏！")
		if (IS_HERETIC(wearer))
			to_chat(wearer, span_boldnotice("随着[src]噼啪作响、火花四溅，你感到力量回来了……"))

	detach_clothing_traits(TRAIT_MANSUS_INHIBITION)
	REMOVE_TRAIT(src, TRAIT_NO_STRIP, REF(src))
	// still locked, though

/obj/item/clothing/neck/antimagic_collar/emp_act(severity)
	. = ..()

	var/mob/living/wearer
	if (isliving(loc))
		wearer = loc

	switch (severity)
		if (EMP_LIGHT)
			return
		if (EMP_HEAVY)
			var/outcome = pick_weight(emp_heavy_results)
			switch (outcome)
				if ("zap")
					to_chat(loc, span_userdanger("[src]发生故障，猛烈的电击使你浑身无力！"))
					wearer?.electrocute_act(25, src, 1, SHOCK_ILLUSION|SHOCK_SUPPRESS_MESSAGE|SHOCK_NOGLOVES|SHOCK_KNOCKDOWN) // illusion so it doesnt do damage
				if ("burn")
					to_chat(loc, span_userdanger("[src]发生故障，过热并灼伤了你的颈部！"))
					wearer?.apply_damage(25, BURN, BODY_ZONE_HEAD) // yes it can wound
				if ("unlock")
					if (!locked)
						return
					to_chat(loc, span_userdanger("[src]发生故障，竟然意外解锁了！"))
					toggle_lock(FALSE)

/obj/item/clothing/neck/antimagic_collar/repair(mob/user)
	. = ..()

	broken = FALSE
	name = initial(src.name)

	if (TRAIT_MANSUS_INHIBITION in clothing_traits)
		return

	attach_clothing_traits(TRAIT_MANSUS_INHIBITION)
	ADD_TRAIT(src, TRAIT_NO_STRIP, REF(src))

	if (isliving(loc))
		var/mob/living/wearer = loc

		playsound(src, 'sound/machines/ping.ogg', 50)
		say("抑制功能已恢复！")

		if (IS_HERETIC(wearer))
			to_chat(wearer, span_userdanger("随着[src]恢复运作，你感到自己的力量消失了！"))

/obj/item/clothing/neck/antimagic_collar/proc/toggle_lock(new_status, mob/living/user, obj/item/key/collar/antimagic/key)
	if (locked == new_status)
		return

	locked = new_status
	balloon_alert_to_viewers("[locked ? "已上锁！" : "已解锁！"]")
	if (!isnull(key) && !locked)
		radio.talk_into(src, "离实项圈[set_id == "UNSET" ? "未设置" : set_id]已被钥匙解锁。", RADIO_CHANNEL_SECURITY, list(speech_span))
	if (user)
		to_chat(user, span_warning("你[locked ? "锁上" : "解锁"]了项圈。"))

/obj/item/clothing/neck/antimagic_collar/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(try_lock))

/obj/item/clothing/neck/antimagic_collar/proc/try_lock(atom/source, mob/user, obj/item/attacking_item, params)
	if(istype(attacking_item, /obj/item/key/collar/antimagic))
		toggle_lock(!locked, user, attacking_item)
	return TRUE

/obj/item/clothing/neck/antimagic_collar/attack_hand(mob/user)
	if(loc == user && user.get_item_by_slot(ITEM_SLOT_NECK) && locked)
		to_chat(user, span_warning("项圈锁住了！必须先解锁才能取下！你也可以试着破坏它……"))
		return
	..()

/obj/item/key/collar/antimagic
	name = "离实项圈钥匙"
	desc = "唯一能打开离实项圈的钥匙。平时很难碰见。"

/obj/item/key/collar/antimagic/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	var/obj/item/clothing/neck/antimagic_collar/collar = target_mob.get_item_by_slot(ITEM_SLOT_NECK)
	if (!istype(collar))
		user.balloon_alert(user, "没有项圈！")
		return FALSE

	collar.toggle_lock(!collar.locked, user, src)

	return TRUE

/obj/item/storage/box/antimagic
	name = "离实项圈盒"
	desc = "内含两个用于压制侍徒的项圈，以及一把解锁钥匙。"
	icon_state = "secbox"
	illustration = "heart_black"

/obj/item/storage/box/antimagic/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/clothing/neck/antimagic_collar(src)
	new /obj/item/key/collar/antimagic(src)

/datum/supply_pack/security/antimagic_collar
	name = "离实项圈"
	desc = "内含两个用于压制侍徒的项圈，以及一把解锁钥匙。"
	cost = CARGO_CRATE_VALUE * 5
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/storage/box/antimagic = 1)
	crate_name = "离实项圈箱"
