/datum/techweb_node/fundamental_sci
	display_name = "基础科学"
	description = "奠定科学认知的基石，为更深入的探索与理论探究铺平道路。"
	node_flags = parent_type::node_flags | TECHWEB_NODE_STARTER
	unlocked_designs = list(
		/datum/design/board/rdserver,
		/datum/design/board/rdservercontrol,
		/datum/design/board/rdconsole,
		/datum/design/tech_disk,
		/datum/design/board/doppler_array,
		/datum/design/board/experimentor,
		/datum/design/board/destructive_analyzer,
		/datum/design/board/destructive_scanner,
		/datum/design/experi_scanner,
		/datum/design/laptop,
		/datum/design/portabledrive/basic,
		/datum/design/portabledrive/advanced,
		/datum/design/portabledrive/super,
	)

/datum/techweb_node/bluespace_theory
	display_name = "蓝空间理论"
	description = "对被称为蓝空间的神秘异维度进行的基础研究。"
	prerequisite_nodes = list(/datum/techweb_node/fundamental_sci)
	unlocked_designs = list(
		/datum/design/bluespace_crystal,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/applied_bluespace
	display_name = "应用蓝空间研究"
	description = "在对蓝空间动力学有了更深的把握之后，便可利用蓝空间晶体分析数据设计出精密的运用与技术。"
	prerequisite_nodes = list(/datum/techweb_node/bluespace_theory)
	unlocked_designs = list(
		/datum/design/board/ore_silo,
		/datum/design/miningsatchel_holding,
		/datum/design/board/plumbing_receiver,
		/datum/design/bluespacebeaker,
		/datum/design/adv_watering_can,
		/datum/design/coffeepot_bluespace,
		/datum/design/bluespacesyringe,
		/datum/design/blutrash,
		/datum/design/light_replacer_blue,
		/datum/design/bluespacebodybag,
		/datum/design/radio_navigation_beacon,
		/datum/design/board/gas_receiver,
		/datum/design/board/bluespace_scrubber,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	discount_experiments = list(/datum/experiment/scanning/points/bluespace_crystal = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL, RADIO_CHANNEL_SERVICE, RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/bluespace_travel
	display_name = "蓝空间旅行"
	description = "基于蓝空间原理推广传送手段，以彻底革新后勤效率。"
	prerequisite_nodes = list(/datum/techweb_node/applied_bluespace)
	unlocked_designs = list(
		/datum/design/board/teleconsole,
		/datum/design/board/teleport_station,
		/datum/design/board/teleport_hub,
		/datum/design/board/launchpad_console,
		/datum/design/board/quantumpad,
		/datum/design/board/launchpad,
		/datum/design/bluespace_pod,
		/datum/design/quantum_keycard,
		/datum/design/swapper,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/anomaly_research
	display_name = "异常研究"
	description = "深入研究神秘的异常现象，探索精炼并驾驭其不可预测能量的方法。"
	prerequisite_nodes = list(/datum/techweb_node/applied_bluespace)
	unlocked_designs = list(
		/datum/design/board/anomaly_refinery,
		/datum/design/anomaly_neutralizer,
		/datum/design/reactive_armour,
		/datum/design/space_furnace,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/anomaly_shells
	display_name = "高级异常外壳"
	description = "旨在利用异常核心的新型外壳，以创新的方式最大化其潜力。"
	prerequisite_nodes = list(/datum/techweb_node/anomaly_research)
	unlocked_designs = list(
		/datum/design/bag_holding,
		/datum/design/cybernetic_heart/anomalock,
		/datum/design/module/mod_storage_holding,
		/datum/design/wormhole_projector,
		/datum/design/gravitygun,
		/datum/design/polymorph_belt,
		/datum/design/perceptomatrix,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	discount_experiments = list(/datum/experiment/scanning/points/anomalies = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)
