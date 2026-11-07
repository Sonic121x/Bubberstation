/datum/round_event_control/slaughter
	name = "生成屠戮恶魔"
	typepath = /datum/round_event/ghost_role/slaughter
	weight = 0
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMBAT, TAG_CHAOTIC)
	max_occurrences = 0
	earliest_start = 1 HOURS
	min_players = 20
	category = EVENT_CATEGORY_ENTITIES
	description = "生成一只屠戮恶魔，它可借血泊穿梭进行猎杀。"
	min_wizard_trigger_potency = 6
	max_wizard_trigger_potency = 7

/datum/round_event/ghost_role/slaughter
	minimum_required = 1
	role_name = "屠戮恶魔"

/datum/round_event/ghost_role/slaughter/spawn_role()
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(check_jobban = ROLE_ALIEN, role = ROLE_ALIEN, alert_pic = /mob/living/basic/demon/slaughter, role_name_text = role_name, amount_to_pick = 1)
	if(isnull(chosen_one))
		return NOT_ENOUGH_PLAYERS
	var/datum/mind/player_mind = new /datum/mind(chosen_one.key)
	player_mind.active = TRUE

	var/spawn_location = find_space_spawn()
	if(!spawn_location)
		return MAP_ERROR //This sends an error message further up.
	var/mob/living/basic/demon/slaughter/spawned = new(spawn_location)
	new /obj/effect/dummy/phased_mob(spawn_location, spawned)

	player_mind.transfer_to(spawned)

	message_admins("[ADMIN_LOOKUPFLW(spawned)] 因事件被转化为屠戮恶魔。")
	spawned.log_message("因事件被生成为屠戮恶魔。", LOG_GAME)
	spawned_mobs += spawned
	return SUCCESSFUL_SPAWN
