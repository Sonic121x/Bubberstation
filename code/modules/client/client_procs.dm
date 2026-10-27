	////////////
	//SECURITY//
	////////////

GLOBAL_LIST_INIT(blacklisted_builds, list(
	"1622" = "渲染相关的 bug 可能导致透视外挂。",
))
GLOBAL_LIST_INIT(unrecommended_builds, list(
	"1670" = "破坏世界内文本渲染的 bug。",
	"1671" = "破坏世界内文本渲染的 bug。",
	"1675" = "频繁崩溃。",
	"1676" = "频繁崩溃。",
))
#define LIMITER_SIZE 5
#define CURRENT_SECOND 1
#define SECOND_COUNT 2
#define CURRENT_MINUTE 3
#define MINUTE_COUNT 4
#define ADMINSWARNED_AT 5
	/*
	When somebody clicks a link in game, this Topic is called first.
	It does the stuff in this proc and  then is redirected to the Topic() proc for the src=[0xWhatever]
	(if specified in the link). ie locate(hsrc).Topic()

	Such links can be spoofed.

	Because of this certain things MUST be considered whenever adding a Topic() for something:
		- Can it be fed harmful values which could cause runtimes?
		- Is the Topic call an admin-only thing?
		- If so, does it have checks to see if the person who called it (usr.client) is an admin?
		- Are the processes being called by Topic() particularly laggy?
		- If so, is there any protection against somebody spam-clicking a link?
	If you have any  questions about this stuff feel free to ask. ~Carn
	*/

//the undocumented 4th argument is for ?[0x\ref] style topic links. hsrc is set to the reference and anything after the ] gets put into hsrc_command
/client/Topic(href, href_list, hsrc, hsrc_command)
	if(!usr || usr != mob) //stops us calling Topic for somebody else's client. Also helps prevent usr=null
		return
	//SKYRAT EDIT ADDITION BEGIN - MENTOR
	if(mentor_client_procs(href_list))
		return
	//SKYRAT EDIT ADDITION END

#ifndef TESTING
	if (LOWER_TEXT(hsrc_command) == "_debug") //disable the integrated byond vv in the client side debugging tools since it doesn't respect vv read protections
		return
#endif

#ifndef TESTING
	if (LOWER_TEXT(hsrc_command) == "_debug") //disable the integrated byond vv in the client side debugging tools since it doesn't respect vv read protections
		return
#endif

	// asset_cache
	var/asset_cache_job
	if(href_list["asset_cache_confirm_arrival"])
		asset_cache_job = asset_cache_confirm_arrival(href_list["asset_cache_confirm_arrival"])
		if (!asset_cache_job)
			return

	// Rate limiting
	var/mtl = CONFIG_GET(number/minute_topic_limit)
	if (!holder && mtl)
		var/minute = round(world.time, 600)
		if (!topiclimiter)
			topiclimiter = new(LIMITER_SIZE)
		if (minute != topiclimiter[CURRENT_MINUTE])
			topiclimiter[CURRENT_MINUTE] = minute
			topiclimiter[MINUTE_COUNT] = 0
		topiclimiter[MINUTE_COUNT] += 1
		if (topiclimiter[MINUTE_COUNT] > mtl)
			var/msg = "你上一个操作被忽略了，因为你一分钟内做得太多了。"
			if (minute != topiclimiter[ADMINSWARNED_AT]) //only one admin message per-minute. (if they spam the admins can just boot/ban them)
				topiclimiter[ADMINSWARNED_AT] = minute
				msg += " 管理员已收到通知。"
				log_game("[key_name(src)] 在游戏内一分钟里达到了每分钟 [mtl] 次 topic 调用的上限")
				message_admins("[ADMIN_LOOKUPFLW(usr)] [ADMIN_KICK(usr)] 在游戏内一分钟里达到了每分钟 [mtl] 次 topic 调用的上限")
			to_chat(src, span_danger("[msg]"))
			return

	var/stl = CONFIG_GET(number/second_topic_limit)
	if (!holder && stl && href_list["window_id"] != "statbrowser")
		var/second = round(world.time, 10)
		if (!topiclimiter)
			topiclimiter = new(LIMITER_SIZE)
		if (second != topiclimiter[CURRENT_SECOND])
			topiclimiter[CURRENT_SECOND] = second
			topiclimiter[SECOND_COUNT] = 0
		topiclimiter[SECOND_COUNT] += 1
		if (topiclimiter[SECOND_COUNT] > stl)
			to_chat(src, span_danger("你上一个操作被忽略了，因为你一秒钟内做得太多了"))
			return

	// Tgui Topic middleware
	if(tgui_Topic(href_list))
		return
	if(href_list["reload_tguipanel"])
		nuke_chat()
	if(href_list["reload_statbrowser"])
		stat_panel.reinitialize()
	// Log all hrefs
	log_href("[src] (usr:[usr]\[[COORD(usr)]\]) : [hsrc ? "[hsrc] " : ""][href]")

	//byond bug ID:2256651
	if (asset_cache_job && (asset_cache_job in completed_asset_jobs))
		to_chat(src, span_danger("检测到你的客户端在接收资源时出现了错误。正在尝试修正……（如果你一直看到这条消息，建议关闭 byond 并重新连接）"))
		src << browse("...", "window=asset_cache_browser")
		return
	if (href_list["asset_cache_preload_data"])
		asset_cache_preload_data(href_list["asset_cache_preload_data"])
		return

	// Admin PM
	if(href_list["priv_msg"])
		cmd_admin_pm(href_list["priv_msg"],null)
		return
	if (href_list["player_ticket_panel"])
		view_latest_ticket()
		return
	// Admin message
	if(href_list["messageread"])
		var/message_id = round(text2num(href_list["messageread"]), 1)
		if(!isnum(message_id))
			return
		var/datum/db_query/query_message_read = SSdbcore.NewQuery(
			"UPDATE [format_table_name("messages")] SET type = 'message sent' WHERE targetckey = :player_key AND id = :id",
			list("id" = message_id, "player_key" = usr.ckey)
		)
		query_message_read.warn_execute()
		QDEL_NULL(query_message_read)
		return

	// TGUIless adminhelp
	if(href_list["tguiless_adminhelp"])
		no_tgui_adminhelp(input(src, "输入你的求助内容", "求助") as null|message)
		return

	if(href_list["commandbar_typing"])
		handle_commandbar_typing(href_list)

	switch(href_list["_src_"])
		if("holder")
			hsrc = holder
		if("usr")
			hsrc = mob
		if("vars")
			return view_var_Topic(href,href_list,hsrc)

	switch(href_list["action"])
		if("openLink")
			src << link(href_list["link"])
		if("openWebMap")
			if(!SSmapping.current_map.mapping_url)
				return
			if(is_station_level(mob.z))
				src << link("[SSmapping.current_map.mapping_url]/?x=[mob.x]&y=[mob.y]&zoom=6")
			else
				src << link("[SSmapping.current_map.mapping_url]")
	if (hsrc)
		var/datum/real_src = hsrc
		if(QDELETED(real_src))
			return

	//fun fact: Topic() acts like a verb and is executed at the end of the tick like other verbs. So we have to queue it if the server is
	//overloaded
	if(hsrc && hsrc != holder && DEFAULT_TRY_QUEUE_VERB(VERB_CALLBACK(src, PROC_REF(_Topic), hsrc, href, href_list)))
		return
	..() //redirect to hsrc.Topic()

