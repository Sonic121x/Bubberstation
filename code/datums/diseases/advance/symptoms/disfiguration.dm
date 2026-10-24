/**Disfiguration
 * Increases stealth
 * No change to resistance
 * Increases stage speed
 * Slightly increases transmissibility
 * Critical level
 * Bonus: Adds disfiguration trait making the mob appear as "Unknown" to others.
 */
/datum/symptom/disfiguration
	name = "毁容"
	desc = "病毒液化面部肌肉，使宿主毁容。"
	illness = "破相病"
	stealth = 2
	resistance = 0
	stage_speed = 3
	transmittable = 1
	level = 5
	severity = 1
	symptom_delay = 50
	symptom_cure = /datum/reagent/consumable/milk

/datum/symptom/disfiguration/Activate(datum/disease/advance/disease)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/victim = disease.affected_mob
	var/obj/item/bodypart/head = victim.get_bodypart(BODY_ZONE_HEAD)
	if(!head || HAS_TRAIT_FROM(head, TRAIT_DISFIGURED, DISEASE_TRAIT))
		return

	switch(disease.stage)
		if(5)
			ADD_TRAIT(head, TRAIT_DISFIGURED, DISEASE_TRAIT)
			victim.visible_message(span_warning("[victim]的脸似乎塌陷了！"), span_notice("你感觉自己的脸皱缩塌陷了！"))
		else
			victim.visible_message(span_warning("[victim]的脸开始扭曲……"), span_notice("你的脸感觉又湿又软……"))


/datum/symptom/disfiguration/End(datum/disease/advance/disease)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/victim = disease.affected_mob
	var/obj/item/bodypart/head = victim?.get_bodypart(BODY_ZONE_HEAD)
	if(head)
		REMOVE_TRAIT(head, TRAIT_DISFIGURED, DISEASE_TRAIT)
