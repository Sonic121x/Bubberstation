/datum/techweb_node/augmentation
	display_name = "义体改造"
	description = "献给那些偏爱闪亮金属胜过柔软血肉的人。"
	node_flags = parent_type::node_flags | TECHWEB_NODE_STARTER
	prerequisite_nodes = list(/datum/techweb_node/robotics)
	unlocked_designs = list(
		/datum/design/borg_chest,
		/datum/design/borg_head,
		/datum/design/borg_l_arm,
		/datum/design/borg_l_leg,
		/datum/design/borg_r_arm,
		/datum/design/borg_r_leg,
		/datum/design/borg_suit,
		/datum/design/cybernetic_eyes,
		/datum/design/cybernetic_eyes/moth,
		/datum/design/cybernetic_ears,
		/datum/design/cybernetic_ears/cat,
		/datum/design/cybernetic_lungs,
		/datum/design/cybernetic_stomach,
		/datum/design/cybernetic_liver,
		/datum/design/cybernetic_heart,
	)
	experiments_to_unlock = list(
		/datum/experiment/scanning/people/android,
	)

/datum/techweb_node/cybernetics
	display_name = "半机械人学"
	description = "搭载预装工具模块与可编程法则的智慧机器人。"
	prerequisite_nodes = list(/datum/techweb_node/augmentation)
	unlocked_designs = list(
		/datum/design/board/robocontrol,
		/datum/design/board/cyborgrecharger,
		/datum/design/posibrain,
		/datum/design/mmi,
		/datum/design/mmi/medical,
		/datum/design/advanced_l_arm,
		/datum/design/advanced_r_arm,
		/datum/design/advanced_l_leg,
		/datum/design/advanced_r_leg,
		/datum/design/borg_upgrade_rename,
		/datum/design/borg_upgrade_restart,
		/datum/design/cybernetic_fangs,
		/datum/design/cybernetic_fangs/cat,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/borg_service
	display_name = "服务型半机械人升级"
	description = "让它们照着食谱做饭吧。"
	prerequisite_nodes = list(/datum/techweb_node/cybernetics)
	unlocked_designs = list(
		/datum/design/borg_upgrade_rolling_table,
		/datum/design/borg_upgrade_condiment_synthesizer,
		/datum/design/borg_upgrade_silicon_knife,
		/datum/design/borg_upgrade_service_apparatus,
		/datum/design/borg_upgrade_drink_apparatus,
		/datum/design/borg_upgrade_service_cookbook,
		/datum/design/borg_upgrade_botany,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/borg_mining
	display_name = "采矿型半机械人升级"
	description = "去开采人类无法涉足的危险矿点。"
	prerequisite_nodes = list(/datum/techweb_node/cybernetics)
	unlocked_designs = list(
		/datum/design/borg_upgrade_lavaproof,
		/datum/design/borg_upgrade_holding,
		/datum/design/borg_upgrade_diamonddrill,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/borg_medical
	display_name = "医疗型半机械人升级"
	description = "让它们遵循阿西莫夫第一法则。"
	prerequisite_nodes = list(/datum/techweb_node/borg_service, /datum/techweb_node/surgery_adv)
	unlocked_designs = list(
		/datum/design/borg_upgrade_pinpointer,
		/datum/design/borg_upgrade_beaker_app,
		/datum/design/borg_upgrade_defibrillator,
		/datum/design/borg_upgrade_expandedsynthesiser,
		/datum/design/borg_upgrade_piercinghypospray,
		/datum/design/borg_upgrade_surgicalprocessor,
		/datum/design/borg_upgrade_surgicalomnitool,
		/datum/design/borg_upgrade_syringe,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/borg_utility
	display_name = "通用型半机械人升级"
	description = "让它们替我们擦地板。"
	prerequisite_nodes = list(/datum/techweb_node/borg_service, /datum/techweb_node/sanitation)
	unlocked_designs = list(
		/datum/design/borg_upgrade_advancedmop,
//		/datum/design/borg_upgrade_broomer, BUBBERS EDIT, ROUNDSTART MODULE
		/datum/design/borg_upgrade_expand,
		/datum/design/borg_upgrade_prt,
		/datum/design/borg_upgrade_plunger,
		/datum/design/borg_upgrade_high_capacity_replacer,
		/datum/design/borg_upgrade_selfrepair,
		/datum/design/borg_upgrade_thrusters,
		/datum/design/borg_upgrade_trashofholding,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/borg_utility/New()
	. = ..()
	if(!CONFIG_GET(flag/disable_secborg))
		unlocked_designs += /datum/design/borg_upgrade_disablercooler

/datum/techweb_node/borg_engi
	display_name = "工程型半机械人升级"
	description = "好更彻底地摸鱼。"
	prerequisite_nodes = list(/datum/techweb_node/borg_mining, /datum/techweb_node/parts_upg)
	unlocked_designs = list(
		/datum/design/borg_upgrade_rped,
		/datum/design/borg_upgrade_engineeringomnitool,
		/datum/design/borg_upgrade_engineering_app,
		/datum/design/borg_upgrade_inducer,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

// Implants root node
/datum/techweb_node/passive_implants
	display_name = "被动植入体"
	description = "设计为无需使用者主动操作即可无缝运作的植入体，可增强多种生理功能或持续提供增益。"
	prerequisite_nodes = list(/datum/techweb_node/augmentation)
	unlocked_designs = list(
		/datum/design/board/skill_station,
		/datum/design/implant_sadtrombone,
		/datum/design/implant_chem,
		/datum/design/implant_tracking,
		/datum/design/implant_exile,
		/datum/design/implant_beacon,
		/datum/design/implant_bluespace,
		/datum/design/implantcase,
		/datum/design/implanter,
		/datum/design/locator,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/cyber_implants
	display_name = "半机械植入体"
	description = "集成于体内的先进技术强化装置，可提升身体能力。"
	prerequisite_nodes = list(/datum/techweb_node/passive_implants, /datum/techweb_node/cybernetics)
	unlocked_designs = list(
		/datum/design/cyberimp_breather,
		/datum/design/cyberimp_nutriment,
		/datum/design/cyberimp_thrusters,
		/datum/design/cyberimp_herculean,
		/datum/design/cyberimp_connector,
		/datum/design/cyberimp_nutriment_plus, // BUBBER EDIT - ADDITION
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/New()
	. = ..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_CYBERNETIC_REVOLUTION))
		research_costs[TECHWEB_POINT_TYPE_GENERIC] /= 2

/datum/techweb_node/cyber/combat_implants
	display_name = "战斗植入体"
	description = "确保你能他妈的醒过来，武士。"
	prerequisite_nodes = list(/datum/techweb_node/cyber/cyber_implants)
	unlocked_designs = list(
		/datum/design/cyberimp_reviver,
		/datum/design/cyberimp_antidrop,
		/datum/design/cyberimp_antistun,
		/datum/design/cyberimp_tacvisor,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/integrated_toolsets
	display_name = "集成工具组"
	description = "助手们数十年的违禁品走私史，催生出一整套能无缝嵌入你手臂的工具箱。"
	prerequisite_nodes = list(/datum/techweb_node/cyber/combat_implants, /datum/techweb_node/exp_tools)
	unlocked_designs = list(
		///datum/design/cyberimp_nutriment_plus, // BUBBER EDIT - REMOVAL
		/datum/design/cyberimp_surgical,
		/datum/design/cyberimp_surgery_brain,
		/datum/design/cyberimp_toolset,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/cyber_organs
	display_name = "半机械器官"
	description = "我们有重建他的技术。"
	prerequisite_nodes = list(/datum/techweb_node/cybernetics)
	unlocked_designs = list(
		/datum/design/cybernetic_eyes/improved,
		/datum/design/cybernetic_eyes/improved/moth,
		/datum/design/cybernetic_ears_u,
		/datum/design/cybernetic_ears_u/cat,
		/datum/design/cybernetic_lungs/tier2,
		/datum/design/cybernetic_stomach/tier2,
		/datum/design/cybernetic_liver/tier2,
		/datum/design/cybernetic_heart/tier2,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/cyber_organs_upgraded
	display_name = "升级版半机械器官"
	description = "我们有升级他的技术。"
	prerequisite_nodes = list(/datum/techweb_node/cyber/cyber_organs)
	unlocked_designs = list(
		/datum/design/cyberimp_gloweyes,
		/datum/design/cyberimp_welding,
		/datum/design/cyberimp_gloweyes/moth,
		/datum/design/cyberimp_welding/moth,
		/datum/design/cybernetic_ears_whisper,
		/datum/design/cybernetic_ears_whisper/cat,
		/datum/design/cybernetic_ears_volume,
		/datum/design/cybernetic_ears_volume/cat,
		/datum/design/cybernetic_lungs/tier3,
		/datum/design/cybernetic_stomach/tier3,
		/datum/design/cybernetic_liver/tier3,
		/datum/design/cybernetic_heart/tier3,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	required_experiments = list(/datum/experiment/scanning/people/augmented_organs)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/cyber_organs_adv
	display_name = "高级半机械器官"
	description = "尖端半机械器官，提供增强的感知能力，让检测 ERP 比以往任何时候都更容易。"
	prerequisite_nodes = list(/datum/techweb_node/cyber/cyber_organs_upgraded, /datum/techweb_node/night_vision)
	unlocked_designs = list(
		/datum/design/cybernetic_ears_xray,
		/datum/design/cybernetic_ears_xray/cat,
		/datum/design/cyberimp_thermals,
		/datum/design/cyberimp_xray,
		/datum/design/cyberimp_thermals/moth,
		/datum/design/cyberimp_xray/moth,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	discount_experiments = list(/datum/experiment/scanning/people/android = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)
