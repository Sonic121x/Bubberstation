/mob/living/carbon/human/Login()
	. = ..()

	dna?.species?.on_owner_login(src)

	if(SStts.tts_enabled && isnull(voice)) // SKYRAT EDIT - None option for TTS - ORIGINAL: if(SStts.tts_enabled && !voice)
		voice = SStts.random_tts_voice(gender)

	if(!LAZYLEN(afk_thefts))
		return

	var/list/print_msg = list()
	print_msg += span_userdanger("当你重新恢复意识时，你回想起有人动过你的东西……")

	afk_thefts = reverse_range(afk_thefts)

	for(var/list/iter_theft as anything in afk_thefts)
		if(!islist(iter_theft) || LAZYLEN(iter_theft) != AFK_THEFT_TIME)
			stack_trace("[src] ([ckey]) returned to their body and had a null/malformed afk_theft entry. Contents: [json_encode(iter_theft)]")
			continue

		var/thief_name = iter_theft[AFK_THEFT_NAME]
		var/theft_message = iter_theft[AFK_THEFT_MESSAGE]
		var/time_since = world.time - iter_theft[AFK_THEFT_TIME]

		if(time_since > AFK_THEFT_FORGET_DETAILS_TIME)
			print_msg += "\t[span_danger("<b>有人[theft_message]，但那至少是 [DisplayTimeText(AFK_THEFT_FORGET_DETAILS_TIME)] 之前的事了。</b>")]"
		else
			print_msg += "\t[span_danger("<b>[thief_name] [theft_message]，大约是在 [DisplayTimeText(time_since, 10)] 之前。</b>")]"

	if(LAZYLEN(afk_thefts) >= AFK_THEFT_MAX_MESSAGES)
		print_msg += span_warning("或许还有别的事，但你只记得这些了……")

	to_chat(src, boxed_message(print_msg.Join("\n")))
	LAZYNULL(afk_thefts)