///dumb workaround because byond doesnt seem to recognize the Topic() typepath for /datum/proc/Topic() from the client Topic,
///so we cant queue it without this
/client/proc/_Topic(datum/hsrc, href, list/href_list)
	return hsrc.Topic(href, href_list)

/client/proc/is_content_unlocked()
	if(!prefs.unlock_content)
		to_chat(src, "成为 BYOND 会员即可使用会员特权与功能，并支持让这款游戏得以实现的引擎。3 个月仅需 10 美元！<a href=\"https://secure.byond.com/membership\">点击此处了解更多</a>。")
		return FALSE
	return TRUE

/client/proc/is_localhost()
	var/static/localhost_addresses = list(
		"127.0.0.1",
		"::1",
		null,
	)
	return address in localhost_addresses

/*
 * Call back proc that should be checked in all paths where a client can send messages
 *
 * Handles checking for duplicate messages and people sending messages too fast
 *
 * The first checks are if you're sending too fast, this is defined as sending
 * SPAM_TRIGGER_AUTOMUTE messages in
 * 5 seconds, this will start supressing your messages,
 * if you send 2* that limit, you also get muted
 *
 * The second checks for the same duplicate message too many times and mutes
 * you for it
 */
/client/proc/handle_spam_prevention(message, mute_type)

	//Increment message count
	total_message_count += 1

	//store the total to act on even after a reset
	var/cache = total_message_count

	if(total_count_reset <= world.time)
		total_message_count = 0
		total_count_reset = world.time + (5 SECONDS)

	//If they're really going crazy, mute them
	if(cache >= SPAM_TRIGGER_AUTOMUTE * 2)
		total_message_count = 0
		total_count_reset = 0
		cmd_admin_mute(src, mute_type, 1)
		return TRUE

	//Otherwise just supress the message
	else if(cache >= SPAM_TRIGGER_AUTOMUTE)
		return TRUE


	if(CONFIG_GET(flag/automute_on) && !holder && last_message == message)
		if(SEND_SIGNAL(mob, COMSIG_MOB_AUTOMUTE_CHECK, src, last_message, mute_type) & WAIVE_AUTOMUTE_CHECK)
			return FALSE

		src.last_message_count++
		if(src.last_message_count >= SPAM_TRIGGER_AUTOMUTE)
			to_chat(src, span_danger("你已超过相同消息的垃圾信息过滤上限。当前回合已被自动禁言。请联系管理员申请解除。"))
			cmd_admin_mute(src, mute_type, 1)
			return TRUE
		if(src.last_message_count >= SPAM_TRIGGER_WARNING)
			//"auto-ban" sends the message that the cold and uncaring gamecode has been designed to quiash you like a bug in short measure should you continue, and it's quite intentional that the user isn't told exactly what that entails.
			to_chat(src, span_userdanger("你的相同消息数量即将达到自动封禁上限。"))
			mob.balloon_alert(mob, "停止刷屏！")
			return FALSE
	else
		last_message = message
		src.last_message_count = 0
		return FALSE

//This stops files larger than UPLOAD_LIMIT being sent from client to server via input(), client.Import() etc.
/client/AllowUpload(filename, filelength)
	var/client_max_file_size = CONFIG_GET(number/upload_limit)
	if (holder)
		var/admin_max_file_size = CONFIG_GET(number/upload_limit_admin)
		if(filelength > admin_max_file_size)
			to_chat(src, span_warning("错误：AllowUpload()：上传文件过大。上传上限：[admin_max_file_size/1024]KiB。"))
			return FALSE
	else if(filelength > client_max_file_size)
		to_chat(src, span_warning("错误：AllowUpload()：上传文件过大。上传上限：[client_max_file_size/1024]KiB。"))
		return FALSE
	return TRUE


	///////////
	//CONNECT//
	///////////

