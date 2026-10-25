/*
	The monitoring computer for the messaging server.
	Lets you read PDA and request console messages.
*/

#define MSG_MON_SCREEN_MAIN 0
#define MSG_MON_SCREEN_LOGS 1
#define MSG_MON_SCREEN_REQUEST_LOGS 2
#define MSG_MON_SCREEN_HACKED 3

/obj/machinery/computer/message_monitor
	name = "消息监控控制台"
	desc = "用于监控船员的 PDA 消息以及请求控制台消息。"
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/telecomms/server")
	icon_screen = "comm_logs"
	circuit = /obj/item/circuitboard/computer/message_monitor
	light_color = LIGHT_COLOR_GREEN
	/// Server linked to.
	var/obj/machinery/telecomms/message_server/linked_server = null
	/// Computer properties.
	/// 0 = Main menu, 1 = Message Logs, 2 = Hacked screen, 3 = Custom Message
	var/screen = MSG_MON_SCREEN_MAIN
	/// The message that shows on the main menu.
	var/message = "系统启动完毕，请选择一项操作。"
	/// Error message to display in the interface.
	var/error_message = ""
	/// Notice message to display in the interface.
	var/notice_message = ""
	/// Success message to display in the interface.
	var/success_message = ""
	/// Decrypt password
	var/password = ""

/obj/machinery/computer/message_monitor/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/computer/message_monitor/post_machine_initialize()
	. = ..()
	//Is the server isn't linked to a server, and there's a server available, default it to the first one in the list.
	if(!linked_server)
		for(var/obj/machinery/telecomms/message_server/message_server in GLOB.telecomm_machines)
			set_linked_server(message_server)
			break

/obj/machinery/computer/message_monitor/Destroy()
	set_linked_server(null)
	return ..()

/obj/machinery/computer/message_monitor/proc/set_linked_server(obj/machinery/telecomms/message_server/new_server)
	if(linked_server)
		linked_server.listening_computers -= src
	linked_server = new_server
	if(linked_server)
		linked_server.listening_computers += src

/obj/machinery/computer/message_monitor/proc/is_server_responsive()
	return !!(linked_server && !(linked_server.machine_stat & (NOPOWER|BROKEN)))

/obj/machinery/computer/message_monitor/screwdriver_act(mob/living/user, obj/item/I)
	if(obj_flags & EMAGGED)
		//Stops people from just unscrewing the monitor and putting it back to get the console working again.
		to_chat(user, span_warning("太烫了，没法操作！"))
		return TRUE
	return ..()

/obj/machinery/computer/message_monitor/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	if(isnull(linked_server))
		to_chat(user, span_notice("屏幕上出现了找不到服务器的错误提示。"))
		return FALSE

	obj_flags |= EMAGGED
	screen = MSG_MON_SCREEN_HACKED
	do_sparks(5, FALSE, src)
	var/obj/item/paper/monitorkey/monitor_key_paper = new(loc, linked_server)
	// Will help make emagging the console not so easy to get away with.
	monitor_key_paper.add_raw_text("<br><br><font color='red'>£%@%(*$%&(£&?*(%&£/{}</font>")
	var/time = 100 * length(linked_server.decryptkey)
	addtimer(CALLBACK(src, PROC_REF(unemag_console)), time)
	error_message = "严重错误 // 正在重启！<正在加载备用输入输出>——请稍候！"
	linked_server.toggled = FALSE
	return TRUE

/// Remove the emag effect from the console
/obj/machinery/computer/message_monitor/proc/unemag_console()
	screen = MSG_MON_SCREEN_MAIN
	linked_server.toggled = TRUE
	error_message = ""
	obj_flags &= ~EMAGGED

