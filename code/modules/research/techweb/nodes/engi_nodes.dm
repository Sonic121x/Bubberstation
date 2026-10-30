// Parts root node
/datum/techweb_node/parts
	display_name = "基础标准零件"
	description = "构成空间站运作基石的基础组件，涵盖日常运作所需的一系列关键设备。"
	node_flags = parent_type::node_flags | TECHWEB_NODE_STARTER
	unlocked_designs = list(
		/datum/design/micro_servo,
		/datum/design/basic_battery,
		/datum/design/basic_capacitor,
		/datum/design/basic_cell,
		/datum/design/basic_matter_bin,
		/datum/design/basic_micro_laser,
		/datum/design/basic_scanning,
		/datum/design/high_battery,
		/datum/design/high_cell,
		/datum/design/miniature_power_cell,
		/datum/design/condenser,
		/datum/design/igniter,
		/datum/design/infrared_emitter,
		/datum/design/prox_sensor,
		/datum/design/signaler,
		/datum/design/timer,
		/datum/design/voice_analyzer,
		/datum/design/health_sensor,
		/datum/design/synthetic_flash,
	)

/datum/techweb_node/parts_upg
	display_name = "升级零件"
	description = "提供超越基础型号的增强性能。"
	prerequisite_nodes = list(/datum/techweb_node/parts, /datum/techweb_node/energy_manipulation)
	unlocked_designs = list(
		/datum/design/rped,
		/datum/design/high_micro_laser,
		/datum/design/adv_capacitor,
		/datum/design/nano_servo,
		/datum/design/adv_matter_bin,
		/datum/design/adv_scanning,
		/datum/design/super_battery,
		/datum/design/super_cell,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)

