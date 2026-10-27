#define OD_CHANCE_NO_TRAUMA 95

// Hexacrocin. Advanced aphrodisiac that can cause brain traumas.
/datum/reagent/drug/aphrodisiac/crocin/hexacrocin
	name = "六克罗辛"
	description = "基础克罗辛的化学浓缩形态。对大多数动物来说，这种催情剂极其强效且具有成瘾性。\
					戒断反应可能造成脑损伤和呼吸急促。过量可导致脑部创伤。"
	taste_description = "液态的欲望"
	color = "#FF2BFF"
	overdose_threshold = 25
	overdose_pref_datum = /datum/preference/toggle/erp/bimbofication
	emote_probability = 5
	thought_probability = 5
	arousal_adjust_amount = 2
	pleasure_adjust_amount = 1.5
	pain_adjust_amount = 0.2
	possible_aroused_thoughts = list(
		"你感到有点燥热。",
		"你感到强烈的性冲动。",
		"你觉得来了兴致。",
		"你准备好去给某人口活了。",
	)

	/// A list of possible to_chat messages the chem is able to trigger after enough cycles in the mobs system
	var/list/extreme_aroused_thoughts = list(
		"你需要操某个人！",
		"你浑身的情欲就要炸开了！",
		"你满脑子都是性爱，根本甩不掉！",
	)
	/// How many cycles the chem has to be in the mob's system before triggering extreme effects
	var/extreme_thought_threshold = 25

/datum/reagent/drug/aphrodisiac/crocin/hexacrocin/life_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(prob(thought_probability) && current_cycle >= extreme_thought_threshold)
		var/displayed_extreme_thought = pick(extreme_aroused_thoughts)
		to_chat(exposed_mob, span_purple("[displayed_extreme_thought]"))

/datum/reagent/drug/aphrodisiac/crocin/hexacrocin/overdose_effects(mob/living/carbon/human/exposed_mob)
	if(prob(OD_CHANCE_NO_TRAUMA) || HAS_TRAIT(exposed_mob, TRAIT_BIMBO))
		return ..()

	to_chat(exposed_mob, span_purple("你的性欲彻底失控了！感觉连说话都变得困难多了……"))
	exposed_mob.gain_trauma(/datum/brain_trauma/very_special/bimbo, TRAUMA_RESILIENCE_BASIC)
	ADD_TRAIT(exposed_mob, TRAIT_BIMBO, TRAIT_LEWDCHEM)

/datum/chemical_reaction/hexacrocin
	results = list(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = 1)
	required_reagents = list(/datum/reagent/drug/aphrodisiac/crocin = 6, /datum/reagent/phenol = 1)
	required_temp = 600
	mix_message = "混合物迅速浓缩，颜色也随之变深……"
	erp_reaction = TRUE
	reaction_tags = REACTION_TAG_CHEMICAL | REACTION_TAG_DRUG | REACTION_TAG_EASY

#undef OD_CHANCE_NO_TRAUMA
