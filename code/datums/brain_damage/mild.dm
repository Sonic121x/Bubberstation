//Mild traumas are the most common; they are generally minor annoyances.
//They can be cured with mannitol and patience, although brain surgery still works.
//Most of the old brain damage effects have been transferred to the dumbness trauma.

/datum/brain_trauma/mild
	abstract_type = /datum/brain_trauma/mild

/datum/brain_trauma/mild/hallucinations
	name = "幻觉"
	desc = "患者持续出现幻觉。"
	scan_desc = "精神分裂症"
	symptoms = "频繁出现幻觉（幻视或幻听）或妄想，\
		给予心智破坏毒素后会有所缓解。"
	gain_text = span_warning("你感觉自己正在失去对现实的把握……")
	lose_text = span_notice("你感觉更加踏实了。")
	/// Whether the hallucinations we give are uncapped, ie all the wacky ones
	var/uncapped = FALSE

/datum/brain_trauma/mild/hallucinations/on_life(seconds_per_tick)
	if(IS_UNCONSCIOUS(owner))
		return
	if(HAS_TRAIT(owner, TRAIT_RDS_SUPPRESSED))
		owner.remove_language(/datum/language/aphasia, source = LANGUAGE_APHASIA)
		owner.adjust_hallucinations(-10 SECONDS * seconds_per_tick)
		return

	owner.grant_language(/datum/language/aphasia, source = LANGUAGE_APHASIA)
	owner.adjust_hallucinations_up_to(((uncapped ? 12 SECONDS : 5 SECONDS) * seconds_per_tick), (uncapped ? 240 SECONDS : 60 SECONDS))

/datum/brain_trauma/mild/hallucinations/on_lose()
	owner.remove_status_effect(/datum/status_effect/hallucination)
	if(!QDELING(owner))
		owner.remove_language(/datum/language/aphasia, source = LANGUAGE_APHASIA)
	return ..()

/datum/brain_trauma/mild/stuttering
	name = "口吃"
	desc = "患者无法正常说话。"
	scan_desc = "口部协调能力下降"
	symptoms = "难以流畅说话，经常重复或拖长发音或音节。"
	gain_text = span_warning("清楚地说话变得越来越困难了。")
	lose_text = span_notice("你感觉能控制自己的言语了。")

/datum/brain_trauma/mild/stuttering/on_life(seconds_per_tick)
	owner.adjust_stutter_up_to(5 SECONDS * seconds_per_tick, 50 SECONDS)

/datum/brain_trauma/mild/stuttering/on_lose()
	owner.remove_status_effect(/datum/status_effect/speech/stutter)
	return ..()

/datum/brain_trauma/mild/dumbness
	name = "智力减退"
	desc = "患者脑活动减弱，导致智力下降。"
	symptoms = "认知功能明显衰退，包括言语、记忆、运动和解决问题的能力。"
	scan_desc = "脑活动减弱"
	gain_text = span_warning("你觉得自己变笨了。")
	lose_text = span_notice("你觉得自己又聪明起来了。")

/datum/brain_trauma/mild/dumbness/on_gain()
	ADD_TRAIT(owner, TRAIT_DUMB, TRAUMA_TRAIT)
	owner.add_mood_event("dumb", /datum/mood_event/oblivious)
	return ..()

/datum/brain_trauma/mild/dumbness/on_life(seconds_per_tick)
	owner.adjust_derpspeech_up_to(5 SECONDS * seconds_per_tick, 50 SECONDS)
	if(SPT_PROB(1.5, seconds_per_tick))
		owner.emote("drool")
	else if(!IS_UNCONSCIOUS_OR_CRIT(owner) && SPT_PROB(1.5, seconds_per_tick))
		owner.say(pick_list_replacements(BRAIN_DAMAGE_FILE, "brain_damage"), forced = "brain damage", filterproof = TRUE)

/datum/brain_trauma/mild/dumbness/on_lose()
	REMOVE_TRAIT(owner, TRAIT_DUMB, TRAUMA_TRAIT)
	owner.remove_status_effect(/datum/status_effect/speech/stutter/derpspeech)
	owner.clear_mood_event("dumb")
	return ..()

