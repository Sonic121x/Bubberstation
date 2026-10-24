SUBSYSTEM_DEF(statpanels)
	name = "状态面板"
	wait = 4
	priority = FIRE_PRIORITY_STATPANEL
	runlevels = RUNLEVELS_DEFAULT | RUNLEVEL_LOBBY
	ss_flags = SS_NO_INIT
	var/list/currentrun = list()
	var/list/global_data
	var/list/mc_data

	///how many subsystem fires between most tab updates
	var/default_wait = 10
	///how many subsystem fires between updates of the status tab
	var/status_wait = 2
	///how many subsystem fires between updates of the MC tab
	var/mc_wait = 5
	///how many full runs this subsystem has completed. used for variable rate refreshes.
	var/num_fires = 0

/datum/controller/subsystem/statpanels/fire(resumed = FALSE)
	if (!resumed)
		num_fires++
		var/datum/map_config/cached = SSmap_vote.next_map_config

		if(isnull(SSmapping.current_map))
			global_data = list("加载中")
		else if(SSmapping.current_map.feedback_link)
			global_data = list(list("地图：[SSmapping.current_map.map_name]", " （反馈）", "action=openLink&link=[SSmapping.current_map.feedback_link]"))
		else
			global_data = list("地图：[SSmapping.current_map?.map_name]")

		if(SSmapping.current_map?.mapping_url)
			global_data += list(list("same_line", " | （在浏览器中查看）", "action=openWebMap"))

		if(cached)
			global_data += "下一张地图：[cached.map_name]"

		// BUBBER EDIT ADDITION BEGIN - Extra stat panel info
		var/real_round_time = world.timeofday - SSticker.real_round_start_time
		var/active_players = get_active_player_count(alive_check = FALSE, afk_check = TRUE, human_check = FALSE) //This is a list of all active players, including players who are dead
		var/observing_players = length(GLOB.current_observers_list) //This is a list of all players that started as an observer-- dead and lobby players are not included.
		//var/current_date = "[time2text(world.realtime, "DDD Month DD")], [CURRENT_STATION_YEAR]" //Unused var for now.
		// BUBBER EDIT ADDITION END - Extra stat panel info

		global_data += list(
			"回合编号：[GLOB.round_id ? GLOB.round_id : "无"]",
			"已连接：[GLOB.clients.len] | 活跃：[active_players]/[CONFIG_GET(number/hard_popcap)] | 观察中：[observing_players]", // BUBBER EDIT ADDITION - Extra stat panel info
			"OOC：[GLOB.ooc_allowed ? "启用" : "禁用"]", // BUBBER EDIT ADDITION - Extra stat panel info
			" ", // BUBBER EDIT ADDITION - Extra stat panel info
			"故事讲述者：[SSgamemode.storyteller ? SSgamemode.storyteller.name : "无"]", // BUBBER EDIT ADDITION - Extra stat panel info
			"空间站时间：[server_timestamp(format = "YYYY-MM-DD hh:mm:ss", ic_time = TRUE)]",
			"回合时长：[time2text(real_round_time, "hh:mm:ss", 0)]", // BUBBER EDIT CHANGE - Extra stat panel info - ORIGINAL: "Round Time: [ROUND_TIME()]"
			"服务器时间：[time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss", world.timezone)]",
			"时间膨胀：[round(SStime_track.time_dilation_current,1)]% 平均：([round(SStime_track.time_dilation_avg_fast,1)]%, [round(SStime_track.time_dilation_avg,1)]%, [round(SStime_track.time_dilation_avg_slow,1)]%)",
		)

		if(SSshuttle.emergency)
			var/ETA = SSshuttle.emergency.getModeStr()
			if(ETA)
				global_data += "[ETA] [SSshuttle.emergency.getTimerStr()]"

		src.currentrun = GLOB.clients.Copy()
		mc_data = null

	var/list/currentrun = src.currentrun
	while(length(currentrun))
		var/client/target = currentrun[length(currentrun)]
		currentrun.len--

		if(!target.stat_panel.is_ready())
			continue

		if(target.stat_tab == "Status" && num_fires % status_wait == 0)
			set_status_tab(target)

		if(!target.holder)
			target.stat_panel.send_message("remove_admin_tabs")
		else
			target.stat_panel.send_message("update_split_admin_tabs", !!(target.prefs.toggles & SPLIT_ADMIN_TABS))

			if(!("MC" in target.panel_tabs) || !("Tickets" in target.panel_tabs))
				target.stat_panel.send_message("add_admin_tabs", target.holder.href_token)

			if(target.stat_tab == "MC" && ((num_fires % mc_wait == 0) || target?.prefs.read_preference(/datum/preference/toggle/fast_mc_refresh)))
				set_MC_tab(target)

			if(target.stat_tab == "Tickets" && num_fires % default_wait == 0)
				set_tickets_tab(target)

			if(!length(GLOB.sdql2_queries) && ("SDQL2" in target.panel_tabs))
				target.stat_panel.send_message("remove_sdql2")

			else if(length(GLOB.sdql2_queries) && (target.stat_tab == "SDQL2" || !("SDQL2" in target.panel_tabs)) && num_fires % default_wait == 0)
				set_SDQL2_tab(target)

		if(MC_TICK_CHECK)
			return

/*
 * send_message for the stat panel can be sent 1 of 4 things:
 * 1- A string entry, to show up as plain text.
 * 2- An empty string (""), which will translate to a new line, to for a break between lines.
 * 3- a list, in which the first entry is plain text, the second entry is highlighted text, and the third entry is a link
 * that clicking the second entry will take you to.
 * 4- a list with "same_line" as the first entry, which will automatically put it on the line above it,
 * with the second/third entry matching #3 (text & url), allowing you to have 2 clickable links on one line.
 */