/client/New(TopicData)
	var/tdata = TopicData //save this for later use
	TopicData = null //Prevent calls to client.Topic from connect

	if(connection != "seeker" && connection != "web")//Invalid connection type.
		return null

	GLOB.clients += src
	GLOB.directory[ckey] = src

	var/reconnecting = FALSE
	if(GLOB.persistent_clients_by_ckey[ckey])
		reconnecting = TRUE
		persistent_client = GLOB.persistent_clients_by_ckey[ckey]
	else
		persistent_client = new(ckey)
	persistent_client.set_client(src)

	winset(src, null, list("browser-options" = "find,refresh"))

	// Instantiate stat panel
	stat_panel = new(src, "statbrowser")
	stat_panel.subscribe(src, PROC_REF(on_stat_panel_message))

	// Instantiate tgui panel
	tgui_panel = new(src, "browseroutput")

	tgui_say = new(src, "tgui_say")

	initialize_commandbar_spy()

	set_right_click_menu_mode(TRUE)

	GLOB.ahelp_tickets.ClientLogin(src)
	GLOB.interviews.client_login(src)
	GLOB.requests.client_login(src)
	//preferences datum - also holds some persistent data for the client (because we may as well keep these datums to a minimum)
	prefs = GLOB.preferences_datums[ckey]
	if(prefs)
		prefs.parent = src
		prefs.load_savefile() // just to make sure we have the latest data
		prefs.apply_all_client_preferences()
	else
		prefs = new /datum/preferences(src)
		GLOB.preferences_datums[ckey] = prefs
	prefs.last_ip = address //these are gonna be used for banning
	prefs.last_id = computer_id //these are gonna be used for banning

	if(fexists(roundend_report_file()))
		ASSIGN_GAME_VERB(src, /client, show_previous_roundend_report)

	if(fexists("data/server_last_roundend_report.html"))
		ASSIGN_GAME_VERB(src, /client, show_servers_last_roundend_report)

	var/full_version = "[byond_version].[byond_build ? byond_build : "xxx"]"
	log_access("Login: [key_name(src)] from [address ? address : "localhost"]-[computer_id] || BYOND v[full_version]")

	var/alert_mob_dupe_login = FALSE
	var/alert_admin_multikey = FALSE
	if(CONFIG_GET(flag/log_access))
		var/list/joined_players = list()
		for(var/player_ckey in GLOB.joined_player_list)
			joined_players[player_ckey] = 1

		for(var/joined_player_ckey in (GLOB.directory | joined_players))
			if (!joined_player_ckey || joined_player_ckey == ckey)
				continue

			var/datum/preferences/joined_player_preferences = GLOB.preferences_datums[joined_player_ckey]
			if(!joined_player_preferences)
				continue //this shouldn't happen.

			var/client/potential_match = GLOB.directory[joined_player_ckey]

			var/matched_ip = null
			var/matched_cid = null
			var/same_round = FALSE

			if(joined_player_preferences.last_ip == address)
				matched_ip = "IP [address]"

			if(joined_player_preferences.last_id == computer_id)
				matched_cid = "计算机 ID [computer_id]"
				alert_mob_dupe_login = TRUE

			if(isnull(matched_ip) && isnull(matched_cid))
				continue

			if (joined_players[joined_player_ckey])
				same_round = TRUE

			var/double_match = !isnull(matched_ip) && !isnull(matched_cid)

			if(double_match && same_round)
				alert_admin_multikey = TRUE

			var/list/concatables = list()
			concatables += span_danger(span_bold("[double_match ? "多重登录" : "提示"]："))
			concatables += "<span class='notice'>连接中的玩家 [key_name_admin(src)] 拥有相同的"
			if(double_match)
				concatables += "！同时为！[matched_ip] 和 [matched_cid]"
			else
				concatables += (!isnull(matched_ip) ? matched_ip : matched_cid)
			concatables += "，与 [isnull(potential_match) ? "[joined_player_ckey]（已不再登录）" : "[key_name_admin(potential_match)]"]"
			if(same_round)
				concatables += span_bold("在本轮内")

			concatables += "</span>"

			var/sendable_string = jointext(concatables, " ")

			message_admins(sendable_string)
			log_admin_private(strip_html_full(sendable_string, MAX_MESSAGE_LEN))

	. = ..() //calls mob.Login()

	// Admin Verbs need the client's mob to exist. Must be after ..()
	var/connecting_admin = FALSE //because de-admined admins connecting should be treated like admins.
	//Admin Authorisation
	var/datum/admins/admin_datum = GLOB.admin_datums[ckey]
	if (!isnull(admin_datum))
		admin_datum.associate(src)
		connecting_admin = TRUE
	else if(GLOB.deadmins[ckey])
		ASSIGN_GAME_VERB(src, /client, readmin)
		connecting_admin = TRUE
	//SKYRAT EDIT ADDITION //We will check the population here, because we need to know if the client is an admin or not.
	if(!check_population(connecting_admin))
		qdel(src)
		return
	// SKYRAT EDIT END
	if(CONFIG_GET(flag/autoadmin))
		if(!GLOB.admin_datums[ckey])
			var/list/autoadmin_ranks = ranks_from_rank_name(CONFIG_GET(string/autoadmin_rank))
			if (autoadmin_ranks.len == 0)
				to_chat(world, "未找到自动管理员等级")
			else
				new /datum/admins(autoadmin_ranks, ckey)

	if(CONFIG_GET(flag/enable_localhost_rank) && !connecting_admin && is_localhost())
		var/datum/admin_rank/localhost_rank = new("!localhost!", RANK_SOURCE_LOCAL, R_EVERYTHING, R_DBRANKS, R_EVERYTHING) //+EVERYTHING -DBRANKS *EVERYTHING
		if(QDELETED(localhost_rank))
			to_chat(world, "本地管理员等级的创建不知为何失败了？")
			return
		new /datum/admins(list(localhost_rank), ckey, 1, 1)

	if (length(GLOB.stickybanadminexemptions))
		GLOB.stickybanadminexemptions -= ckey
		if (!length(GLOB.stickybanadminexemptions))
			restore_stickybans()

	if (!byond_build)
		message_admins(span_adminnotice("[key_name(src)] 被检测到伪造其 BYOND 版本。连接已拒绝。"))
		add_system_note("Spoofed-BYOND-Version", "检测到使用伪造的 BYOND 版本。")
		log_suspicious_login("登录失败：[key] - 伪造的 BYOND 版本")
		qdel(src)
		return

	if (num2text(byond_build) in GLOB.blacklisted_builds)
		log_access("登录失败：[key] - BYOND 版本被列入黑名单")
		to_chat_immediate(src, span_userdanger("你的 BYOND 版本已被列入黑名单。"))
		to_chat_immediate(src, span_danger("BYOND 构建 [byond_build] ([byond_version].[byond_build]) 因以下原因被列入黑名单：[GLOB.blacklisted_builds[num2text(byond_build)]]。"))
		to_chat_immediate(src, span_danger("请下载新版本的 BYOND。如果 [byond_build] 已经是最新版本，你可以前往 <a href=\"https://secure.byond.com/download/build\">BYOND 官网</a> 下载其他版本。"))
		if(connecting_admin)
			to_chat_immediate(src, "由于你是管理员，允许你继续使用这个版本，但请考虑更换 BYOND 版本。")
		else
			qdel(src)
			return

	if(SSinput.initialized)
		set_macros()

	// Initialize stat panel
	stat_panel.initialize(
		inline_html = file("html/statbrowser.html"),
		inline_js = file("html/statbrowser.js"),
		inline_css = file("html/statbrowser.css"),
	)
	addtimer(CALLBACK(src, PROC_REF(check_panel_loaded)), 30 SECONDS)

	INVOKE_ASYNC(src, PROC_REF(acquire_dpi))

	// Initialize tgui panel
	tgui_panel.initialize()

	tgui_say.initialize()

	initialize_escape_menu()

	if(alert_mob_dupe_login && !holder)
		// Notify admins if the connecting player's CID is configured to be ignored by stickybans
		if (SSstickyban && (computer_id in SSstickyban.ignored_cids))
			message_admins("<B>多重登录：</B></span><span class='notice'>[key_name_admin(src)] 连接玩家使用了被忽略的 CID [computer_id] 加入。")
			log_admin_private("多重登录：[key_name(src)] 连接玩家使用了被忽略的 CID [computer_id] 加入。")
		else
			// If the CID is not ignored, notify the player with the pop-up.
			var/dupe_login_message = "你的计算机 ID 本轮已经用另一个 key 登录过了，请立即登出当前这个账号，否则可能被封禁！"
			// Notify admins if the connecting player's CID is a duplicate of another player's CID
			if (alert_admin_multikey)
				dupe_login_message += "\n管理员已收到通知。"
				message_admins(span_danger("<B>多重登录：</B></span><span class='notice'>[key_name_admin(src)] 的 CID+IP 与另一名玩家相同，明显属于多重登录。已警告其离开服务器，否则可能被封禁。"))
				log_admin_private("多重登录：[key_name(src)] 的 CID+IP 与另一名玩家相同，明显属于多重登录。已警告其离开服务器，否则可能被封禁。")
			spawn(0.5 SECONDS) //needs to run during world init, do not convert to add timer
				alert(mob, dupe_login_message) //players get banned if they don't see this message, do not convert to tgui_alert (or even tg_alert) please.
				to_chat_immediate(mob, span_danger(dupe_login_message))


	connection_time = world.time
	connection_realtime = world.realtime
	connection_timeofday = world.timeofday
	winset(src, null, "command=\".configure graphics-hwmode on\"")
	var/breaking_version = CONFIG_GET(number/client_error_version)
	var/breaking_build = CONFIG_GET(number/client_error_build)
	var/warn_version = CONFIG_GET(number/client_warn_version)
	var/warn_build = CONFIG_GET(number/client_warn_build)

	if (byond_version < breaking_version || (byond_version == breaking_version && byond_build < breaking_build)) //Out of date client.
		to_chat_immediate(src, span_danger("<b>你的 BYOND 版本过旧：</b>"))
		to_chat_immediate(src, CONFIG_GET(string/client_error_message))
		to_chat_immediate(src, "你的版本：[byond_version].[byond_build]")
		to_chat_immediate(src, "所需版本：[breaking_version].[breaking_build] 或更高")
		to_chat_immediate(src, "访问 <a href=\"https://secure.byond.com/download\">BYOND 官网</a> 获取最新版本的 BYOND。")
		if (connecting_admin)
			to_chat_immediate(src, "因为你是管理员，允许你越过这一限制，但仍强烈建议你升级版本")
		else
			qdel(src)
			return
	else if (byond_version < warn_version || (byond_version == warn_version && byond_build < warn_build)) //We have words for this client.
		if(CONFIG_GET(flag/client_warn_popup))
			var/msg = "<b>你的 byond 版本可能即将过时：</b><br>"
			msg += CONFIG_GET(string/client_warn_message) + "<br><br>"
			msg += "你的版本：[byond_version].[byond_build]<br>"
			msg += "消除此提示所需的版本：[warn_version].[warn_build] 或更高<br>"
			msg += "访问 <a href=\"https://secure.byond.com/download\">BYOND 官网</a> 获取最新版本的 BYOND。<br>"
			src << browse(HTML_SKELETON(msg), "window=warning_popup")
		else
			to_chat(src, span_danger("<b>你的 byond 版本可能即将过时：</b>"))
			to_chat(src, CONFIG_GET(string/client_warn_message))
			to_chat(src, "你的版本：[byond_version].[byond_build]")
			to_chat(src, "消除此提示所需的版本：[warn_version].[warn_build] 或更高")
			to_chat(src, "访问 <a href=\"https://secure.byond.com/download\">BYOND 官网</a> 获取最新版本的 BYOND。")

	if (connection == "web" && !connecting_admin)
		if (!CONFIG_GET(flag/allow_webclient))
			to_chat_immediate(src, "网页客户端已禁用")
			qdel(src)
			return
		if (CONFIG_GET(flag/webclient_only_byond_members) && !IsByondMember())
			to_chat_immediate(src, "抱歉，网页客户端仅限 BYOND 会员使用。")
			qdel(src)
			return

	if( (world.address == address || !address) && !GLOB.host )
		GLOB.host = key
		world.update_status()

	if(holder)
		add_admin_verbs()
		display_admin_memos(src)
		adminGreet()
	if (mob && reconnecting)
		var/stealth_admin = mob.client?.holder?.fakekey
		var/announce_leave = mob.client?.prefs?.read_preference(/datum/preference/toggle/broadcast_login_logout)
		if (!stealth_admin)
			deadchat_broadcast(" 已重新连接。", "<b>[mob][mob.get_realname_string()]</b>", follow_target = mob, turf_target = get_turf(mob), message_type = DEADCHAT_LOGIN_LOGOUT, admin_only=!announce_leave)
	add_verbs_from_config()

	// This needs to be before the client age from db is updated as it'll be updated by then.
	var/datum/db_query/query_last_connected = SSdbcore.NewQuery(
		"SELECT lastseen FROM [format_table_name("player")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	if(query_last_connected.warn_execute() && length(query_last_connected.rows))
		query_last_connected.NextRow()
		var/time_stamp = query_last_connected.item[1]
		display_unread_notes(src, time_stamp)
	qdel(query_last_connected)

	var/cached_player_age = set_client_age_from_db(tdata) //we have to cache this because other shit may change it and we need its current value now down below.
	if (isnum(cached_player_age) && cached_player_age == -1) //first connection
		player_age = 0
	var/nnpa = CONFIG_GET(number/notify_new_player_age)
	if (isnum(cached_player_age) && cached_player_age == -1) //first connection
		if (nnpa >= 0)
			log_admin_private("新登录：[key_name(key, FALSE, TRUE)]（IP：[address]，ID：[computer_id]）首次登录服务器。")
			message_admins("新用户：[key_name_admin(src)] 首次连接到这里。")
			if (CONFIG_GET(flag/irc_first_connection_alert))
				var/new_player_alert_role = CONFIG_GET(string/new_player_alert_role_id)
				send2tgs_adminless_only(
					"New-user",
					"[key_name(src)] 首次连接到这里！[new_player_alert_role ? " <@&[new_player_alert_role]>" : ""]"
				)
	else if (isnum(cached_player_age) && cached_player_age < nnpa)
		message_admins("新用户：[key_name_admin(src)] 刚刚连接，账号年龄为 [cached_player_age] 天")
	if(CONFIG_GET(flag/use_account_age_for_jobs) && account_age >= 0)
		player_age = account_age
	if(account_age >= 0 && account_age < nnpa)
		message_admins("[key_name_admin(src)]（IP：[address]，ID：[computer_id]）是一个新的 BYOND 账号，已存在 [account_age] 天，创建于 [account_join_date]。")
		if (CONFIG_GET(flag/irc_first_connection_alert))
			var/new_player_alert_role = CONFIG_GET(string/new_player_alert_role_id)
			send2tgs_adminless_only(
				"new_byond_user",
				"[key_name(src)]（IP：[address]，ID：[computer_id]）是一个新的 BYOND 账号，已存在 [account_age] 天，创建于 [account_join_date]。[new_player_alert_role ? " <@&[new_player_alert_role]>" : ""]"
			)
	scream_about_watchlists(src)
	validate_key_in_db()
	// If we aren't already generating a ban cache, fire off a build request
	// This way hopefully any users of request_ban_cache will never need to yield
	if(!ban_cache_start && SSban_cache?.query_started)
		INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(build_ban_cache), src)

	send_resources()

	apply_clickcatcher()

	if(prefs.lastchangelog != GLOB.changelog_hash) //bolds the changelog button on the interface so we know there are updates.
		to_chat(src, span_info("更新日志中有未读的更新。"))
		if(CONFIG_GET(flag/aggressive_changelog))
			changelog()

	if(ckey in GLOB.clientmessages)
		for(var/message in GLOB.clientmessages[ckey])
			to_chat(src, message)
		GLOB.clientmessages.Remove(ckey)

	if(CONFIG_GET(flag/autoconvert_notes))
		convert_notes_sql(ckey)
	display_admin_messages(src)
	if(!winexists(src, "asset_cache_browser")) // The client is using a custom skin, tell them.
		to_chat(src, span_warning("无法访问资源缓存浏览器。如果你正在使用自定义皮肤文件，请允许 DS 下载更新版本；如果没有使用，请提交 bug 报告。这不是严重问题，但可能导致资源下载异常，因为无法得知额外资源何时送达。"))

	update_ambience_pref(prefs.read_preference(/datum/preference/numeric/volume/sound_ambience_volume))
	check_ip_intel()

	//This is down here because of the browse() calls in tooltip/New()
	if(!tooltips)
		tooltips = new /datum/tooltip(src)

	loot_panel = new(src)

	view_size = new(src)
	view_size.resetFormat()
	view_size.setZoomMode()
	view_size.apply()
	Master.UpdateTickRate()
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_CLIENT_CONNECT, src)
	fully_created = TRUE
	set_fullscreen()

