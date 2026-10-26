/datum/controller/subsystem/ticker
	var/list/job_estimation_list = list()

	// QOTR stuff
	var/quote_of_the_round_record_start
	var/quote_of_the_round_text
	var/quote_of_the_round_attribution
	var/quote_of_the_round_ckey

/datum/controller/subsystem/ticker/Initialize()
	. = ..()
	quote_of_the_round_record_start = rand(CONFIG_GET(number/quote_of_the_round_time_random_start), CONFIG_GET(number/quote_of_the_round_time_random_end))
	message_admins(
		span_notice("通知：本轮金句将在 [DisplayTimeText(quote_of_the_round_record_start,1)] 后选出。")
	)
	log_runtime("The quote of the round will be chosen in [DisplayTimeText(quote_of_the_round_record_start,1)].")

/datum/controller/subsystem/ticker/declare_completion(was_forced = END_ROUND_AS_NORMAL)
	handle_antag_tickets()
	handle_quote_of_the_round()
	handle_credits()

	. = ..()

/datum/controller/subsystem/ticker/proc/get_job_estimation(list/players)
	var/list/player_ready_data = list()
	sortTim(players, GLOBAL_PROC_REF(cmp_text_asc))

	for(var/ckey in players)
		var/mob/dead/new_player/player = players[ckey]
		var/datum/preferences/prefs = player.client?.prefs
		var/display = null
		var/datum/job/job_estimation = prefs?.get_highest_priority_job()
		var/title = job_estimation?.title
		// If a player does not have preferences (for some reason) or they don't want to be shown on the panel, continue
		if(!job_estimation || !(prefs.read_preference(/datum/preference/toggle/ready_job)))
			continue

		// If the job the player is selecting has a special name, that name should be displayed in the menu, otherwise it should use the normal name
		switch(title)
			if(JOB_AI)
				display = prefs.read_preference(/datum/preference/name/ai)
			if(JOB_CLOWN)
				display = prefs.read_preference(/datum/preference/name/clown)
			if(JOB_CYBORG)
				display = prefs.read_preference(/datum/preference/name/cyborg)
			if(JOB_MIME)
				display = prefs.read_preference(/datum/preference/name/mime)
			else
				display = prefs.read_preference(/datum/preference/name/real_name)
		// If our player is a member of Command or a Silicon, we want to sort them to the top of the list. Otherwise, just add them to the end of the list.
		if(job_estimation.departments_bitflags & (DEPARTMENT_BITFLAG_COMMAND | DEPARTMENT_BITFLAG_SILICON))
			player_ready_data.Insert(1, "* [display] 担任 [chinese_job_display(title)]")
		else
			player_ready_data += "* [display] 担任 [chinese_job_display(title)]"

	// The title line for the job estimation panel, obviously needs to be at the top
	if(length(player_ready_data))
		player_ready_data.Insert(1, "------------------")
		player_ready_data.Insert(1, "预计职务分配：")
		player_ready_data.Insert(1, "")
	return player_ready_data

/datum/controller/subsystem/ticker/proc/handle_antag_tickets()
	set waitfor = FALSE

	for(var/ckey in GLOB.preferences_datums)
		var/datum/preferences/prefs = GLOB.preferences_datums[ckey]
		if(prefs.antag_tickets == prefs.antag_tickets_old)
			continue //Only save if there has been a change.
		prefs.save_preferences()

/datum/controller/subsystem/ticker/proc/handle_credits()
	if(!GLOB.end_titles)
		GLOB.end_titles = generate_titles()

	for(var/client/C)
		if(!C?.credits)
			C?.RollCredits()

/datum/controller/subsystem/ticker/proc/handle_quote_of_the_round()
	if(quote_of_the_round_text)
		for(var/channel_tag in CONFIG_GET(str_list/channel_announce_new_game))
			send2chat(
				new /datum/tgs_message_content(generate_quote_of_the_round()),
				channel_tag
			)
		to_chat(world, span_notice("已选出本轮金句，应该已发送至 Discord。"))
		log_runtime("A quote of the round was found, and should have been sent to discord.")

	else
		if(world.time <= quote_of_the_round_record_start)
			to_chat(world, span_notice("本轮持续时间太短，无法选出本轮金句。"))
			log_runtime("A quote of the round could not be found. The round ended too early.")
		else
			to_chat(world, span_notice("未能选出本轮金句。也许船员们该表现得更令人难忘一些。"))
			log_runtime("A quote of the round could not be found. Perhaps the filters are too strict?")

/datum/controller/subsystem/ticker/proc/generate_quote_of_the_round()
	return "本班次已结束。准备好，新一轮即将在 **[SSmap_vote.next_map_config.map_name]** 开始！<@&[CONFIG_GET(string/game_alert_role_id)]>\n\
	本班次的金句（[pick(strings("quote_of_the_round.json", "workers"))] [pick(strings("quote_of_the_round.json", "action"))] [pick(strings("quote_of_the_round.json", "message"))]）：\n\
	> *[quote_of_the_round_text]*\n \\- *[quote_of_the_round_attribution]*"

/datum/controller/subsystem/ticker/proc/opfor_report()
	var/list/result = list()

	result += "<span class='header'>敌对势力报告：</span><br>"

	if(!SSopposing_force.approved_applications.len)
		result += span_red("没有申请获批。")
	else
		for(var/datum/opposing_force/opfor in SSopposing_force.approved_applications)
			result += opfor.roundend_report()

	return "<div class='panel stationborder'>[result.Join()]</div>"
