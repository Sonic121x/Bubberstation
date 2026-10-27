/datum/techweb_node/bio_scan
	id = TECHWEB_NODE_BIO_SCAN
	display_name = "生物扫描"
	description = "用于分析患者健康状况与试剂成分的先进技术，确保医疗舱能进行精确诊断与治疗。"
	prereq_ids = list(TECHWEB_NODE_MEDBAY_EQUIP)
	design_ids = list(
		"healthanalyzer",
		"autopsyscanner",
		"genescanner",
		"medical_kiosk",
		"chem_master",
		"ph_meter",
		"scigoggles",
		"mod_reagent_scanner",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/cytology
	id = TECHWEB_NODE_CYTOLOGY
	display_name = "细胞学"
	description = "以细胞培养肢体及各类生物为方向的细胞生物学研究。"
	prereq_ids = list(TECHWEB_NODE_BIO_SCAN)
	design_ids = list(
		"limbgrower",
		"pandemic",
		"vatgrower",
		"petri_dish",
		"swab",
		"biopsy_tool",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/xenobiology
	id = TECHWEB_NODE_XENOBIOLOGY
	display_name = "异种生物学"
	description = "对非人类生物学的探索，揭开外星生命形式及其独特生理过程的秘密。"
	prereq_ids = list(TECHWEB_NODE_CYTOLOGY)
	design_ids = list(
		"xenobioconsole",
		"slime_scanner",
		/* BUBBER EDIT REMOVE - LIMB GROWERS INCLUDE ALL LIMB TYPES
		"limbdesign_ethereal",
		"limbdesign_felinid",
		"limbdesign_lizard",
		"limbdesign_plasmaman",
		*/
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	discount_experiments = list(/datum/experiment/scanning/cytology/slime = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/gene_engineering
	id = TECHWEB_NODE_GENE_ENGINEERING
	display_name = "基因工程"
	description = "对精细 DNA 操作技术的研究，可改造人类遗传性状，从而解锁特定能力与强化。"
	prereq_ids = list(TECHWEB_NODE_SELECTION, TECHWEB_NODE_XENOBIOLOGY)
	design_ids = list(
		"dnascanner",
		"scan_console",
		"dna_disk",
		"dnainfuser",
		"mod_dna_lock",
		"fleshreshaper",
		"fleshreshapermed",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/scanning/people/mutant = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

// Botany root node
/datum/techweb_node/botany_equip
	id = TECHWEB_NODE_BOTANY_EQUIP
	starting_node = TRUE
	display_name = "植物学设备"
	description = "维护站内花园的基本工具，支持植物在空间站独特环境中的生长。"
	design_ids = list(
		"seed_extractor",
		"plant_analyzer",
		"watering_can",
		"spade",
		"cultivator",
		"secateurs",
		"hatchet",
	)

/datum/techweb_node/hydroponics
	id = TECHWEB_NODE_HYDROPONICS
	display_name = "水培学"
	description = "对先进水培系统的研究，以实现高效且可持续的植物栽培。"
	prereq_ids = list(TECHWEB_NODE_BOTANY_EQUIP, TECHWEB_NODE_CHEM_SYNTHESIS)
	design_ids = list(
		"biogenerator",
		"hydro_tray",
		"portaseeder",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SERVICE)

/datum/techweb_node/selection
	id = TECHWEB_NODE_SELECTION
	display_name = "人工选择"
	description = "通过人工选择推进植物栽培技术，可精确操控植物的 DNA。"
	prereq_ids = list(TECHWEB_NODE_HYDROPONICS)
	design_ids = list(
		"flora_gun",
		"gene_shears",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	required_experiments = list(/datum/experiment/scanning/random/plants/wild)
	discount_experiments = list(/datum/experiment/scanning/random/plants/traits = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SERVICE)
