/obj/machinery/power/rtg/portable
	name = "放射性同位素热电发电机"
	desc = "在“荒无人烟之地”发电的终极选择。与标准 RTG 不同，这一特定\
		设计的发电机舍弃了大多数 RTG 设计都会配备的重型辐射屏蔽。\
		好消息是，这类发电机很擅长为各种用途提供还过得去的\
		涓流电力。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	circuit = null
	power_gen = 7500
	/// What we turn into when we are repacked
	var/repacked_type = /obj/item/flatpacked_machine/rtg

/obj/machinery/power/rtg/portable/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 2 SECONDS)
	AddElement(/datum/element/radioactive)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	if(!mapload)
		flick("rtg_deploy", src)

// previously NO_DECONSTRUCTION
/obj/machinery/power/rtg/portable/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/power/rtg/portable/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/power/rtg/portable/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

// Item for creating the arc furnace or carrying it around
/obj/item/flatpacked_machine/rtg
	name = "扁平包装放射性同位素热电发电机"
	icon_state = "rtg_packed"
	type_to_deploy = /obj/machinery/power/rtg/portable
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
