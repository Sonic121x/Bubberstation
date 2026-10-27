/obj/machinery/power/port_gen/pacman/solid_fuel
	name = "\improper S.O.F.I.E. 型便携式发电机"
	desc = "银河系中第二常见的发电机设计，仅次于 P.A.C.M.A.N.。\
		S.O.F.I.E.（固定式运行燃料点火引擎）与其他发电机一样，\
		通过燃烧等离子体板来发电。\
		不过，与其它发电机不同，这一台既不算便携，操作起来也没那么安全，\
		但至少它能发出多得多的电力。使用前必须<b>用螺栓固定在地面上</b>\
		并<b>接上电线</b>。一张硕大的警告标签想让你知道，这台发电机\
		会<b>向周围空气排放废热与废气</b>。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	icon_state = "fuel_generator_0"
	base_icon_state = "fuel_generator"
	circuit = null
	anchored = TRUE
	max_sheets = 25
	time_per_sheet = 100
	power_gen = 12500
	drag_slowdown = 1.5
	sheet_path = /obj/item/stack/sheet/mineral/plasma
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/fuel_generator

/obj/machinery/power/port_gen/pacman/solid_fuel/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 1 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	if(!mapload)
		flick("fuel_generator_deploy", src)

// previously NO_DECONSTRUCTION
/obj/machinery/power/port_gen/pacman/solid_fuel/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/power/port_gen/pacman/solid_fuel/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/power/port_gen/pacman/solid_fuel/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

// We don't need to worry about the board, this machine doesn't have one!
/obj/machinery/power/port_gen/pacman/solid_fuel/on_construction(mob/user, from_flatpack)
	return

/obj/machinery/power/port_gen/pacman/solid_fuel/process()
	. = ..()
	if(active)
		var/turf/where_we_spawn_air = get_turf(src)
		where_we_spawn_air.atmos_spawn_air("co2=10;TEMP=480") // Standard UK diesel engine operating temp is about 220 celsius or ~473 K

// Item for creating the generator or carrying it around

/obj/item/flatpacked_machine/fuel_generator
	name = "扁平包装 S.O.F.I.E. 型便携式发电机"
	icon_state = "fuel_generator_packed"
	type_to_deploy = /obj/machinery/power/port_gen/pacman/solid_fuel
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
