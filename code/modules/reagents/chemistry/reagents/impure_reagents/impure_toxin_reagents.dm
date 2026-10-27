//Reagents produced by metabolising/reacting fermichems suboptimally these specifically are for toxins
//Inverse = Splitting
//Invert = Whole conversion
//Failed = End reaction below purity_min

////////////////////TOXINS///////////////////////////

//Lipolicide - Impure Version
/datum/reagent/impurity/ipecacide
	name = "吐根素"
	description = "一种极其恶心的物质，会引发呕吐。溶脂剂反应不纯时会产生它。"
	ph = 7
	liver_damage = 0

/datum/reagent/impurity/ipecacide/on_mob_add(mob/living/carbon/owner)
	if(owner.disgust >= DISGUST_LEVEL_GROSS)
		return ..()
	owner.adjust_disgust(50)
	..()

//Formaldehyde - Impure Version
/datum/reagent/impurity/methanol
	name = "甲醇"
	description = "一种带有特殊气味的轻质无色液体。摄入可能导致失明。它是生物体代谢不纯甲醛时产生的副产物。"
	color = "#aae7e4"
	ph = 7
	liver_damage = 0

/datum/reagent/impurity/methanol/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/eyes/eyes = affected_mob.get_organ_slot(ORGAN_SLOT_EYES)
	if(eyes?.apply_organ_damage(0.25 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags))
		return UPDATE_MOB_HEALTH

//Chloral Hydrate - Impure Version
/datum/reagent/impurity/chloralax
	name = "氯醛灵"
	description = "一种油状、无色且略带毒性的液体。不纯的水合氯醛在生物体内分解时会产生它。"
	color = "#387774"
	ph = 7
	liver_damage = 0

/datum/reagent/impurity/chloralax/on_mob_life(mob/living/carbon/owner, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(owner.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

//Mindbreaker Toxin - Impure Version
/datum/reagent/impurity/rosenol
	name = "罗森醇"
	description = "一种奇特的蓝色液体，在不纯的心智破坏毒素反应中生成。历史上它曾被滥用于写诗。"
	color = "#0963ad"
	ph = 7
	liver_damage = 0
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/impurity/rosenol/on_mob_life(mob/living/carbon/owner, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/tongue/tongue = owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	if(SPT_PROB(4.0, seconds_per_tick))
		owner.manual_emote("用舌头发出“咔哒”一声。")
		owner.say("不错。", forced = /datum/reagent/impurity/rosenol)
	if(SPT_PROB(2.0, seconds_per_tick))
		owner.say(pick("啊！那是个错误！", "太可怕了。", "大家当心，这土豆真的很烫。", "我六岁时吃掉了一整袋李子。", "要说我最受不了的东西，那就是番茄。", "要说我最喜欢的东西，那就是番茄。", "我们那会儿有位舰长特别严格，在他的站上连呼吸都不许。", "那些不结实的家伙动不动就倒下死了，你能听见他们在你身后倒地的声音。"), forced = /datum/reagent/impurity/rosenol)
