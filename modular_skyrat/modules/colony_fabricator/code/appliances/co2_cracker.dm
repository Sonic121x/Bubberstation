// We can't just use electrolyzer reactions, because that'd let electrolyzers do co2 cracking

GLOBAL_LIST_INIT(cracker_reactions, cracker_reactions_list())

/// Global proc to build up the list of co2 cracker reactions
/proc/cracker_reactions_list()
	var/list/built_reaction_list = list()
	for(var/reaction_path in subtypesof(/datum/cracker_reaction))
		var/datum/cracker_reaction/reaction = new reaction_path()

		built_reaction_list[reaction.id] = reaction

	return built_reaction_list

/datum/cracker_reaction
	var/list/requirements
	var/name = "反应"
	var/id = "r"
	var/desc = ""
	var/list/factor

/// Called when the co2 cracker reaction is run, should be where the code for actually changing gasses around is run
/datum/cracker_reaction/proc/react(turf/location, datum/gas_mixture/air_mixture, working_power)
	return

/// Checks if this reaction can actually be run
/datum/cracker_reaction/proc/reaction_check(datum/gas_mixture/air_mixture)
	var/temp = air_mixture.temperature
	var/list/cached_gases = air_mixture.moles
	if((requirements["MIN_TEMP"] && temp < requirements["MIN_TEMP"]) || (requirements["MAX_TEMP"] && temp > requirements["MAX_TEMP"]))
		return FALSE
	for(var/id in requirements)
		if(id == "MIN_TEMP" || id == "MAX_TEMP")
			continue
		if(cached_gases[id] < requirements[id])
			return FALSE
	return TRUE

/datum/cracker_reaction/co2_cracking
	name = "CO2 裂解"
	id = "co2_cracking"
	desc = "将 CO2 转化为等量的 O2"
	requirements = list(
		/datum/gas/carbon_dioxide = MINIMUM_MOLE_COUNT,
	)
	factor = list(
		/datum/gas/carbon_dioxide = "消耗 1 摩尔 CO2",
		/datum/gas/oxygen = "产生 1 摩尔 O2",
		"位置" = "只能发生在有正在运行的 CO2 裂解机的格子上。",
	)

/datum/cracker_reaction/co2_cracking/react(turf/location, datum/gas_mixture/air_mixture, working_power)
	var/old_heat_capacity = air_mixture.heat_capacity()
	air_mixture.assert_gases(/datum/gas/water_vapor, /datum/gas/oxygen)
	var/proportion = min(air_mixture.moles[/datum/gas/carbon_dioxide] * INVERSE(2), (2.5 * (working_power ** 2)))
	air_mixture.moles[/datum/gas/carbon_dioxide] -= proportion
	air_mixture.moles[/datum/gas/oxygen] += proportion
	var/new_heat_capacity = air_mixture.heat_capacity()
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air_mixture.temperature = max(air_mixture.temperature * old_heat_capacity / new_heat_capacity, TCMB)

// CO2 cracker machine itself

/obj/machinery/electrolyzer/co2_cracker
	name = "便携式 CO2 裂解机"
	desc = "一台便携设备，是边疆许多殖民地的救星。它的工作方式与电解机类似，\
		吸入附近的气体并将其分解为不同的气体。它最大的卖点是什么？它能将二氧化碳裂解\
		成可供呼吸的氧气。对于二氧化碳随处可见、氧气却极难寻找的地方来说十分方便。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/portable_machines.dmi'
	circuit = null
	working_power = 1
	/// Soundloop for while the thermomachine is turned on
	var/datum/looping_sound/conditioner_running/soundloop
	/// What this repacks into
	var/repacked_type = /obj/item/flatpacked_machine/co2_cracker

/obj/machinery/electrolyzer/co2_cracker/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)
	AddElement(/datum/element/repackable, repacked_type, 2 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/electrolyzer/co2_cracker/process_atmos()
	if(on && !soundloop.loop_started)
		soundloop.start()
	else if(soundloop.loop_started)
		soundloop.stop()
	return ..()

/obj/machinery/electrolyzer/co2_cracker/call_reactions(datum/gas_mixture/env)
	for(var/reaction in GLOB.cracker_reactions)
		var/datum/cracker_reaction/current_reaction = GLOB.cracker_reactions[reaction]

		if(!current_reaction.reaction_check(env))
			continue

		current_reaction.react(loc, env, working_power)

	env.garbage_collect()

/obj/machinery/electrolyzer/co2_cracker/RefreshParts()
	. = ..()
	working_power = 2
	efficiency = 1

/obj/machinery/electrolyzer/co2_cracker/crowbar_act(mob/living/user, obj/item/tool)
	return

// "parts kit" for buying these from cargo

/obj/item/flatpacked_machine/co2_cracker
	name = "CO2 裂解机零件包"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/parts_kits.dmi'
	icon_state = "co2_cracker"
	type_to_deploy = /obj/machinery/electrolyzer/co2_cracker
	deploy_time = 2 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, // We're gonna pretend plasma is the catalyst for co2 cracking
	)
