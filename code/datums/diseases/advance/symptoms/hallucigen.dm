/*Hallucigen
 * Slightly increases stealth
 * Lowers resistance tremendously
 * Slightly decreases stage speed
 * Slightly reduces transmissibility
 * Critical level
 * Bonus:Makes the affected mob be hallucinated for short periods of time.
*/

/datum/symptom/hallucigen
	name = "致幻"
	desc = "病毒刺激大脑，偶尔引发幻觉。"
	illness = "疑神疑鬼"
	stealth = 1
	resistance = -2
	stage_speed = 2
	transmittable = -1
	level = 3
	severity = 2
	base_message_chance = 25
	symptom_delay = 57.5
	symptom_cure = /datum/reagent/medicine/psicodine
	cure_color = "yellow"
	threshold_descs = list(
		"阶段速度 7" = "增加幻觉数量。",
		"隐蔽性 4" = "病毒伪装出有益症状。",
	)
	var/fake_healthy = FALSE

/datum/symptom/hallucigen/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 4) //fake good symptom messages
		fake_healthy = TRUE
		base_message_chance = 50
	if(A.totalStageSpeed() >= 7) //stronger hallucinations
		power = 2

/datum/symptom/hallucigen/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/M = A.affected_mob
	var/list/healthy_messages = list("你的肺感觉非常舒畅。", "你意识到自己一直没有呼吸。", "你觉得自己无需呼吸。",\
					"你的眼睛感觉非常舒适。", "你的耳朵感觉非常舒适。", "你觉得自己无需眨眼。")
	switch(A.stage)
		if(1, 2)
			if(prob(base_message_chance))
				if(!fake_healthy)
					to_chat(M, span_notice("[pick("有什么东西出现在你的余光中，随即消失。", "你听见一阵来源不明的微弱低语。", "你的头隐隐作痛。")]"))
				else
					to_chat(M, span_notice("[pick(healthy_messages)]"))
		if(3, 4)
			if(prob(base_message_chance))
				if(!fake_healthy)
					to_chat(M, span_danger("[pick("有什么东西正跟着你。", "有人正在监视你。", "你耳边响起低语。", "不知从何处传来的沉重脚步声正向你逼近。")]"))
				else
					to_chat(M, span_notice("[pick(healthy_messages)]"))
		else
			if(prob(base_message_chance))
				if(!fake_healthy)
					to_chat(M, span_userdanger("[pick("哦，你的头……", "你的头一阵阵剧痛。", "它们无处不在！快跑！", "阴影里有什么东西……")]"))
				else
					to_chat(M, span_notice("[pick(healthy_messages)]"))
			M.adjust_hallucinations(90 SECONDS * power)
