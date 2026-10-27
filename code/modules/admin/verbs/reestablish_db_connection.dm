ADMIN_VERB(reestablish_db_connection, R_NONE, "重新建立数据库连接", "尝试重新建立数据库连接", ADMIN_CATEGORY_SERVER)
	if (!CONFIG_GET(flag/sql_enabled))
		to_chat(user, span_adminnotice("数据库未启用！"), confidential = TRUE)
		return

	if (SSdbcore.IsConnected())
		if (!user.holder.check_for_rights(R_DEBUG))
			tgui_alert(user,"数据库已经连接！（只有拥有 +debug 权限的人才能强制重新连接）", "数据库已经连接！")
			return

		var/reconnect = tgui_alert(user,"数据库已经连接！如果你*确信*这一状态有误，可以强制重新连接", "数据库已经连接！", list("Force Reconnect", "Cancel"))
		if (reconnect != "Force Reconnect")
			return

		SSdbcore.Disconnect()
		log_admin("[key_name(user)] 强制断开了数据库连接")
		message_admins("[key_name_admin(user)] <b>强制</b>断开了数据库连接！")
		BLACKBOX_LOG_ADMIN_VERB("Force Reestablished Database Connection")

	log_admin("[key_name(user)] 正在尝试重新建立数据库连接")
	message_admins("[key_name_admin(user)] 正在尝试重新建立数据库连接")
	BLACKBOX_LOG_ADMIN_VERB("Reestablished Database Connection")

	SSdbcore.failed_connections = 0
	if(!SSdbcore.Connect())
		message_admins("数据库连接失败：" + SSdbcore.ErrorMsg())
	else
		message_admins("数据库连接已重新建立")
