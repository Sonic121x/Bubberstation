///Gets the centcom bans of the given ckey.
/datum/admins/proc/open_centcom_bans(ckey)
	if(!check_rights(R_ADMIN))
		return

	if(!CONFIG_GET(string/centcom_ban_db))
		to_chat(usr, span_warning("中央指挥部银河封禁数据库已禁用！"))
		return

	// Make the request
	var/datum/http_request/request = new()
	request.prepare(RUSTG_HTTP_METHOD_GET, "[CONFIG_GET(string/centcom_ban_db)]/[ckey]", "", "")
	request.begin_async()
	UNTIL(request.is_complete() || !usr)
	if (!usr)
		return
	var/datum/http_response/response = request.into_response()

	var/list/bans

	var/list/dat = list("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><body>")

	if(response.errored)
		dat += "<br>无法连接至中央指挥部。"
	else if(response.status_code != 200)
		dat += "<br>无法连接至中央指挥部。状态码：[response.status_code]"
	else
		if(response.body == "\[]")
			dat += "<center><b>未检测到 [ckey] 的封禁记录</b></center>"
		else
			bans = json_decode(response.body)

			//Ignore bans from non-whitelisted sources, if a whitelist exists
			var/list/valid_sources
			if(CONFIG_GET(string/centcom_source_whitelist))
				valid_sources = splittext(CONFIG_GET(string/centcom_source_whitelist), ",")
				dat += "<center><b>检测到 [ckey] 的封禁记录</b></center>"
			else
				//Ban count is potentially inaccurate if they're using a whitelist
				dat += "<center><b>检测到 [bans.len] 条 [ckey] 的封禁记录</b></center>"

			for(var/list/ban in bans)
				if(valid_sources && !(ban["sourceName"] in valid_sources))
					continue
				dat += "<b>服务器：</b> [sanitize(ban["sourceName"])]<br>"
				dat += "<b>RP 等级：</b> [sanitize(ban["sourceRoleplayLevel"])]<br>"
				dat += "<b>类型：</b> [sanitize(ban["type"])]<br>"
				dat += "<b>封禁者：</b> [sanitize(ban["bannedBy"])]<br>"
				dat += "<b>原因：</b> [sanitize(ban["reason"])]<br>"
				dat += "<b>时间：</b> [sanitize(ban["bannedOn"])]<br>"
				var/expiration = ban["expires"]
				dat += "<b>到期：</b> [expiration ? "[sanitize(expiration)]" : "永久"]<br>"
				if(ban["type"] == "job")
					dat += "<b>职业：</b> "
					var/list/jobs = ban["jobs"]
					dat += sanitize(jobs.Join(", "))
					dat += "<br>"
				dat += "<hr>"

	dat += "<br></body>"
	var/datum/browser/popup = new(usr, "centcomlookup-[ckey]", "<div align='center'>中央指挥部银河封禁数据库</div>", 700, 600)
	popup.set_content(dat.Join())
	popup.open(0)

///Returns the amount of permabans they have on centcom.
/datum/admins/proc/check_centcom_permabans(ckey)
	if(!check_rights(R_ADMIN))
		return

	if(!CONFIG_GET(string/centcom_ban_db))
		to_chat(usr, span_warning("中央指挥部银河封禁数据库已禁用！"))
		return

	// Make the request
	var/datum/http_request/request = new()
	request.prepare(RUSTG_HTTP_METHOD_GET, "[CONFIG_GET(string/centcom_ban_db)]/[ckey]", "", "")
	request.begin_async()
	UNTIL(request.is_complete() || !usr)
	if (!usr)
		return
	var/datum/http_response/response = request.into_response()

	var/list/bans
	var/total_permabans

	if(response.body == "\[]")
		return
	bans = json_decode(response.body)
	//Ignore bans from non-whitelisted sources, if a whitelist exists
	var/list/valid_sources
	if(CONFIG_GET(string/centcom_source_whitelist))
		valid_sources = splittext(CONFIG_GET(string/centcom_source_whitelist), ",")

	for(var/list/ban in bans)
		if(valid_sources && !(ban["sourceName"] in valid_sources))
			continue
		if(!ban["expires"] && (sanitize(ban["type"]) == "Server")) //server permabans only
			total_permabans++

	return total_permabans
