/datum/tgs_chat_command/tgscheck
	name = "check"
	help_text = "获取服务器的人数、游戏模式和地址"

/datum/tgs_chat_command/tgscheck/Run(datum/tgs_chat_user/sender, params)
	var/server = CONFIG_GET(string/public_address) || CONFIG_GET(string/server)
	return new /datum/tgs_message_content("[GLOB.round_id ? "第 #[GLOB.round_id] 回合：" : ""][GLOB.clients.len] 名玩家在 [SSmapping.current_map.map_name] 上；回合状态 [SSticker.HasRoundStarted() ? (SSticker.IsRoundInProgress() ? "进行中" : "收尾中") : "启动中"] —— [server ? server : "[world.internet_address]:[world.port]"]")

/datum/tgs_chat_command/gameversion
	name = "gameversion"
	help_text = "基本上就是从 show-server-revision 动词获取版本详情"

/datum/tgs_chat_command/gameversion/Run(datum/tgs_chat_user/sender, params)
	var/list/msg = list("")
	msg += "BYOND 服务器版本：[world.byond_version].[world.byond_build]（编译版本：[DM_VERSION].[DM_BUILD]）\n"

	if (!GLOB.revdata)
		msg += "未找到修订信息。"
	else
		msg += "修订 [copytext_char(GLOB.revdata.commit, 1, 9)]"
		if (GLOB.revdata.date)
			msg += " 编译于 '[GLOB.revdata.date]'"

		if(GLOB.revdata.originmastercommit)
			msg += "，来自原始提交：<[CONFIG_GET(string/githuburl)]/commit/[GLOB.revdata.originmastercommit]>"

		if(GLOB.revdata.testmerge.len)
			msg += "\n"
			for(var/datum/tgs_revision_information/test_merge/PR as anything in GLOB.revdata.testmerge)
				msg += "PR #[PR.number] 位于 [copytext_char(PR.head_commit, 1, 9)] [PR.title]。\n"
				if (PR.url)
					msg += "<[PR.url]>\n"
	return new /datum/tgs_message_content(msg.Join(""))

// Notify
/datum/tgs_chat_command/notify
	name = "notify"
	help_text = "回合结束时提醒发起者"

/datum/tgs_chat_command/notify/Run(datum/tgs_chat_user/sender, params)
	if(!CONFIG_GET(str_list/channel_announce_new_game))
		return new /datum/tgs_message_content("通知功能当前已禁用")

	for(var/member in SSdiscord.notify_members) // If they are in the list, take them out
		if(member == sender.mention)
			SSdiscord.notify_members -= sender.mention
			return new /datum/tgs_message_content("服务器重启时你将不再收到通知")

	// If we got here, they arent in the list. Chuck 'em in!
	SSdiscord.notify_members += sender.mention
	return new /datum/tgs_message_content("服务器重启时你将会收到通知")
