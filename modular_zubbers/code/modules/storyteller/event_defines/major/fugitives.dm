#define TEAM_BACKSTORY_SIZE 4

/datum/round_event_control/fugitives
	name = "生成逃犯"
	typepath = /datum/round_event/ghost_role/fugitives
	track = EVENT_TRACK_MAJOR
	tags = list(TAG_COMBAT)
	max_occurrences = 1
	min_players = 20
	earliest_start = 30 MINUTES //deadchat sink, lets not even consider it early on.
	category = EVENT_CATEGORY_INVASION
	description = "逃犯会躲藏在空间站上，随后会有猎人追来。"
	map_flags = EVENT_SPACE_ONLY

/datum/round_event/ghost_role/fugitives
	minimum_required = 1
	role_name = "逃犯"
	fakeable = FALSE

/datum/round_event/ghost_role/fugitives/spawn_role()
	var/turf/landing_turf = find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = FALSE)
	if(isnull(landing_turf))
		return MAP_ERROR
	var/list/possible_backstories = list()
	var/list/candidates = SSpolling.poll_ghost_candidates(check_jobban = ROLE_FUGITIVE, role = ROLE_FUGITIVE, alert_pic = /obj/item/card/id/advanced/prisoner, jump_target = landing_turf)

	if(!length(candidates))
		return NOT_ENOUGH_PLAYERS

	if(length(candidates) < TEAM_BACKSTORY_SIZE || prob(30 - (length(candidates) * 2))) //Solo backstories are always considered if a larger backstory cannot be filled out. Otherwise, it's a rare chance that gets rarer if more people sign up.
		possible_backstories += list(FUGITIVE_BACKSTORY_WALDO, FUGITIVE_BACKSTORY_INVISIBLE) //less common as it comes with magicks and is kind of immershun shattering

	if(length(candidates) >= TEAM_BACKSTORY_SIZE)//group refugees
		possible_backstories += list(FUGITIVE_BACKSTORY_PRISONER, FUGITIVE_BACKSTORY_CULTIST, FUGITIVE_BACKSTORY_SYNTH)

	var/backstory = pick(possible_backstories)
	var/member_size = 3
	var/leader
	switch(backstory)
		if(FUGITIVE_BACKSTORY_SYNTH)
			leader = pick_n_take(candidates)
		if(FUGITIVE_BACKSTORY_WALDO, FUGITIVE_BACKSTORY_INVISIBLE)
			member_size = 0 //solo refugees have no leader so the member_size gets bumped to one a bit later
	var/list/members = list()
	var/list/spawned_mobs = list()
	if(isnull(leader))
		member_size++ //if there is no leader role, then the would be leader is a normal member of the team.

	for(var/i in 1 to member_size)
		members += pick_n_take(candidates)

	for(var/mob/dead/selected in members)
		var/mob/living/carbon/human/S = gear_fugitive(selected, landing_turf, backstory)
		spawned_mobs += S
	if(!isnull(leader))
		gear_fugitive_leader(leader, landing_turf, backstory)

	//after spawning
	playsound(src, 'sound/items/weapons/emitter.ogg', 50, TRUE)
	new /obj/item/storage/toolbox/mechanical(landing_turf) //so they can actually escape maint
	var/hunter_backstory = pick(
		HUNTER_PACK_COPS,
		HUNTER_PACK_RUSSIAN,
		HUNTER_PACK_BOUNTY,
		HUNTER_PACK_PSYKER,
		HUNTER_PACK_MI13,
	)
	addtimer(CALLBACK(src, PROC_REF(check_spawn_hunters), hunter_backstory, 10 MINUTES), 1 MINUTES)
	role_name = "逃犯猎人"
	return SUCCESSFUL_SPAWN

/datum/round_event/ghost_role/fugitives/proc/gear_fugitive(mob/dead/selected, turf/landing_turf, backstory) //spawns normal fugitive
	var/datum/mind/player_mind = new /datum/mind(selected.key)
	player_mind.active = TRUE
	var/mob/living/carbon/human/S = new(landing_turf)
	player_mind.transfer_to(S)
	player_mind.set_assigned_role(SSjob.get_job_type(/datum/job/fugitive))
	player_mind.add_antag_datum(/datum/antagonist/fugitive)
	var/datum/antagonist/fugitive/fugitiveantag = player_mind.has_antag_datum(/datum/antagonist/fugitive)
	fugitiveantag.greet(backstory)

	switch(backstory)
		if(FUGITIVE_BACKSTORY_PRISONER)
			S.equipOutfit(/datum/outfit/prisoner)
		if(FUGITIVE_BACKSTORY_CULTIST)
			S.equipOutfit(/datum/outfit/yalp_cultist)
		if(FUGITIVE_BACKSTORY_WALDO)
			S.equipOutfit(/datum/outfit/waldo)
		if(FUGITIVE_BACKSTORY_SYNTH)
			S.equipOutfit(/datum/outfit/synthetic)
		if(FUGITIVE_BACKSTORY_INVISIBLE)
			S.equipOutfit(/datum/outfit/invisible_man)
	message_admins("[ADMIN_LOOKUPFLW(S)] 因事件被转化为逃犯。")
	S.log_message("因事件被生成为逃犯。", LOG_GAME)
	spawned_mobs += S
	return S

