/datum/round_event_control/antagonist/solo/bloodsucker
	name = "吸血鬼"
	roundstart = TRUE

	antag_flag = ROLE_BLOODSUCKER
	antag_datum = /datum/antagonist/bloodsucker
	weight = 5
	min_players = 30

	maximum_antags_global = 3
	restricted_species = list(SPECIES_PROTEAN)
	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/bloodsucker/midround
	name = "吸血鬼事故"
	roundstart = FALSE

/datum/round_event_control/antagonist/solo/bloodsucker/event
	name = "事件生成的吸血鬼"
	roundstart = FALSE
	tags = list(TAG_ANTAG_REROLL)
	max_occurrences = 0
	maximum_antags = 1
