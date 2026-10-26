/datum/opposing_force_selected_equipment
	/// Reference to the selected equipment datum.
	var/datum/opposing_force_equipment/opposing_force_equipment
	/// Why does the user need this?
	var/reason = ""
	/// What is the status of this item?
	var/status = OPFOR_EQUIPMENT_STATUS_NOT_REVIEWED
	/// If denied, why?
	var/denied_reason = ""
	/// How many does the user want?
	var/count = 1

/datum/opposing_force_selected_equipment/New(datum/opposing_force_equipment/opfor_equipment)
	if(opfor_equipment)
		opposing_force_equipment = opfor_equipment

/datum/opposing_force_selected_equipment/Destroy(force, ...)
	opposing_force_equipment = null
	return ..()

/// Called when the gear is issued, use for unique services (e.g. a power outage) that don't have an item
/datum/opposing_force_equipment/proc/on_issue(mob/living/target)
	return

/datum/opposing_force_objective
	/// The name of the objective
	var/title = ""
	/// The actual objective.
	var/description = ""
	/// The reason for the objective.
	var/justification = ""
	/// Was this specific objective approved by the admins?
	var/status = OPFOR_OBJECTIVE_STATUS_NOT_REVIEWED
	/// Why was this objective denied? If a reason was specified.
	var/denied_reason = ""
	/// How intense is this goal?
	var/intensity = 1
	/// The text intensity of this goal
	var/text_intensity = OPFOR_OBJECTIVE_INTENSITY_1

/datum/opposing_force
	/// A list of objectives.
	var/list/objectives = list()
	/// Justification for wanting to do bad things.
	var/set_backstory = ""
	/// Has this been approved?
	var/status = OPFOR_STATUS_NOT_SUBMITTED
	/// Hard ref to our mind.
	var/datum/mind/mind_reference
	/// For logging stuffs
	var/list/modification_log = list()
	/// Can we edit things?
	var/can_edit = TRUE
	/// The reason we were denied.
	var/denied_reason = ""
	/// Have we been request update muted by an admin?
	var/request_updates_muted = FALSE
	/// A text list of the admin chat.
	var/list/admin_chat = list()
	/// Have we issued the player their equipment?
	var/equipment_issued = FALSE
	/// A list of equipment that the user has requested.
	var/list/selected_equipment = list()
	/// Are we blocked from submitting a new request?
	var/blocked = FALSE
	/// What admin has this request been assigned to?
	var/handling_admin = ""
	/// The ckey of the person that made this application
	var/ckey
	/// Contractor hub datum, used if the user OPFORs for a contractor kit
	var/datum/contractor_hub/contractor_hub
	/// Corresponding stat() click button
	var/obj/effect/statclick/opfor_specific/stat_button
	/// If it is part of the ticket ping subsystem
	var/ticket_ping = FALSE

	COOLDOWN_DECLARE(static/request_update_cooldown)
	COOLDOWN_DECLARE(static/ping_cooldown)

/datum/opposing_force/New(datum/mind/mind_reference)
	src.mind_reference = mind_reference
	ckey = ckey(mind_reference.key)
	send_system_message("[ckey]创建了申请")
	stat_button = new()
	stat_button.opfor = src

/datum/opposing_force/Destroy(force)
	mind_reference.opposing_force = null
	mind_reference = null
	SSopposing_force.remove_opfor(src)
	QDEL_LIST(objectives)
	QDEL_LIST(admin_chat)
	QDEL_LIST(modification_log)
	QDEL_NULL(stat_button)
	return ..()

/datum/opposing_force/Topic(href, list/href_list)
	if(href_list["admin_pref"])
		if(!check_rights(R_ADMIN))
			CRASH("Opposing_force TOPIC: Detected possible HREF exploit! ([usr])")
		ui_interact(usr)
		return TRUE

/// Builds the HTML panel entry for the round end report
/datum/opposing_force/proc/build_html_panel_entry()
	var/list/opfor_entry = list("<b>[mind_reference.key]</b> - ")
	opfor_entry += "<a href='byond://?priv_msg=[ckey(mind_reference.key)]'>私信</a> "
	if(mind_reference.current)
		opfor_entry += "<a href='byond://?_src_=holder;[HrefToken()];adminplayerobservefollow=[REF(mind_reference?.current)]'>跟随</a> "
	opfor_entry += "<a href='byond://?src=[REF(src)];admin_pref=show_panel'>显示敌对势力面板</a>"
	return opfor_entry.Join()

/datum/opposing_force/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OpposingForcePanel")
		ui.open()

/datum/opposing_force/ui_state(mob/user)
	return GLOB.always_state

