#define SOURCE_PORTAL 1
#define DESTINATION_PORTAL 2

/* Teleportation devices.
 * Contains:
 * Locator
 * Hand-tele
 */

/*
 * Locator
 */
/obj/item/locator
	name = "蓝空间定位器"
	desc = "一种手持设备，能锁定追踪植入体所独有的蓝空间共振，实时提供方向与位置数据。"
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "locator"
	var/temp = null
	obj_flags = CONDUCTS_ELECTRICITY
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)
	var/tracking_range = 35

/obj/item/locator/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BluespaceLocator", name)
		ui.open()

/obj/item/locator/ui_data(mob/user)
	var/list/data = list()
	data["trackingrange"] = tracking_range;

	var/turf/current_turf = get_turf(src) // Get our current turf location.
	if(!current_turf)
		return data

	var/list/track_implants = list()
	for(var/obj/item/implant/tracking/tracking_implant in GLOB.tracked_implants)
		if(!tracking_implant.imp_in || !isliving(tracking_implant.imp_in))
			continue

		var/mob/living/tracked_mob = tracking_implant.imp_in
		if(tracked_mob.stat == DEAD)
			if(tracked_mob.timeofdeath + tracking_implant.lifespan_postmortem < world.time)
				continue

		var/turf/implant_turf = get_turf(tracking_implant)
		if(!implant_turf  || implant_turf.z != current_turf.z)
			continue

		var/distance = max(abs(implant_turf.x - current_turf.x), abs(implant_turf.y - current_turf.y)) // get Chebyshev distance
		if(distance > tracking_range)
			continue

		var/implant_direction = dir2text(get_dir(current_turf, implant_turf))
		track_implants += list(list(name = tracking_implant.imp_in.name, direction = implant_direction, distance = distance))

	data["trackimplants"] = track_implants

	return data

#define PORTAL_LOCATION_DANGEROUS "portal_location_dangerous"
#define PORTAL_DANGEROUS_EDGE_LIMIT 8

/*
 * Hand-tele
 */
/obj/item/hand_tele
	name = "手持传送器"
	desc = "一件应用蓝空间技术的便携装置。其中一个按钮会打开传送门，另一个会重新打开你上次的目的地。"
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "hand_tele"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)
	armor_type = /datum/armor/item_hand_tele
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP
	///List of portal pairs created by this hand tele
	var/list/active_portal_pairs = list()
	///Maximum concurrent active portal pairs allowed
	var/max_portal_pairs = 3
	///Whether this can be used to teleport to and from away levels
	var/away_restricted = TRUE

	/**
	 * Represents the last place we teleported to, for making quick portals.
	 * Can be in the following states:
	 * - null, meaning either this hand tele hasn't been used yet, or the last place it was portalled to was removed.
	 * - PORTAL_LOCATION_DANGEROUS, meaning the last place it teleported to was the "None (Dangerous)" location.
	 * - A weakref to a /obj/machinery/computer/teleporter, meaning the last place it teleported to was a pre-setup location.
	*/
	var/last_portal_location

/datum/armor/item_hand_tele
	bomb = 30
	fire = 100
	acid = 100

///Checks if the targeted portal was created by us, then causes it to expire, removing it
/obj/item/hand_tele/proc/try_dispel_portal(atom/target, mob/user)
	if(is_parent_of_portal(target))
		to_chat(user, span_notice("你用[src]驱散了[target]！"))
		var/obj/effect/portal/portal = target
		portal.expire()
		return TRUE
	return FALSE

/obj/item/hand_tele/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(try_dispel_portal(interacting_with, user))
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/hand_tele/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return interact_with_atom(interacting_with, user, modifiers)

/obj/item/hand_tele/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	var/portal_location = last_portal_location

	if (isweakref(portal_location))
		var/datum/weakref/last_portal_location_ref = last_portal_location
		portal_location = last_portal_location_ref.resolve()

	if (isnull(portal_location))
		to_chat(user, span_warning("[src]短暂闪烁了一下。没有锁定任何目标。"))
		return ITEM_INTERACT_BLOCKING

	try_create_portal_to(user, portal_location)
	return ITEM_INTERACT_SUCCESS

