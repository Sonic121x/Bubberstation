GLOBAL_LIST_EMPTY(total_extraction_beacons)

/obj/item/extraction_pack
	name = "富尔顿回收包"
	desc = "一种气球装置，可将装备或人员回收到富尔顿回收信标。任何未固定的东西都能被移动。在手中使用回收包即可将其与信标链接。"
	icon = 'icons/obj/fulton.dmi'
	icon_state = "extraction_pack"
	w_class = WEIGHT_CLASS_NORMAL
	/// Beacon weakref
	var/datum/weakref/beacon_ref
	/// List of networks
	var/list/beacon_networks = list("station")
	/// Number of uses left
	var/uses_left = 3
	/// Can be used indoors
	var/can_use_indoors
	/// Can be used on living creatures
	var/safe_for_living_creatures = TRUE
	/// Maximum force that can be used to extract
	var/max_force_fulton = MOVE_FORCE_STRONG
	/// How long will the mob be paralyzed for?
	var/paralyze_duration = 32 SECONDS

/obj/item/extraction_pack/examine()
	. = ..()
	. += span_infoplain("它还剩 [uses_left] 次使用机会。")

	var/obj/structure/extraction_point/beacon = beacon_ref?.resolve()

	if(isnull(beacon))
		beacon_ref = null
		. += span_infoplain("它尚未与信标链接。")
		return

	. += span_infoplain("它已与 [beacon.name] 链接。")

/obj/item/extraction_pack/attack_self(mob/user)
	var/list/possible_beacons = list()
	for(var/datum/weakref/point_ref as anything in GLOB.total_extraction_beacons)
		var/obj/structure/extraction_point/extraction_point = point_ref.resolve()
		if(isnull(extraction_point))
			GLOB.total_extraction_beacons.Remove(point_ref)
			continue
		if(extraction_point.beacon_network in beacon_networks)
			possible_beacons += extraction_point

	if(!length(possible_beacons))
		balloon_alert(user, "没有信标")
		return

	var/chosen_beacon = tgui_input_list(user, "要连接的信标", "气球回收包", sort_names(possible_beacons))
	if(isnull(chosen_beacon))
		return

	beacon_ref = WEAKREF(chosen_beacon)
	balloon_alert(user, "已链接！")

/obj/item/extraction_pack/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ismovable(interacting_with))
		return NONE
	if(!isturf(interacting_with.loc)) // no extracting stuff inside other stuff
		return NONE
	var/atom/movable/thing = interacting_with
	if(thing.anchored)
		return NONE

	var/atom/movable/beacon = get_beacon(user)
	if(isnull(beacon))
		return ITEM_INTERACT_BLOCKING
	var/area/area = get_area(thing)
	if(!can_use_indoors)
		if(!area.outdoors)
			balloon_alert(user, "不在户外！")
			return ITEM_INTERACT_BLOCKING
	if(area.area_flags & NOTELEPORT)
		balloon_alert(user, "无法激活！")
		return ITEM_INTERACT_BLOCKING
	var/area/target_area = get_area(beacon)
	if(area != target_area && ((area.area_flags & LOCAL_TELEPORT) || (target_area.area_flags & LOCAL_TELEPORT)))
		balloon_alert(user, "无法激活！")
		return ITEM_INTERACT_BLOCKING
	if(!safe_for_living_creatures && check_for_living_mobs(thing))
		to_chat(user, span_warning("[src] 不适用于活体生物，它们撑不过回程！"))
		balloon_alert(user, "不安全！")
		return ITEM_INTERACT_BLOCKING
	if(thing.move_resist > max_force_fulton)
		balloon_alert(user, "太重了！")
		return ITEM_INTERACT_BLOCKING
	balloon_alert_to_viewers("正在固定……")
	playsound(thing, 'sound/items/zip/zip.ogg', vol = 50, vary = TRUE)
	if(isliving(thing))
		var/mob/living/creature = thing
		if(creature.mind)
			to_chat(thing, span_userdanger("你正在被回收！保持不动以继续。"))

	if(!do_after(user, 5 SECONDS, target = thing))
		return ITEM_INTERACT_BLOCKING

	if(QDELETED(beacon))
		balloon_alert(user, "信标丢失！")
		return ITEM_INTERACT_BLOCKING

	balloon_alert_to_viewers("回收中！")
	if(loc == user && ishuman(user))
		var/mob/living/carbon/human/human_user = user
		human_user.back?.atom_storage?.attempt_insert(src, user, force = STORAGE_SOFT_LOCKED)
	uses_left--

	if(uses_left <= 0)
		user.transferItemToLoc(src, thing, TRUE)

	if(isliving(thing))
		var/mob/living/creature = thing
		creature.Paralyze(paralyze_duration) // Keep them from moving during the duration of the extraction
		ADD_TRAIT(creature, TRAIT_FORCED_STANDING, FULTON_PACK_TRAIT) // Prevents animation jank from happening
		if(creature.buckled)
			creature.buckled.unbuckle_mob(creature, TRUE) // Unbuckle them to prevent anchoring problems
	else
		thing.set_anchored(TRUE)
		thing.set_density(FALSE)

	var/obj/effect/extraction_holder/holder_obj = new(get_turf(thing))
	holder_obj.appearance = thing.appearance
	thing.forceMove(holder_obj)
	var/mutable_appearance/balloon2 = mutable_appearance('icons/effects/fulton_balloon.dmi', "fulton_expand", layer = VEHICLE_LAYER, appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM | KEEP_APART)
	balloon2.pixel_z = 10
	holder_obj.add_overlay(balloon2)
	addtimer(CALLBACK(src, PROC_REF(create_balloon), thing, user, holder_obj, balloon2, get_turf(beacon)), 0.4 SECONDS)
	return ITEM_INTERACT_SUCCESS

