/// Called when the shuttle starts launching back to centcom, polls a few random players who joined the round for commendations
/datum/controller/subsystem/ticker/proc/poll_hearts()
	if(!CONFIG_GET(number/commendation_percent_poll))
		return

	var/number_to_ask = round(LAZYLEN(GLOB.joined_player_list) * CONFIG_GET(number/commendation_percent_poll)) + rand(0,1)
	if(number_to_ask == 0)
		message_admins("符合条件的玩家不足，无法征询表扬提名。")
		return
	message_admins("正在向 [number_to_ask] 名玩家征询表扬提名。")

	// We need the list to be random, otherwise we'll end up always asking the same people to give out commendations.
	var/list/eligible_player_list = shuffle(GLOB.joined_player_list)

	for(var/i in eligible_player_list)
		var/mob/check_mob = get_mob_by_ckey(i)
		if(!check_mob?.mind || !check_mob.client)
			continue
		// maybe some other filters like bans or whatever
		INVOKE_ASYNC(check_mob, TYPE_PROC_REF(/mob, query_heart), 1)
		number_to_ask--
		if(number_to_ask <= 0)
			break

/// Once the round is actually over, cycle through the ckeys in the hearts list and give them the hearted status
/datum/controller/subsystem/ticker/proc/handle_hearts()
	var/list/message = list("以下玩家在本回合获得了表扬：")
	var/i = 0
	for(var/hearted_ckey in hearts)
		i++
		var/mob/hearted_mob = get_mob_by_ckey(hearted_ckey)
		if(!hearted_mob?.client)
			continue
		hearted_mob.client.adjust_heart()
		message += "[hearted_ckey][i == hearts.len ? "" : ", "]"
	message_admins(message.Join())

/// Ask someone if they'd like to award a commendation for the round, 3 tries to get the name they want before we give up
/mob/proc/query_heart(attempt=1)
	if(!client || attempt > 3)
		return
	if(attempt == 1 && tgui_alert(src, "本回合是否有其他角色表现友善，让你想匿名表达感谢？", "<3?", list("是", "否"), timeout = 30 SECONDS) != "是")
		return

	var/heart_nominee
	switch(attempt)
		if(1)
			heart_nominee = tgui_input_text(src, "对方叫什么名字？只输入姓或名也可能足够。", "<3?", max_length = MAX_NAME_LEN)
		if(2)
			heart_nominee = tgui_input_text(src, "再试一次，对方叫什么名字？只输入姓或名也可能足够。", "<3?", max_length = MAX_NAME_LEN)
		if(3)
			heart_nominee = tgui_input_text(src, "最后再试一次，对方叫什么名字？只输入姓或名也可能足够。", "<3?", max_length = MAX_NAME_LEN)

	if(!heart_nominee)
		return

	heart_nominee = LOWER_TEXT(heart_nominee)
	var/list/name_checks = get_mob_by_name(heart_nominee)
	if(!name_checks || name_checks.len == 0)
		query_heart(attempt + 1)
		return
	name_checks = shuffle(name_checks)

	for(var/i in name_checks)
		var/mob/heart_contender = i
		if(heart_contender == src)
			continue

		switch(tgui_alert(src, "是这个人吗：[heart_contender.real_name]？", "<3?", list("没错！", "不是", "取消"), timeout = 15 SECONDS))
			if("没错！")
				heart_contender.receive_heart(src)
				return
			if("不是")
				continue
			else
				return

	query_heart(attempt + 1)

/*
* Once we've confirmed who we're commending, either set their status now or log it for the end of the round
*
* This used to be reversed, being named nominate_heart and being called on the mob sending the commendation and the first argument being
* the heart_recepient, but that was confusing and unintuitive, so now src is the person being commended and the sender is now the first argument.
*
* Arguments:
* * heart_sender: The reference to the mob who sent the commendation, just for the purposes of logging
* * duration: How long from the moment it's applied the heart will last
* * instant: If TRUE (or if the round is already over), we'll give them the heart status now, if FALSE, we wait until the end of the round (which is the standard behavior)
*/
/mob/proc/receive_heart(mob/heart_sender, duration = 24 HOURS, instant = FALSE)
	if(!client)
		return
	to_chat(heart_sender, span_nicegreen("表扬已送出！"))
	message_admins("[key_name(heart_sender)] 表扬了 [key_name(src)] [instant ? "（立即生效）" : ""]")
	log_admin_private("[key_name(heart_sender)] 表扬了 [key_name(src)] [instant ? "（立即生效）" : ""]")
	if(instant || SSticker.current_state == GAME_STATE_FINISHED)
		client.adjust_heart(duration)
	else
		LAZYADD(SSticker.hearts, ckey)