/datum/opposing_force/ui_data(mob/user)
	var/list/data = list()

	var/client/owner_client = GLOB.directory[ckey]
	data["admin_mode"] = check_rights_for(user.client, R_ADMIN) && user.client != owner_client

	data["creator_ckey"] = ckey

	data["owner_antag"] = (mind_reference.current in GLOB.current_living_antags)

	data["backstory"] = set_backstory

	data["raw_status"] = status

	data["status"] = get_status_string()

	data["can_submit"] = SSopposing_force.accepting_objectives && (status == OPFOR_STATUS_NOT_SUBMITTED || status == OPFOR_STATUS_CHANGES_REQUESTED)

	data["can_request_update"] = (status == OPFOR_STATUS_AWAITING_APPROVAL && COOLDOWN_FINISHED(src, request_update_cooldown))

	data["request_updates_muted"] = request_updates_muted

	data["blocked"] = blocked

	data["can_edit"] = can_edit

	data["approved"] = status == OPFOR_STATUS_APPROVED ? TRUE : FALSE

	data["denied"] = status == OPFOR_STATUS_DENIED ? TRUE : FALSE

	data["handling_admin"] = handling_admin

	data["equipment_issued"] = equipment_issued

	data["owner_mob"] = mind_reference.current ? mind_reference.current.name : "没有角色！"

	data["owner_role"] = mind_reference.assigned_role ? chinese_job_display(mind_reference.assigned_role.title) : "没有职位！"

	var/list/messages = list()
	for(var/message in admin_chat)
		messages.Add(list(list(
			"msg" = message
		)))
	data["messages"] = messages

	data["objectives"] = list()
	var/objective_num = 1
	for(var/datum/opposing_force_objective/opfor as anything in objectives)
		var/list/objective_data = list(
			"id" = objective_num,
			"ref" = REF(opfor),
			"title" = opfor.title,
			"description" = opfor.description,
			"intensity" = opfor.intensity,
			"text_intensity" = opfor.text_intensity,
			"justification" = opfor.justification,
			"approved" = opfor.status == OPFOR_OBJECTIVE_STATUS_APPROVED ? TRUE : FALSE,
			"status_text" = opfor.status,
			"denied_text" = opfor.denied_reason,
			)
		objective_num++
		data["objectives"] += list(objective_data)

	data["equipment_issued"] = equipment_issued

	data["selected_equipment"] = list()
	for(var/datum/opposing_force_selected_equipment/equipment as anything in selected_equipment)
		var/list/equipment_data = list(
			"ref" = REF(equipment),
			"name" = equipment.opposing_force_equipment.name,
			"description" = equipment.opposing_force_equipment.description,
			"item" = equipment.opposing_force_equipment.item_type,
			"status" = equipment.status,
			"approved" = equipment.status == OPFOR_EQUIPMENT_STATUS_APPROVED ? TRUE : FALSE,
			"reason" = equipment.reason,
			"denied_reason" = equipment.denied_reason,
			"count" = equipment.count,
			"admin_note" = equipment.opposing_force_equipment.admin_note,
			)
		data["selected_equipment"] += list(equipment_data)

	return data

/datum/opposing_force/ui_static_data(mob/user)
	. = ..()
	.["equipment_list"] = list()

	for(var/equipment_category in SSopposing_force.equipment_list)
		var/category_items = list()
		for(var/datum/opposing_force_equipment/opfor_equipment as anything in SSopposing_force.equipment_list[equipment_category])
			category_items += list(list(
				"ref" = REF(opfor_equipment),
				"name" = opfor_equipment.name,
				"description" = opfor_equipment.description,
				"equipment_category" = opfor_equipment.category,
				"admin_note" = opfor_equipment.admin_note,
			))
		.["equipment_list"] += list(list(
			"category" = equipment_category,
			"items" = category_items,
		))

/datum/opposing_force/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/datum/opposing_force_objective/edited_objective
	if(params["objective_ref"])
		edited_objective = locate(params["objective_ref"]) in objectives
		if(!edited_objective)
			return

	switch(action)
		// General control
		if("set_backstory")
			set_backstory(usr, params["backstory"])
		if("request_update")
			request_update(usr)
		if("modify_request")
			modify_request(usr)
		if("close_application")
			close_application(usr)
		if("submit")
			submit_to_subsystem(usr)
		if("send_message")
			send_message(usr, params["message"])
		// Objective control
		if("add_objective")
			add_objective(usr)
		if("remove_objective")
			remove_objective(usr, edited_objective)
		if("set_objective_title")
			set_objective_title(usr, edited_objective, params["title"])
		if("set_objective_description")
			set_objective_description(usr, edited_objective, params["new_desciprtion"])
		if("set_objective_justification")
			set_objective_justification(usr, edited_objective, params["new_justification"])
		if("set_objective_intensity")
			set_objective_intensity(usr, edited_objective, params["new_intensity_level"])
		// Equipment control
		if("select_equipment")
			var/datum/opposing_force_equipment/equipment
			for(var/category in SSopposing_force.equipment_list)
				equipment = locate(params["equipment_ref"]) in SSopposing_force.equipment_list[category]
				if(equipment)
					break
			if(!equipment)
				return
			select_equipment(usr, equipment)
		if("remove_equipment")
			var/datum/opposing_force_selected_equipment/equipment = locate(params["selected_equipment_ref"]) in selected_equipment
			if(!equipment)
				return
			remove_equipment(usr, equipment)
		if("set_equipment_reason")
			var/datum/opposing_force_selected_equipment/equipment = locate(params["selected_equipment_ref"]) in selected_equipment
			if(!equipment)
				return
			set_equipment_reason(usr, equipment, params["new_equipment_reason"])
		if("set_equipment_count")
			var/datum/opposing_force_selected_equipment/equipment = locate(params["selected_equipment_ref"]) in selected_equipment
			if(!equipment)
				return
			set_equipment_count(usr, equipment, params["new_equipment_count"])

		// JSON I/O control
		if("import_json")
			if(!length(SSopposing_force.equipment_list)) // sanity check
				return
			json_import(usr)
		if("export_json")
			json_export(usr)

		//Admin protected procs
		if("approve")
			if(!check_rights(R_ADMIN))
				return
			for(var/datum/opposing_force_objective/objective as anything in objectives)
				if(objective.status == OPFOR_OBJECTIVE_STATUS_NOT_REVIEWED)
					to_chat(usr, custom_boxed_message("purple_box", span_command_headset(span_pink("敌对势力：错误，部分目标尚未审核。请批准或拒绝所有目标。"))))
					return
			for(var/datum/opposing_force_selected_equipment/equipment as anything in selected_equipment)
				if(equipment.status == OPFOR_EQUIPMENT_STATUS_NOT_REVIEWED)
					to_chat(usr, custom_boxed_message("purple_box", span_command_headset(span_pink("敌对势力：错误，部分装备申请尚未审核。请批准或拒绝所有装备申请。"))))
					return
			SSopposing_force.approve(src, usr)
		if("approve_all")
			if(!check_rights(R_ADMIN))
				return
			approve_all(usr)
		if("handle")
			handle(usr)
		if("issue_gear")
			if(!check_rights(R_ADMIN))
				return
			issue_gear(usr)
		if("deny")
			if(!check_rights(R_ADMIN))
				return
			var/denied_reason = tgui_input_text(usr, "拒绝理由", "请输入拒绝此申请的理由：")
			// Checking to see if the user is spamming the button, async and all.
			if((status == OPFOR_STATUS_DENIED) || !denied_reason)
				return
			SSopposing_force.deny(src, denied_reason, usr)
		if("mute_request_updates")
			if(!check_rights(R_ADMIN))
				return
			mute_request_updates(usr)
		if("toggle_block")
			if(!check_rights(R_ADMIN))
				return
			toggle_block(usr)
		if("approve_objective")
			if(!check_rights(R_ADMIN))
				return
			approve_objective(usr, edited_objective)
		if("deny_objective")
			if(!check_rights(R_ADMIN))
				return
			var/denied_reason = tgui_input_text(usr, "拒绝理由", "请输入拒绝此目标的理由：")
			if(!denied_reason)
				return
			deny_objective(usr, edited_objective, denied_reason)
		if("approve_equipment")
			var/datum/opposing_force_selected_equipment/equipment = locate(params["selected_equipment_ref"]) in selected_equipment
			if(!equipment)
				return
			if(!check_rights(R_ADMIN))
				return
			approve_equipment(usr, equipment)
		if("deny_equipment")
			var/datum/opposing_force_selected_equipment/equipment = locate(params["selected_equipment_ref"]) in selected_equipment
			if(!equipment)
				return
			if(!check_rights(R_ADMIN))
				return
			var/denied_reason = tgui_input_text(usr, "拒绝理由", "请输入拒绝此目标的理由：")
			if(!denied_reason)
				return
			deny_equipment(usr, equipment, denied_reason)
		if("flw_user")
			if(!check_rights(R_ADMIN))
				return
			flw_user(usr)