///special spawn for one member. it can be used for a special mob or simply to give one normal member special items.
/datum/round_event/ghost_role/fugitives/proc/gear_fugitive_leader(mob/dead/leader, turf/landing_turf, backstory)
	var/datum/mind/player_mind = new /datum/mind(leader.key)
	player_mind.active = TRUE
	//if you want to add a fugitive with a special leader in the future, make this switch with the backstory
	var/mob/living/carbon/human/S = gear_fugitive(leader, landing_turf, backstory)
	var/obj/item/choice_beacon/augments/A = new(landing_turf)
	S.put_in_hands(A)
	new /obj/item/autosurgeon(landing_turf)

/datum/round_event/ghost_role/fugitives/proc/check_spawn_hunters(backstory, remaining_time)
	//if the emergency shuttle has been called, spawn hunters now to give them a chance
	if(remaining_time == 0 || !EMERGENCY_IDLE_OR_RECALLED)
		spawn_hunters(backstory)
		return
	addtimer(CALLBACK(src, PROC_REF(check_spawn_hunters), backstory, remaining_time - 1 MINUTES), 1 MINUTES)

/datum/round_event/ghost_role/fugitives/proc/spawn_hunters(backstory)
	var/list/candidates = SSpolling.poll_ghost_candidates("你愿意被考虑加入[span_notice(backstory)]吗？", check_jobban = ROLE_FUGITIVE_HUNTER, alert_pic = /obj/machinery/sleeper, role_name_text = backstory)
	shuffle_inplace(candidates)

	var/datum/map_template/shuttle/hunter/ship
	switch(backstory)
		if(HUNTER_PACK_COPS)
			ship = new /datum/map_template/shuttle/hunter/space_cop
		if(HUNTER_PACK_RUSSIAN)
			ship = new /datum/map_template/shuttle/hunter/russian
		if(HUNTER_PACK_BOUNTY)
			ship = new /datum/map_template/shuttle/hunter/bounty
		if(HUNTER_PACK_PSYKER)
			ship = new /datum/map_template/shuttle/hunter/psyker
		if(HUNTER_PACK_MI13)
			ship = new/datum/map_template/shuttle/hunter/mi13_foodtruck

	var/x = rand(TRANSITIONEDGE,world.maxx - TRANSITIONEDGE - ship.width)
	var/y = rand(TRANSITIONEDGE,world.maxy - TRANSITIONEDGE - ship.height)
	var/z = SSmapping.empty_space.z_value
	var/turf/placement_turf = locate(x,y,z)
	if(!placement_turf)
		CRASH("Fugitive Hunters (Created from fugitive event) found no turf to load in")
	if(!ship.load(placement_turf))
		CRASH("Loading [backstory] ship failed!")

	for(var/turf/shuttle_turf in ship.get_affected_turfs(placement_turf))
		for(var/obj/effect/mob_spawn/ghost_role/human/fugitive/spawner in shuttle_turf)
			if(length(candidates))
				var/mob/our_candidate = candidates[1]
				var/mob/spawned_mob = spawner.create_from_ghost(our_candidate)
				candidates -= our_candidate
				notify_ghosts(
					"[spawner.prompt_name] 已苏醒：[spawned_mob]！",
					source = spawned_mob,
					header = "快来看！",
				)
			else
				notify_ghosts(
					"[spawner.prompt_name] 生成器已创建！",
					source = spawner,
					header = "在此生成！",
				)

	var/list/announcement_text_list = list()
	var/announcement_title = ""
	switch(backstory)
		if(HUNTER_PACK_COPS)
			announcement_text_list += "注意，[GLOB.station_name] 的全体船员，这里是警察。据报有一名通缉犯躲藏在你们的空间站上。"
			announcement_text_list += "我们持有顺旋星际联盟当局签发的逮捕令，要将此人收押。警员已派往你们所在的位置。"
			announcement_text_list += "我们要求你们配合，将此罪犯绳之以法。"
			announcement_title += "太空警察指挥部"
		if(HUNTER_PACK_RUSSIAN)
			announcement_text_list += "祝你们健康，[GLOB.station_name] 的船员们。我们正前往你们的空间站。"
			announcement_text_list += "船上有一名罪犯。我们会逮捕他们，把他们送回古拉格。这很好，对吧？"
			announcement_title += "俄罗斯货船"
		if(HUNTER_PACK_BOUNTY)
			announcement_text_list += "[GLOB.station_name]。我们的一个赏金目标跑到了你们的空间站上。我们很快就会抵达并把他带走。"
			announcement_text_list += "速战速决吧。不想惹麻烦，就给我滚远点。"
			announcement_title += "未注册信号"
		if(HUNTER_PACK_PSYKER)
			announcement_text_list += "喂，能听见我们吗？我们要来你们的空间站了。下面有个坏蛋，特别坏的坏蛋。我们得逮捕他们。"
			announcement_text_list += "如果你们有愿意付钱的顾客，我们也会在前门提供算命服务。"
			announcement_title += "算命娱乐穿梭机"
		if(HUNTER_PACK_MI13)
			announcement_text_list += "船员监控网络检测到非法入侵。中央指挥部已获悉此事。"
			announcement_text_list += "请向当地安保小队报告任何可疑人员或行为。"
			announcement_title += "纳米传讯入侵反制电子系统"
	if(!length(announcement_text_list))
		announcement_text_list += "在空间站附近检测到不明船只。"
		stack_trace("Fugitive hunter announcement was unable to generate an announcement text based on backstory: [backstory]")

	if(!length(announcement_title))
		announcement_title += "未知信号"
		stack_trace("Fugitive hunter announcement was unable to generate an announcement title based on backstory: [backstory]")

	priority_announce(jointext(announcement_text_list, " "), announcement_title)

#undef TEAM_BACKSTORY_SIZE
