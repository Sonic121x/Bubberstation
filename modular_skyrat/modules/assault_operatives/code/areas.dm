/area/shuttle/syndicate/cruiser
	name = "辛迪加巡洋舰"
	requires_power = FALSE

/area/shuttle/syndicate/cruiser/bridge
	name = "辛迪加巡洋舰控制室"
	color = COLOR_BLUE

/area/shuttle/syndicate/cruiser/medical
	name = "辛迪加巡洋舰医务室"
	color = COLOR_LIGHT_PINK

/area/shuttle/syndicate/cruiser/armory
	name = "辛迪加巡洋舰军械库"
	color = COLOR_ORANGE

/area/shuttle/syndicate/cruiser/eva
	name = "辛迪加巡洋舰舱外活动装备室"
	color = COLOR_GREEN

/area/shuttle/syndicate/cruiser/hallway

/area/shuttle/syndicate/cruiser/airlock
	name = "辛迪加巡洋舰气闸"
	color = COLOR_RED

/area/shuttle/syndicate/cruiser/brig
	name = "辛迪加巡洋舰拘留区"
	color = COLOR_BLACK

/area/shuttle/syndicate/cruiser/engineering
	name = "辛迪加巡洋舰工程区"
	color = COLOR_YELLOW

/area/shuttle/syndicate/frigate
	name = "辛迪加护卫舰"

/area/cruiser_dock
	name = "黄金眼卫星"
	icon_state = "syndie-ship"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	area_flags = VALID_TERRITORY | UNIQUE_AREA | NOTELEPORT
	ambientsounds = AMBIENCE_GENERIC

/area/cruiser_dock/brig
	name = "巡洋舰停泊区监狱"
	color = COLOR_BLUE
	ambientsounds = AMBIENCE_CREEPY
/obj/machinery/door/poddoor/shutters
	smoothing_groups = SMOOTH_GROUP_SHUTTERS

/turf/closed/wall/r_wall/plastitanium/syndicate/cruiser
	canSmoothWith = SMOOTH_GROUP_SHUTTERS + SMOOTH_GROUP_SHUTTLE_PARTS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_PLASTITANIUM_WALLS + SMOOTH_GROUP_SYNDICATE_WALLS

/obj/effect/landmark/start/assaultop
	name = "assaultop"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "snukeop_spawn"
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/assaultop/Initialize(mapload)
	. = ..()
	GLOB.assault_operative_start += get_turf(src)
