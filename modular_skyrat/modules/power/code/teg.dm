/datum/design/board/circulator
	name = "机械设计（循环器电路板）"
	desc = "循环器的电路板。"
	build_path = /obj/item/circuitboard/machine/circulator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/teg
	name = "机械设计（热电发电机电路板）"
	desc = "热电发电机的电路板。"
	build_path = /obj/item/circuitboard/machine/thermoelectric_generator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/adv_power_skyrat
	display_name = "扩展高级电力操控"
	description = "如何获得不同种类的电流。"
	prerequisite_nodes = list(/datum/techweb_node/parts_adv)
	unlocked_designs = list(/datum/design/board/teg, /datum/design/board/circulator)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/scanning/points/machinery_pinpoint_scan/tier2_capacitors = TECHWEB_TIER_3_POINTS)
