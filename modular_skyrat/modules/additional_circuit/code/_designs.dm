//Mining Component
/datum/design/component/mining
	name = "采矿元件"
	id = "comp_mine"
	build_path = /obj/item/circuit_component/mining

//Item Interact Component
/datum/design/component/item_interact
	name = "物品交互元件"
	id = "comp_iinteract"
	build_path = /obj/item/circuit_component/item_interact

/datum/techweb_node/comp_advanced_interacts
	id = TECHWEB_NODE_COMP_INTERACTION_COMPONENT
	display_name = "高级动作元件"
	description = "为无人机外壳解锁更高级的动作元件。"
	prereq_ids = list(TECHWEB_NODE_PROGRAMMED_ROBOT)
	design_ids = list(
		"comp_mine",
		"comp_iinteract",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

//Target Scanner Component
/datum/design/component/radar_scanner
	name = "目标扫描器元件"
	id = "comp_tscanner"
	build_path = /obj/item/circuit_component/target_scanner

//Cell Charge Component
/datum/design/component/cell_charge
	name = "电池电量元件"
	id = "comp_ccharge"
	build_path = /obj/item/circuit_component/cell_charge

//Reagent Injector Component (Bluespace)
/datum/design/component/bci/reagent_injector_bluespace
	name = "试剂注射元件（蓝空间）"
	id = "comp_reagent_injector_bluespace"
	build_path = /obj/item/circuit_component/reagent_injector_bluespace

/datum/techweb_node/riot_supression/New()
	. = ..()
	design_ids += "comp_tscanner"
	design_ids += "comp_ccharge"

/datum/techweb_node/syndicate_basic/New()
	. = ..()
	design_ids += "comp_reagent_injector_bluespace"
