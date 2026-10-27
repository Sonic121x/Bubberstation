/// Furthest the hull will shove debris. Past the long axis.
#define VITEZSTVI_SHOVE_LIMIT 48
/// Opt-out row in the admin list.
#define VITEZSTVI_LEAVE_IT "交给那些醉鬼吧"

/obj/docking_port/mobile/emergency/vitezstvi
	/// Time before impact to fire each collision warning.
	var/early_warning_time = 30 SECONDS
	var/imminent_warning_time = 8 SECONDS
	var/early_warned = FALSE
	var/imminent_warned = FALSE
	/// Fraction of the approach at which we poll ghosts.
	var/deploy_fraction = 0.5
	/// Total inbound flight time this approach, in deciseconds.
	var/inbound_total_time = 0
	var/contractors_deployed = FALSE
	/// What was aboard just before impact.
	var/list/manifest
	/// Turfs the crash site was made of, captured on arrival.
	var/list/departure_footprint

/obj/docking_port/mobile/emergency/vitezstvi/check()
	if(mode == SHUTTLE_CALL)
		var/time_left = timeLeft(1)
		if(!early_warned && time_left <= early_warning_time)
			early_warned = TRUE
			var/site_line = GLOB.vitezstvi_crash_area_name || "某个重要的地方"
			priority_announce(
				text = "空间站，这里是 VARS-7“向导”号。军需官，你个老混蛋，我们收到你的招标了。我们这就来把你的人接出去。只是接近航向有点小问题。帕维尔，空间站怎么越来越大了？[site_line]？这一带的同志们，麻烦你们到别处去当同志。感谢您选择胜利军械。",
				title = "碰撞警告",
				sound = 'sound/machines/warning-buzzer.ogg',
				sender_override = "VARS-7 接近警报",
				color_override = "red",
			)
		if(!imminent_warned && time_left <= imminent_warning_time)
			imminent_warned = TRUE
			take_manifest()
			priority_announce(
				text = "哦，我操，帕维尔，它还在变大！大家都动起来！快他妈闪开！",
				title = "碰撞警告",
				sender_override = "VARS-7 接近警报",
				color_override = "red",
			)
			sound_collision_klaxon()
		// point of no return, so crew it from deadchat like the carp escape event does
		if(!contractors_deployed && inbound_total_time && time_left <= inbound_total_time * deploy_fraction)
			contractors_deployed = TRUE
			INVOKE_ASYNC(src, PROC_REF(deploy_contractors))
	var/was_inbound = (mode == SHUTTLE_CALL)
	var/was_grounded = (mode != SHUTTLE_ESCAPE)
	. = ..()
	if(was_inbound && mode == SHUTTLE_DOCKED)
		clear_wreckage()
		play_landing_impact()
		// our own ship is already physically down, so give the real dock back
		vitezstvi_restore_home_dock()
		capture_departure_site()
	// the hull only actually leaves on the way into escape, not at ignition
	if(was_grounded && mode == SHUTTLE_ESCAPE)
		devastate_departure_site()
	return .

/// Proximity alarm
/obj/docking_port/mobile/emergency/vitezstvi/proc/sound_collision_klaxon()
	for(var/mob/listener as anything in GLOB.player_list)
		var/turf/listener_turf = get_turf(listener)
		if(!listener_turf || !SSmapping.level_trait(listener_turf.z, ZTRAIT_STATION))
			continue
		SEND_SOUND(listener, 'sound/machines/warning-buzzer.ogg')

