/**
 * This proc is designed to be lightweight and straight forward, clients are finicky and joining all the time.
 * FALSE = Deny connection
 * True = Confirm connection
 */
/client/proc/check_population(connecting_admin = FALSE)
	if(connecting_admin)
		return TRUE //We allow admins to pass freeeeeeeely

	var/population = TGS_CLIENT_COUNT
	var/player_cap = CONFIG_GET(number/player_hard_cap)

	if(player_cap && population >= player_cap)
		var/overflow_server_ip = CONFIG_GET(string/overflow_server_ip)
		if(!overflow_server_ip)
			message_admins("警告：尚未设置分流服务器IP！")
			return TRUE
		to_chat_immediate(src, span_boldwarning("本局人数已满，正在将你转移至备用服务器，请稍候……"))
		message_admins("[src]尝试加入，但服务器已满，因此被转移至备用服务器。")
		src << link(overflow_server_ip)
		return FALSE
	return TRUE

/mob/dead/new_player/proc/connect_to_second_server()
	var/choice = tgui_alert(src, "当前服务器人数较多，请考虑加入备用服务器。", "服务器繁忙", list("留在这里", "连接过去！"))
	if(!client)
		return
	if(choice != "连接过去！")
		return
	to_chat(client, span_notice("再见，太空人。"))
	var/overflow_server_ip = CONFIG_GET(string/overflow_server_ip)
	if(!overflow_server_ip)
		message_admins("警告：尚未设置分流服务器IP！")
		return
	client << link(overflow_server_ip)

