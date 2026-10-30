/datum/techweb_node/bio_scan
	display_name = "生物扫描"
	description = "用于分析患者健康状况与试剂成分的先进技术，确保医疗舱能进行精确诊断与治疗。"
	prerequisite_nodes = list(/datum/techweb_node/medbay_equip)
	unlocked_designs = list(
		/datum/design/healthanalyzer,
		/datum/design/autopsy_scanner,
		/datum/design/genescanner,
		/datum/design/board/medical_kiosk,
		/datum/design/board/chem_master,
		/datum/design/ph_meter,
		/datum/design/sci_goggles,
		/datum/design/module/mod_reagent_scanner,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cytology
	display_name = "细胞学"
	description = "以细胞培养肢体及各类生物为方向的细胞生物学研究。"
	prerequisite_nodes = list(/datum/techweb_node/bio_scan)
	unlocked_designs = list(
		/datum/design/board/limbgrower,
		/datum/design/board/pandemic,
		/datum/design/board/vatgrower,
		/datum/design/petridish,
		/datum/design/swab,
		/datum/design/biopsy_tool,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/xenobiology
	display_name = "异种生物学"
	description = "对非人类生物学的探索，揭开外星生命形式及其独特生理过程的秘密。"
	prerequisite_nodes = list(/datum/techweb_node/cytology)
	unlocked_designs = list(
		/datum/design/board/xenobiocamera,
		/datum/design/slime_scanner,
		/* BUBBER EDIT REMOVE - LIMB GROWERS INCLUDE ALL LIMB TYPES
		/datum/design/limb_disk/ethereal,
		/datum/design/limb_disk/felinid,
		/datum/design/limb_disk/lizard,
		/datum/design/limb_disk/plasmaman,
		*/
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	discount_experiments = list(/datum/experiment/scanning/cytology/slime = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/gene_engineering
	display_name = "基因工程"
	description = "对精细 DNA 操作技术的研究，可改造人类遗传性状，从而解锁特定能力与强化。"
	prerequisite_nodes = list(/datum/techweb_node/selection, /datum/techweb_node/xenobiology)
	unlocked_designs = list(
		/datum/design/board/dnascanner,
		/datum/design/board/scan_console,
		/datum/design/dna_disk,
		/datum/design/board/dnainfuser,
		/datum/design/module/mod_dna_lock,
		/datum/design/flesh_reshapers,
		/datum/design/flesh_reshapers/medical,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/scanning/people/mutant = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

// Botany root node
/datum/techweb_node/botany_equip
	display_name = "植物学设备"
	description = "维护站内花园的基本工具，支持植物在空间站独特环境中的生长。"
	node_flags = parent_type::node_flags | TECHWEB_NODE_STARTER
	unlocked_designs = list(
		/datum/design/board/seed_extractor,
		/datum/design/plant_analyzer,
		/datum/design/watering_can,
		/datum/design/spade,
		/datum/design/cultivator,
		/datum/design/secateurs,
		/datum/design/hatchet,
	)

/datum/techweb_node/hydroponics
	display_name = "水培学"
	description = "对先进水培系统的研究，以实现高效且可持续的植物栽培。"
	prerequisite_nodes = list(/datum/techweb_node/botany_equip, /datum/techweb_node/chem_synthesis)
	unlocked_designs = list(
		/datum/design/board/biogenerator,
		/datum/design/board/hydroponics,
		/datum/design/portaseeder,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SERVICE)

/datum/techweb_node/selection
	display_name = "人工选择"
	description = "通过人工选择推进植物栽培技术，可精确操控植物的 DNA。"
	prerequisite_nodes = list(/datum/techweb_node/hydroponics)
	unlocked_designs = list(
		/datum/design/flora_gun,
		/datum/design/geneshears,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	required_experiments = list(/datum/experiment/scanning/random/plants/wild)
	discount_experiments = list(/datum/experiment/scanning/random/plants/traits = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SERVICE)
