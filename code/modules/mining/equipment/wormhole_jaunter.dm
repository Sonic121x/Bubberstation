/**********************Jaunter**********************/
/obj/item/wormhole_jaunter
	name = "虫洞跳跃器"
	desc = "一种利用过时虫洞技术的一次性装置，纳米传讯此后已将目光转向蓝空间，以实现更精确的传送。至少可以说，穿过它制造的虫洞感觉并不好受。\n得益于自由魔像提供的改装，这个跳跃器可以挂在腰带上，提供坠入裂隙时的保护。"
	icon = 'icons/obj/mining.dmi'
	icon_state = "Jaunter"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	slot_flags = ITEM_SLOT_BELT

/obj/item/wormhole_jaunter/attack_self(mob/user)
	user.visible_message(span_notice("[user.name] 激活了 \the [src]！"))
	SSblackbox.record_feedback("tally", "jaunter", 1, "User") // user activated
	activate(user, TRUE)

/obj/item/wormhole_jaunter/proc/turf_check(mob/user)
	var/turf/device_turf = get_turf(src)
	if(!device_turf || is_centcom_level(device_turf.z) || is_reserved_level(device_turf.z))
		if(user)
			to_chat(user, span_notice("你很难让 \the [src] 正常运作。"))
		return FALSE
	return TRUE

/obj/item/wormhole_jaunter/proc/get_destinations()
	var/list/destinations = list()

	for(var/obj/item/beacon/B in GLOB.teleportbeacons)
		var/turf/T = get_turf(B)
		if(is_station_level(T.z))
			destinations += B

	return destinations

/obj/item/wormhole_jaunter/proc/can_jaunter_teleport()
	var/list/destinations = get_destinations()
	return destinations.len > 0

/obj/item/wormhole_jaunter/proc/activate(mob/user, adjacent, teleport)
	if(!turf_check(user))
		return FALSE

	if(!can_jaunter_teleport())
		if(user)
			to_chat(user, span_notice("\The [src] 在世界上找不到可以锚定虫洞的信标。"))
		else
			visible_message(span_notice("\The [src] 在世界上找不到可以锚定虫洞的信标！"))
		return FALSE

	var/list/destinations = get_destinations()
	var/chosen_beacon = pick(destinations)

	var/obj/effect/portal/jaunt_tunnel/tunnel = new (get_turf(src), 100, null, FALSE, get_turf(chosen_beacon))
	if(teleport)
		tunnel.teleport(user)
	else if(adjacent)
		try_move_adjacent(tunnel)

	qdel(src)
	return TRUE

/obj/item/wormhole_jaunter/emp_act(power)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return

	var/triggered = FALSE
	if(power == 1)
		triggered = TRUE
	else if(power == 2 && prob(50))
		triggered = TRUE

	var/mob/M = loc
	if(istype(M) && triggered)
		M.visible_message(span_userdanger("你的 [src.name] 过载并激活了！"))
		SSblackbox.record_feedback("tally", "jaunter", 1, "EMP") // EMP accidental activation
		activate(M, FALSE, TRUE)
	else if(triggered)
		visible_message(span_warning("\The [src] 过载并激活了！"))
		activate()

/obj/item/wormhole_jaunter/equipped(mob/user, slot, initial)
	. = ..()
	if (slot & ITEM_SLOT_BELT)
		RegisterSignal(user, COMSIG_MOVABLE_CHASM_DROPPED, PROC_REF(chasm_react))

/obj/item/wormhole_jaunter/dropped(mob/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_MOVABLE_CHASM_DROPPED)

/obj/item/wormhole_jaunter/proc/chasm_react(mob/living/user, turf/chasm)
	SIGNAL_HANDLER

	if(!activate(user, FALSE, TRUE))
		return

	to_chat(user, span_userdanger("你的 [src] 激活了，把你从 \the [chasm] 中救了出来！"))
	chasm.visible_message(span_boldwarning("[user] 掉进了 \the [chasm]！")) // To freak out any bystanders
	SSblackbox.record_feedback("tally", "jaunter", 1, "Chasm") // Chasm automatic activation
	return COMPONENT_NO_CHASM_DROP

//jaunter tunnel
/obj/effect/portal/jaunt_tunnel
	name = "跳跃隧道"
	icon = 'icons/effects/anomalies.dmi'
	icon_state = "vortex"
	desc = "由虫洞跳跃器在宇宙中开出的稳定孔洞。用“颠簸”都不足以形容穿过它的感觉有多难受，但至少总能把你送到某个信标附近。"
	mech_sized = TRUE //save your ripley
	innate_accuracy_penalty = 6
	light_on = FALSE
	wibbles = FALSE

/obj/effect/portal/jaunt_tunnel/teleport(atom/movable/M, force = FALSE)
	. = ..()
	if(.)
		// KERPLUNK
		playsound(M,'sound/items/weapons/resonator_blast.ogg',50,TRUE)
		if(iscarbon(M))
			var/mob/living/carbon/L = M
			L.Paralyze(60)
			if(ishuman(L))
				shake_camera(L, 20, 1)
				addtimer(CALLBACK(L, TYPE_PROC_REF(/mob/living/carbon, vomit)), 2 SECONDS)
