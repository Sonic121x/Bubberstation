// RESEARCH NODES

// cyber nodes
/datum/techweb_node/cyber/empathy_implant
	id = TECHWEB_NODE_EMPATHY_IMPLANT
	display_name = "共情传感器植入体"
	description = "对拥有特殊心智者进行绝对合乎伦理的实验后所得的成果。"
	prereq_ids = list(TECHWEB_NODE_CYBER_IMPLANTS)
	design_ids = list(
		"ci_empathic_sensor",
	)
	required_experiments = list(/datum/experiment/scanning/people/open_minds)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cyber/cyber_implants/New()
	. = ..()
	design_ids += list(
		"ci-scanner",
		"ci-gloweyes",
		"ci-welding",
		"ci-medhud",
		"ci-sechud",
		"ci-diaghud",
		"ci-civhud",
		"ci-botany",
		"ci-janitor",
		"ci-lighter",
		"ci-razor",
	)

/datum/techweb_node/cyber/cyber_organs_upgraded/New()
	. = ..()
	design_ids += list(
		"limbdesign_adaptive_lungs",
	)
	design_ids -= list(
		"ci-gloweyes",
		"ci-welding",
	)

/datum/techweb_node/cyber/combat_implants/New()
	. = ..()
	design_ids += list(
		"ci-mantis",
		"ci-flash",
		"ci-antisleep",
	)

/datum/techweb_node/cyber/night_vision_implants
	id = TECHWEB_NODE_NIGHT_VISION_IMPLANTS
	display_name = "夜视植入体"
	description = "现在你可以通宵工作了，哪怕弄丢了眼镜！"
	prereq_ids = list(TECHWEB_NODE_NIGHT_VISION, TECHWEB_NODE_CYBER_IMPLANTS)
	design_ids = list(
		"ci-nv",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)


/datum/techweb_node/botanygene
	id = TECHWEB_NODE_BOTANY_ADV
	display_name = "实验性植物工程学"
	description = "植物培育技术与机械的进一步进展，可对植物 DNA 进行精细操作。"
	prereq_ids = list(TECHWEB_NODE_PARTS_ADV, TECHWEB_NODE_SELECTION)
	design_ids = list(
		"diskplantgene",
		"plantgene",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)

/datum/techweb_node/parts_bluespace/New()
	. = ..()
	design_ids += list(
		"bs_experi_scanner"
	)

//Research borg tech node
/datum/techweb_node/borg_research
	id = TECHWEB_NODE_BORG_RESEARCH
	display_name = "研究型半机械人升级"
	description = "它们现在要抢我们的饭碗了！"
	prereq_ids = list(TECHWEB_NODE_BORG_ENGI, TECHWEB_NODE_BORG_MEDICAL)
	design_ids = list(
		"bs_experi_scanner_cyborg",
		"borg_upgrade_advancedanalyzer",
		"borg_upgrade_inducer_sci",
		"borg_upgrade_brped",
		"borg_upgrade_surgicalprocessor_sci",
		"borg_upgrade_research_rcd"
	)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)

//Mining borg upgrades
/datum/techweb_node/borg_mining/New()
	.=..()
	design_ids += list(
		"borg_upgrade_advcutter",
		"borg_upgrade_welding",
	)


/datum/techweb_node/ai_laws/New()
	. = ..()
	design_ids += list(
		"crewsimov",
		"crewsimovpp",
		"ntos",
	)

// MEDICAL
/datum/techweb_node/cyber/cyber_implants/New()
	. = ..()
	design_ids += list(
		"wound_scanner_internal"
	)

/datum/techweb_node/medbay_equip/New()
	. = ..()
	design_ids += list(
		"defibrillator",
	)

//ENGINEERING
/datum/techweb_node/atmos/New()
	. = ..()
	design_ids += list(
		"nitrogen_tank",
		//"nitrogen_tank_belt", | Uncomment in case nitrogen internal tanks get refactored to no longer be 25L
		"anesthetic_tank",
	)

// TOOLS

/datum/techweb_node/mining/New()
	. = ..()
	design_ids += list(
		"interdyne_mining_equipment_vendor",
	)

// Robotics Tech

/datum/techweb_node/borg_engi/New()
	. = ..()
	design_ids += list(
		"rld_cyborg"
	)

/datum/techweb_node/borg_utility/New()
	design_ids += list(
		"borg_upgrade_detailer",
		"rld_cyborg_janitor",
		"cable_coil_cyborg"
	)
	return ..()

/datum/techweb_node/borg_medical/New()
	design_ids += list(
		"borg_upgrade_pinpointer",
	)
	return ..()

