/proc/create_message(type, target_key, admin_ckey, text, timestamp, server, secret, logged = 1, browse, expiry, note_severity)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("无法建立数据库连接。"), confidential = TRUE)
		return
	if(!type)
		return
	var/target_ckey = ckey(target_key)
	if(!target_key && (type == "note" || type == "message" || type == "watchlist entry"))
		var/new_key = input(usr,"你想为谁创建 [type]？","输入 key 或 ckey",null) as null|text
		if(!new_key)
			return
		var/new_ckey = ckey(new_key)
		var/datum/db_query/query_find_ckey = SSdbcore.NewQuery(
			"SELECT ckey FROM [format_table_name("player")] WHERE ckey = :ckey",
			list("ckey" = new_ckey)
		)
		if(!query_find_ckey.warn_execute())
			qdel(query_find_ckey)
			return
		if(!query_find_ckey.NextRow())
			if(tgui_alert(usr, "[new_key]/([new_ckey]) 此前从未出现过，你确定要为其创建 [type] 吗？", "未知 ckey", list("Yes", "No", "Cancel")) != "Yes")
				qdel(query_find_ckey)
				return
		qdel(query_find_ckey)
		target_ckey = new_ckey
		target_key = new_key
	if(QDELETED(usr))
		return
	if(!target_key)
		target_key = target_ckey
	if(!admin_ckey)
		admin_ckey = usr.ckey
		if(!admin_ckey)
			return
	if(!target_ckey)
		target_ckey = admin_ckey
	if(!text)
		text = input(usr,"写下你的 [type]","创建 [type]") as null|message
		if(!text)
			return
	if(!server)
		var/ssqlname = CONFIG_GET(string/serversqlname)
		if (ssqlname)
			server = ssqlname
	if(isnull(secret))
		switch(tgui_alert(usr,"要对玩家隐藏这条备注吗？", "秘密备注？",list("Yes","No","Cancel")))
			if("Yes")
				secret = 1
			if("No")
				secret = 0
			else
				return
	if(isnull(expiry))
		if(tgui_alert(usr, "设置过期时间吗？过期的记录会像已删除的记录一样被隐藏。", "过期时间？", list("Yes", "No", "Cancel")) == "Yes")
			var/expire_time = input("以 YYYY-MM-DD HH:MM:SS 格式设置 [type] 的过期时间。所有时间均为服务器时间。HH:MM:SS 可省略，且为 24 小时制。显然必须晚于当前时间。", "设置过期时间", ISOtime()) as null|text
			if(!expire_time)
				return
			var/datum/db_query/query_validate_expire_time = SSdbcore.NewQuery(
				"SELECT IF(STR_TO_DATE(:expire_time,'%Y-%c-%d %T') > NOW(), STR_TO_DATE(:expire_time,'%Y-%c-%d %T'), 0)",
				list("expire_time" = expire_time)
			)
			if(!query_validate_expire_time.warn_execute())
				qdel(query_validate_expire_time)
				return
			if(query_validate_expire_time.NextRow())
				var/checktime = text2num(query_validate_expire_time.item[1])
				if(!checktime)
					to_chat(usr, "输入的日期时间格式不正确，或并不晚于当前服务器时间。", confidential = TRUE)
					qdel(query_validate_expire_time)
					return
				expiry = query_validate_expire_time.item[1]
			qdel(query_validate_expire_time)
	if(type == "note" && isnull(note_severity))
		note_severity = input("设置该备注的严重程度。", "严重程度", null, null) as null|anything in list("High", "Medium", "Minor", "None")
		if(!note_severity)
			return
	var/list/parameters = list(
		"type" = type,
		"target_ckey" = target_ckey,
		"admin_ckey" = admin_ckey,
		"text" = text,
		"server_name" = CONFIG_GET(string/serversqlname), // SKYRAT EDIT ADDITION - MULTISERVER
		"server" = server,
		"internet_address" = world.internet_address || "0",
		"port" = "[world.port]",
		"round_id" = GLOB.round_id,
		"secret" = secret,
		"expiry" = expiry || null,
		"note_severity" = note_severity,
	)
	if(timestamp)
		parameters["timestamp"] = timestamp
	var/datum/db_query/query_create_message = SSdbcore.NewQuery({"
		INSERT INTO [format_table_name("messages")] (type, targetckey, adminckey, text, timestamp, server, server_ip, server_port, round_id, secret, expire_timestamp, severity, playtime)
		VALUES (:type, :target_ckey, :admin_ckey, :text, [timestamp? ":timestamp" : "Now()"], :server, INET_ATON(:internet_address), :port, :round_id, :secret, :expiry, :note_severity, (SELECT `minutes` FROM [format_table_name("role_time")] WHERE `ckey` = :target_ckey AND `job` = 'Living'))
	"}, parameters)
	var/pm = "[key_name(usr)] 创建了一条[secret ? "秘密 " : ""][type][(type == "note" || type == "message" || type == "watchlist entry") ? "（针对 [target_key]）" : ""]：[text]"
	var/header = "[key_name_admin(usr)] 创建了一条[secret ? "秘密 " : ""][type][(type == "note" || type == "message" || type == "watchlist entry") ? "（针对 [target_key]）" : ""]"
	if(!query_create_message.warn_execute())
		qdel(query_create_message)
		return
	qdel(query_create_message)
	if(logged)
		log_admin_private(pm)
		message_admins("[header]:<br>[text]")
		admin_ticket_log(target_ckey, "<font color='blue'>[header]</font><br>[text]")
		if(browse)
			browse_messages("[type]")
		else
			browse_messages(target_ckey = target_ckey, agegate = TRUE)

/proc/delete_message(message_id, logged = 1, browse)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("无法建立数据库连接。"), confidential = TRUE)
		return
	message_id = text2num(message_id)
	if(!message_id)
		return
	var/type
	var/target_key
	var/text
	var/user_key_name = key_name(usr)
	var/user_name_admin = key_name_admin(usr)
	var/deleted_by_ckey = usr.ckey
	var/datum/db_query/query_find_del_message = SSdbcore.NewQuery(
		"SELECT type, IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey), text FROM [format_table_name("messages")] WHERE id = :id AND deleted = 0",
		list("id" = message_id)
	)
	if(!query_find_del_message.warn_execute())
		qdel(query_find_del_message)
		return
	if(query_find_del_message.NextRow())
		type = query_find_del_message.item[1]
		target_key = query_find_del_message.item[2]
		text = query_find_del_message.item[3]
	qdel(query_find_del_message)
	var/datum/db_query/query_del_message = SSdbcore.NewQuery(
		"UPDATE [format_table_name("messages")] SET deleted = 1, deleted_ckey = :deleted_ckey WHERE id = :id",
		list("deleted_ckey" = deleted_by_ckey, "id" = message_id)
	)
	if(!query_del_message.warn_execute())
		qdel(query_del_message)
		return
	qdel(query_del_message)
	if(logged)
		var/m1 = "[user_key_name] 删除了一条 [type][(type == "note" || type == "message" || type == "watchlist entry") ? "，针对" : "，作者为"] [target_key]：[text]"
		var/m2 = "[user_name_admin] 删除了一条 [type][(type == "note" || type == "message" || type == "watchlist entry") ? "，针对" : "，作者为"] [target_key]：<br>[text]"
		log_admin_private(m1)
		message_admins(m2)
		if(browse)
			browse_messages("[type]")
		else
			browse_messages(target_ckey = ckey(target_key), agegate = TRUE)

/proc/edit_message(message_id, browse)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("无法建立数据库连接。"), confidential = TRUE)
		return
	message_id = text2num(message_id)
	if(!message_id)
		return
	var/editor_ckey = usr.ckey
	var/editor_key = usr.key
	var/kn = key_name(usr)
	var/kna = key_name_admin(usr)
	var/datum/db_query/query_find_edit_message = SSdbcore.NewQuery({"
		SELECT
			type,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), targetckey),
			text
		FROM [format_table_name("messages")]
		WHERE id = :id AND deleted = 0
	"}, list("id" = message_id))
	if(!query_find_edit_message.warn_execute())
		qdel(query_find_edit_message)
		return
	if(query_find_edit_message.NextRow())
		var/type = query_find_edit_message.item[1]
		var/target_key = query_find_edit_message.item[2]
		var/admin_key = query_find_edit_message.item[3]
		var/old_text = query_find_edit_message.item[4]
		var/new_text = input("输入新的 [type]", "新建 [type]", "[old_text]") as null|message
		if(!new_text)
			qdel(query_find_edit_message)
			return
		var/edit_text = "由 [editor_key] 于 [ISOtime()] 编辑，原文<br>[old_text]<br>改为<br>[new_text]<hr>"
		var/datum/db_query/query_edit_message = SSdbcore.NewQuery({"
			UPDATE [format_table_name("messages")]
			SET text = :text, lasteditor = :lasteditor, edits = CONCAT(IFNULL(edits,''),:edit_text)
			WHERE id = :id AND deleted = 0
		"}, list("text" = new_text, "lasteditor" = editor_ckey, "edit_text" = edit_text, "id" = message_id))
		if(!query_edit_message.warn_execute())
			qdel(query_edit_message)
			return
		qdel(query_edit_message)
		log_admin_private("[kn] 编辑了一条 [type] [(type == "note" || type == "message" || type == "watchlist entry") ? "，针对 [target_key]" : ""]（作者 [admin_key]），从 [old_text] 改为 [new_text]")
		message_admins("[kna] 编辑了一条 [type] [(type == "note" || type == "message" || type == "watchlist entry") ? "，针对 [target_key]" : ""]（作者 [admin_key]），从<br>[old_text]<br>改为<br>[new_text]")
		if(browse)
			browse_messages("[type]")
		else
			browse_messages(target_ckey = ckey(target_key), agegate = TRUE)
	qdel(query_find_edit_message)

/proc/edit_message_expiry(message_id, browse)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("无法建立数据库连接。"), confidential = TRUE)
		return
	message_id = text2num(message_id)
	if(!message_id)
		return
	var/editor_ckey = usr.ckey
	var/editor_key = usr.key
	var/kn = key_name(usr)
	var/kna = key_name_admin(usr)
	var/datum/db_query/query_find_edit_expiry_message = SSdbcore.NewQuery({"
		SELECT
			type,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), adminckey),
			expire_timestamp
		FROM [format_table_name("messages")]
		WHERE id = :id AND deleted = 0
	"}, list("id" = message_id))
	if(!query_find_edit_expiry_message.warn_execute())
		qdel(query_find_edit_expiry_message)
		return
	if(query_find_edit_expiry_message.NextRow())
		var/type = query_find_edit_expiry_message.item[1]
		var/target_key = query_find_edit_expiry_message.item[2]
		var/admin_key = query_find_edit_expiry_message.item[3]
		var/old_expiry = query_find_edit_expiry_message.item[4]
		var/new_expiry
		var/expire_time = input("以 YYYY-MM-DD HH:MM:SS 格式设置 [type] 的过期时间。所有时间均为服务器时间。HH:MM:SS 可省略，且为 24 小时制。显然必须晚于当前时间。输入 -1 可移除过期时间。", "设置过期时间", old_expiry) as null|text
		if(!expire_time)
			qdel(query_find_edit_expiry_message)
			return
		if(expire_time == "-1")
			new_expiry = "永不过期"
		else
			var/datum/db_query/query_validate_expire_time_edit = SSdbcore.NewQuery({"
				SELECT IF(STR_TO_DATE(:expire_time,'%Y-%c-%d %T') > NOW(), STR_TO_DATE(:expire_time,'%Y-%c-%d %T'), 0)
			"}, list("expire_time" = expire_time))
			if(!query_validate_expire_time_edit.warn_execute())
				qdel(query_validate_expire_time_edit)
				qdel(query_find_edit_expiry_message)
				return
			if(query_validate_expire_time_edit.NextRow())
				var/checktime = text2num(query_validate_expire_time_edit.item[1])
				if(!checktime)
					to_chat(usr, "输入的日期时间格式不正确，或并不晚于当前服务器时间。", confidential = TRUE)
					qdel(query_validate_expire_time_edit)
					qdel(query_find_edit_expiry_message)
					return
				new_expiry = query_validate_expire_time_edit.item[1]
			qdel(query_validate_expire_time_edit)
		var/edit_text = "过期时间由 [editor_key] 于 [ISOtime()] 编辑，从 [(old_expiry ? old_expiry : "无过期时间")] 改为 [new_expiry]<hr>"
		var/datum/db_query/query_edit_message_expiry = SSdbcore.NewQuery({"
			UPDATE [format_table_name("messages")]
			SET expire_timestamp = :expire_time, lasteditor = :lasteditor, edits = CONCAT(IFNULL(edits,''),:edit_text)
			WHERE id = :id AND deleted = 0
		"}, list("expire_time" = (expire_time == "-1" ? null : new_expiry), "lasteditor" = editor_ckey, "edit_text" = edit_text, "id" = message_id))
		if(!query_edit_message_expiry.warn_execute())
			qdel(query_edit_message_expiry)
			qdel(query_find_edit_expiry_message)
			return
		qdel(query_edit_message_expiry)
		log_admin_private("[kn] 编辑了一条 [type] [(type == "note" || type == "message" || type == "watchlist entry") ? "，针对 [target_key]" : ""]（作者 [admin_key]）的过期时间，从 [(old_expiry ? old_expiry : "无过期时间")] 改为 [new_expiry]")
		message_admins("[kna] 编辑了一条 [type] [(type == "note" || type == "message" || type == "watchlist entry") ? "，针对 [target_key]" : ""]（作者 [admin_key]）的过期时间，从 [(old_expiry ? old_expiry : "无过期时间")] 改为 [new_expiry]")
		if(browse)
			browse_messages("[type]")
		else
			browse_messages(target_ckey = ckey(target_key), agegate = TRUE)
	qdel(query_find_edit_expiry_message)

/proc/edit_message_severity(message_id)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("无法建立数据库连接。"), confidential = TRUE)
		return
	message_id = text2num(message_id)
	if(!message_id)
		return
	var/kn = key_name(usr)
	var/kna = key_name_admin(usr)
	var/datum/db_query/query_find_edit_note_severity = SSdbcore.NewQuery({"
		SELECT
			type,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), adminckey),
			severity
		FROM [format_table_name("messages")]
		WHERE id = :id AND deleted = 0
	"}, list("id" = message_id))
	if(!query_find_edit_note_severity.warn_execute())
		qdel(query_find_edit_note_severity)
		return
	if(query_find_edit_note_severity.NextRow())
		var/type = query_find_edit_note_severity.item[1]
		var/target_key = query_find_edit_note_severity.item[2]
		var/admin_key = query_find_edit_note_severity.item[3]
		var/old_severity = query_find_edit_note_severity.item[4]
		if(!old_severity)
			old_severity = "无"
		var/editor_key = usr.key
		var/editor_ckey = usr.ckey
		var/new_severity = input("设置该备注的严重程度。", "严重程度", null, null) as null|anything in list("high", "medium", "minor", "none") //lowercase for edit log consistency
		if(!new_severity)
			qdel(query_find_edit_note_severity)
			return
		new_severity = new_severity
		var/edit_text = "备注严重程度由 [editor_key] 于 [ISOtime()] 编辑，从 [old_severity] 改为 [new_severity]<hr>"
		var/datum/db_query/query_edit_note_severity = SSdbcore.NewQuery({"
			UPDATE [format_table_name("messages")]
			SET severity = :severity, lasteditor = :lasteditor, edits = CONCAT(IFNULL(edits,''),:edit_text)
			WHERE id = :id AND deleted = 0
		"}, list("severity" = new_severity, "lasteditor" = editor_ckey, "edit_text" = edit_text, "id" = message_id))
		if(!query_edit_note_severity.warn_execute(async = TRUE))
			qdel(query_edit_note_severity)
			qdel(qdel(query_find_edit_note_severity))
			return
		qdel(query_edit_note_severity)
		log_admin_private("[kn] 将 [target_key] 的、由 [admin_key] 撰写的一条 [type] 的严重程度从 [old_severity] 改为 [new_severity]")
		message_admins("[kna] 将 [target_key] 的、由 [admin_key] 撰写的一条 [type] 的严重程度从 [old_severity] 改为 [new_severity]")
		browse_messages(target_ckey = ckey(target_key), agegate = TRUE)
	qdel(query_find_edit_note_severity)

/proc/toggle_message_secrecy(message_id)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("无法建立数据库连接。"), confidential = TRUE)
		return
	message_id = text2num(message_id)
	if(!message_id)
		return
	var/editor_ckey = usr.ckey
	var/editor_key = usr.key
	var/kn = key_name(usr)
	var/kna = key_name_admin(usr)
	var/datum/db_query/query_find_message_secret = SSdbcore.NewQuery({"
		SELECT
			type,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), targetckey),
			secret
		FROM [format_table_name("messages")]
		WHERE id = :id AND deleted = 0
	"}, list("id" = message_id))
	if(!query_find_message_secret.warn_execute())
		qdel(query_find_message_secret)
		return
	if(query_find_message_secret.NextRow())
		var/type = query_find_message_secret.item[1]
		var/target_key = query_find_message_secret.item[2]
		var/admin_key = query_find_message_secret.item[3]
		var/secret = text2num(query_find_message_secret.item[4])
		var/edit_text = "由 [editor_key] 于 [ISOtime()] 标记为[secret ? "非秘密" : "秘密"]<hr>"
		var/datum/db_query/query_message_secret = SSdbcore.NewQuery({"
			UPDATE [format_table_name("messages")]
			SET secret = NOT secret, lasteditor = :lasteditor, edits = CONCAT(IFNULL(edits,''),:edit_text)
			WHERE id = :id
		"}, list("lasteditor" = editor_ckey, "edit_text" = edit_text, "id" = message_id))
		if(!query_message_secret.warn_execute())
			qdel(query_find_message_secret)
			qdel(query_message_secret)
			return
		qdel(query_message_secret)
		log_admin_private("[kn] 将 [target_key] 的、由 [admin_key] 撰写的一条 [type] 切换为[secret ? "非秘密" : "秘密"]")
		message_admins("[kna] 将 [target_key] 的、由 [admin_key] 撰写的一条 [type] 切换为[secret ? "非秘密" : "秘密"]")
		browse_messages(target_ckey = ckey(target_key), agegate = TRUE)
	qdel(query_find_message_secret)

/proc/browse_messages(type, target_ckey, index, linkless = FALSE, filter, agegate = FALSE)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("无法建立数据库连接。"), confidential = TRUE)
		return

	//Needs to be requested before url retrieval since you can view your notes before SSassets finishes initialization
	var/datum/asset/notes_assets = get_asset_datum(/datum/asset/simple/notes)

	var/list/output = list()
	var/ruler = "<hr style='background:#000000; border:0; height:3px'>"
	var/list/navbar = list("<a href='byond://?_src_=holder;[HrefToken()];nonalpha=1'>全部</a><a href='byond://?_src_=holder;[HrefToken()];nonalpha=2'>#</a>")
	for(var/letter in GLOB.alphabet)
		navbar += "<a href='byond://?_src_=holder;[HrefToken()];showmessages=[letter]'>[letter]</a>"
	navbar += "<a href='byond://?_src_=holder;[HrefToken()];showmemo=1'>备忘录</a><a href='byond://?_src_=holder;[HrefToken()];showwatch=1'>观察名单</a>"
	navbar += "<br><form method='GET' name='search' action='?'>\
	<input type='hidden' name='_src_' value='holder'>\
	[HrefTokenFormField()]\
	<input type='text' name='searchmessages' value='[index]'>\
	<input type='submit' value='搜索'></form>"
	if(!linkless)
		output = navbar
	if(type == "memo" || type == "watchlist entry")
		if(type == "memo")
			output += "<h2><center>管理员备忘录</h2>"
			output += "<a href='byond://?_src_=holder;[HrefToken()];addmemo=1'>添加备忘录</a></center>"
		else if(type == "watchlist entry")
			output += "<h2><center>观察名单条目</h2>"
			output += "<a href='byond://?_src_=holder;[HrefToken()];addwatchempty=1'>添加观察名单条目</a>"
			if(filter)
				output += "<a href='byond://?_src_=holder;[HrefToken()];showwatch=1'>取消筛选客户端</a></center>"
			else
				output += "<a href='byond://?_src_=holder;[HrefToken()];showwatchfilter=1'>筛选离线客户端</a></center>"
		output += ruler
		var/datum/db_query/query_get_type_messages = SSdbcore.NewQuery(/* SKYRAT EDIT CHANGE - MULTISERVER */{"
			SELECT
				id,
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
				targetckey,
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), adminckey),
				text,
				timestamp,
				server_name,
				server,
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = lasteditor), lasteditor),
				expire_timestamp,
				playtime,
				round_id
			FROM [format_table_name("messages")]
			WHERE type = :type AND deleted = 0 AND (expire_timestamp > NOW() OR expire_timestamp IS NULL)
		"}, list("type" = type))
		if(!query_get_type_messages.warn_execute())
			qdel(query_get_type_messages)
			return
		while(query_get_type_messages.NextRow())
			if(QDELETED(usr))
				return
			var/id = query_get_type_messages.item[1]
			var/t_key = query_get_type_messages.item[2]
			var/t_ckey = query_get_type_messages.item[3]
			if(type == "watchlist entry" && filter && !(t_ckey in GLOB.directory))
				continue
			var/admin_key = query_get_type_messages.item[4]
			var/text = query_get_type_messages.item[5]
			var/timestamp = query_get_type_messages.item[6]
			var/server = query_get_type_messages.item[7]
			// SKYRAT EDIT CHANGE BEGIN - MULTISERVER
			var/editor_key = query_get_type_messages.item[9]
			var/expire_timestamp = query_get_type_messages.item[10]
			var/playtime = query_get_type_messages.item[11]
			var/round_id = query_get_type_messages.item[12]
			// SKYRAT EDIT CHANGE END - MULTISERVER
			output += "<b>"
			if(type == "watchlist entry")
				output += "[t_key] | "
			output += "[timestamp] | [server] | 轮次 [round_id] | [admin_key]"
			if(type == "watchlist entry")
				output += " | 存活游戏时长 [get_exp_format(text2num(playtime))]"
			if(expire_timestamp)
				output += " | 过期时间 [expire_timestamp]"
			output += "</b>"
			output += " <a href='byond://?_src_=holder;[HrefToken()];editmessageexpiryempty=[id]'>更改过期时间</a>"
			output += " <a href='byond://?_src_=holder;[HrefToken()];deletemessageempty=[id]'>删除</a>"
			output += " <a href='byond://?_src_=holder;[HrefToken()];editmessageempty=[id]'>编辑</a>"
			if(editor_key)
				output += " <font size='2'>最后编辑者 [editor_key] <a href='byond://?_src_=holder;[HrefToken()];messageedits=[id]'>（点击此处查看编辑日志）</a></font>"
			output += "<br>[text]<hr style='background:#000000; border:0; height:1px'>"
		qdel(query_get_type_messages)
	if(target_ckey)
		var/target_key
		var/datum/db_query/query_get_messages = SSdbcore.NewQuery(/* SKYRAT EDIT CHANGE - MULTISERVER */{"
			SELECT
				type,
				secret,
				id,
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), adminckey),
				text,
				timestamp,
				server_name,
				server,
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = lasteditor), lasteditor),
				DATEDIFF(NOW(), timestamp),
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
				expire_timestamp,
				severity,
				playtime,
				round_id
			FROM [format_table_name("messages")]
			WHERE type <> 'memo' AND targetckey = :targetckey AND deleted = 0 AND (expire_timestamp > NOW() OR expire_timestamp IS NULL)
			ORDER BY timestamp DESC
		"}, list("targetckey" = target_ckey))
		if(!query_get_messages.warn_execute())
			qdel(query_get_messages)
			return
		var/list/messagedata = list()
		var/list/watchdata = list()
		var/list/notedata = list()
		var/skipped = 0
		while(query_get_messages.NextRow())
			if(QDELETED(usr))
				return
			type = query_get_messages.item[1]
			if(type == "memo")
				continue
			var/secret = text2num(query_get_messages.item[2])
			if(linkless && secret)
				continue
			var/id = query_get_messages.item[3]
			var/admin_key = query_get_messages.item[4]
			var/text = query_get_messages.item[5]
			var/timestamp = query_get_messages.item[6]
			var/server = query_get_messages.item[7]
			// SKYRAT EDIT CHANGE BEGIN - MULTISERVER
			var/editor_key = query_get_messages.item[9]
			var/age = text2num(query_get_messages.item[10])
			target_key = query_get_messages.item[11]
			var/expire_timestamp = query_get_messages.item[12]
			var/severity = query_get_messages.item[13]
			var/playtime = query_get_messages.item[14]
			var/round_id = query_get_messages.item[15]
			// SKYRAT EDIT CHANGE END - MULTISERVER
			var/alphatext = ""
			var/nsd = CONFIG_GET(number/note_stale_days)
			var/nfd = CONFIG_GET(number/note_fresh_days)
			if (agegate && type == "note" && isnum(nsd) && isnum(nfd) && nsd > nfd)
				var/alpha = clamp(100 - (age - nfd) * (85 / (nsd - nfd)), 15, 100)
				if (alpha < 100)
					if (alpha <= 15)
						if (skipped)
							skipped++
							continue
						alpha = 10
						skipped = TRUE
					alphatext = "filter: alpha(opacity=[alpha]); opacity: [alpha/100];"
			var/list/data = list("<div style='margin:0px;[alphatext]'><p class='severity'>")
			if(severity)
				data += "<img src='[SSassets.transport.get_asset_url("[severity]_button.png")]' height='24' width='24'></img> "
			data += "<b>[timestamp] | [server] | 轮次 [round_id] | [admin_key][secret ? " | <i>- 秘密</i>" : ""] | 存活游戏时长 [get_exp_format(text2num(playtime))]"
			if(expire_timestamp)
				data += " | 过期时间 [expire_timestamp]"
			data += "</b></p><center>"
			if(!linkless)
				if(type == "note")
					if(severity)
						data += "<a href='byond://?_src_=holder;[HrefToken()];editmessageseverity=[id]'>[severity == "none" ? "无" : "[capitalize(severity)]"] 严重程度</a>"
					else
						data += "<a href='byond://?_src_=holder;[HrefToken()];editmessageseverity=[id]'>不适用 严重程度</a>"
				data += " <a href='byond://?_src_=holder;[HrefToken()];editmessageexpiry=[id]'>更改过期时间</a>"
				data += " <a href='byond://?_src_=holder;[HrefToken()];deletemessage=[id]'>删除</a>"
				if(type == "note")
					data += " <a href='byond://?_src_=holder;[HrefToken()];secretmessage=[id]'>[secret ? "<b>秘密</b>" : "非秘密"]</a>"
				if(type == "message sent")
					data += " <font size='2'>留言已发送</font>"
					if(editor_key)
						data += "|"
				else
					data += " <a href='byond://?_src_=holder;[HrefToken()];editmessage=[id]'>编辑</a>"
				if(editor_key)
					data += " <font size='2'>最后编辑者 [editor_key] <a href='byond://?_src_=holder;[HrefToken()];messageedits=[id]'>（点击此处查看编辑日志）</a></font>"
			data += "</div></center>"
			data += "<p style='[alphatext]'>[text]</p><hr style='background:#000000; border:0; height:1px; [alphatext]'>"
			switch(type)
				if("message")
					messagedata += data
				if("message sent")
					messagedata += data
				if("watchlist entry")
					watchdata += data
				if("note")
					notedata += data
		qdel(query_get_messages)
		if(!target_key)
			var/datum/db_query/query_get_message_key = SSdbcore.NewQuery({"
				SELECT byond_key FROM [format_table_name("player")] WHERE ckey = :ckey
			"}, list("ckey" = target_ckey))
			if(!query_get_message_key.warn_execute())
				qdel(query_get_message_key)
				return
			if(query_get_message_key.NextRow())
				target_key = query_get_message_key.item[1]
			qdel(query_get_message_key)
		output += "<h2><center>[target_key]</center></h2><center>"
		if(!linkless)
			output += "<a href='byond://?_src_=holder;[HrefToken()];addnote=[target_key]'>添加备注</a>"
			output += " <a href='byond://?_src_=holder;[HrefToken()];addmessage=[target_key]'>添加留言</a>"
			output += " <a href='byond://?_src_=holder;[HrefToken()];addwatch=[target_key]'>加入观察名单</a>"
			output += " <a href='byond://?_src_=holder;[HrefToken()];showmessageckey=[target_ckey]'>刷新页面</a></center>"
		else
			output += " <a href='byond://?_src_=holder;[HrefToken()];showmessageckeylinkless=[target_ckey]'>刷新页面</a></center>"
		output += ruler
		if(messagedata)
			output += "<h2>留言</h2>"
			output += messagedata
		if(watchdata)
			output += "<h2>观察名单</h2>"
			output += watchdata
		if(notedata)
			output += "<h2>备注</h2>"
			output += notedata
			if(!linkless)
				if (agegate)
					if (skipped) //the first skipped message is still shown so that we can put this link over it.
						output += "<center><a href='byond://?_src_=holder;[HrefToken()];showmessageckey=[target_ckey];showall=1' style='position: relative; top: -3em;'>显示 [skipped] 条隐藏备注</a></center>"
					else
						output += "<center><a href='byond://?_src_=holder;[HrefToken()];showmessageckey=[target_ckey];showall=1'>显示全部</a></center>"
				else
					output += "<center><a href='byond://?_src_=holder;[HrefToken()];showmessageckey=[target_ckey]'>隐藏旧记录</a></center>"
	if(index)
		var/search
		output += "<center><a href='byond://?_src_=holder;[HrefToken()];addmessageempty=1'>添加留言</a><a href='byond://?_src_=holder;[HrefToken()];addwatchempty=1'>添加观察名单条目</a><a href='byond://?_src_=holder;[HrefToken()];addnoteempty=1'>添加备注</a></center>"
		output += ruler
		switch(index)
			if(1)
				search = "^."
			if(2)
				search = "^\[^\[:alpha:\]\]"
			else
				search = "^[index]"
		var/datum/db_query/query_list_messages = SSdbcore.NewQuery({"
			SELECT DISTINCT
				targetckey,
				(SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey)
			FROM [format_table_name("messages")]
			WHERE type <> 'memo'
				AND targetckey REGEXP :search
				AND deleted = 0
				AND (expire_timestamp > NOW() OR expire_timestamp IS NULL)
			ORDER BY targetckey
		"}, list("search" = search))
		if(!query_list_messages.warn_execute())
			qdel(query_list_messages)
			return
		while(query_list_messages.NextRow())
			if(QDELETED(usr))
				return
			var/index_ckey = query_list_messages.item[1]
			var/index_key = query_list_messages.item[2]
			if(!index_key)
				index_key = index_ckey
			output += "<a href='byond://?_src_=holder;[HrefToken()];showmessageckey=[index_ckey]'>[index_key]</a><br>"
		qdel(query_list_messages)
	else if(!type && !target_ckey && !index)
		output += "<center><a href='byond://?_src_=holder;[HrefToken()];addmessageempty=1'>添加留言</a><a href='byond://?_src_=holder;[HrefToken()];addwatchempty=1'>添加观察名单条目</a><a href='byond://?_src_=holder;[HrefToken()];addnoteempty=1'>添加备注</a></center>"
		output += ruler
	var/datum/browser/browser = new(usr, "Note panel", "管理玩家备注", 1000, 500)
	notes_assets.send(usr.client)
	browser.set_content(jointext(output, ""))
	browser.open()

/// Represents a message stored in the db
/datum/admin_message
	/// The uid of this message
	var/id
	/// The admin who left this message
	var/admin_key
	/// The text of this message
	var/text
	/// The time this message was first created
	var/timestamp
	/// The admin who last edited this message
	var/editor_key

/proc/get_message_output(type, target_ckey, show_secret = TRUE, after_timestamp)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("无法建立数据库连接。"), confidential = TRUE)
		return
	if(!type)
		return
	var/list/parameters = list(
		"targetckey" = target_ckey,
		"type" = type,
	)
	if(after_timestamp)
		parameters["after_timestamp"] = after_timestamp
	var/datum/db_query/query_get_message_output = SSdbcore.NewQuery({"
		SELECT
			id,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), adminckey),
			text,
			timestamp,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = lasteditor), lasteditor)
		FROM [format_table_name("messages")]
		WHERE type = :type
		AND deleted = 0
		AND (expire_timestamp > NOW() OR expire_timestamp IS NULL)
		AND (type = 'memo' OR targetckey = :targetckey)
		[after_timestamp? "AND timestamp > :after_timestamp": ""]
		[!show_secret? "AND secret = 0": ""]
	"}, parameters)
	if(!query_get_message_output.warn_execute())
		qdel(query_get_message_output)
		return
	var/list/datum/admin_message/messages = list()
	while(query_get_message_output.NextRow())
		var/datum/admin_message/message = new()
		message.id = query_get_message_output.item[1]
		message.admin_key = query_get_message_output.item[2]
		message.text = query_get_message_output.item[3]
		message.timestamp = query_get_message_output.item[4]
		message.editor_key = query_get_message_output.item[5]
		messages += message
	qdel(query_get_message_output)
	if(!length(messages))
		return
	return messages

/proc/display_admin_messages(client/display_to)
	var/list/text = list()
	for(var/datum/admin_message/message in get_message_output("message", display_to.ckey))
		text += "<font color='[COLOR_RED]' size='3'><b>由 [span_prefix("[message.admin_key]")] 于 [message.timestamp] 留下的管理员留言</b></font>"
		text += "<br><font color='[COLOR_RED]'>[message.text] <A href='byond://?messageread=[message.id]'>（点击此处确认你已阅读此留言）</A></font><br>"
	if(length(text))
		to_chat(display_to, text.Join())

/proc/display_unread_notes(client/display_to, show_after)
	var/list/text = list()
	for(var/datum/admin_message/message in get_message_output("note", display_to.ckey, FALSE, show_after))
		text += "<font color='[COLOR_RED]' size='3'><b>由 [span_prefix("[message.admin_key]")] 于 [message.timestamp] 留下的备注</b></font>"
		text += "<br><font color='[COLOR_RED]'>[message.text]</font><br>"
	if(length(text))
		to_chat(display_to, text.Join())

/proc/display_admin_memos(client/display_to)
	var/list/text = list()
	for(var/datum/admin_message/message in get_message_output("memo", display_to.ckey))
		text += "[span_memo("备忘录，作者 <span class='prefix'>[message.admin_key]")] 于 [message.timestamp]"
		if(message.editor_key)
			text += "<br>[span_memoedit("最后编辑者 [message.editor_key] <A href='byond://?_src_=holder;[HrefToken()];messageedits=[message.id]'>（点击此处查看编辑日志）</A>")]"
		text += "<br>[message.text]</span><br>"
	if(length(text))
		to_chat(display_to, text.Join())

/proc/scream_about_watchlists(client/read_from)
	for(var/datum/admin_message/message in get_message_output("watchlist entry", read_from.ckey))
		message_admins("<font color='[COLOR_RED]'><B>注意：</B></font><font color='[COLOR_ADMIN_PINK]'>[key_name_admin(read_from.ckey)] 自 [message.timestamp] 起就在观察名单上，且刚刚连接——原因：[message.text]</font>")
		send2tgs_adminless_only("Watchlist", "[key_name(read_from.ckey)] 在观察名单上，且刚刚连接——原因：[message.text]")

#define NOTESFILE "data/player_notes.sav"
//if the AUTOCONVERT_NOTES is turned on, anytime a player connects this will be run to try and add all their notes to the databas
/proc/convert_notes_sql(ckey)
	if(!fexists(NOTESFILE))
		return

	var/savefile/notesfile = new(NOTESFILE)
	if(!notesfile)
		log_game("Error: Cannot access [NOTESFILE]")
		return
	notesfile.cd = "/[ckey]"
	while(!notesfile.eof)
		var/notetext
		notesfile >> notetext
		var/server
		var/ssqlname = CONFIG_GET(string/serversqlname)
		if (ssqlname)
			server = ssqlname
		var/regex/note = new("^(\\d{2}-\\w{3}-\\d{4}) \\| (.+) ~(\\w+)$", "i")
		note.Find(notetext)
		var/timestamp = note.group[1]
		notetext = note.group[2]
		var/admin_ckey = note.group[3]
		var/datum/db_query/query_convert_time = SSdbcore.NewQuery("SELECT ADDTIME(STR_TO_DATE(:timestamp,'%d-%b-%Y'), '0')", list("timestamp" = timestamp))
		if(!query_convert_time.Execute())
			qdel(query_convert_time)
			return
		if(query_convert_time.NextRow())
			timestamp = query_convert_time.item[1]
		qdel(query_convert_time)
		if(ckey && notetext && timestamp && admin_ckey && server)
			create_message("note", ckey, admin_ckey, notetext, timestamp, server, 1, 0, null, 0, 0)
	notesfile.cd = "/"
	notesfile.dir.Remove(ckey)

#undef NOTESFILE
