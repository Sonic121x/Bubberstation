//Sand
/turf/open/misc/moonstation_sand
	name = "月沙"
	gender = PLURAL //fucking LIBERALS gendering my SAND oh my GOD *goes on an unhinged rant on reddit*
	desc = "别把它和法律上毫无关联的同名儿童玩具混为一谈，这种月沙粗糙硌人，还会钻得到处都是。"
	initial_gas_mix = MOONSTATION_ATMOS
	icon = 'modular_zubbers/icons/turf/lunar_sand.dmi'
	icon_state = "0,0"
	bullet_bounce_sound = null
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_turf = FALSE
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/moonstation_rock
	flags_1 = NONE

/turf/open/misc/moonstation_sand/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/diggable, /obj/item/stack/ore/glass, 2, worm_chance = 3)
	icon_state = "[x % 10],[y % 10]"

/turf/open/misc/moonstation_sand/break_tile()
	. = ..()
	icon_state = "damaged"

/turf/open/misc/moonstation_sand/broken_states()
	return list("damaged")

//Rock
/turf/open/misc/moonstation_rock
	name = "月岩"
	gender = NEUTER
	desc = "你已经跌到谷底，脚下只剩岩石。"
	initial_gas_mix = MOONSTATION_ATMOS
	icon = 'modular_zubbers/icons/turf/lunar_rock.dmi'
	icon_state = "0,0"
	planetary_atmos = TRUE

/turf/open/misc/moonstation_rock/break_tile()
	. = ..()
	icon_state = "damaged"

/turf/open/misc/moonstation_rock/broken_states()
	return list("damaged")

/turf/open/misc/moonstation_rock/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/diggable, /obj/item/stack/sheet/mineral/stone, 2, worm_chance = 1)
	icon_state = "[x % 10],[y % 10]"

//Misc
/turf/open/floor/plating/rust/moonstation
	initial_gas_mix = MOONSTATION_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/catwalk_floor/rust
	baseturfs = /turf/open/floor/plating/rust

/turf/open/floor/catwalk_floor/rust/moonstation
	initial_gas_mix = MOONSTATION_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/iron/solarpanel/moonstation
	initial_gas_mix = MOONSTATION_ATMOS
	planetary_atmos = TRUE

