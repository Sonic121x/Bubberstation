#define SHELLEO_ERRORLEVEL 1
#define SHELLEO_STDOUT 2
#define SHELLEO_STDERR 3

#define COOLDOWN_LOCAL_INTERNET_SOUND "local_internet_sound"

///Takes an input from either proc/play_web_sound or the request manager and runs it through youtube-dl and prompts the user before playing it to the server.
/proc/localweb_sound(mob/user, input, credit, range = null)
	if(!check_rights(R_SOUND))
		return
	var/ytdl = CONFIG_GET(string/invoke_youtubedl)
	if(!ytdl)
		to_chat(user, span_boldwarning("Youtube-dl 未配置，该操作不可用"), confidential = TRUE) //Check config.txt for the INVOKE_YOUTUBEDL value
		return
	var/localweb_sound_url = ""
	var/stop_localweb_sounds = FALSE
	var/list/music_extra_data = list()
	var/duration = 0
	if(istext(input))
		var/shell_scrubbed_input = shell_url_scrub(input)
		var/list/output = world.shelleo("[ytdl] --geo-bypass --format \"bestaudio\[ext=mp3]/best\[ext=mp4]\[height <= 360]/bestaudio\[ext=m4a]/bestaudio\[ext=aac]\" --dump-single-json --no-playlist -- \"[shell_scrubbed_input]\"")
		var/errorlevel = output[SHELLEO_ERRORLEVEL]
		var/stdout = output[SHELLEO_STDOUT]
		var/stderr = output[SHELLEO_STDERR]
		if(errorlevel)
			to_chat(user, span_boldwarning("Youtube-dl URL 获取失败："), confidential = TRUE)
			to_chat(user, span_warning("[stderr]"), confidential = TRUE)
			return
		var/list/data
		try
			data = json_decode(stdout)
		catch(var/exception/e)
			to_chat(user, span_boldwarning("Youtube-dl JSON 解析失败："), confidential = TRUE)
			to_chat(user, span_warning("[e]: [stdout]"), confidential = TRUE)
			return
		if (data["url"])
			localweb_sound_url = data["url"]
		var/title = "[data["title"]]"
		var/webpage_url = title
		if (data["webpage_url"])
			webpage_url = "<a href=\"[data["webpage_url"]]\">[title]</a>"
		music_extra_data["duration"] = DisplayTimeText(data["duration"] * 1 SECONDS)
		music_extra_data["link"] = data["webpage_url"]
		music_extra_data["artist"] = data["artist"]
		music_extra_data["upload_date"] = data["upload_date"]
		music_extra_data["album"] = data["album"]
		duration = data["duration"] * 1 SECONDS
		if (duration > 10 MINUTES)
			if((tgui_alert(user, "这首歌曲超过 10 分钟。你确定要播放吗？", "长度警告！", list("No", "Yes", "Cancel")) != "Yes"))
				return
		var/res = tgui_alert(user, "要向玩家显示这首歌曲的标题和链接吗？\n[title]", "显示信息？", list("Yes", "No", "Cancel"))
		switch(res)
			if("Yes")
				music_extra_data["title"] = data["title"]
			if("No")
				music_extra_data["link"] = "歌曲链接已隐藏"
				music_extra_data["title"] = "歌曲标题已隐藏"
				music_extra_data["artist"] = "歌曲艺术家已隐藏"
				music_extra_data["upload_date"] = "歌曲上传日期已隐藏"
				music_extra_data["album"] = "歌曲专辑已隐藏"
			if("Cancel", null)
				return
		var/anon = tgui_alert(user, "要显示是谁播放了这首歌曲吗？", "署名自己？", list("Yes", "No", "Cancel"))
		switch(anon)
			if("Yes")
				if(res == "Yes")
					to_chat(world, span_boldannounce("[user.key] 在本地播放了：[webpage_url]"), confidential = TRUE)
				else
					to_chat(world, span_boldannounce("[user.key] 在本地播放了一段声音"), confidential = TRUE)
			if("No")
				if(res == "Yes")
					to_chat(world, span_boldannounce("一名管理员在本地播放了：[webpage_url]"), confidential = TRUE)
			if("Cancel", null)
				return
		if(credit)
			to_chat(world, span_boldannounce(credit), confidential = TRUE)
		SSblackbox.record_feedback("nested tally", "played_url", 1, list("[user.ckey]", "[input]"))
		log_admin("[key_name(user)] 播放了本地网络声音：[input]")
		message_admins("[key_name(user)] 播放了本地网络声音：[input]")
	else
		//pressed ok with blank
		log_admin("[key_name(user)] 停止了本地网络声音。")

		message_admins("[key_name(user)] 停止了本地网络声音。")
		localweb_sound_url = null
		stop_localweb_sounds = TRUE
	if(localweb_sound_url && !findtext(localweb_sound_url, GLOB.is_http_protocol))
		tgui_alert(user, "媒体提供方返回的内容 URL 未使用 HTTP 或 HTTPS 协议。这会带来安全风险，声音将不会被播放。", "安全风险", list("OK"))
		to_chat(user, span_boldwarning("已阻止：内容 URL 未使用 HTTP(S) 协议！"), confidential = TRUE)

		return
	if(localweb_sound_url || stop_localweb_sounds)
		var/list/players = GLOB.player_list
		if (range)
			players = list()
			for (var/mob/listening_mob in hearers(range, user))
				if (listening_mob.client)
					players += listening_mob
		for(var/mob/player_mob as anything in players)
			if(player_mob.client.prefs.read_preference(/datum/preference/numeric/volume/sound_midi) > 0)
				if(!stop_localweb_sounds)
					player_mob.client.tgui_panel?.play_music(localweb_sound_url, music_extra_data)
				else
					player_mob.client.tgui_panel?.stop_music()

	S_TIMER_COOLDOWN_START(SStimer, COOLDOWN_LOCAL_INTERNET_SOUND, duration)

	BLACKBOX_LOG_ADMIN_VERB("Play Local Internet Sound")

