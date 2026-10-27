/datum/techweb_node/mech_assembly
	id = TECHWEB_NODE_MECH_ASSEMBLY
	starting_node = TRUE
	display_name = "机甲组装"
	description = "开发用于在运送货物的同时对抗人工重力的机甲。"
	prereq_ids = list(TECHWEB_NODE_ROBOTICS)
	design_ids = list(
		"mechapower",
		"mech_recharger",
		"ripley_chassis",
		"ripley_torso",
		"ripley_left_arm",
		"ripley_right_arm",
		"ripley_left_leg",
		"ripley_right_leg",
		"ripley_main",
		"ripley_peri",
		"mech_hydraulic_clamp",
	)

/datum/techweb_node/mech_equipment
	id = TECHWEB_NODE_MECH_EQUIPMENT
	display_name = "远征装备"
	description = "专为在太空与天体间航行而设计的机甲装备，确保在最严酷的环境中依然耐用且功能完备。"
	prereq_ids = list(TECHWEB_NODE_MECH_ASSEMBLY)
	design_ids = list(
		"mechacontrol",
		"botpad",
		"botpad_remote",
		"ripleyupgrade",
		"mech_air_tank",
		"mech_thrusters",
		"mech_extinguisher",
		"mecha_camera",
		"mecha_tracking",
		"mech_radio",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_clown
	id = TECHWEB_NODE_MECH_CLOWN
	display_name = "滑稽机器人"
	description = "以笑声为燃料。"
	prereq_ids = list(TECHWEB_NODE_MECH_ASSEMBLY)
	design_ids = list(
		"honk_chassis",
		"honk_torso",
		"honk_head",
		"honk_left_arm",
		"honk_right_arm",
		"honk_left_leg",
		"honk_right_leg",
		"honker_main",
		"honker_peri",
		"honker_targ",
		"mech_banana_mortar",
		"mech_honker",
		"mech_mousetrap_mortar",
		"mech_punching_face",
		"borg_transform_clown",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_SECURITY) //The dread upon security when they hear this...

/datum/techweb_node/mech_medical
	id = TECHWEB_NODE_MECH_MEDICAL
	display_name = "医疗机甲"
	description = "配备注射枪与治疗光束的先进机器人单元，彻底改变了危险环境中的医疗救护。"
	prereq_ids = list(TECHWEB_NODE_MECH_ASSEMBLY, TECHWEB_NODE_CHEM_SYNTHESIS)
	design_ids = list(
		"odysseus_chassis",
		"odysseus_torso",
		"odysseus_head",
		"odysseus_left_arm",
		"odysseus_right_arm",
		"odysseus_left_leg",
		"odysseus_right_leg",
		"odysseus_main",
		"odysseus_peri",
		"mech_medi_beam",
		"mech_syringe_gun",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/mech_mining
	id = TECHWEB_NODE_MECH_MINING
	display_name = "采矿机甲"
	description = "为在熔岩与风暴中持续进行站外采矿作业而打造的坚固机甲。"
	prereq_ids = list(TECHWEB_NODE_MECH_EQUIPMENT, TECHWEB_NODE_MINING)
	design_ids = list(
		"clarke_chassis",
		"clarke_torso",
		"clarke_head",
		"clarke_left_arm",
		"clarke_right_arm",
		"clarke_main",
		"clarke_peri",
		"mecha_kineticgun",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/mech_combat
	id = TECHWEB_NODE_MECH_COMBAT
	display_name = "战斗机甲"
	description = "用于安保机甲的模块化装甲升级与专用装备。"
	prereq_ids = list(TECHWEB_NODE_MECH_EQUIPMENT)
	design_ids = list(
		"mech_ccw_armor",
		"mech_proj_armor",
		"mech_emp_armor",
		"paddyupgrade",
		"mech_hydraulic_claw",
		"mech_disabler",
		"mech_repair_droid",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	required_experiments = list(/datum/experiment/scanning/random/mecha_equipped_scan)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_assault
	id = TECHWEB_NODE_MECH_ASSAULT
	display_name = "突击机甲"
	description = "拥有坚固装甲的重型战斗机甲，以速度换取更强的耐久性。"
	prereq_ids = list(TECHWEB_NODE_MECH_COMBAT)
	design_ids = list(
		"durand_armor",
		"durand_chassis",
		"durand_torso",
		"durand_head",
		"durand_left_arm",
		"durand_right_arm",
		"durand_left_leg",
		"durand_right_leg",
		"durand_main",
		"durand_peri",
		"durand_targ",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_light
	id = TECHWEB_NODE_MECH_LIGHT
	display_name = "轻型战斗机甲"
	description = "机动灵活的作战机甲，具备超频能力可短暂提升速度，在战场上以速度优先于耐久。"
	prereq_ids = list(TECHWEB_NODE_MECH_COMBAT)
	design_ids = list(
		"gygax_armor",
		"gygax_chassis",
		"gygax_torso",
		"gygax_head",
		"gygax_left_arm",
		"gygax_right_arm",
		"gygax_left_leg",
		"gygax_right_leg",
		"gygax_main",
		"gygax_peri",
		"gygax_targ",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_heavy
	id = TECHWEB_NODE_MECH_HEAVY
	display_name = "重型机甲"
	description = "具备双人驾驶能力的先进重型机械化单元，为强大的战场表现与更高的战术灵活性而设计。"
	prereq_ids = list(TECHWEB_NODE_MECH_ASSAULT)
	design_ids = list(
		"savannah_ivanov_armor",
		"savannah_ivanov_chassis",
		"savannah_ivanov_torso",
		"savannah_ivanov_head",
		"savannah_ivanov_left_arm",
		"savannah_ivanov_right_arm",
		"savannah_ivanov_left_leg",
		"savannah_ivanov_right_leg",
		"savannah_ivanov_main",
		"savannah_ivanov_peri",
		"savannah_ivanov_targ",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_infiltrator
	id = TECHWEB_NODE_MECH_INFILTRATOR
	display_name = "渗透机甲"
	description = "具备相位能力的先进机甲，可穿行于墙壁与障碍之中，非常适合隐蔽行动与特种作战。"
	prereq_ids = list(TECHWEB_NODE_MECH_LIGHT, TECHWEB_NODE_ANOMALY_RESEARCH)
	design_ids = list(
		"phazon_armor",
		"phazon_chassis",
		"phazon_torso",
		"phazon_head",
		"phazon_left_arm",
		"phazon_right_arm",
		"phazon_left_leg",
		"phazon_right_leg",
		"phazon_main",
		"phazon_peri",
		"phazon_targ",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_energy_guns
	id = TECHWEB_NODE_MECH_ENERGY_GUNS
	display_name = "机甲能量枪"
	description = "为机甲搭载而优化的电击武器放大版。"
	prereq_ids = list(TECHWEB_NODE_MECH_COMBAT, TECHWEB_NODE_ELECTRIC_WEAPONS)
	design_ids = list(
		"mech_laser",
		"mech_laser_heavy",
		"mech_ion",
		"mech_tesla",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/scanning/random/mecha_damage_scan = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_firearms
	id = TECHWEB_NODE_MECH_FIREARMS
	display_name = "机甲枪械"
	description = "机甲搭载的弹道武器，可增强机械化单位的作战能力。"
	prereq_ids = list(TECHWEB_NODE_MECH_ENERGY_GUNS, TECHWEB_NODE_EXOTIC_AMMO)
	design_ids = list(
		"mech_lmg",
		"mech_lmg_ammo",
		"mech_scattershot",
		"mech_scattershot_ammo",
		"mech_carbine",
		"mech_carbine_ammo",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_heavy_arms
	id = TECHWEB_NODE_MECH_HEAVY_ARMS
	display_name = "重型机甲枪械"
	description = "集成于机甲的高威力武器，为最大化火力而优化。"
	prereq_ids = list(TECHWEB_NODE_MECH_HEAVY, TECHWEB_NODE_EXOTIC_AMMO)
	design_ids = list(
		"clusterbang_launcher",
		"clusterbang_launcher_ammo",
		"mech_grenade_launcher",
		"mech_grenade_launcher_ammo",
		"mech_missile_rack",
		"mech_missile_rack_ammo",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mech_equip_bluespace
	id = TECHWEB_NODE_MECH_EQUIP_BLUESPACE
	display_name = "蓝空间机甲装备"
	description = "一系列由蓝空间技术赋能的装备，提供无与伦比的机动性与实用性。"
	prereq_ids = list(TECHWEB_NODE_MECH_INFILTRATOR, TECHWEB_NODE_BLUESPACE_TRAVEL)
	design_ids = list(
		"mech_gravcatapult",
		"mech_teleporter",
		"mech_wormhole_gen",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)
