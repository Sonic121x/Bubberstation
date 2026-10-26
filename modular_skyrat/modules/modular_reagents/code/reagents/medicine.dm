/datum/reagent/medicine/lidocaine
	name = "利多卡因"
	description = "常用于手术的麻醉剂，代谢缓慢。"
	color = "#6dbdbd" // 109, 189, 189
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 20
	ph = 6.09
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_ANALGESIA)
	inverse_chem_val = 0.55
	inverse_chem = /datum/reagent/inverse/lidocaine
	taste_description = "香草"

	metabolized_traits = list(TRAIT_ANALGESIA)

/datum/reagent/medicine/lidocaine/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	metabolizer.throw_alert("numbed", /atom/movable/screen/alert/numbed)

/datum/reagent/medicine/lidocaine/on_mob_end_metabolize(mob/living/metabolizer)
	metabolizer.clear_alert("numbed")
	return ..()

/datum/reagent/medicine/lidocaine/overdose_process(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjust_organ_loss(ORGAN_SLOT_HEART,3 * REM * seconds_per_tick, 80)
	return ..()

//Inverse Medicines//

/datum/reagent/inverse/lidocaine
	name = "利多痛因"
	description = "一种致痛剂，常用于……干缺德事。代谢速度比利多卡因更快。"
	color = "#85111f" // 133, 17, 31
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	ph = 6.09
	tox_damage = 0

/datum/reagent/inverse/lidocaine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	to_chat(affected_mob, span_userdanger("你的身体传来难以想象的剧痛！"))
	affected_mob.adjust_organ_loss(ORGAN_SLOT_HEART,3 * REM * seconds_per_tick, 85)
	affected_mob.adjust_stamina_loss(5 * REM * seconds_per_tick, 0)
	if(prob(30))
		INVOKE_ASYNC(affected_mob, TYPE_PROC_REF(/mob, emote), "scream")

//Medigun Clotting Medicine
/datum/reagent/medicine/coagulant/fabricated
	name = "合成凝血剂"
	description = "由医疗枪制造的合成凝血剂。"
	color = "#ff7373" //255, 155. 155
	clot_rate = 0.15 //Half as strong as standard coagulant
	passive_bleed_modifier = 0.5 // around 2/3 the bleeding reduction
