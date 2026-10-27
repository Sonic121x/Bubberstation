/obj/machinery/power/colony_wind_turbine
	name = "微型风力涡轮机"
	desc = "一根立柱，两侧各装有一片特别设计的垂直涡轮叶片。\
		放置在有大气的星球户外时，会免费产生一小股电力。\
		若涡轮机所在区域正刮着风暴，发电量会\
		成倍增长。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/wind_turbine.dmi'
	icon_state = "turbine"
	density = TRUE
	max_integrity = 100
	idle_power_usage = 0
	anchored = TRUE
	can_change_cable_layer = FALSE
	circuit = null
	layer = ABOVE_MOB_LAYER
	can_change_cable_layer = TRUE
	/// How much power the turbine makes without a storm
	var/regular_power_production = 2500
	/// How much power the turbine makes during a storm
	var/storm_power_production = 10000
	/// Is our pressure too low to function?
	var/pressure_too_low = FALSE
	/// Minimum external pressure needed to work
	var/minimum_pressure = 5
	/// What we undeploy into
	var/undeploy_type = /obj/item/flatpacked_machine/wind_turbine

/obj/machinery/power/colony_wind_turbine/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, undeploy_type, 2 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	connect_to_network()

/obj/machinery/power/colony_wind_turbine/examine(mob/user)
	. = ..()
	var/area/turbine_area = get_area(src)
	if(!turbine_area.outdoors)
		. += span_notice("它必须建造在<b>户外</b>才能运作。")
	if(pressure_too_low)
		. += span_notice("必须有足够的大气<b>压力</b>，涡轮机才能转动。")


/obj/machinery/power/colony_wind_turbine/process()
	var/area/our_current_area = get_area(src)
	if(!our_current_area.outdoors)
		icon_state = "turbine"
		add_avail(0)
		return

	var/turf/our_turf = get_turf(src)
	var/datum/gas_mixture/environment = our_turf.return_air()

	if(environment.return_pressure() < minimum_pressure)
		pressure_too_low = TRUE
		icon_state = "turbine"
		add_avail(0)
		return

	pressure_too_low = FALSE
	var/storming_out = FALSE

	var/datum/weather/weather_we_track
	for(var/datum/weather/possible_weather in SSweather.processing)
		if((our_turf.z in possible_weather.impacted_z_levels) || (our_current_area in possible_weather.impacted_areas))
			weather_we_track = possible_weather
			break
	if(weather_we_track)
		if(!(weather_we_track.stage == END_STAGE))
			storming_out = TRUE

	add_avail((storming_out ? storm_power_production : regular_power_production))

	var/new_icon_state = (storming_out ? "turbine_storm" : "turbine_normal")
	icon_state = new_icon_state


// Item for deploying wind turbines
/obj/item/flatpacked_machine/wind_turbine
	name = "扁平包装微型风力涡轮机"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/wind_turbine.dmi'
	icon_state = "turbine_packed"
	type_to_deploy = /obj/machinery/power/colony_wind_turbine
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
