//These are all minor mutations that affect your speech somehow.
//Individual ones aren't commented since their functions should be evident at a glance
// no they arent bro


/datum/mutation/nervousness
	name = "紧张"
	desc = "受试者会因紧张而口吃。"
	instability = NEGATIVE_STABILITY_NONE
	quality = MINOR_NEGATIVE
	text_gain_indication = span_danger("你感到紧张。")

/datum/mutation/nervousness/on_life(seconds_per_tick)
	if(SPT_PROB(5, seconds_per_tick))
		owner.set_stutter_if_lower(20 SECONDS)

/datum/mutation/wacky
	name = "滑稽"
	desc = "受试者不只是变成了小丑，简直成了整座马戏团。"
	instability = NEGATIVE_STABILITY_NONE
	quality = MINOR_NEGATIVE
	text_gain_indication = span_sans(span_notice("你的喉头感觉有些异样。"))
	text_lose_indication = span_notice("异样的感觉消失了。")

/datum/mutation/wacky/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/mutation/wacky/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/mutation/wacky/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	speech_args[SPEECH_SPANS] |= SPAN_SANS

/datum/mutation/heckacious
	name = "魔性喉咙"
	desc = "锅们你说的这都什莫玩意儿啊…………"
	quality = MINOR_NEGATIVE
	text_gain_indication = span_sans("噢，操，锅们。你的嗓子感觉糟透腚了。")
	text_lose_indication = span_notice("附在你喉咙里的恶魔终于松手了。")
	locked = TRUE

/datum/mutation/heckacious/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_LIVING_TREAT_MESSAGE, PROC_REF(handle_caps))
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/mutation/heckacious/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, list(COMSIG_LIVING_TREAT_MESSAGE, COMSIG_MOB_SAY))

/datum/mutation/heckacious/proc/handle_caps(atom/movable/source, list/message_args)
	SIGNAL_HANDLER
	message_args[TREAT_CAPITALIZE_MESSAGE] = FALSE

/datum/mutation/heckacious/proc/handle_speech(datum/source, list/speech_args)

	var/message = speech_args[SPEECH_MESSAGE]
	if(!message)
		return
	// Split for swapping purposes
	message = " [message] "

	// Splitting up each word in the text to manually apply our intended changes
	var/list/message_words = splittext(message, " ")
	// What we use in the end
	var/list/edited_message_words

	for(var/editing_word in message_words)
		if(editing_word == " " || editing_word == "" )
			continue
		// Used to replace the original later
		var/og_word = editing_word
		// Iterating through each replaceable-string in the .json
		var/static/list/super_wacky_words = strings("heckacious.json", "heckacious")

		// If the word doesn't get replaced we might do something with it later
		var/word_edited
		for(var/key in super_wacky_words)
			var/value = super_wacky_words[key]
			// If list, pick one value from said list
			if(islist(value))
				value = pick(value)
			editing_word = replacetextEx(editing_word, "[uppertext(key)]", "[uppertext(value)]")
			editing_word = replacetextEx(editing_word, "[capitalize(key)]", "[capitalize(value)]")
			editing_word = replacetextEx(editing_word, "[key]", "[value]")
			// Enable if we actually found something to change
			if(editing_word != og_word)
				word_edited = TRUE

		// Random caps
		if(prob(10))
			editing_word = prob(85) ? uppertext(editing_word) : LOWER_TEXT(editing_word)
		// some times....... we add DOTS...
		if(prob(10))
			for(var/dotnum in 1 to rand(2, 8))
				editing_word += "."
		// change for bold/italics/underline as well!
		if(prob(10))
			var/extra_emphasis = pick("+", "_", "|")
			editing_word = extra_emphasis + editing_word + extra_emphasis

		// If no replacement we do it manually
		if(!word_edited)
			if(prob(65))
				editing_word = replacetext(editing_word, pick(VOWELS), pick(VOWELS))
			// Many more consonants, double it!
			for(var/i in 1 to rand(1, 2))
				editing_word = replacetext(editing_word, pick(CONSONANTS), pick(CONSONANTS))
			// rarely, lettter is DOUBBLED...
			var/patchword = ""
			for(var/letter in 1 to length(editing_word))
				if(prob(92))
					patchword += editing_word[letter]
					continue
				patchword += replacetext(editing_word[letter], "", editing_word[letter] + editing_word[letter])
			editing_word = patchword

		LAZYADD(edited_message_words, editing_word)

	var/edited_message = jointext(edited_message_words, " ")

	message = trim(edited_message)

	speech_args[SPEECH_MESSAGE] = message

/datum/mutation/mute
	name = "失语"
	desc = "受试者大脑中控制发声的区域被完全抑制。"
	instability = NEGATIVE_STABILITY_MAJOR
	quality = NEGATIVE
	text_gain_indication = span_danger("你感觉自己完全无法开口表达了。")
	text_lose_indication = span_danger("你感觉自己又能自由说话了。")

/datum/mutation/mute/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_MUTE, GENETIC_MUTATION)

/datum/mutation/mute/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_MUTE, GENETIC_MUTATION)

/datum/mutation/unintelligible
	name = "言语不清"
	desc = "受试者大脑中控制发声的区域被部分抑制，导致言语失真。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = NEGATIVE
	text_gain_indication = span_danger("你似乎无法形成任何连贯的想法！")
	text_lose_indication = span_danger("你的思绪清晰了许多。")

/datum/mutation/unintelligible/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_UNINTELLIGIBLE_SPEECH, GENETIC_MUTATION)

/datum/mutation/unintelligible/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_UNINTELLIGIBLE_SPEECH, GENETIC_MUTATION)

