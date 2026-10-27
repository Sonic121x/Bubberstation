// Dopamine. Generates in character after orgasm.
/datum/reagent/drug/aphrodisiac/dopamine
	name = "多巴胺……？"
	description = "纯粹的快乐"
	taste_description = "一种难以形容、略带酸味的味道。其中的某种成分让你放松下来，全身充满愉悦。"
	color = "#97ffee"
	overdose_threshold = 10
	life_pref_datum = /datum/preference/toggle/erp/aphro
	overdose_pref_datum = /datum/preference/toggle/erp/aphro
	arousal_adjust_amount = 0.5
	pleasure_adjust_amount = 0.3
	pain_adjust_amount = -0.5

	/// How druggy the chem will make the mob
	var/drugginess_amount = 5 SECONDS
	/// How likely the drug is to make the mob druggy per life process
	var/drugginess_chance = 7

/datum/glass_style/drinking_glass/dopamine
	required_drink_type = /datum/reagent/drug/aphrodisiac/dopamine
	name = "多巴胺"
	desc = "风味绝佳的试剂。光是看着它，你就感到幸福。"

/datum/reagent/drug/aphrodisiac/dopamine/on_mob_add(mob/living/carbon/human/exposed_mob)
	if(!(exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/aphro)))
		return ..()
	exposed_mob.add_mood_event("[type]_start", /datum/mood_event/orgasm, name)
	return ..()

/datum/reagent/drug/aphrodisiac/dopamine/life_effects(mob/living/carbon/human/exposed_mob)
	exposed_mob.set_drugginess(drugginess_amount)
	if(prob(drugginess_chance))
		exposed_mob.emote(pick("twitch", "drool", "moan", "giggle", "shaking"))

/datum/reagent/drug/aphrodisiac/dopamine/overdose_start(mob/living/carbon/human/exposed_mob)
	. = ..()
	to_chat(exposed_mob, span_purple("你感到无比幸福！"))
	exposed_mob.add_mood_event("[type]_overdose", /datum/mood_event/overgasm, name)

/datum/reagent/drug/aphrodisiac/dopamine/overdose_effects(mob/living/carbon/human/exposed_mob)
	if(!(exposed_mob.get_timed_status_effect_duration(/datum/status_effect/hallucination) / (2 SECONDS) < volume && prob(20)))
		return ..()
	exposed_mob.adjust_arousal(arousal_adjust_amount)
	exposed_mob.adjust_pleasure(pleasure_adjust_amount)
	exposed_mob.adjust_pain(pain_adjust_amount)
	if(prob(2))
		exposed_mob.emote(pick("moan", "twitch_s"))

// This chem shouldn't affect user's mood negatively.
/datum/reagent/drug/aphrodisiac/dopamine/overdose_process(mob/living/carbon/human/exposed_mob)
	return
