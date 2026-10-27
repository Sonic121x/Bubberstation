/mob/dead/new_player/Login()
	if(!client)
		return

	if(CONFIG_GET(flag/use_exp_tracking))
		client?.set_exp_from_db()
		client?.set_db_player_flags()
		if(!client)
			// client disconnected during one of the db queries
			return FALSE

	if(!mind)
		mind = new /datum/mind(key)
		mind.active = TRUE
		mind.set_current(src)

	// Check if user should be added to interview queue
	if (!client.holder && CONFIG_GET(flag/panic_bunker) && CONFIG_GET(flag/panic_bunker_interview) && !(client.ckey in GLOB.interviews.approved_ckeys))
		var/required_living_minutes = CONFIG_GET(number/panic_bunker_living)
		var/living_minutes = client.get_exp_living(TRUE)
		if (required_living_minutes >= living_minutes)
			client.interviewee = TRUE

	. = ..()
	if(!. || !client)
		return FALSE

	var/motd = global.config.motd
	if(motd)
		to_chat(src, "<div class=\"motd\">[motd]</div>", handle_whitespace=FALSE)

	if(GLOB.admin_notice)
		to_chat(src, span_notice("<b>管理员公告：</b>\n \t [GLOB.admin_notice]"))

	//SKYRAT EDIT ADDITION
	var/soft_player_cap = CONFIG_GET(number/player_soft_cap)
	if(soft_player_cap && TGS_CLIENT_COUNT >= soft_player_cap)
		INVOKE_ASYNC(src, PROC_REF(connect_to_second_server))
	//SKYRAT EDIT END

	var/spc = CONFIG_GET(number/soft_popcap)
	if(spc && living_player_count() >= spc)
		to_chat(src, span_notice("<b>服务器公告：</b>\n \t [CONFIG_GET(string/soft_popcap_message)]"))

	add_sight(SEE_TURFS)

	client.playtitlemusic()

	var/datum/asset/asset_datum = get_asset_datum(/datum/asset/simple/lobby)
	asset_datum.send(client)
	if(!client) // client disconnected during asset transit
		return FALSE

	// The parent call for Login() may do a bunch of stuff, like add verbs.
	// Delaying the register_for_interview until the very end makes sure it can clean everything up
	// and set the player's client up for interview.
	if(client.interviewee)
		register_for_interview()
		return

	if(SSticker.current_state < GAME_STATE_SETTING_UP)
		var/tl = SSticker.GetTimeLeft()
		to_chat(src, "请设置好你的角色并选择“准备就绪”。游戏将在 [tl > 0 ? "大约 [DisplayTimeText(tl)] 后" : "即将"] 开始。")

	if(GLOB.unrecommended_builds[num2text(client.byond_build)])
		INVOKE_ASYNC(src, PROC_REF(unrcommended_build_alert))

/mob/dead/new_player/proc/unrcommended_build_alert()
	var/warning = "嘿！你正在运行的 BYOND 版本（[client.byond_build]）存在一个或多个可能导致严重游戏中断的潜在问题。\n\n\
		你可以继续游玩，但请注意，游玩过程中可能会遇到以下问题：\n“[GLOB.unrecommended_builds[num2text(client.byond_build)]]”\n\n\
		如果可能，我们建议你更新 BYOND 版本。\n如果你已在使用最新版本，请改为从 www.byond.com/download/build 下载较早的发行版。"
	alert(src, warning, "BYOND 版本不佳", "确定")
