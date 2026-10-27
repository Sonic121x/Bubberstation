/datum/borer_evolution/hivelord
	evo_type = BORER_EVOLUTION_HIVELORD

// T1
/datum/borer_evolution/hivelord/produce_offspring
	name = "产出后代"
	desc = "产下一枚虫卵，由你的宿主吐出来。"
	gain_text = "皮层钻虫产卵的方式十分古怪。到目前为止，我们既没见过它如何产卵，也没见过它在宿主之外产卵。"
	tier = 1
	unlocked_evolutions = list(/datum/borer_evolution/hivelord/blood_chemical)
	evo_cost = 1

/datum/borer_evolution/hivelord/produce_offspring/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/cooldown/mob_cooldown/borer/produce_offspring/attack_action = new(cortical_owner)
	attack_action.Grant(cortical_owner)

// T2
/datum/borer_evolution/hivelord/blood_chemical
	name = "习得血液化学物质"
	desc = "从宿主的血液中学会一种可合成的化学物质。"
	gain_text = "我们在解剖一只曾当过宿主的猴子的粪便时，发现其中香蕉物质的浓度很高，尽管过去一周我们都没喂过它香蕉。"
	tier = 2
	unlocked_evolutions = list(/datum/borer_evolution/hivelord/movespeed)

/datum/borer_evolution/hivelord/blood_chemical/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/cooldown/mob_cooldown/borer/learn_bloodchemical/attack_action = new(cortical_owner)
	attack_action.Grant(cortical_owner)

// T3
/datum/borer_evolution/hivelord/movespeed
	name = "精力提升"
	desc = "大幅提升你的速度。"
	gain_text = "在我注视下，那只皮层钻虫跑完全程所用的时间，只有上周的一半多一点。"
	mutually_exclusive = TRUE
	tier = 3
	unlocked_evolutions = list(/datum/borer_evolution/hivelord/stealth_mode)

/datum/borer_evolution/hivelord/movespeed/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.add_movespeed_modifier(/datum/movespeed_modifier/borer_speed)

// T4
/datum/borer_evolution/hivelord/stealth_mode
	name = "潜行模式"
	desc = "处于潜行模式时，你在宿主体内的存在感会大幅降低，但你无法获得被动收益。"
	gain_text = "有一天我在写报告时，注意到其中一条虫子悄无声息地从笼子里溜出来，钻进了一只猴子体内。它们似乎懂得安静的重要性，真是奇妙。"
	tier = 4
	unlocked_evolutions = list(/datum/borer_evolution/hivelord/produce_offspring_alone)

/datum/borer_evolution/hivelord/stealth_mode/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/cooldown/mob_cooldown/borer/stealth_mode/attack_action = new(cortical_owner)
	attack_action.Grant(cortical_owner)

// T5
/datum/borer_evolution/hivelord/produce_offspring_alone
	name = "产出后代 II"
	desc = "允许你在宿主之外产卵，代价是损失生命与化学物质。"
	gain_text = "其中一条虫子似乎在巢中取得了……首领地位，产的卵比其他都多。最令人担忧的是，在没有宿主的情况下也出现了虫卵，可我并没有*看到*它们产卵……"
	evo_cost = 3
	tier = 5
	unlocked_evolutions = list(
		/datum/borer_evolution/sugar_immunity,
		/datum/borer_evolution/synthetic_borer,
		/datum/borer_evolution/synthetic_chems_positive,
		/datum/borer_evolution/synthetic_chems_negative,
	)

/datum/borer_evolution/hivelord/produce_offspring_alone/on_evolve(mob/living/basic/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.upgrade_flags |= BORER_ALONE_PRODUCTION
