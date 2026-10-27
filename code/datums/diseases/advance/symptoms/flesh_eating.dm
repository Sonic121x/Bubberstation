/*
Necrotizing Fasciitis (AKA Flesh-Eating Disease)
	Very very noticable.
	Lowers resistance tremendously.
	No changes to stage speed.
	Decreases transmissibility tremendously.
	Fatal Level.
Bonus
	Deals brute damage over time.
*/
/datum/symptom/flesh_eating
	name = "坏死性筋膜炎"
	desc = "病毒猛烈攻击骨细胞，导致身体严重摇晃并频繁跌倒。"
	illness = "果冻病"
	stealth = -2
	resistance = -1
	stage_speed = 0
	transmittable = -1
	level = 6
	severity = 5
	base_message_chance = 50
	symptom_delay = 37.5
	symptom_cure = /datum/reagent/medicine/omnizine
	cure_color = "orange"
	threshold_descs = list(
		"抗性 7" = "宿主在组织坏死时会大量出血。",
		"传染性 8" = "使宿主承受剧痛并虚弱。",
	)
	var/bleed = FALSE
	var/pain = FALSE

/datum/symptom/flesh_eating/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalResistance() >= 7) //extra bleeding
		bleed = TRUE
	if(A.totalTransmittable() >= 8) //extra stamina damage
		pain = TRUE

/datum/symptom/flesh_eating/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(2,3)
			if(prob(base_message_chance))
				to_chat(M, span_warning("[pick("你全身突然一阵疼痛。", "你的皮肤上突然渗出血珠。")]"))
		if(4,5)
			to_chat(M, span_userdanger("[pick("剧痛席卷全身，你痛苦地蜷缩起来。", "你感觉身体正由内而外地吞噬自己。", "好痛！")]"))
			Flesheat(M, A)

/datum/symptom/flesh_eating/proc/Flesheat(mob/living/M, datum/disease/advance/A)
	var/get_damage = rand(15,25) * power
	M.take_overall_damage(brute = get_damage, required_bodytype = BODYTYPE_ORGANIC)
	if(pain)
		M.adjust_stamina_loss(get_damage * 2)
	if(bleed)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			var/obj/item/bodypart/random_part = pick(H.get_bodyparts())
			random_part.adjustBleedStacks(5 * power)
	return 1

/*
//////////////////////////////////////

Autophagocytosis (AKA Programmed mass cell death)

	Very noticable.
	Lowers resistance.
	Fast stage speed.
	Decreases transmittability.
	Fatal Level.

Bonus
	Deals brute damage over time.

//////////////////////////////////////
*/

/datum/symptom/flesh_death

	name = "自噬性坏死"
	desc = "病毒迅速吞噬受感染的细胞，造成严重而广泛的损伤。"
	illness = "早发木乃伊化"
	stealth = -2
	resistance = -2
	stage_speed = 1
	transmittable = -2
	level = 7
	severity = 6
	base_message_chance = 50
	symptom_delay = 4.5
	symptom_cure = /datum/reagent/medicine/earthsblood // Good luck finding THAT.
	cure_color = "red"
	var/chems = FALSE
	threshold_descs = list(
		"阶段速度 7" = "在宿主体内合成肝素和溶脂剂，增加出血和饥饿程度。",
		"隐蔽性 5" = "症状在发作前不会显露。",
	)

/datum/symptom/flesh_death/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 5)
		suppress_warning = TRUE
	if(A.totalStageSpeed() >= 7) //bleeding and hunger
		chems = TRUE

/datum/symptom/flesh_death/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(2,3)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(M, span_warning("[pick("你感觉身体正在崩解。", "你的皮肤像灰尘一样一擦就掉。")]"))
		if(4,5)
			if(prob(base_message_chance / 2)) //reduce spam
				to_chat(M, span_userdanger("[pick("你感觉肌肉正在衰弱。", "你的部分皮肤自行脱落了。", "你感觉身体像散沙一样。")]"))
			Flesh_death(M, A)

/datum/symptom/flesh_death/proc/Flesh_death(mob/living/M, datum/disease/advance/A)
	var/get_damage = rand(6,10)
	M.take_overall_damage(brute = get_damage, required_bodytype = BODYTYPE_ORGANIC)
	if(chems)
		M.reagents.add_reagent_list(list(/datum/reagent/toxin/heparin = 2, /datum/reagent/toxin/lipolicide = 2))
	return 1
