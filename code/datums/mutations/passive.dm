/datum/mutation/biotechcompat
	name = "生物技术兼容"
	desc = "受试者能够兼容技能芯片等生物技术。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MINI

/datum/mutation/biotechcompat/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	owner.adjust_skillchip_complexity_modifier(1)

/datum/mutation/biotechcompat/on_losing(mob/living/carbon/human/owner)
	owner.adjust_skillchip_complexity_modifier(-1)
	return ..()

/datum/mutation/clever
	name = "聪慧"
	desc = "受试者的智力提升至普通助理的水平。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MODERATE // literally makes you on par with station equipment
	text_gain_indication = span_danger("你感觉聪明了一点。")
	text_lose_indication = span_danger("你的头脑有些混沌。")

/datum/mutation/clever/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	owner.add_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_LITERATE), GENETIC_MUTATION)

/datum/mutation/clever/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.remove_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_LITERATE), GENETIC_MUTATION)
