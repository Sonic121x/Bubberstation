/datum/disease/pierrot_throat
	name = "皮埃罗之喉"
	max_stages = 4
	spread_text = "空气传播"
	cure_text = "香蕉制品，尤其是香蕉面包。"
	cures = list(/datum/reagent/consumable/banana)
	cure_chance = 50
	agent = "H0NI<42 病毒"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 0.75
	desc = "一种据传源自未清洗小丑服的奇怪病毒。 \
		若不治疗，患者的声带将受到影响，很可能把周围的人逼疯。"
	severity = DISEASE_SEVERITY_MEDIUM
	required_organ = ORGAN_SLOT_TONGUE

/datum/disease/pierrot_throat/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感觉自己有点傻乎乎的。"))
		if(2)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你眼前开始出现彩虹。"))
		if(3)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("一声响亮的<b>叭！</b>打断了你的思绪。"))
		if(4)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.say( pick( list("叭！", "叭！", "叭。", "叭？", "叭！！", "叭？！", "叭……") ) , forced = "pierrot's throat")


/datum/disease/pierrot_throat/after_add()
	RegisterSignal(affected_mob, COMSIG_MOB_SAY, PROC_REF(handle_speech))


/datum/disease/pierrot_throat/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	var/message = speech_args[SPEECH_MESSAGE]
	var/list/split_message = splittext(message, " ") //List each word in the message
	var/applied = 0
	for (var/i in 1 to length(split_message))
		if(prob(3 * stage)) //Stage 1: 3% Stage 2: 6% Stage 3: 9% Stage 4: 12%
			if(findtext(split_message[i], "*") || findtext(split_message[i], ";") || findtext(split_message[i], ":"))
				continue
			split_message[i] = "叭"
			if (applied++ > stage)
				break
	if (applied)
		speech_args[SPEECH_SPANS] |= SPAN_CLOWN // a little bonus
	message = jointext(split_message, " ")
	speech_args[SPEECH_MESSAGE] = message


/datum/disease/pierrot_throat/Destroy()
	UnregisterSignal(affected_mob, COMSIG_MOB_SAY)
	return ..()

/datum/disease/pierrot_throat/remove_disease()
	UnregisterSignal(affected_mob, COMSIG_MOB_SAY)
	return ..()
