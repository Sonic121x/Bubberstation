/datum/round_event_control/portal_storm_lavaland
	name = "传送门风暴：熔岩地带"
	typepath = /datum/round_event/portal_storm/lavaland
	weight = 2
	min_players = 15
	earliest_start = 50 MINUTES
	category = EVENT_CATEGORY_ENTITIES
	description = "熔岩地带的生物从传送门中涌出。"
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_NPC_ANTAG)

/datum/round_event/portal_storm/lavaland
	boss_types = list(
		/mob/living/basic/mining/hivelord = 2,
		/mob/living/basic/mining/lobstrosity = 1,
		/mob/living/basic/mining/basilisk = 1
	)
	hostile_types = list(
		/mob/living/basic/mining/goliath = 3,
		/mob/living/basic/mining/brimdemon = 2,
		/mob/living/basic/mining/legion = 2,
		/mob/living/basic/mining/watcher = 3,
	)

/datum/round_event_control/portal_storm_icemoon
	name = "传送门风暴：冰月"
	typepath = /datum/round_event/portal_storm/icemoon
	weight = 2
	min_players = 30
	earliest_start = 50 MINUTES
	category = EVENT_CATEGORY_ENTITIES
	description = "冰月的生物从传送门中涌出。"
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_NPC_ANTAG)

/datum/round_event/portal_storm/icemoon
	boss_types = list(
		/mob/living/basic/mining/polarbear = 2,
	)
	hostile_types = list(
		/mob/living/basic/mining/ice_demon = 3,
		/mob/living/basic/mining/ice_whelp = 2,
		/mob/living/basic/mining/legion = 2,
		/mob/living/basic/mining/wolf = 5
	)

/datum/round_event_control/portal_storm_xen
	name = "传送门风暴：异星"
	typepath = /datum/round_event/portal_storm/xen
	weight = 2
	min_players = 30
	earliest_start = 50 MINUTES
	category = EVENT_CATEGORY_ENTITIES
	description = "异星的生物从传送门中涌出。"
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_NPC_ANTAG)

/datum/round_event/portal_storm/xen
	hostile_types = list(
		/mob/living/basic/blackmesa/xen/headcrab_zombie = 4,
		/mob/living/basic/blackmesa/xen/vortigaunt = 3,
		/mob/living/basic/blackmesa/xen/bullsquid = 2,
		/mob/living/basic/blackmesa/xen/houndeye = 2,
	)
