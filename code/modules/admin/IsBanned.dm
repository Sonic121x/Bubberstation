//Blocks an attempt to connect before even creating our client datum thing.

//How many new ckey matches before we revert the stickyban to its roundstart state
//These are exclusive, so once it goes over one of these numbers, it reverts the ban
#define STICKYBAN_MAX_MATCHES 15
#define STICKYBAN_MAX_EXISTING_USER_MATCHES 3 //ie, users who were connected before the ban triggered
#define STICKYBAN_MAX_ADMIN_MATCHES 1

/world/IsBanned(key, address, computer_id, type, real_bans_only=FALSE)
	debug_world_log("isbanned(): '[args.Join("', '")]'")
	if (!key || (!real_bans_only && (!address || !computer_id)))
		if(real_bans_only)
			return FALSE
		log_access("登录失败（数据无效）：[key] [address]-[computer_id]")
		return list("reason"="invalid login data", "desc"="错误：无法检查封禁状态，请重试。错误信息：你的计算机在连接时向服务器提供了无效或空白的信息（byond 用户名、IP 和计算机 ID）。供参考的信息：用户名：'[key]' IP：'[address]' 计算机 ID：'[computer_id]'。（如果持续遇到此错误，请重启 byond 或联系 byond 客服。）")

	if (type == "world")
		return ..() //shunt world topic banchecks to purely to byond's internal ban system

	var/admin = FALSE
	var/ckey = ckey(key)

	var/client/C = GLOB.directory[ckey]
	if (C && ckey == C.ckey && computer_id == C.computer_id && address == C.address)
		return //don't recheck connected clients.

	//IsBanned can get re-called on a user in certain situations, this prevents that leading to repeated messages to admins.
	var/static/list/checkedckeys = list()
	//magic voodo to check for a key in a list while also adding that key to the list without having to do two associated lookups
	var/message = !checkedckeys[ckey]++

	if(GLOB.admin_datums[ckey] || GLOB.deadmins[ckey])
		admin = TRUE

	/* SKYRAT EDIT REMOVAL START - We have the panic bunker on 24/7, this just makes our method unusable.
	if(!real_bans_only && !admin && CONFIG_GET(flag/panic_bunker) && !CONFIG_GET(flag/panic_bunker_interview))
		var/datum/db_query/query_client_in_db = SSdbcore.NewQuery(
			"SELECT 1 FROM [format_table_name("player")] WHERE ckey = :ckey",
			list("ckey" = ckey)
		)
		if(!query_client_in_db.Execute())
			qdel(query_client_in_db)
			return

		var/client_is_in_db = query_client_in_db.NextRow()
		if(!client_is_in_db)
			var/reject_message = "Failed Login: [ckey] [address]-[computer_id] - New Account attempting to connect during panic bunker, but was rejected due to no prior connections to game servers (no database entry)"
			log_access(reject_message)
			if (message)
				message_admins(span_adminnotice("[reject_message]"))
			qdel(query_client_in_db)
			return list("reason"="panicbunker", "desc" = "Sorry but the server is currently not accepting connections from never before seen players")

		qdel(query_client_in_db)
	*/ // SKYRAT EDIT REMOVAL END

	//Whitelist
	if(!real_bans_only && !C && CONFIG_GET(flag/usewhitelist))
		if(!check_whitelist(ckey))
			if (admin)
				log_admin("管理员 [ckey] 已被允许绕过白名单")
				if (message)
					message_admins(span_adminnotice("管理员 [ckey] 已被允许绕过白名单"))
					addclientmessage(ckey,span_adminnotice("你已被允许绕过白名单"))
			else
				log_access("登录失败：[ckey] - 不在白名单中")
				return list("reason"="whitelist", "desc" = "\n原因：你不在该服务器的白名单中")

	//Guest Checking
	if(!real_bans_only && !C && is_guest_key(key))
		if (CONFIG_GET(flag/guest_ban))
			log_access("登录失败：[ckey] - 不允许访客登录")
			return list("reason"="guest", "desc"="\n原因：不允许访客登录。请使用 byond 账号登录。")
		if (CONFIG_GET(flag/panic_bunker) && SSdbcore.Connect())
			log_access("登录失败：[ckey] - 恐慌掩体期间不允许访客登录")
			return list("reason"="guest", "desc"="\n原因：抱歉，服务器目前不接受从未见过的玩家或访客连接。如果你曾使用 byond 账号在本服务器游玩过，请登录你曾使用的 byond 账号。")

	//Population Cap Checking
	var/extreme_popcap = CONFIG_GET(number/extreme_popcap)
	if(!real_bans_only && !C && extreme_popcap && !admin)
		var/popcap_value = GLOB.clients.len
		if(popcap_value >= extreme_popcap && !GLOB.joined_player_list.Find(ckey))
			if(!CONFIG_GET(flag/byond_member_bypass_popcap) || !world.IsSubscribed(ckey, "BYOND"))
				log_access("登录失败：[ckey] - 已达人口上限")
				return list("reason"="popcap", "desc"= "\n原因：[CONFIG_GET(string/extreme_popcap_message)]")

	if(CONFIG_GET(flag/sql_enabled))
		if(!SSdbcore.Connect())
			var/msg = "封禁数据库连接失败。未检查键 [ckey]"
			log_world(msg)
			if (message)
				message_admins(msg)
		else
			var/list/ban_details = is_banned_from_with_details(ckey, address, computer_id, "Server")
			for(var/i in ban_details)
				if(admin)
					if(text2num(i["applies_to_admins"]))
						var/msg = "管理员 [ckey] 已被管理员封禁，已拒绝其访问。"
						log_admin(msg)
						if (message)
							message_admins(msg)
					else
						var/msg = "管理员 [ckey] 已被允许绕过对 [ckey(i["key"])] [i["ip"]]-[i["computerid"]] 的匹配非管理员封禁。"
						log_admin(msg)
						if (message)
							message_admins(msg)
							addclientmessage(ckey,span_adminnotice("管理员 [ckey] 已被允许绕过对 [i["key"]] [i["ip"]]-[i["computerid"]] 的匹配非管理员封禁。"))
						continue
				var/expires = "这是永久封禁。"
				var/global_ban = "这是来自我们所有服务器的全球封禁。" //SKYRAT EDIT ADDITION - MULTISERVER
				if(i["expiration_time"])
					expires = " 该封禁为期 [DisplayTimeText(text2num(i["duration"]) MINUTES)]，将于 [i["expiration_time"]]（服务器时间）到期。"
				if(!text2num(i["global_ban"])) //SKYRAT EDIT ADDITION - MULTISERVER
					global_ban = "这是单服务器封禁，仅适用于 [i["server_name"]]。" //SKYRAT EDIT ADDITION - MULTISERVER
				var/desc = /* SKYRAT EDIT CHANGE - MULTISERVER */ {"你或该计算机/连接的另一位用户（[i["key"]]）已被禁止在此游玩。
				封禁原因为：[i["reason"]]
				本次封禁（BanID #[i["id"]]）由 [i["admin_key"]] 于 [i["bantime"]] 在回合 ID [i["round_id"]] 期间施加。
				[global_ban]
				[expires]"}
				log_suspicious_login("登录失败：[ckey] [computer_id] [address] - 已封禁（#[i["id"]]）[text2num(i["global_ban"]) ? "全球" : "本地"]") //SKYRAT EDIT CHANGE - MULTISERVER
				return list("reason"="Banned","desc"="[desc]")
	if (admin)
		if (GLOB.directory[ckey])
			return

		//oh boy, so basically, because of a bug in byond, sometimes stickyban matches don't trigger here, so we can't exempt admins.
		// Whitelisting the ckey with the byond whitelist field doesn't work.
		// So we instead have to remove every stickyban than later re-add them.
		if (!length(GLOB.stickybanadminexemptions))
			for (var/banned_ckey in world.GetConfig("ban"))
				GLOB.stickybanadmintexts[banned_ckey] = world.GetConfig("ban", banned_ckey)
				world.SetConfig("ban", banned_ckey, null)
		if (!SSstickyban.initialized)
			return
		GLOB.stickybanadminexemptions[ckey] = world.time
		stoplag() // sleep a byond tick
		GLOB.stickbanadminexemptiontimerid = addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(restore_stickybans)), 5 SECONDS, TIMER_STOPPABLE|TIMER_UNIQUE|TIMER_OVERRIDE)
		return

	var/list/ban = ..() //default pager ban stuff

	if (ban)
		if (!admin)
			. = ban
		if (real_bans_only)
			return
		var/bannedckey = "ERROR"
		if (ban["ckey"])
			bannedckey = ban["ckey"]

		var/newmatch = FALSE
		var/list/cachedban = SSstickyban.cache[bannedckey]
		//rogue ban in the process of being reverted.
		if (cachedban && (cachedban["reverting"] || cachedban["timeout"]))
			world.SetConfig("ban", bannedckey, null)
			return null

		if (cachedban && ckey != bannedckey)
			newmatch = TRUE
			if (cachedban["keys"])
				if (cachedban["keys"][ckey])
					newmatch = FALSE
			if (cachedban["matches_this_round"][ckey])
				newmatch = FALSE

		if (newmatch && cachedban)
			var/list/newmatches = cachedban["matches_this_round"]
			var/list/pendingmatches = cachedban["matches_this_round"]
			var/list/newmatches_connected = cachedban["existing_user_matches_this_round"]
			var/list/newmatches_admin = cachedban["admin_matches_this_round"]

			if (C)
				newmatches_connected[ckey] = ckey
				newmatches_connected = cachedban["existing_user_matches_this_round"]
				pendingmatches[ckey] = ckey
				sleep(STICKYBAN_ROGUE_CHECK_TIME)
				pendingmatches -= ckey
			if (admin)
				newmatches_admin[ckey] = ckey

			if (cachedban["reverting"] || cachedban["timeout"])
				return null

			newmatches[ckey] = ckey


			if (\
				newmatches.len+pendingmatches.len > STICKYBAN_MAX_MATCHES || \
				newmatches_connected.len > STICKYBAN_MAX_EXISTING_USER_MATCHES || \
				newmatches_admin.len > STICKYBAN_MAX_ADMIN_MATCHES \
			)

				var/action
				if (ban["fromdb"])
					cachedban["timeout"] = TRUE
					action = "将其在本回合剩余时间内置于超时状态"
				else
					cachedban["reverting"] = TRUE
					action = "将其恢复至回始状态"

				world.SetConfig("ban", bannedckey, null)

				//we always report this
				log_game("检测到针对 [bannedckey] 的粘性封禁异常，[action]")
				message_admins("检测到针对 [bannedckey] 的粘性封禁异常，[action]")
				//do not convert to timer.
				spawn (5)
					world.SetConfig("ban", bannedckey, null)
					sleep(1 TICKS)
					world.SetConfig("ban", bannedckey, null)
					if (!ban["fromdb"])
						cachedban = cachedban.Copy() //so old references to the list still see the ban as reverting
						cachedban["matches_this_round"] = list()
						cachedban["existing_user_matches_this_round"] = list()
						cachedban["admin_matches_this_round"] = list()
						cachedban -= "reverting"
						SSstickyban.cache[bannedckey] = cachedban
						world.SetConfig("ban", bannedckey, list2stickyban(cachedban))
				return null

		if (ban["fromdb"])
			if(SSdbcore.Connect())
				INVOKE_ASYNC(SSdbcore, TYPE_PROC_REF(/datum/controller/subsystem/dbcore, QuerySelect), list(
					SSdbcore.NewQuery(
						"INSERT INTO [format_table_name("stickyban_matched_ckey")] (matched_ckey, stickyban) VALUES (:ckey, :bannedckey) ON DUPLICATE KEY UPDATE last_matched = now()",
						list("ckey" = ckey, "bannedckey" = bannedckey)
					),
					SSdbcore.NewQuery(
						"INSERT INTO [format_table_name("stickyban_matched_ip")] (matched_ip, stickyban) VALUES (INET_ATON(:address), :bannedckey) ON DUPLICATE KEY UPDATE last_matched = now()",
						list("address" = address, "bannedckey" = bannedckey)
					),
					SSdbcore.NewQuery(
						"INSERT INTO [format_table_name("stickyban_matched_cid")] (matched_cid, stickyban) VALUES (:computer_id, :bannedckey) ON DUPLICATE KEY UPDATE last_matched = now()",
						list("computer_id" = computer_id, "bannedckey" = bannedckey)
					)
				), FALSE, TRUE)


		//byond will not trigger isbanned() for "global" host bans,
		//ie, ones where the "apply to this game only" checkbox is not checked (defaults to not checked)
		//So it's safe to let admins walk thru host/sticky bans here
		if (admin)
			log_admin("管理员 [ckey] 已被允许绕过对 [bannedckey] 的匹配主机/粘性封禁")
			if (message)
				message_admins(span_adminnotice("管理员 [ckey] 已被允许绕过对 [bannedckey] 的匹配主机/粘性封禁"))
				addclientmessage(ckey,span_adminnotice("你已被允许绕过对 [bannedckey] 的匹配主机/粘性封禁"))
			return null

		if (C) //user is already connected!.
			to_chat(C, span_redtext("你在连接后匹配到粘性封禁，即将被断开连接。如果这实际上是封禁规避检测系统失控所致，我们会自动检测并撤销这些匹配。如果你认为属于这种情况，请恰好等待 6 秒，然后使用 文件 -> 重新连接 重连，以确认该匹配是否已被自动撤销。"), confidential = TRUE)

		var/desc = "\n原因：（粘性封禁）你或该计算机/连接的另一位用户（[bannedckey]）已被禁止在此游玩。封禁原因为：\n[ban["message"]]\n本次封禁由 [ban["admin"]] 施加\n这是封禁规避检测系统施加的封禁，如果你认为此封禁有误，请恰好等待 6 秒后重试，然后再提交申诉。\n"
		. = list("reason" = "Stickyban", "desc" = desc)
		log_suspicious_login("登录失败：[ckey] [computer_id] [address] - 粘性封禁 [ban["message"]] 目标用户名：[bannedckey] 施加者：[ban["admin"]]")

	return .

/proc/restore_stickybans()
	for (var/banned_ckey in GLOB.stickybanadmintexts)
		world.SetConfig("ban", banned_ckey, GLOB.stickybanadmintexts[banned_ckey])
	GLOB.stickybanadminexemptions = list()
	GLOB.stickybanadmintexts = list()
	if (GLOB.stickbanadminexemptiontimerid)
		deltimer(GLOB.stickbanadminexemptiontimerid)
	GLOB.stickbanadminexemptiontimerid = null

#undef STICKYBAN_MAX_MATCHES
#undef STICKYBAN_MAX_EXISTING_USER_MATCHES
#undef STICKYBAN_MAX_ADMIN_MATCHES
