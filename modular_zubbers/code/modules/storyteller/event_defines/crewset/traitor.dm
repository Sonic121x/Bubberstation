/datum/round_event_control/antagonist/solo/traitor
	name = "叛徒"
	roundstart = TRUE

	antag_flag = ROLE_TRAITOR
	antag_datum = /datum/antagonist/traitor
	weight = 16
	maximum_antags_global = 6

	tags = list(TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/traitor/midround
	name = "潜伏特工（叛徒）"
	roundstart = FALSE

/datum/round_event_control/antagonist/solo/traitor/event
	name = "事件生成的叛徒"
	roundstart = FALSE
	tags = list(TAG_ANTAG_REROLL)
	max_occurrences = 0
	maximum_antags = 1