/obj/item/hand_tele/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	return interact_with_atom_secondary(interacting_with, user, modifiers)

/obj/item/hand_tele/attack_self(mob/user)
	if (!can_teleport_notifies(user))
		return
	//SKYRAT EDIT BEGIN
	var/turf/my_turf = get_turf(src)
	if(is_away_level(my_turf.z))
		to_chat(user, "<span class='warning'>[src]无法在此处使用！</span>")
		return
	//SKYRAT EDIT END
	var/list/locations = list()
	for(var/obj/machinery/computer/teleporter/computer as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/computer/teleporter))
		var/atom/target = computer.target_ref?.resolve()
		if(!target)
			computer.target_ref = null
			continue
		if(!check_teleport_valid(user, get_turf(computer), TELEPORT_CHANNEL_BLUESPACE))
			continue

		if(!computer.power_station || !computer.power_station.teleporter_hub)
			continue

		if((computer.power_station.machine_stat & (NOPOWER|BROKEN|MAINT)) || computer.power_station.panel_open)
			continue

		if((computer.power_station.teleporter_hub.machine_stat & (NOPOWER|BROKEN|MAINT)) || computer.power_station.teleporter_hub.panel_open)
			continue

		if(computer.power_station.engaged)
			locations["[get_area(target)]（活跃）"] = computer
		else
			locations["[get_area(target)]（未激活）"] = computer

	locations["无（危险）"] = PORTAL_LOCATION_DANGEROUS

	var/teleport_location_key = tgui_input_list(user, "要锁定的传送器", "手持传送器", sort_list(locations))
	if (isnull(teleport_location_key))
		return
	if(user.get_active_held_item() != src || user.incapacitated)
		return

	// Not always a datum, but needed for IS_WEAKREF_OF to cast properly.
	var/datum/teleport_location = locations[teleport_location_key]
	if (!try_create_portal_to(user, teleport_location))
		return

	if (teleport_location == PORTAL_LOCATION_DANGEROUS)
		last_portal_location = PORTAL_LOCATION_DANGEROUS
	else if (!IS_WEAKREF_OF(teleport_location, last_portal_location))
		if (isweakref(teleport_location))
			var/datum/weakref/about_to_replace_location_ref = last_portal_location
			var/obj/machinery/computer/teleporter/about_to_replace_location = about_to_replace_location_ref.resolve()
			if (about_to_replace_location)
				UnregisterSignal(about_to_replace_location, COMSIG_TELEPORTER_NEW_TARGET)

		RegisterSignal(teleport_location, COMSIG_TELEPORTER_NEW_TARGET, PROC_REF(on_teleporter_new_target))

		last_portal_location = WEAKREF(teleport_location)

