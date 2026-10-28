GLOBAL_LIST_INIT(electrolyzer_reactions, electrolyzer_reactions_list())

/*
 * Global proc to build the electrolyzer reactions list
 */
/proc/electrolyzer_reactions_list()
	var/list/built_reaction_list = list()
	for(var/reaction_path in subtypesof(/datum/gas_reaction/electrolyzer))
		var/datum/gas_reaction/electrolyzer/reaction = new reaction_path()

		built_reaction_list[reaction.id] = reaction

	return built_reaction_list

/datum/gas_reaction/electrolyzer
	abstract_type = /datum/gas_reaction/electrolyzer

/datum/gas_reaction/electrolyzer/New()
	. = ..()
	factor ||= list()
	factor["Location"] ||= "只能发生在装有运行中电解机的地块上。"

/**
 * Electrolyzer reaction.
 * Args:
 * * air_mixture: The gas_mixture receiving the electrolysis.
 * * working_power: How much energy to put into the electrolysis, in electrolyzer units. A value of 1 is what a tier 1 electrolyzer would put in.
 * * electrolyzer_args: Additional arguments for alternative methods of electrolysis.
 */
/datum/gas_reaction/electrolyzer/proc/react(datum/gas_mixture/air_mixture, working_power, list/electrolyzer_args = list())
	return

/**
 * Checks whether the requirements are met for a reaction.
 * Args:
 * * air_mixture: The air mixture to check the requirements for.
 * * electrolyzer_args: Additional arguments for alternative methods of electrolysis.
 */
/datum/gas_reaction/electrolyzer/proc/reaction_check(datum/gas_mixture/air_mixture, list/electrolyzer_args = list())
	var/temp = air_mixture.temperature
	var/list/cached_moles = air_mixture.moles
	if((requirements["MIN_TEMP"] && temp < requirements["MIN_TEMP"]) || (requirements["MAX_TEMP"] && temp > requirements["MAX_TEMP"]))
		return FALSE
	for(var/id in requirements)
		if (id == "MIN_TEMP" || id == "MAX_TEMP")
			continue
		if(cached_moles[id] < requirements[id])
			return FALSE
	return TRUE

/datum/gas_reaction/electrolyzer/h2o_conversion
	name = "H2O 转化"
	id = "h2o_conversion"
	desc = "将 H2O 转化为 H2 与 O2。"
	requirements = list(
		/datum/gas/water_vapor = MINIMUM_MOLE_COUNT
	)
	factor = list(
		/datum/gas/water_vapor = "消耗 2 摩尔 H2O。",
		/datum/gas/oxygen = "生成 1 摩尔 O2。",
		/datum/gas/hydrogen = "生成 2 摩尔 H2。",
	)

/datum/gas_reaction/electrolyzer/h2o_conversion/react(datum/gas_mixture/air_mixture, working_power, list/electrolyzer_args = list())

	var/old_heat_capacity = air_mixture.heat_capacity()

	var/proportion = min(air_mixture.moles[/datum/gas/water_vapor] * INVERSE(2), (2.5 * (working_power ** 2)))
	air_mixture.adjust_gas(/datum/gas/water_vapor, -proportion * 2)
	air_mixture.adjust_gas(/datum/gas/oxygen, proportion)
	air_mixture.adjust_gas(/datum/gas/hydrogen, proportion * 2)
	var/new_heat_capacity = air_mixture.heat_capacity()
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air_mixture.temperature = max(air_mixture.temperature * old_heat_capacity / new_heat_capacity, TCMB)

/datum/gas_reaction/electrolyzer/nob_conversion
	name = "超惰性气体转化"
	id = "nob_conversion"
	desc = "将超惰性气体转化为反惰性气体。"
	requirements = list(
		/datum/gas/hypernoblium = MINIMUM_MOLE_COUNT,
	)
	factor = list(
		/datum/gas/hypernoblium = "消耗 1 摩尔超惰性气体。",
		/datum/gas/antinoblium = "生成 1 摩尔反惰性气体。",
		"Location" = "只能发生在正被功率高于 5 GeV 的超物质电弧击中的地块上。",
	)

