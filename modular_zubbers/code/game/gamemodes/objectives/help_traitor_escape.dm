/datum/objective/jailbreak/traitor
	name = "协助叛徒逃脱"

/datum/objective/jailbreak/traitor/is_valid_target(datum/mind/possible_target)
	. = ..()
	if(!.)
		return FALSE
	if(possible_target.has_antag_datum(/datum/antagonist/traitor))
		return TRUE
	return FALSE