/// Takes either PORTAL_LOCATION_DANGEROUS or an /obj/machinery/computer/teleport/computer.
/obj/item/hand_tele/proc/try_create_portal_to(mob/user, teleport_location)
	if (length(active_portal_pairs) >= max_portal_pairs)
		user.show_message(span_notice("[src]正在充能！"))
		return

	var/atom/teleport_target

	if (teleport_location == PORTAL_LOCATION_DANGEROUS)
		var/list/dangerous_turfs = list()
		for(var/turf/dangerous_turf in urange(10, get_turf(src), TRUE))
			if(dangerous_turf.x > world.maxx - PORTAL_DANGEROUS_EDGE_LIMIT || dangerous_turf.x < PORTAL_DANGEROUS_EDGE_LIMIT)
				continue //putting them at the edge is dumb
			if(dangerous_turf.y > world.maxy - PORTAL_DANGEROUS_EDGE_LIMIT || dangerous_turf.y < PORTAL_DANGEROUS_EDGE_LIMIT)
				continue
			if(!check_teleport_valid(src, dangerous_turf))
				continue
			dangerous_turfs += dangerous_turf

		teleport_target = pick(dangerous_turfs)
	else
		var/obj/machinery/computer/teleporter/computer = teleport_location
		var/atom/target = computer.target_ref?.resolve()
		if(!target)
			computer.target_ref = null
		teleport_target = target

	if (teleport_target == null)
		to_chat(user, span_notice("[src]振动了一下，然后停住了。也许你该试试别的。"))
		return

	if(!check_teleport_valid(src, teleport_target))
		to_chat(user, span_notice("[src]发生故障。"))
		return

	if (!can_teleport_notifies(user))
		return

	var/list/obj/effect/portal/created = create_portal_pair(get_turf(user), get_turf(teleport_target), 300, 1, null)
	if(LAZYLEN(created) != 2)
		return

	var/obj/effect/portal/portal1 = created[1]
	var/obj/effect/portal/portal2 = created[2]

	RegisterSignal(portal1, COMSIG_QDELETING, PROC_REF(on_portal_destroy))
	RegisterSignal(portal2, COMSIG_QDELETING, PROC_REF(on_portal_destroy))

	try_move_adjacent(portal1, user.dir)
	if(QDELETED(portal1) || QDELETED(portal2)) //in the event that something managed to delete the portal objects, i.e. something teleported them
		to_chat(user, span_notice("[src]振动了一下，但似乎没有出现传送门。也许你该试试别的。"))
		return
	active_portal_pairs[portal1] = portal2

	investigate_log("被 [key_name(user)] 在 [AREACOORD(user)] 处使用，创建了一对传送门，目的地分别为 [AREACOORD(portal1)] 和 [AREACOORD(portal2)]。", INVESTIGATE_PORTAL)
	add_fingerprint(user)

	user.show_message(span_notice("已锁定。"), MSG_AUDIBLE)

	return TRUE

///Checks for whether creating a portal in our area is allowed or not,
///returning FALSE when in a NOTELEPORT area, an away mission or when the user is not on a turf.
///Is, for some reason, separate from the teleport target's check in try_create_portal_to()
/obj/item/hand_tele/proc/can_teleport_notifies(mob/user)
	var/turf/current_location = get_turf(user)
	if (!current_location || !check_teleport_valid(src, current_location) || !isturf(user.loc) || (away_restricted && is_away_level(current_location.z)))
		to_chat(user, span_notice("[src]发生故障。"))
		return FALSE

	return TRUE

///Clears last teleport location when the teleporter providing our target location changes its target
/obj/item/hand_tele/proc/on_teleporter_new_target(datum/source)
	SIGNAL_HANDLER

	if (IS_WEAKREF_OF(source, last_portal_location))
		last_portal_location = null
		UnregisterSignal(source, COMSIG_TELEPORTER_NEW_TARGET)

///Removes a destroyed portal from active_portal_pairs list
/obj/item/hand_tele/proc/on_portal_destroy(obj/effect/portal/P)
	SIGNAL_HANDLER

	active_portal_pairs -= P //If this portal pair is made by us it'll be erased along with the other portal by the portal.

/obj/item/hand_tele/proc/is_parent_of_portal(obj/effect/portal/P)
	if(!istype(P))
		return FALSE
	if(active_portal_pairs[P])
		return SOURCE_PORTAL
	for(var/i in active_portal_pairs)
		if(active_portal_pairs[i] == P)
			return DESTINATION_PORTAL
	return FALSE

/obj/item/hand_tele/suicide_act(mob/living/user)
	if(iscarbon(user))
		user.visible_message(span_suicide("[user]创造了一个不稳定的传送门，把自己的头伸了进去！看起来是想自杀！"))
		var/mob/living/carbon/itemUser = user
		var/obj/item/bodypart/head/head = itemUser.get_bodypart(BODY_ZONE_HEAD)
		if(head)
			head.drop_limb()
			var/list/safeLevels = SSmapping.levels_by_any_trait(list(ZTRAIT_SPACE_RUINS, ZTRAIT_LAVA_RUINS, ZTRAIT_STATION, ZTRAIT_MINING))
			head.forceMove(locate(rand(1, world.maxx), rand(1, world.maxy), pick(safeLevels)))
			itemUser.visible_message(span_suicide("传送门猛然闭合，把[user]的头一起带走了！"))
		else
			itemUser.visible_message(span_suicide("[user]意识到自己没有头，看起来更加沮丧了……然后突然羞愤而死！"))
		return BRUTELOSS

