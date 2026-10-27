/datum/borer_evolution/diveworm
	evo_type = BORER_EVOLUTION_DIVEWORM

// T1
/datum/borer_evolution/diveworm/health_per_level
	name = "生命提升"
	desc = "提高你每次升级时获得的健康上限。"
	gain_text = "随着时间推移，一些更具攻击性的虫子死后越来越难解剖。它们的皮肤膜最厚可达原来的三倍。"
	tier = 1
	unlocked_evolutions = list(/datum/borer_evolution/diveworm/host_speed)
	evo_cost = 1

/datum/borer_evolution/diveworm/health_per_level/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.health_per_level += 2.5
	cortical_owner.recalculate_stats()

// T2
/datum/borer_evolution/diveworm/host_speed
	name = "钻入速度"
	desc = "缩短你在未躲藏状态下进入宿主所需的时间。"
	gain_text = "有一两次，我一眨眼，就看到那些未被寄生的猴子正在和一条几秒前还在房间另一头的虫子扭打在一起。"
	tier = 2
	unlocked_evolutions = list(/datum/borer_evolution/diveworm/expanded_chemicals)

/datum/borer_evolution/diveworm/host_speed/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.upgrade_flags |= BORER_FAST_BORING

// T3 + T1 path
/datum/borer_evolution/diveworm/expanded_chemicals
	name = "扩展化学品清单"
	desc = "在可解锁清单中获得一批新的阴险化学物质。"
	gain_text = "有时我会看到一只已知的宿主猴子……倒下，然后站起来，接着又倒下。就好像那条虫子在玩弄它……"
	mutually_exclusive = TRUE
	tier = 3
	unlocked_evolutions = list(
		/datum/borer_evolution/diveworm/harm_increase,
		/datum/borer_evolution/diveworm/health_per_level/t2,
	)
	var/static/list/added_chemicals = list(
		/datum/reagent/toxin/fentanyl,
		/datum/reagent/toxin/staminatoxin,
		/datum/reagent/toxin/mutetoxin,
		/datum/reagent/toxin/mutagen,
		/datum/reagent/toxin/cyanide,
		/datum/reagent/drug/opium,
		/datum/reagent/drug/mushroomhallucinogen,
		/datum/reagent/inverse/oculine,
	)

/datum/borer_evolution/diveworm/expanded_chemicals/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.potential_chemicals |= added_chemicals

/datum/borer_evolution/diveworm/health_per_level/t2
	name = "生命提升 II"
	tier = -1
	unlocked_evolutions = list(/datum/borer_evolution/diveworm/health_per_level/t3)
	evo_cost = 2

/datum/borer_evolution/diveworm/health_per_level/t3
	name = "生命提升 III"
	tier = -1
	unlocked_evolutions = list()
	evo_cost = 2

// T4 + its path
/datum/borer_evolution/diveworm/harm_increase
	name = "毒素增量"
	desc = "提高你对宿主的被动与主动伤害，以及伤害发生的频率。"
	gain_text = "在囚养环境中，一些虫子变得更加……粗野、更大。最明显的是，宿主被它们折磨死得快多了。"
	tier = 4
	unlocked_evolutions = list(
		/datum/borer_evolution/diveworm/harm_increase/t2,
		/datum/borer_evolution/diveworm/empowered_offspring,
	)

/datum/borer_evolution/diveworm/harm_increase/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.host_harm_multiplier += 0.25

/datum/borer_evolution/diveworm/harm_increase/t2
	name = "毒素增量 II"
	desc = "进一步提高你对宿主的被动与主动伤害，以及伤害发生的频率。"
	tier = -1
	unlocked_evolutions = list(/datum/borer_evolution/diveworm/harm_increase/t3)

/datum/borer_evolution/diveworm/harm_increase/t3
	name = "毒素增量 III"
	desc = "进一步提高你对宿主的被动与主动伤害，以及伤害发生的频率。"
	tier = -1
	unlocked_evolutions = list()

// T5
/datum/borer_evolution/diveworm/empowered_offspring
	name = "强化后代"
	desc = "在已死亡的宿主体内产卵，一段时间后将有一只强化皮层钻虫破体而出。"
	gain_text = "大多数虫卵会被宿主从喉咙里吐出来……但有一枚不是。它像恐怖电影里那样从胸口爆了出来。这可真是个令人担忧的发现。"
	evo_cost = 3
	tier = 5
	unlocked_evolutions = list(
		/datum/borer_evolution/sugar_immunity,
		/datum/borer_evolution/synthetic_borer,
		/datum/borer_evolution/synthetic_chems_negative,
	)

/datum/borer_evolution/diveworm/empowered_offspring/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/cooldown/mob_cooldown/borer/empowered_offspring/attack_action = new(cortical_owner)
	attack_action.Grant(cortical_owner)
