// Make sure that the code compiles with AI_VOX undefined
#ifdef AI_VOX
#define VOX_DELAY 300

/mob/living/silicon/ai
	/// The currently selected VOX Announcer voice.
	var/vox_type = VOX_BMS
	/// The list of available VOX Announcer voices to choose from.
	var/list/vox_voices = list(VOX_HL, VOX_NORMAL, VOX_BMS)
	/// The VOX word(s) that were previously inputed.
	var/vox_word_string
	/// Can the AI purchase the nuke as a malf
	var/can_purchase_nuke = FALSE

GAME_VERB_DESC(/mob/living/silicon/ai, announcement_help, "播报帮助", "显示可向船员播报的语音词汇列表。", "AI 指令")
	if(incapacitated)
		return

	var/dat = {"
	<font class='bad'>警告：</font>滥用播报系统会导致你被封禁职业。<BR><BR>
	以下是可以输入到“播报”按钮中的词汇列表，用来组成句子，向你所在同一层级的全体人员语音播报。<BR>
	<UL><LI>你也可以点击词语来试听。</LI>
	<LI>每次播报最多只能说 30 个词。</LI>
	<LI>不要像平常那样使用标点；如果你想停顿，可以用空格分隔句号和逗号字符，例如：“Alpha . Test , Bravo”。</LI>
	<LI>数字请用单词形式，例如 eight、sixty 等 </LI>
	<LI>音效词要在实际词语前加一个“s”，例如 scensor</LI>
	<LI>用 Ctrl+F 可以查找列表中是否存在某个词。</LI></UL><HR>
	"}
	switch(vox_type)
		if(VOX_NORMAL)
			var/index = 0
			for(var/word in GLOB.vox_sounds)
				index++
				dat += "<A href='byond://?src=[REF(src)];say_word=[word]'>[capitalize(word)]</A>"
				if(index != GLOB.vox_sounds.len)
					dat += " / "
		if(VOX_HL)
			var/index = 0
			for(var/word in GLOB.vox_sounds_hl)
				index++
				dat += "<A href='byond://?src=[REF(src)];say_word=[word]'>[capitalize(word)]</A>"
				if(index != GLOB.vox_sounds_hl.len)
					dat += " / "
		if(VOX_MIL)
			var/index = 0
			for(var/word in GLOB.vox_sounds_mil)
				index++
				dat += "<A href='byond://?src=[REF(src)];say_word=[word]'>[capitalize(word)]</A>"
				if(index != GLOB.vox_sounds_mil.len)
					dat += " / "
		if(VOX_BMS)
			var/index = 0
			for(var/word in GLOB.vox_sounds_bms)
				index++
				dat += "<A href='byond://?src=[REF(src)];say_word=[word]'>[capitalize(word)]</A>"
				if(index != GLOB.vox_sounds_bms.len)
					dat += " / "

	var/datum/browser/popup = new(src, "announce_help", "Announcement Help", 500, 400)
	popup.set_content(dat)
	popup.open()


/mob/living/silicon/ai/proc/announcement()
	var/static/announcing_vox = 0 // Stores the time of the last announcement
	if(announcing_vox > world.time)
		to_chat(src, span_notice("请等待 [DisplayTimeText(announcing_vox - world.time)]。"))
		return

	var/message = input(src, "警告：滥用此指令可能导致你被封禁职业。更多帮助请见“播报帮助”", "播报", src.last_announcement) as text|null

	if(!message || announcing_vox > world.time)
		return

	last_announcement = message

	if(incapacitated)
		return

	if(control_disabled)
		to_chat(src, span_warning("无线接口已禁用，无法操作播报扩音系统。"))
		return

	var/list/words = splittext(trim(message), " ")
	var/list/incorrect_words = list()

	if(words.len > 30)
		words.len = 30

	switch(vox_type)
		if(VOX_NORMAL)
			for(var/word in words)
				word = LOWER_TEXT(trim(word))
				if(!word)
					words -= word
					continue
				if(!GLOB.vox_sounds[word])
					incorrect_words += word
		if(VOX_HL)
			for(var/word in words)
				word = LOWER_TEXT(trim(word))
				if(!word)
					words -= word
					continue
				if(!GLOB.vox_sounds_hl[word])
					incorrect_words += word
		if(VOX_MIL)
			for(var/word in words)
				word = LOWER_TEXT(trim(word))
				if(!word)
					words -= word
					continue
				if(!GLOB.vox_sounds_mil[word])
					incorrect_words += word
		if(VOX_BMS)
			for(var/word in words)
				word = LOWER_TEXT(trim(word))
				if(!word)
					words -= word
					continue
				if(!GLOB.vox_sounds_bms[word])
					incorrect_words += word

	if(incorrect_words.len)
		to_chat(src, span_notice("以下词语在播报系统中不可用：[english_list(incorrect_words)]。"))
		return

	announcing_vox = world.time + VOX_DELAY

	log_game("[key_name(src)] 通过语音播报发出了以下信息：[message]。")
	log_talk(message, LOG_SAY, tag="VOX Announcement")

	var/list/players = list()
	var/turf/ai_turf = get_turf(src)
	for(var/mob/player_mob as anything in GLOB.player_list)
		var/turf/player_turf = get_turf(player_mob)
		if(is_valid_z_level(ai_turf, player_turf))
			players += player_mob
	minor_announce(capitalize(message), "[name] 播报", players = players, should_play_sound = CALLBACK(GLOBAL_PROC_REF(does_target_have_vox_off)))

	for(var/word in words)
		play_vox_word(word, ai_turf, null, vox_type)


/proc/play_vox_word(word, ai_turf, mob/only_listener, vox_type)

	word = LOWER_TEXT(word)
	var/sound_file
	var/vox_volume_mod = 1
	switch(vox_type)
		if(VOX_HL)
			if(GLOB.vox_sounds_hl[word])
				sound_file = GLOB.vox_sounds_hl[word]
				vox_volume_mod = 0.75
		if(VOX_MIL)
			if(GLOB.vox_sounds_mil[word])
				sound_file = GLOB.vox_sounds_mil[word]
				vox_volume_mod = 0.50 // My poor ears...
		if(VOX_BMS)
			if(GLOB.vox_sounds_bms[word])
				sound_file = GLOB.vox_sounds_bms[word]
		else
			if(GLOB.vox_sounds[word])
				sound_file = GLOB.vox_sounds[word]

// If there is no single listener, broadcast to everyone in the same z level
	if(!only_listener)
		// Play voice for all mobs in the z level
		for(var/mob/player_mob in GLOB.player_list)
			var/pref_volume = safe_read_pref(player_mob.client, /datum/preference/numeric/volume/sound_ai_vox)
			pref_volume *= vox_volume_mod
			if(HAS_TRAIT(player_mob, TRAIT_DEAF) || !pref_volume)
				continue

			var/turf/player_turf = get_turf(player_mob)
			if(!is_valid_z_level(ai_turf, player_turf))
				continue

			var/sound/voice = sound(sound_file, wait = 1, channel = CHANNEL_VOX, volume = pref_volume)
			voice.status = SOUND_STREAM
			SEND_SOUND(player_mob, voice)

	else
		var/pref_volume = safe_read_pref(only_listener.client, /datum/preference/numeric/volume/sound_ai_vox)
		var/sound/voice = sound(sound_file, wait = 1, channel = CHANNEL_VOX, volume = pref_volume)
		voice.status = SOUND_STREAM
		SEND_SOUND(only_listener, voice)

	return TRUE

/proc/does_target_have_vox_off(mob/target)
	return !safe_read_pref(target.client, /datum/preference/numeric/volume/sound_ai_vox)

GAME_VERB_DESC(/mob/living/silicon/ai, switch_vox, "切换 VOX 语音", "切换你的 VOX 播报语音！", "AI 指令")
	if(incapacitated)
		return
	var/selection = tgui_input_list(src, "请选择新的 VOX 语音：", "VOX 语音", vox_voices)
	if(selection == null)
		return
	vox_type = selection

	to_chat(src, "VOX 语音已设为 [vox_type]")


GAME_VERB_DESC(/mob/living/silicon/ai, display_word_string, "显示词语串", "显示最近输入的 VOX 语句列表。", "AI 指令")
	if(incapacitated)
		return

	to_chat(src, vox_word_string)

GAME_VERB_DESC(/mob/living/silicon/ai, clear_word_string, "清除词语串", "清除最近的 VOX 词语。", "AI 指令")
	vox_word_string = ""

#undef VOX_DELAY
#endif
