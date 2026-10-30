/datum/techweb_node/mech_assembly
	display_name = "机甲组装"
	description = "开发用于在运送货物的同时对抗人工重力的机甲。"
	node_flags = parent_type::node_flags | TECHWEB_NODE_STARTER
	prerequisite_nodes = list(/datum/techweb_node/robotics)
	unlocked_designs = list(
		/datum/design/board/mechapower,
		/datum/design/board/mech_recharger,
		/datum/design/ripley_chassis,
		/datum/design/ripley_torso,
		/datum/design/ripley_left_arm,
		/datum/design/ripley_right_arm,
		/datum/design/ripley_left_leg,
		/datum/design/ripley_right_leg,
		/datum/design/board/ripley_main,
		/datum/design/board/ripley_peri,
		/datum/design/mech_hydraulic_clamp,
	)

/datum/techweb_node/mech_equipment
	display_name = "远征装备"
	description = "专为在太空与天体间航行而设计的机甲装备，确保在最严酷的环境中依然耐用且功能完备。"
	prerequisite_nodes = list(/datum/techweb_node/mech_assembly)
	unlocked_designs = list(
		/datum/design/board/mechacontrol,
		/datum/design/board/botpad,
		/datum/design/botpad_remote,
		/datum/design/ripleyupgrade,
		/datum/design/mech_air_tank,
		/datum/design/mech_thrusters,
		/datum/design/mech_extinguisher,
		/datum/design/mecha_camera,
		/datum/design/mecha_tracking,
		/datum/design/mech_radio,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_clown
	display_name = "滑稽机器人"
	description = "以笑声为燃料。"
	prerequisite_nodes = list(/datum/techweb_node/mech_assembly)
	unlocked_designs = list(
		/datum/design/honk_chassis,
		/datum/design/honk_torso,
		/datum/design/honk_head,
		/datum/design/honk_left_arm,
		/datum/design/honk_right_arm,
		/datum/design/honk_left_leg,
		/datum/design/honk_right_leg,
		/datum/design/board/honker_main,
		/datum/design/board/honker_peri,
		/datum/design/board/honker_targ,
		/datum/design/mech_banana_mortar,
		/datum/design/mech_honker,
		/datum/design/mech_mousetrap_mortar,
		/datum/design/mech_punching_glove,
		/datum/design/borg_transform_clown,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_SECURITY) //The dread upon security when they hear this...

/datum/techweb_node/mech_medical
	display_name = "医疗机甲"
	description = "配备注射枪与治疗光束的先进机器人单元，彻底改变了危险环境中的医疗救护。"
	prerequisite_nodes = list(/datum/techweb_node/mech_assembly, /datum/techweb_node/chem_synthesis)
	unlocked_designs = list(
		/datum/design/odysseus_chassis,
		/datum/design/odysseus_torso,
		/datum/design/odysseus_head,
		/datum/design/odysseus_left_arm,
		/datum/design/odysseus_right_arm,
		/datum/design/odysseus_left_leg,
		/datum/design/odysseus_right_leg,
		/datum/design/board/odysseus_main,
		/datum/design/board/odysseus_peri,
		/datum/design/mech_medical_beamgun,
		/datum/design/mech_syringe_gun,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/mech_mining
	display_name = "采矿机甲"
	description = "为在熔岩与风暴中持续进行站外采矿作业而打造的坚固机甲。"
	prerequisite_nodes = list(/datum/techweb_node/mech_equipment, /datum/techweb_node/mining)
	unlocked_designs = list(
		/datum/design/clarke_chassis,
		/datum/design/clarke_torso,
		/datum/design/clarke_head,
		/datum/design/clarke_left_arm,
		/datum/design/clarke_right_arm,
		/datum/design/board/clarke_main,
		/datum/design/board/clarke_peri,
		/datum/design/mecha_kineticgun,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/mech_combat
	display_name = "战斗机甲"
	description = "用于安保机甲的模块化装甲升级与专用装备。"
	prerequisite_nodes = list(/datum/techweb_node/mech_equipment)
	unlocked_designs = list(
		/datum/design/mech_ccw_armor,
		/datum/design/mech_proj_armor,
		/datum/design/mech_emp_armor,
		/datum/design/paddyupgrade,
		/datum/design/mech_hydraulic_claw,
		/datum/design/mech_disabler,
		/datum/design/mech_repair_droid,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	required_experiments = list(/datum/experiment/scanning/random/mecha_equipped_scan)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_assault
	display_name = "突击机甲"
	description = "拥有坚固装甲的重型战斗机甲，以速度换取更强的耐久性。"
	prerequisite_nodes = list(/datum/techweb_node/mech_combat)
	unlocked_designs = list(
		/datum/design/durand_armor,
		/datum/design/durand_chassis,
		/datum/design/durand_torso,
		/datum/design/durand_head,
		/datum/design/durand_left_arm,
		/datum/design/durand_right_arm,
		/datum/design/durand_left_leg,
		/datum/design/durand_right_leg,
		/datum/design/board/durand_main,
		/datum/design/board/durand_peri,
		/datum/design/board/durand_targ,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_light
	display_name = "轻型战斗机甲"
	description = "机动灵活的作战机甲，具备超频能力可短暂提升速度，在战场上以速度优先于耐久。"
	prerequisite_nodes = list(/datum/techweb_node/mech_combat)
	unlocked_designs = list(
		/datum/design/gygax_armor,
		/datum/design/gygax_chassis,
		/datum/design/gygax_torso,
		/datum/design/gygax_head,
		/datum/design/gygax_left_arm,
		/datum/design/gygax_right_arm,
		/datum/design/gygax_left_leg,
		/datum/design/gygax_right_leg,
		/datum/design/board/gygax_main,
		/datum/design/board/gygax_peri,
		/datum/design/board/gygax_targ,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_heavy
	display_name = "重型机甲"
	description = "具备双人驾驶能力的先进重型机械化单元，为强大的战场表现与更高的战术灵活性而设计。"
	prerequisite_nodes = list(/datum/techweb_node/mech_assault)
	unlocked_designs = list(
		/datum/design/savannah_ivanov_armor,
		/datum/design/savannah_ivanov_chassis,
		/datum/design/savannah_ivanov_torso,
		/datum/design/savannah_ivanov_head,
		/datum/design/savannah_ivanov_left_arm,
		/datum/design/savannah_ivanov_right_arm,
		/datum/design/savannah_ivanov_left_leg,
		/datum/design/savannah_ivanov_right_leg,
		/datum/design/board/savannah_ivanov_main,
		/datum/design/board/savannah_ivanov_peri,
		/datum/design/board/savannah_ivanov_targ,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_infiltrator
	display_name = "渗透机甲"
	description = "具备相位能力的先进机甲，可穿行于墙壁与障碍之中，非常适合隐蔽行动与特种作战。"
	prerequisite_nodes = list(/datum/techweb_node/mech_light, /datum/techweb_node/anomaly_research)
	unlocked_designs = list(
		/datum/design/phazon_armor,
		/datum/design/phazon_chassis,
		/datum/design/phazon_torso,
		/datum/design/phazon_head,
		/datum/design/phazon_left_arm,
		/datum/design/phazon_right_arm,
		/datum/design/phazon_left_leg,
		/datum/design/phazon_right_leg,
		/datum/design/board/phazon_main,
		/datum/design/board/phazon_peri,
		/datum/design/board/phazon_targ,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_energy_guns
	display_name = "机甲能量枪"
	description = "为机甲搭载而优化的电击武器放大版。"
	prerequisite_nodes = list(/datum/techweb_node/mech_combat, /datum/techweb_node/electric_weapons)
	unlocked_designs = list(
		/datum/design/mech_laser,
		/datum/design/mech_laser_heavy,
		/datum/design/mech_ion,
		/datum/design/mech_tesla,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/scanning/random/mecha_damage_scan = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_firearms
	display_name = "机甲枪械"
	description = "机甲搭载的弹道武器，可增强机械化单位的作战能力。"
	prerequisite_nodes = list(/datum/techweb_node/mech_energy_guns, /datum/techweb_node/exotic_ammo)
	unlocked_designs = list(
		/datum/design/mech_lmg,
		/datum/design/mech_lmg_ammo,
		/datum/design/mech_scattershot,
		/datum/design/mech_scattershot_ammo,
		/datum/design/mech_carbine,
		/datum/design/mech_carbine_ammo,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_heavy_arms
	display_name = "重型机甲枪械"
	description = "集成于机甲的高威力武器，为最大化火力而优化。"
	prerequisite_nodes = list(/datum/techweb_node/mech_heavy, /datum/techweb_node/exotic_ammo)
	unlocked_designs = list(
		/datum/design/clusterbang_launcher,
		/datum/design/clusterbang_launcher_ammo,
		/datum/design/mech_grenade_launcher,
		/datum/design/mech_grenade_launcher_ammo,
		/datum/design/mech_missile_rack,
		/datum/design/mech_missile_rack_ammo,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_equip_bluespace
	display_name = "蓝空间机甲装备"
	description = "一系列由蓝空间技术赋能的装备，提供无与伦比的机动性与实用性。"
	prerequisite_nodes = list(/datum/techweb_node/mech_infiltrator, /datum/techweb_node/bluespace_travel)
	unlocked_designs = list(
		/datum/design/mech_gravcatapult,
		/datum/design/mech_teleporter,
		/datum/design/mech_wormhole_gen,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)