/datum/brain_trauma/mild/speech_impediment
	name = "言语障碍"
	desc = "患者无法组织连贯的句子。"
	scan_desc = "交流障碍"
	symptoms = "难以将想法表达为连贯的话语，经常说出杂乱或毫无意义的句子。"
	gain_text = span_danger("你似乎无法形成任何连贯的思绪！")
	lose_text = span_danger("你的思绪变得清晰了。")

/datum/brain_trauma/mild/speech_impediment/on_gain()
	ADD_TRAIT(owner, TRAIT_UNINTELLIGIBLE_SPEECH, TRAUMA_TRAIT)
	. = ..()

/datum/brain_trauma/mild/speech_impediment/on_lose()
	REMOVE_TRAIT(owner, TRAIT_UNINTELLIGIBLE_SPEECH, TRAUMA_TRAIT)
	..()

/datum/brain_trauma/mild/concussion
	name = "脑震荡"
	desc = "患者发生了脑震荡。"
	symptoms = "出现头痛、眩晕、恶心、意识混乱，偶尔失去意识。"
	scan_desc = "脑震荡"
	gain_text = span_warning("你的头好痛！")
	lose_text = span_notice("你头部的压迫感开始减轻。")

/datum/brain_trauma/mild/concussion/on_life(seconds_per_tick)
	if(SPT_PROB(2.5, seconds_per_tick))
		switch(rand(1,11))
			if(1)
				owner.vomit(VOMIT_CATEGORY_DEFAULT)
			if(2,3)
				owner.adjust_dizzy(20 SECONDS)
			if(4,5)
				owner.adjust_confusion(10 SECONDS)
				owner.set_eye_blur_if_lower(20 SECONDS)
			if(6 to 9)
				owner.adjust_slurring(1 MINUTES)
			if(10)
				to_chat(owner, span_notice("你一时忘了自己正在做什么。"))
				owner.Stun(20)
			if(11)
				to_chat(owner, span_warning("你昏了过去。"))
				owner.Unconscious(80)

	..()

/datum/brain_trauma/mild/healthy
	name = "病识感缺失"
	desc = "无论实际状况如何，患者总觉得自己很健康。"
	scan_desc = "自我认知缺陷"
	symptoms = "无法意识到或否认自身疾病，\
		即使有明显反证，也经常坚称自己完全健康。"
	gain_text = span_notice("你感觉棒极了！")
	lose_text = span_warning("你不再觉得自己完全健康了。")

/datum/brain_trauma/mild/healthy/on_gain()
	owner.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)
	return ..()

/datum/brain_trauma/mild/healthy/on_life(seconds_per_tick)
	owner.adjust_stamina_loss(-6 * seconds_per_tick) //no pain, no fatigue

/datum/brain_trauma/mild/healthy/on_lose()
	owner.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)
	return ..()

/datum/brain_trauma/mild/muscle_weakness
	name = "肌无力"
	desc = "患者偶尔出现阵发性肌无力。"
	scan_desc = "运动神经信号微弱"
	symptoms = "突然出现肌无力，导致握力下降、行动困难，偶尔跌倒。"
	gain_text = span_warning("你的肌肉感到莫名无力。")
	lose_text = span_notice("你感觉又能控制自己的肌肉了。")

/datum/brain_trauma/mild/muscle_weakness/on_life(seconds_per_tick)
	var/fall_chance = 1
	if(owner.move_intent == MOVE_INTENT_RUN)
		fall_chance += 2
	if(SPT_PROB(0.5 * fall_chance, seconds_per_tick) && owner.body_position == STANDING_UP)
		to_chat(owner, span_warning("你的腿突然一软！"))
		owner.Paralyze(35)

	else if(owner.get_active_held_item())
		var/drop_chance = 1
		var/obj/item/I = owner.get_active_held_item()
		drop_chance += I.w_class
		if(SPT_PROB(0.5 * drop_chance, seconds_per_tick) && owner.dropItemToGround(I))
			to_chat(owner, span_warning("你失手掉落了[I]！"))

	else if(SPT_PROB(1.5, seconds_per_tick))
		to_chat(owner, span_warning("你突然感到肌肉无力！"))
		owner.adjust_stamina_loss(50)
	..()

