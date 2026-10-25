/datum/round_event_control/wisdomcow
	name = "智慧奶牛"
	typepath = /datum/round_event/wisdomcow
	max_occurrences = 1
	weight = 20
	category = EVENT_CATEGORY_FRIENDLY
	description = "一头奶牛出现，向你传授智慧箴言。"
	admin_setup = list(
		/datum/event_admin_setup/set_location/wisdom_cow,
		/datum/event_admin_setup/listed_options/wisdom_cow_wisdom,
		/datum/event_admin_setup/input_number/wisdom_cow,
		/datum/event_admin_setup/listed_options/wisdom_cow_milk,
	)

/datum/round_event/wisdomcow
	///Location override that, if set causes the cow to spawn in a pre-determined locaction instead of randomly.
	var/turf/spawn_location
	///An override that if set rigs the cow to spawn with a specific wisdow rather than a random one.
	var/selected_wisdom
	///An override that if set modifies the amount of wisdow the cow will add/remove, if not set will default to 500.
	var/selected_experience
	///An override that if set modifies what you can milk out of the cow
	var/datum/reagent/forced_reagent_type

/datum/round_event/wisdomcow/announce(fake)
	priority_announce("该区域发现了一头智慧奶牛。记得向她请教。", "纳米传讯奶牛养殖局")

/datum/round_event/wisdomcow/start()
	var/turf/targetloc
	if(spawn_location)
		targetloc = spawn_location
	else
		targetloc = get_safe_random_station_turf()
	var/mob/living/basic/cow/wisdom/wise = new(targetloc, selected_wisdom, selected_experience, forced_reagent_type)
	do_smoke(1, wise, targetloc)
	announce_to_ghosts(wise)

/datum/event_admin_setup/set_location/wisdom_cow
	input_text = "在当前地块生成？"

/datum/event_admin_setup/set_location/wisdom_cow/apply_to_event(datum/round_event/wisdomcow/event)
	event.spawn_location = chosen_turf

/datum/event_admin_setup/listed_options/wisdom_cow_wisdom
	input_text = "选择特定的智慧类型？"
	normal_run_option = "随机智慧"

/datum/event_admin_setup/listed_options/wisdom_cow_wisdom/get_list()
	return subtypesof(/datum/skill)

/datum/event_admin_setup/listed_options/wisdom_cow_wisdom/apply_to_event(datum/round_event/wisdomcow/event)
	event.selected_wisdom = chosen

/datum/event_admin_setup/input_number/wisdom_cow
	input_text = "这头奶牛应该给予多少经验？"
	default_value = 500
	max_value = 2500
	min_value = -2500

/datum/event_admin_setup/input_number/wisdom_cow/apply_to_event(datum/round_event/wisdomcow/event)
	event.selected_experience = chosen_value

/datum/event_admin_setup/listed_options/wisdom_cow_milk
	input_text = "选择一种乳汁？"
	normal_run_option = "随机试剂"

/datum/event_admin_setup/listed_options/wisdom_cow_milk/get_list()
	return sort_list(subtypesof(/datum/reagent), /proc/cmp_typepaths_asc)

/datum/event_admin_setup/listed_options/wisdom_cow_milk/apply_to_event(datum/round_event/scrubber_overflow/event)
	event.forced_reagent_type = chosen