//////////////
//DISCONNECT//
//////////////

/client/Del()
	if(!gc_destroyed)
		gc_destroyed = world.time
		if (!QDELING(src))
			stack_trace("Client does not purport to be QDELING, this is going to cause bugs in other places!")

		// Yes this is the same as what's found in qdel(). Yes it does need to be here
		// Get off my back
		SEND_SIGNAL(src, COMSIG_QDELETING, TRUE)
		Destroy() //Clean up signals and timers.
	return ..()

/client/Destroy()
	if(mob)
		var/stealth_admin = mob.client?.holder?.fakekey
		var/announce_join = mob.client?.prefs?.read_preference(/datum/preference/toggle/broadcast_login_logout)
		if (!stealth_admin)
			deadchat_broadcast(" 已断开连接。", "<b>[mob][mob.get_realname_string()]</b>", follow_target = mob, turf_target = get_turf(mob), message_type = DEADCHAT_LOGIN_LOGOUT, admin_only=!announce_join)
		mob.become_uncliented()

	GLOB.clients -= src
	GLOB.directory -= ckey
	if(persistent_client)
		persistent_client.set_client(null)
	else
		stack_trace("A client was Del()'d without a persistent_client! This should not be happening.")

	log_access("Logout: [key_name(src)]")
	GLOB.ahelp_tickets.ClientLogout(src)
	GLOB.interviews.client_logout(src)
	GLOB.requests.client_logout(src)
	SSserver_maint.UpdateHubStatus()
	if(credits)
		QDEL_LIST(credits)
	if(holder)
		holder.owner = null
		GLOB.admins -= src
		handle_admin_logout()

	QDEL_LIST_ASSOC_VAL(char_render_holders)

	SSambience.remove_ambience_client(src)
	SSmouse_entered.hovers -= src
	SSping.currentrun -= src
	SSsound_tokens.clients_needing_update -= src
	SSsound_tokens.currentrun -= src
	QDEL_NULL(view_size)
	QDEL_NULL(void)
	QDEL_NULL(tooltips)
	QDEL_NULL(loot_panel)
	QDEL_NULL(parallax_rock)
	seen_messages = null
	Master.UpdateTickRate()
	..() //Even though we're going to be hard deleted there are still some things that want to know the destroy is happening
	return QDEL_HINT_HARDDEL_NOW

