/datum/gas_reaction/standard/water_vapor/init_factors()
	factor = list(
		/datum/gas/water_vapor = "冷凝会消耗 [MOLES_GAS_VISIBLE] 摩尔。\
			冻结则不会消耗任何摩尔。两者都至少需要 [MOLES_GAS_VISIBLE] 摩尔才能发生。",
		"Temperature" = "在 [WATER_VAPOR_DEPOSITION_POINT]K 或以下会冻结地砖，\
			在 [WATER_VAPOR_CONDENSATION_POINT]K 或以下会将其打湿。",
		"Location" = "只能在地砖上发生。",
	)

/datum/gas_reaction/standard/miaster/init_factors()
	factor = list(
		/datum/gas/miasma = "[/datum/gas/miasma::name]的灭菌速率\
			与温度和 [MIASTER_STERILIZATION_TEMP]K 之间的差值成正比。",
		/datum/gas/oxygen = "每消耗 1 摩尔[/datum/gas/miasma::name]会释放 1 摩尔[/datum/gas/oxygen::name]。",
		"Temperature" = "温度越高，[/datum/gas/miasma::name]灭菌越快。",
		"Energy" = "每灭菌 1 摩尔[/datum/gas/miasma::name]会释放 [MIASTER_STERILIZATION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/standard/plasmafire/init_factors()
	factor = list(
		/datum/gas/oxygen = "[/datum/gas/oxygen::name]消耗量由温度决定，\
			在 [PLASMA_MINIMUM_BURN_TEMPERATURE]K 时，每消耗 1 摩尔[/datum/gas/plasma::name]会消耗 [OXYGEN_BURN_RATIO_BASE] 摩尔氧气，\
			在 [PLASMA_UPPER_TEMPERATURE]K 时，每消耗 1 摩尔[/datum/gas/plasma::name]会消耗 [OXYGEN_BURN_RATIO_BASE-1] 摩尔氧气。\
			[/datum/gas/oxygen::name]浓度最高达到[/datum/gas/plasma::name]的 [PLASMA_OXYGEN_FULLBURN] 倍\
			可加快[/datum/gas/plasma::name]的消耗速度。",
		/datum/gas/plasma = "[/datum/gas/plasma::name]的消耗速率与温度\
			和 [PLASMA_MINIMUM_BURN_TEMPERATURE]K 之间的差值成正比，在 [PLASMA_UPPER_TEMPERATURE]K 时达到最大。",
		/datum/gas/tritium = "每消耗 1 摩尔[/datum/gas/plasma::name]会生成 1 摩尔[/datum/gas/tritium::name]，\
			前提是[/datum/gas/oxygen::name]至少为[/datum/gas/plasma::name]的 97 倍。",
		/datum/gas/water_vapor = "每消耗 1 摩尔[/datum/gas/plasma::name]会生成 0.25 摩尔[/datum/gas/water_vapor::name]，\
			前提是未生成[/datum/gas/tritium::name]。",
		/datum/gas/carbon_dioxide = "每消耗 1 摩尔[/datum/gas/plasma::name]会生成 0.75 摩尔[/datum/gas/carbon_dioxide::name]，\
			前提是未生成[/datum/gas/tritium::name]。",
		"Temperature" = "发生的最低温度为 [PLASMA_MINIMUM_BURN_TEMPERATURE]K。\
			温度升高至 [PLASMA_UPPER_TEMPERATURE]K 可提高[/datum/gas/oxygen::name]利用效率，\
			并提高[/datum/gas/plasma::name]的消耗速率。",
		"Energy" = "每消耗 1 摩尔[/datum/gas/plasma::name]会释放 [FIRE_PLASMA_ENERGY_RELEASED] 焦耳能量。",
	)

/datum/gas_reaction/standard/h2fire/init_factors()
	factor = list(
		/datum/gas/oxygen = "每消耗 1 摩尔[/datum/gas/hydrogen::name]会消耗 0.5 摩尔[/datum/gas/oxygen::name]。\
			[/datum/gas/oxygen::name]浓度最高达到\
			[/datum/gas/hydrogen::name]的 [HYDROGEN_OXYGEN_FULLBURN] 倍可提高[/datum/gas/hydrogen::name]的消耗速率。",
		/datum/gas/hydrogen = "只要[/datum/gas/oxygen::name]足以支持燃烧，[/datum/gas/hydrogen::name]就会被极快地消耗。",
		/datum/gas/water_vapor = "每燃烧 1 摩尔[/datum/gas/hydrogen::name]会生成 1 摩尔[/datum/gas/water_vapor::name]。",
		"Temperature" = "发生的最低温度为 [FIRE_MINIMUM_TEMPERATURE_TO_EXIST]K",
		"Energy" = "每消耗 1 摩尔[/datum/gas/hydrogen::name]会释放 [FIRE_HYDROGEN_ENERGY_RELEASED] 焦耳能量。",
	)

/datum/gas_reaction/standard/tritfire/init_factors()
	factor = list(
		/datum/gas/oxygen = "每消耗 1 摩尔[/datum/gas/tritium::name]会消耗 0.5 摩尔[/datum/gas/oxygen::name]。\
			[/datum/gas/oxygen::name]浓度最高达到\
			[/datum/gas/tritium::name]的 [TRITIUM_OXYGEN_FULLBURN] 倍可提高[/datum/gas/tritium::name]的消耗速率。",
		/datum/gas/tritium = "只要[/datum/gas/oxygen::name]足以支持燃烧，[/datum/gas/tritium::name]就会被极快地消耗。",
		/datum/gas/water_vapor = "每燃烧 1 摩尔[/datum/gas/tritium::name]会生成 1 摩尔[/datum/gas/water_vapor::name]。",
		"Temperature" = "发生的最低温度为 [FIRE_MINIMUM_TEMPERATURE_TO_EXIST]K",
		"Energy" = "每消耗 1 摩尔[/datum/gas/tritium::name]会释放 [FIRE_TRITIUM_ENERGY_RELEASED] 焦耳能量。",
		"Radiation" = "此反应会释放与释放能量成正比的辐射。",
	)

/datum/gas_reaction/standard/freonfire/init_factors()
	factor = list(
		/datum/gas/oxygen = "[/datum/gas/oxygen::name]消耗量由温度决定，\
			在 [FREON_LOWER_TEMPERATURE]K 时，每消耗 1 摩尔[/datum/gas/freon::name]会消耗 [OXYGEN_BURN_RATIO_BASE] 摩尔氧气，\
			在 [FREON_MAXIMUM_BURN_TEMPERATURE]K 时，每消耗 1 摩尔[/datum/gas/freon::name]会消耗 [OXYGEN_BURN_RATIO_BASE - 1] 摩尔氧气。\
			[/datum/gas/oxygen::name]浓度最高达到\
			[/datum/gas/freon::name]的 [FREON_OXYGEN_FULLBURN] 倍可提高[/datum/gas/freon::name]的消耗速率。",
		/datum/gas/freon = "[/datum/gas/freon::name]的消耗速率与温度\
			和 [FREON_MAXIMUM_BURN_TEMPERATURE]K 之间的差值成正比。其与[/datum/gas/oxygen::name]的比例也会影响消耗速率。",
		/datum/gas/carbon_dioxide = "每消耗 1 摩尔[/datum/gas/freon::name]会生成 1 摩尔[/datum/gas/carbon_dioxide::name]。",
		"Temperature" = "只能在 [FREON_LOWER_TEMPERATURE] - [FREON_MAXIMUM_BURN_TEMPERATURE]K 之间发生。",
		"Energy" = "每消耗 1 摩尔[/datum/gas/freon::name]会吸收 [FIRE_FREON_ENERGY_CONSUMED] 焦耳能量。",
		"Hot Ice" = "此反应在 [HOT_ICE_FORMATION_MINIMUM_TEMPERATURE]-[HOT_ICE_FORMATION_MAXIMUM_TEMPERATURE]K 之间发生时会生成“热冰”。",
	)


/datum/gas_reaction/standard/nitrousformation/init_factors()
	factor = list(
		/datum/gas/oxygen = "反应需要存在 10 摩尔[/datum/gas/oxygen::name]。\
			每生成 1 摩尔[/datum/gas/nitrous_oxide::name]会消耗 0.5 摩尔[/datum/gas/oxygen::name]。",
		/datum/gas/nitrogen = "反应需要存在 20 摩尔[/datum/gas/nitrogen::name]。\
			每生成 1 摩尔[/datum/gas/nitrous_oxide::name]会消耗 1 摩尔[/datum/gas/nitrogen::name]。",
		/datum/gas/bz = "反应需要存在 5 摩尔[/datum/gas/bz::name]，但不会消耗。",
		/datum/gas/nitrous_oxide = "[/datum/gas/nitrous_oxide::name]会被快速生成。",
		"Temperature" = "只能在 [N2O_FORMATION_MIN_TEMPERATURE] - [N2O_FORMATION_MAX_TEMPERATURE]K 之间发生",
		"Energy" = "每生成 1 摩尔[/datum/gas/nitrous_oxide::name]会释放 [N2O_FORMATION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/standard/nitrous_decomp/init_factors()
	factor = list(
		/datum/gas/nitrous_oxide = "[/datum/gas/nitrous_oxide::name]的分解速率随温度\
			偏离反应最低与最高温度的平均值而降低。\
			至少需要 [MINIMUM_MOLE_COUNT * 2] 摩尔才能发生。", //okay this one isn't made into a define yet.
		/datum/gas/oxygen = "每分解 1 摩尔[/datum/gas/nitrous_oxide::name]会生成 0.5 摩尔[/datum/gas/oxygen::name]。",
		/datum/gas/nitrogen = "每分解 1 摩尔[/datum/gas/nitrous_oxide::name]会生成 1 摩尔[/datum/gas/nitrogen::name]。",
		"Temperature" = "分解速率与温度到最低及最高反应温度的差值之积成正比。只能在 [N2O_DECOMPOSITION_MIN_TEMPERATURE] - [N2O_DECOMPOSITION_MAX_TEMPERATURE]K 之间发生。",
		"Energy" = "每分解 1 摩尔[/datum/gas/nitrous_oxide::name]会释放 [N2O_DECOMPOSITION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/standard/bzformation/init_factors()
	factor = list(
		/datum/gas/plasma = "每生成 1 摩尔[/datum/gas/bz::name]会消耗 0.8 摩尔[/datum/gas/plasma::name]。\
			若[/datum/gas/plasma::name]多于[/datum/gas/nitrous_oxide::name]，[/datum/gas/bz::name]的生成速率会降低。",
		/datum/gas/nitrous_oxide = "每生成 1 摩尔[/datum/gas/bz::name]会消耗 0.4 摩尔[/datum/gas/nitrous_oxide::name]。\
			若[/datum/gas/nitrous_oxide::name]少于[/datum/gas/plasma::name]，反应速率会降低。\
			当[/datum/gas/plasma::name]为[/datum/gas/nitrous_oxide::name]的三倍时，\
			它会开始分解为[/datum/gas/nitrogen::name]和[/datum/gas/oxygen::name]——\
			一氧化二氮占比越低，分解的[/datum/gas/nitrous_oxide::name]就越多。",
		/datum/gas/bz = "气压越低、体积越大，生成的[/datum/gas/bz::name]就越多。\
			[/datum/gas/nitrous_oxide::name]少于[/datum/gas/plasma::name]会减慢反应。",
		/datum/gas/nitrogen = "每分解 1 摩尔[/datum/gas/nitrous_oxide::name]会生成 1 摩尔[/datum/gas/nitrogen::name]。\
			[/datum/gas/nitrous_oxide::name]与[/datum/gas/plasma::name]的比值越低，分解相对于[/datum/gas/bz::name]生成的比例就越高。",
		/datum/gas/oxygen = "每分解 1 摩尔[/datum/gas/nitrous_oxide::name]会生成 0.5 摩尔[/datum/gas/oxygen::name]。\
			[/datum/gas/nitrous_oxide::name]与[/datum/gas/plasma::name]的比值越低，分解相对于[/datum/gas/bz::name]生成的比例就越高。",
		"Energy" = "每生成 1 摩尔[/datum/gas/bz::name]会释放 [BZ_FORMATION_ENERGY] 焦耳能量。\
			每分解 1 摩尔[/datum/gas/nitrous_oxide::name]会释放 [N2O_DECOMPOSITION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/standard/pluox_formation/init_factors()
	factor = list(
		/datum/gas/carbon_dioxide = "每生成 1 摩尔[/datum/gas/pluoxium::name]会消耗 1 摩尔[/datum/gas/carbon_dioxide::name]。",
		/datum/gas/oxygen = "每生成 1 摩尔[/datum/gas/pluoxium::name]会消耗 0.5 摩尔[/datum/gas/oxygen::name]。",
		/datum/gas/tritium = "每生成 1 摩尔[/datum/gas/pluoxium::name]会有 0.01 摩尔[/datum/gas/tritium::name]转化为[/datum/gas/hydrogen::name]。",
		/datum/gas/pluoxium = "[/datum/gas/pluoxium::name]在任何给定混合物中都以恒定速率生成。",
		/datum/gas/hydrogen = "[/datum/gas/tritium::name]失去中子后生成[/datum/gas/hydrogen::name]。",
		"Energy" = "每生成 1 摩尔[/datum/gas/pluoxium::name]会释放 [PLUOXIUM_FORMATION_ENERGY] 焦耳能量。",
		"Temperature" = "只能在 [PLUOXIUM_FORMATION_MIN_TEMP] - [PLUOXIUM_FORMATION_MAX_TEMP]K 之间发生",
	)

/datum/gas_reaction/standard/nitrium_formation/init_factors()
	factor = list(
		/datum/gas/bz = "反应需要存在 5 摩尔[/datum/gas/bz::name]。\
			每生成 1 摩尔[/datum/gas/nitrium::name]会消耗 0.05 摩尔[/datum/gas/bz::name]。",
		/datum/gas/tritium = "反应需要存在 20 摩尔[/datum/gas/tritium::name]。\
			每生成 1 摩尔[/datum/gas/nitrium::name]会消耗 1 摩尔[/datum/gas/tritium::name]。",
		/datum/gas/nitrogen = "反应需要存在 10 摩尔[/datum/gas/nitrogen::name]。\
			每生成 1 摩尔[/datum/gas/nitrium::name]会消耗 1 摩尔[/datum/gas/nitrogen::name]。",
		/datum/gas/nitrium = "[/datum/gas/nitrium::name]的生成速率与温度成正比。",
		"Temperature" = "只能在 [NITRIUM_FORMATION_MIN_TEMP]K 以上发生",
		"Energy" = "每生成 1 摩尔[/datum/gas/nitrium::name]会吸收 [NITRIUM_FORMATION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/standard/nitrium_decomposition/init_factors()
	factor = list(
		/datum/gas/oxygen = "反应需要存在 [MINIMUM_MOLE_COUNT] 摩尔[/datum/gas/oxygen::name]，但不会消耗。",
		/datum/gas/nitrium = "[/datum/gas/nitrium::name]的消耗速率与温度成正比。",
		/datum/gas/hydrogen = "每分解 1 摩尔[/datum/gas/nitrium::name]会生成 1 摩尔[/datum/gas/hydrogen::name]。",
		/datum/gas/nitrogen = "每分解 1 摩尔[/datum/gas/nitrium::name]会生成 1 摩尔[/datum/gas/nitrogen::name]。",
		"Temperature" = "只能在 [NITRIUM_DECOMPOSITION_MAX_TEMP] 以下发生。温度越高，[/datum/gas/nitrium::name]分解越快。",
		"Energy" = "每分解 1 摩尔[/datum/gas/nitrium::name]会释放 [NITRIUM_DECOMPOSITION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/standard/freonformation/init_factors()
	factor = list(
		/datum/gas/plasma = "至少需要存在 0.06 摩尔[/datum/gas/plasma::name]。\
			每生成 1 摩尔[/datum/gas/freon::name]会消耗 0.6 摩尔[/datum/gas/plasma::name]。",
		/datum/gas/carbon_dioxide = "至少需要存在 0.03 摩尔[/datum/gas/carbon_dioxide::name]。\
			每生成 1 摩尔[/datum/gas/freon::name]会消耗 0.3 摩尔[/datum/gas/carbon_dioxide::name]。",
		/datum/gas/bz = "至少需要存在 0.01 摩尔[/datum/gas/bz::name]。\
			每生成 1 摩尔[/datum/gas/freon::name]会消耗 0.1 摩尔[/datum/gas/bz::name]。",
		/datum/gas/freon = "[/datum/gas/freon::name]的生成速率随温度变化。\
			详见温度因素说明。",
		"Energy" = "每生成 1 摩尔[/datum/gas/freon::name]会吸收 100 至 800 焦耳能量", // I don't know why the energy release is also a sigmoidal function, but it should really just be constant to be honest.
		"Temperature" = "发生的最低温度为 [FIRE_MINIMUM_TEMPERATURE_TO_EXIST + 100]K。\
			生成速率在 800K 时达到峰值，但温度超过 5500K 后，\
			生成速率可超过低温峰值（在 8500K 时可达其三倍）。",
	)

/datum/gas_reaction/standard/nobliumformation/init_factors()
	factor = list(
		/datum/gas/nitrogen = "反应需要存在 10 摩尔[/datum/gas/nitrogen::name]。\
			每生成 1 摩尔[/datum/gas/hypernoblium::name]会消耗 10 摩尔[/datum/gas/nitrogen::name]。",
		/datum/gas/tritium = "反应需要存在 5 摩尔[/datum/gas/tritium::name]。\
			每生成 1 摩尔[/datum/gas/hypernoblium::name]会消耗 5 摩尔[/datum/gas/tritium::name]。\
				存在[/datum/gas/bz::name]时，[/datum/gas/tritium::name]的相对消耗比例会降低。",
		/datum/gas/hypernoblium = "[/datum/gas/hypernoblium::name]的产量随\
			[/datum/gas/nitrogen::name]与[/datum/gas/tritium::name]的摩尔数之和变化。",
		"Energy" = "每生成 1 摩尔[/datum/gas/hypernoblium::name]会释放 [NOBLIUM_FORMATION_ENERGY] 焦耳能量。",
		/datum/gas/bz = "[/datum/gas/bz::name]不会在反应中被消耗，但会减少释放的能量。\
			它还会根据[/datum/gas/tritium::name]与[/datum/gas/bz::name]的比例\
			减少[/datum/gas/tritium::name]的消耗；[/datum/gas/bz::name]相对[/datum/gas/tritium::name]越多，减少得越多。",
		"Temperature" = "只能在 [NOBLIUM_FORMATION_MIN_TEMP] - [NOBLIUM_FORMATION_MAX_TEMP]K 之间发生",
	)

/datum/gas_reaction/standard/halon_o2removal/init_factors()
	factor = list(
		/datum/gas/halon = "[/datum/gas/halon::name]的消耗速率与温度成正比。",
		/datum/gas/oxygen = "每燃烧 1 摩尔[/datum/gas/halon::name]会消耗 20 摩尔[/datum/gas/oxygen::name]。",
		/datum/gas/carbon_dioxide = "每消耗 1 摩尔[/datum/gas/halon::name]会生成 5 摩尔[/datum/gas/carbon_dioxide::name]。",
		"Energy" = "每消耗 1 摩尔[/datum/gas/halon::name]会吸收 [HALON_COMBUSTION_ENERGY] 焦耳能量。",
		"Temperature" = "只能在 [FIRE_MINIMUM_TEMPERATURE_TO_EXIST]K 以上发生。温度越高，[/datum/gas/halon::name]消耗越快。",
	)

/datum/gas_reaction/standard/healium_formation/init_factors()
	factor = list(
		/datum/gas/bz = "每生成 1 摩尔[/datum/gas/healium::name]会消耗 1/12 摩尔[/datum/gas/bz::name]。",
		/datum/gas/freon = "每生成 1 摩尔[/datum/gas/healium::name]会消耗 11/12 摩尔[/datum/gas/freon::name]。",
		/datum/gas/healium = "[/datum/gas/healium::name]的生成速率与温度成正比。",
		"Temperature" = "只能在 [HEALIUM_FORMATION_MIN_TEMP] - [HEALIUM_FORMATION_MAX_TEMP] 之间发生。\
			温度越高，[/datum/gas/healium::name]生成越快。",
		"Energy" = "每生成 1 摩尔[/datum/gas/healium::name]会释放 [HEALIUM_FORMATION_ENERGY/3] 焦耳能量。",
	)

/datum/gas_reaction/standard/zauker_formation/init_factors()
	factor = list(
		/datum/gas/hypernoblium = "每生成 1 摩尔[/datum/gas/zauker::name]会消耗 0.02 摩尔[/datum/gas/hypernoblium::name]。",
		/datum/gas/nitrium = "每生成 1 摩尔[/datum/gas/zauker::name]会消耗 1 摩尔[/datum/gas/nitrium::name]。",
		/datum/gas/zauker = "[/datum/gas/zauker::name]的生成速率与温度成正比。",
		"Temperature" = "只能在 [ZAUKER_FORMATION_MIN_TEMPERATURE] - [ZAUKER_FORMATION_MAX_TEMPERATURE]K 之间发生。[/datum/gas/zauker::name]的生成速率与温度成正比。",
		"Energy" = "每生成 1 摩尔[/datum/gas/zauker::name]会吸收 [2 * ZAUKER_FORMATION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/standard/zauker_decomp/init_factors() //Fixed reaction rate
	factor = list(
		/datum/gas/zauker = "每个独立气体混合物中的[/datum/gas/zauker::name]以每秒 [ZAUKER_DECOMPOSITION_MAX_RATE SECONDS / SSair.wait] 摩尔的速率消耗。",
		/datum/gas/nitrogen = "反应至少需要存在 [MINIMUM_MOLE_COUNT] 摩尔[/datum/gas/nitrogen::name]。\
			每分解 1 摩尔[/datum/gas/zauker::name]会生成 0.7 摩尔[/datum/gas/nitrogen::name]。",
		/datum/gas/oxygen = "每分解 1 摩尔[/datum/gas/zauker::name]会生成 0.3 摩尔[/datum/gas/oxygen::name]。",
		"Energy" = "每分解 1 摩尔[/datum/gas/zauker::name]会释放 [ZAUKER_DECOMPOSITION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/standard/proto_nitrate_formation/init_factors()
	factor = list(
		/datum/gas/pluoxium = "每生成 1 摩尔[/datum/gas/proto_nitrate::name]会消耗 1/11 摩尔[/datum/gas/pluoxium::name]。",
		/datum/gas/hydrogen = "每生成 1 摩尔[/datum/gas/proto_nitrate::name]会消耗 10/11 摩尔[/datum/gas/hydrogen::name]。",
		/datum/gas/proto_nitrate = "[/datum/gas/proto_nitrate::name]的生成速率与温度成正比。",
		"Energy" = "每生成 1 摩尔[/datum/gas/proto_nitrate::name]会释放 [PN_FORMATION_ENERGY / 2.2] 焦耳能量。",
		"Temperature" = "只能在 [PN_FORMATION_MIN_TEMPERATURE] - [PN_FORMATION_MAX_TEMPERATURE]K 之间发生。\
			温度越高，[/datum/gas/proto_nitrate::name]生成越快。",
	)

/datum/gas_reaction/standard/proto_nitrate_hydrogen_response/init_factors() // Fixed reaction rate
	factor = list(
		/datum/gas/hydrogen = "反应需要存在 [PN_HYDROGEN_CONVERSION_THRESHOLD] 摩尔[/datum/gas/hydrogen::name]。\
			每生成 1 摩尔[/datum/gas/proto_nitrate::name]会消耗 2 摩尔[/datum/gas/hydrogen::name]。",
		/datum/gas/proto_nitrate = "反应需要存在 [MINIMUM_MOLE_COUNT] 摩尔[/datum/gas/proto_nitrate::name]。\
			[/datum/gas/proto_nitrate::name]的生成速率与自身摩尔数成正比，\
			最高为每秒 [PN_HYDROGEN_CONVERSION_MAX_RATE * 0.5 SECONDS / SSair.wait] 摩尔。",
		"Energy" = "每生成 1 摩尔[/datum/gas/proto_nitrate::name]会吸收 [PN_HYDROGEN_CONVERSION_ENERGY * 2] 焦耳能量。",
	)

/datum/gas_reaction/standard/proto_nitrate_tritium_response/init_factors()
	factor = list(
		/datum/gas/tritium = "[/datum/gas/tritium::name]释放中子的速率与温度及[/datum/gas/proto_nitrate::name]的摩尔数成正比。",
		/datum/gas/proto_nitrate = "每释放 1 摩尔中子会消耗 0.005 摩尔[/datum/gas/proto_nitrate::name]。",
		/datum/gas/hydrogen = "中子逸出后留下[/datum/gas/hydrogen::name]。",
		"Energy" = "每释放 1 摩尔中子会释放 [PN_TRITIUM_CONVERSION_ENERGY / 2] 焦耳能量。",
		"Radiation" = "中子以电离辐射的形式释放。",
	)

/datum/gas_reaction/standard/proto_nitrate_bz_response/init_factors()
	factor = list(
		/datum/gas/proto_nitrate = "反应需要存在 [MINIMUM_MOLE_COUNT] 摩尔[/datum/gas/proto_nitrate::name]。\
			[/datum/gas/proto_nitrate::name]会加速[/datum/gas/bz::name]分解。",
		/datum/gas/bz = "[/datum/gas/bz::name]分解为[/datum/gas/plasma::name]和[/datum/gas/nitrous_oxide::name]。\
			随后[/datum/gas/nitrous_oxide::name]分解为[/datum/gas/nitrogen::name]和[/datum/gas/oxygen::name]，\
			[/datum/gas/oxygen::name]再衰变为[/datum/gas/helium::name]。",
		/datum/gas/nitrogen = "每分解 1 摩尔[/datum/gas/bz::name]会生成 0.4 摩尔[/datum/gas/nitrogen::name]。",
		/datum/gas/helium = "每分解 1 摩尔[/datum/gas/bz::name]会生成 1.6 摩尔[/datum/gas/helium::name]。",
		/datum/gas/plasma = "每分解 1 摩尔[/datum/gas/bz::name]会生成 0.8 摩尔[/datum/gas/plasma::name]。",
		"Energy" = "每分解 1 摩尔[/datum/gas/bz::name]会释放 [PN_BZASE_ENERGY] 焦耳能量。",
		"Radiation" = "此分解过程会释放辐射。",
		"Hallucinations" = "此反应可能使附近的各种碳基生命产生幻觉。",
		"Nuclear Particles" = "此反应会释放能量极高的核粒子，\
			每个独立气体混合物每秒最多释放 [2 * PN_BZASE_NUCLEAR_PARTICLE_MAXIMUM] 个。",
		"Temperature" = "只能在 [PN_BZASE_MIN_TEMP] - [PN_BZASE_MAX_TEMP]K 之间发生。",
	)

/datum/gas_reaction/standard/antinoblium_replication/init_factors()
	factor = list(
		/datum/gas/antinoblium = "自我复制需要 [MOLES_GAS_VISIBLE] 摩尔[/datum/gas/antinoblium::name]。\
			需要将其他气体转化为[/datum/gas/antinoblium::name]。",
		"Temperature" = "只能在 [REACTION_OPPRESSION_MIN_TEMP]K 以上发生。"
	)
