ADMIN_VERB(change_shuttle_events, R_ADMIN|R_FUN, "更改穿梭机事件", "更改穿梭机上的事件。", ADMIN_CATEGORY_SHUTTLE)
	//At least for now, just letting admins modify the emergency shuttle is fine
	var/obj/docking_port/mobile/port = SSshuttle.emergency

	if(!port)
		to_chat(user, span_admin("糟糕，找不到逃生穿梭机！"))

	var/list/options = list("Clear"="Clear")

	//Grab the active events so we know which ones we can Add or Remove
	var/list/active = list()
	for(var/datum/shuttle_event/event in port.event_list)
		active[event.type] = event

	for(var/datum/shuttle_event/event as anything in subtypesof(/datum/shuttle_event))
		options[((event in active) ? "(移除)" : "(添加)") + initial(event.name)] = event

	//Throw up an ugly menu with the shuttle events and the options to add or remove them, or clear them all
	var/result = input(user, "选择要添加/移除的事件", "穿梭机事件") as null|anything in sort_list(options)

	if(result == "Clear")
		port.event_list.Cut()
		message_admins("[key_name_admin(user)] 清除了以下穿梭机上的事件：[port]")
	else if(options[result])
		var/typepath = options[result]
		if(typepath in active)
			port.event_list.Remove(active[options[result]])
			message_admins("[key_name_admin(user)] 从[port]移除了“[active[result]]”。")
		else
			message_admins("[key_name_admin(user)] 向[port]添加了“[typepath]”。")
			port.add_shuttle_event(typepath)

ADMIN_VERB(call_shuttle, R_ADMIN, "召唤穿梭机", "强制召唤穿梭机，并附加额外的修正。", ADMIN_CATEGORY_SHUTTLE)
	if(EMERGENCY_AT_LEAST_DOCKED)
		return

	var/confirm = tgui_alert(user, "你确定吗？", "确认", list("Yes", "Yes (No Recall)", "No"))
	switch(confirm)
		if(null, "No")
			return
		if("Yes (No Recall)")
			SSshuttle.admin_emergency_no_recall = TRUE
			SSshuttle.emergency.mode = SHUTTLE_IDLE

	SSshuttle.emergency.request()
	BLACKBOX_LOG_ADMIN_VERB("Call Shuttle")
	log_admin("[key_name(user)] 管理员召唤了紧急穿梭机。")
	message_admins(span_adminnotice("[key_name_admin(user)] 管理员召唤了紧急穿梭机[confirm == "Yes (No Recall)" ? "（不可召回）" : ""]。"))

ADMIN_VERB(cancel_shuttle, R_ADMIN, "取消穿梭机", "无视任何情况召回穿梭机。", ADMIN_CATEGORY_SHUTTLE)
	if(EMERGENCY_AT_LEAST_DOCKED)
		return

	if(tgui_alert(user, "你确定吗？", "确认取消穿梭机", list("Yes", "No")) != "Yes")
		return

	if(!SSshuttle.cancel_evac(user.mob, hide_origin = TRUE)) // handles the case where the shuttle is set to unrecallable by another admin or the code
		return

	BLACKBOX_LOG_ADMIN_VERB("Cancel Shuttle")
	log_admin("[key_name(user)] 管理员召回了紧急穿梭机。")
	message_admins(span_adminnotice("[key_name_admin(user)] 管理员召回了紧急穿梭机。"))

ADMIN_VERB(disable_shuttle, R_ADMIN, "禁用穿梭机", "那些混蛋别想出去。", ADMIN_CATEGORY_SHUTTLE)
	if(SSshuttle.emergency.mode == SHUTTLE_DISABLED)
		to_chat(user, span_warning("错误，穿梭机已被禁用。"))
		return

	if(tgui_alert(user, "你确定吗？", "确认", list("Yes", "No")) != "Yes")
		return

	message_admins(span_adminnotice("[key_name_admin(user)] 禁用了穿梭机。"))

	SSshuttle.last_mode = SSshuttle.emergency.mode
	SSshuttle.last_call_time = SSshuttle.emergency.timeLeft(1)
	SSshuttle.admin_emergency_no_recall = TRUE
	SSshuttle.emergency.setTimer(0)
	SSshuttle.emergency.mode = SHUTTLE_DISABLED
	priority_announce(
		text = "紧急穿梭机上行链路故障，穿梭机禁用直至另行通知。",
		title = "上行链路故障",
		sound = 'sound/announcer/announcement/announce_dig.ogg',
		sender_override = "紧急穿梭机上行链路警报",
		color_override = "grey",
	)

