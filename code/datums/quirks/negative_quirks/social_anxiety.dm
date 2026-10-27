/datum/quirk/social_anxiety
	name = "Social Anxiety"
	desc = "与人交谈对你来说很困难，你常常口吃，甚至完全说不出话。"
	icon = FA_ICON_COMMENT_SLASH
	value = -3
	gain_text = span_danger("你开始担心自己说的话。")
	lose_text = span_notice("你又觉得说话轻松些了。") //if only it were that easy!
	medical_record_text = "患者在社交场合通常感到焦虑，并倾向于回避。"
	medical_symptom_text = "在社交场合感到强烈的焦虑与不适，\
		导致回避社交互动及沟通困难。"
	hardcore_value = 4
	mob_trait = TRAIT_ANXIOUS
	mail_goodies = list(/obj/item/storage/pill_bottle/psicodine)
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_TRAUMALIKE
	var/dumb_thing = TRUE

/datum/quirk/social_anxiety/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_MOB_EYECONTACT, PROC_REF(eye_contact))
	RegisterSignal(quirk_holder, COMSIG_MOB_EXAMINATE, PROC_REF(looks_at_floor))
	RegisterSignal(quirk_holder, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	quirk_holder.apply_status_effect(/datum/status_effect/speech/stutter/anxiety, INFINITY)

/datum/quirk/social_anxiety/remove()
	UnregisterSignal(quirk_holder, list(COMSIG_MOB_EYECONTACT, COMSIG_MOB_EXAMINATE, COMSIG_MOB_SAY))
	quirk_holder.remove_status_effect(/datum/status_effect/speech/stutter/anxiety)

/// Calculates how much to modifiy our effects based on our mood level
/datum/quirk/social_anxiety/proc/calculate_mood_mod()
	var/nearby_people = 0
	for(var/mob/living/carbon/human/listener in oview(3, quirk_holder))
		if(listener.client || listener.mind)
			nearby_people++

	var/mod = 1
	if(quirk_holder.mob_mood)
		mod = 1 + 0.02 * (50 - (max(50, quirk_holder.mob_mood.mood_level * (SANITY_LEVEL_MAX + 1 - quirk_holder.mob_mood.sanity_level)))) //low sanity levels are better, they max at 6
	else
		mod = 1 + 0.02 * (50 - (max(50, 0.1 * quirk_holder.nutrition)))

	return mod * nearby_people * 12.5

/datum/quirk/social_anxiety/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	if(HAS_TRAIT(quirk_holder, TRAIT_FEARLESS))
		return
	if(HAS_TRAIT(source, TRAIT_SIGN_LANG)) // No modifiers for signers, so you're less anxious when you go non-verbal
		return

	var/moodmod = calculate_mood_mod()
	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		var/list/message_split = splittext(message, " ")
		var/list/new_message = list()
		for(var/word in message_split)
			if(prob(max(5, moodmod)) && word != message_split[1]) //Minimum 1/20 chance of filler
				new_message += pick("呃，","那个，","嗯，")
				if(prob(min(5, moodmod))) //Max 1 in 20 chance of cutoff after a successful filler roll, for 50% odds in a 15 word sentence
					quirk_holder.set_silence_if_lower(6 SECONDS)
					to_chat(quirk_holder, span_danger("你感到局促不安，停止了说话。你需要缓一缓！"))
					break
			new_message += word

		message = jointext(new_message, " ")

	if(prob(min(50, (0.50 * moodmod)))) //Max 50% chance of not talking
		if(dumb_thing)
			to_chat(quirk_holder, span_userdanger("你想起很久以前说过的一句蠢话，在心里尖叫起来。"))
			dumb_thing = FALSE //only once per life
			if(prob(1))
				new/obj/item/food/spaghetti/pastatomato(get_turf(quirk_holder)) //now that's what I call spaghetti code
		else
			to_chat(quirk_holder, span_warning("你觉得这句话对谈话没什么帮助，于是决定不说。"))
			if(prob(min(25, (0.25 * moodmod)))) //Max 25% chance of silence stacks after successful not talking roll
				to_chat(quirk_holder, span_danger("你缩回了自己的世界。你<i>真的</i>不想开口说话。"))
				quirk_holder.set_silence_if_lower(10 SECONDS)

		speech_args[SPEECH_MESSAGE] = pick("呃。","那个。","嗯。")
	else
		speech_args[SPEECH_MESSAGE] = message

// small chance to make eye contact with inanimate objects/mindless mobs because of nerves
/datum/quirk/social_anxiety/proc/looks_at_floor(datum/source, atom/A)
	SIGNAL_HANDLER

	var/mob/living/mind_check = A
	if(prob(85) || (istype(mind_check) && mind_check.mind))
		return

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), quirk_holder, span_smallnotice("你与[A]对上了视线。")), 0.3 SECONDS)

/datum/quirk/social_anxiety/proc/eye_contact(datum/source, mob/living/other_mob, triggering_examiner)
	SIGNAL_HANDLER

	if(prob(75))
		return
	var/msg
	if(triggering_examiner)
		msg = "你与[other_mob]对上了视线，"
	else
		msg = "[other_mob]与你对上了视线，"

	switch(rand(1,3))
		if(1)
			quirk_holder.set_jitter_if_lower(20 SECONDS)
			msg += "让你开始坐立不安！"
		if(2)
			quirk_holder.set_stutter_if_lower(6 SECONDS)
			msg += "让你开始结巴！"
		if(3)
			quirk_holder.Stun(2 SECONDS)
			msg += "让你僵住了！"

	quirk_holder.add_mood_event("anxiety_eyecontact", /datum/mood_event/anxiety_eyecontact)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), quirk_holder, span_userdanger("[msg]")), 3) // so the examine signal has time to fire and this will print after
	return COMSIG_BLOCK_EYECONTACT

/datum/mood_event/anxiety_eyecontact
	description = "有时眼神接触会让我紧张得不行……"
	mood_change = -5
	timeout = 3 MINUTES
