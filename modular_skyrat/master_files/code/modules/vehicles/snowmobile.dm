/obj/vehicle/ridden/atv/snowmobile
	name = "雪地摩托"
	desc = "一辆专为雪地使用而设计的履带式载具，不过看起来在其他地形上会寸步难行。"
	icon_state = "snowmobile"
	icon = 'modular_skyrat/master_files/icons/obj/vehicles/vehicles.dmi'
	var/static/list/snow_typecache = typecacheof(list(/turf/open/misc/asteroid/snow/icemoon, /turf/open/floor/plating/snowed/smoothed/icemoon))

/obj/vehicle/ridden/atv/snowmobile/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if (QDELETED(src))
		return
	var/datum/component/riding/riding_component = LoadComponent(/datum/component/riding)
	if(snow_typecache[loc.type])
		riding_component.vehicle_move_delay = 1
	else
		riding_component.vehicle_move_delay = 2

/obj/vehicle/ridden/atv/snowmobile/snowcurity
	name = "安保雪地摩托"
	desc = "当你想比骑安保平衡车显得更像一个工具人时，就选它。"
	icon_state = "snowcurity"
	icon = 'modular_skyrat/master_files/icons/obj/vehicles/vehicles.dmi'
	key_type = /obj/item/key/security

/datum/component/riding/vehicle/atv/snowmobile/snowcurity
	keytype = /obj/item/key/security

// This should eventually be fixed upstream by adding make_ridable to the base ATV definition
// or, ideally, to /obj/vehicle/ridden so that it's not duplicated all over the codebase
// for wheelchairs, scooters, and snowmobiles alike.
/obj/vehicle/ridden/atv/snowmobile/snowcurity/Initialize(mapload)
	. = ..()
	// We shouldn't have the ridable component added while still in Initialize,
	// so this is hopefully safe to do.
	RemoveElement(/datum/element/ridable)
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/atv/snowmobile/snowcurity)


/obj/vehicle/ridden/atv/snowmobile/syndicate
	name = "雪地摩托"
	desc = "一辆专为雪地使用而设计的履带式载具，绘有辛迪加配色的徽记。"
	icon_state = "syndimobile"
	icon = 'modular_skyrat/master_files/icons/obj/vehicles/vehicles.dmi'

