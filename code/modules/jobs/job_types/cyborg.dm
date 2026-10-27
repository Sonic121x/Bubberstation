/datum/job/cyborg
	title = JOB_CYBORG
	description = "协助船员，遵守你的法则，服从你的人工智能。"
	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON
	faction = FACTION_STATION
	total_positions = 3	// SKYRAT EDIT: Original value (0)
	spawn_positions = 3
	supervisors = "你的法则与人工智能" //Nodrak
	spawn_type = /mob/living/silicon/robot
	minimal_player_age = 21
	exp_requirements = 120
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "CYBORG"

	display_order = JOB_DISPLAY_ORDER_CYBORG

	departments_list = list(
		/datum/job_department/silicon,
		)
	random_spawns_possible = FALSE
	job_flags = JOB_NEW_PLAYER_JOINABLE | JOB_EQUIP_RANK | JOB_CANNOT_OPEN_SLOTS


/datum/job/cyborg/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(!iscyborg(spawned))
		return
	var/mob/living/silicon/robot/robot_spawn = spawned
	if(player_client)
		robot_spawn.set_gender(player_client)
	//SKYRAT EDIT START
	robot_spawn.set_connected_ai(select_priority_ai())
	if(robot_spawn.connected_ai)
		log_combat(robot_spawn.connected_ai, robot_spawn, "将半机械人 [robot_spawn] 同步至 [robot_spawn.connected_ai]（半机械人出生同步）") // BUBBER EDIT - PUBLIC LOGS AND CLEANUP
		if(robot_spawn.shell) //somehow?
			robot_spawn.undeploy()
			robot_spawn.notify_ai(AI_NOTIFICATION_AI_SHELL)
		else
			robot_spawn.notify_ai(TRUE)
		robot_spawn.visible_message(span_notice("[robot_spawn] 发出轻柔的提示音。"), span_notice("法则同步协议已启动。"))
		robot_spawn.lawupdate = TRUE
		robot_spawn.lawsync()
		robot_spawn.show_laws()
		if(HAS_TRAIT(SSstation, STATION_TRAIT_HOS_AI))
			robot_spawn.visible_message(self_message = span_alert("本班次已启用安保半机械人。"))
	//SKYRAT EDIT END
	if(!robot_spawn.connected_ai) // Only log if there's no Master AI
		robot_spawn.log_current_laws()

	// cyborgs can late spawn in some strange circumstances
	if(SSticker.current_state != GAME_STATE_SETTING_UP)
		robot_spawn.notify_ai(AI_NOTIFICATION_NEW_BORG)

/datum/job/cyborg/get_radio_information()
	return "<b>在消息前加上 :b 即可与其他半机械人和人工智能通话。</b>"

/datum/job/cyborg/on_respawn(mob/new_character)
	new_character.Robotize(TRUE)

/datum/job/cyborg/get_lobby_icon()
	return icon('icons/mob/huds/hud.dmi', "hudcyborg")
