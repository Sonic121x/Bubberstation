/datum/controller/subsystem/map_vote/finalize_map_vote(datum/vote/map_vote/map_vote, winning_option) // BUBBER EDIT CHANGE - Ranked Choice Voting - add winning_option
	if(already_voted)
		message_admins("地图投票已结算，却再次尝试进行结算。")
		return
	already_voted = TRUE

	var/flat = CONFIG_GET(number/map_vote_flat_bonus)
	previous_cache = map_vote_cache.Copy()
	for(var/map_id in map_vote.choices)
		var/datum/map_config/map = config.maplist[map_id]
		map_vote_cache[map_id] += (map_vote.choices[map_id] * map.voteweight) + flat
	sanitize_cache()
	write_cache()
	update_tally_printout()

	if(admin_override)
		send_map_vote_notice("管理员覆盖设置已生效，地图不会更换。", "票数已记录并保存。")
		return


	// BUBBER EDIT CHANGE BEGIN - Ranked Choice Voting
	/*
	var/list/message_data = list()
	var/winner
	var/winner_amount = 0
	for(var/map in map_vote.choices)
		message_data += "[map] - [map_vote_cache[map]]"
		if(!winner_amount)
			winner = map
			winner_amount = map_vote_cache[map]
			continue
		if(map_vote_cache[map] <= winner_amount)
			continue
		winner = map
		winner_amount = map_vote_cache[map]

	var/filtered_vote_results = "[span_bold("投票结果（包括结转票数）")]\n\n[message_data.Join("\n")]"

	ASSERT(winner, "No winner found in map vote.")
	set_next_map(config.maplist[winner])
	var/list/vote_result_message = list(filtered_vote_results)
	vote_result_message += list("<hr>下一张地图：[span_cyan(span_bold(next_map_config.map_name))]")
	var/carryover_percentage = CONFIG_GET(number/map_vote_tally_carryover_percentage)
	if(carryover_percentage)
		vote_result_message += list("\n落选地图的票数将有 [CONFIG_GET(number/map_vote_tally_carryover_percentage)]% 结转至下一次地图投票。")

	// do not reset tallies if only one map is even possible
	if(length(map_vote.choices) > 1)
		map_vote_cache[winner] = CONFIG_GET(number/map_vote_minimum_tallies)
		write_cache()
		update_tally_printout()
	else
		vote_result_message += "只有一张地图可供选择，票数未重置。"
	*/
	set_next_map(config.maplist[winning_option])
	var/list/vote_results = map_vote.elimination_results
	var/serialized_vote_results = "[vote_results.Join("\n")]"
	var/list/vote_result_message = list("方式：排序投票\n\n淘汰顺序：\n[serialized_vote_results]\n\n下一张地图：[span_vote_notice(span_bold(winning_option))]")
	// BUBBER EDIT CHANGE END - Ranked Choice Voting

	send_map_vote_notice(arglist(vote_result_message))

/datum/controller/subsystem/map_vote/send_map_vote_notice(...)
	var/static/last_message_at
	if(last_message_at == world.time)
		message_admins("同一游戏刻内调用了两次 send_map_vote_notice。请通知开发者合并消息。")
	last_message_at = world.time

	var/list/messages = args.Copy()
	//to_chat(world, custom_boxed_message("purple_box", vote_font("[span_bold("Map Vote")]\n<hr>[messages.Join("\n")]"))) // BUBBER EDIT CHANGE - Ranked Choice Voting
	to_chat(world, vote_font(fieldset_block("地图投票——结果", "[messages.Join("\n")]", "boxed_message purple_box")))

/datum/controller/subsystem/map_vote/update_tally_printout()
	var/list/data = list()
	for(var/map_id in map_vote_cache)
		var/datum/map_config/map = config.maplist[map_id]
		data += "[map.map_name] - [map_vote_cache[map_id]]"
	tally_printout = "[span_bold("当前地图票数（包括结转票数）")]\n\n[data.Join("\n")]"
