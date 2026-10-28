//Mining Component
/datum/design/component/mining
	name = "采矿元件"
	build_path = /obj/item/circuit_component/mining

//Item Interact Component
/datum/design/component/item_interact
	name = "物品交互元件"
	build_path = /obj/item/circuit_component/item_interact

/datum/techweb_node/comp_advanced_interacts
	display_name = "高级动作元件"
	description = "为无人机外壳解锁更高级的动作元件。"
	prerequisite_nodes = list(/datum/techweb_node/programmed_robot)
	unlocked_designs = list(
		/datum/design/component/mining,
		/datum/design/component/item_interact,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

//Target Scanner Component
/datum/design/component/radar_scanner
	name = "目标扫描器元件"
	build_path = /obj/item/circuit_component/target_scanner

//Cell Charge Component
/datum/design/component/cell_charge
	name = "电池电量元件"
	build_path = /obj/item/circuit_component/cell_charge

//Reagent Injector Component (Bluespace)
/datum/design/component/bci/reagent_injector_bluespace
	name = "试剂注射元件（蓝空间）"
	build_path = /obj/item/circuit_component/reagent_injector_bluespace

/datum/techweb_node/riot_supression/New()
	. = ..()
	unlocked_designs += /datum/design/component/radar_scanner
	unlocked_designs += /datum/design/component/cell_charge

/datum/techweb_node/syndicate_basic/New()
	. = ..()
	unlocked_designs += /datum/design/component/bci/reagent_injector_bluespace