/obj/item/extraction_pack/proc/get_beacon(mob/living/user)
	var/obj/structure/extraction_point/beacon = beacon_ref?.resolve()
	if (isnull(beacon))
		balloon_alert(user, "尚未链接！")
		beacon_ref = null
	return beacon

/obj/item/extraction_pack/proc/create_balloon(atom/movable/thing, mob/living/user, obj/effect/extraction_holder/holder_obj, mutable_appearance/balloon2, turf/beacon_turf)
	var/mutable_appearance/balloon = mutable_appearance('icons/effects/fulton_balloon.dmi', "fulton_balloon", layer = VEHICLE_LAYER, appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM | KEEP_APART)
	balloon.pixel_z = 10
	holder_obj.cut_overlay(balloon2)
	holder_obj.add_overlay(balloon)
	playsound(holder_obj.loc, 'sound/items/fulton/fultext_deploy.ogg', vol = 50, vary = TRUE, extrarange = -3)

	animate(holder_obj, pixel_z = 10, time = 2 SECONDS, flags = ANIMATION_RELATIVE)
	animate(pixel_z = 5, time = 1 SECONDS, flags = ANIMATION_RELATIVE)
	animate(pixel_z = -5, time = 1 SECONDS, flags = ANIMATION_RELATIVE)
	animate(pixel_z = 5, time = 1 SECONDS, flags = ANIMATION_RELATIVE)
	animate(pixel_z = -5, time = 1 SECONDS, flags = ANIMATION_RELATIVE)

	sleep(6 SECONDS)

	playsound(holder_obj.loc, 'sound/items/fulton/fultext_launch.ogg', vol = 50, vary = TRUE, extrarange = -3)
	animate(holder_obj, pixel_z = 1000, time = 3 SECONDS, flags = ANIMATION_RELATIVE)

	if(ishuman(thing))
		var/mob/living/carbon/human/creature = thing
		creature.SetUnconscious(0)
		creature.remove_status_effect(/datum/status_effect/drowsiness)
		creature.SetSleeping(0)

	sleep(3 SECONDS)

	var/turf/flooring_near_beacon = list()
	for(var/turf/floor as anything in RANGE_TURFS(1, beacon_turf))
		if(!floor.is_blocked_turf())
			flooring_near_beacon += floor

	if(!length(flooring_near_beacon))
		flooring_near_beacon += beacon_turf

	holder_obj.forceMove(pick(flooring_near_beacon))

	animate(holder_obj, pixel_z = -990, time = 5 SECONDS, flags = ANIMATION_RELATIVE)
	animate(pixel_z = 5, time = 1 SECONDS, flags = ANIMATION_RELATIVE)
	animate(pixel_z = -5, time = 1 SECONDS, flags = ANIMATION_RELATIVE)

	sleep(7 SECONDS)

	var/mutable_appearance/balloon3 = mutable_appearance('icons/effects/fulton_balloon.dmi', "fulton_retract", layer = VEHICLE_LAYER, appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM | KEEP_APART)
	balloon3.pixel_z = 10
	holder_obj.cut_overlay(balloon)
	holder_obj.add_overlay(balloon3)

	sleep(0.4 SECONDS)

	holder_obj.cut_overlay(balloon3)
	if (isliving(thing))
		REMOVE_TRAIT(thing, TRAIT_FORCED_STANDING, FULTON_PACK_TRAIT)
	thing.set_anchored(FALSE) // An item has to be unanchored to be extracted in the first place.
	thing.set_density(initial(thing.density))
	animate(holder_obj, pixel_z = -10, time = 0.5 SECONDS, flags = ANIMATION_RELATIVE)
	sleep(0.5 SECONDS)
	thing.forceMove(holder_obj.loc)
	qdel(holder_obj)
	if(uses_left <= 0)
		qdel(src)

