/obj/machinery/microwave/frontier_printed
	desc = "一台塑料面板的微波炉，能完成标准微波炉的一切工作。\
		这一台特别设计成能被紧密打包成便于之后在工厂里\
		重新组装的形状。不过，似乎没有附带把它重新折回去的\
		说明书……"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/kitchen_stuff/microwave.dmi'
	circuit = null
	max_n_of_items = 5
	efficiency = 2
	vampire_charging_capable = TRUE

/obj/machinery/microwave/frontier_printed/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/microwave/frontier_printed/RefreshParts()
	. = ..()
	max_n_of_items = 5
	efficiency = 2
	vampire_charging_capable = TRUE

/obj/machinery/microwave/frontier_printed/examine(mob/user)
	. = ..()
	. += span_notice("它无法重新打包，但可以正常拆解。")

/obj/machinery/microwave/frontier_printed/unanchored
	anchored = FALSE

// Deployable item for cargo

/obj/item/flatpacked_machine/macrowave
	name = "微波炉零件包"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/kitchen_stuff/microwave.dmi'
	icon_state = "packed_microwave"
	w_class = WEIGHT_CLASS_NORMAL
	type_to_deploy = /obj/machinery/microwave/frontier_printed
	deploy_time = 2 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
