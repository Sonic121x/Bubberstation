/datum/techweb_node/oldstation_surgery
	id = TECHWEB_NODE_OLDSTATION_SURGERY
	display_name = "实验性解剖"
	description = "解锁实验性解剖，可借此产出研究点数。"
	prereq_ids = list(TECHWEB_NODE_MEDBAY_EQUIP)
	design_ids = list(
		"surgery_oldstation_dissection",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
	show_on_wiki = FALSE

/datum/techweb_node/surgery
	id = TECHWEB_NODE_SURGERY
	display_name = "改良伤口处理"
	description = "谁能想到，用止血钳时手法更轻柔能减轻病人的疼痛呢？"
	prereq_ids = list(TECHWEB_NODE_MEDBAY_EQUIP)
	design_ids = list(
		"surgery_heal_upgrade",
		"medibot_upgrade",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/surgery_adv
	id = TECHWEB_NODE_SURGERY_ADV
	display_name = "高级外科手术"
	description = "当简单的药物无济于事时。"
	prereq_ids = list(TECHWEB_NODE_SURGERY)
	design_ids = list(
		"harvester",
		"medibot_upgrade_two",
		"surgery_heal_combo",
		"surgery_heal_upgrade_femto",
		"surgery_lobotomy",
		"surgery_lobotomy_mechanic",
		"surgery_wing_reconstruction",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	discount_experiments = list(/datum/experiment/autopsy/human = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/surgery_exp
	id = TECHWEB_NODE_SURGERY_EXP
	display_name = "实验性外科手术"
	description = "当进化不够快时。"
	prereq_ids = list(TECHWEB_NODE_SURGERY_ADV)
	design_ids = list(
		"medibot_upgrade_three",
		"surgery_cortex_folding",
		"surgery_cortex_folding_mechanic",
		"surgery_cortex_imprint",
		"surgery_cortex_imprint_mechanic",
		"surgery_heal_combo_upgrade",
		"surgery_ligament_hook",
		"surgery_ligament_hook_mechanic",
		"surgery_ligament_reinforcement",
		"surgery_ligament_reinforcement_mechanic",
		"surgery_muscled_veins",
		"surgery_muscled_veins_mechanic",
		"surgery_nerve_ground",
		"surgery_nerve_ground_mechanic",
		"surgery_nerve_splice",
		"surgery_nerve_splice_mechanic",
		"surgery_pacify",
		"surgery_pacify_mechanic",
		"surgery_vein_thread",
		"surgery_vein_thread_mechanic",
		"surgery_viral_bond",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	discount_experiments = list(/datum/experiment/autopsy/nonhuman = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/surgery_tools
	id = TECHWEB_NODE_SURGERY_TOOLS
	display_name = "高级手术工具"
	description = "具备双重用途、适合快速手术的外科器械。"
	prereq_ids = list(TECHWEB_NODE_SURGERY_EXP)
	design_ids = list(
		"laserscalpel",
		"searingtool",
		"mechanicalpinches",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/autopsy/xenomorph = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_MEDICAL)