ADMIN_VERB(enable_shuttle, R_ADMIN, "启用穿梭机", "那些混蛋这回真能出去了。", ADMIN_CATEGORY_SHUTTLE)
	if(SSshuttle.emergency.mode != SHUTTLE_DISABLED)
		to_chat(user, span_warning("错误，穿梭机未被禁用。"))
		return

	if(tgui_alert(user, "你确定吗？", "确认", list("Yes", "No")) != "Yes")
		return

	message_admins(span_adminnotice("[key_name_admin(user)] 启用了紧急穿梭机。"))
	SSshuttle.admin_emergency_no_recall = FALSE
	SSshuttle.emergency_no_recall = FALSE
	if(SSshuttle.last_mode == SHUTTLE_DISABLED) //If everything goes to shit, fix it.
		SSshuttle.last_mode = SHUTTLE_IDLE

	SSshuttle.emergency.mode = SSshuttle.last_mode
	if(SSshuttle.last_call_time < 10 SECONDS && SSshuttle.last_mode != SHUTTLE_IDLE)
		SSshuttle.last_call_time = 10 SECONDS //Make sure no insta departures.
	SSshuttle.emergency.setTimer(SSshuttle.last_call_time)
	priority_announce(
		text = "紧急穿梭机上行链路已恢复，穿梭机已启用。",
		title = "上行链路已恢复",
		sound = 'sound/announcer/announcement/announce_dig.ogg',
		sender_override = "紧急穿梭机上行链路警报",
		color_override = "green",
	)

ADMIN_VERB(hostile_environment, R_ADMIN, "敌对环境", "以自然的方式禁用穿梭机。", ADMIN_CATEGORY_SHUTTLE)
	switch(tgui_alert(user, "请选择一个选项", "敌对环境管理器", list("Enable", "Disable", "Clear All")))
		if("Enable")
			if (SSshuttle.hostile_environments["Admin"] == TRUE)
				to_chat(user, span_warning("错误，管理员敌对环境已启用。"))
			else
				message_admins(span_adminnotice("[key_name_admin(user)] 启用了管理员敌对环境"))
				SSshuttle.registerHostileEnvironment("Admin")
		if("Disable")
			if (!SSshuttle.hostile_environments["Admin"])
				to_chat(user, span_warning("错误，未找到管理员敌对环境。"))
			else
				message_admins(span_adminnotice("[key_name_admin(user)] 禁用了管理员敌对环境"))
				SSshuttle.clearHostileEnvironment("Admin")
		if("Clear All")
			message_admins(span_adminnotice("[key_name_admin(user)] 禁用了当前所有敌对环境来源"))
			SSshuttle.hostile_environments.Cut()
			SSshuttle.checkHostileEnvironment()

ADMIN_VERB(shuttle_panel, R_ADMIN, "穿梭机操纵器", "打开穿梭机操纵器界面。", ADMIN_CATEGORY_SHUTTLE)
	SSshuttle.ui_interact(user.mob)

/obj/docking_port/mobile/proc/admin_fly_shuttle(mob/user)
	var/list/options = list()

	for(var/port in SSshuttle.stationary_docking_ports)
		if (istype(port, /obj/docking_port/stationary/transit))
			continue  // please don't do this
		var/obj/docking_port/stationary/S = port
		if (canDock(S) == SHUTTLE_CAN_DOCK)
			options[S.name || S.shuttle_id] = S

	options += "--------"
	options += "Infinite Transit"
	options += "Delete Shuttle"
	options += "Into The Sunset (delete & greentext 'escape')"

	var/selection = tgui_input_list(user, "选择[name || shuttle_id]要飞往何处：", "飞行穿梭机", options)
	if(isnull(selection))
		return

	switch(selection)
		if("Infinite Transit")
			destination = null
			mode = SHUTTLE_IGNITING
			setTimer(ignitionTime)

		if("Delete Shuttle")
			if(tgui_alert(user, "真的要删除[name || shuttle_id]吗？", "删除穿梭机", list("Cancel", "Really!")) != "Really!")
				return
			jumpToNullSpace()

		if("Into The Sunset (delete & greentext 'escape')")
			if(tgui_alert(user, "真的要删除[name || shuttle_id]，并把逃跑目标判定为成功（greentext）吗？", "删除穿梭机", list("Cancel", "Really!")) != "Really!")
				return
			intoTheSunset()

		else
			if(options[selection])
				request(options[selection])

/obj/docking_port/mobile/emergency/admin_fly_shuttle(mob/user)
	return  // use the existing verbs for this

/obj/docking_port/mobile/arrivals/admin_fly_shuttle(mob/user)
	switch(tgui_alert(user, "你想让抵达穿梭机飞一次，还是更改它的目的地？", "飞行穿梭机", list("Fly", "Retarget", "Cancel")))
		if("Cancel")
			return
		if("Fly")
			return ..()

	var/list/options = list()

	for(var/port in SSshuttle.stationary_docking_ports)
		if (istype(port, /obj/docking_port/stationary/transit))
			continue  // please don't do this
		var/obj/docking_port/stationary/S = port
		if (canDock(S) == SHUTTLE_CAN_DOCK)
			options[S.name || S.shuttle_id] = S

	var/selection = tgui_input_list(user, "新的抵达穿梭机目的地", "飞行穿梭机", options)
	if(isnull(selection))
		return
	target_dock = options[selection]
	if(!QDELETED(target_dock))
		destination = target_dock
