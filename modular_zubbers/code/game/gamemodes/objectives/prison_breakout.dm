/datum/objective/prison_breakout
	name = "越狱"
	martyr_compatible = TRUE
	admin_grantable = TRUE
	count_space_areas = TRUE

/datum/objective/prison_breakout/update_explanation_text()
	. = ..()
	if(target?.current)
		explanation_text = "将[target.name]救出监狱，确保其活着逃离空间站且未被拘押。"
	else
		explanation_text = "自由目标"

/datum/objective/prison_breakout/is_valid_target(datum/mind/possible_target)
	. = ..()
	if(!.)
		return FALSE
	if(istype(possible_target.assigned_role, /datum/job/prisoner))
		return TRUE
	var/area/target_area = get_area(possible_target.current)
	var/datum/record/crew/record = find_record(possible_target.name)
	if(record && (record.wanted_status == WANTED_PRISONER || record.wanted_status == WANTED_ARREST))
		if(istype(target_area, /area/station/security/prison))
			return TRUE
	return FALSE

/datum/objective/prison_breakout/check_completion()
	return completed || considered_escaped(target)

/datum/objective/prison_breakout/admin_edit(mob/admin)
	admin_simple_target_pick(admin)
