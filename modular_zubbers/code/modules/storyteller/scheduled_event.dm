///Scheduled event datum for SSgamemode to put events into.
/datum/scheduled_event
	/// What event are scheduling.
	var/datum/round_event_control/event
	/// When do we start our event
	var/start_time = 0
	/// If we were created by a storyteller, here's a cost to refund in case.
	var/cost
	/// Whether we alerted admins about this schedule when it's close to being invoked.
	var/alerted_admins = FALSE
	/// Whether we are faking an occurence or not
	var/fakes_occurence = TRUE
	/// Whether this ignores event can run checks. If bussed by an admin, you want to ignore checks
	var/ignores_checks
	/// Whether the scheduled event will override the announcement change. If null it won't. TRUE = force yes. FALSE = force no.
	var/announce_change

/datum/scheduled_event/New(datum/round_event_control/passed_event, passed_time, passed_cost, passed_ignore, passed_announce)
	. = ..()
	event = passed_event
	start_time = passed_time
	cost = passed_cost
	ignores_checks = passed_ignore
	announce_change = passed_announce
	/// Add a fake occurence to make the weightings/checks properly respect the scheduled event.
	event.add_occurence()
	fakes_occurence = TRUE

/datum/scheduled_event/proc/remove_occurence()
	if(fakes_occurence)
		/// Remove the fake occurence if we still have it
		event.subtract_occurence()
		fakes_occurence = FALSE

/// For admins who want to reschedule the event.
/datum/scheduled_event/proc/reschedule(new_time)
	start_time = new_time
	alerted_admins = FALSE

/datum/scheduled_event/proc/get_href_actions()
	var/round_started = SSticker.HasRoundStarted()
	if(round_started)
		return "<a href='byond://?src=[REF(src)];action=fire'>触发</a> <a href='byond://?src=[REF(src)];action=reschedule'>重新安排</a> <a href='byond://?src=[REF(src)];action=cancel'>取消</a> <a href='byond://?src=[REF(src)];action=refund'>退还</a></td>"
	else
		return "<a href='byond://?src=[REF(src)];action=cancel'>取消</a>"

/// Try and fire off the scheduled event
/datum/scheduled_event/proc/try_fire()
	/// Remove our fake occurence pre-emptively for the checks.
	remove_occurence()
	var/players_amt = SSgamemode.active_crew //Makes events based on active crew instead of active players.
	///If we can't spawn the scheduled event, refund it.
	if(!ignores_checks && !event.can_spawn_event(players_amt)) //FALSE argument to ignore popchecks, to prevent scheduled events from failing from people dying/cryoing etc.
		message_admins("预定事件：[event] 无法运行，消耗已退还。")
		log_admin("预定事件：[event] 无法运行，消耗已退还。")

		SSgamemode.refund_scheduled_event(src)
		return

	///Trigger the event and remove the scheduled datum
	message_admins("预定事件：[event] 已成功触发。")
	SSgamemode.TriggerEvent(event)
	SSgamemode.remove_scheduled_event(src)

/datum/scheduled_event/Destroy()
	remove_occurence()
	event = null
	return ..()

/datum/scheduled_event/Topic(href, list/href_list)
	. = ..()
	switch(href_list["action"])
		if("cancel")
			message_admins("[key_name_admin(usr)] 已取消预定事件 [src.event.name]。")
			log_admin_private("[key_name(usr)] 已取消预定事件 [src.event.name]。")
			SSgamemode.remove_scheduled_event(src)
		if("refund")
			message_admins("[key_name_admin(usr)] 已退还预定事件 [src.event.name] 的消耗。")
			log_admin_private("[key_name(usr)] 已退还预定事件 [src.event.name] 的消耗。")
			SSgamemode.refund_scheduled_event(src)
		if("reschedule")
			var/new_schedule = tgui_input_number(usr, "设置触发事件的倒计时（秒）", "重新安排事件", 0, 3600, 0)
			if(isnull(new_schedule) || QDELETED(src))
				return
			src.start_time = world.time + (new_schedule SECONDS)
			message_admins("[key_name_admin(usr)] 已将事件 [src.event.name] 重新安排到 [new_schedule] 秒后。")
			log_admin_private("[key_name(usr)] 已将事件 [src.event.name] 重新安排到 [new_schedule] 秒后。")
		if("fire")
			if(!SSticker.HasRoundStarted())
				return
			message_admins("[key_name_admin(usr)] 已触发预定事件 [src.event.name]。")
			log_admin_private("[key_name(usr)] 已触发预定事件 [src.event.name]。")
			src.try_fire()
