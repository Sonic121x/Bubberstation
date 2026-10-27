ADMIN_VERB(upload_jukebox_music, R_SERVER, "点唱机上传音乐", "上传有效的 .ogg 文件，供点唱机访问播放。", ADMIN_CATEGORY_SERVER)
	var/file = input(user, "选择要上传到点唱机的 .ogg 文件。") as sound|null
	if(!file)
		return

	// we could theorticly support other sound types but OGG is the better format from what I am aware and I am 100% sure its length is properly fetched.
	if(!IS_OGG_FILE(file))
		tgui_alert(user, "文件类型无效。请选择一个 OGG 文件。", "加载错误", list("确定"))
		return

	var/list/track_data = splittext(file, "+")
	if(track_data.len < 2)
		if(tgui_alert(user, "你的歌曲标题目前没有以十分之一秒为单位标注节拍间隔，例如：SS13+5.ogg。是否继续？", "确认", list("Yes", "No")) != "Yes")
			return
	if(track_data.len > 2)
		tgui_alert(user, "标题中只应包含曲名和以十分之一秒为单位的节拍间隔，例如：SS13+5.ogg", "加载错误", list("确定"))
		return


	var/clean_name = SANITIZE_FILENAME("[file]")
	var/save_path = "[CONFIG_JUKEBOX_SOUNDS][clean_name]"

	// Copy uploaded file to the server
	fcopy(file, save_path)

	message_admins("[key_name_admin(user)] 向点唱机上传了 [clean_name]！")
	to_chat(user, span_notice("已成功上传 [clean_name]！"))
	refresh_jukebox_songs()

ADMIN_VERB(browse_jukebox_music, R_SERVER, "点唱机浏览音乐", "浏览用于审核的音乐文件。", ADMIN_CATEGORY_SERVER)
	var/list/files = flist(CONFIG_JUKEBOX_SOUNDS)
	// Filter out things that are not sound files, like the exclude
	for(var/thing in files)
		if(!IS_SOUND_FILE(thing))
			files -= thing
	if(!files.len)
		to_chat(user, span_warning("未找到已上传的音轨。"))
		return

	var/choice = tgui_input_list(user, "选择一首音轨：", "选择点唱机音乐", files)
	if(!choice)
		return

	var/path = "[CONFIG_JUKEBOX_SOUNDS][choice]"

	switch(tgui_alert(user, "播放、删除还是下载？", choice, list("Play", "Delete", "Download")))
		if ("Play")
			SEND_SOUND(user, sound(path))
		if ("Delete")
			fdel(path)
			var/msg = "[key_name_admin(user)] 从点唱机中删除了 [choice]！"
			message_admins(msg)
			log_admin(msg)
			SSblackbox.record_feedback("associative", "jukebox_deletion", 1, list("round_id" = "[GLOB.round_id]", "deletor" = "[key_name_admin(user)]", "deleted" = "[choice]"))
			refresh_jukebox_songs()
		if ("Download")
			user << ftp(file(path))
		else
			return

/// Recache the songs from config then force replace all the songs.
/proc/refresh_jukebox_songs()
	var/refreshed = FALSE
	for(var/obj/machinery/jukebox/jukebox as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/jukebox))
		if(!refreshed)
			jukebox.music_player.load_songs_from_config(TRUE)
			refreshed = TRUE

		jukebox.music_player.songs = jukebox.music_player.init_songs()
