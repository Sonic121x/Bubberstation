/obj/item/circuitboard/machine/plantgenes
	name = "植物 DNA 操控器（机器电路板）"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/plantgenes
	req_components = list(
		/datum/stock_part/servo = 1,
		/datum/stock_part/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1,
		/datum/stock_part/scanning_module = 1)

/obj/item/circuitboard/machine/megacell_charger
	name = "巨型电池充电器（机器电路板）"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/cell_charger/mega
	req_components = list(/datum/stock_part/capacitor = 3)
	needs_anchored = FALSE
