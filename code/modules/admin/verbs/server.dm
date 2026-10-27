// Server Tab - Server Verbs

ADMIN_VERB(toggle_random_events, R_SERVER, "切换随机事件", "开启或关闭随机事件。", ADMIN_CATEGORY_SERVER)
	var/new_are = !CONFIG_GET(flag/allow_random_events)
	CONFIG_SET(flag/allow_random_events, new_are)
	message_admins("[key_name_admin(user)] [new_are ? "启用" : "禁用"]了随机事件。")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Random Events", "[new_are ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

ADMIN_VERB(toggle_hub, R_SERVER, "切换 Hub", "切换服务器在 BYOND Hub 上的可见性。", ADMIN_CATEGORY_SERVER)
	world.update_hub_visibility(!GLOB.hub_visibility)

	log_admin("[key_name(user)] 切换了本回合服务器的 Hub 状态，现在 Hub 显示为[(GLOB.hub_visibility?"开启":"关闭")]。")
	message_admins("[key_name_admin(user)] 切换了本回合服务器的 Hub 状态，现在 Hub 显示为[(GLOB.hub_visibility?"开启":"关闭")]。")
	if (GLOB.hub_visibility && !world.reachable)
		message_admins("警告：服务器不会出现在 Hub 上，因为 BYOND 检测到有防火墙正在阻止传入连接。")

	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggled Hub Visibility", "[GLOB.hub_visibility ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

#define REGULAR_RESTART "Regular Restart"
#define REGULAR_RESTART_DELAYED "Regular Restart (with delay)"
#define NO_EVENT_RESTART "Restart, Skip TGS Event"
#define HARD_RESTART "Hard Restart (No Delay/Feedback Reason)"
#define HARDEST_RESTART "Hardest Restart (No actions, just reboot)"
#define TGS_RESTART "Server Restart (Kill and restart DD)"
ADMIN_VERB(restart, R_SERVER, "重启世界", "立即重启世界。", ADMIN_CATEGORY_SERVER)
	var/list/options = list(REGULAR_RESTART, REGULAR_RESTART_DELAYED, HARD_RESTART)

	// this option runs a codepath that can leak db connections because it skips subsystem (specifically SSdbcore) shutdown
	if(!SSdbcore.IsConnected())
		options += HARDEST_RESTART

	if(world.TgsAvailable())
		options.Insert(3, NO_EVENT_RESTART)
		options += TGS_RESTART;

	if(SSticker.admin_delay_notice)
		if(alert(user, "确定吗？已有管理员以如下理由延迟了回合结束：[SSticker.admin_delay_notice]", "确认", "Yes", "No") != "Yes")
			return FALSE

	var/result = input(user, "选择重启方式", "世界重启", options[1]) as null|anything in options
	if(isnull(result))
		return

	BLACKBOX_LOG_ADMIN_VERB("Reboot World")
	var/init_by = "由[user.holder.fakekey ? "管理员" : user.key]发起。"
	switch(result)
		if(REGULAR_RESTART, REGULAR_RESTART_DELAYED, NO_EVENT_RESTART)
			var/delay = 1
			if(result == REGULAR_RESTART_DELAYED)
				delay = input("重启应延迟多久（秒）？", "重启延迟", 5) as num|null
			if(!delay)
				return FALSE
			if(!user.is_localhost())
				if(alert(user,"确定要重启服务器吗？","此服务器正在运行", "重启", "取消") != "重启")
					return FALSE

			if (result != NO_EVENT_RESTART)
				SSticker.TriggerRoundEndTgsEvent()

			SSticker.Reboot(init_by, "admin reboot - by [user.key] [user.holder.fakekey ? "(stealth)" : ""]", delay * 10)
		if(HARD_RESTART)
			to_chat(world, "世界重启 - [init_by]")
			world.Reboot()
		if(HARDEST_RESTART)
			to_chat(world, "硬重启世界 - [init_by]")
			world.Reboot(fast_track = TRUE)
		if(TGS_RESTART)
			to_chat(world, "服务器重启 - [init_by]")
			world.TgsEndProcess()

#undef REGULAR_RESTART
#undef REGULAR_RESTART_DELAYED
#undef NO_EVENT_RESTART
#undef HARD_RESTART
#undef HARDEST_RESTART
#undef TGS_RESTART

ADMIN_VERB(cancel_reboot, R_SERVER, "取消重启", "取消待执行的世界重启。", ADMIN_CATEGORY_SERVER)
	if(!SSticker.cancel_reboot(user))
		return
	log_admin("[key_name(user)] 取消了待执行的世界重启。")
	message_admins("[key_name_admin(user)] 取消了待执行的世界重启。")

ADMIN_VERB(end_round, R_SERVER, "结束回合", "强制结束回合并允许服务器正常重启。", ADMIN_CATEGORY_SERVER)
	var/confirm = tgui_alert(user, "结束本回合并重启游戏世界？", "结束回合", list("Yes", "Cancel"))
	if(confirm != "Yes")
		return
	SSticker.force_ending = FORCE_END_ROUND
	BLACKBOX_LOG_ADMIN_VERB("End Round")

ADMIN_VERB(toggle_ooc, R_ADMIN, "切换 OOC", "开启或关闭 OOC 频道。", ADMIN_CATEGORY_SERVER)
	toggle_ooc()
	log_admin("[key_name(user)] 切换了 OOC。")
	message_admins("[key_name_admin(user)] 切换了 OOC。")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle OOC", "[GLOB.ooc_allowed ? "Enabled" : "Disabled"]"))

ADMIN_VERB(toggle_ooc_dead, R_ADMIN, "切换死亡 OOC", "开启或关闭死亡玩家的 OOC 频道。", ADMIN_CATEGORY_SERVER)
	toggle_dooc()
	log_admin("[key_name(user)] 切换了 OOC。")
	message_admins("[key_name_admin(user)] 切换了死亡 OOC。")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Dead OOC", "[GLOB.dooc_allowed ? "Enabled" : "Disabled"]"))

ADMIN_VERB(toggle_vote_dead, R_ADMIN, "切换死亡投票", "开启或关闭死亡玩家的投票。", ADMIN_CATEGORY_SERVER)
	SSvote.toggle_dead_voting(user)

ADMIN_VERB(start_now, R_SERVER, "立即开始", "立刻开始本回合。", ADMIN_CATEGORY_SERVER)
	var/static/list/waiting_states = list(GAME_STATE_PREGAME, GAME_STATE_STARTUP)
	if(!(SSticker.current_state in waiting_states))
		to_chat(user, span_warning(span_red("游戏已经开始了！")))
		return

	if(SSticker.start_immediately)
		SSticker.start_immediately = FALSE
		SSticker.SetTimeLeft(3 MINUTES)
		to_chat(world, span_big(span_notice("游戏将在 3 分钟后开始。")))
		SEND_SOUND(world, sound('sound/announcer/default/attention.ogg'))
		message_admins(span_adminnotice("[key_name_admin(user)] 取消了立即开始。游戏将在 3 分钟后开始。"))
		log_admin("[key_name(user)] 取消了立即开始。")
		return

	if(!user.is_localhost())
		var/response = tgui_alert(user, "确定要开始本回合吗？", "立即开始", list("Start Now", "Cancel"))
		if(response != "Start Now")
			return
	SSticker.start_immediately = TRUE

	log_admin("[key_name(user)] 开始了游戏。")
	message_admins("[key_name_admin(user)] 开始了游戏。")
	if(SSticker.current_state == GAME_STATE_STARTUP)
		message_admins("服务器仍在设置中，但本回合会尽快开始。")
	BLACKBOX_LOG_ADMIN_VERB("Start Now")

// ADMIN_VERB(delay_round_end, R_SERVER, "Delay Round End", "Prevent the server from restarting.", ADMIN_CATEGORY_SERVER)
ADMIN_VERB(delay_round_end, R_ADMIN, "延迟回合结束", "阻止服务器重启。", ADMIN_CATEGORY_SERVER) // SKYRAT EDIT -- ORIGINAL ABOVE
	if(SSticker.delay_end)
		tgui_alert(user, "回合结束已被延迟。当前延迟的原因是：“[SSticker.admin_delay_notice]”", "提示", list("确定"))
		return

	var/delay_reason = input(user, "输入延迟回合结束的原因", "回合延迟原因") as null|text

	if(isnull(delay_reason))
		return

	if(SSticker.delay_end)
		tgui_alert(user, "回合结束已被延迟。当前延迟的原因是：“[SSticker.admin_delay_notice]”", "提示", list("确定"))
		return

	SSticker.delay_end = TRUE
	SSticker.admin_delay_notice = delay_reason
	if(SSticker.reboot_timer)
		SSticker.cancel_reboot(user)

	log_admin("[key_name(user)] 因以下原因延迟了回合结束：[SSticker.admin_delay_notice]")
	message_admins("[key_name_admin(user)] 因以下原因延迟了回合结束：[SSticker.admin_delay_notice]")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Delay Round End", "Reason: [delay_reason]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

ADMIN_VERB(toggle_enter, R_SERVER, "切换进入游戏", "开启或关闭进入游戏的功能。", ADMIN_CATEGORY_SERVER)
	if(!SSlag_switch.initialized)
		return
	SSlag_switch.set_measure(DISABLE_NON_OBSJOBS, !SSlag_switch.measures[DISABLE_NON_OBSJOBS])
	log_admin("[key_name(user)] 切换了新玩家进入游戏功能。Lag Switch 索引 ([DISABLE_NON_OBSJOBS])")
	message_admins("[key_name_admin(user)] 切换了新玩家进入游戏：[SSlag_switch.measures[DISABLE_NON_OBSJOBS] ? "关闭" : "开启"]。")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Entering", "[!SSlag_switch.measures[DISABLE_NON_OBSJOBS] ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

ADMIN_VERB(toggle_ai, R_SERVER, "切换 AI", "开启或关闭选择 AI 职业的功能。", ADMIN_CATEGORY_SERVER)
	var/alai = CONFIG_GET(flag/allow_ai)
	CONFIG_SET(flag/allow_ai, !alai)
	if (alai)
		to_chat(world, span_bold("AI 职业现在已不可选择。"), confidential = TRUE)
	else
		to_chat(world, "<B>AI 职业现在可以选择。</B>", confidential = TRUE)
	log_admin("[key_name(user)] 切换了 AI 允许状态。")
	world.update_status()
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle AI", "[!alai ? "Disabled" : "Enabled"]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

ADMIN_VERB(toggle_respawn, R_SERVER, "切换重生", "开启或关闭重生功能。", ADMIN_CATEGORY_SERVER)
	var/respawn_state = CONFIG_GET(flag/allow_respawn)
	var/new_state = -1
	var/new_state_text = ""
	switch(respawn_state)
		if(RESPAWN_FLAG_DISABLED) // respawn currently disabled
			new_state = RESPAWN_FLAG_FREE
			new_state_text = "Enabled"
			to_chat(world, span_bold("你现在可以重生了。"), confidential = TRUE)

		if(RESPAWN_FLAG_FREE) // respawn currently enabled
			new_state = RESPAWN_FLAG_NEW_CHARACTER
			new_state_text = "Enabled, Different Slot"
			to_chat(world, span_bold("你现在可以以另一个角色重生了。"), confidential = TRUE)

		if(RESPAWN_FLAG_NEW_CHARACTER) // respawn currently enabled for different slot characters only
			new_state = RESPAWN_FLAG_DISABLED
			new_state_text = "Disabled"
			to_chat(world, span_bold("你不能再重生了。"), confidential = TRUE)

		else
			WARNING("Invalid respawn state in config: [respawn_state]")

	if(new_state == -1)
		to_chat(user, span_warning("重生配置设置有误，请向你最近的服务器主机反映（或者自己修好它）。\
			在此期间，重生已设为“关闭”。"))
		new_state = RESPAWN_FLAG_DISABLED
		new_state_text = "Disabled"

	CONFIG_SET(flag/allow_respawn, new_state)

	message_admins(span_adminnotice("[key_name_admin(user)] 将重生设置为“[new_state_text]”。"))
	log_admin("[key_name(user)] 将重生设置为“[new_state_text]”。")

	world.update_status()
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Respawn", "[new_state_text]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

ADMIN_VERB(delay, R_SERVER, "延迟开局", "延迟游戏开始。", ADMIN_CATEGORY_SERVER)
	var/newtime = input(user, "以秒为单位设置新时间。设为 -1 表示无限期延迟。", "设置延迟", round(SSticker.GetTimeLeft()/10)) as num|null
	if(!newtime)
		return
	if(SSticker.current_state > GAME_STATE_PREGAME)
		return tgui_alert(user, "太晚了……游戏已经开始了！")
	newtime = newtime*10
	SSticker.SetTimeLeft(newtime)
	SSticker.start_immediately = FALSE
	if(newtime < 0)
		to_chat(world, span_infoplain("<b>游戏开始已被延迟。</b>"), confidential = TRUE)
		log_admin("[key_name(user)] 延迟了回合开始。")
	else
		to_chat(world, span_infoplain(span_bold("游戏将在[DisplayTimeText(newtime)]后开始。")), confidential = TRUE)
		SEND_SOUND(world, sound('sound/announcer/default/attention.ogg'))
		log_admin("[key_name(user)] 将开局延迟设为[DisplayTimeText(newtime)]。")
	BLACKBOX_LOG_ADMIN_VERB("Delay Game Start")

ADMIN_VERB(set_admin_notice, R_SERVER, "设置管理员公告", "设置一条所有加入服务器的人都会看到的公告。仅本回合有效。", ADMIN_CATEGORY_SERVER)
	var/new_admin_notice = input(
		user,
		"为本回合设置一条公开公告，所有加入服务器的人都将看到。\n（留空将删除当前公告）：",
		"设置公告",
		GLOB.admin_notice,
	) as message|null
	if(new_admin_notice == null)
		return
	if(new_admin_notice == GLOB.admin_notice)
		return
	if(new_admin_notice == "")
		message_admins("[key_name(user)] 移除了管理员公告。")
		log_admin("[key_name(user)] 移除了管理员公告：\n[GLOB.admin_notice]")
	else
		message_admins("[key_name(user)] 设置了管理员公告。")
		log_admin("[key_name(user)] 设置了管理员公告：\n[new_admin_notice]")
		to_chat(world, span_adminnotice("<b>管理员公告：</b>\n \t [new_admin_notice]"), confidential = TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Set Admin Notice")
	GLOB.admin_notice = new_admin_notice

ADMIN_VERB(toggle_guests, R_SERVER, "切换访客", "开启或关闭访客进入游戏的功能。", ADMIN_CATEGORY_SERVER)
	var/new_guest_ban = !CONFIG_GET(flag/guest_ban)
	CONFIG_SET(flag/guest_ban, new_guest_ban)
	if (new_guest_ban)
		to_chat(world, span_bold("访客不能再进入游戏。"), confidential = TRUE)
	else
		to_chat(world, "<B>访客现在可以进入游戏。</B>", confidential = TRUE)
	log_admin("[key_name(user)] 切换了访客进入游戏：现在[!new_guest_ban ? "允许" : "不允许"]。")
	message_admins(span_adminnotice("[key_name_admin(user)] 切换了访客进入游戏：现在[!new_guest_ban ? "允许" : "不允许"]。"))
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Guests", "[!new_guest_ban ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!
