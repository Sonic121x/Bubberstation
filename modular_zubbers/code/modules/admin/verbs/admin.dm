ADMIN_VERB(ping_deadmins, R_ADMIN, "通知已卸任权限的管理员", "向所有暂时卸任管理权限的管理员发送通知和消息。", ADMIN_CATEGORY_MAIN)
	var/message = tgui_input_text(user, "输入随通知发送的消息", "通知卸任权限的管理员", "需要协助处理工单……", max_length = 256)
	if(!message)
		return

	var/list/admins_notified = list()
	for(var/ckey in GLOB.deadmins)
		var/client/deadmin_client = GLOB.directory[ckey]
		if(!deadmin_client)
			continue
		to_chat(
			deadmin_client,
			fieldset_block(
				span_adminhelp("[user.key]正在请求帮助"),
				span_adminsay(message),
				"boxed_message red_box"),
			type = MESSAGE_TYPE_SYSTEM,
			confidential = TRUE,
		)
		SEND_SOUND(deadmin_client, sound('sound/effects/adminhelp.ogg'))
		admins_notified += ckey

	log_admin("[key_name_admin(user)]通知了[length(admins_notified)]位已卸任权限的管理员（[admins_notified.Join(", ")]），消息：[message]")
	message_admins("[key_name_admin(user)]通知了[length(admins_notified)]位已卸任权限的管理员（[admins_notified.Join(", ")]），消息：[message]")