/datum/opposing_force/proc/flw_user(mob/user)
	user.client?.admin_follow(mind_reference.current)

/datum/opposing_force/proc/set_equipment_count(mob/user, datum/opposing_force_selected_equipment/equipment, new_count)
	var/sanitized_newcount = sanitize_integer(new_count, 1, equipment.opposing_force_equipment.max_amount)
	equipment.count = new_count
	add_log(user.ckey, "将装备‘[equipment.opposing_force_equipment.name]’的数量设为[sanitized_newcount]")

/datum/opposing_force/proc/handle(mob/user)
	if(handling_admin)
		var/choice = tgui_alert(user, "另一位管理员正在处理此申请，你要接管吗？", "管理员处理", list("是", "否"))
		if(choice == "否")
			return
	handling_admin = get_admin_ckey(user)
	to_chat(mind_reference.current, custom_boxed_message("green_box", span_nicegreen("你的敌对势力申请现由[handling_admin]处理。")))
	send_admins_opfor_message("受理：[ADMIN_LOOKUPFLW(user)]正在处理[mind_reference.key]的敌对势力申请。")
	send_system_message("[handling_admin]已接手此申请")
	add_log(user.ckey, "接手了申请")

/datum/opposing_force/proc/mute_request_updates(mob/user, override = "none")
	if(override != "none")
		request_updates_muted = override
	else
		request_updates_muted = !request_updates_muted
	send_system_message("[user ? get_admin_ckey(user) : "敌对势力子系统"][request_updates_muted ? "禁用" : "恢复"]了求助请求功能")
	add_log(user.ckey, "[request_updates_muted ? "禁用" : "恢复"]了用户的敌对势力求助请求功能。")

/datum/opposing_force/proc/toggle_block(mob/user, override = "none")
	if(override != "none")
		blocked = override
	else
		blocked = !blocked
	send_system_message("[user ? get_admin_ckey(user) : "敌对势力子系统"]禁止了你提交新申请")
	add_log(user.ckey, "禁止了用户提交敌对势力申请。")

/**
 * Equipment procs
 */

/datum/opposing_force/proc/deny_equipment(mob/user, datum/opposing_force_selected_equipment/incoming_equipment, denied_reason = "")
	if(incoming_equipment.status == OPFOR_EQUIPMENT_STATUS_DENIED)
		return
	incoming_equipment.status = OPFOR_EQUIPMENT_STATUS_DENIED
	incoming_equipment.denied_reason = denied_reason
	send_system_message("[user ? get_admin_ckey(user) : "敌对势力子系统"]拒绝了装备‘[incoming_equipment.opposing_force_equipment.name]’[denied_reason ? "，理由：‘[denied_reason]’" : ""]")
	add_log(user.ckey, "拒绝了装备：[incoming_equipment.opposing_force_equipment.name]，理由：[denied_reason]")

/datum/opposing_force/proc/approve_equipment(mob/user, datum/opposing_force_selected_equipment/incoming_equipment)
	if(incoming_equipment.status == OPFOR_EQUIPMENT_STATUS_APPROVED)
		return
	incoming_equipment.status = OPFOR_EQUIPMENT_STATUS_APPROVED
	incoming_equipment.denied_reason = ""
	send_system_message("[user ? get_admin_ckey(user) : "敌对势力子系统"]批准了装备‘[incoming_equipment.opposing_force_equipment.name]’")
	add_log(user.ckey, "批准了装备：[incoming_equipment.opposing_force_equipment.name]")

/datum/opposing_force/proc/set_equipment_reason(mob/user, datum/opposing_force_selected_equipment/incoming_equipment, new_reason)
	if(!can_edit)
		return
	if(!incoming_equipment)
		CRASH("set_equipment_reason tried to update a non existent opfor equipment datum!")
	var/sanitized_reason = replacetext(STRIP_HTML_SIMPLE(new_reason, OPFOR_TEXT_LIMIT_DESCRIPTION), "\"", " ")
	add_log(user.ckey, "将装备（[incoming_equipment.opposing_force_equipment.name]）的理由从：[incoming_equipment.reason]，更新为：[sanitized_reason]")
	incoming_equipment.reason = sanitized_reason
	return TRUE