ADMIN_VERB(play_localweb_sound, R_SOUND, "播放本地网络声音", "向指定范围内的玩家播放指定的网络声音。", ADMIN_CATEGORY_FUN)
	var/ytdl = CONFIG_GET(string/invoke_youtubedl)
	if(!ytdl)
		to_chat(src, span_boldwarning("Youtube-dl 未配置，该操作不可用"), confidential = TRUE) //Check config.txt for the INVOKE_YOUTUBEDL value
		return

	if(S_TIMER_COOLDOWN_TIMELEFT(SStimer, COOLDOWN_LOCAL_INTERNET_SOUND))
		if(tgui_alert(usr, "其他人已经在播放网络声音了！还剩 [DisplayTimeText(S_TIMER_COOLDOWN_TIMELEFT(SStimer, COOLDOWN_LOCAL_INTERNET_SOUND), 1)]。\
		是否要覆盖？", "音乐被打断", list("No","Yes")) != "Yes")
			return

	var/web_sound_input = tgui_input_text(usr, "输入内容 URL（仅支持部分网站，留空则停止播放）", "播放本地网络声音", null)

	if(length(web_sound_input))
		web_sound_input = trim(web_sound_input)
		if(findtext(web_sound_input, ":") && !findtext(web_sound_input, GLOB.is_http_protocol))
			to_chat(src, span_boldwarning("不允许使用非 http(s) URI。"), confidential = TRUE)
			to_chat(src, span_warning("如需使用 ytsearch: 之类的 youtube-dl 快捷方式，请改用网站上完整的 URL。"), confidential = TRUE)
			return
		var/number_input = tgui_input_number(usr, "你希望以多大范围播放？（留空则对所有人播放）", "播放本地网络声音", null)
		localweb_sound(usr, web_sound_input, range = number_input)
	else
		localweb_sound(usr, null, null, null)

#undef SHELLEO_ERRORLEVEL
#undef SHELLEO_STDOUT
#undef SHELLEO_STDERR
#undef COOLDOWN_LOCAL_INTERNET_SOUND