/client/proc/set_client_age_from_db(connectiontopic)
	if (is_guest_key(src.key))
		return
	if(!SSdbcore.Connect())
		return
	var/datum/db_query/query_get_related_ip = SSdbcore.NewQuery(
		"SELECT ckey FROM [format_table_name("player")] WHERE ip = INET_ATON(:address) AND ckey != :ckey",
		list("address" = address, "ckey" = ckey)
	)
	if(!query_get_related_ip.Execute())
		qdel(query_get_related_ip)
		return
	related_accounts_ip = ""
	while(query_get_related_ip.NextRow())
		related_accounts_ip += "[query_get_related_ip.item[1]], "
	qdel(query_get_related_ip)
	var/datum/db_query/query_get_related_cid = SSdbcore.NewQuery(
		"SELECT ckey FROM [format_table_name("player")] WHERE computerid = :computerid AND ckey != :ckey",
		list("computerid" = computer_id, "ckey" = ckey)
	)
	if(!query_get_related_cid.Execute())
		qdel(query_get_related_cid)
		return
	related_accounts_cid = ""
	while (query_get_related_cid.NextRow())
		related_accounts_cid += "[query_get_related_cid.item[1]], "
	qdel(query_get_related_cid)
	var/admin_rank = holder?.rank_names() || "Player"
	var/new_player
	var/datum/db_query/query_client_in_db = SSdbcore.NewQuery(
		"SELECT 1 FROM [format_table_name("player")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	if(!query_client_in_db.Execute())
		qdel(query_client_in_db)
		return
/* SKYRAT EDIT - ORIGINAL:
	var/client_is_in_db = query_client_in_db.NextRow()
	// If we aren't an admin, and the flag is set (the panic bunker is enabled).
	if(CONFIG_GET(flag/panic_bunker) && !holder && !GLOB.deadmins[ckey])
		// The amount of hours needed to bypass the panic bunker.
		var/living_recs = CONFIG_GET(number/panic_bunker_living)
		// This relies on prefs existing, but this proc is only called after that occurs, so we're fine.
		var/minutes = get_exp_living(pure_numeric = TRUE)

		// Check to see if our client should be rejected.
		// If interviews are on, we should let anyone through, ideally.
		if(!CONFIG_GET(flag/panic_bunker_interview))
			// If we don't have panic_bunker_living set and the client is not in the DB, reject them.
			// Otherwise, if we do have a panic_bunker_living set, check if they have enough minutes played.
			if((living_recs == 0 && !client_is_in_db) || living_recs >= minutes)
				var/reject_message = "Failed Login: [key] - [client_is_in_db ? "":"New "]Account attempting to connect during panic bunker, but\
					[living_recs == 0 ? " was rejected due to no prior connections to game servers (no database entry)":" they do not have the required living time [minutes]/[living_recs]"]."
				log_access(reject_message)
				message_admins(span_adminnotice("[reject_message]"))
				var/message = CONFIG_GET(string/panic_bunker_message)
				message = replacetext(message, "%minutes%", living_recs)
				to_chat_immediate(src, message)
				var/list/connectiontopic_a = params2list(connectiontopic)
				var/list/panic_addr = CONFIG_GET(string/panic_server_address)
				if(panic_addr && !connectiontopic_a["redirect"])
					var/panic_name = CONFIG_GET(string/panic_server_name)
					to_chat_immediate(src, span_notice("Sending you to [panic_name ? panic_name : panic_addr]."))
					winset(src, null, "command=.options")
					src << link("[panic_addr]?redirect=1")
				qdel(query_client_in_db)
				qdel(src)
				return
*/
	var/client_is_in_db = query_client_in_db.NextRow()

	if(!client_is_in_db)
		//SKYRAT EDIT ADDITION BEGIN - PANICBUNKER
		if (CONFIG_GET(flag/panic_bunker) && !holder && !GLOB.deadmins[ckey] && !(ckey in GLOB.bunker_passthrough))
			log_access("登录失败：[key] - [address] - 新账号试图在恐慌地堡期间连接")
			message_admins("<span class='adminnotice'>登录失败：[key] - [address] - 新账号试图在恐慌地堡期间连接</span>")
			//BUBBER EDIT ADDITION BEGIN - PANICBUNKER TEXT
			//BUBBER TODO: Make the to_chat a config thing and present it to skyrat
			var/forumurl = CONFIG_GET(string/forumurl)
			to_chat_immediate(src, {"<span class='notice'>你好！本服务器启用了白名单。<br> <br> 想要加入我们的社区，请查看我们的 Discord！要获得游戏服务器的完整访问权限，请阅读规则，并在此处链接的 Discord 服务器中“白名单”分类下的 #get-whitelisted 频道中提交工单：<a href=' [forumurl] '>[forumurl]</a></span>"})
			//BUBBER EDIT ADDITION END - PANICBUNKER TEXT
			var/list/connectiontopic_a = params2list(connectiontopic)
			var/list/panic_addr = CONFIG_GET(string/panic_server_address)
			if(panic_addr && !connectiontopic_a["redirect"])
				var/panic_name = CONFIG_GET(string/panic_server_name)
				to_chat(src, "<span class='notice'>正在将你发送到 [panic_name ? panic_name : panic_addr]。</span>")
				winset(src, null, "command=.options")
				src << link("[panic_addr]?redirect=1")
			qdel(query_client_in_db)
			qdel(src)
			return
		//SKYRAT EDIT END
		new_player = 1
		account_join_date = findJoinDate()
		var/datum/db_query/query_add_player = SSdbcore.NewQuery({"
			INSERT INTO [format_table_name("player")] (`ckey`, `byond_key`, `firstseen`, `firstseen_round_id`, `lastseen`, `lastseen_round_id`, `ip`, `computerid`, `lastadminrank`, `accountjoindate`)
			VALUES (:ckey, :key, Now(), :round_id, Now(), :round_id, INET_ATON(:ip), :computerid, :adminrank, :account_join_date)
		"}, list("ckey" = ckey, "key" = key, "round_id" = GLOB.round_id, "ip" = address, "computerid" = computer_id, "adminrank" = admin_rank, "account_join_date" = account_join_date || null))
		if(!query_add_player.Execute())
			qdel(query_client_in_db)
			qdel(query_add_player)
			return
		qdel(query_add_player)
		if(!account_join_date)
			account_join_date = "Error"
			account_age = -1
		//SKYRAT EDIT ADDITION BEGIN - PANICBUNKER
		else if(ckey in GLOB.bunker_passthrough)
			GLOB.bunker_passthrough -= ckey
		//SKYRAT EDIT END
	qdel(query_client_in_db)
	var/datum/db_query/query_get_client_age = SSdbcore.NewQuery(
		"SELECT firstseen, DATEDIFF(Now(),firstseen), accountjoindate, DATEDIFF(Now(),accountjoindate) FROM [format_table_name("player")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	if(!query_get_client_age.Execute())
		qdel(query_get_client_age)
		return
	if(query_get_client_age.NextRow())
		player_join_date = query_get_client_age.item[1]
		player_age = text2num(query_get_client_age.item[2])
		if(!account_join_date)
			account_join_date = query_get_client_age.item[3]
			account_age = text2num(query_get_client_age.item[4])
			if(!account_age)
				account_join_date = findJoinDate()
				if(!account_join_date)
					account_age = -1
				else
					var/datum/db_query/query_datediff = SSdbcore.NewQuery(
						"SELECT DATEDIFF(Now(), :account_join_date)",
						list("account_join_date" = account_join_date)
					)
					if(!query_datediff.Execute())
						qdel(query_datediff)
						qdel(query_get_client_age)
						return
					if(query_datediff.NextRow())
						account_age = text2num(query_datediff.item[1])
					qdel(query_datediff)
	qdel(query_get_client_age)
	if(!new_player)
		SSdbcore.FireAndForget(
			"UPDATE [format_table_name("player")] SET lastseen = Now(), lastseen_round_id = :round_id, ip = INET_ATON(:ip), computerid = :computerid, lastadminrank = :admin_rank, accountjoindate = :account_join_date WHERE ckey = :ckey",
			list("round_id" = GLOB.round_id, "ip" = address, "computerid" = computer_id, "admin_rank" = admin_rank, "account_join_date" = account_join_date || null, "ckey" = ckey)
		)
	if(!account_join_date)
		account_join_date = "Error"
	SSdbcore.FireAndForget(/* BUBBER EDIT - MULTISERVER */{"
		INSERT INTO `[format_table_name("connection_log")]` (`id`,`datetime`,`server_name`,`server_ip`,`server_port`,`round_id`,`ckey`,`ip`,`computerid`)
		VALUES(null,Now(),:server_name,INET_ATON(:internet_address),:port,:round_id,:ckey,INET_ATON(:ip),:computerid)
	"}, list("server_name" = CONFIG_GET(string/serversqlname), "internet_address" = world.internet_address || "0", "port" = world.port, "round_id" = GLOB.round_id, "ckey" = ckey, "ip" = address, "computerid" = computer_id)) //BUBBER EDIT - MULTISERVER

	SSserver_maint.UpdateHubStatus()

	if(new_player)
		player_age = -1
	. = player_age

/client/proc/findJoinDate()
	var/list/http = world.Export("http://byond.com/members/[ckey]?format=text")
	if(!http)
		log_world("无法连接 byond 会员页面以查询账号年龄 [ckey]")
		return
	var/F = file2text(http["CONTENT"])
	if(F)
		var/regex/R = regex("joined = \"(\\d{4}-\\d{2}-\\d{2})\"")
		if(R.Find(F))
			. = R.group[1]
		else
			CRASH("Age check regex failed for [src.ckey]")

/client/proc/validate_key_in_db()
	var/sql_key
	var/datum/db_query/query_check_byond_key = SSdbcore.NewQuery(
		"SELECT byond_key FROM [format_table_name("player")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	if(!query_check_byond_key.Execute())
		qdel(query_check_byond_key)
		return
	if(query_check_byond_key.NextRow())
		sql_key = query_check_byond_key.item[1]
	qdel(query_check_byond_key)
	if(key != sql_key)
		var/list/http = world.Export("http://byond.com/members/[ckey]?format=text")
		if(!http)
			log_world("无法连接 byond 会员页面以获取 [ckey] 变更后的 key")
			return
		var/F = file2text(http["CONTENT"])
		if(F)
			var/regex/R = regex("\\tkey = \"(.+)\"")
			if(R.Find(F))
				var/web_key = R.group[1]
				var/datum/db_query/query_update_byond_key = SSdbcore.NewQuery(
					"UPDATE [format_table_name("player")] SET byond_key = :byond_key WHERE ckey = :ckey",
					list("byond_key" = web_key, "ckey" = ckey)
				)
				query_update_byond_key.Execute()
				qdel(query_update_byond_key)
			else
				CRASH("Key check regex failed for [ckey]")

/client/proc/add_system_note(system_ckey, message)
	//check to see if we noted them in the last day.
	var/datum/db_query/query_get_notes = SSdbcore.NewQuery(
		"SELECT id FROM [format_table_name("messages")] WHERE type = 'note' AND targetckey = :targetckey AND adminckey = :adminckey AND timestamp + INTERVAL 1 DAY < NOW() AND deleted = 0 AND (expire_timestamp > NOW() OR expire_timestamp IS NULL)",
		list("targetckey" = ckey, "adminckey" = system_ckey)
	)
	if(!query_get_notes.Execute())
		qdel(query_get_notes)
		return
	if(query_get_notes.NextRow())
		qdel(query_get_notes)
		return
	qdel(query_get_notes)
	//regardless of above, make sure their last note is not from us, as no point in repeating the same note over and over.
	query_get_notes = SSdbcore.NewQuery(
		"SELECT adminckey FROM [format_table_name("messages")] WHERE targetckey = :targetckey AND deleted = 0 AND (expire_timestamp > NOW() OR expire_timestamp IS NULL) ORDER BY timestamp DESC LIMIT 1",
		list("targetckey" = ckey)
	)
	if(!query_get_notes.Execute())
		qdel(query_get_notes)
		return
	if(query_get_notes.NextRow())
		if (query_get_notes.item[1] == system_ckey)
			qdel(query_get_notes)
			return
	qdel(query_get_notes)
	create_message("note", key, system_ckey, message, null, null, 0, 0, null, 0, 0)

/client/Click(atom/object, atom/location, control, params)
	if(click_intercept_time)
		if(click_intercept_time >= world.time)
			click_intercept_time = 0 //Reset and return. Next click should work, but not this one.
			return
		click_intercept_time = 0 //Just reset. Let's not keep re-checking forever.

	var/ab = FALSE
	var/list/modifiers = params2list(params)

	var/button_clicked = LAZYACCESS(modifiers, "button")

	var/dragged = LAZYACCESS(modifiers, DRAG)
	if(dragged && button_clicked != dragged)
		return

	if (object && IS_WEAKREF_OF(object, middle_drag_atom_ref) && button_clicked == LEFT_CLICK)
		ab = max(0, 5 SECONDS-(world.time-middragtime)*0.1)

	var/mcl = CONFIG_GET(number/minute_click_limit)
	if (!holder && mcl)
		var/minute = round(world.time, 600)

		if (!clicklimiter)
			clicklimiter = new(LIMITER_SIZE)

		if (minute != clicklimiter[CURRENT_MINUTE])
			clicklimiter[CURRENT_MINUTE] = minute
			clicklimiter[MINUTE_COUNT] = 0

		clicklimiter[MINUTE_COUNT] += 1 + (ab)

		if (clicklimiter[MINUTE_COUNT] > mcl)
			var/msg = "你上一个点击被忽略了，因为你一分钟内点得太多了。"
			if (minute != clicklimiter[ADMINSWARNED_AT]) //only one admin message per-minute. (if they spam the admins can just boot/ban them)
				clicklimiter[ADMINSWARNED_AT] = minute

				msg += " 管理员已收到通知。"
				if (ab)
					log_game("[key_name(src)] 正在使用中键自动瞄准外挂")
					message_admins("[ADMIN_LOOKUPFLW(usr)] [ADMIN_KICK(usr)] 正在使用中键自动瞄准外挂</span>")
					add_system_note("aimbot", "正在使用中键自动瞄准外挂")
				log_game("[key_name(src)] 在游戏内一分钟里达到了每分钟 [mcl] 次点击的上限")
				message_admins("[ADMIN_LOOKUPFLW(usr)] [ADMIN_KICK(usr)] 在游戏内一分钟里达到了每分钟 [mcl] 次点击的上限")
			to_chat(src, span_danger("[msg]"))
			return

	var/scl = CONFIG_GET(number/second_click_limit)
	if (!holder && scl)
		var/second = round(world.time, 10)
		if (!clicklimiter)
			clicklimiter = new(LIMITER_SIZE)

		if (second != clicklimiter[CURRENT_SECOND])
			clicklimiter[CURRENT_SECOND] = second
			clicklimiter[SECOND_COUNT] = 0

		clicklimiter[SECOND_COUNT] += 1 + (!!ab)

		if (clicklimiter[SECOND_COUNT] > scl)
			to_chat(src, span_danger("你上一个点击被忽略了，因为你一秒钟内点得太多了"))
			return

	//check if the server is overloaded and if it is then queue up the click for next tick
	//yes having it call a wrapping proc on the subsystem is fucking stupid glad we agree unfortunately byond insists its reasonable
	if(!QDELETED(object) && TRY_QUEUE_VERB(VERB_CALLBACK(object, TYPE_PROC_REF(/atom, _Click), location, control, params), VERB_HIGH_PRIORITY_QUEUE_THRESHOLD, SSinput, control))
		return

	if (hotkeys)
		// If hotkey mode is enabled, then clicking the map will automatically
		// unfocus the text bar.
		winset(src, null, "input.focus=false")
	else
		winset(src, null, "input.focus=true")

	SEND_SIGNAL(src, COMSIG_CLIENT_CLICK, object, location, control, params, usr)

	..()

/client/proc/add_verbs_from_config()
	if (interviewee)
		return
	if(CONFIG_GET(flag/see_own_notes))
		ASSIGN_GAME_VERB(src, /client, self_notes)
	if(CONFIG_GET(flag/use_exp_tracking))
		ASSIGN_GAME_VERB(src, /client, self_playtime)
	if(!CONFIG_GET(flag/forbid_preferences_export))
		ASSIGN_GAME_VERB(src, /client, export_preferences)


//checks if a client is afk
//3000 frames = 5 minutes
/client/proc/is_afk(duration = CONFIG_GET(number/inactivity_period))
	if(inactivity > duration)
		return inactivity
	return FALSE

/// Send resources to the client.
/// Sends both game resources and browser assets.
/client/proc/send_resources()
#if (PRELOAD_RSC == 0)
	var/static/next_external_rsc = 0
	var/list/external_rsc_urls = CONFIG_GET(keyed_list/external_rsc_urls)
	if(length(external_rsc_urls))
		next_external_rsc = WRAP(next_external_rsc+1, 1, external_rsc_urls.len+1)
		preload_rsc = external_rsc_urls[next_external_rsc]
#endif

	spawn (10) //removing this spawn causes all clients to not get verbs. (this can't be addtimer because these assets may be needed before the mc inits)

		//load info on what assets the client has
		src << browse('code/modules/asset_cache/validate_assets.html', "window=asset_cache_browser")

		//Precache the client with all other assets slowly, so as to not block other browse() calls
		if (CONFIG_GET(flag/asset_simple_preload))
			addtimer(CALLBACK(SSassets.transport, TYPE_PROC_REF(/datum/asset_transport, send_assets_slow), src, SSassets.transport.preload), 5 SECONDS)

		#if (PRELOAD_RSC == 0)
		addtimer(CALLBACK(src, TYPE_PROC_REF(/client, preload_vox)), 1 MINUTES)
		#endif

#if (PRELOAD_RSC == 0)
/client/proc/preload_vox()
	for (var/name in GLOB.vox_sounds)
		var/file = GLOB.vox_sounds[name]
		Export("##action=load_rsc", file)
		stoplag()
#endif

//Hook, override it to run code when dir changes
//Like for /atoms, but clients are their own snowflake FUCK
/client/proc/setDir(newdir)
	dir = newdir

/client/vv_edit_var(var_name, var_value)
	switch (var_name)
		if (NAMEOF(src, holder))
			return FALSE
		if (NAMEOF(src, ckey))
			return FALSE
		if (NAMEOF(src, key))
			return FALSE
		if(NAMEOF(src, view))
			view_size.setDefault(var_value)
			return TRUE
	. = ..()

/client/proc/rescale_view(change, min, max)
	view_size.setTo(clamp(change, min, max), clamp(change, min, max))

/client/proc/set_eye(new_eye)
	if(new_eye == eye)
		return
	var/atom/old_eye = eye
	eye = new_eye
	SEND_SIGNAL(src, COMSIG_CLIENT_SET_EYE, old_eye, new_eye)
/**
 * Updates the keybinds for special keys
 *
 * Handles adding macros for the keys that need it
 * And adding movement keys to the clients movement_keys list
 * At the time of writing this, communication(OOC, Say, IC, ASAY) require macros
 * Arguments:
 * * direct_prefs - the preference we're going to get keybinds from
 */
/client/proc/update_special_keybinds(datum/preferences/direct_prefs)
	var/datum/preferences/D = prefs || direct_prefs
	if(!D?.key_bindings)
		return
	movement_keys = list()
	for(var/kb_name in D.key_bindings)
		for(var/key in D.key_bindings[kb_name])
			switch(kb_name)
				if("North")
					movement_keys[key] = NORTH
				if("East")
					movement_keys[key] = EAST
				if("West")
					movement_keys[key] = WEST
				if("South")
					movement_keys[key] = SOUTH
				if(ADMIN_CHANNEL)
					if(holder)
						var/asay = tgui_say_create_open_command(ADMIN_CHANNEL)
						winset(src, "default-[REF(key)]", "parent=default;name=[key];command=[asay]")
					else
						winset(src, "default-[REF(key)]", "parent=default;name=[key];command=")
	calculate_move_dir()

/client/proc/change_view(new_size)
	if (isnull(new_size))
		CRASH("change_view called without argument.")

	view = new_size
	SEND_SIGNAL(src, COMSIG_VIEW_SET, new_size)
	mob.hud_used.screentip_text.update_view()
	mob.hud_used.activation.update_view() // BUBBER EDIT ADDITION
	apply_clickcatcher()
	mob.reload_fullscreen()
	if (isliving(mob))
		var/mob/living/M = mob
		M.update_damage_hud()
	attempt_auto_fit_viewport()

/client/proc/generate_clickcatcher()
	if(!void)
		void = new()
	if(!(void in screen))
		screen += void

/client/proc/apply_clickcatcher()
	generate_clickcatcher()
	var/list/actualview = getviewsize(view)
	void.UpdateGreed(actualview[1],actualview[2])

/client/proc/AnnouncePR(announcement)
	if(get_chat_toggles(src) & CHAT_PULLR)
		to_chat(src, announcement)

///Redirect proc that makes it easier to call the unlock achievement proc. Achievement type is the typepath to the award, user is the mob getting the award, and value is an optional variable used for leaderboard value increments
/client/proc/give_award(achievement_type, mob/user, value = 1, ...)
	return persistent_client.achievements.unlock(arglist(args))

///Redirect proc that makes it easier to get the status of an achievement. Achievement type is the typepath to the award.
/client/proc/get_award_status(achievement_type)
	return persistent_client.achievements.get_achievement_status(achievement_type)

///Gives someone hearted status for OOC, from behavior commendations
/client/proc/adjust_heart(duration = 24 HOURS)
	var/new_duration = world.realtime + duration
	if(prefs.hearted_until > new_duration)
		return
	to_chat(src, span_nicegreen("有人送了你一颗心！"))
	prefs.hearted_until = new_duration
	prefs.hearted = TRUE
	prefs.save_preferences()

/// compiles a full list of verbs and sends it to the browser
/client/proc/init_verbs()
	if(IsAdminAdvancedProcCall())
		return
	var/list/verblist = list()
	var/list/verbstoprocess = verbs.Copy()
	if(mob)
		verbstoprocess += mob.verbs
		for(var/atom/movable/thing as anything in mob.contents)
			verbstoprocess += thing.verbs
	panel_tabs.Cut() // panel_tabs get reset in init_verbs on JS side anyway
	for(var/procpath/verb_to_init as anything in verbstoprocess)
		if(!verb_to_init)
			continue
		if(verb_to_init.hidden)
			continue
		if(!istext(verb_to_init.category))
			continue
		panel_tabs |= verb_to_init.category
		verblist[++verblist.len] = list(verb_to_init.category, verb_to_init.name)
	src.stat_panel.send_message("init_verbs", list(panel_tabs = panel_tabs, verblist = verblist))

	var/list/panel_verbs = list()
	for(var/procpath/verb_to_init as anything in verbstoprocess)
		if(!verb_to_init || verb_to_init.hidden)
			continue
		if(!SSverbs.verbs_by_verb_path[verb_to_init] && !SSadmin_verbs.admin_verbs_by_verb_path[verb_to_init])
			continue
		panel_verbs += list(SSverbs.serialize_verb(verb_to_init))
	tgui_panel?.window?.send_message("verbs/init", list("verbs" = panel_verbs))

/client/proc/check_panel_loaded()
	if(stat_panel.is_ready())
		return
	to_chat(src, span_userdanger("状态面板加载失败，点击<a href='byond://?src=[REF(src)];reload_statbrowser=1'>此处</a>重新加载面板 "))

/client/proc/open_filter_editor(atom/in_atom)
	if(holder)
		holder.filterrific = new /datum/filter_editor(in_atom)
		holder.filterrific.ui_interact(mob)

///opens the particle editor UI for the in_atom object for this client
/client/proc/open_particle_editor(atom/movable/in_atom)
	if(holder)
		holder.particle_test = new /datum/particle_editor(in_atom)
		holder.particle_test.ui_interact(mob)

/client/proc/set_right_click_menu_mode(shift_only)
	if(shift_only)
		winset(src, SKIN_MAPWINDOW_MAP, "right-click=true")
		winset(src, SKIN_DEFAULT_SHIFTUP, "is-disabled=false")
		winset(src, SKIN_DEFAULT_SHIFT, "is-disabled=false")
	else
		winset(src, SKIN_MAPWINDOW_MAP, "right-click=false")
		winset(src, SKIN_DEFAULT_SHIFT, "is-disabled=true")
		winset(src, SKIN_DEFAULT_SHIFTUP, "is-disabled=true")

/client/proc/update_ambience_pref(value)
	if(value)
		if(SSambience.ambience_listening_clients[src] > world.time)
			return // If already properly set we don't want to reset the timer.
		SSambience.ambience_listening_clients[src] = world.time + 10 SECONDS //Just wait 10 seconds before the next one aight mate? cheers.
	else
		SSambience.remove_ambience_client(src)

/**
 * Handles incoming messages from the stat-panel TGUI.
 */
/client/proc/on_stat_panel_message(type, payload)
	switch(type)
		if("Update-Verbs")
			init_verbs()
		if("Remove-Tabs")
			panel_tabs -= payload["tab"]
		if("Send-Tabs")
			panel_tabs |= payload["tab"]
		if("Reset-Tabs")
			panel_tabs = list()
		if("Set-Tab")
			stat_tab = payload["tab"]
			SSstatpanels.immediate_send_stat_data(src)

/// Checks if this client has met the days requirement passed in, or if
/// they are exempt from it.
/// Returns the number of days left, or 0.
/client/proc/get_remaining_days(days_needed)
	if(!CONFIG_GET(flag/use_age_restriction_for_jobs))
		return 0

	if(!isnum(player_age) || player_age < 0)
		return 0

	if(!isnum(days_needed))
		return 0

	return max(0, days_needed - player_age)

/// Attempts to make the client orbit the given object, for administrative purposes.
/// If they are not an observer, will try to aghost them.
/client/proc/admin_follow(atom/movable/target)
	if(!isobserver(mob))
		SSadmin_verbs.dynamic_invoke_verb(src, /datum/admin_verb/admin_ghost)
		if(!isobserver(mob))
			return

	var/mob/dead/observer/observer = mob
	observer.ManualFollow(target)

GAME_VERB_DESC(/client, stop_client_sounds, "停止声音", "停止当前声音", "OOC")
	SEND_SOUND(usr, sound(null))
	tgui_panel?.stop_music()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Stop Self Sounds"))

GAME_VERB(/client, toggle_fullscreen, "切换全屏", "OOC")

	var/is_on = prefs.read_preference(/datum/preference/toggle/fullscreen_mode)
	prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/fullscreen_mode], !is_on)
	set_fullscreen()

/client/proc/set_fullscreen()
	winset(src, SKIN_MAINWINDOW, "is-fullscreen=[prefs?.read_preference(/datum/preference/toggle/fullscreen_mode) ? "true" : "false"]")
	attempt_auto_fit_viewport()

/// Clears the client's screen, aside from ones that opt out
/client/proc/clear_screen()
	for (var/object in screen)
		if (istype(object, /atom/movable/screen))
			var/atom/movable/screen/screen_object = object
			if (!screen_object.clear_with_screen)
				continue

		screen -= object

/// Handles any "fluff" or supplementary procedures related to an admin logout event. Should not have anything critically related cleaning up an admin's logout.
/client/proc/handle_admin_logout()
	adminGreet(logout = TRUE)
	if(length(GLOB.admins) > 0 || !SSticker.IsRoundInProgress()) // We only want to report this stuff if we are currently playing.
		return

	var/list/message_to_send = list()
	var/static/list/cheesy_messages = null

	if (isnull(cheesy_messages))
		cheesy_messages = list(
			"永远孤独 :(",
			"我线上没有管理员！",
			"我需要一个拥抱 :(",
			"我需要有人陪着我 :(",
			"我想要个男人 :(",
			"我孤零零一个人 :(",
			"我感觉好寂寞 :(",
			"我好寂寞 :(",
			"谁来抱抱我 :(",
			"发生什么了？大家都去哪了？",
			"大家都去哪了？",
			"为什么没人爱我？ :(",
		)

	message_to_send += pick(cheesy_messages)
	message_to_send += "（无管理员在线）"

	send2adminchat("服务器", jointext(message_to_send, " "))

/// This grabs the DPI of the user per their skin
/client/proc/acquire_dpi()
	window_scaling = text2num(winget(src, null, "dpi"))

#undef ADMINSWARNED_AT
#undef CURRENT_MINUTE
#undef CURRENT_SECOND
#undef LIMITER_SIZE
#undef MINUTE_COUNT
#undef SECOND_COUNT