/datum/techweb_node/parts_adv
	display_name = "高级零件"
	description = "调校最精细、精度最高的标准零件。"
	prerequisite_nodes = list(/datum/techweb_node/parts_upg)
	unlocked_designs = list(
		/datum/design/ultra_micro_laser,
		/datum/design/super_capacitor,
		/datum/design/pico_servo,
		/datum/design/super_matter_bin,
		/datum/design/phasic_scanning,
		/datum/design/hyper_battery,
		/datum/design/hyper_cell,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	discount_experiments = list(/datum/experiment/scanning/points/machinery_tiered_scan/tier2_any = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)


/datum/techweb_node/parts_bluespace
	display_name = "蓝空间零件"
	description = "这些高级组件融合了最新的蓝空间技术，不仅提升了性能，也为空间站的技术能力开辟了新的可能。"
	prerequisite_nodes = list(/datum/techweb_node/parts_adv, /datum/techweb_node/bluespace_travel)
	unlocked_designs = list(
		/datum/design/bs_rped,
		/datum/design/quadultra_micro_laser,
		/datum/design/quadratic_capacitor,
		/datum/design/femto_servo,
		/datum/design/bluespace_matter_bin,
		/datum/design/triphasic_scanning,
		/datum/design/bluespace_battery,
		/datum/design/bluespace_cell,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/scanning/points/machinery_tiered_scan/tier3_any = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)

/datum/techweb_node/telecomms
	display_name = "通讯技术"
	description = "一整套用于全站通讯系统的机械，确保连接畅通与运作协调。"
	prerequisite_nodes = list(/datum/techweb_node/parts_bluespace)
	unlocked_designs = list(
		/datum/design/board/comm_monitor,
		/datum/design/board/comm_server,
		/datum/design/board/message_monitor,
		/datum/design/board/ntnet_relay,
		/datum/design/board/telecomms_hub,
		/datum/design/board/telecomms_messaging,
		/datum/design/board/telecomms_server,
		/datum/design/board/telecomms_processor,
		/datum/design/board/telecomms_relay,
		/datum/design/board/telecomms_bus,
		/datum/design/board/subspace_broadcaster,
		/datum/design/board/subspace_receiver,
		/datum/design/subspace_amplifier,
		/datum/design/subspace_analyzer,
		/datum/design/subspace_ansible,
		/datum/design/subspace_crystal,
		/datum/design/hyperwave_filter,
		/datum/design/subspace_transmitter,
		/datum/design/subspace_treatment,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)

// Engineering root node
/datum/techweb_node/construction
	display_name = "建造工程"
	description = "用于空间站维护与扩建的工具和关键机械。"
	node_flags = parent_type::node_flags | TECHWEB_NODE_STARTER
	unlocked_designs = list(
		/datum/design/board/circuit_imprinter/offstation,
		/datum/design/board/circuit_imprinter,
		/datum/design/board/solarcontrol,
		/datum/design/solar,
		/datum/design/tracker_electronics,
		/datum/design/apc_board,
		/datum/design/airalarm_electronics,
		/datum/design/airlock_board,
		/datum/design/firealarm_electronics,
		/datum/design/firelock_board,
		/datum/design/trapdoor_electronics,
		/datum/design/control,
		/datum/design/ignition_control,
		/datum/design/board/big_manipulator,
		/datum/design/airlock_painter,
		/datum/design/airlock_painter/decal,
		/datum/design/rwd,
		/datum/design/cable_coil,
		/datum/design/welding_helmet,
		/datum/design/weldingtool,
		/datum/design/mini_weldingtool,
		/datum/design/tscanner,
		/datum/design/multitool,
		/datum/design/wrench,
		/datum/design/crowbar,
		/datum/design/screwdriver,
		/datum/design/wirecutters,
		/datum/design/light_bulb,
		/datum/design/light_tube,
		/datum/design/board/crossing_signal,
		/datum/design/board/guideway_sensor,
		/datum/design/board/manuunloader,
		/datum/design/board/manusmelter,
		/datum/design/board/manucrusher,
		/datum/design/board/manucrafter,
		/datum/design/board/manulathe,
		/datum/design/board/manusorter,
		/datum/design/board/manurouter,
		/datum/design/board/mailsorter,
	)

/datum/techweb_node/energy_manipulation
	display_name = "能量操控"
	description = "通过精密的能量控制手段驾驭闪电弧的原始力量。"
	prerequisite_nodes = list(/datum/techweb_node/construction)
	unlocked_designs = list(
		/datum/design/board/apc_control,
		/datum/design/board/powermonitor,
		/datum/design/board/plankman,
		/datum/design/board/smes,
		/datum/design/board/smesbank,
		/datum/design/board/power_connector,
		/datum/design/board/emitter,
		/datum/design/board/grounding_rod,
		/datum/design/board/tesla_coil,
		/datum/design/board/cell_charger,
		/datum/design/board/recharger,
		/datum/design/inducer,
		/datum/design/inducerengi,
		/datum/design/welding_goggles,
		/datum/design/tray_goggles,
		/datum/design/geiger,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)

/datum/techweb_node/shuttle_engineering
	display_name = "穿梭机工程"
	description = "用于建造穿梭机的材料与设备"
	prerequisite_nodes = list(/datum/techweb_node/energy_manipulation, /datum/techweb_node/applied_bluespace)
	unlocked_designs = list(
		/datum/design/borg_upgrade_shuttle_blueprints,
		/datum/design/board/propulsion_engine,
		/datum/design/shuttle_blueprints,
		/datum/design/board/shuttle/flight_control,
		/datum/design/board/shuttle/shuttle_docker,
		/datum/design/shuttle_rods,
		/datum/design/shuttle_remote,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING, RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/holographics
	display_name = "全息技术"
	description = "将全息技术应用于标识与隔离屏障。"
	prerequisite_nodes = list(/datum/techweb_node/energy_manipulation)
	unlocked_designs = list(
		/datum/design/board/atmosshieldgen,
		/datum/design/forcefield_projector,
		/datum/design/holosign,
		/datum/design/holosignsec,
		/datum/design/holosignengi,
		/datum/design/holosignatmos,
		/datum/design/holosign/restaurant,
		/datum/design/holosign/bar,
		/datum/design/holobarrier_jani,
		/datum/design/holobarrier_med,
		/datum/design/board/holopad,
		/datum/design/holodisk,
		/datum/design/board/modular_shield_gate,
		/datum/design/board/modular_shield_generator,
		/datum/design/board/modular_shield_node,
		/datum/design/board/modular_shield_cable,
		/datum/design/board/modular_shield_relay,
		/datum/design/board/modular_shield_charger,
		/datum/design/board/modular_shield_well,
		/datum/design/board/modular_shield_console,
		/datum/design/diode_disk_magnetic,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/hud
	display_name = "集成式 HUD"
	description = "最初是为助手们通过增强现实了解不同职业的细节而开发的。"
	prerequisite_nodes = list(/datum/techweb_node/holographics, /datum/techweb_node/cyber/cyber_implants)
	unlocked_designs = list(
		/datum/design/health_hud,
		/datum/design/diagnostic_hud,
		/datum/design/security_hud,
		/datum/design/module/mod_visor_medhud,
		/datum/design/module/mod_visor_diaghud,
		/datum/design/module/mod_visor_sechud,
		/datum/design/cyberimp_medical_hud,
		/datum/design/cyberimp_diagnostic_hud,
		/datum/design/cyberimp_security_hud,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING, RADIO_CHANNEL_SECURITY, RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/night_vision
	display_name = "夜视技术"
	description = "有传言称纳米传讯推动这项技术是为了延长轮班时长，确保全天候的生产效率。"
	prerequisite_nodes = list(/datum/techweb_node/hud)
	unlocked_designs = list(
		/datum/design/diagnostic_hud_night,
		/datum/design/health_hud_night,
		/datum/design/night_vision_goggles,
		/datum/design/nvgmesons,
		/datum/design/nv_sci_goggles,
		/datum/design/security_hud_night,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING, RADIO_CHANNEL_SECURITY, RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)
