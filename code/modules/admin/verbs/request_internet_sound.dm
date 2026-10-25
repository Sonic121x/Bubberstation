GAME_VERB(/mob, request_internet_sound, "请求网络音乐", "OOC")
	if(!CONFIG_GET(flag/request_internet_sound))
		to_chat(usr, span_danger("本服务器已禁用网络音乐请求。"), confidential = TRUE)
		return

	var/request_url = tgui_input_text(usr, "请输入一个 URL。支持的来源：[replacetext(replacetext(CONFIG_GET(string/request_internet_allowed), "\\", ""), ",", ", ")]。", "请求网络音乐")
	if(!request_url)
		return

	var/regex/allowed_regex = regex(replacetext(CONFIG_GET(string/request_internet_allowed), ",", "|"), "i")
	if(!allowed_regex.Find(request_url))
		to_chat(usr, span_danger("无效的 URL。请使用以下网站之一的 URL：[replacetext(CONFIG_GET(string/request_internet_allowed), "\\", " ")]"), confidential = TRUE)
		return

	var/credit = tgui_alert(usr, "要为点播这首曲目署名吗？（将显示为 [usr.ckey]）", "是否署名？", list("No", "Yes", "Cancel"))

	if(credit == "Cancel" || isnull(credit))
		return

	else if (credit == "Yes")
		credit = "[usr.ckey] 点播了这首曲目。"
	else
		credit = null

	log_internet_request("[src.key]/([src.name]): [request_url]")
	if(usr.client)
		if(usr.client.prefs.muted & MUTE_INTERNET_REQUEST)
			to_chat(usr, span_danger("你现在无法点播音乐。（已被禁言）"), confidential = TRUE)
			return
		if(src.client.handle_spam_prevention(request_url,MUTE_INTERNET_REQUEST))
			return

	GLOB.requests.music_request(usr.client, request_url, credit)
	to_chat(usr, span_info("你请求播放 [span_linkify(request_url)]。"), confidential = TRUE)

	var/list/admin_message = list()
	admin_message += ("[ADMIN_FULLMONTY(src)] [ADMIN_SC(src)] 请求播放以下内容：<br>")
	admin_message += ("[span_linkify(request_url)] [ADMIN_PLAY_INTERNET(request_url, credit)]")

	for(var/client/admin_client in GLOB.admins)
		if(get_chat_toggles(admin_client) & CHAT_PRAYER)
			to_chat(admin_client, fieldset_block("收到网络音乐请求", jointext(admin_message, ""), "boxed_message"), type = MESSAGE_TYPE_PRAYER, confidential = TRUE)

	SSblackbox.record_feedback("tally", "music_request", 1, "Music Request") // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!