/datum/opposing_force/proc/remove_equipment(mob/user, datum/opposing_force_selected_equipment/incoming_equipment)
	if(!can_edit)
		return
	add_log(user.ckey, "移除了装备：[incoming_equipment.opposing_force_equipment.name]")
	selected_equipment -= incoming_equipment
	qdel(incoming_equipment)

/datum/opposing_force/proc/select_equipment(mob/user, datum/opposing_force_equipment/incoming_equipment, reason)
	if(!can_edit)
		return
	if(LAZYLEN(selected_equipment) >= OPFOR_EQUIPMENT_LIMIT)
		to_chat(user, span_warning("你的物品太多了，请移除一项！"))
		return
	var/datum/opposing_force_selected_equipment/new_selected = new(incoming_equipment)
	selected_equipment += new_selected
	add_log(user.ckey, "选择了装备：[incoming_equipment.name]")
	return new_selected

/datum/opposing_force/proc/issue_gear(mob/user)
	if(!selected_equipment.len || !isliving(mind_reference.current) || status != OPFOR_STATUS_APPROVED || equipment_issued)
		return
	var/mob/living/target = mind_reference.current
	for(var/datum/opposing_force_selected_equipment/iterating_equipment as anything in selected_equipment)
		if(iterating_equipment.status != OPFOR_EQUIPMENT_STATUS_APPROVED)
			continue
		for(var/i in 1 to iterating_equipment.count)
			if(!(iterating_equipment.opposing_force_equipment.item_type == /obj/effect/gibspawner/generic)) // This is what's used in place of an item in uplinks, so it's the same here
				new iterating_equipment.opposing_force_equipment.item_type(get_turf(target))
			iterating_equipment.opposing_force_equipment.on_issue(target)

	add_log(user.ckey, "发放了装备")
	send_system_message("[user ? get_admin_ckey(user) : "敌对势力子系统"]发放了所有已批准的装备")
	equipment_issued = TRUE

/**
 * Control procs
 */

/datum/opposing_force/proc/request_update(mob/user)
	if(request_updates_muted)
		to_chat(user, span_warning("你目前被禁止请求进度更新！"))
		return
	if(status != OPFOR_STATUS_AWAITING_APPROVAL || !COOLDOWN_FINISHED(src, request_update_cooldown))
		return

	send_admins_opfor_message(span_command_headset("进度请求：[ADMIN_LOOKUPFLW(user)]请求更新其敌对势力申请的处理进度！"))
	add_log(user.ckey, "请求了进度更新")

	for(var/client/staff as anything in GLOB.admins)
		if(staff?.prefs?.toggles & SOUND_ADMINHELP)
			SEND_SOUND(staff, sound('sound/effects/adminhelp.ogg'))
		window_flash(staff)

	COOLDOWN_START(src, request_update_cooldown, OPFOR_REQUEST_UPDATE_COOLDOWN)

/datum/opposing_force/proc/submit_to_subsystem(mob/user)
	if(blocked)
		to_chat(user, span_warning("你目前被禁止提交新申请！"))
		return
	if(status != OPFOR_STATUS_NOT_SUBMITTED && status != OPFOR_STATUS_CHANGES_REQUESTED)
		return FALSE
	// Subsystem checks, no point in bloating the system if it's not accepting more.
	var/availability = SSopposing_force.check_availability()
	if(availability != OPFOR_SUBSYSTEM_READY)
		to_chat(usr, span_warning("错误，敌对势力子系统拒绝了你的申请。理由：<b>[availability]</b>"))
		return FALSE

	var/queue_position = SSopposing_force.add_to_queue(src)

	for(var/client/staff as anything in GLOB.admins)
		if(staff?.prefs?.toggles & SOUND_ADMINHELP)
			SEND_SOUND(staff, sound('sound/effects/adminhelp.ogg'))
		window_flash(staff, ignorepref = TRUE)

	addtimer(CALLBACK(src, PROC_REF(add_to_ping_ss)), 2 MINUTES) // this is not responsible for the notification itself, but only for adding the ticket to the list of those to notify.
	status = OPFOR_STATUS_AWAITING_APPROVAL
	can_edit = FALSE
	add_log(user.ckey, "提交到了敌对势力子系统")
	send_system_message("[user ? get_admin_ckey(user) : "敌对势力子系统"]已提交申请以供审核")
	send_admins_opfor_message(span_command_headset("提交：[ADMIN_LOOKUPFLW(user)]提交了敌对势力申请，在队列中排第[queue_position]位。"))
	to_chat(usr, custom_boxed_message("green_box", span_nicegreen(("你已加入敌对势力子系统的申请队列，当前排第<b>[queue_position]</b>位。"))))

/datum/opposing_force/proc/modify_request(mob/user)
	if(status == OPFOR_STATUS_CHANGES_REQUESTED)
		return
	var/choice = tgui_alert(user, "确定要请求修改吗？这将撤销所有目标的批准状态。", "确认", list("是", "否"))
	if(choice != "是")
		return
	if(status == OPFOR_STATUS_CHANGES_REQUESTED) // The alert is not async, so this could change, thus being spammed.
		return
	for(var/datum/opposing_force_objective/opfor in objectives)
		opfor.status = OPFOR_OBJECTIVE_STATUS_NOT_REVIEWED
	status = OPFOR_STATUS_CHANGES_REQUESTED
	SSopposing_force.modify_request(src)
	can_edit = TRUE

	add_log(user.ckey, "提交了修改请求")
	send_system_message("[user ? get_admin_ckey(user) : "敌对势力子系统"]请求修改申请")
	send_admins_opfor_message("请求修改：[ADMIN_LOOKUPFLW(user)]提交了修改请求，其申请已重置。")

