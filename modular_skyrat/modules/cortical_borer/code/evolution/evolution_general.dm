/datum/borer_evolution/upgrade_injection
	name = "强化注射"
	desc = "将可注射剂量提升至 10 单位。"
	gain_text = "它们的生长速度令人震惊，器官和腺体在短短几天内就能膨胀到原来的数倍。"
	unlocked_evolutions = list(/datum/borer_evolution/upgrade_injection/t2)
	tier = 1

/datum/borer_evolution/upgrade_injection/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.injection_rates_unlocked += cortical_owner.injection_rates[length(cortical_owner.injection_rates_unlocked) + 1]

/datum/borer_evolution/upgrade_injection/t2
	name = "强化注射 II"
	desc = "将可注射剂量提升至 25 单位。"
	unlocked_evolutions = list(/datum/borer_evolution/upgrade_injection/t3)
	tier = 2

/datum/borer_evolution/upgrade_injection/t3
	name = "强化注射 III"
	desc = "将可注射剂量提升至 50 单位。"
	unlocked_evolutions = list()
	tier = 3

/datum/borer_evolution/sugar_immunity
	name = "糖分免疫"
	desc = "免疫你或宿主体内糖分的不良影响。"
	gain_text = "在最大的那些个体中，有几只已经能够抵抗糖分的影响。若我们还想控制住它们，这着实令人担忧。"
	evo_cost = 5
	tier = 6

/datum/borer_evolution/sugar_immunity/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.upgrade_flags |= BORER_SUGAR_IMMUNE

/datum/borer_evolution/synthetic_borer
	name = "合成人钻入"
	desc = "获得将合成人也作为宿主的能力。"
	gain_text = "现在我们用机器人来照料活着的虫子，但有一天……它们全都失控了。安保将其击倒，进一步检查发现虫子已经钻进了处理单元。"
	evo_cost = 6
	tier = 6

/datum/borer_evolution/synthetic_borer/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.organic_restricted = FALSE

/datum/borer_evolution/synthetic_chems_positive
	name = "合成化学品（+）"
	desc = "获得一系列对合成人有帮助的化学物质。"
	gain_text = "在我们确认机器人同样不安全之后，开始用它们做实验。有趣的是，其中一些再也不需要上油了。"
	tier = 6
	evo_cost = 6
	var/static/list/added_chemicals = list(
		/datum/reagent/consumable/ethanol/synthanol,
		/datum/reagent/medicine/system_cleaner,
		/datum/reagent/medicine/nanite_slurry,
		/datum/reagent/medicine/liquid_solder,
		/datum/reagent/fuel/oil,
		/datum/reagent/fuel,
	)

/datum/borer_evolution/synthetic_chems_positive/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.potential_chemicals |= added_chemicals

/datum/borer_evolution/synthetic_chems_negative
	name = "合成化学品（-）"
	desc = "获得一系列能损伤合成人的化学物质。"
	gain_text = "好消息是，有些虫子对机器人也有敌意。它们从内部被腐蚀，有些基本上只剩空壳。"
	tier = 6
	evo_cost = 6
	var/static/list/added_chemicals = list(
		/datum/reagent/toxin/acid/fluacid, // More like anti everything but :shrug:
		/datum/reagent/thermite,
		/datum/reagent/pyrosium,
		/datum/reagent/oxygen,
	)

/datum/borer_evolution/synthetic_chems_negative/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.potential_chemicals |= added_chemicals