/datum/techweb_node/augmentation/New()
	. = ..()
	design_ids += list(
		"blanksynth",
		"dominatrixmodule",
		"obediencemodule",
		"borg_upgrade_expand",
		"borg_upgrade_shrink",
		"waddle_module"
	)

/datum/techweb_node/borg_utility/New()
	. = ..()
	design_ids -= list(
		"borg_upgrade_expand" // Moved to default robotics, always available. It provides no practical benefit so it shouldn't be here
	)

/datum/techweb_node/borg_mining/New()
	. = ..()
	design_ids += list(
		"pinpointer_vent_cyborg",
		"adv_xenoarchbag_cyborg",
		"pka_railgun_cyborg",
		"pka_repeater_cyborg",
		"pka_shotgun_cyborg",
		"pka_pistol_cyborg",
		"pka_shockwave_cyborg",
		"pka_m79_cyborg",
	)
/datum/techweb_node/mechlaunchpad
	id = TECHWEB_NODE_MECHLAUNCHPAD
	display_name = "机甲后勤解决方案"
	description = "蓝空间技术应用的进步，使我们能将机甲从工坊迅速运送至目的地。"
	prereq_ids = list(TECHWEB_NODE_BLUESPACE_TRAVEL, TECHWEB_NODE_MECH_EQUIPMENT)
	design_ids = list(
		"mechlauncher_pad",
		"mechlauncher_console",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

// Computer Tech
/datum/techweb_node/gaming/New()
	. = ..()
	design_ids += list(
		"minesweeper",
	)

// Security Tech

/datum/techweb_node/riot_supression/New()
	design_ids += "s12g_rubber"
	design_ids += "s12g_bslug"
	design_ids += "s12g_br"
	design_ids += "s12g_incinslug"
	design_ids += "wt550_ammo_normal"
	design_ids += "m9mm_mag"
	design_ids += "m45_mag"
	design_ids += "solgrenade_mag"
	design_ids += "ntusp_conversion"
	design_ids += "ntusp_powerpack"
	design_ids += "ntmp5_powerpack"
	. = ..()

/datum/techweb_node/exotic_ammo/New()
	design_ids += "wt550_ammo_ap"
	design_ids += "wt550_ammo_compressed"
	. = ..()

/datum/techweb_node/syndicate_basic/New()
	design_ids += "wt550_ammo_incendiary"
	design_ids += "s12g_db"
	design_ids += "mod_mind_transfer"
	. = ..()

/datum/techweb_node/bullet_weapons //This is for advanced bullet weapon designs and upgrades
	id = TECHWEB_NODE_BULLET_WEAPONS
	display_name = "高级弹道武器"
	description = "说得好像开枪还能更复杂似的。"
	prereq_ids = list(TECHWEB_NODE_EXOTIC_AMMO)
	design_ids = list(
		"wt550_burst",
		"wt550_long",
		"battle_rifle_basic",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/advanced_armor //This is for advanced armor and shields
	id = TECHWEB_NODE_ADVANCED_ARMOR
	display_name = "高级安保防护"
	description = "如果伤不到他们，那我们就耗赢他们。"
	prereq_ids = list(TECHWEB_NODE_RIOT_SUPRESSION, TECHWEB_NODE_GAS_COMPRESSION)
	design_ids = list(
		"security_juggernaut"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

// Modsuit tech
/datum/techweb_node/mod_equip/New()
	. = ..()
	design_ids += list("mod_remote_module")

/datum/techweb_node/nerd
	id = TECHWEB_NODE_NERD
	display_name = "理论物理学"
	description = "他们问我有多懂理论物理学。我说我有一个理论物理学学位。"
	prereq_ids = list(
		TECHWEB_NODE_ROBOTICS, //Suit AI
		TECHWEB_NODE_CHEM_SYNTHESIS, //Wound analyzer (and morphine production).
		TECHWEB_NODE_MOD_ENGI //Suit protection.
	)
	design_ids = list(
		"nerd_suit",
		"nerd_glases"
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS
	)

/datum/techweb_node/advanced_nerd
	id = TECHWEB_NODE_NERD_ADV
	display_name = "高级理论物理学"
	description = "科学家不该有枪。"
	prereq_ids = list(
		TECHWEB_NODE_ALIENTECH, //Memes.
		TECHWEB_NODE_ANOMALY_SHELLS, //Physgun
		TECHWEB_NODE_NERD, //Previous tier
		TECHWEB_NODE_EXP_TOOLS //Crowbar
	)
	design_ids = list(
		"physgun",
		"fast_crowbar"
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS
	)

/datum/techweb_node/mod_equip/New()
	design_ids += list("mod_protean_servo", "mod_hat_stabilizer",
	)
	. = ..()
