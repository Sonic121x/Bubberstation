/datum/round_event_control/vent_clog/extreme
	name = "通风管堵塞：极端"
	typepath = /datum/round_event/vent_clog/extreme
	weight = 14
	min_players = 23
	max_occurrences = 6
	earliest_start = 25 MINUTES
	description = "极度危险的生物从通风口中爬出。"
	min_wizard_trigger_potency = 3
	max_wizard_trigger_potency = 6
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_NPC_ANTAG)
	track = EVENT_TRACK_MODERATE

/datum/round_event/vent_clog/extreme/setup()
	. = ..()
	spawn_delay = rand(15,25)
	maximum_spawns = rand(4, 6)
	filth_spawn_types = list(
		/obj/effect/decal/cleanable/blood,
		/obj/effect/decal/cleanable/blood/splatter,
	)

/datum/round_event/vent_clog/extreme/announce(fake)
	var/area/event_area = fake ? pick(GLOB.teleportlocs) : get_area_name(vent)
	priority_announce("在[event_area]的通风网络中检测到极度危险的生命体征。", "安保警报", color_override = "yellow")

/datum/round_event/vent_clog/extreme/get_mob()
	var/static/list/mob_list = list(
		/mob/living/basic/cockroach/glockroach/mobroach,
		/mob/living/basic/bear,
		/mob/living/basic/slime/random,
		/mob/living/basic/mining/cazador,
		/mob/living/basic/mining/scorpion,
	)
	return pick(mob_list)
