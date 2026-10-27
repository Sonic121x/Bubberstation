// Open the ui, nothing special here
// Maybe make it update static data?
/datum/controller/subsystem/gamemode/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ZubbersStoryteller", "故事讲述者控制面板")
		ui.open()

/datum/controller/subsystem/gamemode/ui_data(mob/user)
	var/list/data = list()
	data["storyteller_name"] = storyteller ? storyteller.name : "无"
	data["storyteller_halt"] = storyteller_halted
	data["antag_count"] = GLOB.current_living_antags.len // Switch this up if the calculation for the cap changes (It probably will)
	data["antag_cap"] = get_antag_cap()

	data["pop_data"] = get_ui_pop_data()
	data["tracks_data"] = get_ui_track_data()
	data["scheduled_data"] = get_ui_scheduled_data()
	return data

/datum/controller/subsystem/gamemode/proc/get_ui_pop_data()
	var/list/pop_data = list(
		"active" = get_correct_popcount(),
		"crew" = active_crew,
		"head" = head_crew,
		"sec" = sec_crew,
		"eng" = eng_crew,
		"med" = med_crew,
	)
	return pop_data

/datum/controller/subsystem/gamemode/proc/get_ui_track_data()
	var/list/track_data = list()
	for(var/track in event_tracks)
		var/last_points = last_point_gains[track]
		var/lower = event_track_points[track]
		var/upper = point_thresholds[track]
		var/next = last_points ? round((upper - lower) / last_points / STORYTELLER_WAIT_TIME * 40 / 6) / 10 : 0
		var/datum/round_event_control/forced = forced_next_events[track]
		track_data[track] = list(
			"name" = "[track]",
			"current" = lower,
			"max" = upper,
			"next" = next,
			"forced" = forced ? forced.generate_ui_data() : null
		)
	return track_data

/datum/controller/subsystem/gamemode/proc/get_ui_scheduled_data()
	var/list/scheduled_data = list()
	var/list/sorted_scheduled = list()
	for(var/datum/scheduled_event/scheduled as anything in scheduled_events)
		sorted_scheduled[scheduled] = scheduled.start_time
	sortTim(sorted_scheduled, cmp=/proc/cmp_numeric_asc, associative = TRUE)
	for(var/datum/scheduled_event/scheduled as anything in sorted_scheduled)
		var/time = (scheduled.event.roundstart) ? null : ((scheduled.start_time - world.time) / (1 SECONDS))
		scheduled_data[scheduled.event.name] = list(
			"track" = scheduled.event.track,
			"time" = time,
			"event_type" = scheduled.event.type,
		)
	return scheduled_data

// God has abandoned us
/datum/controller/subsystem/gamemode/ui_static_data(mob/user)
	var/list/static_data = list()
	// Events are static because we don't need to update them as often, only on storyteller ticks
	static_data["events"] = list()
	for(var/event_category in event_pools)
		var/list/event_list = event_pools[event_category]
		static_data["events"][event_category] = list("name" = event_category, "events" = list())
		for(var/datum/round_event_control/event as anything in event_list)
			static_data["events"][event_category]["events"][event.type] = event.generate_ui_data()
	// Uncategorized shit
	static_data["events"]["Uncategorized"] = list("name" = "未分类", "events" = list())
	for(var/datum/round_event_control/event as anything in uncategorized)
		static_data["events"]["Uncategorized"]["events"][event.type] = event.generate_ui_data()
	return static_data

/datum/controller/subsystem/gamemode/ui_state(mob/user)
	return ADMIN_STATE(R_ADMIN)

/datum/controller/subsystem/gamemode/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("set_storyteller")
			// Todo: Replace with tgui_input
			var/list/name_list = list()
			for(var/storyteller_type in storytellers)
				var/datum/storyteller/storyboy = storytellers[storyteller_type]
				name_list[storyboy.name] = storyboy.type
			var/new_storyteller_name = input(usr, "选择新的故事讲述者（将绕过投票结果）：", "故事讲述者")  as null|anything in name_list
			if(!new_storyteller_name)
				return
			message_admins("[key_name_admin(usr)] 已将故事讲述者更换为 [new_storyteller_name]。")
			var/new_storyteller_type = name_list[new_storyteller_name]
			set_storyteller(new_storyteller_type, TRUE, usr.ckey)
		if("halt_storyteller")
			halt_storyteller(usr)
		if("track_action")
			switch(params["action"])
				if("set_pnts")
					var/track_to_adjust = params["track"]
					var/num = tgui_input_number(\
					usr, \
					"设置 [track_to_adjust] 的事件进度点数",
					title = "事件进度点数", \
					default = event_track_points[track_to_adjust], \
					max_value = point_thresholds[track_to_adjust]*5, \
					)
					if(isnull(num))
						return
					event_track_points[track_to_adjust] = num
				if("force_next")
					var/forced_track = params["track"]
					force_next_event(forced_track, usr)
		if("event_action")
			var/datum/scheduled_event/sch_event = get_scheduled_by_event_type(params["type"])
			if(isnull(sch_event))
				return
			switch(params["action"])
				if("cancel")
					message_admins("[key_name_admin(usr)] 已取消预定事件 [sch_event.event.name]。")
					log_admin_private("[key_name(usr)] 已取消预定事件 [sch_event.event.name]。")
					SSgamemode.remove_scheduled_event(sch_event)
				if("refund")
					message_admins("[key_name_admin(usr)] 已退还预定事件 [sch_event.event.name] 的消耗。")
					log_admin_private("[key_name(usr)] 已退还预定事件 [sch_event.event.name] 的消耗。")
					SSgamemode.refund_scheduled_event(sch_event)
				if("reschedule")
					var/new_schedule = tgui_input_number(usr, "设置触发事件的倒计时（秒）", "重新安排事件", 0, 3600, 0)
					if(isnull(new_schedule) || QDELETED(sch_event))
						return
					sch_event.start_time = world.time + (new_schedule SECONDS)
					message_admins("[key_name_admin(usr)] 已将事件 [sch_event.event.name] 重新安排到 [new_schedule] 秒后。")
					log_admin_private("[key_name(usr)] 已将事件 [sch_event.event.name] 重新安排到 [new_schedule] 秒后。")
				if("fire")
					if(!SSticker.HasRoundStarted())
						return
					message_admins("[key_name_admin(usr)] 已触发预定事件 [sch_event.event.name]。")
					log_admin_private("[key_name(usr)] 已触发预定事件 [sch_event.event.name]。")
					sch_event.try_fire()
		if("panel_action")
			var/datum/round_event_control/event = get_event_by_track_and_type(params["track"], params["type"])
			var/track = params["track"]
			if(isnull(event))
				return
			switch(params["action"])
				if("fire")
					message_admins("[key_name_admin(usr)] 已触发事件 [event.name]。")
					log_admin_private("[key_name(usr)] 已触发事件 [event.name]。")
					SSgamemode.TriggerEvent(event)
				if("force_next")
					message_admins("[key_name_admin(usr)] 已将 [track] 轨道的下一个事件强制设为 [event.name]。")
					log_admin_private("[key_name(usr)] 已将 [track] 轨道的下一个事件强制设为 [event.name]。")
					SSgamemode.force_event(event)
				if ("schedule")
					message_admins("[key_name_admin(usr)] 已预定事件 [event.name]。")
					log_admin_private("[key_name(usr)] 已预定事件 [event.name]。")
					SSgamemode.schedule_event(event, (rand(3, 4) MINUTES), 0)
		if("panel_update")
			if(storyteller)
				storyteller.calculate_weights_all()
