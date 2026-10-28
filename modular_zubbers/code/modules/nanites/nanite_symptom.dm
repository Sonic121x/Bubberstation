/datum/symptom/nano_boost
	name = "纳米共生"
	desc = "病毒会与宿主血液中的纳米机器人发生反应，增强其复制周期。"
	stealth = 0
	resistance = 2
	stage_speed = 2
	transmittable = -1
	level = 7
	severity = 0
	symptom_delay = 1
	var/reverse_boost = FALSE
	threshold_descs = list(
		"传播性 5" = "存在纳米机器人时提高病毒的生长速率。",
		"阶段速度 7" = "提高复制增益。"
	)

/datum/symptom/nano_boost/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalTransmittable() >= 5) //reverse boost
		reverse_boost = TRUE
	if(A.totalStageSpeed() >= 7) //more nanites
		power = 2

/datum/symptom/nano_boost/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/M = A.affected_mob
	SEND_SIGNAL(M, COMSIG_NANITE_ADJUST_VOLUME, 0.5 * power)
	if(reverse_boost && SEND_SIGNAL(M, COMSIG_HAS_NANITES))
		if(prob(A.stage_prob))
			A.stage = min(A.stage + 1,A.max_stages)

/datum/symptom/nano_destroy
	name = "硅裂解"
	desc = "病毒会与宿主血液中的纳米机器人发生反应，攻击并吞噬它们。"
	stealth = 0
	resistance = 4
	stage_speed = -1
	transmittable = 1
	level = 7
	severity = 0
	symptom_delay = 1
	var/reverse_boost = FALSE
	threshold_descs = list(
		"阶段速度 5" = "存在纳米机器人时提高病毒的生长速率。",
		"抗性 7" = "大幅提高纳米机器人的被摧毁速率。"
	)

/datum/symptom/nano_destroy/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStageSpeed() >= 5) //reverse boost
		reverse_boost = TRUE
	if(A.totalResistance() >= 7) //more nanites
		power = 3

/datum/symptom/nano_destroy/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/M = A.affected_mob
	SEND_SIGNAL(M, COMSIG_NANITE_ADJUST_VOLUME, -0.4 * power)
	if(reverse_boost && SEND_SIGNAL(M, COMSIG_HAS_NANITES))
		if(prob(A.stage_prob))
			A.stage = min(A.stage + 1,A.max_stages)
