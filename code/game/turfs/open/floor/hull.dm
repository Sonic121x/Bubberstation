
/turf/open/floor/engine/hull
	name = "外部船体装甲板"
	desc = "坚固的外部船体装甲板，将你与冷漠的太空真空隔绝。"
	icon_state = "regular_hull"
	initial_gas_mix = AIRLESS_ATMOS
	temperature = TCMB

/turf/open/floor/engine/hull/air
	name = "内部船体装甲板"
	desc = "坚固的内部船体装甲板，将你与下方的地板隔绝。"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	temperature = T20C

/turf/open/floor/engine/hull/lavaland
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

/turf/open/floor/engine/hull/ceiling
	name = "穿梭机顶棚装甲板"

/turf/open/floor/engine/hull/reinforced
	name = "外部强化船体装甲板"
	desc = "极其坚固的外部船体装甲板，将你与冷漠的太空真空隔绝。"
	icon_state = "reinforced_hull"
	heat_capacity = INFINITY

/turf/open/floor/engine/hull/reinforced/air
	name = "内部强化船体装甲板"
	desc = "极其坚固的内部船体装甲板，将你与下方的地板隔绝。"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	temperature = T20C
