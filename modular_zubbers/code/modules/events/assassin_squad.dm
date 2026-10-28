/datum/round_event_control/syndicate_assassination_attempt
	name = "辛迪加暗杀行动"
	typepath = /datum/round_event/syndicate_assassination_attempt
	weight = 16
	min_players = 30
	max_occurrences = 4
	earliest_start = 40 MINUTES
	description = "辛迪加打手乘空投舱出现，袭击被选中的玩家。"
	tags = list(TAG_COMBAT, TAG_NPC_ANTAG)
	track = EVENT_TRACK_MODERATE

/datum/round_event_control/syndicate_assassination_attempt/can_spawn_event(players_amt, allow_magic = FALSE)
	. = ..(players_amt, allow_magic)
	if(!.)
		return
	if(isnull(find_victim()))
		return FALSE
	return TRUE

/datum/round_event_control/syndicate_assassination_attempt/proc/find_victim()
	var/list/candidates = list()
	var/area/area_type
	for(var/mob/player as anything in GLOB.player_list)
		if(player.has_faction(ROLE_SYNDICATE) || player.has_faction(ROLE_SYNDICATE_INFILTRATOR) || player.has_faction(ROLE_LONE_OPERATIVE) || player.has_faction(ROLE_OPERATIVE) || player.has_faction(ROLE_TRAITOR))
			continue
		area_type = get_area(player)
		if(is_type_in_list(area_type, GLOB.expected_erp_areas))
			continue
		if(!is_station_level(player.z))
			continue
		if(isdead(player))
			continue
		if(!ishuman(player))
			continue
		candidates += player

	if(length(candidates) > 0)
		return pick(candidates)
	return null

///Spawns a cargo pod containing a random cargo supply pack on a random area of the station
/datum/round_event/syndicate_assassination_attempt
	var/mob/victim ///Randomly picked player
	announce_chance = 100
	///types of syndies to send in
	var/list/potential_assassins = list(
		/mob/living/basic/trooper/syndicate/melee,\
		/mob/living/basic/trooper/syndicate/melee/sword/space, \
		/mob/living/basic/trooper/syndicate/melee/sword/space/stormtrooper,\
		/mob/living/basic/trooper/syndicate/ranged, \
		/mob/living/basic/trooper/syndicate/ranged/smg, \
		/mob/living/basic/trooper/syndicate/ranged/shotgun/space, \
	)
	///how many syndies to send in
	var/spawn_number = 5

/datum/round_event/syndicate_assassination_attempt/announce(fake)
	if(fake)
		victim = pick_fake_victim()
	priority_announce(get_announce_text(victim), "辛迪加", 'sound/announcer/announcement/announce_syndi.ogg', ANNOUNCEMENT_TYPE_SYNDICATE, has_important_message = TRUE, color_override = "red")

/datum/round_event/syndicate_assassination_attempt/proc/pick_fake_victim()
	var/list/candidates = list()
	var/area/area_type
	for(var/mob/player as anything in GLOB.player_list)
		area_type = get_area(player)
		if(is_type_in_list(area_type, GLOB.expected_erp_areas))
			continue
		if(!is_station_level(player.z))
			continue
		if(isdead(player))
			continue
		if(!ishuman(player))
			continue
		candidates += player

	return pick(candidates)

/datum/round_event/syndicate_assassination_attempt/proc/get_announce_text(victim)
	var/list/potential_text = list( \
		"亲爱的[victim]，数数你还剩多少日子吧，因为所剩无几了。你已被列入死亡名单，我们是来收账的。",\
		"你好啊，纳米传讯的渣滓。我们是来谋杀[victim]的。服从，否则就去死。",\
		"咚咚咚，是辛迪加在说话！我们手上有针对[victim]的处决令。开门。",\
		"[victim]还活着；我们很快会赶到纠正这一点。",\
		"我们正派出一支冷酷小队直奔[victim]。30 分钟内解决，超时免费。",\
	)
	return pick(potential_text)

/datum/round_event/syndicate_assassination_attempt/setup()
	start_when = rand(20, 40)
	var/datum/round_event_control/syndicate_assassination_attempt/assassin_control = control
	victim = assassin_control.find_victim()
	if(isnull(victim))
		CRASH("No valid candidates for assassination found.")

///Spawns a random supply pack, puts it in a pod, and spawns it on a random tile of the selected area
/datum/round_event/syndicate_assassination_attempt/start()
	var/obj/structure/closet/supplypod/pod = make_pod()
	fill_pod(pod)
	var/turf/landing_zone = get_turf(victim)

	new /obj/effect/pod_landingzone (landing_zone, pod)

	alert_ghosts(victim)

/datum/round_event/syndicate_assassination_attempt/proc/alert_ghosts(mob/victim)
	notify_ghosts("[victim.name]正遭到辛迪加袭击！", source = victim, header = "暗杀进行中")

/datum/round_event/syndicate_assassination_attempt/proc/get_blacklisted_areas()
	return GLOB.expected_erp_areas.Copy()

///Handles the creation of the pod, in case it needs to be modified beforehand
/datum/round_event/syndicate_assassination_attempt/proc/make_pod()
	var/obj/structure/closet/supplypod/pod = new
	pod.set_style(/datum/pod_style/syndicate)
	pod.explosionSize = list(0,0,0,1)
	pod.delays[POD_TRANSIT] = 3
	return pod

///Puts entities in the pod
/datum/round_event/syndicate_assassination_attempt/proc/fill_pod(obj/structure/closet/supplypod)
	var/spawntype
	for(var/i = 0; i < spawn_number; i ++)
		spawntype = pick(potential_assassins)
		new spawntype(supplypod)

///////////////////////////////////////////////////
///////////////////// Hammers /////////////////////
///////////////////////////////////////////////////

/datum/round_event_control/syndicate_assassination_attempt/kill_this_guy_with_hammers
	name = "用锤子干掉这家伙"
	typepath = /datum/round_event/syndicate_assassination_attempt/hammers
	weight = 1
	max_occurrences = 1
	min_players = 30
	earliest_start = 40 MINUTES
	description = "辛迪加打手乘空投舱出现，手持锤子袭击被选中的玩家。"
	tags = list(TAG_COMBAT, TAG_NPC_ANTAG)
	track = EVENT_TRACK_MODERATE

/datum/round_event/syndicate_assassination_attempt/hammers
	potential_assassins = list(
		/mob/living/basic/trooper/syndicate/melee/hammer,\
	)
	spawn_number = 8

/datum/round_event/syndicate_assassination_attempt/hammers/get_announce_text(victim)
	return "我们要用锤子干掉[victim]。这是一个威胁。"

/mob/living/basic/trooper/syndicate/melee/hammer
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "用锤猛砸"
	attack_verb_simple = "用锤砸"
	attack_sound = 'sound/items/weapons/sonic_jackhammer.ogg'
	armour_penetration = 35
	r_hand = /obj/item/melee/breaching_hammer