/datum/opposing_force/proc/deny(mob/denier, reason = "")
	if(status == OPFOR_STATUS_DENIED)
		return
	status = OPFOR_STATUS_DENIED
	can_edit = FALSE
	denied_reason = reason

	for(var/datum/opposing_force_selected_equipment/iterating_equipment as anything in selected_equipment)
		iterating_equipment.status = OPFOR_EQUIPMENT_STATUS_DENIED
	for(var/datum/opposing_force_objective/opfor in objectives)
		opfor.status = OPFOR_OBJECTIVE_STATUS_DENIED
	SEND_SOUND(mind_reference.current, sound('modular_skyrat/modules/opposing_force/sound/denied.ogg'))
	add_log(denier.ckey, "拒绝了申请")
	to_chat(mind_reference.current, custom_boxed_message("red_box", span_redtext("你的敌对势力申请已被[denier ? get_admin_ckey(denier) : "敌对势力子系统"]拒绝！")))
	send_system_message(get_admin_ckey(denier) + "拒绝了申请，理由如下：[reason]")
	send_admins_opfor_message("[span_red("已拒绝")]：[ADMIN_LOOKUPFLW(denier)]拒绝了[ckey]的申请（[reason ? reason : "未说明理由"]）")
	ticket_counter_add_handled(denier.ckey, 1)

/datum/opposing_force/proc/approve(mob/approver)
	if(status == OPFOR_STATUS_APPROVED)
		return
	status = OPFOR_STATUS_APPROVED
	can_edit = FALSE

	SEND_SOUND(mind_reference.current, sound('modular_skyrat/modules/opposing_force/sound/approved.ogg'))
	add_log(approver.ckey, "批准了申请")
	var/objective_denied = FALSE
	for(var/datum/opposing_force_objective/opfor_obj as anything in objectives)
		if(!(opfor_obj.status == OPFOR_OBJECTIVE_STATUS_DENIED))
			continue
		objective_denied = TRUE
		break
	to_chat(mind_reference.current, custom_boxed_message("green_box", span_greentext("你的敌对势力申请已获[approver ? get_admin_ckey(approver) : "敌对势力子系统"][objective_denied ? span_bold("部分批准（详情请查看敌对势力面板）") : span_bold("完全批准")]！")))
	send_system_message("[approver ? get_admin_ckey(approver) : "敌对势力子系统"]批准了申请")
	send_admins_opfor_message("[span_green("已批准")]：[ADMIN_LOOKUPFLW(approver)]批准了[ckey]的申请")
	ticket_counter_add_handled(approver.ckey, 1)

/datum/opposing_force/proc/close_application(mob/user)
	if(status == OPFOR_STATUS_NOT_SUBMITTED)
		return
	var/choice = tgui_alert(user, "确定要撤回申请吗？", "确认", list("是", "否"))
	if(choice != "是")
		return
	if(status == OPFOR_STATUS_NOT_SUBMITTED) // The alert is not async, so this could change, thus being spammed.
		return
	SSopposing_force.unsubmit_opfor(src)
	status = OPFOR_STATUS_NOT_SUBMITTED
	can_edit = TRUE

	for(var/datum/opposing_force_selected_equipment/iterating_equipment as anything in selected_equipment)
		iterating_equipment.status = OPFOR_EQUIPMENT_STATUS_NOT_REVIEWED
	for(var/datum/opposing_force_objective/opfor as anything in objectives)
		opfor.status = OPFOR_OBJECTIVE_STATUS_NOT_REVIEWED

	add_log(user.ckey, "撤回了申请")
	send_system_message("[user ? get_admin_ckey(user) : "敌对势力子系统"]关闭了申请")

/datum/opposing_force/proc/set_backstory(mob/user, incoming_backstory)
	if(!can_edit)
		return
	var/sanitized_backstory = STRIP_HTML_SIMPLE(incoming_backstory, OPFOR_TEXT_LIMIT_BACKSTORY)
	add_log(user.ckey, "将背景故事从：[set_backstory]，更新为：[sanitized_backstory]")
	set_backstory = sanitized_backstory
	return TRUE

/datum/opposing_force/proc/approve_all(mob/user)
	if(SSopposing_force.approve(src, user))
		for(var/datum/opposing_force_selected_equipment/iterating_equipment as anything in selected_equipment)
			iterating_equipment.status = OPFOR_EQUIPMENT_STATUS_APPROVED
		for(var/datum/opposing_force_objective/opfor as anything in objectives)
			opfor.status = OPFOR_OBJECTIVE_STATUS_APPROVED
	send_system_message("[user ? get_admin_ckey(user) : "敌对势力子系统"]批准了申请及其所有目标和装备")
	add_log(user.ckey, "批准了申请及其所有目标和装备")


/**
 * Objective procs
 */

/datum/opposing_force/proc/set_objective_intensity(mob/user, datum/opposing_force_objective/opposing_force_objective, new_intensity)
	if(!can_edit)
		return
	if(!opposing_force_objective)
		CRASH("set_objective_intensity tried to update a non existent opfor objective!")
	var/sanitized_intensity = sanitize_integer(new_intensity, 1, 500)
	switch(sanitized_intensity)
		if(0 to 100)
			opposing_force_objective.text_intensity = OPFOR_OBJECTIVE_INTENSITY_1
		if(101 to 200)
			opposing_force_objective.text_intensity = OPFOR_OBJECTIVE_INTENSITY_2
		if(201 to 300)
			opposing_force_objective.text_intensity = OPFOR_OBJECTIVE_INTENSITY_3
		if(301 to 400)
			opposing_force_objective.text_intensity = OPFOR_OBJECTIVE_INTENSITY_4
		if(401 to 501)
			opposing_force_objective.text_intensity = OPFOR_OBJECTIVE_INTENSITY_5
	add_log(user.ckey, "将目标强度从[opposing_force_objective.intensity]更新为[sanitized_intensity]。")
	opposing_force_objective.intensity = sanitized_intensity
	return TRUE

