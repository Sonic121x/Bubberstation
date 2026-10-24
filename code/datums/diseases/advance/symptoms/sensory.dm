/* Mind Restoration
 * Slight stealth reduction
 * Reduces resistance
 * Slight increase to stage speed
 * Greatly decreases transmissibility
 * Critical level
*/
/datum/symptom/mind_restoration
	name = "心智修复"
	desc = "病毒加强神经元之间的连接，缩短各种精神异常的持续时间。"
	stealth = -1
	resistance = -2
	stage_speed = 1
	transmittable = -3
	level = 5
	symptom_delay = 7.5
	var/purge_alcohol = FALSE
	var/trauma_heal_mild = FALSE
	var/trauma_heal_severe = FALSE
	threshold_descs = list(
		"抗性 6" = "治愈轻度脑创伤。",
		"抗性 9" = "治愈重度脑创伤。",
		"传染性 8" = "清除血液中的酒精。",
	)

/datum/symptom/mind_restoration/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalResistance() >= 6) //heal brain damage
		trauma_heal_mild = TRUE
	if(A.totalResistance() >= 9) //heal severe traumas
		trauma_heal_severe = TRUE
	if(A.totalTransmittable() >= 8) //purge alcohol
		purge_alcohol = TRUE

/datum/symptom/mind_restoration/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob


	if(A.stage >= 3)
		M.adjust_dizzy(-4 SECONDS)
		M.adjust_drowsiness(-4 SECONDS)
		// All slurring effects get reduced down a bit
		for(var/datum/status_effect/speech/slurring/slur in M.status_effects)
			slur.remove_duration(1 SECONDS)

		M.adjust_confusion(-2 SECONDS)
		if(purge_alcohol)
			M.reagents.remove_reagent(/datum/reagent/consumable/ethanol, 3, include_subtypes = TRUE)
			M.adjust_drunk_effect(-5)

	if(A.stage >= 4)
		M.adjust_drowsiness(-4 SECONDS)
		if(M.reagents.has_reagent(/datum/reagent/toxin/mindbreaker))
			M.reagents.remove_reagent(/datum/reagent/toxin/mindbreaker, 5)
		if(M.reagents.has_reagent(/datum/reagent/toxin/histamine))
			M.reagents.remove_reagent(/datum/reagent/toxin/histamine, 5)

		M.adjust_hallucinations(-20 SECONDS)

	if(A.stage >= 5)
		M.adjust_organ_loss(ORGAN_SLOT_BRAIN, -3)
		if(trauma_heal_mild && iscarbon(M))
			var/mob/living/carbon/C = M
			if(prob(10))
				if(trauma_heal_severe)
					C.cure_trauma_type(resilience = TRAUMA_RESILIENCE_SURGERY)
				else
					C.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)



/datum/symptom/sensory_restoration
	name = "感官修复"
	desc = "病毒刺激感觉组织的生成和更新，使宿主受损的眼睛和耳朵能够再生。"
	stealth = 0
	resistance = 1
	stage_speed = -2
	transmittable = 2
	level = 4
	base_message_chance = 7
	symptom_delay = 1
	delay_variation = 0

/datum/symptom/sensory_restoration/Activate(datum/disease/advance/advanced_disease)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/infected_mob = advanced_disease.affected_mob
	switch(advanced_disease.stage)
		if(4, 5)
			if(advanced_disease.has_required_infectious_organ(infected_mob, ORGAN_SLOT_EARS))
				var/obj/item/organ/ears/ears = infected_mob.get_organ_slot(ORGAN_SLOT_EARS)
				ears?.apply_organ_damage(-4)
				ears?.adjust_temporary_deafness(-8 SECONDS)

			if(!advanced_disease.has_required_infectious_organ(infected_mob, ORGAN_SLOT_EYES))
				return

			var/obj/item/organ/eyes/eyes = infected_mob.get_organ_slot(ORGAN_SLOT_EYES)
			infected_mob.adjust_temp_blindness(-4 SECONDS)
			infected_mob.adjust_eye_blur(-4 SECONDS)

			eyes.apply_organ_damage(-2)
			if(prob(20))
				if(infected_mob.is_blind_from(EYE_DAMAGE))
					to_chat(infected_mob, span_warning("你的视力慢慢恢复了……"))
					infected_mob.adjust_eye_blur(20 SECONDS)

				else if(infected_mob.is_nearsighted_from(EYE_DAMAGE))
					to_chat(infected_mob, span_warning("你视野边缘的黑暗开始消退。"))
					infected_mob.adjust_eye_blur(5 SECONDS)

		else
			if(prob(base_message_chance))
				to_chat(infected_mob, span_notice("[pick("你的眼睛感觉非常舒适。","你感觉双眼能看得更清楚了。", "你觉得自己无需眨眼。","你的耳朵感觉非常舒适。","你感觉听觉更加敏锐了。")]"))
