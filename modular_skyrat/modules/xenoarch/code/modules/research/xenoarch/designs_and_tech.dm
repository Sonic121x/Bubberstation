#define RND_SUBCATEGORY_MACHINE_XENOARCH "/Xenoarchaeology Machinery"
#define RND_SUBCATEGORY_EQUIPMENT_XENOARCH "/Xenoarchaeology Equipment"
#define RND_SUBCATEGORY_TOOLS_XENOARCH "/Xenoarchaeology Tools"
#define RND_SUBCATEGORY_TOOLS_XENOARCH_ADVANCED "/Xenoarchaeology Tools (Advanced)"

/datum/design/xenoarch
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)

/datum/design/xenoarch/tool
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_XENOARCH,
	)

/datum/design/xenoarch/tool/hammer
	desc = "能够缓慢清除奇异岩石上碎屑的锤子。"

/datum/design/xenoarch/tool/hammer/cm1
	name = "锤子（1 厘米）"
	id = "hammer_cm1"
	build_path = /obj/item/xenoarch/hammer/cm1

/datum/design/xenoarch/tool/hammer/cm2
	name = "锤子（2 厘米）"
	id = "hammer_cm2"
	build_path = /obj/item/xenoarch/hammer/cm2

/datum/design/xenoarch/tool/hammer/cm3
	name = "锤子（3 厘米）"
	id = "hammer_cm3"
	build_path = /obj/item/xenoarch/hammer/cm3

/datum/design/xenoarch/tool/hammer/cm4
	name = "锤子（4 厘米）"
	id = "hammer_cm4"
	build_path = /obj/item/xenoarch/hammer/cm4

/datum/design/xenoarch/tool/hammer/cm5
	name = "锤子（5 厘米）"
	id = "hammer_cm5"
	build_path = /obj/item/xenoarch/hammer/cm5

/datum/design/xenoarch/tool/hammer/cm6
	name = "锤子（6 厘米）"
	id = "hammer_cm6"
	build_path = /obj/item/xenoarch/hammer/cm6

/datum/design/xenoarch/tool/hammer/cm10
	name = "锤子（10 厘米）"
	id = "hammer_cm10"
	build_path = /obj/item/xenoarch/hammer/cm10

/datum/design/xenoarch/tool/brush
	name = "刷子"
	desc = "能够缓慢清除奇异岩石上碎屑的刷子。"
	id = "xenoarch_brush"
	build_path = /obj/item/xenoarch/brush

/datum/design/xenoarch/tool/xeno_tape
	name = "异星考古卷尺"
	desc = "用于测量奇异岩石挖掘深度的卷尺。"
	id = "xenoarch_tapemeasure"
	build_path = /obj/item/xenoarch/tape_measure

/datum/design/xenoarch/tool/scanner
	name = "异星考古手持扫描仪"
	desc = "用于奇异岩石的手持扫描仪，可标注“安全”深度和最大深度。"
	id = "xenoarch_handscanner"
	build_path = /obj/item/xenoarch/handheld_scanner

/datum/design/xenoarch/tool/advanced
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_XENOARCH_ADVANCED,
	)


/datum/design/xenoarch/tool/advanced/scanner
	name = "高级异星考古手持扫描仪"
	id = "xenoarch_handscanner_adv"
	build_path = /obj/item/xenoarch/handheld_scanner/advanced

/datum/design/xenoarch/tool/advanced/recoverer
	name = "异星考古手持修复器"
	desc = "能够复原被岁月侵蚀的物品的装置。"
	id = "xenoarch_handrecoverer"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)
	// rebalance material req after first repath/categorization?
	build_path = /obj/item/xenoarch/handheld_recoverer

/datum/design/xenoarch/tool/advanced/adv_hammer
	name = "高级锤子"
	desc = "能够快速清除奇异岩石上碎屑，并调整挖掘深度的锤子。"
	id = "xenoarch_adv_hammer"
	build_path = /obj/item/xenoarch/hammer/adv

/datum/design/xenoarch/tool/advanced/adv_brush
	name = "高级刷子"
	desc = "能够快速清除奇异岩石上碎屑的刷子。"
	id = "xenoarch_adv_brush"
	build_path = /obj/item/xenoarch/brush/adv

/datum/design/xenoarch/equipment
	// everything under this except the adv bag feels redundant because cloth/leather are there too
	// but i guess we'll burn that bridge another time
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_XENOARCH,
	)

