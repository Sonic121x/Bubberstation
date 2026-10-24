/*Headache
 * Slightly reduces stealth
 * Increases resistance tremendously
 * Increases stage speed
 * No change to transmissibility
 * Low level
 * Bonus: Displays an annoying message! Should be used for buffing your disease.
*/
/datum/symptom/headache
	name = "头痛"
	desc = "病毒使脑内发炎，导致持续头痛。"
	illness = "脑冻症"
	stealth = -1
	resistance = 4
	stage_speed = 2
	transmittable = 0
	level = 1
	severity = 1
	base_message_chance = 100
	symptom_delay = 22.5
	symptom_cure = /datum/reagent/drug/space_drugs
	threshold_descs = list(
		"阶段速度 6" = "头痛将造成剧痛，使宿主虚弱。",
		"阶段速度 9" = "头痛频率降低，但强度大幅增加，使宿主无法采取任何行动。",
		"隐蔽性 4" = "在病程后期之前降低头痛频率。",
	)

/datum/symptom/headache/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 4)
		base_message_chance = 50
	if(A.totalStageSpeed() >= 6) //severe pain
		power = 2
	if(A.totalStageSpeed() >= 9) //cluster headaches
		symptom_delay = 45
		power = 3

/datum/symptom/headache/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	if(HAS_TRAIT(M, TRAIT_SOOTHED_HEADACHE))
		return
	if(power < 2)
		if(prob(base_message_chance) || A.stage >= 4)
			to_chat(M, span_warning("[pick("你的头很痛。", "你的头一阵阵作痛。")]"))
	if(power >= 2 && A.stage >= 4)
		to_chat(M, span_warning("[pick("你的头疼得厉害。", "你的头不停地抽痛。")]"))
		M.adjust_stamina_loss(25)
	if(power >= 3 && A.stage >= 5)
		to_chat(M, span_userdanger("[pick("你的头好痛！", "你感觉脑子里插着一把烧红的刀！", "一阵剧痛充斥着你的脑袋！")]"))
		M.Stun(35)
