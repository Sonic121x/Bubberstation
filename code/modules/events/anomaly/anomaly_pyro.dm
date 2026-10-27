/datum/round_event_control/anomaly/anomaly_pyro
	name = "异常：火山碎屑"
	typepath = /datum/round_event/anomaly/anomaly_pyro

	max_occurrences = 5
	weight = 20
	description = "该异常会点燃物品，并生成一只火山碎屑史莱姆。"
	min_wizard_trigger_potency = 1
	max_wizard_trigger_potency = 4

/datum/round_event/anomaly/anomaly_pyro
	start_when = ANOMALY_START_HARMFUL_TIME
	announce_when = ANOMALY_ANNOUNCE_HARMFUL_TIME
	anomaly_path = /obj/effect/anomaly/pyro

/datum/round_event/anomaly/anomaly_pyro/announce(fake)
	if(isnull(impact_area))
		impact_area = placer.findValidArea()
	priority_announce("在 [ANOMALY_ANNOUNCE_HARMFUL_TEXT] [impact_area.name] 检测到火山碎屑异常。", "异常警报", ANNOUNCER_PYROANOMALIES) //SKYRAT EDIT CHANGE - ORIGINAL: priority_announce("Pyroclastic anomaly detected on [ANOMALY_ANNOUNCE_HARMFUL_TEXT] [impact_area.name].", "Anomaly Alert")
