/datum/round_event_control/space_dragon
	name = "生成太空龙"
	typepath = /datum/round_event/ghost_role/space_dragon
	weight = 2
	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT, TAG_CHAOTIC)
	max_occurrences = 1
	min_players = 20
	category = EVENT_CATEGORY_ENTITIES
	description = "生成一条太空龙，它会试图占领空间站。"
	min_wizard_trigger_potency = 6
	max_wizard_trigger_potency = 7

/datum/round_event/ghost_role/space_dragon
	minimum_required = 1
	role_name = "太空龙"
	announce_when = 10

/datum/round_event/ghost_role/space_dragon/announce(fake)
	priority_announce("[station_name()]附近检测到强烈的生物能量波动，请保持警戒。", "生命信号警报")

/datum/round_event/ghost_role/space_dragon/spawn_role()
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(check_jobban = ROLE_SPACE_DRAGON, role = ROLE_SPACE_DRAGON, alert_pic = /mob/living/basic/space_dragon, amount_to_pick = 1)
	if(isnull(chosen_one))
		return NOT_ENOUGH_PLAYERS
	var/spawn_location = find_space_spawn()
	if(isnull(spawn_location))
		return MAP_ERROR
	var/mob/living/basic/space_dragon/dragon = new(spawn_location)
	dragon.PossessByPlayer(chosen_one.key)
	dragon.mind.add_antag_datum(/datum/antagonist/space_dragon)
	playsound(dragon, 'sound/effects/magic/ethereal_exit.ogg', 50, TRUE, -1)
	message_admins("[ADMIN_LOOKUPFLW(dragon)] 因事件被转化为太空龙。")
	dragon.log_message("因事件被生成为太空龙。", LOG_GAME)
	spawned_mobs += dragon
	return SUCCESSFUL_SPAWN