/obj/item/extraction_pack/networked
	name = "联网富尔顿回收包"
	desc = "一种可将设备或人员运往附近“烛光”采矿导航网络中任意富尔顿信标或已开采矿石喷口的气球。任何未被固定的东西都能搬走。"
	icon_state = "extraction_pack_networked"
	paralyze_duration = 18 SECONDS

/obj/item/extraction_pack/networked/attack_self(mob/user)
	var/list/possible_beacons = list()
	for(var/datum/weakref/point_ref as anything in GLOB.total_extraction_beacons)
		var/obj/structure/extraction_point/extraction_point = point_ref.resolve()
		if(isnull(extraction_point))
			GLOB.total_extraction_beacons.Remove(point_ref)
			continue
		if(extraction_point.beacon_network in beacon_networks)
			possible_beacons += extraction_point

	for (var/datum/mining_beacon_network/network as anything in GLOB.mining_beacon_networks)
		var/list/fulton_points = list()
		var/node_located = FALSE
		for (var/datum/component/candela_node/node as anything in network.linked_nodes)
			if (node.fulton_point)
				fulton_points += node.parent

			if (node_located)
				continue

			if (get_dist(node.parent, user) <= MINING_BEACON_MAX_REACH && (user in viewers(MINING_BEACON_MAX_REACH, node.parent)))
				node_located = TRUE

		if (node_located)
			possible_beacons |= fulton_points

	if(!length(possible_beacons))
		balloon_alert(user, "没有信标")
		return

	var/chosen_beacon = tgui_input_list(user, "要连接的信标", "气球回收包", sort_names(possible_beacons))
	if(isnull(chosen_beacon))
		return

	beacon_ref = WEAKREF(chosen_beacon)
	balloon_alert(user, "已链接！")

/obj/item/extraction_pack/networked/get_beacon(mob/living/user)
	var/obj/structure/extraction_point/beacon = beacon_ref?.resolve()
	if (isnull(beacon))
		balloon_alert(user, "尚未链接！")
		beacon_ref = null
		return null

	// Anything that isn't an extraction point must've came from a Candela network, go through all of its nodes check if we can access it
	if (istype(beacon))
		return beacon

	for (var/datum/mining_beacon_network/network as anything in GLOB.mining_beacon_networks)
		// Check if its even our target's network to begin with
		var/target_net = FALSE
		for (var/datum/component/candela_node/node as anything in network.linked_nodes)
			if (node.parent == beacon)
				target_net = TRUE
				break

		if (!target_net)
			continue

		for (var/datum/component/candela_node/node as anything in network.linked_nodes)
			if (get_dist(node.parent, user) <= MINING_BEACON_MAX_REACH && (user in viewers(MINING_BEACON_MAX_REACH, node.parent)))
				return beacon

	balloon_alert(user, "超出网络覆盖范围！")
	return null

/obj/item/fulton_core
	name = "回收信标组装套件"
	desc = "建造后会发出信号，富尔顿回收装置可锁定该信号。在手中激活即可展开为信标。"
	icon = 'icons/obj/fulton.dmi'
	icon_state = "folded_extraction"
	/// Structure to spawn
	var/point_type = /obj/structure/extraction_point

