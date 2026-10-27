/datum/weather/particle/rain_storm
	name = "rain"
	desc = "猛烈的雷雨倾泻而下，将暴露在外的人淋得湿透。"

	particle_type = /particles/weather/rain_storm
	min_severity = 30

	telegraph_message = span_danger("高空中雷声隆隆。你听到雨点敲打遮蔽物的声音。")
	telegraph_overlay = "rain_low"
	telegraph_duration = 30 SECONDS

	weather_message = span_userdanger("<i>大雨在你周围倾盆而下！</i>")
	weather_overlay = "rain_high"

	end_message = span_bolddanger("倾盆大雨逐渐转为小雨。")
	end_overlay = "rain_low"
	end_duration = 30 SECONDS

	// Don't display overlays when using particle weather
	overlay_planes = list(WEATHER_PLANE)

	weather_duration_lower = 3 MINUTES
	weather_duration_upper = 5 MINUTES

	weather_color = null
	thunder_color = null

	area_type = /area
	target_trait = ZTRAIT_RAINSTORM
	immunity_type = TRAIT_RAINSTORM_IMMUNE
	probability = 90

	weather_flags = (WEATHER_TURFS | WEATHER_MOBS | WEATHER_THUNDER | WEATHER_BAROMETER)
	whitelist_weather_reagents = list(/datum/reagent/water)

/datum/weather/particle/rain_storm/New(z_levels, list/weather_data)
	. = ..()
	if (isnull(weather_reagent) || istype(weather_reagent, /datum/reagent/water) || !weather_color)
		return

	// Non-water rain gets colored into their reagent's color
	for (var/list/holder_list as anything in weather_objects)
		for (var/obj/effect/abstract/weather_holder/holder as anything in holder_list)
			holder.particles.color = weather_color

/datum/weather/particle/rain_storm/get_playlist_ref()
	return GLOB.rain_storm_sounds

/datum/weather/particle/rain_storm/telegraph()
	GLOB.rain_storm_sounds.Cut()
	for(var/area/impacted_area as anything in impacted_areas)
		GLOB.rain_storm_sounds[impacted_area] = /datum/looping_sound/rain/start

	// change the message for if rain is triggered inside the station (no canopy of course)
	for(var/z in impacted_z_levels)
		if(is_station_level(z))
			telegraph_message = span_warning("头顶传来隆隆雷声。你听到雨点落在周围地面上的声音。")
			break

	return ..()

/datum/weather/particle/rain_storm/start()
	GLOB.rain_storm_sounds.Cut()
	for(var/area/impacted_area as anything in impacted_areas)
		GLOB.rain_storm_sounds[impacted_area] = /datum/looping_sound/rain/middle
	return ..()

/datum/weather/particle/rain_storm/wind_down()
	GLOB.rain_storm_sounds.Cut()
	for(var/area/impacted_area as anything in impacted_areas)
		GLOB.rain_storm_sounds[impacted_area] = /datum/looping_sound/rain/end
	return ..()

/datum/weather/particle/rain_storm/end()
	GLOB.rain_storm_sounds.Cut()
	return ..()

/particles/weather/rain_storm
	icon = 'icons/effects/particles/generic.dmi'
	icon_state = "drop"
	color = "#ccffff"
	position = generator(GEN_BOX, list(-510, -256, 0), list(400, 512, 0))
	grow = list(-0.01, -0.01)
	gravity = list(0, -10, 0.5)
	drift = generator(GEN_CIRCLE, 0, 1)
	friction = 0.3
	min_spawn = 50
	max_spawn = 300
	wind_strength = 5
	spin = 0

/datum/weather/particle/rain_storm/blood
	whitelist_weather_reagents = list(/datum/reagent/blood)
	probability = 0 // admeme event

// Fun fact - if you increase the weather_temperature higher than LIQUID_PLASMA_BP
// the plasma rain will vaporize into a gas on whichever turf it lands on
/datum/weather/particle/rain_storm/plasma
	whitelist_weather_reagents = list(/datum/reagent/toxin/plasma)
	probability = 0 // maybe for icebox maps one day?

/datum/weather/particle/rain_storm/deep_fried
	weather_temperature = 455 // just hot enough to apply the fried effect
	whitelist_weather_reagents = list(/datum/reagent/consumable/nutriment/fat/oil)
	weather_flags = (WEATHER_TURFS | WEATHER_INDOORS)
	probability = 0 // admeme event

/datum/weather/particle/rain_storm/acid
	desc = "这颗行星上的雷雨天然带有酸性，会将毫无防护地暴露其中的人灼伤焚毁。"

	telegraph_duration = 40 SECONDS
	telegraph_message = span_warning("高空中雷声隆隆。酸性雨滴落在遮蔽物上，发出嘶嘶声。快寻找掩蔽！")
	telegraph_sound = 'sound/effects/siren.ogg'

	weather_message = span_userdanger("<i>酸雨在你周围倾盆而下！快进室内！</i>")
	weather_duration_lower = 1 MINUTES
	weather_duration_upper = 2 MINUTES

	end_duration = 10 SECONDS
	end_message = span_bolddanger("倾盆大雨逐渐转为小雨。现在外面应该安全了。")

	// these are weighted by acidpwr which causes more damage the higher it is
	whitelist_weather_reagents = list(
		/datum/reagent/toxin/acid/nitracid = 3,
		/datum/reagent/toxin/acid = 2,
		/datum/reagent/toxin/acid/fluacid = 1,
	)
	probability = 0

