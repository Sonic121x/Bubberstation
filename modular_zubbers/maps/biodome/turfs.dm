/turf/closed/wall/r_wall/fakewood
	desc = "一大块用于分隔房间的加固金属。这一块被漆成了原木的样子。"
	color = COLOR_ORANGE_BROWN

/turf/open/water/jungle/biodome
	name="生态穹顶湖"
	fishing_datum = /datum/fish_source/ocean/beach
	planetary_atmos = FALSE

/turf/open/water/beach/biodome
	name="生态穹顶水域"
	planetary_atmos = FALSE

/turf/open/misc/beach/sand/biodome
	name="生态穹顶海滩"
	planetary_atmos = FALSE

/turf/open/misc/ashplanet/wateryrock/biodome
	name="生态穹顶湖岩地"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = FALSE

/turf/open/lava/plasma/biodome
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	baseturfs = /turf/open/lava/plasma/biodome
	planetary_atmos = FALSE

/turf/open/floor/fake_iron_sand
	desc = "等等。这火星土壤居然只是画上去的！"
	icon_state = "ironsand1"
	base_icon_state = "ironsand1"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/fake_iron_sand/Initialize(mapload)
	. = ..()
	icon_state = "ironsand[rand(1,15)]"

/turf/open/floor/fake_iron_sand/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/fake_iron_sand/crowbar_act(mob/living/user, obj/item/I)
	return


/turf/open/floor/fake_snow/safe
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	slowdown = 0

/turf/open/floor/wood/stairs
	icon = 'modular_zubbers/icons/maps/biodome/floor.dmi'
	icon_state = "woodstairs_up"

/turf/open/floor/wood/stairs/down
	icon_state = "woodstairs_down"

/turf/open/floor/wood/stairs/left
	icon_state = "woodstairs_left"

/turf/open/floor/wood/stairs/right
	icon_state = "woodstairs_right"
