/*Vomiting
 * Reduces stealth
 * Slight resistance reduction
 * Slight stage speed reduction
 * Increases transmissibility
 * Bonus : Forces the affected mob to vomit! Makes the affected mob lose nutrition and heal toxin damage
and your disease can spread via people walking on vomit.
*/

/datum/symptom/vomit
	name = "呕吐"
	desc = "病毒引起恶心并刺激胃部，导致偶尔呕吐。"
	illness = "旋风反胃症"
	stealth = -3
	resistance = 2
	stage_speed = 0
	transmittable = 3
	level = 3
	severity = 3
	base_message_chance = 100
	symptom_delay = 52.5
	required_organ = ORGAN_SLOT_STOMACH
	symptom_cure = /datum/reagent/medicine/ondansetron
	cure_color = "yellow"
	threshold_descs = list(
		"抗性 9" = "宿主会吐血，造成内部损伤。",
		"传染性 9" = "宿主会喷射性呕吐，增加呕吐距离。",
		"隐蔽性 4" = "症状在发作前不会显露。"
	)
	var/vomit_nebula = FALSE
	var/vomit_blood = FALSE
	var/proj_vomit = 0

/datum/symptom/vomit/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 4)
		suppress_warning = TRUE
	if(A.totalResistance() >= 9) //blood vomit
		vomit_blood = TRUE
	if(A.totalTransmittable() >= 9) //projectile vomit
		proj_vomit = 5

/datum/symptom/vomit/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(M, span_warning("[pick("你感到恶心。", "你感觉自己快吐了！")]"))
		else
			vomit(M)

/datum/symptom/vomit/proc/vomit(mob/living/carbon/vomiter)
	var/deductable_nutrition = 0
	var/constructed_flags = (MOB_VOMIT_MESSAGE | MOB_VOMIT_HARM)
	var/type_of_vomit = /obj/effect/decal/cleanable/vomit/toxic
	if(vomit_nebula)
		type_of_vomit = /obj/effect/decal/cleanable/vomit/nebula
		deductable_nutrition = 10
	else
		constructed_flags |= MOB_VOMIT_STUN
		deductable_nutrition = 20

	if(vomit_blood)
		constructed_flags |= MOB_VOMIT_BLOOD

	vomiter.vomit(vomit_flags = constructed_flags, vomit_type = type_of_vomit, lost_nutrition = deductable_nutrition, distance = proj_vomit)

/datum/symptom/vomit/nebula
	name = "星云呕吐"
	desc = "此病症刺激胃部，偶尔吐出带有星星的呕吐物，但不会使人眩晕。"
	illness = "星云恶心症"
	vomit_nebula = TRUE
	naturally_occuring = FALSE