/datum/controller/subsystem/statpanels/proc/set_status_tab(client/target)
	if(!global_data)//statbrowser hasnt fired yet and we were called from immediate_send_stat_data()
		return
	target.stat_panel.send_message("update_stat", list(
		"global_data" = global_data,
		"other_str" = target.mob?.get_status_tab_items(),
	))

/datum/controller/subsystem/statpanels/proc/set_MC_tab(client/target)
	var/turf/eye_turf = get_turf(target.eye)
	var/coord_entry = COORD(eye_turf)
	if(!mc_data)
		generate_mc_data()
	target.stat_panel.send_message("update_mc", list("mc_data" = mc_data, "coord_entry" = coord_entry))

/datum/controller/subsystem/statpanels/proc/set_tickets_tab(client/target)
	var/list/ahelp_tickets = GLOB.ahelp_tickets.stat_entry()
	target.stat_panel.send_message("update_tickets", ahelp_tickets)
	var/datum/interview_manager/m = GLOB.interviews

	// get open interview count
	var/dc = 0
	for (var/ckey in m.open_interviews)
		var/datum/interview/current_interview = m.open_interviews[ckey]
		if (current_interview && !current_interview.owner)
			dc++
	var/stat_string = "（[m.open_interviews.len - dc]人在线 / [dc]人断线）"

	// Prepare each queued interview
	var/list/queued = list()
	for (var/datum/interview/queued_interview in m.interview_queue)
		queued += list(list(
			"ref" = REF(queued_interview),
			"status" = "\[[queued_interview.pos_in_queue]\]: [queued_interview.owner_ckey][!queued_interview.owner ? " （断线）": ""] \[INT-[queued_interview.id]\]"
		))

	var/list/data = list(
		"status" = list(
			"进行中：" = "[m.open_interviews.len] [stat_string]",
			"排队中：" = "[m.interview_queue.len]",
			"已关闭：" = "[m.closed_interviews.len]"),
		"interviews" = queued
	)

	// Push update
	target.stat_panel.send_message("update_interviews", data)

/datum/controller/subsystem/statpanels/proc/set_SDQL2_tab(client/target)
	var/list/sdql2A = list()
	sdql2A[++sdql2A.len] = list("", "查看全局 SDQL2 列表", REF(GLOB.sdql2_vv_statobj))
	var/list/sdql2B = list()
	for(var/datum/sdql2_query/query as anything in GLOB.sdql2_queries)
		sdql2B = query.generate_stat()

	sdql2A += sdql2B
	target.stat_panel.send_message("update_sdql2", sdql2A)

/datum/controller/subsystem/statpanels/proc/generate_mc_data()
	mc_data = list(
		list("", "CPU:", world.cpu),
		list("", "实例：", "[num2text(world.contents.len, 10)]"),
		list("", "世界时间：", "[world.time]"),
		list("", "全局变量：", GLOB.stat_entry(), text_ref(GLOB)),
		list("", "[config]:", config.stat_entry(), text_ref(config)),
		list("", "Byond:", "(FPS:[world.fps]) （时刻数：[world.time/world.tick_lag]） （时刻漂移：[round(Master.tickdrift,1)]([round((Master.tickdrift/(world.time/world.tick_lag))*100,0.1)]%)）\n  （内部时刻占用率：[round(MAPTICK_LAST_INTERNAL_TICK_USAGE,0.1)]%）"),
		list("", "主控制器：", Master.stat_entry(), text_ref(Master)),
		list("", "故障保护控制器：", Failsafe.stat_entry(), text_ref(Failsafe)),
		list("", "", "")
	)
#if defined(MC_TAB_TRACY_INFO) || defined(SPACEMAN_DMM)
	var/static/tracy_dll
	var/static/tracy_present
	if(isnull(tracy_dll))
		tracy_dll = TRACY_DLL_PATH
		tracy_present = fexists(tracy_dll)
	if(tracy_present)
		if(Tracy.enabled)
			mc_data.Insert(2, list(list("", "byond-tracy:", "已启用（原因：[Tracy.init_reason || "无"]）")))
		else if(Tracy.error)
			mc_data.Insert(2, list(list("", "byond-tracy:", "发生错误（[Tracy.error]）")))
		else if(fexists(TRACY_ENABLE_PATH))
			mc_data.Insert(2, list(list("", "byond-tracy:", "已安排于下回合启用")))
		else
			mc_data.Insert(2, list(list("", "byond-tracy:", "未启用")))
	else
		mc_data.Insert(2, list(list("", "byond-tracy:", "未找到[tracy_dll]")))
#endif
	for(var/datum/controller/subsystem/sub_system as anything in Master.subsystems)
		mc_data[++mc_data.len] = list("\[[sub_system.state_letter()]]", sub_system.name, sub_system.stat_entry(), text_ref(sub_system))

///immediately update the active statpanel tab of the target client
/datum/controller/subsystem/statpanels/proc/immediate_send_stat_data(client/target)
	if(!target.stat_panel.is_ready())
		return FALSE

	if(target.stat_tab == "Status")
		set_status_tab(target)
		return TRUE

	if(!target.holder)
		return FALSE

	if(target.stat_tab == "MC")
		set_MC_tab(target)
		return TRUE

	if(target.stat_tab == "Tickets")
		set_tickets_tab(target)
		return TRUE

	if(!length(GLOB.sdql2_queries) && ("SDQL2" in target.panel_tabs))
		target.stat_panel.send_message("remove_sdql2")

	else if(length(GLOB.sdql2_queries) && target.stat_tab == "SDQL2")
		set_SDQL2_tab(target)
