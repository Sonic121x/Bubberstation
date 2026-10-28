/datum/techweb_node/atmos
	display_name = "大气学"
	description = "维持空间站空气及相关生命维持系统。"
	node_flags = parent_type::node_flags | TECHWEB_NODE_STARTER
	unlocked_designs = list(
		/datum/design/board/atmos_control,
		/datum/design/board/atmosalerts,
		/datum/design/board/thermomachine,
		/datum/design/board/space_heater,
		/datum/design/board/scrubber,
		/datum/design/generic_gas_tank,
		/datum/design/oxygen_tank,
		/datum/design/plasma_tank,
		/datum/design/plasmaman_tank_belt,
		/datum/design/plasmarefiller,
		/datum/design/extinguisher,
		/datum/design/pocketfireextinguisher,
		/datum/design/gas_filter,
		/datum/design/plasmaman_gas_filter,
		/datum/design/analyzer,
		/datum/design/pipe_painter,
	)

/datum/techweb_node/gas_compression
	display_name = "气体压缩"
	description = "高度压缩的气体蕴藏着释放巨大能量潜力的可能。"
	prerequisite_nodes = list(/datum/techweb_node/atmos)
	unlocked_designs = list(
		/datum/design/board/tank_compressor,
		/datum/design/board/pump,
		/datum/design/emergency_oxygen,
		/datum/design/emergency_oxygen_engi,
		/datum/design/board/turbine_computer,
		/datum/design/turbine_part_compressor,
		/datum/design/turbine_part_rotor,
		/datum/design/turbine_part_stator,
		/datum/design/board/turbine_compressor,
		/datum/design/board/turbine_rotor,
		/datum/design/board/turbine_stator,
		/datum/design/atmos_thermal,
		/datum/design/pneumatic_seal,
		/datum/design/large_welding_tool,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	experiments_to_unlock = list(
		/datum/experiment/ordnance/gaseous/plasma,
		/datum/experiment/ordnance/gaseous/nitrous_oxide,
		/datum/experiment/ordnance/gaseous/bz,
		/datum/experiment/ordnance/gaseous/noblium,
	)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)

/datum/techweb_node/plasma_control
	display_name = "受控等离子"
	description = "通过高压气体与电力的实验，实现结晶化与受控的等离子反应。"
	prerequisite_nodes = list(/datum/techweb_node/gas_compression, /datum/techweb_node/energy_manipulation)
	unlocked_designs = list(
		/datum/design/board/electrolyzer,
		/datum/design/board/pipe_scrubber,
		/datum/design/board/pacman,
		/datum/design/mech_generator,
		/datum/design/plasmacutter,
		/datum/design/diode_disk_incendiary,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	discount_experiments = list(/datum/experiment/ordnance/gaseous/plasma = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)

/datum/techweb_node/fusion
	display_name = "核聚变"
	description = "研究聚变反应堆技术，通过涉及惰性气体的受控等离子反应，实现可持续且高效的能量生产。"
	prerequisite_nodes = list(/datum/techweb_node/plasma_control)
	unlocked_designs = list(
		/datum/design/board/HFR_core,
		/datum/design/board/HFR_corner,
		/datum/design/board/HFR_fuel_input,
		/datum/design/board/HFR_interface,
		/datum/design/board/HFR_moderator_input,
		/datum/design/board/HFR_waste_output,
		/datum/design/fire_extinguisher_advanced,
		/datum/design/bolter_wrench,
		/datum/design/rpd,
		/datum/design/engine_goggles,
		/datum/design/board/crystallizer,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	discount_experiments = list(/datum/experiment/ordnance/gaseous/nitrous_oxide = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)

/datum/techweb_node/exp_tools
	display_name = "实验性工具"
	description = "强化站内工具的功能与通用性。"
	prerequisite_nodes = list(/datum/techweb_node/fusion)
	unlocked_designs = list(
		/datum/design/board/flatpacker,
		/datum/design/handdrill,
		/datum/design/exwelder,
		/datum/design/jawsoflife,
		/datum/design/rangedanalyzer,
		/datum/design/rtd_loaded,
		/datum/design/mech_rcd,
		/datum/design/rcd_loaded,
		/datum/design/rcd_ammo,
		/datum/design/welding_mask,
		/datum/design/magboots,
		/datum/design/diode_disk_stamina,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/ordnance/gaseous/bz = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)

/datum/techweb_node/rcd_upgrade
	display_name = "快速建造装置升级"
	description = "为 RCD 与 RPD 提供的新设计与增强功能。"
	prerequisite_nodes = list(/datum/techweb_node/exp_tools, /datum/techweb_node/parts_bluespace)
	unlocked_designs = list(
		/datum/design/rcd_upgrade/silo_link,
		/datum/design/rcd_upgrade/anti_interrupt,
		/datum/design/rcd_upgrade/cooling,
		/datum/design/rcd_upgrade/frames,
		/datum/design/rcd_upgrade/furnishing,
		/datum/design/rcd_upgrade/simple_circuits,
		/datum/design/rpd_upgrade/unwrench,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	discount_experiments = list(/datum/experiment/ordnance/gaseous/noblium = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)
