/datum/admins/proc/stickyban(action,data)
	if(!check_rights(R_BAN))
		return
	switch (action)
		if ("show")
			stickyban_show()
		if ("add")
			var/list/ban = list()
			var/ckey
			ban["admin"] = usr.ckey
			ban["type"] = list("sticky")
			ban["reason"] = "(InGameBan)([usr.key])" //this will be displayed in dd only

			if (data["ckey"])
				ckey = ckey(data["ckey"])
			else
				ckey = input(usr,"Ckey","Ckey","") as text|null
				if (!ckey)
					return
				ckey = ckey(ckey)
			ban["ckey"] = ckey

			if (get_stickyban_from_ckey(ckey))
				to_chat(usr, span_adminnotice("错误：无法添加粘性封禁：该用户当前已有粘性封禁"), confidential = TRUE)
				return

			if (data["reason"])
				ban["message"] = data["reason"]
			else
				var/reason = input(usr,"原因","原因","规避封禁") as text|null
				if (!reason)
					return
				ban["message"] = "[reason]"

			if(SSdbcore.Connect())
				var/datum/db_query/query_create_stickyban = SSdbcore.NewQuery({"
					INSERT INTO [format_table_name("stickyban")] (ckey, reason, banning_admin)
					VALUES (:ckey, :message, :banning_admin)
				"}, list("ckey" = ckey, "message" = ban["message"], "banning_admin" = usr.ckey))
				if (query_create_stickyban.warn_execute())
					ban["fromdb"] = TRUE
				qdel(query_create_stickyban)

			world.SetConfig("ban",ckey,list2stickyban(ban))
			ban = stickyban2list(list2stickyban(ban))
			ban["matches_this_round"] = list()
			ban["existing_user_matches_this_round"] = list()
			ban["admin_matches_this_round"] = list()
			ban["pending_matches_this_round"] = list()
			SSstickyban.cache[ckey] = ban

			log_admin_private("[key_name(usr)] 已对 [ckey] 施加粘性封禁。\n原因：[ban["message"]]")
			message_admins(span_adminnotice("[key_name_admin(usr)] 已对 [ckey] 施加粘性封禁。\n原因：[ban["message"]]"))

		if ("remove")
			if (!data["ckey"])
				return
			var/ckey = data["ckey"]

			var/ban = get_stickyban_from_ckey(ckey)
			if (!ban)
				to_chat(usr, span_adminnotice("错误：未找到 [ckey] 的粘性封禁！"), confidential = TRUE)
				return
			if (tgui_alert(usr,"确定要移除 [ckey] 的粘性封禁吗？","确认",list("Yes","No")) == "No")
				return
			if (!get_stickyban_from_ckey(ckey))
				to_chat(usr, span_adminnotice("错误：该封禁消失了。"), confidential = TRUE)
				return
			world.SetConfig("ban",ckey, null)
			SSstickyban.cache -= ckey

			if (SSdbcore.Connect())
				SSdbcore.QuerySelect(list(
					SSdbcore.NewQuery("DELETE FROM [format_table_name("stickyban")] WHERE ckey = :ckey", list("ckey" = ckey)),
					SSdbcore.NewQuery("DELETE FROM [format_table_name("stickyban_matched_ckey")] WHERE stickyban = :ckey", list("ckey" = ckey)),
					SSdbcore.NewQuery("DELETE FROM [format_table_name("stickyban_matched_cid")] WHERE stickyban = :ckey", list("ckey" = ckey)),
					SSdbcore.NewQuery("DELETE FROM [format_table_name("stickyban_matched_ip")] WHERE stickyban = :ckey", list("ckey" = ckey))
				), warn = TRUE, qdel = TRUE)


			log_admin_private("[key_name(usr)] 已移除 [ckey] 的粘性封禁")
			message_admins(span_adminnotice("[key_name_admin(usr)] 已移除 [ckey] 的粘性封禁"))

		if ("remove_alt")
			if (!data["ckey"])
				return
			var/ckey = data["ckey"]
			if (!data["alt"])
				return
			var/alt = ckey(data["alt"])
			var/ban = get_stickyban_from_ckey(ckey)
			if (!ban)
				to_chat(usr, span_adminnotice("错误：未找到 [ckey] 的粘性封禁！"), confidential = TRUE)
				return

			var/key = LAZYACCESS(ban["keys"], alt)
			if (!key)
				to_chat(usr, span_adminnotice("错误：[alt] 未与 [ckey] 的粘性封禁关联！"), confidential = TRUE)
				return

			if (tgui_alert(usr,"确定要解除 [alt] 与 [ckey] 粘性封禁的关联吗？\n注意：没有什么能阻止 byond 重新将它们关联起来，可使用 \[E] 将其豁免","确认",list("Yes","No")) == "No")
				return

			//we have to do this again incase something changes
			ban = get_stickyban_from_ckey(ckey)
			if (!ban)
				to_chat(usr, span_adminnotice("错误：该封禁消失了。"), confidential = TRUE)
				return

			key = LAZYACCESS(ban["keys"], alt)

			if (!key)
				to_chat(usr, span_adminnotice("错误：[alt] 与 [ckey] 粘性封禁的关联消失了。"), confidential = TRUE)
				return

			LAZYREMOVE(ban["keys"], alt)
			world.SetConfig("ban",ckey,list2stickyban(ban))

			SSstickyban.cache[ckey] = ban

			if (SSdbcore.Connect())
				var/datum/db_query/query_remove_stickyban_alt = SSdbcore.NewQuery(
					"DELETE FROM [format_table_name("stickyban_matched_ckey")] WHERE stickyban = :ckey AND matched_ckey = :alt",
					list("ckey" = ckey, "alt" = alt)
				)
				query_remove_stickyban_alt.warn_execute()
				QDEL_NULL(query_remove_stickyban_alt)

			log_admin_private("[key_name(usr)] 已解除 [alt] 与 [ckey] 粘性封禁的关联")
			message_admins(span_adminnotice("[key_name_admin(usr)] 已解除 [alt] 与 [ckey] 粘性封禁的关联"))

		if ("edit")
			if (!data["ckey"])
				return
			var/ckey = data["ckey"]
			var/ban = get_stickyban_from_ckey(ckey)
			if (!ban)
				to_chat(usr, span_adminnotice("错误：未找到 [ckey] 的粘性封禁！"), confidential = TRUE)
				return
			var/oldreason = ban["message"]
			var/reason = input(usr,"原因","原因","[ban["message"]]") as text|null
			if (!reason || reason == oldreason)
				return
			//we have to do this again incase something changed while we waited for input
			ban = get_stickyban_from_ckey(ckey)
			if (!ban)
				to_chat(usr, span_adminnotice("错误：该封禁消失了。"), confidential = TRUE)
				return
			ban["message"] = "[reason]"

			world.SetConfig("ban",ckey,list2stickyban(ban))

			SSstickyban.cache[ckey] = ban

			if (SSdbcore.Connect())
				var/datum/db_query/query_edit_stickyban = SSdbcore.NewQuery(
					"UPDATE [format_table_name("stickyban")] SET reason = :reason WHERE ckey = :ckey",
					list("reason" = reason, "ckey" = ckey)
				)
				query_edit_stickyban.warn_execute()
				QDEL_NULL(query_edit_stickyban)

			log_admin_private("[key_name(usr)] 已将 [ckey] 的粘性封禁原因从 [oldreason] 修改为 [reason]")
			message_admins(span_adminnotice("[key_name_admin(usr)] 已将 [ckey] 的粘性封禁原因从 [oldreason] 修改为 [reason]"))

		if ("exempt")
			if (!data["ckey"])
				return
			var/ckey = data["ckey"]
			if (!data["alt"])
				return
			var/alt = ckey(data["alt"])
			var/ban = get_stickyban_from_ckey(ckey)
			if (!ban)
				to_chat(usr, span_adminnotice("错误：未找到 [ckey] 的粘性封禁！"), confidential = TRUE)
				return

			var/key = LAZYACCESS(ban["keys"], alt)
			if (!key)
				to_chat(usr, span_adminnotice("错误：[alt] 未与 [ckey] 的粘性封禁关联！"), confidential = TRUE)
				return

			if (tgui_alert(usr,"确定要将 [alt] 从 [ckey] 的粘性封禁中豁免吗？","确认",list("Yes","No")) == "No")
				return

			//we have to do this again incase something changes
			ban = get_stickyban_from_ckey(ckey)
			if (!ban)
				to_chat(usr, span_adminnotice("错误：该封禁消失了。"), confidential = TRUE)
				return

			key = LAZYACCESS(ban["keys"], alt)

			if (!key)
				to_chat(usr, span_adminnotice("错误：[alt] 与 [ckey] 粘性封禁的关联消失了。"), confidential = TRUE)
				return
			LAZYREMOVE(ban["keys"], alt)
			key["exempt"] = TRUE
			LAZYSET(ban["whitelist"], alt, key)

			world.SetConfig("ban",ckey,list2stickyban(ban))

			SSstickyban.cache[ckey] = ban

			if (SSdbcore.Connect())
				var/datum/db_query/query_exempt_stickyban_alt = SSdbcore.NewQuery(
					"UPDATE [format_table_name("stickyban_matched_ckey")] SET exempt = 1 WHERE stickyban = :ckey AND matched_ckey = :alt",
					list("ckey" = ckey, "alt" = alt)
				)
				query_exempt_stickyban_alt.warn_execute()
				QDEL_NULL(query_exempt_stickyban_alt)

			log_admin_private("[key_name(usr)] 已豁免 [alt]，使其不受 [ckey] 的粘性封禁影响")
			message_admins(span_adminnotice("[key_name_admin(usr)] 已豁免 [alt]，使其不受 [ckey] 的粘性封禁影响"))

		if ("unexempt")
			if (!data["ckey"])
				return
			var/ckey = data["ckey"]
			if (!data["alt"])
				return
			var/alt = ckey(data["alt"])
			var/ban = get_stickyban_from_ckey(ckey)
			if (!ban)
				to_chat(usr, span_adminnotice("错误：未找到 [ckey] 的粘性封禁！"), confidential = TRUE)
				return

			var/key = LAZYACCESS(ban["whitelist"], alt)
			if (!key)
				to_chat(usr, span_adminnotice("错误：[alt] 并未从 [ckey] 的粘性封禁中获得豁免！"), confidential = TRUE)
				return

			if (tgui_alert(usr,"确定要取消 [alt] 在 [ckey] 粘性封禁中的豁免吗？","确认",list("Yes","No")) == "No")
				return

			//we have to do this again incase something changes
			ban = get_stickyban_from_ckey(ckey)
			if (!ban)
				to_chat(usr, span_adminnotice("错误：该封禁消失了。"), confidential = TRUE)
				return

			key = LAZYACCESS(ban["whitelist"], alt)
			if (!key)
				to_chat(usr, span_adminnotice("错误：[alt] 对 [ckey] 粘性封禁的豁免消失了。"), confidential = TRUE)
				return

			LAZYREMOVE(ban["whitelist"], alt)
			key["exempt"] = FALSE
			LAZYSET(ban["keys"], alt, key)

			world.SetConfig("ban",ckey,list2stickyban(ban))

			SSstickyban.cache[ckey] = ban

			if (SSdbcore.Connect())
				var/datum/db_query/query_unexempt_stickyban_alt = SSdbcore.NewQuery(
					"UPDATE [format_table_name("stickyban_matched_ckey")] SET exempt = 0 WHERE stickyban = :ckey AND matched_ckey = :alt",
					list("ckey" = ckey, "alt" = alt)
				)
				query_unexempt_stickyban_alt.warn_execute()
				QDEL_NULL(query_unexempt_stickyban_alt)

			log_admin_private("[key_name(usr)] 已取消 [alt] 在 [ckey] 粘性封禁中的豁免")
			message_admins(span_adminnotice("[key_name_admin(usr)] 已取消 [alt] 在 [ckey] 粘性封禁中的豁免"))

		if ("timeout")
			if (!data["ckey"])
				return
			if (!SSdbcore.Connect())
				to_chat(usr, span_adminnotice("数据库未连接！"), confidential = TRUE)
				return

			var/ckey = data["ckey"]

			if (tgui_alert(usr,"确定要让 [ckey] 的粘性封禁进入超时状态，直到下一回合（或被移除）吗？","确认",list("Yes","No")) == "No")
				return
			var/ban = get_stickyban_from_ckey(ckey)
			if (!ban)
				to_chat(usr, span_adminnotice("错误：未找到 [ckey] 的粘性封禁！"), confidential = TRUE)
				return

			ban["timeout"] = TRUE

			world.SetConfig("ban", ckey, null)

			var/cachedban = SSstickyban.cache[ckey]
			if (cachedban)
				cachedban["timeout"] = TRUE

			log_admin_private("[key_name(usr)] 已将 [ckey] 的粘性封禁设为超时。")
			message_admins(span_adminnotice("[key_name_admin(usr)] 已将 [ckey] 的粘性封禁设为超时。"))

		if ("untimeout")
			if (!data["ckey"])
				return
			if (!SSdbcore.Connect())
				to_chat(usr, span_adminnotice("数据库未连接！"), confidential = TRUE)
				return
			var/ckey = data["ckey"]

			if (tgui_alert(usr,"确定要解除 [ckey] 粘性封禁的超时吗？","确认",list("Yes","No")) == "No")
				return

			var/ban = get_stickyban_from_ckey(ckey)
			var/cachedban = SSstickyban.cache[ckey]
			if (cachedban)
				cachedban["timeout"] = FALSE
			if (!ban)
				if (!cachedban)
					to_chat(usr, span_adminnotice("错误：未找到 [ckey] 的粘性封禁！"), confidential = TRUE)
					return
				ban = cachedban

			ban["timeout"] = FALSE

			world.SetConfig("ban",ckey,list2stickyban(ban))

			log_admin_private("[key_name(usr)] 已解除 [ckey] 粘性封禁的超时状态。")
			message_admins(span_adminnotice("[key_name_admin(usr)] 已解除 [ckey] 粘性封禁的超时状态。"))


		if ("revert")
			if (!data["ckey"])
				return
			var/ckey = data["ckey"]
			if (tgui_alert(usr,"确定要将 [ckey] 的粘性封禁恢复到回合开始（或上次编辑）时的状态吗？","确认",list("Yes","No")) == "No")
				return
			var/ban = get_stickyban_from_ckey(ckey)
			if (!ban)
				to_chat(usr, span_adminnotice("错误：未找到 [ckey] 的粘性封禁！"), confidential = TRUE)
				return
			var/cached_ban = SSstickyban.cache[ckey]
			if (!cached_ban)
				to_chat(usr, span_adminnotice("错误：未找到 [ckey] 的缓存的粘性封禁！"), confidential = TRUE)
			world.SetConfig("ban",ckey,null)

			log_admin_private("[key_name(usr)] 已将 [ckey] 的粘性封禁恢复到回合开始时的状态。")
			message_admins(span_adminnotice("[key_name_admin(usr)] 已将 [ckey] 的粘性封禁恢复到回合开始时的状态。"))
			//revert is mostly used when shit goes rouge, so we have to set it to null
			// and wait a byond tick before assigning it to ensure byond clears its shit.
			sleep(world.tick_lag)
			world.SetConfig("ban",ckey,list2stickyban(cached_ban))


/datum/admins/proc/stickyban_gethtml(ckey)
	var/ban = get_stickyban_from_ckey(ckey)
	if (!ban)
		return
	var/timeout
	if (SSdbcore.Connect())
		timeout = "<a href='byond://?_src_=holder;[HrefToken()];stickyban=[(ban["timeout"] ? "untimeout" : "timeout")]&ckey=[ckey]'>\[[(ban["timeout"] ? "untimeout" : "timeout" )]\]</a>"
	else
		timeout = "<a href='byond://?_src_=holder;[HrefToken()];stickyban=revert&ckey=[ckey]'>\[回退\]</a>"
	. = list({"
		<a href='byond://?_src_=holder;[HrefToken()];stickyban=remove&ckey=[ckey]'>\[-\]</a>
		[timeout]
		<b>[ckey]</b>
		<br />"
		[ban["message"]] <b><a href='byond://?_src_=holder;[HrefToken()];stickyban=edit&ckey=[ckey]'>\[编辑\]</a></b><br />
	"})
	if (ban["admin"])
		. += "[ban["admin"]]<br />"
	else
		. += "旧版记录<br />"
	. += "已捕获的账号<br />\n<ol>"
	for (var/key in ban["keys"])
		if (ckey(key) == ckey)
			continue
		. += "<li><a href='byond://?_src_=holder;[HrefToken()];stickyban=remove_alt&ckey=[ckey]&alt=[ckey(key)]'>\[-\]</a>[key]<a href='byond://?_src_=holder;[HrefToken()];stickyban=exempt&ckey=[ckey]&alt=[ckey(key)]'>\[E\]</a></li>"

	for (var/key in ban["whitelist"])
		if (ckey(key) == ckey)
			continue
		. += "<li><a href='byond://?_src_=holder;[HrefToken()];stickyban=remove_alt&ckey=[ckey]&alt=[ckey(key)]'>\[-\]</a>[key]<a href='byond://?_src_=holder;[HrefToken()];stickyban=unexempt&ckey=[ckey]&alt=[ckey(key)]'>\[UE\]</a></li>"

	. += "</ol>\n"

/datum/admins/proc/stickyban_show()
	if(!check_rights(R_BAN))
		return
	var/list/bans = sticky_banned_ckeys()
	var/list/banhtml = list()
	for(var/key in bans)
		var/ckey = ckey(key)
		banhtml += "<br /><hr />\n"
		banhtml += stickyban_gethtml(ckey)

	var/html = {"
	<head>
		<title>粘性封禁</title>
	</head>
	<body>
		<h2>全部粘性封禁：</h2> <a href='byond://?_src_=holder;[HrefToken()];stickyban=add'>\[+\]</a><br>
		[banhtml.Join("")]
	</body>
	"}
	usr << browse(html,"window=stickybans;size=700x400")

/proc/sticky_banned_ckeys()
	if (SSdbcore.Connect() || length(SSstickyban.dbcache))
		if (SSstickyban.dbcacheexpire < world.time)
			SSstickyban.Populatedbcache()
		if (SSstickyban.dbcacheexpire)
			return SSstickyban.dbcache.Copy()

	return sort_list(world.GetConfig("ban"))


/proc/get_stickyban_from_ckey(ckey)
	. = list()
	if (!ckey)
		return null
	if (SSdbcore.Connect() || length(SSstickyban.dbcache))
		if (SSstickyban.dbcacheexpire < world.time)
			SSstickyban.Populatedbcache()
		if (SSstickyban.dbcacheexpire)
			. = SSstickyban.dbcache[ckey]
			//reset the cache incase its a newer ban (but only if we didn't update the cache recently)
			if (!. && SSstickyban.dbcacheexpire != world.time+STICKYBAN_DB_CACHE_TIME)
				SSstickyban.dbcacheexpire = 1
				SSstickyban.Populatedbcache()
				. = SSstickyban.dbcache[ckey]
			if (.)
				var/list/cachedban = SSstickyban.cache["[ckey]"]
				if (cachedban)
					.["timeout"] = cachedban["timeout"]

				.["fromdb"] = TRUE
			return

	. = stickyban2list(world.GetConfig("ban", ckey)) || stickyban2list(world.GetConfig("ban", ckey(ckey))) || list()

	if (!length(.))
		return null

/proc/stickyban2list(ban, strictdb = TRUE)
	if (!ban)
		return null
	. = params2list(ban)
	if (.["keys"])
		var/keys = splittext(.["keys"], ",")
		var/ckeys = list()
		for (var/key in keys)
			var/ckey = ckey(key)
			ckeys[ckey] = ckey //to make searching faster.
		.["keys"] = ckeys
	if (.["whitelist"])
		var/keys = splittext(.["whitelist"], ",")
		var/ckeys = list()
		for (var/key in keys)
			var/ckey = ckey(key)
			ckeys[ckey] = ckey //to make searching faster.
		.["whitelist"] = ckeys
	.["type"] = splittext(.["type"], ",")
	.["IP"] = splittext(.["IP"], ",")
	.["computer_id"] = splittext(.["computer_id"], ",")
	. -= "fromdb"


/proc/list2stickyban(list/ban)
	if (!ban || !islist(ban))
		return null
	. = ban.Copy()
	if (.["keys"])
		.["keys"] = jointext(.["keys"], ",")
	if (.["IP"])
		.["IP"] = jointext(.["IP"], ",")
	if (.["computer_id"])
		.["computer_id"] = jointext(.["computer_id"], ",")
	if (.["whitelist"])
		.["whitelist"] = jointext(.["whitelist"], ",")
	if (.["type"])
		.["type"] = jointext(.["type"], ",")

	. -= "reverting"
	. -= "matches_this_round"
	. -= "existing_user_matches_this_round"
	. -= "admin_matches_this_round"
	. -= "pending_matches_this_round"


	. = list2params(.)

ADMIN_VERB(panel_sticky_ban, R_BAN, "粘性封禁面板", "列出并管理粘性封禁。", ADMIN_CATEGORY_MAIN)
	user.holder.stickyban_show()