/// Spoomy boomy
/obj/docking_port/mobile/emergency/vitezstvi/proc/play_landing_impact()
	var/turf/epicentre
	var/list/passengers = list()
	for(var/area/shuttle_area as anything in shuttle_areas)
		for(var/turf/shuttle_turf in shuttle_area)
			if(!epicentre)
				epicentre = shuttle_turf
			for(var/mob/passenger in shuttle_turf)
				passengers += passenger
	if(!epicentre)
		return

	// Shuttle needs to shake both levels of a multi z station
	for(var/z_level in SSmapping.get_connected_levels(epicentre))
		var/turf/deck_epicentre = locate(epicentre.x, epicentre.y, z_level)
		if(!deck_epicentre)
			continue
		SSexplosions.shake_the_room(deck_epicentre, 14, 255, 3, 6)

	playsound(epicentre, 'sound/vehicles/car_crash.ogg', 100, vary = FALSE, falloff_distance = 25)

	for(var/mob/passenger as anything in passengers)
		SEND_SOUND(passenger, 'sound/vehicles/car_crash.ogg')

	do_sparks(8, TRUE, epicentre)
	do_smoke(3, epicentre, epicentre)

/// Poll ghosts into the contractor bunks.
/obj/docking_port/mobile/emergency/vitezstvi/proc/deploy_contractors()
	var/list/bunks = list()
	for(var/area/shuttle_area as anything in shuttle_areas)
		for(var/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/bunk in shuttle_area)
			bunks += bunk
	if(!length(bunks))
		return
	var/list/takers = SSpolling.poll_ghost_candidates(
		question = "你愿意考虑在胜利军械谋个职位吗？",
		check_jobban = ROLE_SENTIENCE,
		poll_time = 20 SECONDS,
		alert_pic = /obj/item/radio/headset/vitezstvi,
		role_name_text = "胜利军械承包商",
		amount_to_pick = length(bunks),
	)
	if(!islist(takers))
		takers = takers ? list(takers) : list()
	for(var/mob/dead/observer/taker in takers)
		if(!length(bunks))
			break
		var/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/bunk = pick(bunks)
		bunks -= bunk
		if(taker?.ckey)
			bunk.create_from_ghost(taker, apply_prefs = TRUE)

/obj/docking_port/mobile/emergency/vitezstvi/request(obj/docking_port/stationary/S, area/signal_origin, reason, red_alert, set_coefficient = null)
	early_warned = FALSE
	imminent_warned = FALSE
	contractors_deployed = FALSE
	manifest = null
	departure_footprint = null
	. = ..()
	// timeLeft(1) is deciseconds; the parent just set the timer
	inbound_total_time = timeLeft(1)
	// only a genuine call rolls a crash site - a preview never reaches request()
	vitezstvi_roll_crash_target()
	vitezstvi_announce_target()

/// REF() strings, not atoms, so nothing gets held alive.
/obj/docking_port/mobile/emergency/vitezstvi/proc/take_manifest()
	manifest = list()
	for(var/area/shuttle_area as anything in shuttle_areas)
		for(var/turf/shuttle_turf in shuttle_area)
			for(var/atom/movable/thing in shuttle_turf)
				manifest[REF(thing)] = TRUE

/// Coordinates, not turf refs: departure swaps the turf objects out from under us.
/obj/docking_port/mobile/emergency/vitezstvi/proc/capture_departure_site()
	departure_footprint = list()
	for(var/area/shuttle_area as anything in shuttle_areas)
		for(var/turf/shuttle_turf in shuttle_area)
			departure_footprint += list(list(shuttle_turf.x, shuttle_turf.y, shuttle_turf.z))

/// A room a shuttle crashed into shouldn't look untouched once the shuttle leaves.
/obj/docking_port/mobile/emergency/vitezstvi/proc/devastate_departure_site()
	if(!departure_footprint)
		return
	var/list/footprint = departure_footprint
	departure_footprint = null
	for(var/list/coords as anything in footprint)
		CHECK_TICK
		var/turf/wrecked = locate(coords[1], coords[2], coords[3])
		if(isnull(wrecked))
			continue
		if(iswallturf(wrecked))
			var/turf/closed/wall/flattened = wrecked
			// station walls sit on plating, so the crater never opens to space
			flattened.dismantle_wall(devastated = TRUE)
		else if(istype(wrecked, /turf/open/floor))
			var/turf/open/floor/broken_floor = wrecked
			broken_floor.break_tile_to_plating()
		wrecked.add_overlay(image('icons/effects/effects.dmi', "scorch"))

