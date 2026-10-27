#define MAP_VOTE_CACHE_LOCATION "data/map_vote_cache.json"

SUBSYSTEM_DEF(map_vote)
	name = "地图投票"
	ss_flags = SS_NO_FIRE

	/// Has an admin specifically set a map.
	var/admin_override = FALSE

	/// Have we already done a vote.
	var/already_voted = FALSE

	/// The map that has been chosen for next round.
	var/datum/map_config/next_map_config

	/// Stores the current map vote cache, so that players can look at the current tally.
	var/list/map_vote_cache

	/// Stores the previous map vote cache, used when a map vote is reverted.
	var/list/previous_cache

	/// Stores the last amount of potential players to compare next time we're called
	var/player_cache = -1

	/// Cached list of votable maps
	var/list/votable_map_cache

	/// Stores a formatted html string of the tally counts
	var/tally_printout = span_red("加载中……")

/datum/controller/subsystem/map_vote/Initialize()
	if(rustg_file_exists(MAP_VOTE_CACHE_LOCATION))
		map_vote_cache = json_decode(file2text(MAP_VOTE_CACHE_LOCATION))
		var/carryover = 0 // BUBBER EDIT CHANGE - Ranked Choice Voting - Original: CONFIG_GET(number/map_vote_tally_carryover_percentage)
		for(var/map_id in map_vote_cache)
			map_vote_cache[map_id] = round(map_vote_cache[map_id] * (carryover / 100))
		sanitize_cache()
	else
		map_vote_cache = list()
	update_tally_printout()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/map_vote/proc/write_cache()
	rustg_file_write(json_encode(map_vote_cache), MAP_VOTE_CACHE_LOCATION)

/datum/controller/subsystem/map_vote/proc/sanitize_cache()
	var/max = CONFIG_GET(number/map_vote_maximum_tallies)
	for(var/map_id in map_vote_cache)
		if(!(map_id in config.maplist))
			map_vote_cache -= map_id
		var/count = map_vote_cache[map_id]
		if(count > max)
			map_vote_cache[map_id] = max

/datum/controller/subsystem/map_vote/proc/send_map_vote_notice(...)
	var/static/last_message_at
	if(last_message_at == world.time)
		message_admins("同一个游戏 tick 内调用了两次 send_map_vote_notice。请联系开发人员合并消息。")
	last_message_at = world.time

	var/list/messages = args.Copy()
	to_chat(world, span_purple(boxed_message("地图投票<br><hr>[jointext(messages, "<br>")]")))

/datum/controller/subsystem/map_vote/proc/finalize_map_vote(datum/vote/map_vote/map_vote)
	if(already_voted)
		message_admins("地图投票已经结算，但系统再次尝试结算。")
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
		send_map_vote_notice("管理员指定的地图已生效，不会更换地图。", "票数已记录并保存。")
		return

	var/winner
	var/winner_amount = 0
	for(var/map in map_vote.choices)
		if(!winner_amount)
			winner = map
			winner_amount = map_vote_cache[map]
			continue
		if(map_vote_cache[map] <= winner_amount)
			continue
		winner = map
		winner_amount = map_vote_cache[map]

	ASSERT(winner, "No winner found in map vote.")
	set_next_map(config.maplist[winner])
	var/list/messages = list("已选地图 - [span_bold(next_map_config.map_name)]")
	messages += "选定时的累计票数："
	messages += tally_printout

	// do not reset tallies if only one map is even possible
	if(length(map_vote.choices) > 1)
		map_vote_cache[winner] = CONFIG_GET(number/map_vote_minimum_tallies)
		write_cache()
		update_tally_printout()
	else
		messages += "只有一张地图可选，累计票数未重置。"

	send_map_vote_notice(arglist(messages))

/// Returns a list of all map options that are invalid for the current population.
/datum/controller/subsystem/map_vote/proc/get_valid_map_vote_choices()
	var/filter_threshold = 0
	if(SSticker.HasRoundStarted())
		filter_threshold = get_active_player_count(alive_check = FALSE, afk_check = TRUE, human_check = FALSE)
	else
		filter_threshold = length(GLOB.clients)

	// Cached because it's called off ui_data, I really don't think this is worth it but whatever
	if(filter_threshold == player_cache && !isnull(votable_map_cache))
		return votable_map_cache.Copy()

	player_cache = filter_threshold
	var/list/pop_valid_maps = list()
	// Fill in our default choices with all of the maps in our map config, if they are votable and not blocked.
	var/list/maps = shuffle(global.config.maplist)
	for(var/map in maps)
		var/datum/map_config/possible_config = config.maplist[map]
		if(!possible_config.votable)
			continue
		if(possible_config.config_min_users > 0 && filter_threshold < possible_config.config_min_users)
			continue
		if(possible_config.config_max_users > 0 && filter_threshold > possible_config.config_max_users)
			continue
		pop_valid_maps += possible_config.map_name

	// Remove stale (played twice in the past KEEP_ROUNDS_MAP + 1 rounds (including this one as the + 1)) maps
	var/list/freshened_valid_maps = list()
	for(var/map_name in pop_valid_maps)
		if(map_name in SSpersistence.blocked_maps)
			continue
		freshened_valid_maps += map_name

	// We might stale out all valid maps, in that case just ignore the stale system
	if(!length(freshened_valid_maps))
		votable_map_cache = pop_valid_maps.Copy()
		return pop_valid_maps

	votable_map_cache = freshened_valid_maps.Copy()
	return freshened_valid_maps

/datum/controller/subsystem/map_vote/proc/filter_cache_to_valid_maps()
	var/connected_players = length(GLOB.player_list)
	var/list/valid_maps = list()
	for(var/map_id in map_vote_cache)
		var/datum/map_config/map = config.maplist[map_id]
		if(!map.votable)
			continue
		if(map.config_min_users > 0 && (connected_players < map.config_min_users))
			continue
		if(map.config_max_users > 0 && (connected_players > map.config_max_users))
			continue
		valid_maps[map_id] = map_vote_cache[map_id]
	return valid_maps

/datum/controller/subsystem/map_vote/proc/set_next_map(datum/map_config/change_to)
	if(!change_to.MakeNextMap())
		message_admins("无法通过 next_map.json 将新地图设为 [change_to.map_name]！")
		return FALSE

	next_map_config = change_to
	return TRUE

/datum/controller/subsystem/map_vote/proc/revert_next_map(client/user)
	if(!next_map_config)
		return
	if(previous_cache)
		map_vote_cache = previous_cache
		previous_cache = null

	already_voted = FALSE
	admin_override = FALSE
	next_map_config = null

	if(!isnull(user))
		message_admins("[key_name_admin(user)] 撤销了下一张地图的选择。投票已重新开放。")
		log_admin("[key_name_admin(user)] 撤销了下一张地图的选择。")
	send_map_vote_notice("已撤销下一张地图的选择。投票已重新开放。")

#undef MAP_VOTE_CACHE_LOCATION

/datum/controller/subsystem/map_vote/proc/update_tally_printout()
	var/list/data = list()
	for(var/map_id in map_vote_cache)
		var/datum/map_config/map = config.maplist[map_id]
		data += "[map.map_name] - [map_vote_cache[map_id]]"
	var/tally_msg = span_tooltip("地图赢得投票后，其累计票数会被重置。\
		否则，票数将保留到下一回合，并与下一次投票的票数相加，\
		直到该地图最终胜出后重置。", "当前累计票数")
	tally_printout = boxed_message("[tally_msg]<br><hr>[jointext(data, "<br>")]")
