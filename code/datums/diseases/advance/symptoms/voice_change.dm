/*Voice Change
 * Slight stealth increase
 * Reduces resistance
 * Reduces stage speed
 * Increases transmissibility
 * Fatal level
 * Bonus: Changes the voice of the affected mob. Causing confusion in communication.
*/

/datum/symptom/voice_change
	name = "变声"
	desc = "病毒改变宿主声带的音高和音色，使其声音发生变化。"
	illness = "默剧危机"
	stealth = 2
	resistance = -1
	stage_speed = -2
	transmittable = 2
	level = 6
	severity = 2
	base_message_chance = 100
	symptom_delay = 90
	required_organ = ORGAN_SLOT_TONGUE
	symptom_cure = /datum/reagent/inverse/healing/convermol
	threshold_descs = list(
		"传染性 14" = "损伤宿主大脑的语言中枢，使其完全无法说出或理解任何语言。",
		"阶段速度 7" = "更频繁地改变声音。",
		"隐蔽性 3" = "症状在发作前不会显露。"
	)
	var/scramble_language = FALSE
	var/datum/language/current_language

/datum/symptom/voice_change/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 3)
		suppress_warning = TRUE
	if(A.totalStageSpeed() >= 7) //faster change of voice
		base_message_chance = 25
		symptom_delay = 55
		delay_variation = 0.35
	if(A.totalTransmittable() >= 14) //random language
		scramble_language = TRUE

/datum/symptom/voice_change/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/M = A.affected_mob
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(M, span_warning("[pick("你的喉咙很痛。", "你清了清嗓子。")]"))
		else
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				H.override_voice = H.generate_random_mob_name()
				if(scramble_language && !current_language) // Last part prevents rerolling language with small amounts of cure.
					current_language = pick(subtypesof(/datum/language) - /datum/language/common)
					H.add_blocked_language(subtypesof(/datum/language) - current_language, source = LANGUAGE_VOICECHANGE)
					H.grant_language(current_language, source = LANGUAGE_VOICECHANGE)

/datum/symptom/voice_change/End(datum/disease/advance/A)
	..()
	if(ishuman(A.affected_mob))
		var/mob/living/carbon/human/H = A.affected_mob
		H.override_voice = ""
	if(scramble_language)
		A.affected_mob.remove_blocked_language(subtypesof(/datum/language), source = LANGUAGE_VOICECHANGE)
		A.affected_mob.remove_all_languages(LANGUAGE_VOICECHANGE) // In case someone managed to get more than one anyway.
