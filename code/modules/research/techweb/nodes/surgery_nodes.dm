/datum/techweb_node/oldstation_surgery
	display_name = "实验性解剖"
	description = "解锁实验性解剖，可借此产出研究点数。"
	prerequisite_nodes = list(/datum/techweb_node/medbay_equip)
	unlocked_designs = list(
		/datum/design/surgery/experimental_dissection,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	node_flags = TECHWEB_NODE_HIDDEN

/datum/techweb_node/surgery
	display_name = "改良伤口处理"
	description = "谁能想到，用止血钳时手法更轻柔能减轻病人的疼痛呢？"
	prerequisite_nodes = list(/datum/techweb_node/medbay_equip)
	unlocked_designs = list(
		/datum/design/surgery/tend_wounds_upgrade,
		/datum/design/medibot_upgrade,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/surgery_adv
	display_name = "高级外科手术"
	description = "当简单的药物无济于事时。"
	prerequisite_nodes = list(/datum/techweb_node/surgery)
	unlocked_designs = list(
		/datum/design/board/harvester,
		/datum/design/medibot_upgrade/tier_two,
		/datum/design/surgery/tend_wounds_combo,
		/datum/design/surgery/tend_wounds_upgrade/femto,
		/datum/design/surgery/lobotomy,
		/datum/design/surgery/lobotomy/mechanic,
		/datum/design/surgery/wing_reconstruction,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	discount_experiments = list(/datum/experiment/autopsy/human = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/surgery_exp
	display_name = "实验性外科手术"
	description = "当进化不够快时。"
	prerequisite_nodes = list(/datum/techweb_node/surgery_adv)
	unlocked_designs = list(
		/datum/design/medibot_upgrade/tier_three,
		/datum/design/surgery/cortex_folding,
		/datum/design/surgery/cortex_folding/mechanic,
		/datum/design/surgery/cortex_imprint,
		/datum/design/surgery/cortex_imprint/mechanic,
		/datum/design/surgery/tend_wounds_combo/upgrade,
		/datum/design/surgery/ligament_hook,
		/datum/design/surgery/ligament_hook/mechanic,
		/datum/design/surgery/ligament_reinforcement,
		/datum/design/surgery/ligament_reinforcement/mechanic,
		/datum/design/surgery/muscled_veins,
		/datum/design/surgery/muscled_veins/mechanic,
		/datum/design/surgery/nerve_grounding,
		/datum/design/surgery/nerve_grounding/mechanic,
		/datum/design/surgery/nerve_splicing,
		/datum/design/surgery/nerve_splicing/mechanic,
		/datum/design/surgery/pacify,
		/datum/design/surgery/pacify/mechanic,
		/datum/design/surgery/vein_threading,
		/datum/design/surgery/vein_threading/mechanic,
		/datum/design/surgery/viral_bonding,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	discount_experiments = list(/datum/experiment/autopsy/nonhuman = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/surgery_tools
	display_name = "高级手术工具"
	description = "具备双重用途、适合快速手术的外科器械。"
	prerequisite_nodes = list(/datum/techweb_node/surgery_exp)
	unlocked_designs = list(
		/datum/design/laserscalpel,
		/datum/design/searingtool,
		/datum/design/mechanicalpinches,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/autopsy/xenomorph = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_MEDICAL)