/datum/opposing_force/proc/set_objective_description(mob/user, datum/opposing_force_objective/opposing_force_objective, new_description)
	if(!can_edit)
		return
	if(!opposing_force_objective)
		CRASH("set_objective_description tried to update a non existent opfor objective!")
	var/sanitized_description = replacetext(STRIP_HTML_SIMPLE(new_description, OPFOR_TEXT_LIMIT_DESCRIPTION), "\"", " ")
	opposing_force_objective.description = sanitized_description
	add_log(user.ckey, "将目标（[opposing_force_objective.title]）的描述从：[opposing_force_objective.description]，更新为：[sanitized_description]")
	return TRUE

/datum/opposing_force/proc/set_objective_justification(mob/user, datum/opposing_force_objective/opposing_force_objective, new_justification)
	if(!can_edit)
		return
	if(!opposing_force_objective)
		CRASH("set_objective_description tried to update a non existent opfor objective!")
	var/sanitize_justification = replacetext(STRIP_HTML_SIMPLE(new_justification, OPFOR_TEXT_LIMIT_JUSTIFICATION), "\"", " ")
	opposing_force_objective.justification = sanitize_justification
	add_log(user.ckey, "将目标（[opposing_force_objective.title]）的动机从：[opposing_force_objective.justification]，更新为：[sanitize_justification]")
	return TRUE

/datum/opposing_force/proc/remove_objective(mob/user, datum/opposing_force_objective/opposing_force_objective)
	if(!can_edit)
		return
	if(!opposing_force_objective)
		CRASH("set_objective_description tried to remove a non existent opfor objective!")
	objectives -= opposing_force_objective
	add_log(user.ckey, "从敌对势力申请中移除了以下目标：[opposing_force_objective.title]")
	qdel(opposing_force_objective)
	return TRUE

/datum/opposing_force/proc/add_objective(mob/user)
	if(!can_edit)
		return
	if(LAZYLEN(objectives) >= OPFOR_MAX_OBJECTIVES)
		to_chat(user, span_warning("你的目标太多了，请移除一项！"))
		return
	var/datum/opposing_force_objective/opfor_objective = new
	objectives += opfor_objective
	add_log(user.ckey, "新增了一个空白目标")
	return opfor_objective

/datum/opposing_force/proc/set_objective_title(mob/user, datum/opposing_force_objective/opposing_force_objective, new_title)
	if(!can_edit)
		return
	var/sanitized_title = replacetext(STRIP_HTML_SIMPLE(new_title, OPFOR_TEXT_LIMIT_TITLE), "\"", " ")
	if(!opposing_force_objective)
		CRASH("set_objective_description tried to update a non existent opfor objective!")
	add_log(user.ckey, "将目标（[opposing_force_objective.title]）的标题从：[opposing_force_objective.title]，更新为：[sanitized_title]")
	opposing_force_objective.title = sanitized_title
	return TRUE

/datum/opposing_force/proc/deny_objective(mob/user, datum/opposing_force_objective/opposing_force_objective, deny_reason)
	opposing_force_objective.status = OPFOR_OBJECTIVE_STATUS_DENIED
	opposing_force_objective.denied_reason = deny_reason
	add_log(user.ckey, "拒绝了目标（[opposing_force_objective.title]），理由：[deny_reason]")
	send_system_message("[user ? get_admin_ckey(user) : "敌对势力子系统"]拒绝了目标‘[opposing_force_objective.title]’，理由：‘[deny_reason]’")
	to_chat(mind_reference?.current, span_warning("你的敌对势力目标[span_bold("[opposing_force_objective.title]")]已被拒绝。"))

/datum/opposing_force/proc/approve_objective(mob/user, datum/opposing_force_objective/opposing_force_objective)
	opposing_force_objective.status = OPFOR_OBJECTIVE_STATUS_APPROVED
	add_log(user.ckey, "批准了目标（[opposing_force_objective.title]）")
	send_system_message("[user ? get_admin_ckey(user) : "敌对势力子系统"]批准了目标‘[opposing_force_objective.title]’")
	to_chat(mind_reference?.current, span_warning("你的敌对势力目标[span_bold("[opposing_force_objective.title]")]已获批准。"))

/**
 * System procs
 */

/datum/opposing_force/proc/add_log(logger_ckey, new_log)
	var/msg = "敌对势力（[ckey]）：[logger_ckey ? logger_ckey : "系统"] - [new_log]"
	modification_log += msg
	log_admin(msg)

/datum/opposing_force/proc/send_admins_opfor_message(message)
	message = "[span_pink("敌对势力：")] [span_admin("[message]（<a href='byond://?src=[REF(src)];admin_pref=show_panel'>显示面板</a>）")]"
	to_chat(GLOB.admins,
		type = MESSAGE_TYPE_ADMINLOG,
		html = message,
		confidential = TRUE)

/datum/opposing_force/proc/get_status_string()
	var/subsystem_status = SSopposing_force.check_availability()
	if(subsystem_status != OPFOR_SUBSYSTEM_READY)
		return subsystem_status
	switch(status)
		if(OPFOR_STATUS_AWAITING_APPROVAL)
			return "等待批准，你在队列中排第[SSopposing_force.get_queue_position(src)]位"
		if(OPFOR_STATUS_APPROVED)
			return "已批准，请查看各项目标的具体批准情况"
		if(OPFOR_STATUS_DENIED)
			return "已拒绝，请勿执行任何目标"
		if(OPFOR_STATUS_CHANGES_REQUESTED)
			return "需要修改，请检查你的申请"
		if(OPFOR_STATUS_NOT_SUBMITTED)
			return "尚未提交"
		else
			return "错误"

/datum/opposing_force/proc/get_admin_ckey(mob/user)
	if(user.client?.holder?.fakekey)
		return user.client.holder.fakekey
	return user.ckey

