/datum/round_event_control/antagonist/solo/spy
	name = "间谍"
	roundstart = TRUE

	antag_flag = ROLE_SPY
	antag_datum = /datum/antagonist/spy
	weight = 8
	maximum_antags_global = 4
	
	min_players = 15

	tags = list(TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/spy/midround
	name = "间谍（回合中）"
	roundstart = FALSE
	
	min_players = 15

/datum/round_event_control/antagonist/solo/spy/event
	name = "事件生成的间谍"
	roundstart = FALSE
	tags = list(TAG_ANTAG_REROLL)
	max_occurrences = 0
	maximum_antags = 1