/obj/machinery/computer/message_monitor/ui_data(mob/user)
	var/list/data = list(
		"screen" = screen,
		"error_message" = error_message,
		"notice_message" = notice_message,
		"success_message" = success_message,
		"auth" = authenticated,
		"server_status" = is_server_responsive(),
	)

	switch(screen)
		if(MSG_MON_SCREEN_MAIN)
			data["password"] = password
			data["status"] = linked_server.on
			// Check is AI or cyborg malf
			var/mob/living/silicon/silicon_user = user
			data["is_malf"] = istype(silicon_user) && silicon_user.hack_software

		if(MSG_MON_SCREEN_LOGS)
			var/list/message_list = list()
			for(var/datum/data_tablet_msg/pda in linked_server.pda_msgs)
				message_list += list(list("ref" = REF(pda), "sender" = pda.sender, "recipient" = pda.recipient, "message" = pda.message))
			data["messages"] = message_list
		if(MSG_MON_SCREEN_REQUEST_LOGS)
			var/list/request_list = list()
			for(var/datum/data_rc_msg/rc in linked_server.rc_msgs)
				request_list += list(list("ref" = REF(rc), "message" = rc.message, "stamp" = rc.stamp, "id_auth" = rc.id_auth, "departament" = rc.sender_department))
			data["requests"] = request_list
	return data

/obj/machinery/computer/message_monitor/ui_static_data(mob/user)
	var/list/data = list("areaDisplay" = chinese_area_display(null, TRUE))
	data["is_on_station"] = is_on_station()
	return data

/// Check if this console is on the station and in a valid area
/obj/machinery/computer/message_monitor/proc/is_on_station()
	if(!is_station_level(z))
		return FALSE
	var/area/station/area = get_area(src)
	if(isnull(area) || !(area.area_flags & VALID_TERRITORY))
		return FALSE
	return TRUE

/obj/machinery/computer/message_monitor/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return .

	error_message = ""
	success_message = ""
	notice_message = ""

	switch(action)
		if("auth")
			var/authPass = params["auth_password"]

			if(authenticated)
				authenticated = FALSE
				return TRUE

			if(linked_server.decryptkey != authPass)
				error_message = "警报：解密密钥错误！"
				return TRUE

			authenticated = TRUE
			success_message = "登录成功！"

			return TRUE
		if("link_server")
			var/list/message_servers = list()
			for (var/obj/machinery/telecomms/message_server/message_server in GLOB.telecomm_machines)
				message_servers += message_server

			if(length(message_servers) > 1)
				var/selected_server = tgui_input_list(usr, "请选择服务器", "选择服务器", message_servers)
				if(QDELETED(src) || !is_operational || !usr.can_interact_with(src))
					screen = MSG_MON_SCREEN_MAIN
					return TRUE
				set_linked_server(selected_server)
				if(linked_server)
					notice_message = "提示：已选择服务器。"
			else if(length(message_servers) == 1)
				set_linked_server(message_servers[1])
				notice_message = "提示：仅检测到一台服务器，已自动选择。"
			else
				error_message = "警报：未检测到服务器。"
			screen = MSG_MON_SCREEN_MAIN
			return TRUE
		if("turn_server")
			if(!is_server_responsive())
				error_message = "警报：未检测到服务器。"
				return TRUE

			linked_server.toggled = !linked_server.toggled
			return TRUE
		if("view_message_logs")
			screen = MSG_MON_SCREEN_LOGS
			return
		if("view_request_logs")
			screen = MSG_MON_SCREEN_REQUEST_LOGS
			return TRUE
		if("clear_message_logs")
			linked_server.pda_msgs = list()
			notice_message = "提示：记录已清空。"
			return TRUE
		if("clear_request_logs")
			linked_server.rc_msgs = list()
			notice_message = "提示：记录已清空。"
			return TRUE
		if("set_key")
			if(!is_on_station())
				return TRUE

			var/dkey = tgui_input_text(usr, "请输入解密密钥", "电信解密", max_length = 16)
			if(QDELETED(src) || !is_operational || !usr.can_interact_with(src))
				return TRUE
			if(dkey && dkey != "")
				if(linked_server.decryptkey == dkey)
					var/newkey = tgui_input_text(usr, "请输入新密钥（3—16个字符）", "新密钥", max_length = 16)
					if(QDELETED(src) || !is_operational || !usr.can_interact_with(src))
						return TRUE
					if(length(newkey) <= 3)
						notice_message = "提示：解密密钥过短！"
					else if(newkey && newkey != "")
						linked_server.decryptkey = newkey
					notice_message = "提示：已设置解密密钥。"
				else
					error_message = "警报：解密密钥错误！"
			return TRUE
		if("return_home")
			screen = MSG_MON_SCREEN_MAIN
			return TRUE
		if("delete_message")
			linked_server.pda_msgs -= locate(params["ref"]) in linked_server.pda_msgs
			success_message = "记录已删除！"
			return TRUE
		if("delete_request")
			linked_server.rc_msgs -= locate(params["ref"]) in linked_server.rc_msgs
			success_message = "记录已删除！"
			return TRUE
		if("connect_server")
			if(linked_server)
				return TRUE
			for(var/obj/machinery/telecomms/message_server/new_home in GLOB.telecomm_machines)
				set_linked_server(new_home)
				break
			return TRUE
		if("send_fake_message")
			var/sender = tgui_input_text(usr, "发件人叫什么名字？", "发件人", max_length = MAX_NAME_LEN)
			var/job = tgui_input_text(usr, "发件人的职业是什么？", "职业", max_length = 60)

			var/recipient
			var/list/tablet_to_messenger = list()
			var/list/viewable_tablets = list()
			for (var/messenger_ref in GLOB.pda_messengers)
				var/datum/computer_file/program/messenger/message_app = GLOB.pda_messengers[messenger_ref]
				if(!message_app || message_app.invisible)
					continue
				if(!message_app.computer.saved_identification)
					continue
				viewable_tablets += message_app.computer
				tablet_to_messenger[message_app.computer] = message_app
			if(length(viewable_tablets) > 0)
				recipient = tgui_input_list(usr, "从列表中选择平板电脑", "选择平板电脑", viewable_tablets)
			else
				recipient = null

			var/message = tgui_input_text(usr, "请输入消息", "消息", max_length = MAX_MESSAGE_LEN)
			if(isnull(sender) || sender == "")
				sender = "未知"

			if(isnull(recipient))
				notice_message = "提示：未选择收件人！"
				return TRUE
			if(isnull(message) || message == "")
				notice_message = "提示：未输入消息！"
				return TRUE
			if(QDELETED(src) || !is_operational || !usr.can_interact_with(src))
				return TRUE

			var/datum/signal/subspace/messaging/tablet_message/signal = new(src, list(
				"fakename" = "[sender]",
				"fakejob" = "[job]",
				"message" = message,
				"targets" = list(tablet_to_messenger[recipient]),
			))
			// This will log the signal and transmit it to the target
			linked_server.receive_information(signal, null)
			usr.log_message("（平板电脑：[name] | [usr.real_name]）向[signal.format_target()]发送了“[message]”", LOG_PDA)
			return TRUE
		// Malfunction AI and cyborgs can hack console. This will authenticate the console, but you need to wait password selection
		if("hack")
			var/time = 10 SECONDS * length(linked_server.decryptkey)
			addtimer(CALLBACK(src, PROC_REF(unemag_console)), time)
			screen = MSG_MON_SCREEN_HACKED
			error_message = "严重错误 // 正在重启！<正在加载备用输入输出>——请稍候！"
			linked_server.toggled = FALSE
			authenticated = TRUE
			return TRUE
	return TRUE