/datum/weather/particle/rain_storm/wizard
	name = "magical rain"
	desc = "一场魔法雷雨倾泻而下，将暴露在外的人浸透在神秘的雨水中。"

	telegraph_message = span_danger("一片魔法雨云出现在头顶。你听到了雨滴落下的声音。")
	protected_areas = /datum/weather/rad_storm::protected_areas

	// same time durations as floor_is_lava event
	telegraph_duration = 15 SECONDS
	weather_duration_lower = 30 SECONDS
	weather_duration_upper = 1 MINUTES
	end_duration = 0 SECONDS
	target_trait = ZTRAIT_STATION

	turf_weather_chance = 0.02 // double the turf chance
	whitelist_weather_reagents = list()
	probability = 0 // shouldn't spawn normally
	weather_flags = (WEATHER_TURFS | WEATHER_MOBS | WEATHER_INDOORS | WEATHER_BAROMETER)

/datum/weather/particle/rain_storm/wizard/New(z_levels, list/weather_data)
	if(length(GLOB.wizard_rain_reagents)) // the wizard event has already been run once and setup the whitelist
		whitelist_weather_reagents = GLOB.wizard_rain_reagents
		return ..()

	// most medicine do nothing when it comes into contact with turfs or mobs (via TOUCH) except for a few
	var/list/allowed_medicine = list(
		/datum/reagent/medicine/c2/synthflesh,
		/datum/reagent/medicine/adminordrazine,
		/datum/reagent/medicine/strange_reagent,
		// include a random medicine
		pick(subtypesof(/datum/reagent/medicine)),
	)
	GLOB.wizard_rain_reagents |= allowed_medicine

	// One randomized type is allowed so the whitelist isn't spammed with subtypes
	GLOB.wizard_rain_reagents |= pick(subtypesof(/datum/reagent/mutationtoxin))
	GLOB.wizard_rain_reagents |= pick(subtypesof(/datum/reagent/plantnutriment))
	GLOB.wizard_rain_reagents |= pick(subtypesof(/datum/reagent/impurity))
	GLOB.wizard_rain_reagents |= pick(subtypesof(/datum/reagent/drug))
	GLOB.wizard_rain_reagents |= pick(typesof(/datum/reagent/glitter/random))
	GLOB.wizard_rain_reagents |= pick(typesof(/datum/reagent/uranium))
	GLOB.wizard_rain_reagents |= pick(typesof(/datum/reagent/luminescent_fluid))
	GLOB.wizard_rain_reagents |= pick(typesof(/datum/reagent/carpet))
	GLOB.wizard_rain_reagents |= pick(typesof(/datum/reagent/water))
	GLOB.wizard_rain_reagents |= pick(typesof(/datum/reagent/fuel))
	GLOB.wizard_rain_reagents |= pick(typesof(/datum/reagent/colorful_reagent))
	GLOB.wizard_rain_reagents |= pick(typesof(/datum/reagent/ants))
	GLOB.wizard_rain_reagents |= pick(typesof(/datum/reagent/lube))
	GLOB.wizard_rain_reagents |= pick(typesof(/datum/reagent/space_cleaner))

	// lots of toxins do nothing so we need to be picky
	var/list/allowed_toxins = list(
		/datum/reagent/toxin/itching_powder,
		/datum/reagent/toxin/polonium, // radiation
		/datum/reagent/toxin/mutagen,
		// all the acids
		/datum/reagent/toxin/acid,
		/datum/reagent/toxin/acid/fluacid,
		/datum/reagent/toxin/acid/nitracid,
		// include a random toxin
		pick(subtypesof(/datum/reagent/toxin)),
	)
	GLOB.wizard_rain_reagents |= allowed_toxins

	// too many food & drinks so blacklist most of them
	var/list/allowed_food_drinks = list(
		/datum/reagent/consumable/ethanol/wizz_fizz,
		/datum/reagent/consumable/condensedcapsaicin,
		/datum/reagent/consumable/frostoil,
		// include a random food or drink
		pick(subtypesof(/datum/reagent/consumable)),
		// include a random regular drink (vodka, wine, beer, etc.)
		pick(/obj/machinery/chem_dispenser/drinks/beer::beer_dispensable_reagents),
	)
	GLOB.wizard_rain_reagents |= allowed_food_drinks

	var/list/allowed_exotic_reagents = list(
		// fire
		/datum/reagent/clf3,
		/datum/reagent/phlogiston,
		/datum/reagent/napalm,
		// cosmetic
		/datum/reagent/hair_dye,
		/datum/reagent/barbers_aid,
		/datum/reagent/baldium,
		/datum/reagent/mulligan,
		/datum/reagent/growthserum,
		// op shit
		/datum/reagent/romerol,
		/datum/reagent/gondola_mutation_toxin,
		/datum/reagent/metalgen,
		/datum/reagent/flightpotion,
		/datum/reagent/eigenstate,
		/datum/reagent/magillitis,
		/datum/reagent/pax,
		/datum/reagent/gluttonytoxin,
		/datum/reagent/aslimetoxin,
		// misc
		/datum/reagent/blood,
		/datum/reagent/hauntium,
		/datum/reagent/copper,
	)
	GLOB.wizard_rain_reagents |= allowed_exotic_reagents

	// add a few randomized reagents not listed above so they at least have a chance
	GLOB.wizard_rain_reagents |= pick(subtypesof(/datum/reagent))
	GLOB.wizard_rain_reagents |= pick(subtypesof(/datum/reagent))
	GLOB.wizard_rain_reagents |= pick(subtypesof(/datum/reagent))

	whitelist_weather_reagents = GLOB.wizard_rain_reagents
	return ..()
