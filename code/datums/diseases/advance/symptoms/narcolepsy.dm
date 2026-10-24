/*Narcolepsy
 * Slight reduction to stealth
 * Reduces resistance
 * Greatly reduces stage speed
 * No change to transmissibility
 * Fatal level
 * Bonus: Causes drowsiness and sleep.
*/
/datum/symptom/narcolepsy
	name = "发作性睡病"
	desc = "病毒引起激素失衡，使宿主困倦并阵发性入睡。"
	illness = "极地鼾声"
	stealth = -1
	resistance = -2
	stage_speed = -2
	transmittable = 0
	level = 6
	symptom_delay = 57.5
	severity = 4
	symptom_cure = /datum/reagent/medicine/ondansetron
	cure_color = "yellow"
	var/yawning = FALSE
	threshold_descs = list(
		"传染性 4" = "宿主会定期打哈欠，尝试感染周围六米内的人。",
		"阶段速度 10" = "更频繁地引发睡病，提高宿主睡着的概率。",
	)

/datum/symptom/narcolepsy/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalTransmittable() >= 4) //yawning (mostly just some copy+pasted code from sneezing, with a few tweaks)
		yawning = TRUE
	if(A.totalStageSpeed() >= 10) //act more often
		symptom_delay = 32.5

/datum/symptom/narcolepsy/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return

	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1)
			if(prob(50))
				to_chat(M, span_warning("你感到疲倦。"))
		if(2)
			if(prob(50))
				to_chat(M, span_warning("你感到非常疲倦。"))
		if(3)
			if(prob(50))
				to_chat(M, span_warning("你努力集中精神保持清醒。"))

			M.adjust_drowsiness_up_to(10 SECONDS, 140 SECONDS)

		if(4)
			if(prob(50))
				if(yawning)
					to_chat(M, span_warning("你想忍住哈欠，却没能成功。"))
				else
					to_chat(M, span_warning("你打了个盹。")) //you can't really yawn while nodding off, can you?

			M.adjust_drowsiness_up_to(20 SECONDS, 140 SECONDS)

			if(yawning)
				M.emote("yawn")
				A.airborne_spread(6)

		if(5)
			if(prob(50))
				to_chat(M, span_warning("[pick("好累……","你感到非常困倦。","你的眼皮快撑不住了。","你努力保持清醒。")]"))

			M.adjust_drowsiness_up_to(80 SECONDS, 140 SECONDS)

			if(yawning)
				M.emote("yawn")
				A.airborne_spread(6)
