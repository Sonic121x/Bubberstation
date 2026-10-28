/datum/techweb_node/material_processing
	display_name = "材料加工"
	description = "对合金与矿石进行精炼加工，以提升它们的实用性与价值。"
	node_flags = parent_type::node_flags | TECHWEB_NODE_STARTER
	unlocked_designs = list(
		/datum/design/pickaxe,
		/datum/design/shovel,
		/datum/design/conveyor_switch,
		/datum/design/conveyor_belt,
		/datum/design/board/mass_driver,
		/datum/design/board/recycler,
		/datum/design/board/stacking_machine,
		/datum/design/board/stacking_unit_console,
		/datum/design/board/autolathe,
		/datum/design/material/rglass,
		/datum/design/alloy/plaglass,
		/datum/design/alloy/plasmarglass,
		/datum/design/alloy/plasteel_alloy,
		/datum/design/alloy/titaniumglass,
		/datum/design/alloy/plastitanium,
		/datum/design/alloy/plastitaniumglass,
	)

/datum/techweb_node/mining
	display_name = "采矿技术"
	description = "开发旨在优化采矿作业与资源开采的工具。"
	prerequisite_nodes = list(/datum/techweb_node/material_processing)
	unlocked_designs = list(
		/datum/design/cargo_express,
		/datum/design/board/brm,
		/datum/design/board/smelter,
		/datum/design/board/refinery,
		/datum/design/board/ore_redemption,
		/datum/design/board/mining_equipment_vendor,
		/datum/design/mining_scanner,
		/datum/design/mech_mining_scanner,
		/datum/design/superresonator,
		/datum/design/mech_drill,
		/datum/design/module/mod_drill,
		/datum/design/drill,
		/datum/design/module/mod_orebag,
		/datum/design/beacon,
		/datum/design/telesci_gps,
		/datum/design/module/mod_gps,
		/datum/design/module/mod_visor_meson,
		/datum/design/mesons,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/low_pressure_excavation
	display_name = "低压采掘"
	description = "对原型动能加速器（PKA）的研究，这种气动枪在低压环境中性能卓越。"
	prerequisite_nodes = list(/datum/techweb_node/mining, /datum/techweb_node/gas_compression)
	unlocked_designs = list(
		/datum/design/damage_mod,
		/datum/design/range_mod,
		/datum/design/cooldown_mod,
		/datum/design/trigger_guard_mod,
		/datum/design/hyperaccelerator,
		/datum/design/damage_mod/borg,
		/datum/design/range_mod/borg,
		/datum/design/cooldown_mod/borg,
		/datum/design/hyperaccelerator/borg,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/plasma_mining
	display_name = "等离子光束采矿"
	description = "工程师的等离子焊枪在采矿作业中被证明极为有效。这促成了机甲搭载型号与为矿工强化的手持切割器的研发。"
	prerequisite_nodes = list(/datum/techweb_node/low_pressure_excavation, /datum/techweb_node/plasma_control)
	unlocked_designs = list(
		/datum/design/mech_plasma_cutter,
		/datum/design/plasmacutter_adv,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/bitrunning
	display_name = "比特潜行技术"
	description = "蓝空间技术催生了量子尺度计算，从而开启了在执行高级程序的同时将原子结构实体化的途径。"
	prerequisite_nodes = list(/datum/techweb_node/gaming, /datum/techweb_node/applied_bluespace)
	unlocked_designs = list(
		/datum/design/board/byteforge,
		/datum/design/board/quantum_console,
		/datum/design/board/netpod,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/mining_adv
	display_name = "高级采矿技术"
	description = "高阶采矿设备，不断拓展资源开采效率与效果的边界。"
	prerequisite_nodes = list(/datum/techweb_node/plasma_mining)
	unlocked_designs = list(
		/datum/design/jackhammer,
		/datum/design/drill_diamond,
		/datum/design/mech_diamond_drill,
		/datum/design/module/mod_candela_spool,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)
