/datum/techweb_node/nanite_base
	id = "nanite_base"
	display_name = "基础纳米机器人编程"
	description = "纳米机器人构造与编程的基础。纳米机器人会根据宿主的数量被动产生科学点数。"
	prereq_ids = list(TECHWEB_NODE_BCI)
	design_ids = list(
		// "access_nanites",
		"debugging_nanites",
		"monitoring_nanites",
		"nanite_chamber",
		"nanite_chamber_control",
		"nanite_cloud_control",
		"nanite_comm_remote",
		"nanite_disk",
		"nanite_program_hub",
		"nanite_programmer",
		"nanite_remote",
		"nanite_scanner",
		"public_nanite_chamber",
		"relay_nanites",
		"relay_repeater_nanites",
		"repairing_nanites",
		"repeater_nanites",
		"sensor_nanite_volume",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_smart
	id = "nanite_smart"
	display_name = "智能纳米机器人编程"
	description = "需要纳米机器人执行复杂动作、自主行动、四处游荡或搜寻目标的纳米机器人程序。"
	prereq_ids = list("nanite_base", TECHWEB_NODE_PROGRAMMING)
	design_ids = list(
		"memleak_nanites",
		"metabolic_nanites",
		"purging_nanites",
		"sensor_voice_nanites",
		"stealth_nanites",
		"voice_nanites",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/nanite_mesh
	id = "nanite_mesh"
	display_name = "网状纳米机器人编程"
	description = "需要静态结构与膜结构的纳米机器人程序。"
	prereq_ids = list("nanite_base", TECHWEB_NODE_MOD_ENGI_ADV)
	design_ids = list(
		"conductive_nanites",
		"cryo_nanites",
		"dermal_button_nanites",
		"emp_nanites",
		"hardening_nanites",
		"refractive_nanites",
		"shock_nanites",
		"temperature_nanites",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_bio
	id = "nanite_bio"
	display_name = "生物纳米机器人编程"
	description = "需要复杂生物交互的纳米机器人程序。"
	prereq_ids = list("nanite_base", TECHWEB_NODE_MOD_MEDICAL_ADV)
	design_ids = list(
		"bloodheal_nanites",
		"coagulating_nanites",
		"flesheating_nanites",
		"poison_nanites",
		"sensor_crit_nanites",
		"sensor_damage_nanites",
		"sensor_death_nanites",
		"sensor_health_nanites",
		"sensor_species_nanites",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/nanite_neural
	id = "nanite_neural"
	display_name = "神经纳米机器人编程"
	description = "影响神经与脑组织的纳米机器人程序。"
	prereq_ids = list("nanite_bio")
	design_ids = list(
		"bad_mood_nanites",
		"brainheal_nanites",
		"good_mood_nanites",
		"nervous_nanites",
		"paralyzing_nanites",
		"selfscan_nanites",
		"stun_nanites",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/nanite_synaptic
	id = "nanite_synaptic"
	display_name = "突触纳米机器人编程"
	description = "影响心智与思维的纳米机器人程序。"
	prereq_ids = list("nanite_neural", TECHWEB_NODE_SURGERY_EXP)
	design_ids = list(
		"blinding_nanites",
		"hallucination_nanites",
		"mindshield_nanites",
		"mute_nanites",
		"pacifying_nanites",
		"sleep_nanites",
		// "speech_nanites",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/nanite_harmonic
	id = "nanite_harmonic"
	display_name = "谐和纳米机器人编程"
	description = "需要纳米机器人与生物体无缝整合的纳米机器人程序。研究完成后会被动提高所有纳米云的重生速率。"
	prereq_ids = list("nanite_bio","nanite_smart","nanite_mesh")
	design_ids = list(
		"regenerative_nanites",
		"aggressive_nanites",
		"brainheal_plus_nanites",
		"defib_nanites",
		"fakedeath_nanites",
		"purging_plus_nanites",
		// "regenerative_plus_nanites",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_combat
	id = "nanite_military"
	display_name = "军用纳米机器人编程"
	description = "执行军用级功能的纳米机器人程序。"
	prereq_ids = list("nanite_harmonic", TECHWEB_NODE_SYNDICATE_BASIC)
	design_ids = list(
		// "explosive_nanites",
		"meltdown_nanites",
		"nanite_sting_nanites",
		"pyro_nanites",
		"viral_nanites",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/nanite_hazard
	id = "nanite_hazard"
	display_name = "危险纳米机器人程序"
	description = "极为先进的纳米机器人程序，具有极端危险的潜力。"
	prereq_ids = list("nanite_harmonic", TECHWEB_NODE_ALIENTECH)
	design_ids = list(
		"mindcontrol_nanites",
		"mitosis_nanites",
		// "spreading_nanites",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_replication_protocols
	id = "nanite_replication_protocols"
	display_name = "纳米机器人复制协议"
	description = "覆写默认纳米机器人复制程序的协议，可在特定情况下获得更高效率。"
	prereq_ids = list("nanite_smart")
	design_ids = list(
		"factory_nanites",
		"kickstart_nanites",
		"offline_nanites",
		"pyramid_nanites",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)
	hidden = TRUE
	experimental = TRUE

/datum/techweb_node/nanite_storage_protocols
	id = "nanite_storage_protocols"
	display_name = "纳米机器人储存协议"
	description = "覆写默认纳米机器人储存程序的协议，可获得更高效率或更大容量。"
	prereq_ids = list("nanite_smart")
	design_ids = list(
		"free_range_nanites",
		"hive_nanites",
		"unsafe_storage_nanites",
		"zip_nanites",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)
	hidden = TRUE
	experimental = TRUE