/obj/item/syndicate_teleporter
	name = "实验性传送器"
	desc = "一件逆向工程仿制的纳米传讯手持传送器。缺少原型机所具备的高级安全功能。背面可以看到一条三头蛇的图案。"
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "syndi-tele"
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 4
	throw_range = 10
	obj_flags = CONDUCTS_ELECTRICITY
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	//Uses of the device left
	var/charges = 4
	//The maximum number of stored uses
	var/max_charges = 4
	///Minimum distance to teleport user forward
	var/minimum_teleport_distance = 4
	///Maximum distance to teleport user forward
	var/maximum_teleport_distance = 8
	//How far the emergency teleport checks for a safe position
	var/parallel_teleport_distance = 3
	// How much blood lost per teleport (out of base 560 blood)
	var/bleed_amount = 20

/obj/item/syndicate_teleporter/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/syndicate_teleporter/Destroy(force)
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/syndicate_teleporter/examine(mob/user)
	. = ..()
	. += span_notice("[src]还剩 <b>[charges]</b> 次充能，总共 [max_charges] 次。")

/obj/item/syndicate_teleporter/attack_self(mob/user)
	. = ..()
	if(.)
		return
	attempt_teleport(user = user, triggered_by_emp = FALSE)
	return TRUE

/obj/item/syndicate_teleporter/process(seconds_per_tick)
	if(SPT_PROB(10, seconds_per_tick) && charges < max_charges)
		charges++
		if(ishuman(loc))
			var/mob/living/carbon/human/holder = loc
			balloon_alert(holder, "传送器发出哔声")
		playsound(src, 'sound/machines/beep/twobeep.ogg', 10, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)

/obj/item/syndicate_teleporter/emp_act(severity)
	. = ..()
	if(!prob(50/severity))
		return
	var/teleported_something = FALSE
	if(ishuman(loc))
		var/mob/living/carbon/human/holder = loc
		balloon_alert(holder, "传送器嗡嗡作响！")
		attempt_teleport(user = holder, triggered_by_emp = TRUE)
	else
		var/turf/teleport_turf = get_turf(src)
		for(var/mob/living/mob_on_same_tile in teleport_turf)
			if(!teleported_something)
				teleported_something = TRUE
			attempt_teleport(user = mob_on_same_tile, triggered_by_emp = TRUE, not_holding_tele = TRUE)
		if(!teleported_something)
			visible_message(span_danger("[src]闪烁一下，从现实中消失了！"))
			do_sparks(2, 1, src)
			qdel(src)

/**
 * Tries to teleport the user forward based on random number between min/max teleport distance vars.
 * If destination is closed turf, try to save user from gibbing via a panic teleport.
 * Wearing bag of holding or triggering teleport via EMP removes panic teleport, higher chance of being gibbed.
 * Mobs on same tile as destination get telefragged.
 **/
