/datum/gas_reaction/water_vapor/init_factors()
	factor = list(
		/datum/gas/water_vapor = "冷凝会消耗 [MOLES_GAS_VISIBLE] 摩尔，冻结则不会消耗任何摩尔。两者都至少需要 [MOLES_GAS_VISIBLE] 摩尔才能发生。",
		"Temperature" = "在 [WATER_VAPOR_DEPOSITION_POINT] 开尔文或以下会冻结地砖，在 [WATER_VAPOR_CONDENSATION_POINT] 开尔文或以下会将其打湿。",
		"Location" = "只能在地砖上发生。",
	)

/datum/gas_reaction/miaster/init_factors()
	factor = list(
		/datum/gas/miasma = "瘴气的灭菌速率与温度和 [MIASTER_STERILIZATION_TEMP]K 之间的差值成正比。",
		/datum/gas/oxygen = "每消耗 1 摩尔瘴气会释放 1 摩尔氧气。",
		"Temperature" = "温度越高，瘴气灭菌越快。",
		"Energy" = "每灭菌 1 摩尔瘴气会释放 [MIASTER_STERILIZATION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/plasmafire/init_factors()
	factor = list(
		/datum/gas/oxygen = "氧气消耗量由温度决定：在 [PLASMA_MINIMUM_BURN_TEMPERATURE] 开尔文时，每消耗 1 摩尔等离子体会消耗 [OXYGEN_BURN_RATIO_BASE] 摩尔氧气；在 [PLASMA_UPPER_TEMPERATURE] 开尔文时为 [OXYGEN_BURN_RATIO_BASE-1] 摩尔。氧气浓度最高达到等离子体的 [PLASMA_OXYGEN_FULLBURN] 倍可加快等离子体的消耗速度。",
		/datum/gas/plasma = "等离子体的消耗速率与温度和 [PLASMA_MINIMUM_BURN_TEMPERATURE]K 之间的差值成正比，在 [PLASMA_UPPER_TEMPERATURE]K 时达到最大。",
		/datum/gas/tritium = "当氧气至少为等离子体的 97 倍时，每消耗 1 摩尔等离子体会生成 1 摩尔氚。",
		/datum/gas/water_vapor = "若未生成氚，则每消耗 1 摩尔等离子体会生成 0.25 摩尔水蒸气。",
		/datum/gas/carbon_dioxide = "若未生成氚，则每消耗 1 摩尔等离子体会生成 0.75 摩尔二氧化碳。",
		"Temperature" = "发生的最低温度为 [PLASMA_MINIMUM_BURN_TEMPERATURE] 开尔文。温度升高至 [PLASMA_UPPER_TEMPERATURE]K 可提高氧气效率，并提高等离子体的消耗速率。",
		"Energy" = "每消耗 1 摩尔等离子体会释放 [FIRE_PLASMA_ENERGY_RELEASED] 焦耳能量。",
	)

/datum/gas_reaction/h2fire/init_factors()
	factor = list(
		/datum/gas/oxygen = "每消耗 1 摩尔氢气会消耗 0.5 摩尔氧气。氧气浓度最高达到氢气的 [HYDROGEN_OXYGEN_FULLBURN] 倍可提高氢气的消耗速率。",
		/datum/gas/hydrogen = "只要氧气足以支持燃烧，氢气就会被极快地消耗。",
		/datum/gas/water_vapor = "每燃烧 1 摩尔氢气会生成 1 摩尔水蒸气。",
		"Temperature" = "发生的最低温度为 [FIRE_MINIMUM_TEMPERATURE_TO_EXIST] 开尔文",
		"Energy" = "每消耗 1 摩尔氢气会释放 [FIRE_HYDROGEN_ENERGY_RELEASED] 焦耳能量。",
	)

/datum/gas_reaction/tritfire/init_factors()
	factor = list(
		/datum/gas/oxygen = "每消耗 1 摩尔氚会消耗 0.5 摩尔氧气。氧气浓度最高达到氚的 [TRITIUM_OXYGEN_FULLBURN] 倍可提高氚的消耗速率。",
		/datum/gas/tritium = "只要氧气足以支持燃烧，氚就会被极快地消耗。",
		/datum/gas/water_vapor = "每燃烧 1 摩尔氚会生成 1 摩尔水蒸气。",
		"Temperature" = "发生的最低温度为 [FIRE_MINIMUM_TEMPERATURE_TO_EXIST] 开尔文",
		"Energy" = "每消耗 1 摩尔氚会释放 [FIRE_TRITIUM_ENERGY_RELEASED] 焦耳能量。",
		"Radiation" = "此反应会释放与释放能量成正比的辐射。",
	)

/datum/gas_reaction/freonfire/init_factors()
	factor = list(
		/datum/gas/oxygen = "氧气消耗量由温度决定：在 [FREON_LOWER_TEMPERATURE] 开尔文时，每消耗 1 摩尔氟利昂会消耗 [OXYGEN_BURN_RATIO_BASE] 摩尔氧气；在 [FREON_MAXIMUM_BURN_TEMPERATURE] 开尔文时为 [OXYGEN_BURN_RATIO_BASE-1] 摩尔。氧气浓度最高达到氟利昂的 [FREON_OXYGEN_FULLBURN] 倍可提高氟利昂的消耗速率。",
		/datum/gas/freon = "氟利昂的消耗速率与温度同 [FREON_MAXIMUM_BURN_TEMPERATURE]K 的距离成正比。其与氧气的关系同样会影响消耗速率。",
		/datum/gas/carbon_dioxide = "每消耗 1 摩尔氟利昂会生成 1 摩尔二氧化碳。",
		"Temperature" = "只能在 [FREON_LOWER_TEMPERATURE] - [FREON_MAXIMUM_BURN_TEMPERATURE] 开尔文之间发生",
		"Energy" = "每消耗 1 摩尔氟利昂会吸收 [FIRE_FREON_ENERGY_CONSUMED] 焦耳能量。",
		"Hot Ice" = "此反应在 [HOT_ICE_FORMATION_MINIMUM_TEMPERATURE]-[HOT_ICE_FORMATION_MAXIMUM_TEMPERATURE] 开尔文之间发生时会生成热冰",
	)


/datum/gas_reaction/nitrousformation/init_factors()
	factor = list(
		/datum/gas/oxygen = "反应发生需要存在 10 摩尔氧气。每生成 1 摩尔一氧化二氮会消耗 0.5 摩尔氧气。",
		/datum/gas/nitrogen = "反应发生需要存在 20 摩尔氮气。每生成 1 摩尔一氧化二氮会消耗 1 摩尔氮气。",
		/datum/gas/bz = "反应发生需要存在 5 摩尔 BZ。不会被消耗。",
		/datum/gas/nitrous_oxide = "一氧化二氮会迅速生成。",
		"Temperature" = "只能在 [N2O_FORMATION_MIN_TEMPERATURE] - [N2O_FORMATION_MAX_TEMPERATURE] 开尔文之间发生",
		"Energy" = "每生成 1 摩尔一氧化二氮会释放 [N2O_FORMATION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/nitrous_decomp/init_factors()
	factor = list(
		/datum/gas/nitrous_oxide = "一氧化二氮的分解速率与温度和该反应最低、最高温度平均值之间的距离成负相关。至少需要 [MINIMUM_MOLE_COUNT * 2] 摩尔才发生。", //okay this one isn't made into a define yet.
		/datum/gas/oxygen = "每分解 1 摩尔一氧化二氮会生成 0.5 摩尔氧气。",
		/datum/gas/nitrogen = "每分解 1 摩尔一氧化二氮会生成 1 摩尔氮气。",
		"Temperature" = "分解速率与温度和最低、最高温度之间距离的乘积成正比。只能在 [N2O_DECOMPOSITION_MIN_TEMPERATURE] - [N2O_DECOMPOSITION_MAX_TEMPERATURE] 开尔文之间发生。",
		"Energy" = "每分解 1 摩尔一氧化二氮会释放 [N2O_DECOMPOSITION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/bzformation/init_factors()
	factor = list(
		/datum/gas/plasma = "每生成 1 摩尔 BZ 会消耗 0.8 摩尔等离子体。若等离子体多于一氧化二氮，BZ 的生成速率会减慢。",
		/datum/gas/nitrous_oxide = "每生成 1 摩尔 BZ 会消耗 0.4 摩尔一氧化二氮。若一氧化二氮少于等离子体，反应速率会减慢。当等离子体达到一氧化二氮的三倍时，一氧化二氮会开始分解为氮气和氧气，比例越低，分解的一氧化二氮越多。",
		/datum/gas/bz = "气压越低、体积越大，生成的 BZ 越多。一氧化二氮少于等离子体会减慢反应。",
		/datum/gas/nitrogen = "每分解 1 摩尔一氧化二氮会生成 1 摩尔氮气。一氧化二氮与等离子体的比例越低，分解与 BZ 生成的比值越高。",
		/datum/gas/oxygen = "每分解 1 摩尔一氧化二氮会生成 0.5 摩尔氧气。一氧化二氮与等离子体的比例越低，分解与 BZ 生成的比值越高。",
		"Energy" = "每生成 1 摩尔 BZ 会释放 [BZ_FORMATION_ENERGY] 焦耳能量。一氧化二氮每分解 1 摩尔会释放 [N2O_DECOMPOSITION_ENERGY] 焦耳",
	)

/datum/gas_reaction/pluox_formation/init_factors()
	factor = list(
		/datum/gas/carbon_dioxide = "每生成 1 摩尔富氧气会消耗 1 摩尔二氧化碳。",
		/datum/gas/oxygen = "每生成 1 摩尔富氧气会消耗 0.5 摩尔氧气。",
		/datum/gas/tritium = "每生成 1 摩尔富氧气，会有 0.01 摩尔氚转化为氢气。",
		/datum/gas/pluoxium = "在任何给定混合气中，富氧气都会以恒定速率生成。",
		/datum/gas/hydrogen = "氢气由氚失去中子后形成。",
		"Energy" = "每生成 1 摩尔富氧气会释放 [PLUOXIUM_FORMATION_ENERGY] 焦耳能量。",
		"Temperature" = "只能在 [PLUOXIUM_FORMATION_MIN_TEMP] - [PLUOXIUM_FORMATION_MAX_TEMP] 开尔文之间发生",
	)

/datum/gas_reaction/nitrium_formation/init_factors()
	factor = list(
		/datum/gas/bz = "反应发生需要存在 5 摩尔 BZ。每生成 1 摩尔氮素气会消耗 0.05 摩尔 BZ。",
		/datum/gas/tritium = "反应发生需要存在 20 摩尔氚。每生成 1 摩尔氮素气会消耗 1 摩尔氚。",
		/datum/gas/nitrogen = "反应发生需要存在 10 摩尔氮气。每生成 1 摩尔氮素气会消耗 1 摩尔氮气。",
		/datum/gas/nitrium = "氮素气以随温度变化的速率生成。",
		"Temperature" = "只能在 [NITRIUM_FORMATION_MIN_TEMP] 开尔文以上发生",
		"Energy" = "每生成 1 摩尔氮素气会吸收 [NITRIUM_FORMATION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/nitrium_decomposition/init_factors()
	factor = list(
		/datum/gas/oxygen = "反应发生需要存在 [MINIMUM_MOLE_COUNT] 摩尔氧气。不会被消耗。",
		/datum/gas/nitrium = "氮素气以随温度变化的速率被消耗。",
		/datum/gas/hydrogen = "每分解 1 摩尔氮素气会生成 1 摩尔氢气。",
		/datum/gas/nitrogen = "每分解 1 摩尔氮素气会生成 1 摩尔氮气。",
		"Temperature" = "只能在 [NITRIUM_DECOMPOSITION_MAX_TEMP] 以下发生。温度越高，氮素气的分解越快。",
		"Energy" = "每分解 1 摩尔氮素气会释放 [NITRIUM_DECOMPOSITION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/freonformation/init_factors()
	factor = list(
		/datum/gas/plasma = "至少需要存在 0.06 摩尔等离子体。每生成 1 摩尔氟利昂会消耗 0.6 摩尔等离子体。",
		/datum/gas/carbon_dioxide = "至少需要存在 0.03 摩尔二氧化碳。每生成 1 摩尔氟利昂会消耗 0.3 摩尔二氧化碳。",
		/datum/gas/bz = "至少需要存在 0.01 摩尔 BZ。每生成 1 摩尔氟利昂会消耗 0.1 摩尔 BZ。",
		/datum/gas/freon = "氟利昂以随温度变化的速率生成，该速率是二次指数函数与 S 形函数之和，二次指数项在 800 开尔文时达到峰值，但 S 形函数在超过 5,500K 后占据主导，效率最高可达 3 倍。",
		"Energy" = "每生成 1 摩尔氟利昂会吸收 100 至 800 焦耳能量", // I don't know why the energy release is also a sigmoidal function, but it should really just be constant to be honest.
		"Temperature" = "发生的最低温度为 [FIRE_MINIMUM_TEMPERATURE_TO_EXIST + 100] 开尔文，产量在 800K 时达到峰值。不过在 5500K 以上可以实现更高的速率，在超过 8500K 时最高可达低温速率的 3 倍。",
	)

/datum/gas_reaction/nobliumformation/init_factors()
	factor = list(
		/datum/gas/nitrogen = "反应发生需要存在 10 摩尔氮气。每生成 1 摩尔超惰性气体，会消耗 10 摩尔氮气。",
		/datum/gas/tritium = "反应发生需要存在 5 摩尔氚。每生成 1 摩尔超惰性气体，会消耗 5 摩尔氚。氚的相对消耗速率会在 BZ 存在时降低。",
		/datum/gas/hypernoblium = "超惰性气体的产量取决于氮气与氚的摩尔数之和。",
		"Energy" = "每生成 1 摩尔超惰性气体会释放 [NOBLIUM_FORMATION_ENERGY] 焦耳能量。",
		/datum/gas/bz = "BZ 在此反应中不被消耗，但会降低释放的能量。它还会按氚与 BZ 的比例减少氚的消耗量，BZ 多于氚时减少得更多。",
		"Temperature" = "只能在 [NOBLIUM_FORMATION_MIN_TEMP] - [NOBLIUM_FORMATION_MAX_TEMP] 开尔文之间发生",
	)

/datum/gas_reaction/halon_o2removal/init_factors()
	factor = list(
		/datum/gas/halon = "哈龙以随温度变化的速率被消耗。",
		/datum/gas/oxygen = "每燃烧 1 摩尔哈龙会消耗 20 摩尔氧气。",
		/datum/gas/carbon_dioxide = "每消耗 1 摩尔哈龙会生成 5 摩尔二氧化碳。",
		"Energy" = "每消耗 1 摩尔哈龙会吸收 [HALON_COMBUSTION_ENERGY] 焦耳能量。",
		"Temperature" = "只能在 [FIRE_MINIMUM_TEMPERATURE_TO_EXIST] 开尔文以上发生。温度越高，哈龙的消耗越快。",
	)

/datum/gas_reaction/healium_formation/init_factors()
	factor = list(
		/datum/gas/bz = "每生成 1 摩尔愈合气会消耗 1/12 摩尔 BZ。",
		/datum/gas/freon = "每生成 1 摩尔愈合气会消耗 11/12 摩尔氟利昂。",
		/datum/gas/healium = "愈合气以随温度变化的速率生成。",
		"Temperature" = "只能在 [HEALIUM_FORMATION_MIN_TEMP] - [HEALIUM_FORMATION_MAX_TEMP] 之间发生。温度越高，愈合气的生成越快。",
		"Energy" = "每生成 1 摩尔愈合气会释放 [HEALIUM_FORMATION_ENERGY/3] 焦耳能量。",
	)

/datum/gas_reaction/zauker_formation/init_factors()
	factor = list(
		/datum/gas/hypernoblium = "每生成 1 摩尔灼蚀气会消耗 0.02 摩尔超惰性气体。",
		/datum/gas/nitrium = "每生成 1 摩尔灼蚀气会消耗 1 摩尔氮素气。",
		/datum/gas/zauker = "灼蚀气以随温度变化的速率生成。",
		"Temperature" = "只能在 [ZAUKER_FORMATION_MIN_TEMPERATURE] - [ZAUKER_FORMATION_MAX_TEMPERATURE] 开尔文之间发生。灼蚀气的生成速率与温度成正比。",
		"Energy" = "每生成 1 摩尔灼蚀气会吸收 [2 * ZAUKER_FORMATION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/zauker_decomp/init_factors() //Fixed reaction rate
	factor = list(
		/datum/gas/zauker = "在任何独特的混合气中，灼蚀气每秒被消耗 [ZAUKER_DECOMPOSITION_MAX_RATE SECONDS / SSair.wait] 摩尔。",
		/datum/gas/nitrogen = "此反应发生至少需要存在 [MINIMUM_MOLE_COUNT] 摩尔氮气。每分解 1 摩尔灼蚀气会生成 0.7 摩尔氮气。",
		/datum/gas/oxygen = "每分解 1 摩尔灼蚀气会生成 0.3 摩尔氧气。",
		"Energy" = "每分解 1 摩尔灼蚀气会释放 [ZAUKER_DECOMPOSITION_ENERGY] 焦耳能量。",
	)

/datum/gas_reaction/proto_nitrate_formation/init_factors()
	factor = list(
		/datum/gas/pluoxium = "每生成 1 摩尔原硝气会消耗 1/11 摩尔富氧气。",
		/datum/gas/hydrogen = "每生成 1 摩尔原硝气会消耗 10/11 摩尔氢气。",
		/datum/gas/proto_nitrate = "原硝气以随温度变化的速率生成。",
		"Energy" = "每生成 1 摩尔原硝气会释放 [PN_FORMATION_ENERGY / 2.2] 焦耳能量。",
		"Temperature" = "只能在 [PN_FORMATION_MIN_TEMPERATURE] - [PN_FORMATION_MAX_TEMPERATURE] 开尔文之间发生。温度越高，原硝气的生成越快。",
	)

/datum/gas_reaction/proto_nitrate_hydrogen_response/init_factors() // Fixed reaction rate
	factor = list(
		/datum/gas/hydrogen = "反应发生需要存在 [PN_HYDROGEN_CONVERSION_THRESHOLD] 摩尔氢气。每生成 1 摩尔原硝气会消耗 2 摩尔氢气。",
		/datum/gas/proto_nitrate = "反应发生需要存在 [MINIMUM_MOLE_COUNT] 摩尔原硝气。原硝气以其摩尔数为基准、以与摩尔数成正比的速率生成，最高为每秒 [PN_HYDROGEN_CONVERSION_MAX_RATE * 0.5 SECONDS / SSair.wait] 摩尔。",
		"Energy" = "每生成 1 摩尔原硝气会吸收 [PN_HYDROGEN_CONVERSION_ENERGY * 2] 焦耳能量。",
	)

/datum/gas_reaction/proto_nitrate_tritium_response/init_factors()
	factor = list(
		/datum/gas/tritium = "氚以随温度和原硝气摩尔数变化的速率辐射出中子。",
		/datum/gas/proto_nitrate = "每释放 1 摩尔中子会消耗 0.005 摩尔原硝气。",
		/datum/gas/hydrogen = "中子逃逸后会残留氢气。",
		"Energy" = "每释放 1 摩尔中子会释放 [PN_TRITIUM_CONVERSION_ENERGY / 2] 焦耳能量。",
		"Radiation" = "中子以电离辐射的形式被释放。",
	)

/datum/gas_reaction/proto_nitrate_bz_response/init_factors()
	factor = list(
		/datum/gas/proto_nitrate = "反应发生需要存在 [MINIMUM_MOLE_COUNT] 摩尔原硝气。原硝气会加速 BZ 的分解。",
		/datum/gas/bz = "BZ 会分解为等离子体与一氧化二氮。随后一氧化二氮分解为氮气与氧气，氧气再衰变为氦气。",
		/datum/gas/nitrogen = "每分解 1 摩尔 BZ 会生成 0.4 摩尔氮气。",
		/datum/gas/helium = "每分解 1 摩尔 BZ 会生成 1.6 摩尔氦气。",
		/datum/gas/plasma = "每分解 1 摩尔 BZ 会生成 0.8 摩尔等离子体。",
		"Energy" = "每分解 1 摩尔 BZ 会释放 [PN_BZASE_ENERGY] 焦耳能量。",
		"Radiation" = "此分解过程会释放辐射。",
		"Hallucinations" = "此反应会使附近的多种碳基生物产生幻觉。",
		"Nuclear Particles" = "此反应会释放能量极高的核粒子，每个独特混合气每秒最多 [2 * PN_BZASE_NUCLEAR_PARTICLE_MAXIMUM] 个。",
		"Temperature" = "只能在 [PN_BZASE_MIN_TEMP] - [PN_BZASE_MAX_TEMP] 开尔文之间发生。",
	)

/datum/gas_reaction/antinoblium_replication/init_factors()
	factor = list(
		/datum/gas/antinoblium = "需要 [MOLES_GAS_VISIBLE] 摩尔反惰性气体才能自我复制。需要将其他气体转化为反惰性气体。",
		"Temperature" = "只能在 [REACTION_OPPRESSION_MIN_TEMP] 开尔文以上发生。"
	)