/datum/design/xenoarch/equipment/bag
	name = "异星考古袋"
	desc = "可容纳约二十五块奇异岩石或遗物的袋子。"
	id = "xenoarch_bag"
	build_path = /obj/item/storage/bag/xenoarch

/datum/design/xenoarch/equipment/belt
	name = "异星考古腰带"
	desc = "可收纳异星考古所需全部基本工具的腰带。"
	id = "xenoarch_belt"
	build_path = /obj/item/storage/belt/utility/xenoarch

/datum/design/xenoarch/equipment/bag_adv
	name = "高级异星考古袋"
	desc = "可容纳约五十块奇异岩石或遗物的袋子。"
	id = "xenoarch_bag_adv"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	// i kinda hate how this requires diamond, but this is supposed to be a fix pr, burn the gbp on it later
	build_path = /obj/item/storage/bag/xenoarch/adv

/datum/design/board/xenoarch
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_XENOARCH,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/xenoarch/researcher
	name = "机器设计（异星考古研究仪）"
	desc = "可制造用于建造异星考古研究仪的电路板。"
	id = "xeno_researcher"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_researcher

/datum/design/board/xenoarch/scanner
	name = "机器设计（异星考古扫描仪）"
	desc = "可制造用于建造异星考古扫描仪的电路板。"
	id = "xeno_scanner"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_scanner

/datum/design/board/xenoarch/recoverer
	name = "机器设计（异星考古修复器）"
	desc = "可制造用于建造异星考古修复器的电路板。"
	id = "xeno_recoverer"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_recoverer

/datum/design/board/xenoarch/digger
	name = "机器设计（异星考古挖掘机）"
	desc = "可制造用于建造异星考古挖掘机的电路板。"
	id = "xeno_digger"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_digger

/datum/techweb_node/basic_xenoarch
	id = "basic_xenoarch"
	starting_node = TRUE
	display_name = "基础异星考古学"
	description = "异星考古学的基础设计。"
	design_ids = list(
		"hammer_cm1",
		"hammer_cm2",
		"hammer_cm3",
		"hammer_cm4",
		"hammer_cm5",
		"hammer_cm6",
		"hammer_cm10",
		"xenoarch_brush",
		"xenoarch_tapemeasure",
		"xenoarch_handscanner",
	)

/datum/techweb_node/xenoarch_storage
	id = TECHWEB_NODE_XENOARCH_STORAGE
	display_name = "异星考古收纳"
	description = "从事异星考古时，你可能需要一些收纳空间。"
	prereq_ids = list(TECHWEB_NODE_XENOARCH_BASIC)
	design_ids = list(
		"xenoarch_belt",
		"xenoarch_bag",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/xenoarch_machines
	id = TECHWEB_NODE_XENOARCH_MACHINES
	display_name = "异星考古机器"
	description = "异星考古有时很耗时间，也许机器能帮上忙？"
	prereq_ids = list(TECHWEB_NODE_XENOARCH_BASIC)
	design_ids = list(
		"xeno_researcher",
		"xeno_scanner",
		"xeno_recoverer",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/adv_xenoarch
	id = TECHWEB_NODE_XENOARCH_ADVANCED
	display_name = "高级异星考古学"
	description = "用了一阵子后，我们的工具已经过时——该升级了。"
	prereq_ids = list(TECHWEB_NODE_XENOARCH_BASIC, TECHWEB_NODE_XENOARCH_MACHINES, TECHWEB_NODE_XENOARCH_STORAGE)
	design_ids = list(
		"xenoarch_adv_hammer",
		"xenoarch_adv_brush",
		"xenoarch_bag_adv",
		"xenoarch_handscanner_adv",
		"xenoarch_handrecoverer",
		"xeno_digger",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	required_experiments = list(/datum/experiment/scanning/points/xenoarch)

/datum/experiment/scanning/points/xenoarch
	name = "高级异星考古工具"
	description = "我们可以制造更先进的异星考古工具。"
	required_points = 10
	required_atoms = list(
		/obj/item/xenoarch/useless_relic = 1,
		/obj/item/xenoarch/broken_item = 2,
	)

#undef RND_SUBCATEGORY_MACHINE_XENOARCH
#undef RND_SUBCATEGORY_EQUIPMENT_XENOARCH
#undef RND_SUBCATEGORY_TOOLS_XENOARCH
#undef RND_SUBCATEGORY_TOOLS_XENOARCH_ADVANCED
