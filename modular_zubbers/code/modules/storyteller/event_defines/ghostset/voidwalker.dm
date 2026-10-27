// TG did not cook this antag into the event system. So I had to make my own

/datum/round_event_control/voidwalker
	name = "生成虚空行者"
	typepath = /datum/round_event/ghost_role/void_walker
	max_occurrences = 1
	weight = 5
	earliest_start = 20 MINUTES
	min_players = 25
	category = EVENT_CATEGORY_ENTITIES
	description = "一只会把人们拖出空间站、坠入深渊的虚空行者"
	map_flags = EVENT_SPACE_ONLY
	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_SPACE)
	track = EVENT_TRACK_GHOSTSET

/datum/round_event/ghost_role/void_walker
	fakeable = FALSE
	role_name = "虚空行者"

/datum/round_event/ghost_role/void_walker/spawn_role()
	var/spawn_location = find_space_spawn()
	if(isnull(spawn_location))
		return MAP_ERROR

	var/mob/chosen_one = SSpolling.poll_ghost_candidates(check_jobban = ROLE_VOIDWALKER, role = ROLE_VOIDWALKER, alert_pic = /obj/item/clothing/head/helmet/skull/cosmic, jump_target = spawn_location, role_name_text = "虚空行者", amount_to_pick = 1)
	if(isnull(chosen_one))
		return NOT_ENOUGH_PLAYERS
	var/datum/mind/player_mind = new /datum/mind(chosen_one.key)
	player_mind.active = TRUE

	var/mob/living/basic/voidwalker/walker = new (spawn_location)
	player_mind.transfer_to(walker)
	player_mind.set_assigned_role(SSjob.get_job_type(/datum/job/voidwalker))
	player_mind.add_antag_datum(/datum/antagonist/voidwalker)
	playsound(walker, 'sound/effects/magic/ethereal_exit.ogg', 50, TRUE, -1)
	message_admins("[ADMIN_LOOKUPFLW(walker)] 因回合中事件被转化为虚空行者。")
	walker.log_message("[key_name(walker)] 因事件被生成为虚空行者。", LOG_GAME)
	spawned_mobs += walker
	return SUCCESSFUL_SPAWN