/obj/machinery/computer/message_monitor/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "MessageMonitor", name)
		ui.open()

/obj/machinery/computer/message_monitor/ui_assets(mob/user)
	. = ..()
	. += get_asset_datum(/datum/asset/spritesheet_batched/chat)

#undef MSG_MON_SCREEN_MAIN
#undef MSG_MON_SCREEN_LOGS
#undef MSG_MON_SCREEN_REQUEST_LOGS
#undef MSG_MON_SCREEN_HACKED

/// Monitor decryption key paper

/obj/item/paper/monitorkey
	name = "监控器解密密钥"

/obj/item/paper/monitorkey/Initialize(mapload, obj/machinery/telecomms/message_server/server)
	. = ..()
	if (server)
		print(server)
		return INITIALIZE_HINT_NORMAL
	return INITIALIZE_HINT_LATELOAD

/**
 * Handles printing the monitor key for a given server onto this piece of paper.
 */
/obj/item/paper/monitorkey/proc/print(obj/machinery/telecomms/message_server/server)
	add_raw_text("<center><h2>每日密钥重置</h2></center><br>新的消息监控器密钥为<b>[server.decryptkey]</b>。<br>请妥善保密，别让小丑拿到。<br>必要时请将密码改得更安全。")
	add_overlay("paper_words")
	update_appearance()

/obj/item/paper/monitorkey/LateInitialize()
	for (var/obj/machinery/telecomms/message_server/preset/server in GLOB.telecomm_machines)
		if (server.decryptkey)
			print(server)
			break