/// Docking shoves junk one tile, which lands it inside. Push it the rest of the way out.
/obj/docking_port/mobile/emergency/vitezstvi/proc/clear_wreckage()
	if(!manifest)
		return
	var/list/debris = list()
	var/turf/sample
	var/min_x = INFINITY
	var/max_x = 0
	var/min_y = INFINITY
	var/max_y = 0
	for(var/area/shuttle_area as anything in shuttle_areas)
		for(var/turf/shuttle_turf in shuttle_area)
			sample = shuttle_turf
			min_x = min(min_x, shuttle_turf.x)
			max_x = max(max_x, shuttle_turf.x)
			min_y = min(min_y, shuttle_turf.y)
			max_y = max(max_y, shuttle_turf.y)
			for(var/atom/movable/thing in shuttle_turf)
				if(ismob(thing) || manifest[REF(thing)])
					continue
				debris += thing
	manifest = null
	if(!length(debris) || !sample)
		return
	var/turf/centre = locate(round((min_x + max_x) * 0.5), round((min_y + max_y) * 0.5), sample.z)
	for(var/atom/movable/thing as anything in debris)
		shove_clear(thing, centre)

/// Walks debris outward until it clears the hull.
/obj/docking_port/mobile/emergency/vitezstvi/proc/shove_clear(atom/movable/thing, turf/centre)
	var/turf/current = get_turf(thing)
	if(!current)
		return
	var/push_dir = get_dir(centre, current) || pick(GLOB.cardinals)
	for(var/steps_taken in 1 to VITEZSTVI_SHOVE_LIMIT)
		var/turf/next_turf = get_step(current, push_dir)
		if(!next_turf)
			break
		current = next_turf
		if(!isopenturf(current) || (get_area(current) in shuttle_areas))
			continue
		thing.forceMove(current)
		return
	// boxed in by the map edge
	qdel(thing)

/obj/docking_port/mobile/emergency/vitezstvi/Topic(href, list/href_list)
	. = ..()
	if(!href_list["vitezstvi_retarget"])
		return
	if(!check_rights(R_ADMIN))
		return
	admin_retarget(usr)

/// Deliberately unrestricted: every station area is offered.
/obj/docking_port/mobile/emergency/vitezstvi/proc/admin_retarget(mob/user)
	if(early_warned)
		to_chat(user, span_warning("穿梭机已经太近了，无法改变其轨迹！"))
		return
	var/list/options = list()
	for(var/area_path in GLOB.the_station_areas)
		var/area/candidate = GLOB.areas_by_type[area_path]
		if(candidate)
			options[chinese_area_display(candidate.name)] = candidate
	if(!length(options))
		to_chat(user, span_warning("没有可供瞄准的空间站区域。"))
		return
	var/list/menu = sort_list(options)
	menu.Insert(1, VITEZSTVI_LEAVE_IT)
	var/choice = tgui_input_list(user, "我们要落哪儿？", "胜利军械飞行控制", menu)
	if(isnull(choice) || choice == VITEZSTVI_LEAVE_IT)
		return
	var/area/destination = options[choice]
	var/turf/target = vitezstvi_crash_turf(list(destination.type))
	if(!target || !vitezstvi_place_crash_target(target))
		to_chat(user, span_warning("[choice] 里没有地方能放下穿梭机。"))
		return
	vitezstvi_announce_target(rerouted = TRUE)
	message_admins("[key_name_admin(user)] 将 VARS-7“向导”号改道至 [choice]。")
	log_admin("[key_name(user)] 将 VARS-7“向导”号改道至 [choice]。")

#undef VITEZSTVI_SHOVE_LIMIT
#undef VITEZSTVI_LEAVE_IT
