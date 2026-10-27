/datum/techweb_node/material_processing
	id = TECHWEB_NODE_MATERIAL_PROC
	starting_node = TRUE
	display_name = "材料加工"
	description = "对合金与矿石进行精炼加工，以提升它们的实用性与价值。"
	design_ids = list(
		"pickaxe",
		"shovel",
		"conveyor_switch",
		"conveyor_belt",
		"mass_driver",
		"recycler",
		"stack_machine",
		"stack_console",
		"autolathe",
		"rglass",
		"plasmaglass",
		"plasmareinforcedglass",
		"plasteel",
		"titaniumglass",
		"plastitanium",
		"plastitaniumglass",
	)

/datum/techweb_node/mining
	id = TECHWEB_NODE_MINING
	display_name = "采矿技术"
	description = "开发旨在优化采矿作业与资源开采的工具。"
	prereq_ids = list(TECHWEB_NODE_MATERIAL_PROC)
	design_ids = list(
		"cargoexpress",
		"brm",
		"b_smelter",
		"b_refinery",
		"ore_redemption",
		"mining_equipment_vendor",
		"mining_scanner",
		"mech_mscanner",
		"superresonator",
		"mech_drill",
		"mod_drill",
		"drill",
		"mod_orebag",
		"beacon",
		"telesci_gps",
		"mod_gps",
		"mod_visor_meson",
		"mesons",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/low_pressure_excavation
	id = TECHWEB_NODE_LOW_PRESSURE_EXCAVATION
	display_name = "低压采掘"
	description = "对原型动能加速器（PKA）的研究，这种气动枪在低压环境中性能卓越。"
	prereq_ids = list(TECHWEB_NODE_MINING, TECHWEB_NODE_GAS_COMPRESSION)
	design_ids = list(
		"damagemod",
		"rangemod",
		"cooldownmod",
		"triggermod",
		"hypermod",
		"borg_upgrade_damagemod",
		"borg_upgrade_rangemod",
		"borg_upgrade_cooldownmod",
		"borg_upgrade_hypermod",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/plasma_mining
	id = TECHWEB_NODE_PLASMA_MINING
	display_name = "等离子光束采矿"
	description = "工程师的等离子焊枪在采矿作业中被证明极为有效。这促成了机甲搭载型号与为矿工强化的手持切割器的研发。"
	prereq_ids = list(TECHWEB_NODE_LOW_PRESSURE_EXCAVATION, TECHWEB_NODE_PLASMA_CONTROL)
	design_ids = list(
		"mech_plasma_cutter",
		"plasmacutter_adv",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/bitrunning
	id = TECHWEB_NODE_BITRUNNING
	display_name = "比特潜行技术"
	description = "蓝空间技术催生了量子尺度计算，从而开启了在执行高级程序的同时将原子结构实体化的途径。"
	prereq_ids = list(TECHWEB_NODE_GAMING, TECHWEB_NODE_APPLIED_BLUESPACE)
	design_ids = list(
		"byteforge",
		"quantum_console",
		"netpod",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/mining_adv
	id = TECHWEB_NODE_MINING_ADV
	display_name = "高级采矿技术"
	description = "高阶采矿设备，不断拓展资源开采效率与效果的边界。"
	prereq_ids = list(TECHWEB_NODE_PLASMA_MINING)
	design_ids = list(
		"jackhammer",
		"drill_diamond",
		"mech_diamond_drill",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)
