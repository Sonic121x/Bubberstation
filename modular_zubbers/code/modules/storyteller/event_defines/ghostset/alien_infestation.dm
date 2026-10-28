/datum/round_event_control/alien_infestation
	name = "异形入侵"
	typepath = /datum/round_event/ghost_role/alien_infestation
	weight = 2
	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CHAOTIC)
	min_players = 35
	category = EVENT_CATEGORY_ENTITIES
	description = "一只异形幼虫会从随机通风口生成。"

/datum/round_event_control/alien_infestation/can_spawn_event(players_amt, allow_magic = FALSE)
	. = ..()
	if(!.)
		return .

	for(var/mob/living/carbon/alien/A in GLOB.player_list)
		if(A.stat != DEAD)
			return FALSE

/datum/round_event/ghost_role/alien_infestation
	announce_when = 400

	minimum_required = 1
	role_name = "异形幼虫"

	// 50% chance of being incremented by one
	var/spawncount = 1
	fakeable = TRUE


/datum/round_event/ghost_role/alien_infestation/setup()
	announce_when = rand(announce_when, announce_when + 50)
	if(prob(50))
		spawncount++

/datum/round_event/ghost_role/alien_infestation/announce(fake)
	var/living_aliens = FALSE
	for(var/mob/living/carbon/alien/A in GLOB.player_list)
		if(A.stat != DEAD)
			living_aliens = TRUE

	if(living_aliens || fake)
		priority_announce("检测到不明生命体正在进入[station_name()]。请封锁所有外部通道，包括管道和通风系统。", "生命信号警报", ANNOUNCER_ALIENS)


/datum/round_event/ghost_role/alien_infestation/spawn_role()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/atmospherics/components/unary/vent_pump))
		if(QDELETED(temp_vent))
			continue
		if(is_station_level(temp_vent.loc.z) && !temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(!temp_vent_parent)
				continue//no parent vent
			//Stops Aliens getting stuck in small networks.
			//See: Security, Virology
			if(temp_vent_parent.other_atmos_machines.len > 20)
				vents += temp_vent

	if(!vents.len)
		message_admins("某事件试图生成异形，但未找到合适的通风口，正在中止。")
		return MAP_ERROR

	var/list/candidates = SSpolling.poll_ghost_candidates(check_jobban = ROLE_ALIEN, role = ROLE_ALIEN, alert_pic = /mob/living/carbon/alien/larva, role_name_text = role_name)

	if(!length(candidates))
		return NOT_ENOUGH_PLAYERS

	while(spawncount > 0 && vents.len && candidates.len)
		var/obj/vent = pick_n_take(vents)
		var/mob/dead/observer/selected = pick_n_take(candidates)
		var/mob/living/carbon/alien/larva/new_xeno = new(vent.loc)
		new_xeno.PossessByPlayer(selected.key)
		new_xeno.move_into_vent(vent)

		spawncount--
		message_admins("[ADMIN_LOOKUPFLW(new_xeno)] 因事件被转化为异形。")
		new_xeno.log_message("因事件被生成为异形。", LOG_GAME)
		spawned_mobs += new_xeno

	return SUCCESSFUL_SPAWN