/datum/opposing_force/proc/broadcast_queue_change()
	var/queue_number = SSopposing_force.get_queue_position(src)
	to_chat(mind_reference.current, custom_boxed_message("green_box", span_nicegreen("你的敌对势力申请目前在队列中排第[queue_number]位。")))
	send_system_message("申请目前在队列中排第[queue_number]位")

/datum/opposing_force/proc/send_message(mob/user, message)
	if(!message)
		return
	message = STRIP_HTML_SIMPLE(message, OPFOR_TEXT_LIMIT_MESSAGE)
	var/message_string
	var/real_round_time = world.timeofday - SSticker.real_round_start_time
	if(check_rights_for(user.client, R_ADMIN) && user != mind_reference)
		message_string = "[time2text(real_round_time, "hh:mm:ss", 0)]（管理员）[get_admin_ckey(user)]：" + message
	else
		message_string = "[time2text(real_round_time, "hh:mm:ss", 0)]（用户）[user.ckey]：" + message
	admin_chat += message_string

	// We support basic commands, see run_command for compatible commands, the operator is /
	if(findtext(message, "/", 1, 2))
		// We remove the command indentifier before we try running the command.
		var/command = replacetext(message, "/", "", 1, 2)
		run_command(user, command)

	add_log(user.ckey, "发送了消息：[message]")


/datum/opposing_force/proc/send_system_message(message)
	var/real_round_time = world.timeofday - SSticker.real_round_start_time
	var/message_string = "[time2text(real_round_time, "hh:mm:ss", 0)] 系统：" + message
	admin_chat += message_string

/datum/opposing_force/proc/run_command(mob/user, message)
	var/list/params = splittext(message, " ")

	var/command = params[1]

	switch(command)
		if("item")
			check_item(params[2])
		if("help")
			print_help(user)
		if("ping_admin")
			ping_admin(user)
		if("ping_user")
			ping_user(user)
		if("unlock_equipment")
			unlock_equipment(user) // Admin only proc
		else
			send_system_message("未知命令：[command]")

/datum/opposing_force/proc/print_help(mob/user)
	send_system_message("可用命令：")
	send_system_message("/item '物品类型路径' - 查看物品的简要属性")
	send_system_message("/ping_admin - 提醒正在处理申请的管理员（如有）。")
	send_system_message("/help - 显示此帮助")
	// Admin commands.
	if(check_rights_for(user.client, R_ADMIN))
		send_system_message("管理员命令：")
		send_system_message("/unlock_equipment - 解锁所有装备，便于向用户发放更多物品。")
		send_system_message("/ping_user - 提醒用户。")

/**
 * System commands
 */
/datum/opposing_force/proc/check_item(type)
	var/obj/item/processed_item = text2path(type)
	if(!processed_item)
		send_system_message("未知类型：[type]")
		return
	if(!ispath(processed_item, /obj/item))
		send_system_message("错误：[processed_item]不是物品")
		return

	send_system_message("[type]的物品属性如下：")
	send_system_message("名称：[initial(processed_item.name)]")
	send_system_message("描述：[initial(processed_item.desc)]")
	send_system_message("重量等级：[initial(processed_item.w_class)]")
	send_system_message("工具功能：[initial(processed_item.tool_behaviour)]")
	send_system_message("对护甲效果较差：[initial(processed_item.weak_against_armour) ? "是" : "否"]")
	send_system_message("伤害类型：[initial(processed_item.damtype)]")
	send_system_message("创伤加成：[initial(processed_item.wound_bonus)]")
	send_system_message("裸露部位创伤加成：[initial(processed_item.exposed_wound_bonus)]")
	send_system_message("伤害：[initial(processed_item.force)]")

/datum/opposing_force/proc/unlock_equipment(mob/user)
	if(!check_rights_for(user.client, R_ADMIN))
		send_system_message("错误：你无权执行此操作。")
		return
	if(!equipment_issued)
		send_system_message("错误：尚未发放装备。")
		return
	equipment_issued = TRUE
	send_system_message("装备已解锁。")

/datum/opposing_force/proc/ping_admin(mob/user)
	if(!handling_admin)
		send_system_message("错误：目前没有管理员处理此申请。")
		return
	if(!COOLDOWN_FINISHED(src, ping_cooldown))
		send_system_message("错误：提醒功能尚在冷却中。")
		return
	if(request_updates_muted)
		send_system_message("错误：你已被禁言。")
		return
	if(user.ckey != handling_admin && GLOB.directory[handling_admin])
		to_chat(GLOB.directory[handling_admin], span_pink("敌对势力：[user]在敌对势力管理员聊天中发出了提醒！（<a href='byond://?src=[REF(src)];admin_pref=show_panel'>显示面板</a>）"))
		SEND_SOUND(GLOB.directory[handling_admin], sound('sound/misc/bloop.ogg'))
		send_system_message("已提醒负责处理的管理员。")
		COOLDOWN_START(src, ping_cooldown, OPFOR_PING_COOLDOWN)
	else
		send_system_message("错误：提醒失败。")

/datum/opposing_force/proc/ping_user(mob/user)
	if(!check_rights_for(user.client, R_ADMIN))
		send_system_message("错误：你无权执行此操作。")
		return
	send_system_message("已提醒用户。")
	to_chat(mind_reference.current, span_pink("敌对势力：[get_admin_ckey(user)]在你的敌对势力聊天中发出了提醒，请查看！"))
	SEND_SOUND(mind_reference.current, sound('sound/misc/bloop.ogg'))

/datum/opposing_force/proc/roundend_report()
	var/list/report = list("<br>")
	report += span_greentext(mind_reference.current?.real_name)

	if(set_backstory)
		report += "<b>已获批准的敌对势力申请具有以下背景故事：</b><br>"
		report += "[set_backstory]<br>"

	if(objectives.len)
		report += "<b>以及以下目标：</b><br>"
		for(var/datum/opposing_force_objective/opfor_objective in objectives)
			if(opfor_objective.status != OPFOR_OBJECTIVE_STATUS_APPROVED)
				continue
			report += "<b>标题：</b>[opfor_objective.title]<br>"
			report += "<b>描述：</b>[opfor_objective.description]<br>"
			report += "<br>"

	if(selected_equipment.len)
		report += "<b>并获批了以下装备：</b><br>"
		for(var/datum/opposing_force_selected_equipment/opfor_equipment in selected_equipment)
			if(opfor_equipment.status != OPFOR_EQUIPMENT_STATUS_APPROVED)
				continue
			report += "</b>[opfor_equipment.opposing_force_equipment.name]<b><br>"
			report += "<br>"

	return report.Join("\n")

