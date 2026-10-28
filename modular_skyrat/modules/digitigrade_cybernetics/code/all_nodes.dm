//digitigrade research

/datum/techweb_node/digitigrade_cyber
	display_name = "趾行式义体"
	description = "特化的义体肢体设计。股骨缩短想必是机械优化的结果。"
	prerequisite_nodes = list(/datum/techweb_node/robotics)
	unlocked_designs = list(
		/datum/design/digitigrade_cyber_l_leg,
		/datum/design/digitigrade_cyber_r_leg,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)


/datum/techweb_node/adv_digitigrade_cyber
	display_name = "高级趾行式义体"
	description = "比消费级趾行式型号更高一档，它们带有自锐化的爪子，能更快地毁掉你的鞋子。"
	prerequisite_nodes = list(/datum/techweb_node/augmentation)
	unlocked_designs = list(
		/datum/design/digitigrade_adv_l_leg,
		/datum/design/digitigrade_adv_r_leg,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
