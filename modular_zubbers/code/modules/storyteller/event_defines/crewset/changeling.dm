/datum/round_event_control/antagonist/solo/changeling
	name = "变形怪"
	roundstart = TRUE

	antag_flag = ROLE_CHANGELING
	antag_datum = /datum/antagonist/changeling
	weight = 8
	min_players = 20
	maximum_antags_global = 4
	restricted_species = list(SPECIES_PROTEAN)

	tags = list(TAG_COMBAT, TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/changeling/midround
	name = "基因组觉醒（变形怪）"
	roundstart = FALSE

/datum/round_event_control/antagonist/solo/changeling/event
	name = "事件生成的变形怪"
	roundstart = FALSE
	tags = list(TAG_ANTAG_REROLL)
	max_occurrences = 0
	maximum_antags = 1
