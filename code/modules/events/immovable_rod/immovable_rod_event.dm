/// Immovable rod random event.
/// The rod will spawn at some location outside the station, and travel in a straight line to the opposite side of the station
/datum/round_event_control/immovable_rod
	name = "不可移动之杆"
	typepath = /datum/round_event/immovable_rod
	min_players = 15
	max_occurrences = 5
	category = EVENT_CATEGORY_SPACE
	description = "空间站穿过了一根不可移动之杆。"
	min_wizard_trigger_potency = 6
	max_wizard_trigger_potency = 7
	admin_setup = list(/datum/event_admin_setup/set_location/immovable_rod, /datum/event_admin_setup/question/immovable_rod)

/datum/round_event/immovable_rod
	announce_when = 5
	/// Admins can pick a spot the rod will aim for.
	var/atom/special_target
	/// Admins can also force it to loop around forever, or at least until the RD gets their hands on it.
	var/force_looping = FALSE

/datum/round_event/immovable_rod/announce(fake)
	priority_announce("刚才那到底是什么鬼东西？！", "全面警报")

/datum/round_event/immovable_rod/start()
	var/startside = pick(GLOB.cardinals)
	var/turf/end_turf = get_edge_target_turf(get_random_station_turf(), REVERSE_DIR(startside))
	var/turf/start_turf = spaceDebrisStartLoc(startside, end_turf.z)
	var/atom/rod = new /obj/effect/immovablerod(start_turf, end_turf, special_target, force_looping)
	announce_to_ghosts(rod)

/// Admins can pick a spot the rod will aim for
/datum/event_admin_setup/set_location/immovable_rod
	input_text = "瞄准当前位置？"

/datum/event_admin_setup/set_location/immovable_rod/apply_to_event(datum/round_event/immovable_rod/event)
	event.special_target = chosen_turf

/// Admins can also force it to loop around forever, or at least until the RD gets their hands on it.
/datum/event_admin_setup/question/immovable_rod
	input_text = "你希望这根杆在太空的各个 Z 层之间强制循环穿梭吗？"

/datum/event_admin_setup/question/immovable_rod/apply_to_event(datum/round_event/immovable_rod/event)
	event.force_looping = chosen
	var/log_message = "[key_name_admin(usr)] 已将一根不可移动之杆[event.force_looping ? "（强制循环）" : ""]瞄准 [event.special_target ? AREACOORD(event.special_target) : "随机位置"]。"
	message_admins(log_message)
	log_admin(log_message)