/obj/item/syndicate_teleporter/proc/attempt_teleport(mob/user, triggered_by_emp = FALSE, not_holding_tele = FALSE)
	if(!charges && !triggered_by_emp)
		balloon_alert(user, "正在充能！")
		return

	var/turf/current_location = get_turf(user)

	if(malfunctioning(user, current_location))
		if(not_holding_tele)
			return
		balloon_alert(user, "发生故障！")
		return

	var/teleport_distance = rand(minimum_teleport_distance, maximum_teleport_distance)
	var/turf/destination = get_teleport_loc(current_location, user, teleport_distance)
	var/bagholdingcheck = FALSE
	for(var/obj/item/check as anything in user.get_all_contents_type(/obj/item))
		if(check.item_flags & BLUESPACE_INTERFERENCE)
			bagholdingcheck = TRUE
	if(isclosedturf(destination))
		if(!triggered_by_emp && !bagholdingcheck)
			panic_teleport(user, destination) //We're in a wall, engage emergency parallel teleport.
		else
			if(bagholdingcheck && !not_holding_tele)
				to_chat(user, span_warning("你的次元背包上的蓝空间接口干扰了传送！"))
			get_fragged(user, destination, not_holding_tele) //EMP teleported you into a wall? Wearing a BoH? You're dead.
	else
		telefrag(destination, user)
		do_teleport(user, destination, channel = TELEPORT_CHANNEL_FREE)
		charges = max(charges - 1, 0)
		new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(current_location)
		new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(destination)
		if(make_bloods(current_location, destination, user))
			new /obj/effect/temp_visual/circle_wave/syndi_teleporter/bloody(destination)
		else
			new /obj/effect/temp_visual/circle_wave/syndi_teleporter(destination)
		playsound(current_location, SFX_PORTAL_ENTER, 50, 1, SHORT_RANGE_SOUND_EXTRARANGE)
		playsound(destination, 'sound/effects/phasein.ogg', 25, 1, SHORT_RANGE_SOUND_EXTRARANGE)
		playsound(destination, SFX_PORTAL_ENTER, 50, 1, SHORT_RANGE_SOUND_EXTRARANGE)

/obj/item/syndicate_teleporter/proc/malfunctioning(mob/guy_teleporting, turf/current_location)
	if(!current_location)
		return TRUE
	if(!check_teleport_valid(src, current_location))
		return TRUE
	if(is_away_level(current_location.z))
		return TRUE
	if(is_centcom_level(current_location.z))
		return TRUE
	if(is_reserved_level(current_location.z))
		return TRUE
	if(!isturf(guy_teleporting.loc))
		return TRUE
	return FALSE

/**
 * Checks parallel_teleport_distance amount of tiles parallel to user's teleport destination.
 * If no valid closed turfs found, gib user.
 **/
/obj/item/syndicate_teleporter/proc/panic_teleport(mob/user, turf/destination)
	var/turf/mobloc = get_turf(user)
	var/turf/emergency_destination = get_teleport_loc(destination, user, distance = 0, closed_turf_check = TRUE, errorx = parallel_teleport_distance)

	if(emergency_destination)
		telefrag(emergency_destination, user)
		do_teleport(user, emergency_destination, channel = TELEPORT_CHANNEL_FREE)
		charges = max(charges - 1, 0)
		new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(mobloc)
		new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(emergency_destination)
		balloon_alert(user, "紧急传送已触发！")
		if(make_bloods(destination, emergency_destination, user))
			new /obj/effect/temp_visual/circle_wave/syndi_teleporter/bloody(destination)
		else
			new /obj/effect/temp_visual/circle_wave/syndi_teleporter(destination)
		playsound(mobloc, SFX_PORTAL_ENTER, 50, 1, SHORT_RANGE_SOUND_EXTRARANGE)
		playsound(emergency_destination, 'sound/effects/phasein.ogg', 25, 1, SHORT_RANGE_SOUND_EXTRARANGE)
		playsound(emergency_destination, SFX_PORTAL_ENTER, 50, 1, SHORT_RANGE_SOUND_EXTRARANGE)
		playsound(src, 'sound/machines/warning-buzzer.ogg', 25, TRUE)
	else //We tried to save. We failed. Death time.
		get_fragged(user, destination)

