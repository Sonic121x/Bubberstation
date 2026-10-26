/datum/techweb_node/augmentation
	id = TECHWEB_NODE_AUGMENTATION
	starting_node = TRUE
	display_name = "义体改造"
	description = "献给那些偏爱闪亮金属胜过柔软血肉的人。"
	prereq_ids = list(TECHWEB_NODE_ROBOTICS)
	design_ids = list(
		"borg_chest",
		"borg_head",
		"borg_l_arm",
		"borg_l_leg",
		"borg_r_arm",
		"borg_r_leg",
		"borg_suit",
		"cybernetic_eyes",
		"cybernetic_eyes_moth",
		"cybernetic_ears",
		"cybernetic_ears_cat",
		"cybernetic_lungs",
		"cybernetic_stomach",
		"cybernetic_liver",
		"cybernetic_heart",
	)
	experiments_to_unlock = list(
		/datum/experiment/scanning/people/android,
	)

/datum/techweb_node/cybernetics
	id = TECHWEB_NODE_CYBERNETICS
	display_name = "半机械人学"
	description = "搭载预装工具模块与可编程法则的智慧机器人。"
	prereq_ids = list(TECHWEB_NODE_AUGMENTATION)
	design_ids = list(
		"robocontrol",
		"cyborgrecharger",
		"mmi_posi",
		"mmi",
		"mmi_m",
		"advanced_l_arm",
		"advanced_r_arm",
		"advanced_l_leg",
		"advanced_r_leg",
		"borg_upgrade_rename",
		"borg_upgrade_restart",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/borg_service
	id = TECHWEB_NODE_BORG_SERVICES
	display_name = "服务型半机械人升级"
	description = "让它们照着食谱做饭吧。"
	prereq_ids = list(TECHWEB_NODE_CYBERNETICS)
	design_ids = list(
		"borg_upgrade_rolling_table",
		"borg_upgrade_condiment_synthesizer",
		"borg_upgrade_silicon_knife",
		"borg_upgrade_service_apparatus",
		"borg_upgrade_drink_apparatus",
		"borg_upgrade_service_cookbook",
		"borg_upgrade_botany",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/borg_mining
	id = TECHWEB_NODE_BORG_MINING
	display_name = "采矿型半机械人升级"
	description = "去开采人类无法涉足的危险矿点。"
	prereq_ids = list(TECHWEB_NODE_CYBERNETICS)
	design_ids = list(
		"borg_upgrade_lavaproof",
		"borg_upgrade_holding",
		"borg_upgrade_diamonddrill",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/borg_medical
	id = TECHWEB_NODE_BORG_MEDICAL
	display_name = "医疗型半机械人升级"
	description = "让它们遵循阿西莫夫第一法则。"
	prereq_ids = list(TECHWEB_NODE_BORG_SERVICES, TECHWEB_NODE_SURGERY_ADV)
	design_ids = list(
		"borg_upgrade_pinpointer",
		"borg_upgrade_beakerapp",
		"borg_upgrade_defibrillator",
		"borg_upgrade_expandedsynthesiser",
		"borg_upgrade_piercinghypospray",
		"borg_upgrade_surgicalprocessor",
		"borg_upgrade_surgicalomnitool",
		"borg_upgrade_syringe",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/borg_utility
	id = TECHWEB_NODE_BORG_UTILITY
	display_name = "通用型半机械人升级"
	description = "让它们替我们擦地板。"
	prereq_ids = list(TECHWEB_NODE_BORG_SERVICES, TECHWEB_NODE_SANITATION)
	design_ids = list(
		"borg_upgrade_advancedmop",
//		"borg_upgrade_broomer", BUBBERS EDIT, ROUNDSTART MODULE
		"borg_upgrade_expand",
		"borg_upgrade_prt",
		"borg_upgrade_plunger",
		"borg_upgrade_high_capacity_replacer",
		"borg_upgrade_selfrepair",
		"borg_upgrade_thrusters",
		"borg_upgrade_trashofholding",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/borg_utility/New()
	. = ..()
	if(!CONFIG_GET(flag/disable_secborg))
		design_ids += "borg_upgrade_disablercooler"

/datum/techweb_node/borg_engi
	id = TECHWEB_NODE_BORG_ENGI
	display_name = "工程型半机械人升级"
	description = "好更彻底地摸鱼。"
	prereq_ids = list(TECHWEB_NODE_BORG_MINING, TECHWEB_NODE_PARTS_UPG)
	design_ids = list(
		"borg_upgrade_rped",
		"borg_upgrade_engineeringomnitool",
		"borg_upgrade_engineeringapp",
		"borg_upgrade_inducer",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

// Implants root node
/datum/techweb_node/passive_implants
	id = TECHWEB_NODE_PASSIVE_IMPLANTS
	display_name = "被动植入体"
	description = "设计为无需使用者主动操作即可无缝运作的植入体，可增强多种生理功能或持续提供增益。"
	prereq_ids = list(TECHWEB_NODE_AUGMENTATION)
	design_ids = list(
		"skill_station",
		"implant_trombone",
		"implant_chem",
		"implant_tracking",
		"implant_exile",
		"implant_beacon",
		"implant_bluespace",
		"implantcase",
		"implanter",
		"locator",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/cyber_implants
	id = TECHWEB_NODE_CYBER_IMPLANTS
	display_name = "半机械植入体"
	description = "集成于体内的先进技术强化装置，可提升身体能力。"
	prereq_ids = list(TECHWEB_NODE_PASSIVE_IMPLANTS, TECHWEB_NODE_CYBERNETICS)
	design_ids = list(
		"ci-reviver", // BUBBER EDIT - MOVED
		"ci-breather",
		"ci-nutriment",
		"ci-nutrimentplus", // BUBBER EDIT - ADDITION
		"ci-thrusters",
		//"ci-herculean", // BUBBER EDIT - REMOVAL
		"ci-connector",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/New()
	..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_CYBERNETIC_REVOLUTION))
		research_costs[TECHWEB_POINT_TYPE_GENERIC] /= 2

/datum/techweb_node/cyber/combat_implants
	id = TECHWEB_NODE_COMBAT_IMPLANTS
	display_name = "战斗植入体"
	description = "确保你能他妈的醒过来，武士。"
	prereq_ids = list(TECHWEB_NODE_CYBER_IMPLANTS)
	design_ids = list(
		//"ci-reviver", // BUBBER EDIT - MOVED
		"ci-antidrop",
		"ci-antistun",
		"ci-tacvisor",
		"ci-herculean", // BUBBER EDIT - ADDITION
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/integrated_toolsets
	id = TECHWEB_NODE_INTERGRATED_TOOLSETS
	display_name = "集成工具组"
	description = "助手们数十年的违禁品走私史，催生出一整套能无缝嵌入你手臂的工具箱。"
	prereq_ids = list(TECHWEB_NODE_COMBAT_IMPLANTS, TECHWEB_NODE_EXP_TOOLS)
	design_ids = list(
		//"ci-nutrimentplus", // BUBBER EDIT - REMOVAL
		"ci-surgery",
		"ci-surgery-brain",
		"ci-toolset",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/cyber_organs
	id = TECHWEB_NODE_CYBER_ORGANS
	display_name = "半机械器官"
	description = "我们有重建他的技术。"
	prereq_ids = list(TECHWEB_NODE_CYBERNETICS)
	design_ids = list(
		"cybernetic_eyes_improved",
		"cybernetic_eyes_improved_moth",
		"cybernetic_ears_u",
		"cybernetic_ears_u_cat",
		"cybernetic_lungs_tier2",
		"cybernetic_stomach_tier2",
		"cybernetic_liver_tier2",
		"cybernetic_heart_tier2",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/cyber_organs_upgraded
	id = TECHWEB_NODE_CYBER_ORGANS_UPGRADED
	display_name = "升级版半机械器官"
	description = "我们有升级他的技术。"
	prereq_ids = list(TECHWEB_NODE_CYBER_ORGANS)
	design_ids = list(
		"ci-gloweyes",
		"ci-welding",
		"ci-gloweyes-moth",
		"ci-welding-moth",
		"cybernetic_ears_whisper",
		"cybernetic_ears_whisper_cat",
		"cybernetic_ears_volume",
		"cybernetic_ears_volume_cat",
		"cybernetic_lungs_tier3",
		"cybernetic_stomach_tier3",
		"cybernetic_liver_tier3",
		"cybernetic_heart_tier3",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	required_experiments = list(/datum/experiment/scanning/people/augmented_organs)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/cyber_organs_adv
	id = TECHWEB_NODE_CYBER_ORGANS_ADV
	display_name = "高级半机械器官"
	description = "尖端半机械器官，提供增强的感知能力，让检测 ERP 比以往任何时候都更容易。"
	prereq_ids = list(TECHWEB_NODE_CYBER_ORGANS_UPGRADED, TECHWEB_NODE_NIGHT_VISION)
	design_ids = list(
		"cybernetic_ears_xray",
		"cybernetic_ears_xray_cat",
		"ci-thermals",
		"ci-xray",
		"ci-thermals-moth",
		"ci-xray-moth",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	discount_experiments = list(/datum/experiment/scanning/people/android = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)
