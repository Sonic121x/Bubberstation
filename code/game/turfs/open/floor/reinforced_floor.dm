
/turf/open/floor/engine
	name = "加固地板"
	desc = "极其坚固。"
	icon_state = "engine"
	holodeck_compatible = TRUE
	thermal_conductivity = 0.01
	heat_capacity = INFINITY
	footstep = FOOTSTEP_PLATING
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_turf = FALSE
	rcd_proof = TRUE
	rust_resistance = RUST_RESISTANCE_REINFORCED
	floor_tile = /obj/item/stack/rods
	/// How many `floor_tile` do you get when you deconstruct the floor
	var/floor_tile_amount = 2

/turf/open/floor/engine/examine(mob/user)
	. += ..()
	. += span_notice("加固杆已被<b>扳紧</b>固定在原位。")

/turf/open/floor/engine/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/engine/break_tile()
	return //unbreakable

/turf/open/floor/engine/burn_tile()
	return //unburnable

/turf/open/floor/engine/make_plating(force = FALSE)
	if(force)
		return ..()
	return //unplateable

/turf/open/floor/engine/try_replace_tile(obj/item/stack/tile/T, mob/user, list/modifiers)
	return

/turf/open/floor/engine/crowbar_act(mob/living/user, obj/item/I)
	return

/turf/open/floor/engine/wrench_act(mob/living/user, obj/item/I)
	..()
	to_chat(user, span_notice("你开始拆卸加固杆……"))
	if(I.use_tool(src, user, 30, volume=80))
		if(!istype(src, /turf/open/floor/engine))
			return TRUE
		if(floor_tile)
			new floor_tile(src, floor_tile_amount)
		ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	return TRUE

/turf/open/floor/engine/ex_act(severity, target)
	if(target == src)
		ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		return TRUE
	if(is_explosion_shielded(severity))
		return FALSE

	switch(severity)
		if(EXPLODE_DEVASTATE)
			if(prob(80))
				if (!ispath(baseturf_at_depth(2), /turf/open/floor))
					attempt_lattice_replacement()
				else
					ScrapeAway(2, flags = CHANGETURF_INHERIT_AIR)
			else if(prob(50))
				ScrapeAway(2, flags = CHANGETURF_INHERIT_AIR)
			else
				ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		if(EXPLODE_HEAVY)
			if(prob(50))
				ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

	return TRUE

// Contents *under* the reinforced flooring is protected from explosions (unless it's devastate level)
/turf/open/floor/engine/can_propagate_explosion(atom/movable/some_thing, severity)
	return severity == EXPLODE_DEVASTATE || !HAS_TRAIT(some_thing, TRAIT_UNDERFLOOR)

/turf/open/floor/engine/singularity_pull(atom/singularity, current_size)
	..()
	if(current_size >= STAGE_FIVE)
		if(floor_tile)
			if(prob(30))
				new floor_tile(src)
				make_plating(TRUE)
		else if(prob(30))
			attempt_lattice_replacement()

/turf/open/floor/engine/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

//air filled floors; used in atmos pressure chambers

/turf/open/floor/engine/n2o
	article = "an"
	name = "\improper 一氧化二氮地板"
	initial_gas_mix = ATMOS_TANK_N2O

/turf/open/floor/engine/co2
	name = "\improper 二氧化碳地板"
	initial_gas_mix = ATMOS_TANK_CO2

/turf/open/floor/engine/plasma
	name = "\improper 等离子地板"
	initial_gas_mix = ATMOS_TANK_PLASMA

/turf/open/floor/engine/o2
	name = "\improper 氧气地板"
	initial_gas_mix = ATMOS_TANK_O2

/turf/open/floor/engine/n2
	article = "an"
	name = "\improper 氮气地板"
	initial_gas_mix = ATMOS_TANK_N2

/turf/open/floor/engine/bz
	name = "\improper BZ 地板"
	initial_gas_mix = ATMOS_TANK_BZ

/turf/open/floor/engine/freon
	name = "\improper 氟利昂地板"
	initial_gas_mix = ATMOS_TANK_FREON

/turf/open/floor/engine/halon
	name = "\improper 哈龙地板"
	initial_gas_mix = ATMOS_TANK_HALON

/turf/open/floor/engine/healium
	name = "\improper 愈合气地板"
	initial_gas_mix = ATMOS_TANK_HEALIUM

/turf/open/floor/engine/h2
	article = "an"
	name = "\improper 氢气地板"
	initial_gas_mix = ATMOS_TANK_H2

/turf/open/floor/engine/hypernoblium
	name = "\improper 超惰性气体地板"
	initial_gas_mix = ATMOS_TANK_HYPERNOBLIUM

/turf/open/floor/engine/miasma
	name = "\improper 瘴气地板"
	initial_gas_mix = ATMOS_TANK_MIASMA

/turf/open/floor/engine/nitrium
	name = "\improper 氮素气地板"
	initial_gas_mix = ATMOS_TANK_NITRIUM

/turf/open/floor/engine/pluoxium
	name = "\improper 富氧气地板"
	initial_gas_mix = ATMOS_TANK_PLUOXIUM

/turf/open/floor/engine/proto_nitrate
	name = "\improper 原硝气地板"
	initial_gas_mix = ATMOS_TANK_PROTO_NITRATE

/turf/open/floor/engine/tritium
	name = "\improper 氚地板"
	initial_gas_mix = ATMOS_TANK_TRITIUM

/turf/open/floor/engine/h2o
	article = "an"
	name = "\improper 水蒸气地板"
	initial_gas_mix = ATMOS_TANK_H2O

/turf/open/floor/engine/zauker
	name = "\improper 灼蚀气地板"
	initial_gas_mix = ATMOS_TANK_ZAUKER

/turf/open/floor/engine/helium
	name = "\improper 氦地板"
	initial_gas_mix = ATMOS_TANK_HELIUM

/turf/open/floor/engine/antinoblium
	name = "\improper 反惰性气体地板"
	initial_gas_mix = ATMOS_TANK_ANTINOBLIUM

/turf/open/floor/engine/air
	name = "空气地板"
	initial_gas_mix = ATMOS_TANK_AIRMIX

/turf/open/floor/engine/xenobio
	name = "异种生物学 BZ 地板"
	initial_gas_mix = XENOBIO_BZ

/turf/open/floor/engine/cult
	name = "铭刻地板"
	desc = "这片阴森的地板上方，空气闻起来有些异样。"
	icon_state = "cult"
	floor_tile = null
	var/obj/effect/cult_turf/realappearance


/turf/open/floor/engine/cult/Initialize(mapload)
	. = ..()
	icon_state = "plating" //we're redefining the base icon_state here so that the Conceal/Reveal Presence spell works for cultists

	if (!mapload)
		new /obj/effect/temp_visual/cult/turf/floor(src)

	realappearance = new /obj/effect/cult_turf(src)
	realappearance.linked = src

/turf/open/floor/engine/cult/Destroy()
	be_removed()
	return ..()

/turf/open/floor/engine/cult/ChangeTurf(path, new_baseturfs, flags)
	if(path != type)
		be_removed()
	return ..()

/turf/open/floor/engine/cult/proc/be_removed()
	QDEL_NULL(realappearance)

/turf/open/floor/engine/cult/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/engine/vacuum
	name = "真空地板"
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/engine/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/engine/insulation
	name = "超绝热地板"
	desc = "坚固且完全隔热。"
	icon_state = "insulation"
	thermal_conductivity = 0
	floor_tile = /obj/item/stack/sheet/mineral/plastitanium
	floor_tile_amount = 1 // Made with 1 sheet, deconstructs into 1 sheet
