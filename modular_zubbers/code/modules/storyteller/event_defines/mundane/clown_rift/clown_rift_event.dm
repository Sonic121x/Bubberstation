/datum/round_event_control/clown_rift
	name = "小丑裂隙"
	category = EVENT_CATEGORY_JANITORIAL
	description = "撕开一道裂隙，从里面抛出一堆乱七八糟的小丑物品"
	typepath = /datum/round_event/clown_rift
	track = EVENT_TRACK_MUNDANE
	tags = list(TAG_CLOWN, TAG_NEUTRAL)
	admin_setup = list(/datum/event_admin_setup/set_location/clown_rift)

	weight = 50
	max_occurrences = 5

/datum/round_event/clown_rift
	announce_when = 20 EVENT_SECONDS
	start_when = 2 EVENT_SECONDS
	var/area/impact_area
	var/obj/effect/clown_rift/rift
	/// Admin selected location
	var/turf/impact_turf

/datum/round_event/clown_rift/setup()
	if(impact_turf)
		impact_area = get_area(impact_turf)
	else
		impact_area = find_area()
		impact_turf = get_valid_turf(impact_area)

/datum/round_event/clown_rift/start()
	rift = new /obj/effect/clown_rift(impact_turf)
	announce_to_ghosts(rift)

/datum/round_event/clown_rift/announce(fake)
	priority_announce("在 [chinese_area_display(impact_area.name)] 检测到小丑能量冲击")

/datum/round_event/clown_rift/proc/find_area()
	var/static/list/allowed_areas
	if(isnull(allowed_areas))
		var/static/list/safe_area_types = typecacheof(list(
			/area/station/ai/satellite/chamber,
			/area/station/ai/upload/chamber,
			/area/station/science/ordnance/bomb,
			/area/station/solars,
			/area/station/maintenance,
		))
		allowed_areas = make_associative(GLOB.the_station_areas) - safe_area_types
	var/list/possible_areas = typecache_filter_list(GLOB.areas, allowed_areas)
	if (length(possible_areas))
		return pick(possible_areas)

/datum/round_event/clown_rift/proc/get_valid_turf(target_area)
	var/list/possible_turfs = list()
	for(var/turf/possible_turf as anything in get_area_turfs(target_area))
		if (isspaceturf(possible_turf))
			continue
		if (possible_turf.is_blocked_turf(exclude_mobs = TRUE))
			continue
		if (islava(possible_turf))
			continue
		if (ischasm(possible_turf))
			continue
		possible_turfs += possible_turf

	return pick(possible_turfs)

/datum/event_admin_setup/set_location/clown_rift
	input_text = "在你当前所在的区域生成裂隙？"

/datum/event_admin_setup/set_location/clown_rift/apply_to_event(datum/round_event/clown_rift/event)
	event.impact_turf = chosen_turf


