/**Dizziness
 * Increases stealth
 * Lowers resistance
 * Decreases stage speed considerably
 * Slightly reduces transmissibility
 * Intense Level
 * Bonus: Shakes the affected mob's screen for short periods.
 */

/datum/symptom/dizzy // Not the egg
	name = "眩晕"
	desc = "病毒使前庭系统发炎，导致阵发性眩晕。"
	illness = "晕动病"
	stealth = 1
	resistance = 0
	stage_speed = -2
	transmittable = -1
	level = 4
	severity = 2
	base_message_chance = 50
	symptom_delay = 22.5
	symptom_cure = /datum/reagent/medicine/haloperidol
	cure_color = "yellow"
	threshold_descs = list(
		"传染性 6" = "还会造成吸毒般的视觉扭曲。",
		"隐蔽性 4" = "症状在发作前不会显露。",
	)

/datum/symptom/dizzy/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 4)
		suppress_warning = TRUE
	if(A.totalTransmittable() >= 6) //druggy
		power = 2

/datum/symptom/dizzy/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(M, span_warning("[pick("你感到眩晕。", "你感到天旋地转。")]"))
		else
			to_chat(M, span_userdanger("一阵眩晕向你袭来！"))
			M.adjust_dizzy_up_to(1 MINUTES, 140 SECONDS)
			if(power >= 2)
				M.set_drugginess(80 SECONDS)
