/obj/machinery/griddle/frontier_tabletop
	name = "桌面铁板烤盘"
	desc = "一种足够纤薄的铁板烤盘，能轻松架在桌子上面，无需大费周章。这一型号专门设计成\
		可拆成许多部件、运往银河各处。这使它成了各地快闪小吃摊和\
		殖民地厨房的最爱。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/kitchen_stuff/griddle.dmi'
	icon_state = "griddletable_off"
	variant = "table"
	pass_flags_self = LETPASSTHROW
	pass_flags = PASSTABLE
	circuit = null
	// Lines up perfectly with tables when anchored on them
	anchored_tabletop_offset = 3
	/// What type this repacks into
	var/repacked_type = /obj/item/flatpacked_machine/frontier_griddle

/obj/machinery/griddle/frontier_tabletop/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 2 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/griddle/frontier_tabletop/unanchored
	anchored = FALSE

// Deployable item for cargo

/obj/item/flatpacked_machine/frontier_griddle
	name = "扁平包装桌面铁板烤盘"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/kitchen_stuff/griddle.dmi'
	icon_state = "griddle_parts"
	w_class = WEIGHT_CLASS_NORMAL
	type_to_deploy = /obj/machinery/griddle/frontier_tabletop
	deploy_time = 2 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
