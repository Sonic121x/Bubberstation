/obj/item/skillchip/musical
	name = "\improper 旧版《空间站 13：音乐剧》"
	desc = "一张旧的《空间站 13：音乐剧》拷贝， \
		曾在空间站百年庆典上放映……又或者是两百周年？"
	skill_name = "音乐剧的记忆"
	skill_description = "让你能唱出那个高音，就像一世纪前的人们那样。"
	skill_icon = FA_ICON_MUSIC
	activate_message = span_notice("你觉得自己能 \u2669 高唱一曲！ \u266B")
	deactivate_message = span_notice("那部音乐剧从你脑海中淡去，只留下一丝怀旧之情。")
	custom_premium_price = PAYCHECK_CREW * 4

/obj/item/skillchip/musical/Initialize(mapload, is_removable)
	. = ..()
	name = replacetext(name, "旧版", round(CURRENT_STATION_YEAR - pick(50, 100, 150, 200, 250), 5))

/obj/item/skillchip/musical/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(make_music))

/obj/item/skillchip/musical/on_deactivate(mob/living/carbon/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_SAY)

/obj/item/skillchip/musical/proc/make_music(mob/living/carbon/source, list/say_args)
	SIGNAL_HANDLER

	var/raw_message = say_args[SPEECH_MESSAGE]
	var/list/words = splittext(raw_message, " ")
	if(length(words) <= 1)
		say_args[SPEECH_MODS][MODE_SING] = TRUE
		return
	var/last_word = words[length(words)]
	var/num_chars = length_char(last_word)
	var/last_vowel = ""
	// find the last vowel present in the word
	for(var/i in 1 to num_chars)
		var/char = copytext_char(last_word, i, i + 1)
		if(char in VOWELS)
			last_vowel = char

	// now we'll reshape the final word to make it sound like they're singing it
	var/final_word = ""
	var/has_ellipsis = copytext(last_word, -3) == "..."
	for(var/i in 1 to num_chars)
		var/char = copytext_char(last_word, i, i + 1)
		// replacing any final periods with exclamation marks (so long as it's not an ellipsis)
		if(char == "." && i == num_chars && !has_ellipsis)
			final_word += "!"
		// or if it's the vowel we found, we're gonna repeat it a few times (holding the note)
		else if(char == last_vowel)
			for(var/j in 1 to 4)
				final_word += char
			// if we dragged out the last character of the word, just period it
			if(i == num_chars)
				final_word += "."
		// no special handing otherwise
		else
			final_word += char

	if(!has_ellipsis)
		// adding an extra exclamation mark at the end if there's no period
		var/last_char = copytext_char(final_word, -1)
		if(last_char != ".")
			final_word += "!"

	words[length(words)] = final_word
	// now we siiiiiiing
	say_args[SPEECH_MESSAGE] = jointext(words, " ")
	say_args[SPEECH_MODS][MODE_SING] = TRUE

/obj/item/skillchip/musical/examine(mob/user)
	. = ..()
	. += span_tinynoticeital("咦，看来它正好能装进技能芯片转接器里。")

/obj/item/skillchip/musical/examine_more(mob/user)
	. = ..()
	var/list/songs = list()
	songs += "&bull; “空间站 13 叙事曲”"
	songs += "&bull; “舰长的召唤”"
	songs += "&bull; “默剧演员的哀歌”"
	songs += "&bull; “被货运部封禁”"
	songs += "&bull; “植物学蓝调”"
	songs += "&bull; “小丑之歌”"
	songs += "&bull; “工程师挽歌”"
	songs += "&bull; “医疗失职者”"
	songs += "&bull; “安保罢工”"
	songs += "&bull; “快叫穿梭机来”"
	songs += "&bull;  还有一首被划掉了……"

	. += span_notice("<i>在芯片背面，你看到一份歌曲列表：</i>")
	. += span_smallnotice("<i>[jointext(songs, "<br>")]</i>")
