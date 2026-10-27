/area/ocean
	name = "海洋"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "explored"
	requires_power = TRUE
	always_unpowered = TRUE
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	outdoors = TRUE
	ambience_index = AMBIENCE_SPACE
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_AREA_SPACE

/area/ocean/generated
	icon_state = "unexplored"
	map_generator = /datum/map_generator/ocean_generator

/area/ocean/trench
	area_flags_mapping = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	name = "海沟"

/area/ocean/trench/generated
	icon_state = "unexplored"
	map_generator = /datum/map_generator/cave_generator/trench

/area/ruin/ocean
	default_gravity = STANDARD_GRAVITY

/area/ruin/ocean/listening_outpost
	name = "监听站"

/area/ruin/ocean/bunker
	name = "地堡"

/area/ruin/ocean/bioweapon_research
	name = "辛迪加海底基地"

/area/ruin/ocean/mining_site
	name = "采矿场"

/area/ruin/ocean/saddam_hole
	name = "洞穴藏身处"
