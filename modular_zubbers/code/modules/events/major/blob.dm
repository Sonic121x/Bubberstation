/datum/round_event_control/blob
	name = "变形菌"
	typepath = /datum/round_event/ghost_role/blob
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE, TAG_COMBAT, TAG_CHAOTIC)
	weight = 10
	max_occurrences = 1
	min_players = 35
	category = EVENT_CATEGORY_ENTITIES
	description = "生成一个新的变形菌主脑。"

/datum/round_event_control/blob/can_spawn_event(players, allow_magic = FALSE)
	if(EMERGENCY_PAST_POINT_OF_NO_RETURN) // no blobs if the shuttle is past the point of no return
		return FALSE
	return ..()

/datum/round_event/ghost_role/blob
	announce_chance = 0
	role_name = "变形菌主脑"
	fakeable = TRUE

/datum/round_event/ghost_role/blob/announce(fake)
	if(!fake)
		return //the mob itself handles this.
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(lose_some_weight_lardass)), rand(2 MINUTES, 4 MINUTES))
	priority_announce("确认 [station_name()] 上爆发五级生物危害。全体人员必须控制住此次爆发。", "生物危害警报", ANNOUNCER_OUTBREAK5)

/datum/dynamic_ruleset/midround/from_ghosts/blob/false_alarm()
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(lose_some_weight_lardass)), rand(2 MINUTES, 4 MINUTES))

/datum/round_event/ghost_role/blob/spawn_role()
	if(!GLOB.blobstart.len)
		return MAP_ERROR
	var/icon/blob_icon = icon('icons/mob/nonhuman-player/blob.dmi', icon_state = "blob_core")
	blob_icon.Blend("#9ACD32", ICON_MULTIPLY)
	blob_icon.Blend(icon('icons/mob/nonhuman-player/blob.dmi', "blob_core_overlay"), ICON_OVERLAY)
	var/image/blob_image = image(blob_icon)
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(check_jobban = ROLE_BLOB, role = ROLE_BLOB, alert_pic = blob_image, role_name_text = role_name, amount_to_pick = 1, chat_text_border_icon = blob_image)
	if(isnull(chosen_one))
		return NOT_ENOUGH_PLAYERS
	var/mob/dead/observer/new_blob = chosen_one
	var/mob/eye/blob/BC = new_blob.become_overmind()
	spawned_mobs += BC
	message_admins("[ADMIN_LOOKUPFLW(BC)] 因事件被转化为变形菌主脑。")
	BC.log_message("因事件被生成为变形菌主脑。", LOG_GAME)
	return SUCCESSFUL_SPAWN

/proc/lose_some_weight_lardass()
	var/unlucky_victim = "你妈" //debug text that should never trigger but should tell coders that something went wrong without breaking immersion
	var/unlucky_victim_fatty_score = 0
	//Get the fattest person
	for(var/mob/living/carbon/human/possible_fatty as anything in GLOB.human_list)

		if(!possible_fatty.mind)
			continue

		if(possible_fatty.stat == DEAD)
			continue //Too mean

		if(possible_fatty.name != possible_fatty.real_name)
			continue //Not possible to pick up on sensors.

		var/turf/possible_fatty_turf = get_turf(possible_fatty)

		if(!possible_fatty_turf || !is_station_level(possible_fatty_turf.z))
			continue

		var/possible_fatty_score = possible_fatty.nutrition
		if(possible_fatty.has_quirk(/datum/quirk/overweight))
			possible_fatty_score = possible_fatty_score * 1.5 + 1000

		if(possible_fatty_score > unlucky_victim_fatty_score)
			unlucky_victim = "[possible_fatty]" //We don't use .name here because we want "The" to be affixed to it if needed.
			unlucky_victim_fatty_score = possible_fatty_score

	priority_announce(
		"经确认，[station_name()]上的五级生物危害警报为误报，我们的传感器似乎将[unlucky_victim]误判为了五级生物危害。 \
		根据纳米传讯安全健康饮食计划，提醒全体船员养成健康的饮食习惯。",
		"生物危害警报"
	)
