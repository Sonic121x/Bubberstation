/datum/techweb_node/nanite_base
	display_name = "基础纳米机器人编程"
	description = "纳米机器人构造与编程的基础。纳米机器人会根据宿主的数量被动产生科学点数。"
	prerequisite_nodes = list(/datum/techweb_node/bci)
	unlocked_designs = list(
		// /datum/design/nanites/access,
		/datum/design/nanites/nanite_debugging,
		/datum/design/nanites/monitoring,
		/datum/design/board/nanite_chamber,
		/datum/design/board/nanite_chamber_control,
		/datum/design/board/nanite_cloud_control,
		/datum/design/nanite_comm_remote,
		/datum/design/nanite_disk,
		/datum/design/board/nanite_program_hub,
		/datum/design/board/nanite_programmer,
		/datum/design/nanite_remote,
		/datum/design/nanite_scanner,
		/datum/design/board/public_nanite_chamber,
		/datum/design/nanites/relay,
		/datum/design/nanites/relay_repeater,
		/datum/design/nanites/repairing,
		/datum/design/nanites/repeater,
		/datum/design/nanites/sensor_nanite_volume,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_smart
	display_name = "智能纳米机器人编程"
	description = "需要纳米机器人执行复杂动作、自主行动、四处游荡或搜寻目标的纳米机器人程序。"
	prerequisite_nodes = list(/datum/techweb_node/nanite_base, /datum/techweb_node/programming)
	unlocked_designs = list(
		/datum/design/nanites/memory_leak,
		/datum/design/nanites/metabolic_synthesis,
		/datum/design/nanites/purging,
		/datum/design/nanites/sensor_voice,
		/datum/design/nanites/stealth,
		/datum/design/nanites/voice,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/nanite_mesh
	display_name = "网状纳米机器人编程"
	description = "需要静态结构与膜结构的纳米机器人程序。"
	prerequisite_nodes = list(/datum/techweb_node/nanite_base, /datum/techweb_node/mod_engi_adv)
	unlocked_designs = list(
		/datum/design/nanites/conductive,
		/datum/design/nanites/cryo,
		/datum/design/nanites/dermal_button,
		/datum/design/nanites/emp,
		///datum/design/nanites/hardening, TODO -- REFACTOR THESE
		///datum/design/nanites/refractive,
		/datum/design/nanites/shock,
		/datum/design/nanites/temperature,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_bio
	display_name = "生物纳米机器人编程"
	description = "需要复杂生物交互的纳米机器人程序。"
	prerequisite_nodes = list(/datum/techweb_node/nanite_base, /datum/techweb_node/mod_medical_adv)
	unlocked_designs = list(
		/datum/design/nanites/blood_restoring,
		/datum/design/nanites/coagulating,
		/datum/design/nanites/flesh_eating,
		/datum/design/nanites/poison,
		/datum/design/nanites/sensor_crit,
		/datum/design/nanites/sensor_damage,
		/datum/design/nanites/sensor_death,
		/datum/design/nanites/sensor_health,
		/datum/design/nanites/sensor_species,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/nanite_neural
	display_name = "神经纳米机器人编程"
	description = "影响神经与脑组织的纳米机器人程序。"
	prerequisite_nodes = list(/datum/techweb_node/nanite_bio)
	unlocked_designs = list(
		/datum/design/nanites/bad_mood,
		/datum/design/nanites/brain_heal,
		/datum/design/nanites/good_mood,
		/datum/design/nanites/nervous,
		/datum/design/nanites/paralyzing,
		/datum/design/nanites/self_scan,
		/datum/design/nanites/stun,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/nanite_synaptic
	display_name = "突触纳米机器人编程"
	description = "影响心智与思维的纳米机器人程序。"
	prerequisite_nodes = list(/datum/techweb_node/nanite_neural, /datum/techweb_node/surgery_exp)
	unlocked_designs = list(
		/datum/design/nanites/blinding,
		/datum/design/nanites/hallucination,
		/datum/design/nanites/mindshield,
		/datum/design/nanites/mute,
		/datum/design/nanites/pacifying,
		/datum/design/nanites/sleepy,
		// /datum/design/nanites/speech,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/nanite_harmonic
	display_name = "谐和纳米机器人编程"
	description = "需要纳米机器人与生物体无缝整合的纳米机器人程序。研究完成后会被动提高所有纳米云的重生速率。"
	prerequisite_nodes = list(/datum/techweb_node/nanite_bio, /datum/techweb_node/nanite_smart, /datum/techweb_node/nanite_mesh)
	unlocked_designs = list(
		/datum/design/nanites/regenerative,
		/datum/design/nanites/aggressive_replication,
		/datum/design/nanites/brain_heal_advanced,
		/datum/design/nanites/defib,
		/datum/design/nanites/fake_death,
		/datum/design/nanites/purging_advanced,
		// /datum/design/nanites/regenerative_advanced,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_combat
	display_name = "军用纳米机器人编程"
	description = "执行军用级功能的纳米机器人程序。"
	prerequisite_nodes = list(/datum/techweb_node/nanite_harmonic, /datum/techweb_node/syndicate_basic)
	unlocked_designs = list(
		// /datum/design/nanites/explosive,
		/datum/design/nanites/meltdown,
		/datum/design/nanites/nanite_sting,
		/datum/design/nanites/pyro,
		/datum/design/nanites/viral,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/nanite_hazard
	display_name = "危险纳米机器人程序"
	description = "极为先进的纳米机器人程序，具有极端危险的潜力。"
	prerequisite_nodes = list(/datum/techweb_node/nanite_harmonic, /datum/techweb_node/alien/base)
	unlocked_designs = list(
		/datum/design/nanites/mind_control,
		/datum/design/nanites/mitosis,
		// /datum/design/nanites/spreading,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/nanite_replication_protocols
	display_name = "纳米机器人复制协议"
	description = "覆写默认纳米机器人复制程序的协议，可在特定情况下获得更高效率。"
	prerequisite_nodes = list(/datum/techweb_node/nanite_smart)
	unlocked_designs = list(
		/datum/design/nanites/factory,
		/datum/design/nanites/kickstart,
		/datum/design/nanites/offline,
		/datum/design/nanites/pyramid,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)
	node_flags = TECHWEB_NODE_WIKI | TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL

/datum/techweb_node/nanite_storage_protocols
	display_name = "纳米机器人储存协议"
	description = "覆写默认纳米机器人储存程序的协议，可获得更高效率或更大容量。"
	prerequisite_nodes = list(/datum/techweb_node/nanite_smart)
	unlocked_designs = list(
		/datum/design/nanites/free_range,
		/datum/design/nanites/hive,
		/datum/design/nanites/unsafe_storage,
		/datum/design/nanites/zip,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS, TECHWEB_POINT_TYPE_NANITE = TECHWEB_TIER_3_POINTS)
	node_flags = TECHWEB_NODE_WIKI | TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL
