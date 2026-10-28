/// Similar to space carp event
/// Has the exact same announcement to mess with the meta of telling it's carps.
/// Dolphins and Manatees however don't path to station, so they will just float harmlessly
/// in the surrounding space
/datum/round_event_control/dolphin_migration
	name = "海豚迁徙"
	typepath = /datum/round_event/dolphin_migration
	min_players = 0 // Neutral mobs, no destruction, just spawn whenever
	earliest_start = 10 MINUTES
	max_occurrences = 6
	category = EVENT_CATEGORY_ENTITIES
	description = "在空间站周围召唤一群无害的太空海豚。"
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 3

	weight = 5
	track = EVENT_TRACK_MUNDANE
	tags = list(TAG_SPACE, TAG_NEUTRAL)

/datum/round_event/dolphin_migration
	announce_when = 3
	start_when = 50
	/// Most common mob type to spawn
	var/dolphin_type = /mob/living/basic/dolphin
	/// Rarer mob type to spawn
	var/boss_type = /mob/living/basic/dolphin/manatee
	/// What to describe detecting near the station
	var/fluff_signal = /datum/round_event/carp_migration::fluff_signal // Steal directly from the carp event

/datum/round_event/dolphin_migration/announce(fake)
	priority_announce("在 [station_name()] 附近检测到[fluff_signal]，请待命。", "生命信号警报")

/datum/round_event/dolphin_migration/start()
	for(var/obj/effect/landmark/carpspawn/spawn_point in GLOB.landmarks_list)
		if(prob(95))
			new dolphin_type(spawn_point.loc)
		else
			new boss_type(spawn_point.loc)