/// Adds the OPFOR in question to the ticket ping subsystem should it not be approved.
/datum/opposing_force/proc/add_to_ping_ss()
	if(status == OPFOR_STATUS_APPROVED)
		return
	ticket_ping = TRUE

/// Allows a user to import an OPFOR from json
/datum/opposing_force/proc/json_import(mob/importer)
	var/file_uploaded = input(importer, "选择要上传的.json文件。（这会覆盖你已输入的数据）", "上传JSON模板") as null|file
	if(!file_uploaded)
		return
	if(copytext("[file_uploaded]", -5) != ".json") //5 == length(".json")
		to_chat(importer, span_warning("文件名必须以‘.json’结尾：[file_uploaded]"))
		return

	QDEL_LIST(objectives)
	QDEL_LIST(selected_equipment)
	set_backstory = null

	add_log(importer.ckey, "从JSON导入了敌对势力申请。")

	try
		var/list/opfor_data = json_load(file_uploaded)
		for(var/category in opfor_data)
			switch(category)
				if("objectives")
					for(var/iter_num in opfor_data["objectives"])
						var/datum/opposing_force_objective/opfor_objective = add_objective(importer)
						if(!opfor_objective)
							continue

						var/list/iter_obj = opfor_data["objectives"][iter_num]

						set_objective_title(importer, opfor_objective, iter_obj["title"])
						set_objective_description(importer, opfor_objective, iter_obj["description"])
						set_objective_justification(importer, opfor_objective, iter_obj["justification"])
						set_objective_intensity(importer, opfor_objective, iter_obj["intensity"])

				if("backstory")
					set_backstory(importer, opfor_data["backstory"])

				if("selected_equipment")
					for(var/iter_num in opfor_data["selected_equipment"])
						// If there isn't category data / a given equipment type, OR if either of those don't fit within certain perameters, it continues
						var/list/equipment = opfor_data["selected_equipment"][iter_num]

						if(\
						!equipment["equipment_parent_category"]|| !(equipment["equipment_parent_category"] in SSopposing_force.equipment_list) \
						|| !equipment["equipment_parent_type"] || !ispath(text2path(equipment["equipment_parent_type"]), /datum/opposing_force_equipment))
							continue

						// creates a new selected equipment datum using a type gotten from the given equipment type via SSopposing_force.equipment_list
						var/datum/opposing_force_selected_equipment/opfor_equipment = select_equipment(importer, \
						locate(text2path(equipment["equipment_parent_type"])) in SSopposing_force.equipment_list[equipment["equipment_parent_category"]])

						if(!opfor_equipment)
							continue

						set_equipment_reason(importer, opfor_equipment, equipment["equipment_reason"])
						set_equipment_count(importer, opfor_equipment, equipment["equipment_count"])

	catch //taking 0 risk
		QDEL_LIST(objectives)
		QDEL_LIST(selected_equipment)
		set_backstory = null
		to_chat(importer, span_warning("JSON文件存在损坏，请修正后重新上传。"))
		add_log(importer.ckey, "尝试上传损坏的JSON，正在清除残留数据……")


/// Allows a user to export from an OPFOR into a json file
/datum/opposing_force/proc/json_export(mob/exporter)

	var/list/exported_data = list(
		"objectives" = list(),
		"backstory" = set_backstory,
		"selected_equipment" = list(),
	)

	for(var/datum/opposing_force_objective/iterating_objective as anything in objectives)
		exported_data["objectives"]["[objectives.Find(iterating_objective)]"] = list(
			"title" = iterating_objective.title,
			"description" = iterating_objective.description,
			"justification" = iterating_objective.justification,
			"intensity" = iterating_objective.intensity, //remember to use set_objective_number or whatever the proc is
		)

	for(var/datum/opposing_force_selected_equipment/iterating_equipment as anything in selected_equipment)
		exported_data["selected_equipment"]["[selected_equipment.Find(iterating_equipment)]"] = list(
			"equipment_name" = iterating_equipment.opposing_force_equipment.name,
			"equipment_parent_category" = iterating_equipment.opposing_force_equipment.category,
			"equipment_parent_type" = iterating_equipment.opposing_force_equipment.type,
			"equipment_reason" = iterating_equipment.reason,
			"equipment_count" = iterating_equipment.count,
		)

	add_log(exporter.ckey, "将敌对势力申请导出为JSON。")

	var/to_write_file = "data/opfor_temp/[REF(src)].json"
	rustg_file_write(json_encode(exported_data), to_write_file)

	try
		usr << ftp(file(to_write_file), "exported_OPFOR.json")

	catch
		log_game("敌对势力申请者ckey：[exporter.ckey]尝试导出JSON数据，但ftp(file())发生运行时错误。")
		add_log(exporter.ckey, "尝试导出JSON数据，但ftp(file())发生运行时错误。")

	fdel(to_write_file)

/obj/effect/statclick/opfor_specific
	var/datum/opposing_force/opfor

/obj/effect/statclick/opfor_specific/Destroy()
	opfor = null
	. = ..()

/obj/effect/statclick/opfor_specific/Click()
	if (!usr.client?.holder)
		message_admins("无管理员权限的[key_name_admin(usr)]点击了敌对势力状态按钮！（[src]）")
		log_game("无管理员权限的[key_name(usr)]点击了敌对势力状态按钮！（[src]）")
		return

	opfor.ui_interact(usr)