/datum/gas_reaction/electrolyzer/nob_conversion/reaction_check(datum/gas_mixture/air_mixture, list/electrolyzer_args = list())
	if(!electrolyzer_args[ELECTROLYSIS_ARGUMENT_SUPERMATTER_POWER] || electrolyzer_args[ELECTROLYSIS_ARGUMENT_SUPERMATTER_POWER] <= POWER_PENALTY_THRESHOLD)
		return FALSE
	return ..()

/datum/gas_reaction/electrolyzer/nob_conversion/react(datum/gas_mixture/air_mixture, working_power, list/electrolyzer_args = list())
	/// The supermatter zap power_level.
	var/supermatter_power = electrolyzer_args[ELECTROLYSIS_ARGUMENT_SUPERMATTER_POWER]
	var/list/cached_moles = air_mixture.moles
	var/old_heat_capacity = air_mixture.heat_capacity()
	air_mixture.assert_gases(/datum/gas/hypernoblium, /datum/gas/antinoblium)
	var/electrolysed = cached_moles[/datum/gas/hypernoblium] * clamp(supermatter_power - POWER_PENALTY_THRESHOLD, 0, CRITICAL_POWER_PENALTY_THRESHOLD - POWER_PENALTY_THRESHOLD) / (CRITICAL_POWER_PENALTY_THRESHOLD - POWER_PENALTY_THRESHOLD)

	air_mixture.adjust_gas(/datum/gas/hypernoblium, -electrolysed)
	air_mixture.adjust_gas(/datum/gas/antinoblium, electrolysed)

	var/list/cached_specific_heat = GAS_META[META_GAS_SPECIFIC_HEAT]
	var/new_heat_capacity = old_heat_capacity + electrolysed * (cached_specific_heat[/datum/gas/antinoblium] - cached_specific_heat[/datum/gas/hypernoblium])
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air_mixture.temperature = max(air_mixture.temperature * old_heat_capacity / new_heat_capacity, TCMB)

/datum/gas_reaction/electrolyzer/halon_generation
	name = "哈龙生成"
	id = "halon_generation"
	desc = "通过电解 BZ 制取哈龙。"
	requirements = list(
		/datum/gas/bz = MINIMUM_MOLE_COUNT,
	)
	factor = list(
		/datum/gas/bz = "消耗全部 BZ。",
		/datum/gas/oxygen = "每消耗 1 摩尔 BZ 生成 0.2 摩尔氧气。",
		/datum/gas/halon = "每消耗 1 摩尔 BZ 生成 2 摩尔哈龙。",
		"Energy" = "每消耗 1 摩尔 BZ 释放 91.2321 kJ 热能。",
		"Temperature" = "反应效率与温度成正比。",
	)

/datum/gas_reaction/electrolyzer/halon_generation/react(datum/gas_mixture/air_mixture, working_power, list/electrolyzer_args = list())
	var/old_heat_capacity = air_mixture.heat_capacity()
	air_mixture.assert_gases(/datum/gas/bz, /datum/gas/oxygen, /datum/gas/halon)
	var/bz_moles = air_mixture.moles[/datum/gas/bz]
	var/reaction_efficency = min(bz_moles * (1 - NUM_E ** (-0.5 * air_mixture.temperature * working_power / FIRE_MINIMUM_TEMPERATURE_TO_EXIST)), bz_moles)

	air_mixture.adjust_gas(/datum/gas/bz, -reaction_efficency)
	air_mixture.adjust_gas(/datum/gas/oxygen, reaction_efficency * 0.2)
	air_mixture.adjust_gas(/datum/gas/halon, reaction_efficency * 2)

	var/energy_used = reaction_efficency * HALON_FORMATION_ENERGY
	var/new_heat_capacity = air_mixture.heat_capacity()
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air_mixture.temperature = max(((air_mixture.temperature * old_heat_capacity + energy_used) / new_heat_capacity), TCMB)
