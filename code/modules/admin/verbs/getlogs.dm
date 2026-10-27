ADMIN_VERB(get_server_logs, R_ADMIN, "获取服务器日志", "查看或获取日志文件。", ADMIN_CATEGORY_MAIN)
	user.browseserverlogs()

ADMIN_VERB(get_current_logs, R_ADMIN, "获取当前日志", "查看或获取本回合的日志文件。", ADMIN_CATEGORY_MAIN)
	user.browseserverlogs(current=TRUE)

/client/proc/browseserverlogs(current=FALSE)
	var/path = browse_files(current ? BROWSE_ROOT_CURRENT_LOGS : BROWSE_ROOT_ALL_LOGS)
	if(!path)
		return

	if(file_spam_check())
		return

	log_admin("[key_name(src)] 访问了文件：[path]") // SKYRAT EDIT -- ADDITION
	message_admins("[key_name_admin(src)] 访问了文件：[path]")
	switch(tgui_alert(usr,"在游戏内查看、用系统文本编辑器打开，还是下载？", path, list("View", "Open", "Download")))
		if ("View")
			src << browse(HTML_SKELETON("<pre style='word-wrap: break-word;'>[html_encode(file2text(file(path)))]</pre>"), list2params(list("window" = "viewfile.[path]")))
		if ("Open")
			src << run(file(path))
		if ("Download")
			src << ftp(file(path))
		else
			return
	to_chat(src, "正在尝试发送 [path]，如果文件非常大，这可能需要好几分钟。", confidential = TRUE)
