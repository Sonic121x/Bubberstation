//digitigrade research

/datum/techweb_node/digitigrade_cyber
	id = TECHWEB_NODE_CYBERNETICS_DIGITIGRADE
	display_name = "趾行式义体"
	description = "特化的义体肢体设计。股骨缩短想必是机械优化的结果。"
	prereq_ids = list(TECHWEB_NODE_ROBOTICS)
	design_ids = list(
		"digitigrade_cyber_l_leg",
		"digitigrade_cyber_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)


/datum/techweb_node/adv_digitigrade_cyber
	id = TECHWEB_NODE_CYBERNETICS_DIGITIGRADE_ADVANCED
	display_name = "高级趾行式义体"
	description = "比消费级趾行式型号更高一档，它们带有自锐化的爪子，能更快地毁掉你的鞋子。"
	prereq_ids = list(TECHWEB_NODE_AUGMENTATION)
	design_ids = list(
		"digitigrade_advanced_l_leg",
		"digitigrade_advanced_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
