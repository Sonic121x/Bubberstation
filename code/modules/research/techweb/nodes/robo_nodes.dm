/datum/techweb_node/robotics
	id = TECHWEB_NODE_ROBOTICS
	starting_node = TRUE
	display_name = "机器人技术"
	description = "让我们生活得更懒散的可编程机械。"
	design_ids = list(
		"botnavbeacon",
		"mechfab",
		"paicard",
	)

/datum/techweb_node/exodrone
	id = TECHWEB_NODE_EXODRONE
	display_name = "探索无人机"
	description = "改装过的街机，暗中利用玩家的技巧操控真实无人机，以达到实用目的。"
	prereq_ids = list(TECHWEB_NODE_ROBOTICS)
	design_ids = list(
		"exodrone_console",
		"exodrone_launcher",
		"exoscanner",
		"exoscanner_console",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

// AI root node
/datum/techweb_node/ai
	id = TECHWEB_NODE_AI
	display_name = "人工智能"
	description = "对 AI 系统的探索，它们比全船船员加起来还要聪明。"
	prereq_ids = list(TECHWEB_NODE_ROBOTICS)
	design_ids = list(
		"aicore",
		"aifixer",
		"airack_broadcaster",
		"airack_normal",
		"airack_small",
		"asimov_module",
		"borg_ai_control",
		"corporate_module",
		"default_module",
		"drone_module",
		"freeform_module",
		"intellicard",
		"mecha_tracking_ai_control",
		"nutimov_module",
		"oxygen_module",
		"paladin_module",
		"protectstation_module",
		"quarantine_module",
		"robocop_module",
		"safeguard_module",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/ai/New()
	. = ..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_HUMAN_AI))
		design_ids -= list(
			"aicore",
			"aifixer",
			"borg_ai_control",
			"intellicard",
			"mecha_tracking_ai_control",
		)
	else if(HAS_TRAIT(SSstation, STATION_TRAIT_UNIQUE_AI) || HAS_TRAIT(SSstation, STATION_TRAIT_HOS_AI)) //Bubber edit HoS AI station trait
		research_costs[TECHWEB_POINT_TYPE_GENERIC] *= 3

/datum/techweb_node/ai_laws
	id = TECHWEB_NODE_AI_LAWS
	display_name = "高级 AI 升级"
	description = "钻研复杂精密的 AI 指令，但愿它们不会导致人类灭绝。"
	prereq_ids = list(TECHWEB_NODE_AI)
	design_ids = list(
		"ai_power_upgrade",
		"antimov_module",
		"asimovpp_module",
		"balance_module",
		"damaged_module",
		"dungeon_master_module",
		"freeformcore_module",
		"hippocratic_module",
		"hulkamania_module",
		"liveandletlive_module",
		"maintain_module",
		"onehuman_module",
		"overlord_module",
		"painter_module",
		"paladin_devotion_module",
		"peacekeeper_module",
		"reporter_module",
		"ten_commandments_module",
		"thermurderdynamic_module",
		"thinkermov_module",
		"tyrant_module",
		"yesman_module",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_COMMAND)
