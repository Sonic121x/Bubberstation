/datum/round_event_control/wizard/tower_of_babel
	name = "巴别塔"
	weight = 3
	typepath = /datum/round_event/wizard/tower_of_babel
	max_occurrences = 1
	earliest_start = 0 MINUTES
	description = "所有人都会忘记当前掌握的语言，并获得一门随机语言。"
	min_wizard_trigger_potency = 5
	max_wizard_trigger_potency = 7

/datum/round_event/wizard/tower_of_babel/start()
	GLOB.tower_of_babel = new /datum/tower_of_babel()