/datum/brain_trauma/mild/muscle_spasms
	name = "肌肉痉挛"
	desc = "患者偶尔出现肌肉痉挛，导致不自主的动作。"
	scan_desc = "神经性抽搐"
	symptoms = "肌肉不自主收缩，引发短促、突然的动作或抽搐，可能干扰正常运动功能。"
	gain_text = span_warning("你的肌肉感到莫名无力。")
	lose_text = span_notice("你感觉又能控制自己的肌肉了。")

/datum/brain_trauma/mild/muscle_spasms/on_gain()
	owner.apply_status_effect(/datum/status_effect/spasms)
	. = ..()

/datum/brain_trauma/mild/muscle_spasms/on_lose()
	owner.remove_status_effect(/datum/status_effect/spasms)
	..()

/datum/brain_trauma/mild/nervous_cough
	name = "神经性咳嗽"
	desc = "患者总是想咳嗽。"
	scan_desc = "神经性咳嗽"
	symptoms = "持续产生无法控制的咳嗽冲动，可能影响正常活动与社交。"
	gain_text = span_warning("你的喉咙不停发痒……")
	lose_text = span_notice("你的喉咙不再发痒了。")

/datum/brain_trauma/mild/nervous_cough/on_life(seconds_per_tick)
	if(SPT_PROB(6, seconds_per_tick) && !HAS_TRAIT(owner, TRAIT_SOOTHED_THROAT))
		if(prob(5))
			to_chat(owner, span_warning("[pick("你剧烈地咳嗽起来！", "你咳得停不下来！")]"))
			owner.Immobilize(20)
			owner.emote("cough")
			addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob/, emote), "cough"), 0.6 SECONDS)
			addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob/, emote), "cough"), 1.2 SECONDS)
		owner.emote("cough")
	..()

/datum/brain_trauma/mild/expressive_aphasia
	name = "表达性失语症"
	desc = "患者部分丧失言语能力，导致词汇量减少。"
	scan_desc = "无法组织复杂句子"
	symptoms = "难以用言语表达想法，经常用简单词汇或无意义的声音代替复杂词语。"
	gain_text = span_warning("你不再能理解复杂的词语了。")
	lose_text = span_notice("你感觉自己的词汇量恢复正常了。")

/datum/brain_trauma/mild/expressive_aphasia/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		var/list/message_split = splittext(message, " ")
		var/list/new_message = list()

		for(var/word in message_split)
			var/suffix = ""
			var/suffix_foundon = 0
			for(var/potential_suffix in list("." , "," , ";" , "!" , ":" , "?"))
				suffix_foundon = findtext(word, potential_suffix, -length(potential_suffix))
				if(suffix_foundon)
					suffix = potential_suffix
					break

			if(suffix_foundon)
				word = copytext(word, 1, suffix_foundon)
			word = html_decode(word)

			if(GLOB.most_common_words_alphabetical[LOWER_TEXT(word)])
				new_message += word + suffix
			else
				if(prob(30) && message_split.len > 2)
					new_message += pick("呃","嗯")
					break
				else
					var/list/charlist = text2charlist(word)
					charlist.len = round(charlist.len * 0.5, 1)
					shuffle_inplace(charlist)
					new_message += jointext(charlist, "") + suffix

		message = jointext(new_message, " ")

	speech_args[SPEECH_MESSAGE] = trim(message)

/datum/brain_trauma/mild/mind_echo
	name = "思维回声"
	desc = "患者的语言神经元无法正常停止活动，导致先前的言语模式偶尔自行重现。"
	scan_desc = "循环神经模式"
	symptoms = "不自主地重复先前听过或说过的话，在听觉与言语中不断产生似曾相识的感觉。"
	gain_text = span_warning("你感觉思绪中出现了微弱的回声……")
	lose_text = span_notice("微弱的回声消失了。")
	var/list/hear_dejavu = list()
	var/list/speak_dejavu = list()