///Force move victim to destination, explode destination, drop all victim's items, gib them
/obj/item/syndicate_teleporter/proc/get_fragged(mob/living/victim, turf/destination, not_holding_tele = FALSE)
	var/turf/mobloc = get_turf(victim)
	victim.forceMove(destination)
	new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(mobloc)
	new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(destination)
	playsound(mobloc, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	playsound(destination, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	playsound(destination, 'sound/effects/magic/disintegrate.ogg', 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	if(!not_holding_tele)
		to_chat(victim, span_userdanger("你传送进了[destination]，[src]试图救你，但是……"))
	else
		to_chat(victim, span_userdanger("你传送进了[destination]。"))
	destination.ex_act(EXPLODE_HEAVY)
	victim.unequip_everything()
	victim.investigate_log("被[src]绞碎成肉酱。", INVESTIGATE_DEATHS)
	victim.gib(DROP_ALL_REMAINS)

///Damage and stun all mobs in fragging_location turf, called after a teleport
/obj/item/syndicate_teleporter/proc/telefrag(turf/fragging_location, mob/user) // Don't let this gib. Never let this gib.
	for(var/mob/living/victim in fragging_location)//Hit everything in the turf
		victim.apply_damage(20, BRUTE)
		victim.Paralyze(6 SECONDS)
		to_chat(victim, span_warning("[user]传送到了你身上，蓝空间冲击波把你掀翻在地！"))
		victim.throw_at(get_step_rand(victim), 1, 1, user, spin = TRUE)

///Bleed and make blood splatters at tele start and end points
/obj/item/syndicate_teleporter/proc/make_bloods(turf/old_location, turf/new_location, mob/living/user)
	if(user.can_bleed(BLOOD_COVER_TURFS) != BLEED_SPLATTER)
		return FALSE
	user.add_splatter_floor(old_location)
	user.add_splatter_floor(new_location)
	if(!iscarbon(user))
		return FALSE
	var/mob/living/carbon/carbon_user = user

	// always lose a bit
	carbon_user.bleed(bleed_amount * 0.25)
	// sometimes lose a lot
	// average evens out to 10 per teleport, but the randomness spices things up
	if(prob(25) && bleed_amount)
		playsound(src, 'sound/effects/wounds/pierce1.ogg', 40, vary = TRUE)
		visible_message(span_warning("鲜血从[user]身上喷涌而出，[src]没能正确传送对方的身体！"), \
			span_boldwarning("鲜血从你身上明显喷出，[src]没能正确传送你的身体！"))
		carbon_user.bleed(bleed_amount * 0.75)
		carbon_user.spray_blood(pick(GLOB.alldirs), rand(1, 3))
		return TRUE

	return FALSE
	// retval used for picking wave type

/// Visual effect spawned when teleporting
/obj/effect/temp_visual/circle_wave/syndi_teleporter
	duration = 0.25 SECONDS
	color = COLOR_SYNDIE_RED
	max_alpha = 100
	amount_to_scale = 0.8

/obj/effect/temp_visual/circle_wave/syndi_teleporter/bloody
	duration = 0.25 SECONDS
	color = COLOR_VIVID_RED
	max_alpha = 160
	amount_to_scale = 1

/obj/item/paper/syndicate_teleporter
	name = "传送器指南"
	default_raw_text = {"
		<b>关于你新式原型传送器的使用说明：</b><br>
		<br>
		本传送器会将使用者朝其面朝的方向传送 4-8 米。<br>
		<br>
		它拥有 4 次充能，并会随时间随机恢复。不，把传送器插进 APC、微波炉或带电的气闸并不会让它充得更快。<br>
		<br>
		<b>警告：</b>传送进墙内会激活失效保护，沿平行方向最多 3 米进行传送，但如果找不到安全位置，使用者将被撕成碎片。<br>
		<br>
		请勿让传送器暴露在电磁脉冲之下。否则可能发生意外的故障。
		<br>
		最后一点警告：所涉及的技术本质上是实验性的。尽管多年的研究已让我们能够避免把你的器官留在原地，但它实在无法顾及你体内的所有液体。
		"}

/obj/effect/temp_visual/teleport_abductor/syndi_teleporter
	duration = 5

#undef PORTAL_LOCATION_DANGEROUS
#undef PORTAL_DANGEROUS_EDGE_LIMIT

#undef SOURCE_PORTAL
#undef DESTINATION_PORTAL
