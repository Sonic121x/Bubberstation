/datum/borer_evolution/symbiote
	evo_type = BORER_EVOLUTION_SYMBIOTE

// T1
/datum/borer_evolution/symbiote/willing_host
	name = "自愿宿主"
	desc = "询问宿主是否自愿，推进你的目标。"
	gain_text = "我们喂给虫子的那些猴子中，有些似乎远比其他的更……愿意成为宿主。我发誓我看到其中一只让虫子爬上了它的手臂。"
	tier = 1
	unlocked_evolutions = list(/datum/borer_evolution/symbiote/chem_per_level)
	evo_cost = 1

/datum/borer_evolution/symbiote/willing_host/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/cooldown/mob_cooldown/borer/willing_host/attack_action = new(cortical_owner)
	attack_action.Grant(cortical_owner)

// T2
/datum/borer_evolution/symbiote/chem_per_level
	name = "化学物质增量"
	desc = "提高你每次升级时获得的化学物质量。"
	gain_text = "我们清理皮层钻虫笼子的频率越来越高了。也许它们的分泌物是用不完的多余化学物质？"
	tier = 2
	unlocked_evolutions = list(/datum/borer_evolution/symbiote/expanded_chemicals)

/datum/borer_evolution/symbiote/chem_per_level/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.chem_storage_per_level += 10
	cortical_owner.chem_regen_per_level += 0.5
	cortical_owner.recalculate_stats()

// T3 + T2 Path
/datum/borer_evolution/symbiote/expanded_chemicals
	name = "扩展化学品清单"
	desc = "在可解锁清单中获得一批新的有益化学物质。"
	gain_text = "这些虫子能够合成的化学物质实在惊人，它们的宿主在受到惊人程度的伤害后仍能站起来。"
	mutually_exclusive = TRUE
	tier = 3
	unlocked_evolutions = list(
		/datum/borer_evolution/symbiote/harm_decrease,
		/datum/borer_evolution/symbiote/chem_per_level/t2,
	)
	var/static/list/added_chemicals = list(
		/datum/reagent/medicine/sal_acid,
		/datum/reagent/medicine/oxandrolone,
		/datum/reagent/medicine/atropine,
		/datum/reagent/medicine/neurine,
		/datum/reagent/medicine/leporazine,
		/datum/reagent/medicine/omnizine,
	)

/datum/borer_evolution/symbiote/expanded_chemicals/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.potential_chemicals |= added_chemicals

/datum/borer_evolution/symbiote/chem_per_level/t2
	name = "化学物质增量 II"
	desc = "进一步提高你每次升级时获得的化学物质量。"
	tier = -1
	unlocked_evolutions = list(/datum/borer_evolution/symbiote/chem_per_level/t3)

/datum/borer_evolution/symbiote/chem_per_level/t3
	name = "化学物质增量 III"
	desc = "进一步提高你每次升级时获得的化学物质量。"
	tier = -1
	unlocked_evolutions = list()

// T4 and path
/datum/borer_evolution/symbiote/harm_decrease
	name = "毒素减量"
	desc = "降低你对宿主的被动与主动伤害，以及伤害发生的频率。"
	gain_text = "然而，其他一些个体变得……即使没有更小，也显然更长、更柔韧了。"
	tier = 4
	unlocked_evolutions = list(
		/datum/borer_evolution/symbiote/harm_decrease/t2,
		/datum/borer_evolution/symbiote/revive_host,
	)

/datum/borer_evolution/symbiote/harm_decrease/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.host_harm_multiplier -= 0.25

/datum/borer_evolution/symbiote/harm_decrease/t2
	name = "毒素减量 II"
	desc = "进一步降低你对宿主的被动与主动伤害，以及伤害发生的频率。"
	tier = -1
	unlocked_evolutions = list(/datum/borer_evolution/symbiote/harm_decrease/t3)

/datum/borer_evolution/symbiote/harm_decrease/t3
	name = "毒素减量 III"
	desc = "进一步降低你对宿主的被动与主动伤害，以及伤害发生的频率。"
	tier = -1
	unlocked_evolutions = list()

// T5
/datum/borer_evolution/symbiote/revive_host
	name = "复活宿主"
	desc = "复活你的宿主并治愈其病痛。"
	gain_text = "我在实验室时，发生了迄今为止最离奇的事情。一只皮层钻虫钻进了一具尸体的头部，片刻之后它又站了起来。"
	evo_cost = 3
	tier = 5
	unlocked_evolutions = list(
		/datum/borer_evolution/sugar_immunity,
		/datum/borer_evolution/synthetic_borer,
		/datum/borer_evolution/synthetic_chems_positive,
	)

/datum/borer_evolution/symbiote/revive_host/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/cooldown/mob_cooldown/borer/revive_host/attack_action = new(cortical_owner)
	attack_action.Grant(cortical_owner)

