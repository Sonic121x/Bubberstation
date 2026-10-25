
ADMIN_VERB(edit_admin_permissions, R_PERMISSIONS, "权限面板", "编辑管理员权限。", ADMIN_CATEGORY_MAIN)
	user.holder.edit_admin_permissions(PERMISSIONS_PAGE_PERMISSIONS)

#define PERMISSIONS_LOGS_PER_PAGE 20
/// List of all the actions you have ever been able to take in admin logs, keep in parity with the
/// operation enum in the admin_log table
GLOBAL_LIST_INIT(permission_action_types, list(
	PERMISSIONS_ACTION_ADMIN_ADDED,
	PERMISSIONS_ACTION_ADMIN_REMOVED,
	PERMISSIONS_ACTION_ADMIN_RANK_CHANGED,
	PERMISSIONS_ACTION_RANK_ADDED,
	PERMISSIONS_ACTION_RANK_REMOVED,
	PERMISSIONS_ACTION_RANK_CHANGED,
	PERMISSIONS_ACTION_NONE
))

/datum/admins/proc/edit_admin_permissions(action, log_target, log_actor, log_operation, log_page)
	if(!check_rights(R_PERMISSIONS))
		return
	var/datum/asset/asset_cache_datum = get_asset_datum(/datum/asset/group/permissions)
	asset_cache_datum.send(usr)
	var/list/output = list("<link rel='stylesheet' type='text/css' href='[SSassets.transport.get_asset_url("panels.css")]'>")

	var/new_line = " | "
	if(action == PERMISSIONS_PAGE_PERMISSIONS)
		new_line = "<br>"

	output += {"
		<a href='byond://?_src_=holder;[HrefToken()];editrightsbrowser=1'>\
			[action == PERMISSIONS_PAGE_PERMISSIONS ? "<b>\[权限\]</b>": "\[权限\]"]
		</a>
		[new_line]<a href='byond://?_src_=holder;[HrefToken()];editrightsbrowserranks=1'>
			[action == PERMISSIONS_PAGE_RANKS ? "<b>\[等级\]</b>": "\[等级\]"]
		</a>
		[new_line]<a href='byond://?_src_=holder;[HrefToken()];editrightsbrowserlogging=1;editrightslogpage=0'>
			[action == PERMISSIONS_PAGE_LOGGING ? "<b>\[日志\]</b>": "\[日志\]"]
		</a>
		[new_line]<a href='byond://?_src_=holder;[HrefToken()];editrightsbrowserhousekeep=1'>
			[action == PERMISSIONS_PAGE_HOUSEKEEPING ? "<b>\[维护\]</b>": "\[维护\]"]
		</a>
	"}

	if(action != PERMISSIONS_PAGE_PERMISSIONS)
		output += "<hr style='background:#000000; border:0; height:3px'>"

	if(action == PERMISSIONS_PAGE_PERMISSIONS)
		output += {"
			<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<title>权限面板</title>
				<script type='text/javascript' src='[SSassets.transport.get_asset_url("search.js")]'></script>
			</head>
			<body onload='selectTextField();updateSearch();'>
				<div id='main'>
					<table id='searchable' cellspacing='0'>
					<tr class='title'>
						<th style='width:150px;'>CKEY <a class='small' href='byond://?src=[REF(src)];[HrefToken()];editrights=add'>\[+\]</a></th>
						<th style='width:125px;'>等级</th>
						<th>权限</th>
					</tr>
		"}
		for(var/admin_ckey in GLOB.admin_datums + GLOB.deadmins)
			var/datum/admins/admin_datum = GLOB.admin_datums[admin_ckey]
			if(!admin_datum)
				admin_datum = GLOB.deadmins[admin_ckey]
				if (!admin_datum)
					continue
			if(admin_datum.owner)
				admin_ckey = admin_datum.owner.key

			var/deadmin_link = ""
			if (admin_datum.deadmined)
				deadmin_link = "<a class='small' href='byond://?src=[REF(src)];[HrefToken()];editrights=activate;key=[admin_ckey]'>\[RA\]</a>"
			else
				deadmin_link = "<a class='small' href='byond://?src=[REF(src)];[HrefToken()];editrights=deactivate;key=[admin_ckey]'>\[DA\]</a>"

			var/verify_link = ""
			if (admin_datum.blocked_by_2fa)
				verify_link = "<a class='small' href='byond://?src=[REF(src)];[HrefToken()];editrights=verify;key=[admin_ckey]'>\[两步验证\]</a>"

			output += {"
				<tr>
					<td style='text-align:center;'>[admin_ckey]
						<br> [deadmin_link]
						<a class='small' href='byond://?src=[REF(src)];[HrefToken()];editrights=remove;key=[admin_ckey]'>\[-\]</a>
						<a class='small' href='byond://?src=[REF(src)];[HrefToken()];editrights=sync;key=[admin_ckey]'>\[同步 TGDB\]</a>
						[verify_link]
					</td>
					<td>
						<a href='byond://?src=[REF(src)];[HrefToken()];editrights=rank;key=[admin_ckey]'>[admin_datum.rank_names()]</a>
					</td>
					<td>
						<a class='small' href='byond://?src=[REF(src)];[HrefToken()];editrights=permissions;key=[admin_ckey]'>[rights2text(admin_datum.rank_flags(), " ")]</a>
					</td>
				</tr>
			"}
		output += {"
					</table>
				</div>
				<div id='top'>
					<b>搜索：</b>
					<input type='text' id='filter' value='' style='width:70%;' onkeyup='updateSearch();'>
				</div>
			</body>
		"}
	else if(action == PERMISSIONS_PAGE_RANKS)
		var/creation_meaningful = check_rights(R_PERMISSIONS) && usr.client.holder.can_edit_rights_flags() != NONE
		output += {"
			<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<title>权限面板</title>
			</head>
			[creation_meaningful ? "<a href='byond://?_src_=holder;[HrefToken()];editrightsbrowserranks=1;editrightsaddrank=1'>\[创建等级\]</a>" : ""]
			<hr style='background:#000000; border:0; height:3px'>
		"}
		// First we're gonna collect admins by rank, for sorting purposes
		var/datum/db_query/query_extract_admins = SSdbcore.NewQuery("SELECT IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE [format_table_name("player")].ckey = [format_table_name("admin")].ckey), ckey), [format_table_name("admin")].`rank` FROM [format_table_name("admin")]")
		if(!query_extract_admins.warn_execute())
			qdel(query_extract_admins)
			return
		var/list/admins_by_rank = list()
		while(query_extract_admins.NextRow())
			var/admin_key = query_extract_admins.item[1]
			var/admin_rank = query_extract_admins.item[2]
			for(var/datum/admin_rank/composed_rank as anything in ranks_from_rank_name(admin_rank))
				admins_by_rank[composed_rank.name] ||= list()
				admins_by_rank[composed_rank.name] |= list(admin_key)
		QDEL_NULL(query_extract_admins)

		for(var/stored_key in GLOB.admin_datums)
			var/datum/admins/live_holder = GLOB.admin_datums[stored_key]
			for(var/datum/admin_rank/composed_rank as anything in live_holder.ranks)
				admins_by_rank[composed_rank.name] ||= list()
				admins_by_rank[composed_rank.name] |= list(stored_key)

		// Then, pull the full list of DB ranks
		var/datum/db_query/query_extract_ranks = SSdbcore.NewQuery("SELECT `rank`, flags, exclude_flags, can_edit_flags FROM [format_table_name("admin_ranks")]")
		if(!query_extract_ranks.warn_execute())
			qdel(query_extract_ranks)
			return
		var/list/all_ranks = list()
		while(query_extract_ranks.NextRow())
			var/loaded_rank = query_extract_ranks.item[1]
			var/rank_flags = text2num(query_extract_ranks.item[2])
			var/rank_exclude_flags = text2num(query_extract_ranks.item[3])
			var/rank_can_edit_flags = text2num(query_extract_ranks.item[4])
			all_ranks[loaded_rank] = list("rank" = loaded_rank, "flags" = rank_flags, "exclude_flags" = rank_exclude_flags, "can_edit_flags" = rank_can_edit_flags)
		QDEL_NULL(query_extract_ranks)

		for(var/datum/admin_rank/rank as anything in GLOB.admin_ranks)
			// This does technically potentially mask local edits? to db ranks if that is even possible (should not be), but I prefer to be honest about longterm values.
			if(all_ranks[rank.name])
				continue
			all_ranks[rank.name] = list("rank" = rank.name, "flags" = rank.include_rights, "exclude_flags" = rank.exclude_rights, "can_edit_flags" = rank.can_edit_rights)

		sortTim(all_ranks, GLOBAL_PROC_REF(cmp_text_asc))
		for(var/rank_name in all_ranks)
			var/list/datum/admin_rank/rank_datums = ranks_from_rank_name(rank_name)
			if(!length(rank_datums))
				continue
			var/datum/admin_rank/rank_datum = rank_datums[1]

			var/list/rank_info = all_ranks[rank_name]
			var/permissions = rights2text(rank_info["flags"], seperator = " ", prefix = "+")
			var/denied_permissions = rights2text(rank_info["exclude_flags"], seperator = " ", prefix = "-")
			var/editing_permissions = rights2text(rank_info["can_edit_flags"], seperator = " ", prefix = "*")

			var/modify_might_be_allowed = FALSE
			var/delete_might_be_allowed = FALSE
			if((rank_datum.source == RANK_SOURCE_DB && check_rights(R_DBRANKS)) || rank_datum.source == RANK_SOURCE_TEMPORARY)
				modify_might_be_allowed = TRUE
				delete_might_be_allowed = TRUE
			if(length(admins_by_rank[rank_name]) != 0)
				delete_might_be_allowed = FALSE
			if((usr.client.holder.can_edit_rights_flags() & rank_datum.rights) != rank_datum.rights)
				modify_might_be_allowed = FALSE
				delete_might_be_allowed = FALSE

			output += {"
				<b>[rank_name]</b>
				[modify_might_be_allowed ? " | <a href='byond://?_src_=holder;[HrefToken()];editrightsbrowserranks=1;editrightseditrank=[rank_name]'>\[编辑\]</a>" : ""]
				[delete_might_be_allowed ? " | <a href='byond://?_src_=holder;[HrefToken()];editrightsbrowserranks=1;editrightsremoverank=[rank_name]'>\[删除\]</a>" : ""]
				<br>来源：[rank_datum.pretty_print_source()]
				<br>持有者：[length(admins_by_rank[rank_name])]
				<br>权限：[permissions]
				<br>被拒绝：[denied_permissions]
				<br>可编辑：[editing_permissions]
				<hr style='background:#000000; border:0; height:1px'>
			"}
	else if(action == PERMISSIONS_PAGE_LOGGING)
		output += {"
			<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<title>权限面板</title>
			</head>
		"}
		var/log_count = 0
		var/page_count = 0
		var/selected_page = 0
		log_target ||= ""
		log_actor ||= ""
		log_operation ||= null
		if(log_operation == PERMISSIONS_ACTION_NONE)
			log_operation = null
		if(log_page)
			selected_page = text2num(log_page)

		var/list/action_options = list()
		for(var/action_type in GLOB.permission_action_types)
			if(action_type == log_operation || (isnull(log_operation) && action_type == PERMISSIONS_ACTION_NONE))
				action_options += "<option value='[action_type]' selected>[action_type]</option>"
			else
				action_options += "<option value='[action_type]'>[action_type]</option>"
		// We intentionally do not carry page values through searches since they'd get messed with
		output += {"
			<form method='get' action='?'>
				[HrefTokenFormField()]
				<input type='hidden' name='_src_' value='holder'>
				<input type='hidden' name='editrightsbrowserlogging' value='1'>
				<b>被修改的 Ckey：</b>
					<input type='text' name='editrightslogtarget' value='[log_target]' style='width:20%;''>
				<b> 操作管理员： </b>
					<input type='text' name='editrightslogactor' value='[log_actor]' style='width:20%;''>
				<b> 操作： </b>
					<select name="editrightslogoperation" style='width:20%;'>
						[action_options.Join()]
					</select>
				<input type='submit' value='搜索'>
			</form>
		"}
		var/datum/db_query/query_count_admin_logs = SSdbcore.NewQuery({"
			SELECT COUNT(id) FROM [format_table_name("admin_log")]
			WHERE target LIKE CONCAT('%',:target,'%')
				AND adminckey LIKE CONCAT('%',:adminckey,'%')
				AND (:operation IS NULL OR operation = :operation)
			"},
			list("target" = log_target, "adminckey" = log_actor, "operation" = log_operation)
		)
		if(!query_count_admin_logs.warn_execute())
			qdel(query_count_admin_logs)
			return
		if(query_count_admin_logs.NextRow())
			log_count = text2num(query_count_admin_logs.item[1])
		QDEL_NULL(query_count_admin_logs)

		if(log_count > PERMISSIONS_LOGS_PER_PAGE)
			output += "<b>页码：</b>"
			while(log_count > 0)
				output += {"
					|<a href='byond://?_src_=holder;[HrefToken()];editrightsbrowserlogging=1;editrightslogtarget=[log_target];editrightslogactor=[log_actor];editrightslogoperation=[log_operation];editrightslogpage=[page_count]'>
						[page_count == selected_page ? "<b>\[[page_count]\]</b>" : "\[[page_count]\]"]
					</a>
				"}
				log_count -= PERMISSIONS_LOGS_PER_PAGE
				page_count++
			output += "|"
		var/datum/db_query/query_search_admin_logs = SSdbcore.NewQuery({"
			SELECT
				datetime,
				round_id,
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), adminckey),
				operation,
				IF(ckey IS NULL, target, byond_key),
				log
			FROM [format_table_name("admin_log")]
			LEFT JOIN [format_table_name("player")] ON target = ckey
			WHERE target LIKE CONCAT('%',:target,'%')
				AND adminckey LIKE CONCAT('%',:adminckey,'%')
				AND (:operation IS NULL OR operation = :operation)
			ORDER BY datetime DESC
			LIMIT :skip, :take
		"}, list("target" = log_target, "adminckey" = log_actor, "operation" = log_operation, "skip" = PERMISSIONS_LOGS_PER_PAGE * selected_page, "take" = PERMISSIONS_LOGS_PER_PAGE))
		if(!query_search_admin_logs.warn_execute())
			qdel(query_search_admin_logs)
			return
		var/action_found = FALSE
		while(query_search_admin_logs.NextRow())
			var/datetime = query_search_admin_logs.item[1]
			var/round_id = query_search_admin_logs.item[2]
			var/admin_key = query_search_admin_logs.item[3]
			var/operation_applied = query_search_admin_logs.item[4]
			var/ckey_actioned = query_search_admin_logs.item[5]
			var/log = query_search_admin_logs.item[6]
			if(!action_found)
				action_found = TRUE
				output += "<hr style='background:#000000; border:0; height:3px'>"
			output += {"
				<p style='margin:0px'>
					<b>[datetime] | 回合 ID [round_id] | 管理员 [admin_key] | 操作 [operation_applied] 作用于 [ckey_actioned]</b>
					<br>[log]
				</p>
				<hr style='background:#000000; border:0; height:3px'>
			"}
		QDEL_NULL(query_search_admin_logs)
	else if(action == PERMISSIONS_PAGE_HOUSEKEEPING)
		output += {"
			<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<title>权限面板</title>
			</head>
		"}

		// We're gonna sanity check admin rank info, yea?
		// We're pulling from the db as a source of truth here, instead of trusting the local lists
		// First, pull all admin ranks which are used
		var/datum/db_query/query_extract_admins = SSdbcore.NewQuery("SELECT IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE [format_table_name("player")].ckey = [format_table_name("admin")].ckey), ckey), [format_table_name("admin")].`rank` FROM [format_table_name("admin")]")
		if(!query_extract_admins.warn_execute())
			qdel(query_extract_admins)
			return
		var/list/admins_by_rank = list()
		while(query_extract_admins.NextRow())
			var/admin_key = query_extract_admins.item[1]
			var/admin_rank = query_extract_admins.item[2]
			for(var/datum/admin_rank/composed_rank as anything in ranks_from_rank_name(admin_rank))
				admins_by_rank[composed_rank.name] += list(admin_key)
		QDEL_NULL(query_extract_admins)

		// Then, pull the full list of DB ranks to purity check against
		var/datum/db_query/query_extract_ranks = SSdbcore.NewQuery("SELECT `rank`, flags, exclude_flags, can_edit_flags FROM [format_table_name("admin_ranks")]")
		if(!query_extract_ranks.warn_execute())
			qdel(query_extract_ranks)
			return
		var/list/all_db_ranks = list()
		while(query_extract_ranks.NextRow())
			var/loaded_rank = query_extract_ranks.item[1]
			var/rank_flags = query_extract_ranks.item[2]
			var/rank_exclude_flags = query_extract_ranks.item[3]
			var/rank_can_edit_flags = query_extract_ranks.item[4]
			all_db_ranks[loaded_rank] = list("rank" = loaded_rank, "flags" = rank_flags, "exclude_flags" = rank_exclude_flags, "can_edit_flags" = rank_can_edit_flags)
		QDEL_NULL(query_extract_ranks)

		output += "<h3>等级无效的管理员 ckey</h3>"
		var/list/invalid_admin_ranks = admins_by_rank - all_db_ranks
		if(length(invalid_admin_ranks)) // Add a nice leader to the output
			output += "<hr style='background:#000000; border:0; height:1px'>"
		else
			output += "未发现无效等级。"

		for(var/illegal_rank in invalid_admin_ranks)
			for(var/misapplied_admin in admins_by_rank[illegal_rank])
				output += {"
					[misapplied_admin] 拥有不存在的等级 [illegal_rank] |
					<a href='byond://?_src_=holder;[HrefToken()];editrightsbrowserhousekeep=1;editrightschange=[misapplied_admin]'>\[更改等级\]</a> |
					<a href='byond://?_src_=holder;[HrefToken()];editrightsbrowserhousekeep=1;editrightsremove=[misapplied_admin]'>\[移除\]</a>
					<hr style='background:#000000; border:0; height:1px'>
				"}

		output += "<h3>未使用的数据库等级</h3>"
		var/list/unused_ranks = all_db_ranks - admins_by_rank
		if(length(unused_ranks))
			output += "<hr style='background:#000000; border:0; height:1px'>"
		else
			output += "未发现未使用的等级。"

		sortTim(unused_ranks, GLOBAL_PROC_REF(cmp_text_asc))
		for(var/unused_rank in unused_ranks)
			var/list/datum/admin_rank/rank_datums = ranks_from_rank_name(unused_rank)
			var/datum/admin_rank/rank_datum = rank_datums[1]

			var/list/rank_info = all_db_ranks[unused_rank]
			var/permissions = rights2text(text2num(rank_info["flags"]), seperator = " ", prefix = "+")
			var/denied_permissions = rights2text(text2num(rank_info["exclude_flags"]), seperator = " ", prefix = "-")
			var/editing_permissions = rights2text(text2num(rank_info["can_edit_flags"]), seperator = " ", prefix = "*")

			var/delete_might_be_allowed = FALSE
			// First case should never fail, but uh, just in case
			if(rank_datum.source == RANK_SOURCE_DB && check_rights(R_DBRANKS))
				delete_might_be_allowed = TRUE
			if((usr.client.holder.can_edit_rights_flags() & rank_datum.rights) == rank_datum.rights)
				delete_might_be_allowed = FALSE
			output += {"
				等级 [unused_rank] 没有任何管理员持有
				[delete_might_be_allowed ? " | <a href='byond://?_src_=holder;[HrefToken()];editrightsbrowserhousekeep=1;editrightsremoverank=[unused_rank]'>\[删除\]</a>" : ""]
				<br>来源：[rank_datum.pretty_print_source()]
				<br>权限：[permissions]
				<br>被拒绝：[denied_permissions]
				<br>可编辑：[editing_permissions]
				<hr style='background:#000000; border:0; height:1px'>
			"}

	if(QDELETED(usr))
		return
	usr << browse("<!DOCTYPE html><html>[jointext(output, "")]</html>","window=editrights;size=1000x650")

/datum/admins/proc/edit_rights_topic(list/href_list)
	if(!check_rights(R_PERMISSIONS))
		message_admins("[key_name_admin(usr)] 试图在权限不足的情况下编辑管理员权限。")
		log_admin("[key_name(usr)] 试图在权限不足的情况下编辑管理员权限。")
		return
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("管理员编辑被阻止：检测到高级 ProcCall。"), confidential = TRUE)
		return
	var/datum/asset/permissions_assets = get_asset_datum(/datum/asset/simple/namespaced/common)
	permissions_assets.send(usr.client)
	var/admin_key = href_list["key"]
	var/admin_ckey = ckey(admin_key)

	var/task = href_list["editrights"]
	var/datum/admins/target_admin_datum = GLOB.admin_datums[admin_ckey]
	if(!target_admin_datum)
		target_admin_datum = GLOB.deadmins[admin_ckey]
	if (!target_admin_datum && task != "add")
		return
	var/use_db
	var/skip
	var/legacy_only
	if(task == "activate" || task == "deactivate" || task == "sync" || task == "verify" || task == "permissions")
		skip = TRUE
	if(!CONFIG_GET(flag/admin_legacy_system) && CONFIG_GET(flag/protect_legacy_admins) && task == "rank")
		if(admin_ckey in GLOB.protected_admins)
			to_chat(usr, span_adminprefix("服务器配置禁止编辑此管理员的等级。"), confidential = TRUE)
			return
	if(!CONFIG_GET(flag/admin_legacy_system) && CONFIG_GET(flag/protect_legacy_ranks) && task == "permissions")
		if((target_admin_datum.ranks & GLOB.protected_ranks).len > 0)
			to_chat(usr, span_adminprefix("服务器配置禁止编辑此等级的权限标志。"), confidential = TRUE)
			return
	if(CONFIG_GET(flag/load_legacy_ranks_only) && (task == "add" || task == "rank" || task == "permissions"))
		to_chat(usr, span_adminprefix("数据库等级加载已禁用，只能临时更改等级权限，永久创建新等级已被阻止。"), confidential = TRUE)
		legacy_only = TRUE

	if(check_rights(R_DBRANKS, FALSE) && !skip)
		if(!SSdbcore.Connect())
			to_chat(usr, span_danger("无法连接数据库，更改仅会临时生效。"), confidential = TRUE)
			use_db = FALSE
		else
			use_db = tgui_alert(usr,"永久更改会保存到数据库供后续回合使用，临时更改只影响当前回合", "永久还是临时？", list("Permanent", "Temporary", "Cancel"))
			if(isnull(use_db) || use_db == "Cancel")
				return
			if(use_db == "Permanent")
				use_db = TRUE
			else
				use_db = FALSE
		if(QDELETED(usr))
			return

	if(target_admin_datum && (task != "sync" && task != "verify") && !check_if_greater_rights_than_holder(target_admin_datum))
		message_admins("[key_name_admin(usr)] 试图在权限不足的情况下更改 [admin_key] 的等级。")
		log_admin("[key_name(usr)] 试图在权限不足的情况下更改 [admin_key] 的等级。")
		return
	switch(task)
		if("add")
			admin_ckey = add_admin(admin_ckey, admin_key, use_db)
			if(!admin_ckey)
				return

			if(!admin_key) // Prevents failures in logging admin rank changes.
				admin_key = admin_ckey

			change_admin_rank(admin_ckey, admin_key, use_db, null, legacy_only)
		if("remove")
			remove_admin(admin_ckey, admin_key, use_db, target_admin_datum)
		if("rank")
			change_admin_rank(admin_ckey, admin_key, use_db, target_admin_datum, legacy_only)
		if("permissions")
			change_admin_flags(admin_ckey, admin_key, target_admin_datum)
		if("activate")
			force_readmin(admin_key, target_admin_datum)
		if("deactivate")
			force_deadmin(admin_key, target_admin_datum)
		if("sync")
			sync_lastadminrank(admin_ckey, admin_key, target_admin_datum)
		if("verify")
			var/msg = "已通过 [admin_ckey] 的身份验证"
			message_admins("[key_name_admin(usr)] [msg]")
			log_admin("[key_name(usr)] [msg]")

			target_admin_datum.bypass_2fa = TRUE
			target_admin_datum.associate(GLOB.directory[admin_ckey])
	edit_admin_permissions(PERMISSIONS_PAGE_PERMISSIONS)

/datum/admins/proc/add_admin(admin_ckey, admin_key, use_db)
	if(!check_rights(R_PERMISSIONS) || (use_db && !check_rights(R_DBRANKS)))
		return
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("管理员添加被阻止：检测到高级 ProcCall。"), confidential = TRUE)
		return
	if(admin_ckey)
		. = admin_ckey
	else
		admin_key = input("新管理员的 key","管理员 key") as text|null
		. = ckey(admin_key)
	if(!.)
		return FALSE
	if(!admin_ckey && (. in (GLOB.admin_datums+GLOB.deadmins)))
		to_chat(usr, span_danger("[admin_key] 已经是管理员了。"), confidential = TRUE)
		return FALSE
	if(!use_db)
		return
	//if an admin exists without a datum they won't be caught by the above
	var/datum/db_query/query_admin_in_db = SSdbcore.NewQuery(
		"SELECT 1 FROM [format_table_name("admin")] WHERE ckey = :ckey",
		list("ckey" = .)
	)
	if(!query_admin_in_db.warn_execute())
		qdel(query_admin_in_db)
		return FALSE
	if(query_admin_in_db.NextRow())
		qdel(query_admin_in_db)
		to_chat(usr, span_danger("[admin_key] 已在管理员数据库中。如果其未出现在管理员列表中，请查看维护标签页。"), confidential = TRUE)
		return FALSE
	QDEL_NULL(query_admin_in_db)
	var/datum/db_query/query_add_admin = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name("admin")] (ckey, `rank`) VALUES (:ckey, 'NEW ADMIN')",
		list("ckey" = .)
	)
	if(!query_add_admin.warn_execute())
		qdel(query_add_admin)
		return FALSE
	QDEL_NULL(query_add_admin)
	var/datum/db_query/query_add_admin_log = SSdbcore.NewQuery({"
		INSERT INTO [format_table_name("admin_log")] (datetime, round_id, adminckey, adminip, operation, target, log)
		VALUES (NOW(), :round_id, :adminckey, INET_ATON(:adminip), '[PERMISSIONS_ACTION_ADMIN_ADDED]', :target, CONCAT('New admin added: ', :target))
	"}, list("round_id" = "[GLOB.round_id]",  "adminckey" = usr.ckey, "adminip" = usr.client.address, "target" = .))
	if(!query_add_admin_log.warn_execute())
		qdel(query_add_admin_log)
		return
	QDEL_NULL(query_add_admin_log)

/datum/admins/proc/remove_admin(admin_ckey, admin_key, use_db, datum/admins/target_holder)
	if(!check_rights(R_PERMISSIONS) || (use_db && !check_rights(R_DBRANKS)))
		return
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("管理员移除被阻止：检测到高级 ProcCall。"), confidential = TRUE)
		return
	if(tgui_alert(usr,"你确定要移除 [admin_ckey] 吗？", "确认移除", list("Do it", "Cancel")) != "Do it")
		return
	GLOB.admin_datums -= admin_ckey
	GLOB.deadmins -= admin_ckey
	if(target_holder)
		target_holder.disassociate()
	var/m1 = "[key_name_admin(usr)] 已将 [admin_key] 从管理员列表中[use_db ? "永久" : "临时"]移除"
	var/m2 = "[key_name(usr)] 已将 [admin_key] 从管理员列表中[use_db ? "永久" : "临时"]移除"

	if(!use_db)
		message_admins(m1)
		log_admin(m2)
		return
	var/datum/db_query/query_remove_admin = SSdbcore.NewQuery(
		"DELETE FROM [format_table_name("admin")] WHERE ckey = :ckey",
		list("ckey" = admin_ckey)
	)
	if(!query_remove_admin.warn_execute())
		qdel(query_remove_admin)
		return
	QDEL_NULL(query_remove_admin)
	message_admins(m1)
	log_admin(m2)
	var/datum/db_query/query_remove_admin_log = SSdbcore.NewQuery({"
		INSERT INTO [format_table_name("admin_log")] (datetime, round_id, adminckey, adminip, operation, target, log)
		VALUES (NOW(), :round_id, :adminckey, INET_ATON(:adminip), '[PERMISSIONS_ACTION_ADMIN_REMOVED]', :admin_ckey, CONCAT('Admin removed: ', :admin_ckey))
	"}, list("round_id" = "[GLOB.round_id]", "adminckey" = usr.ckey, "adminip" = usr.client.address, "admin_ckey" = admin_ckey))
	if(!query_remove_admin_log.warn_execute())
		qdel(query_remove_admin_log)
		return
	QDEL_NULL(query_remove_admin_log)
	sync_lastadminrank(admin_ckey, admin_key)

/datum/admins/proc/force_readmin(admin_key, datum/admins/target_holder)
	if(!target_holder || !target_holder.deadmined)
		return
	target_holder.activate()
	message_admins("[key_name_admin(usr)] 强制恢复了 [admin_key] 的管理员身份")
	log_admin("[key_name(usr)] 强制恢复了 [admin_key] 的管理员身份")

/datum/admins/proc/force_deadmin(admin_key, datum/admins/target_holder)
	if(!target_holder || target_holder.deadmined)
		return
	message_admins("[key_name_admin(usr)] 强制解除了 [admin_key] 的管理员身份")
	log_admin("[key_name(usr)] 强制解除了 [admin_key] 的管理员身份")
	target_holder.deactivate() //after logs so the deadmined admin can see the message.

/datum/admins/proc/auto_deadmin()
	if(owner.is_localhost())
		return FALSE
	if(owner.prefs.read_preference(/datum/preference/toggle/bypass_deadmin_in_centcom) && is_centcom_level(owner.mob.z) && !istype(owner.mob, /mob/dead/new_player))
		return FALSE

	to_chat(owner, span_interface("你现在是一名普通玩家了。"), confidential = TRUE)
	var/old_owner = owner
	deactivate()
	message_admins("[old_owner] 因自动解除管理员配置而被解除了管理员身份。")
	log_admin("[old_owner] 因自动解除管理员配置而被解除了管理员身份。")
	return TRUE

#define RANK_DONE ":) 我完成了"

/datum/admins/proc/change_admin_rank(admin_ckey, admin_key, use_db, datum/admins/target_holder, legacy_only)
	if(!check_rights(R_PERMISSIONS) || (use_db && !check_rights(R_DBRANKS)))
		return
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("等级修改被阻止：检测到高级 ProcCall。"), confidential = TRUE)
		return

	var/rank_type = RANK_SOURCE_TEMPORARY
	if(use_db)
		rank_type = RANK_SOURCE_DB

	var/list/rank_names = list()
	if(!use_db || (use_db && !legacy_only))
		rank_names += "*新等级*"
	for(var/datum/admin_rank/admin_rank as anything in GLOB.admin_ranks)
		if((admin_rank.rights & usr.client.holder.can_edit_rights_flags()) != admin_rank.rights)
			continue
		if(use_db && admin_rank.source != RANK_SOURCE_DB && admin_rank.source != RANK_SOURCE_TXT)
			continue
		rank_names[admin_rank.name] = admin_rank

	var/list/new_rank_names = list()
	var/list/custom_ranks = list()


	while (TRUE)
		var/list/display_rank_names = list(RANK_DONE)

		if (new_rank_names.len > 0)
			display_rank_names += "** 已选择 **"
			for (var/rank_name in new_rank_names)
				display_rank_names += rank_name
			display_rank_names += "---------"

		for (var/rank_name in rank_names)
			if (!(rank_name in display_rank_names))
				display_rank_names += rank_name

		var/next_rank = input("请选择一个等级，若已完成请选择 [RANK_DONE]。") as null|anything in display_rank_names

		if (isnull(next_rank))
			return

		if (next_rank == RANK_DONE)
			break

		// They clicked "** SELECTED **" or something silly.
		if (!(next_rank in rank_names))
			continue

		if (next_rank in new_rank_names)
			new_rank_names -= next_rank
			continue

		if (next_rank == "*新等级*")
			var/new_rank_name = input("请输入新等级", "新建自定义等级") as text|null
			if (!new_rank_name)
				return

			var/datum/admin_rank/custom_rank = rank_names[new_rank_name]
			if(!isnull(custom_rank))
				continue

			if (target_holder)
				custom_rank = new(new_rank_name, rank_type, target_holder.rank_flags())
			else
				custom_rank = new(new_rank_name, rank_type)

			if(QDELETED(custom_rank))
				continue
			GLOB.admin_ranks += custom_rank
			custom_ranks += custom_rank
			new_rank_names += new_rank_name

		new_rank_names += next_rank

	var/list/new_ranks = list()
	for (var/datum/admin_rank/admin_rank as anything in GLOB.admin_ranks)
		if (admin_rank.name in new_rank_names)
			new_ranks += admin_rank
			new_rank_names -= admin_rank.name

			if (new_rank_names.len == 0)
				break

	var/joined_rank = join_admin_ranks(new_ranks)
	var/m1 = "[key_name_admin(usr)] 已将 [admin_key] 的管理员等级[use_db ? "永久" : "临时"]修改为 [joined_rank]"
	var/m2 = "[key_name(usr)] 已将 [admin_key] 的管理员等级[use_db ? "永久" : "临时"]修改为 [joined_rank]"
	if(use_db)
		//if a player was tempminned before having a permanent change made to their rank they won't yet be in the db
		var/old_rank
		var/datum/db_query/query_admin_in_db = SSdbcore.NewQuery(
			"SELECT `rank` FROM [format_table_name("admin")] WHERE ckey = :admin_ckey",
			list("admin_ckey" = admin_ckey)
		)
		if(!query_admin_in_db.warn_execute())
			qdel(query_admin_in_db)
			return
		if(!query_admin_in_db.NextRow())
			add_admin(admin_ckey, admin_key, TRUE)
			old_rank = "NEW ADMIN"
		else
			old_rank = query_admin_in_db.item[1]
		QDEL_NULL(query_admin_in_db)

		for (var/datum/admin_rank/custom_rank in custom_ranks)
			//similarly if a temp rank is created it won't be in the db if someone is permanently changed to it
			var/datum/db_query/query_rank_in_db = SSdbcore.NewQuery(
				"SELECT 1 FROM [format_table_name("admin_ranks")] WHERE `rank` = :new_rank",
				list("new_rank" = custom_rank.name)
			)
			if(!query_rank_in_db.warn_execute())
				qdel(query_rank_in_db)
				return
			if(query_rank_in_db.NextRow())
				QDEL_NULL(query_rank_in_db)
				continue
			QDEL_NULL(query_rank_in_db)
			var/datum/db_query/query_add_rank = SSdbcore.NewQuery({"
				INSERT INTO [format_table_name("admin_ranks")] (`rank`, flags, exclude_flags, can_edit_flags)
				VALUES (:new_rank, '0', '0', '0')
			"}, list("new_rank" = custom_rank.name))
			if(!query_add_rank.warn_execute())
				qdel(query_add_rank)
				return
			QDEL_NULL(query_add_rank)
			var/datum/db_query/query_add_rank_log = SSdbcore.NewQuery({"
				INSERT INTO [format_table_name("admin_log")] (datetime, round_id, adminckey, adminip, operation, target, log)
				VALUES (NOW(), :round_id, :adminckey, INET_ATON(:adminip), '[PERMISSIONS_ACTION_RANK_ADDED]', :new_rank, CONCAT('New rank added: ', :new_rank))
			"}, list("round_id" = "[GLOB.round_id]", "adminckey" = usr.ckey, "adminip" = usr.client.address, "new_rank" = custom_rank.name))
			if(!query_add_rank_log.warn_execute())
				qdel(query_add_rank_log)
				return
			QDEL_NULL(query_add_rank_log)
		var/datum/db_query/query_change_rank = SSdbcore.NewQuery(
			"UPDATE [format_table_name("admin")] SET `rank` = :new_rank WHERE ckey = :admin_ckey",
			list("new_rank" = joined_rank, "admin_ckey" = admin_ckey)
		)
		if(!query_change_rank.warn_execute())
			qdel(query_change_rank)
			return
		QDEL_NULL(query_change_rank)
		message_admins(m1)
		log_admin(m2)
		var/datum/db_query/query_change_rank_log = SSdbcore.NewQuery({"
			INSERT INTO [format_table_name("admin_log")] (datetime, round_id, adminckey, adminip, operation, target, log)
			VALUES (NOW(), :round_id, :adminckey, INET_ATON(:adminip), '[PERMISSIONS_ACTION_ADMIN_RANK_CHANGED]', :target, CONCAT('Rank of ', :target, ' changed from ', :old_rank, ' to ', :new_rank))
		"}, list("round_id" = "[GLOB.round_id]", "adminckey" = usr.ckey, "adminip" = usr.client.address, "target" = admin_ckey, "old_rank" = old_rank, "new_rank" = joined_rank))
		if(!query_change_rank_log.warn_execute())
			qdel(query_change_rank_log)
			return
		QDEL_NULL(query_change_rank_log)
	else
		message_admins(m1)
		log_admin(m2)
	if(target_holder) //they were previously an admin
		target_holder.disassociate() //existing admin needs to be disassociated
		target_holder.ranks = new_ranks //set the admin_rank as our rank
		target_holder.bypass_2fa = TRUE // Another admin has cleared us
		var/client/target_client = GLOB.directory[admin_ckey]
		target_holder.associate(target_client)
	else
		target_holder = new(new_ranks, admin_ckey) //new admin
		target_holder.bypass_2fa = TRUE // Another admin has cleared us
		target_holder.activate()

#undef RANK_DONE

/// Changes, for this round only, the flags a particular admin gets to use
/datum/admins/proc/change_admin_flags(admin_ckey, admin_key, datum/admins/admin_holder)
	if(!check_rights(R_PERMISSIONS))
		return
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("等级修改被阻止：检测到高级 ProcCall。"), confidential = TRUE)
		return
	var/new_flags = input_bitfield(
		usr,
		"管理员权限<br>这只会临时影响当前管理员（[admin_ckey]）",
		"admin_flags",
		admin_holder.rank_flags(),
		350,
		590,
		allowed_edit_field = usr.client.holder.can_edit_rights_flags(),
	)
	if(isnull(new_flags))
		return

	admin_holder.disassociate()

	if (findtext(admin_holder.rank_names(), "([admin_ckey])"))
		var/datum/admin_rank/rank = admin_holder.ranks[1]
		rank.rights = new_flags
		rank.include_rights = new_flags
		rank.exclude_rights = NONE
		rank.can_edit_rights = rank.can_edit_rights
	else
		// Not a modified subrank, need to duplicate the admin_rank datum to prevent modifying others too.
		var/datum/admin_rank/new_admin_rank = new(
			/* init_name = */ "[admin_holder.rank_names()]([admin_ckey])",
			/* init_source = */ RANK_SOURCE_TEMPORARY,
			/* init_rights = */ new_flags,

			// rank_flags() includes the exclude rights, so we no longer need to handle them separately.
			/* init_exclude_rights = */ NONE,

			/* init_edit_rights = */ admin_holder.can_edit_rights_flags(),
		)

		admin_holder.ranks = list(new_admin_rank)

	var/log = "[key_name(usr)] 已将 [admin_ckey] 的管理员权限更新为 [rights2text(new_flags)]"
	message_admins(log)
	log_admin(log)

	var/client/admin_client = GLOB.directory[admin_ckey]
	admin_holder.associate(admin_client)

/// Polls usr for a new rank to add to either JUST this round, or the DB
/datum/admins/proc/add_rank()
	if(!check_rights(R_PERMISSIONS))
		to_chat(usr, span_adminprefix("你没有执行此操作的权限。"), confidential = TRUE)
		return
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("等级添加被阻止：检测到高级 ProcCall。"), confidential = TRUE)
		return
	if(usr.client.holder.can_edit_rights_flags() == NONE)
		to_chat(usr, span_adminprefix("你不被允许添加任何权限。"), confidential = TRUE)
		return

	var/new_rank_name = input("请输入新等级", "新建自定义等级") as text|null
	if (!new_rank_name)
		return

	var/list/datum/admin_rank/existing_ranks = ranks_from_rank_name(new_rank_name)
	if (length(existing_ranks))
		to_chat(usr, span_adminprefix("同名等级已存在，抱歉！"), confidential = TRUE)
		return

	var/rights = input_bitfield(
		usr,
		"为 [new_rank_name] 设置新权限",
		"admin_flags",
		NONE,
		350,
		590,
		allowed_edit_field = usr.client.holder.can_edit_rights_flags(),
	)
	var/excluded_rights = input_bitfield(
		usr,
		"为 [new_rank_name] 设置新排除权限",
		"admin_flags",
		NONE,
		350,
		590,
		allowed_edit_field = usr.client.holder.can_edit_rights_flags(),
	)
	var/edit_rights = input_bitfield(
		usr,
		"为 [new_rank_name] 设置新编辑权限",
		"admin_flags",
		NONE,
		350,
		590,
		allowed_edit_field = usr.client.holder.can_edit_rights_flags(),
	)

	var/use_db = FALSE
	if(check_rights(R_DBRANKS, FALSE))
		if(!SSdbcore.Connect())
			to_chat(usr, span_danger("无法连接数据库，更改仅会临时生效。"), confidential = TRUE)
			use_db = FALSE
		else
			var/use_db_response = tgui_alert(usr,"永久更改会保存到数据库供后续回合使用，临时更改只影响当前回合", "永久还是临时？", list("Permanent", "Temporary", "Cancel"))
			if(isnull(use_db_response) || use_db_response == "Cancel")
				return
			if(use_db_response == "Permanent")
				use_db = TRUE
			else
				use_db = FALSE
		if(QDELETED(usr))
			return

	var/datum/admin_rank/custom_rank
	if(use_db)
		custom_rank = new(new_rank_name, RANK_SOURCE_DB, rights, excluded_rights, edit_rights)
	else
		custom_rank = new(new_rank_name, RANK_SOURCE_TEMPORARY, rights, excluded_rights, edit_rights)
	if(QDELETED(custom_rank))
		to_chat(usr, span_danger("等级创建失败，请检查运行时错误。"), confidential = TRUE)
		return

	GLOB.admin_ranks += custom_rank

	var/m1 = "[key_name_admin(usr)] 创建了新的[use_db ? "永久" : "临时"]等级 [new_rank_name]"
	var/m2 = "[key_name(usr)] 创建了新的[use_db ? "永久" : "临时"]等级 [new_rank_name]"

	if(!use_db)
		message_admins(m1)
		log_admin(m2)
		return
	// Shit check for conflicts
	var/datum/db_query/query_rank_in_db = SSdbcore.NewQuery(
		"SELECT 1 FROM [format_table_name("admin_ranks")] WHERE `rank` = :new_rank",
		list("new_rank" = custom_rank.name)
	)
	if(!query_rank_in_db.warn_execute())
		qdel(query_rank_in_db)
		return
	if(query_rank_in_db.NextRow())
		qdel(query_rank_in_db)
		return
	QDEL_NULL(query_rank_in_db)
	var/datum/db_query/query_add_rank = SSdbcore.NewQuery({"
		INSERT INTO [format_table_name("admin_ranks")] (`rank`, flags, exclude_flags, can_edit_flags)
		VALUES (:new_rank, :rights, :excluded_rights, :edit_rights)
	"}, list("new_rank" = custom_rank.name, "rights" = rights, "excluded_rights" = excluded_rights, "edit_rights" = edit_rights))
	if(!query_add_rank.warn_execute())
		qdel(query_add_rank)
		return
	QDEL_NULL(query_add_rank)
	message_admins(m1)
	log_admin(m2)
	var/datum/db_query/query_add_rank_log = SSdbcore.NewQuery({"
		INSERT INTO [format_table_name("admin_log")] (datetime, round_id, adminckey, adminip, operation, target, log)
		VALUES (NOW(), :round_id, :adminckey, INET_ATON(:adminip), '[PERMISSIONS_ACTION_RANK_ADDED]', :new_rank,
		CONCAT('New rank added: ', :new_rank, ' (', :rights, ')', ' (', :excluded_rights, ')', ' (', :edit_rights, ')'))
	"}, list("round_id" = "[GLOB.round_id]", "adminckey" = usr.ckey, "adminip" = usr.client.address, "new_rank" = custom_rank.name,
		"rights" = rights, "excluded_rights" = excluded_rights, "edit_rights" = edit_rights))
	if(!query_add_rank_log.warn_execute())
		qdel(query_add_rank_log)
		return
	QDEL_NULL(query_add_rank_log)

/// Removes a rank from the db/temp loading
/datum/admins/proc/remove_rank(admin_rank)
	if(!admin_rank)
		return
	if(!check_rights(R_PERMISSIONS))
		message_admins("[key_name_admin(usr)] 试图在权限不足的情况下移除等级。")
		log_admin("[key_name(usr)] 试图在权限不足的情况下移除等级。")
		return
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("等级删除被阻止：检测到高级 ProcCall。"), confidential = TRUE)
		return
	for(var/datum/admin_rank/R in GLOB.admin_ranks)
		if(R.name == admin_rank && ((R.rights & usr.client.holder.can_edit_rights_flags()) != R.rights))
			to_chat(usr, span_adminprefix("你并不拥有此等级所含全部权限的编辑权，因此不允许删除该等级。"), confidential = TRUE)
			return

	var/list/datum/admin_rank/target_ranks = ranks_from_rank_name(admin_rank)
	if (!target_ranks || length(target_ranks) > 1)
		return
	var/datum/admin_rank/target_rank = target_ranks[1]

	var/local_only_deletion
	switch(target_rank.source)
		if(RANK_SOURCE_LOCAL)
			to_chat(usr, span_adminprefix("本地主机等级无法删除。"), confidential = TRUE)
			return
		// This handles protected ranks on its own
		if(RANK_SOURCE_TXT)
			to_chat(usr, span_adminprefix("文本文件中的等级无法被有效删除，请去修改 admin_ranks.txt"), confidential = TRUE)
			return
		if(RANK_SOURCE_BACKUP)
			to_chat(usr, span_adminprefix("备份等级无法被有效删除，因为它们存放在临时 json 中，嗯……去改那个？大概吧。"), confidential = TRUE)
			return
		if(RANK_SOURCE_TEMPORARY)
			local_only_deletion = TRUE
		if(RANK_SOURCE_DB)
			local_only_deletion = FALSE

	if(!local_only_deletion && CONFIG_GET(flag/load_legacy_ranks_only))
		to_chat(usr, span_adminprefix("数据库等级加载已禁用，此时不允许删除数据库等级，将改为删除本地副本。"), confidential = TRUE)
		local_only_deletion = TRUE

	if(!local_only_deletion)
		var/datum/db_query/query_admins_with_rank = SSdbcore.NewQuery(
			"SELECT 1 FROM [format_table_name("admin")] WHERE `rank` = :admin_rank",
			list("admin_rank" = admin_rank)
		)
		if(!query_admins_with_rank.warn_execute())
			qdel(query_admins_with_rank)
			return
		if(query_admins_with_rank.NextRow())
			qdel(query_admins_with_rank)
			to_chat(usr, span_danger("错误：数据库等级仍在使用时尝试删除该等级；请告知程序员，这不该发生。"), confidential = TRUE)
			return
		QDEL_NULL(query_admins_with_rank)

	for(var/admin_name in GLOB.admin_datums)
		var/datum/admins/existing_min = GLOB.admin_datums[admin_name]
		if(target_rank in existing_min.ranks)
			to_chat(usr, span_danger("错误：等级仍在使用时尝试删除该等级；请告知程序员，这不该发生。"), confidential = TRUE)
			return

	if(tgui_alert(usr,"你确定要移除 [admin_rank] 吗？", "确认移除", list("Do it","Cancel")) != "Do it")
		return

	var/m1 = "[key_name_admin(usr)] 已[local_only_deletion ? "临时" : "永久"]移除等级 [admin_rank]"
	var/m2 = "[key_name(usr)] 已[local_only_deletion ? "临时" : "永久"]移除等级 [admin_rank]"
	GLOB.admin_ranks -= target_rank
	QDEL_NULL(target_rank)

	if(local_only_deletion)
		message_admins(m1)
		log_admin(m2)
		return
	var/datum/db_query/query_remove_rank = SSdbcore.NewQuery(
		"DELETE FROM [format_table_name("admin_ranks")] WHERE `rank` = :admin_rank",
		list("admin_rank" = admin_rank)
	)
	if(!query_remove_rank.warn_execute())
		qdel(query_remove_rank)
		return
	QDEL_NULL(query_remove_rank)
	message_admins(m1)
	log_admin(m2)
	var/datum/db_query/query_remove_rank_log = SSdbcore.NewQuery({"
		INSERT INTO [format_table_name("admin_log")] (datetime, round_id, adminckey, adminip, operation, target, log)
		VALUES (NOW(), :round_id, :adminckey, INET_ATON(:adminip), '[PERMISSIONS_ACTION_RANK_REMOVED]', :admin_rank, CONCAT('Rank removed: ', :admin_rank))
	"}, list("round_id" = "[GLOB.round_id]", "adminckey" = usr.ckey, "adminip" = usr.client.address, "admin_rank" = admin_rank))
	if(!query_remove_rank_log.warn_execute())
		qdel(query_remove_rank_log)
		return
	QDEL_NULL(query_remove_rank_log)

/// Changes the flags on either a DB or local rank
/datum/admins/proc/change_rank(admin_rank)
	if(!admin_rank)
		return
	if(!check_rights(R_PERMISSIONS))
		message_admins("[key_name_admin(usr)] 试图在权限不足的情况下编辑等级权限。")
		log_admin("[key_name(usr)] 试图在权限不足的情况下编辑等级权限。")
		return
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("等级编辑被阻止：检测到高级 ProcCall。"), confidential = TRUE)
		return
	var/datum/asset/permissions_assets = get_asset_datum(/datum/asset/simple/namespaced/common)
	permissions_assets.send(usr.client)

	var/list/datum/admin_rank/target_ranks = ranks_from_rank_name(admin_rank)
	if (!target_ranks || length(target_ranks) > 1)
		return
	var/datum/admin_rank/target_rank = target_ranks[1]
	if(target_rank.name != admin_rank) // Somehow
		to_chat(usr, span_adminprefix("传入的等级与目标不匹配，不知为何。"), confidential = TRUE)
		return
	if((target_rank.rights & usr.client.holder.can_edit_rights_flags()) != target_rank.rights)
		to_chat(usr, span_adminprefix("你并不拥有此等级所含全部权限的编辑权，因此不允许修改该等级。"), confidential = TRUE)
		return

	var/attempt_db = FALSE
	switch(target_rank.source)
		if(RANK_SOURCE_LOCAL)
			to_chat(usr, span_adminprefix("本地主机等级无法修改。"), confidential = TRUE)
			return
		// This handles protected ranks on its own
		if(RANK_SOURCE_TXT)
			to_chat(usr, span_adminprefix("文本文件中的等级无法被有效修改，请去修改 admin_ranks.txt"), confidential = TRUE)
			return
		if(RANK_SOURCE_BACKUP)
			to_chat(usr, span_adminprefix("备份等级无法被有效修改，因为它们存放在临时 json 中，嗯……去改那个？大概吧。"), confidential = TRUE)
			return
		// For completeness
		if(RANK_SOURCE_TEMPORARY)
			attempt_db = FALSE
		if(RANK_SOURCE_DB)
			if(!check_rights(R_DBRANKS, FALSE))
				message_admins("[key_name_admin(usr)] attempted to edit db rank permissions without sufficient rights.")
				log_admin("[key_name(usr)] attempted to edit db rank permissions without sufficient rights.")
				return
			attempt_db = TRUE

	// We do not block editing ranks on protected admins which are not also protected
	// This means an admin could in theory bypass protections if they modified a linked rank (such as game admin) which is not also protected
	// It might be wise to make the permissions afforded by protected ranks inviolable. I'm unsure.
	if(CONFIG_GET(flag/load_legacy_ranks_only))
		to_chat(usr, span_adminprefix("数据库等级加载已禁用，只能临时更改等级的权限。"), confidential = TRUE)
		attempt_db = FALSE

	var/use_db = FALSE
	if(attempt_db)
		if(!SSdbcore.Connect())
			to_chat(usr, span_danger("无法连接数据库，正在取消。"), confidential = TRUE)
			return
		use_db = TRUE

	// Similarly, I want to shit check flags. This is sort of... paranoid but I want to be careful here
	var/working_rights = NONE
	var/working_exclude_rights = NONE
	var/working_can_edit_rights = NONE

	// Not allowed to permenantly edit a rank if it isn't IN the db already
	// This is a real shitcheck but just to be sure
	if(use_db)
		var/datum/db_query/query_db_rank_info = SSdbcore.NewQuery({"
			SELECT flags, exclude_flags, can_edit_flags FROM [format_table_name("admin_ranks")]
			WHERE `rank` = :rank_name
		"}, list("rank_name" = admin_rank))
		if(!query_db_rank_info.warn_execute())
			qdel(query_db_rank_info)
		if(query_db_rank_info.NextRow())
			working_rights = query_db_rank_info.item[1]
			working_exclude_rights = query_db_rank_info.item[2]
			working_can_edit_rights = query_db_rank_info.item[3]
		else // Couldn't find anything, no db memes then
			to_chat(usr, span_adminprefix("数据库中不存在该等级，正在退出。"), confidential = TRUE)
			qdel(query_db_rank_info)
			return
		QDEL_NULL(query_db_rank_info)
	else
		working_rights = target_rank.include_rights
		working_exclude_rights = target_rank.exclude_rights
		working_can_edit_rights = target_rank.can_edit_rights

	while(TRUE)
		var/what_to_edit = tgui_input_list(usr, "你想编辑什么", "等级编辑", list("Rights", "Excluded Rights", "Edit Rights", "Finished"))
		var/existing_flags = NONE
		var/pretty_name
		switch(what_to_edit)
			if("Rights")
				existing_flags = working_rights
				pretty_name = "权限"
			if("Excluded Rights")
				existing_flags = working_exclude_rights
				pretty_name = "被排除的权限"
			if("Edit Rights")
				existing_flags = working_can_edit_rights
				pretty_name = "编辑权限"
			else
				return
		var/new_flags = input_bitfield(
			usr,
			"正在编辑 [target_rank.name] 的 [what_to_edit]",
			"admin_flags",
			existing_flags,
			350,
			590,
			allowed_edit_field = usr.client.holder.can_edit_rights_flags(),
		)
		if(isnull(new_flags))
			to_chat(usr, span_adminprefix("已取消编辑等级。"), confidential = TRUE)
			return

		// Gotta turn it off and on again
		var/list/datum/admins/impacted_admins_to_client = list()
		for(var/admin_key in GLOB.admin_datums)
			var/datum/admins/checking = GLOB.admin_datums[admin_key]
			if(!checking.owner)
				continue
			if(!(target_rank in checking.ranks))
				continue
			impacted_admins_to_client[checking] = checking.owner
			checking.disassociate()

		switch(what_to_edit)
			if("Rights")
				target_rank.include_rights = new_flags
				working_rights = new_flags
			if("Excluded Rights")
				target_rank.exclude_rights = new_flags
				working_exclude_rights = new_flags
			if("Edit Rights")
				target_rank.can_edit_rights = new_flags
				working_can_edit_rights = new_flags

		var/log = "[key_name(usr)] 已[use_db ? "永久" : "临时"]将 [admin_rank] 等级的[pretty_name]更新为 [rights2text(new_flags)]"
		message_admins(log)
		log_admin(log)

		for(var/datum/admins/modified as anything in impacted_admins_to_client)
			modified.associate(impacted_admins_to_client[modified])

		if(!use_db)
			continue

		// Only one at a time to avoid carrying over temp changes
		// Doing it as we are does technically mean conflicts can occur, but that's rare enough I'm ok with it
		var/datum/db_query/query_update_rank
		switch(what_to_edit)
			if("Rights")
				query_update_rank = SSdbcore.NewQuery({"
					UPDATE [format_table_name("admin_ranks")]
					SET flags = :flags
					WHERE `rank` = :rank_name
				"}, list("rank_name" = admin_rank, "flags" = new_flags))
			if("Excluded Rights")
				query_update_rank = SSdbcore.NewQuery({"
					UPDATE [format_table_name("admin_ranks")]
					SET exclude_flags = :exclude_flags
					WHERE `rank` = :rank_name
				"}, list("rank_name" = admin_rank, "exclude_flags" = new_flags))
			if("Editing Rights")
				query_update_rank = SSdbcore.NewQuery({"
					UPDATE [format_table_name("admin_ranks")]
					SET can_edit_flags = :can_edit_flags
					WHERE `rank` = :rank_name
				"}, list("rank_name" = admin_rank, "can_edit_flags" = new_flags))

		if(!query_update_rank.warn_execute())
			qdel(query_update_rank)
			return
		QDEL_NULL(query_update_rank)

		var/datum/db_query/query_update_rank_log = SSdbcore.NewQuery({"
			INSERT INTO [format_table_name("admin_log")] (datetime, round_id, adminckey, adminip, operation, target, log)
			VALUES (NOW(), :round_id, :adminckey, INET_ATON(:adminip), '[PERMISSIONS_ACTION_RANK_CHANGED]', :admin_rank, CONCAT('Rank changed: ', :admin_rank))
		"}, list("round_id" = "[GLOB.round_id]", "adminckey" = usr.ckey, "adminip" = usr.client.address, "admin_rank" = admin_rank))
		if(!query_update_rank_log.warn_execute())
			qdel(query_update_rank_log)
			return
		QDEL_NULL(query_update_rank_log)

/datum/admins/proc/sync_lastadminrank(admin_ckey, admin_key, datum/admins/target_holder)
	var/sqlrank = "Player"
	if (target_holder)
		sqlrank = target_holder.rank_names()
	var/datum/db_query/query_sync_lastadminrank = SSdbcore.NewQuery(
		"UPDATE [format_table_name("player")] SET lastadminrank = :rank WHERE ckey = :ckey",
		list("rank" = sqlrank, "ckey" = admin_ckey)
	)
	if(!query_sync_lastadminrank.warn_execute())
		qdel(query_sync_lastadminrank)
		return
	QDEL_NULL(query_sync_lastadminrank)
	to_chat(usr, span_admin("已成功同步 [admin_key]。"), confidential = TRUE)

#undef PERMISSIONS_LOGS_PER_PAGE