/datum/brain_trauma/mild/mind_echo/handle_hearing(datum/source, list/hearing_args)
	if(HAS_TRAIT(owner, TRAIT_DEAF) || owner == hearing_args[HEARING_SPEAKER])
		return

	if(hear_dejavu.len >= 5)
		if(prob(25))
			var/deja_vu = pick_n_take(hear_dejavu)
			var/static/regex/quoted_spoken_message = regex("\".+\"", "gi")
			hearing_args[HEARING_RAW_MESSAGE] = quoted_spoken_message.Replace(hearing_args[HEARING_RAW_MESSAGE], "\"[deja_vu]\"") //Quotes included to avoid cases where someone says part of their name
			return
	if(hear_dejavu.len >= 15)
		if(prob(50))
			popleft(hear_dejavu) //Remove the oldest
			hear_dejavu += hearing_args[HEARING_RAW_MESSAGE]
	else
		hear_dejavu += hearing_args[HEARING_RAW_MESSAGE]

/datum/brain_trauma/mild/mind_echo/handle_speech(datum/source, list/speech_args)
	if(speak_dejavu.len >= 5)
		if(prob(25))
			var/deja_vu = pick_n_take(speak_dejavu)
			speech_args[SPEECH_MESSAGE] = deja_vu
			return
	if(speak_dejavu.len >= 15)
		if(prob(50))
			popleft(speak_dejavu) //Remove the oldest
			speak_dejavu += speech_args[SPEECH_MESSAGE]
	else
		speak_dejavu += speech_args[SPEECH_MESSAGE]

/datum/brain_trauma/mild/color_blindness
	name = "全色盲"
	desc = "患者的枕叶无法识别和处理颜色，导致完全色盲。"
	scan_desc = "色盲"
	symptoms = "完全无法感知色彩，眼中的世界只有黑、白与不同深浅的灰色。"
	gain_text = span_warning("你周围的世界似乎失去了色彩。")
	lose_text = span_notice("世界又变得明亮多彩了。")

/datum/brain_trauma/mild/color_blindness/on_gain()
	owner.add_client_colour(/datum/client_colour/monochrome, TRAUMA_TRAIT)
	return ..()

/datum/brain_trauma/mild/color_blindness/on_lose(silent)
	owner.remove_client_colour(TRAUMA_TRAIT)
	return ..()

/datum/brain_trauma/mild/possessive
	name = "占有欲过强"
	desc = "患者对自己的物品有极强的占有欲。"
	scan_desc = "占有欲过强"
	symptoms = "极度渴望将个人物品留在身边，\
		经常紧握手持物品，即使被强迫松手也不肯放开。"
	gain_text = span_warning("你开始担心自己的物品。")
	lose_text = span_notice("你不再那么担心自己的物品了。")

/datum/brain_trauma/mild/possessive/on_lose(silent)
	. = ..()
	for(var/obj/item/thing in owner.held_items)
		clear_trait(thing)

/datum/brain_trauma/mild/possessive/on_life(seconds_per_tick)
	if(!SPT_PROB(5, seconds_per_tick))
		return

	var/obj/item/my_thing = pick(owner.held_items) // can pick null, that's fine
	if(isnull(my_thing) || HAS_TRAIT(my_thing, TRAIT_NODROP) || (my_thing.item_flags & (HAND_ITEM|ABSTRACT)))
		return

	ADD_TRAIT(my_thing, TRAIT_NODROP, TRAUMA_TRAIT)
	RegisterSignals(my_thing, list(COMSIG_ITEM_DROPPED, COMSIG_MOVABLE_MOVED), PROC_REF(clear_trait))
	to_chat(owner, span_warning("你觉得必须把[my_thing]留在身边……"))
	addtimer(CALLBACK(src, PROC_REF(relax), my_thing), rand(30 SECONDS, 3 MINUTES), TIMER_DELETE_ME)

/datum/brain_trauma/mild/possessive/proc/relax(obj/item/my_thing)
	if(QDELETED(my_thing))
		return
	if(HAS_TRAIT_FROM_ONLY(my_thing, TRAIT_NODROP, TRAUMA_TRAIT)) // in case something else adds nodrop, somehow?
		to_chat(owner, span_notice("你觉得现在可以放心地放开[my_thing]了。"))
	clear_trait(my_thing)

/datum/brain_trauma/mild/possessive/proc/clear_trait(obj/item/my_thing, ...)
	SIGNAL_HANDLER

	REMOVE_TRAIT(my_thing, TRAIT_NODROP, TRAUMA_TRAIT)
	UnregisterSignal(my_thing, list(COMSIG_ITEM_DROPPED, COMSIG_MOVABLE_MOVED))