/datum/mutation/swedish
	name = "瑞典腔"
	desc = "一种源于遥远过去的可怕突变，人们曾以为它在2037年的事件后已经绝迹。\
		受试者的言语变得难以理解，常被误认为是在说外语。"
	instability = NEGATIVE_STABILITY_NONE
	quality = MINOR_NEGATIVE
	text_gain_indication = span_notice("你感觉自己很瑞典，虽然不知道这究竟是什么意思。")
	text_lose_indication = span_notice("那种瑞典的感觉消失了。")
	var/static/list/language_mutilation = list("w" = "v", "j" = "y", "bo" = "bjo", "a" = list("å","ä","æ","a"), "o" = list("ö","ø","o"))

/datum/mutation/swedish/New(datum/mutation/copymut)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = language_mutilation, end_string = list("","，啵克","，啵克，啵克"), end_string_chance = 30)

/datum/mutation/chav
	name = "街头混混腔"
	desc = "一种未知突变，使受试者说起某种非常特别的方言。\
		受试者的言语变得难以理解，常被误认为是在说外语。"
	instability = NEGATIVE_STABILITY_NONE
	quality = MINOR_NEGATIVE
	text_gain_indication = span_notice("你丫觉得自个儿像个二货，是不？")
	text_lose_indication = span_notice("你不再想出言不逊、阴阳怪气了。")

/datum/mutation/chav/New(datum/mutation/copymut)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("chav_replacement.json", "chav"), end_string = "，哥们", end_string_chance = 30)

/datum/mutation/elvis
	name = "猫王"
	desc = "一种以其“零号病人”命名的可怕突变。\
		受试者说话开始带有奇怪的节奏，还常常突然跳起舞来。"
	instability = NEGATIVE_STABILITY_NONE
	quality = MINOR_NEGATIVE
	text_gain_indication = span_notice("你感觉好极了，甜心宝贝。")
	text_lose_indication = span_notice("你觉得少说两句也不错。")

/datum/mutation/elvis/New(datum/mutation/copymut)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("elvis_replacement.json", "elvis"))

/datum/mutation/elvis/on_life(seconds_per_tick)
	switch(pick(1,2))
		if(1)
			if(SPT_PROB(7.5, seconds_per_tick))
				var/list/dancetypes = list("摇摆的", "花哨的", "时髦的", "二十世纪风格的", "牛仔舞式的", "摇滚风格的", "酷炫的", "撩人的", "劲爆的", "惊艳的")
				var/dancemoves = pick(dancetypes)
				owner.visible_message("<b>[owner]</b>突然跳起了[dancemoves]舞步！")
		if(2)
			if(SPT_PROB(7.5, seconds_per_tick))
				owner.visible_message("<b>[owner]</b>[pick("抖动着臀部", "扭转着胯部", "摇摆着臀部", "用脚打着拍子", "随着想象中的歌曲起舞", "抖动着双腿", "打起了响指")]！")

/datum/mutation/stoner
	name = "嗨客"
	desc = "受试者的智力大幅下降，说的话只有处于同样状态的人才能理解。"
	quality = NEGATIVE
	text_gain_indication = span_notice("你感觉……超放松，老兄！")
	text_lose_indication = span_notice("你感觉自己的时间感恢复了些。")

/datum/mutation/stoner/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	owner.grant_language(/datum/language/beachbum, source = LANGUAGE_STONER)
	owner.add_blocked_language(subtypesof(/datum/language) - /datum/language/beachbum, source = LANGUAGE_STONER)

/datum/mutation/stoner/on_losing(mob/living/carbon/human/owner)
	..()
	owner.remove_language(/datum/language/beachbum, source = LANGUAGE_STONER)
	owner.remove_blocked_language(subtypesof(/datum/language) - /datum/language/beachbum, source = LANGUAGE_STONER)

/datum/mutation/medieval
	name = "中世纪腔"
	desc = "一种源于遥远过去的可怕突变，据信曾是旧地球“欧洲”各地常见的基因。\
		受试者会染上某种口癖，说话风格变得十分特别。"
	instability = NEGATIVE_STABILITY_NONE
	quality = MINOR_NEGATIVE
	text_gain_indication = span_notice("你想去寻找圣杯！")
	text_lose_indication = span_notice("你不再想寻找任何东西了。")

/datum/mutation/medieval/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/mutation/medieval/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/mutation/medieval/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		message = " [message] "
		var/list/medieval_words = strings("medieval_replacement.json", "medieval")
		var/list/startings = strings("medieval_replacement.json", "startings")
		for(var/key in medieval_words)
			var/value = medieval_words[key]
			if(islist(value))
				value = pick(value)
			if(uppertext(key) == key)
				value = uppertext(value)
			if(capitalize(key) == key)
				value = capitalize(value)
			message = replacetextEx(message,regex("\b[REGEX_QUOTE(key)]\b","ig"), value)
		message = trim(message)
		var/chosen_starting = pick(startings)
		message = "[chosen_starting] [message]"

		speech_args[SPEECH_MESSAGE] = message

/datum/mutation/piglatin
	name = "猪拉丁语"
	desc = "历史学家声称，五个世纪前全人类都使用这种神秘语言。\
		受试者被迫使用这种通常难以理解的语言说话。"
	instability = NEGATIVE_STABILITY_NONE
	quality = MINOR_NEGATIVE
	text_gain_indication = span_notice("么什感觉不对劲哎。")
	text_lose_indication = span_notice("异样的感觉消失了。")

/datum/mutation/piglatin/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/mutation/piglatin/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/mutation/piglatin/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	var/spoken_message = speech_args[SPEECH_MESSAGE]
	spoken_message = piglatin_sentence(spoken_message)
	speech_args[SPEECH_MESSAGE] = spoken_message