/obj/item/fulton_core/attack_self(mob/user)
	var/area/user_area = get_area(user)
	if(user_area.area_flags & NOTELEPORT)
		balloon_alert(user, "无法部署！")
		return

	if(!do_after(user, 1.5 SECONDS, target = user) || QDELETED(src))
		return

	new point_type(get_turf(user), user)
	playsound(src, 'sound/items/deconstruct.ogg', vol = 50, vary = TRUE, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE)
	qdel(src)

/obj/item/fulton_core/networked
	name = "联网回收信标组装套件"
	desc = "建造后会发出信号，同一“烛光”导航网络中的富尔顿回收装置可锁定该信号。在手中激活即可展开为信标。"
	point_type = /obj/structure/extraction_point/networked

/obj/item/fulton_core/syndicate
	name = "可疑的回收信标组装套件"
	point_type = /obj/structure/extraction_point/syndicate

/obj/structure/extraction_point
	name = "富尔顿回收信标"
	desc = "富尔顿回收系统的信标。在手中激活回收包即可将其与信标链接。"
	icon = 'icons/obj/fulton.dmi'
	icon_state = "extraction_point"
	anchored = TRUE
	density = FALSE
	obj_flags = CAN_BE_HIT | UNIQUE_RENAME
	/// String key used to check if a beacon can be accessed by a pack
	var/beacon_network = "station"
	/// What type of core do we drop when picked up
	var/core_type = /obj/item/fulton_core

/obj/structure/extraction_point/Initialize(mapload, mob/creator)
	. = ..()
	name += " ([rand(100,999)]) ([get_area_name(src, TRUE)])"
	INVOKE_ASYNC(src, PROC_REF(poll_name), creator)
	GLOB.total_extraction_beacons.Add(WEAKREF(src))
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/extraction_point/proc/poll_name(mob/creator)
	var/name_input = tgui_input_text(creator, "你想给信标起什么名字？", "富尔顿信标", default = name, max_length = MAX_LABEL_LEN)
	if (name_input && !QDELETED(src) && !QDELETED(creator) && creator.Adjacent(src))
		name = name_input

/obj/structure/extraction_point/Destroy(force)
	GLOB.total_extraction_beacons -= WEAKREF(src)
	return ..()

/obj/structure/extraction_point/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	balloon_alert_to_viewers("正在收起……")
	if(!do_after(user, 1.5 SECONDS, src))
		return
	new core_type(drop_location())
	playsound(src, 'sound/items/deconstruct.ogg', vol = 50, vary = TRUE, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE)
	qdel(src)

/obj/structure/extraction_point/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "[icon_state]_light", src, alpha = src.alpha)

/obj/structure/extraction_point/syndicate
	beacon_network = "syndicate"
	core_type = /obj/item/fulton_core/syndicate

/obj/structure/extraction_point/networked
	name = "联网富尔顿回收信标"
	desc = "富尔顿回收系统的信标，可通过“烛光”导航网络广播其位置。"
	icon_state = "extraction_point_networked"
	core_type = /obj/item/fulton_core/networked

/obj/structure/extraction_point/networked/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/candela_node, new /datum/mining_beacon_network(), null, connection_pixel_x = base_pixel_w, connection_pixel_y = base_pixel_z - 2)

/obj/effect/extraction_holder
	name = "回收容器"
	desc = "你不该看到这个"
	var/atom/movable/stored_obj

/obj/item/extraction_pack/proc/check_for_living_mobs(atom/A)
	if(isliving(A))
		var/mob/living/L = A
		if(L.stat != DEAD)
			return TRUE
	for(var/thing in A.get_all_contents())
		if(isliving(A))
			var/mob/living/L = A
			if(L.stat != DEAD)
				return TRUE
	return FALSE

/obj/effect/extraction_holder/singularity_act()
	return

/obj/effect/extraction_holder/singularity_pull(atom/singularity, current_size)
	return

/obj/item/extraction_pack/syndicate
	name = "辛迪加富尔顿回收包"
	can_use_indoors = TRUE
	beacon_networks = list("station", "syndicate")
