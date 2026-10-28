#define IMPORTANT_ACTION_COOLDOWN (60 SECONDS)
#define EMERGENCY_ACCESS_COOLDOWN (30 SECONDS)

#define STATE_BUYING_SHUTTLE "buying_shuttle"
#define STATE_CHANGING_STATUS "changing_status"
#define STATE_MAIN "main"
#define STATE_MESSAGES "messages"
//SKYRAT EDIT ADDITION
GLOBAL_VAR_INIT(cops_arrived, FALSE)
#define EMERGENCY_RESPONSE_POLICE "WOOP WOOP THAT'S THE SOUND OF THE POLICE"
#define EMERGENCY_RESPONSE_ATMOS "DISCO INFERNO"
#define EMERGENCY_RESPONSE_EMT "AAAAAUGH, I'M DYING, I NEEEEEEEEEED A MEDIC BAG"
#define EMERGENCY_RESPONSE_EMAG "AYO THE PIZZA HERE"
//SKYRAT EDIT END

// The communications computer
/obj/machinery/computer/communications
	name = "通讯控制台"
	desc = "用于发布高优先级公告和处理紧急情况的控制台。"
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/communications")
	icon_screen = "comm"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_COMMAND)
	circuit = /obj/item/circuitboard/computer/communications
	light_color = LIGHT_COLOR_BLUE

	/// If the battlecruiser has been called
	var/static/battlecruiser_called = FALSE

	/// Cooldown for important actions, such as messaging CentCom or other sectors
	COOLDOWN_DECLARE(static/important_action_cooldown)
	COOLDOWN_DECLARE(static/emergency_access_cooldown)

	/// Whether syndicate mode is enabled or not.
	var/syndicate = FALSE

	/// The current state of the UI
	var/state = STATE_MAIN

	/// The current state of the UI for AIs
	var/cyborg_state = STATE_MAIN

	/// The name of the user who logged in
	var/authorize_name

	/// The access that the card had on login
	var/list/authorize_access

	/// The messages this console has been sent
	var/list/datum/comm_message/messages

	/// How many times the alert level has been changed
	/// Used to clear the modal to change alert level
	var/alert_level_tick = 0

	/// The timer ID for sending the next cross-comms message
	var/send_cross_comms_message_timer

	/// The last lines used for changing the status display
	var/static/last_status_display

	///how many uses the console has done of toggling the emergency access
	var/toggle_uses = 0
	///how many uses can you toggle emergency access with before cooldowns start occuring BOTH ENABLE/DISABLE
	var/toggle_max_uses = 3
	///when was emergency access last toggled
	var/last_toggled

/obj/machinery/computer/communications/syndicate
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/communications/syndicate")
	icon_screen = "commsyndie"
	circuit = /obj/item/circuitboard/computer/communications/syndicate
	req_access = list(ACCESS_SYNDICATE_LEADER)
	light_color = LIGHT_COLOR_BLOOD_MAGIC

	syndicate = TRUE

/obj/machinery/computer/communications/syndicate/emag_act(mob/user, obj/item/card/emag/emag_card)
	return FALSE

/obj/machinery/computer/communications/syndicate/can_buy_shuttles(mob/user)
	return FALSE

/obj/machinery/computer/communications/syndicate/can_send_messages_to_other_sectors(mob/user)
	return FALSE

/obj/machinery/computer/communications/syndicate/authenticated_as_silicon_or_captain(mob/user)
	return FALSE

/obj/machinery/computer/communications/syndicate/get_communication_players()
	var/list/targets = list()
	for(var/mob/target in GLOB.player_list)
		if(target.stat == DEAD || target.z == z || target.mind?.has_antag_datum(/datum/antagonist/battlecruiser))
			targets += target
	return targets

/obj/machinery/computer/communications/Initialize(mapload)
	. = ..()
	// All maps should have at least 1 comms console
	REGISTER_REQUIRED_MAP_ITEM(1, INFINITY)

	GLOB.shuttle_caller_list += src

/// Are we NOT a silicon, AND we're logged in as the captain?
/obj/machinery/computer/communications/proc/authenticated_as_non_silicon_captain(mob/user)
	if (HAS_SILICON_ACCESS(user))
		return FALSE
	return ACCESS_CAPTAIN in authorize_access

/// Are we a silicon, OR we're logged in as the captain?
/obj/machinery/computer/communications/proc/authenticated_as_silicon_or_captain(mob/user)
	if (HAS_SILICON_ACCESS(user))
		return TRUE
	return ACCESS_CAPTAIN in authorize_access

/// Are we a silicon, OR logged in?
/obj/machinery/computer/communications/proc/authenticated(mob/user)
	if (HAS_SILICON_ACCESS(user))
		return TRUE
	return authenticated

// SKYRAT EDIT START - Are we the AI?
/// Are we the ai, or captain?
/obj/machinery/computer/communications/proc/authenticated_as_ai_or_captain(mob/user)
	if (isAI(user))
		return TRUE
	return ACCESS_CAPTAIN in authorize_access
// SKYRAT EDIT END

/obj/machinery/computer/communications/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!isidcard(tool))
		return NONE
	attack_hand(user)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/computer/communications/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(istype(emag_card, /obj/item/card/emag/battlecruiser))
		var/obj/item/card/emag/battlecruiser/caller_card = emag_card
		if (user)
			if(!IS_TRAITOR(user))
				to_chat(user, span_danger("你感觉这不是个好主意。"))
				return FALSE
		if(battlecruiser_called)
			if (user)
				to_chat(user, span_danger("卡片报告称，已经向辛迪加舰队发送了远程消息……？"))
			return FALSE
		battlecruiser_called = TRUE
		caller_card.use_charge(user)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(summon_battlecruiser), caller_card.team), rand(20 SECONDS, 1 MINUTES))
		playsound(src, 'sound/machines/terminal/terminal_alert.ogg', 50, FALSE)
		priority_announce("全体船员注意：深空传感器探测到你站附近正在形成具有辛迪加战列巡洋舰级特征的亚空间裂隙。预计抵达时间：三至五分钟。", "[command_name()]高优先级通报") //SKYRAT EDIT ADDITION: announcement on battlecruiser call
		return TRUE

	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	if (authenticated)
		authorize_access = SSid_access.get_region_access_list(list(REGION_ALL_STATION))
	balloon_alert(user, "路由电路已扰乱")
	playsound(src, 'sound/machines/terminal/terminal_alert.ogg', 50, FALSE)
	return TRUE

/obj/machinery/computer/communications/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/ui_state)
	var/static/list/approved_states = list(STATE_BUYING_SHUTTLE, STATE_CHANGING_STATUS, STATE_MAIN, STATE_MESSAGES)

	. = ..()
	if (.)
		return

	if (!has_communication())
		return

	var/mob/user = ui.user
	. = TRUE

	switch (action)
		if ("answerMessage")
			if (!authenticated(user))
				return

			var/answer_index = params["answer"]
			var/message_index = params["message"]

			// If either of these aren't numbers, then bad voodoo.
			if(!isnum(answer_index) || !isnum(message_index))
				message_admins("[ADMIN_LOOKUPFLW(user)]在[src] [ADMIN_JMP(src)]回复消息时提供了无效索引类型。这不应发生，请联系维护者或查阅tgui日志。")
				CRASH("Non-numeric index provided when answering comms console message.")

			if (!answer_index || !message_index || answer_index < 1 || message_index < 1)
				return
			var/datum/comm_message/message = messages[message_index]
			if (message.answered)
				return
			message.answered = answer_index
			message.answer_callback.InvokeAsync()
		if ("callShuttle")
			if (!authenticated(user) || syndicate)
				return
			var/reason = trim(params["reason"], MAX_MESSAGE_LEN)
			if (length(reason) < CALL_SHUTTLE_REASON_LENGTH)
				return
			SSshuttle.requestEvac(user, reason)
			post_status("shuttle")
		if ("changeSecurityLevel")
			if (!authenticated_as_silicon_or_captain(user))
				return

			// Check if they have
			if (!HAS_SILICON_ACCESS(user))
				var/obj/item/held_item = user.get_active_held_item()
				var/obj/item/card/id/id_card = held_item?.GetID()
				if (!istype(id_card))
					to_chat(user, span_warning("你需要刷身份证！"))
					playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
					return
				if (!(ACCESS_CAPTAIN in id_card.access))
					to_chat(user, span_warning("你没有执行此操作的权限！"))
					playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
					return

			var/new_sec_level = SSsecurity_level.text_level_to_number(params["newSecurityLevel"])
			if (new_sec_level < SEC_LEVEL_GREEN || new_sec_level > SEC_LEVEL_AMBER) //SKYRAT EDIT CHANGE - ALERTS
				return
			if (SSsecurity_level.get_current_level_as_number() >= SEC_LEVEL_DELTA)
				to_chat(user, span_warning("由于末日危机，中央指挥部已锁定警戒等级！"))
				return
			if (SSsecurity_level.get_current_level_as_number() >= SEC_LEVEL_DELTA)
				to_chat(user, span_warning("由于末日危机，中央指挥部已锁定警戒等级！"))
				return
			if (SSsecurity_level.get_current_level_as_number() == new_sec_level)
				return

			SSsecurity_level.set_level(new_sec_level)

			to_chat(user, span_notice("授权已确认。正在修改警戒等级。"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)

			// Only notify people if an actual change happened
			user.log_message("changed the security level to [params["newSecurityLevel"]] with [src].", LOG_GAME)
			message_admins("[ADMIN_LOOKUPFLW(user)]在[AREACOORD(user)]使用[src]将警戒等级改为[chinese_security_level_display(params["newSecurityLevel"])]。")
			deadchat_broadcast("在[span_name("[chinese_area_display(get_area_name(user, TRUE))]")]使用[src]将警戒等级改为[chinese_security_level_display(params["newSecurityLevel"])]。", span_name("[user.real_name]"), user, message_type=DEADCHAT_ANNOUNCEMENT)

			alert_level_tick += 1
		if ("deleteMessage")
			if (!authenticated(user))
				return
			var/message_index = text2num(params["message"])
			if (!message_index)
				return
			LAZYREMOVE(messages, LAZYACCESS(messages, message_index))
		if ("makePriorityAnnouncement")
			if (!authenticated_as_silicon_or_captain(usr) && !syndicate)
				return
			make_announcement(usr)
		if ("messageAssociates")
			if (!authenticated_as_ai_or_captain(usr)) //Skyrat edit | Allows AI and Captain to send messages
				return
			if (!COOLDOWN_FINISHED(src, important_action_cooldown))
				return

			playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)
			var/message = trim(html_encode(params["message"]), MAX_MESSAGE_LEN)

			var/emagged = obj_flags & EMAGGED
			if (emagged)
				message_syndicate(message, user)
				to_chat(user, span_danger("SYSERR @l(19833)of(transmit.dm): !@$ 消息已发送至辛迪加指挥部。"))
			else if(syndicate)
				message_syndicate(message, user)
				to_chat(user, span_danger("消息已发送至辛迪加指挥部。"))
			else
				message_centcom(message, user)
				to_chat(user, span_notice("消息已发送至中央指挥部。"))

			var/associates = (emagged || syndicate) ? "the Syndicate": "CentCom"
			user.log_talk(message, LOG_SAY, tag = "message to [associates]")
			deadchat_broadcast("在[span_name("[chinese_area_display(get_area_name(user, TRUE))]")]向[(emagged || syndicate) ? "辛迪加" : "中央指挥部"]发送了消息：\"[message]\"。", span_name("[user.real_name]"), user, message_type = DEADCHAT_ANNOUNCEMENT)
			COOLDOWN_START(src, important_action_cooldown, IMPORTANT_ACTION_COOLDOWN)
		if ("purchaseShuttle")
			var/can_buy_shuttles_or_fail_reason = can_buy_shuttles(user)
			if (can_buy_shuttles_or_fail_reason != TRUE)
				if (can_buy_shuttles_or_fail_reason != FALSE)
					to_chat(user, span_alert("[can_buy_shuttles_or_fail_reason]"))
				return
			var/list/shuttles = assoc_to_values(SSmapping.shuttle_templates)
			var/datum/map_template/shuttle/shuttle = locate(params["shuttle"]) in shuttles
			if (!istype(shuttle))
				return
			if (!can_purchase_this_shuttle(shuttle))
				return
			if (istype(shuttle, /datum/map_template/shuttle/emergency/departmental))
				var/datum/map_template/shuttle/emergency/departmental/dept_shuttle = shuttle
				if(dept_shuttle.department_type)
					var/max_crew_count = 0
					for(var/dept_type in SSjob.joinable_departments_by_type)
						var/crew_count = get_department_employee_count(dept_type)
						if(crew_count > max_crew_count)
							max_crew_count = crew_count

					var/crew_in_department = get_department_employee_count(dept_shuttle.department_type)
					if(crew_in_department <= 0 || crew_in_department < max_crew_count)
						to_chat(user, span_alert("This shuttle can be buyed only if this department has most employees."))
						return
			if (!shuttle.prerequisites_met())
				to_chat(user, span_alert("你尚未满足购买此穿梭机的条件。"))
				return
			var/datum/bank_account/bank_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
			if (bank_account.account_balance < shuttle.credit_cost)
				return
			SSshuttle.shuttle_purchased = SHUTTLEPURCHASE_PURCHASED
			for(var/datum/round_event_control/shuttle_insurance/insurance_event in SSevents.control)
				insurance_event.weight *= 20
			SSshuttle.unload_preview()
			SSshuttle.existing_shuttle = SSshuttle.emergency
			SSshuttle.action_load(shuttle, replace = TRUE)
			bank_account.adjust_money(-shuttle.credit_cost)

			var/purchaser_name = (obj_flags & EMAGGED) ? scramble_message_replace_chars("认证失败：CVE-2018-17107", 60) : user.real_name
			minor_announce("[purchaser_name]花费[shuttle.credit_cost][MONEY_NAME]购买了[chinese_template_display(shuttle.name)]。[shuttle.extra_desc ? " [shuttle.extra_desc]" : ""]" , "穿梭机采购")

			message_admins("[ADMIN_LOOKUPFLW(user)]购买了[chinese_template_display(shuttle.name)]。")
			log_shuttle("[key_name(user)] has purchased [shuttle.name].")
			SSblackbox.record_feedback("text", "shuttle_purchase", 1, shuttle.name)
			state = STATE_MAIN
		if ("recallShuttle")
			// AIs cannot recall the shuttle
			if (!authenticated(user) || HAS_SILICON_ACCESS(user) || syndicate)
				return
			SSshuttle.cancel_evac(user)
		if ("requestNukeCodes")
			if (!authenticated_as_non_silicon_captain(user))
				return
			if (!COOLDOWN_FINISHED(src, important_action_cooldown))
				return
			var/reason = trim(html_encode(params["reason"]), MAX_MESSAGE_LEN)
			nuke_request(reason, user)
			to_chat(user, span_notice("请求已发送。"))
			user.log_message("has requested the nuclear codes from CentCom with reason \"[reason]\"", LOG_SAY)
			priority_announce("[user]已申请空间站核自毁装置的密码。稍后将收到批准或拒绝的回复。", "核自毁密码申请", SSstation.announcer.get_rand_report_sound())
			playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 50, FALSE)
			COOLDOWN_START(src, important_action_cooldown, IMPORTANT_ACTION_COOLDOWN)
		if ("restoreBackupRoutingData")
			if (!authenticated_as_non_silicon_captain(user))
				return
			if (!(obj_flags & EMAGGED))
				return
			to_chat(user, span_notice("备用路由数据已恢复。"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)
			obj_flags &= ~EMAGGED
		if ("sendToOtherSector")
			if (!authenticated_as_non_silicon_captain(user))
				return
			if (!can_send_messages_to_other_sectors(user))
				return
			if (!COOLDOWN_FINISHED(src, important_action_cooldown))
				return

			var/message = trim(html_encode(params["message"]), MAX_MESSAGE_LEN)
			if (!message)
				return

			GLOB.communications_controller.soft_filtering = FALSE
			var/list/hard_filter_result = is_ic_filtered(message)
			if(hard_filter_result)
				tgui_alert(user, "你的消息含有本服务器禁止的词语：\"[hard_filter_result[CHAT_FILTER_INDEX_WORD]]\"。")
				return

			var/list/soft_filter_result = is_soft_ooc_filtered(message)
			if(soft_filter_result)
				if(tgui_alert(user,"你的消息含有\"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\"。原因：\"[soft_filter_result[CHAT_FILTER_INDEX_REASON]]\"。确定要使用吗？", "敏感词提醒", list("是", "否")) != "是")
					return
				message_admins("[ADMIN_LOOKUPFLW(user)]确认使用触发软过滤的词语\"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\"。其跨站消息可能包含禁用词，已延长可拒绝发送的等待时间。\n\n消息：\"[html_encode(message)]\"")
				log_admin_private("[key_name(user)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". They may be using a disallowed term for a cross-station message. Increasing delay time to reject.\n\n Message: \"[message]\"")
				GLOB.communications_controller.soft_filtering = TRUE

			playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)

			var/destination = params["destination"]
			if (!(destination in CONFIG_GET(keyed_list/cross_server)) && destination != "all")
				message_admins("[ADMIN_LOOKUPFLW(user)]为通讯控制台跨星区消息提供了无效目的地。消息：\"[html_encode(message)]\"")
				return

			user.log_message("is about to send the following message to [destination]: [message]", LOG_GAME)
			to_chat(
				GLOB.admins,
				span_adminnotice( \
					"<b color='orange'>跨星区消息（待发送）：</b>[ADMIN_LOOKUPFLW(user)]即将发送 \
					以下消息至<b>[destination]</b>（将在[GLOB.communications_controller.soft_filtering ? DisplayTimeText(EXTENDED_CROSS_SECTOR_CANCEL_TIME) : DisplayTimeText(CROSS_SECTOR_CANCEL_TIME)]后自动批准）： \
					<b><a href='byond://?src=[REF(src)];reject_cross_comms_message=1'>拒绝发送</a></b><br> \
					[html_encode(message)]" \
				)
			)

			send_cross_comms_message_timer = addtimer(CALLBACK(src, PROC_REF(send_cross_comms_message), user, destination, message), GLOB.communications_controller.soft_filtering ? EXTENDED_CROSS_SECTOR_CANCEL_TIME : CROSS_SECTOR_CANCEL_TIME, TIMER_STOPPABLE)

			COOLDOWN_START(src, important_action_cooldown, IMPORTANT_ACTION_COOLDOWN)
		if ("setState")
			if (!authenticated(user))
				return
			if (!(params["state"] in approved_states))
				return
			if (state == STATE_BUYING_SHUTTLE && can_buy_shuttles(user) != TRUE)
				return
			set_state(usr, params["state"])
		if ("setStatusMessage")
			if (!authenticated(user))
				return
			var/line_one = reject_bad_text(params["upperText"] || "", MAX_STATUS_LINE_LENGTH)
			var/line_two = reject_bad_text(params["lowerText"] || "", MAX_STATUS_LINE_LENGTH)
			post_status("message", line_one, line_two)
			last_status_display = list(line_one, line_two)
		if ("setStatusPicture")
			if (!authenticated(user))
				return
			var/picture = params["picture"]
			if (!(picture in GLOB.status_display_approved_pictures))
				return
			if(picture in GLOB.status_display_state_pictures)
				post_status(picture)
			else
				if(picture == "currentalert") // You cannot set Code Blue display during Code Red and similiar
					post_status("alert", SSsecurity_level?.current_security_level?.status_display_icon_state || "greenalert")
				else
					post_status("alert", picture)

		if ("toggleAuthentication")
			// Log out if we're logged in
			if (authorize_name)
				authenticated = FALSE
				authorize_access = null
				authorize_name = null
				playsound(src, 'sound/machines/terminal/terminal_off.ogg', 50, FALSE)
				return

			if (obj_flags & EMAGGED)
				authenticated = TRUE
				authorize_access = SSid_access.get_region_access_list(list(REGION_ALL_STATION))
				authorize_name = "未知"
				to_chat(user, span_warning("[src]的登录验证被绕过，发出轻微警报。"))
				playsound(src, 'sound/machines/terminal/terminal_alert.ogg', 25, FALSE)
			else if(isliving(user))
				var/mob/living/L = user
				var/obj/item/card/id/id_card = L.get_idcard(hand_first = TRUE)
				if (check_access(id_card))
					authenticated = TRUE
					authorize_access = id_card.access.Copy()
					authorize_name = "[id_card.registered_name] - [chinese_job_display(id_card.assignment)]"

			state = STATE_MAIN
			playsound(src, 'sound/machines/terminal/terminal_on.ogg', 50, FALSE)
			imprint_gps("加密通讯频道")

		if ("toggleEmergencyAccess")
			if(emergency_access_cooldown(user)) //if were in cooldown, dont allow the following code
				return
			if (!authenticated_as_silicon_or_captain(user))
				return
			if (GLOB.emergency_access)
				revoke_maint_all_access()
				user.log_message("disabled emergency maintenance access.", LOG_GAME)
				message_admins("[ADMIN_LOOKUPFLW(user)]关闭了维护隧道紧急通行权限。")
				deadchat_broadcast("在[span_name("[chinese_area_display(get_area_name(user, TRUE))]")]关闭了维护隧道紧急通行权限。", span_name("[user.real_name]"), user, message_type = DEADCHAT_ANNOUNCEMENT)
			else
				make_maint_all_access()
				user.log_message("enabled emergency maintenance access.", LOG_GAME)
				message_admins("[ADMIN_LOOKUPFLW(user)]开启了维护隧道紧急通行权限。")
				deadchat_broadcast("在[span_name("[chinese_area_display(get_area_name(user, TRUE))]")]开启了维护隧道紧急通行权限。", span_name("[user.real_name]"), user, message_type = DEADCHAT_ANNOUNCEMENT)
		// Request codes for the Captain's Spare ID safe.
		if("requestSafeCodes")
			if(SSjob.assigned_captain)
				to_chat(user, span_warning("空间站已有获任命的舰长或代理舰长！"))
				return

			if(SSjob.safe_code_timer_id)
				to_chat(user, span_warning("保险箱密码已申请，正在送往你的空间站！"))
				return

			if(SSjob.safe_code_requested)
				to_chat(user, span_warning("保险箱密码已经申请并送达你的空间站！"))
				return

			if(!SSid_access.spare_id_safe_code)
				to_chat(user, span_warning("没有可送往你站的保险箱密码！"))
				return

			var/turf/pod_location = get_turf(src)

			SSjob.safe_code_request_loc = pod_location
			SSjob.safe_code_requested = TRUE
			SSjob.safe_code_timer_id = addtimer(CALLBACK(SSjob, TYPE_PROC_REF(/datum/controller/subsystem/job, send_spare_id_safe_code), pod_location), 120 SECONDS, TIMER_UNIQUE | TIMER_STOPPABLE)
			minor_announce("由于人员短缺，已批准向你站发送用于获取舰长备用身份证的密码。空投舱将送达[chinese_area_display(get_area_name(pod_location))]，预计120秒后抵达。")

		// SKYRAT EDIT ADDITION START
		if ("callThePolice")
			if(!pre_911_check(usr))
				return
			calling_911(usr, "执法官", EMERGENCY_RESPONSE_POLICE)
		if ("callTheCatmos")
			if(!pre_911_check(usr))
				return
			calling_911(usr, "高级大气工程队", EMERGENCY_RESPONSE_ATMOS)
		if ("callTheParameds")
			if(!pre_911_check(usr))
				return
			calling_911(usr, "急救医疗队", EMERGENCY_RESPONSE_EMT)
		if("callThePizza")
			if(!(obj_flags & EMAGGED))
				return
			if(!pre_911_check(usr))
				return
			GLOB.cops_arrived = TRUE
			log_game("[key_name(usr)] has dialed for a pizza order from Dogginos using an emagged communications console.")
			message_admins("[ADMIN_LOOKUPFLW(usr)]使用被电磁破解的通讯控制台致电多吉诺披萨店订购披萨。")
			deadchat_broadcast("使用被电磁破解的通讯控制台致电多吉诺披萨店订购披萨。", span_name("[usr.real_name]"), usr, message_type=DEADCHAT_ANNOUNCEMENT)
			GLOB.pizza_order = pick(GLOB.pizza_names)
			call_911(EMERGENCY_RESPONSE_EMAG)
			to_chat(usr, span_notice("感谢选择多吉诺披萨店，[GLOB.pizza_order]！"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)
		if("toggleEngOverride")
			if(emergency_access_cooldown(usr)) //if were in cooldown, dont allow the following code
				return
			if (!authenticated_as_silicon_or_captain(usr))
				return
			if (GLOB.force_eng_override)
				toggle_eng_override()
				usr.log_message("disabled airlock engineering override.", LOG_GAME)
				deadchat_broadcast("在[span_name("[chinese_area_display(get_area_name(usr, TRUE))]")]关闭了气闸工程越权控制。", span_name("[usr.real_name]"), usr, message_type = DEADCHAT_ANNOUNCEMENT)
			else
				toggle_eng_override()
				usr.log_message("enabled airlock engineering override.", LOG_GAME)
				deadchat_broadcast("在[span_name("[chinese_area_display(get_area_name(usr, TRUE))]")]开启了气闸工程越权控制。", span_name("[usr.real_name]"), usr, message_type = DEADCHAT_ANNOUNCEMENT)
		// SKYRAT EDIT ADDITION END

/obj/machinery/computer/communications/proc/emergency_access_cooldown(mob/user)
	if(toggle_uses == toggle_max_uses) //you have used up free uses already, do it one more time and start a cooldown
		to_chat(user, span_warning("这是最后一次免冷却使用，接下来的[DisplayTimeText(EMERGENCY_ACCESS_COOLDOWN)]内你将无法再次使用。"))
		COOLDOWN_START(src, emergency_access_cooldown, EMERGENCY_ACCESS_COOLDOWN)
		++toggle_uses //add a use so that this if() is false the next time you try this button
		return FALSE

	if(!COOLDOWN_FINISHED(src, emergency_access_cooldown))
		var/time_left = DisplayTimeText(COOLDOWN_TIMELEFT(src, emergency_access_cooldown), 1)
		to_chat(user, span_warning("紧急通行权限仍需冷却[time_left]！"))
		return TRUE //dont use the button, we are in cooldown
	else if((last_toggled + EMERGENCY_ACCESS_COOLDOWN) < world.time)
		toggle_uses = 0 //either cooldown is done, or we just havent touched it in 30 seconds, either way reset uses

	++toggle_uses //add a use
	last_toggled = world.time
	return FALSE //if we are not in cooldown, allow using the button

/obj/machinery/computer/communications/proc/send_cross_comms_message(mob/user, destination, message)
	send_cross_comms_message_timer = null

	var/list/payload = list()

	payload["sender_ckey"] = user.ckey
	var/network_name = CONFIG_GET(string/cross_comms_network)
	if(network_name)
		payload["network"] = network_name
	if(GLOB.communications_controller.soft_filtering)
		payload["is_filtered"] = TRUE

	var/name_to_send = "[CONFIG_GET(string/cross_comms_name)]([station_name()])" //SKYRAT EDIT ADDITION

	send2otherserver(html_decode(name_to_send), message, "Comms_Console", destination == "all" ? null : list(destination), additional_data = payload) //SKYRAT EDIT END
	minor_announce(message, title = "发送至盟友空间站的消息")
	user.log_talk(message, LOG_SAY, tag = "message to the other server")
	message_admins("[ADMIN_LOOKUPFLW(user)]向其他服务器发送了消息。")
	deadchat_broadcast("向其他空间站发送了消息。</span>", "<span class='bold'>[user.real_name]", user, message_type = DEADCHAT_ANNOUNCEMENT)
	GLOB.communications_controller.soft_filtering = FALSE // set it to false at the end of the proc to ensure that everything prior reads as intended

/obj/machinery/computer/communications/ui_data(mob/user)
	var/list/data = list(
		"authenticated" = FALSE,
		"emagged" = FALSE,
		"syndicate" = syndicate,
	)

	var/ui_state = HAS_SILICON_ACCESS(user) ? cyborg_state : state

	var/has_connection = has_communication()
	data["hasConnection"] = has_connection

	if(!SSjob.assigned_captain && !SSjob.safe_code_requested && SSid_access.spare_id_safe_code && has_connection)
		data["canRequestSafeCode"] = TRUE
		data["safeCodeDeliveryWait"] = 0
	else
		data["canRequestSafeCode"] = FALSE
		if(SSjob.safe_code_timer_id && has_connection)
			data["safeCodeDeliveryWait"] = timeleft(SSjob.safe_code_timer_id)
			data["safeCodeDeliveryArea"] = chinese_area_display(get_area_name(SSjob.safe_code_request_loc))
		else
			data["safeCodeDeliveryWait"] = 0
			data["safeCodeDeliveryArea"] = null

	if (authenticated || HAS_SILICON_ACCESS(user))
		data["authenticated"] = TRUE
		data["canLogOut"] = !HAS_SILICON_ACCESS(user)
		data["page"] = ui_state

		if ((obj_flags & EMAGGED) || syndicate)
			data["emagged"] = TRUE

		switch (ui_state)
			if (STATE_MAIN)
				data["canBuyShuttles"] = can_buy_shuttles(user)
				data["canMakeAnnouncement"] = FALSE
				data["canMessageAssociates"] = FALSE
				data["canRecallShuttles"] = !HAS_SILICON_ACCESS(user)
				data["canRequestNuke"] = FALSE
				data["canSendToSectors"] = FALSE
				data["canSetAlertLevel"] = FALSE
				data["canToggleEmergencyAccess"] = FALSE
				data["canToggleEngineeringOverride"] = FALSE //SKYRAT EDIT - Engineering Override
				data["importantActionReady"] = COOLDOWN_FINISHED(src, important_action_cooldown)
				data["shuttleCalled"] = FALSE
				data["shuttleLastCalled"] = FALSE
				data["aprilFools"] = check_holidays(APRIL_FOOLS)
				data["alertLevel"] = SSsecurity_level.get_current_level_as_text()
				data["authorizeName"] = authorize_name
				data["canLogOut"] = !HAS_SILICON_ACCESS(user)
				data["shuttleCanEvacOrFailReason"] = SSshuttle.canEvac()
				if(syndicate)
					data["shuttleCanEvacOrFailReason"] = "无法通过此控制台呼叫穿梭机！"

				if (authenticated_as_non_silicon_captain(user))
					data["canMessageAssociates"] = TRUE
					data["canRequestNuke"] = TRUE

				if (can_send_messages_to_other_sectors(user))
					data["canSendToSectors"] = TRUE

					var/list/sectors = list()
					var/our_id = CONFIG_GET(string/cross_comms_name)

					for (var/server in CONFIG_GET(keyed_list/cross_server))
						if (server == our_id)
							continue
						sectors += server

					data["sectors"] = sectors

				if (authenticated_as_silicon_or_captain(user))
					data["canToggleEmergencyAccess"] = TRUE
					data["emergencyAccess"] = GLOB.emergency_access
					data["canToggleEngineeringOverride"] = TRUE //SKYRAT EDIT - Engineering Override Toggle
					data["engineeringOverride"] = GLOB.force_eng_override //SKYRAT EDIT - Engineering Override Toggle
					data["alertLevelTick"] = alert_level_tick
					data["canMakeAnnouncement"] = TRUE
					data["canSetAlertLevel"] = HAS_SILICON_ACCESS(user) ? "NO_SWIPE_NEEDED" : "SWIPE_NEEDED"
				else if(syndicate)
					data["canMakeAnnouncement"] = TRUE

				if (authenticated_as_ai_or_captain(user))
					data["canMessageAssociates"] = TRUE //Skyrat Edit | Allows AI to report to CC in the event of there being no command alive/to begin with

				if (SSshuttle.emergency.mode != SHUTTLE_IDLE && SSshuttle.emergency.mode != SHUTTLE_RECALL)
					data["shuttleCalled"] = TRUE
					data["shuttleRecallable"] = SSshuttle.can_recall(user) || syndicate

				if (SSshuttle.emergencyCallAmount)
					data["shuttleCalledPreviously"] = TRUE
					if (SSshuttle.emergency_last_call_loc)
						data["shuttleLastCalled"] = chinese_area_display(SSshuttle.emergency_last_call_loc.name)
			if (STATE_MESSAGES)
				data["messages"] = list()

				if (messages)
					for (var/_message in messages)
						var/datum/comm_message/message = _message
						data["messages"] += list(list(
							"answered" = message.answered,
							"content" = message.content,
							"title" = message.title,
							"possibleAnswers" = message.possible_answers,
						))
			if (STATE_BUYING_SHUTTLE)
				var/datum/bank_account/bank_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
				var/list/shuttles = list()

				for (var/shuttle_id in SSmapping.shuttle_templates)
					var/datum/map_template/shuttle/shuttle_template = SSmapping.shuttle_templates[shuttle_id]

					if (shuttle_template.credit_cost == INFINITY)
						continue

					if (!can_purchase_this_shuttle(shuttle_template))
						continue

					var/department_locked = FALSE
					var/department_name_string = ""

					if (istype(shuttle_template, /datum/map_template/shuttle/emergency/departmental))
						var/datum/map_template/shuttle/emergency/departmental/dept_shuttle = shuttle_template
						department_name_string = dept_shuttle.department_name

						if (dept_shuttle.department_type)
							var/crew_in_department = get_department_employee_count(dept_shuttle.department_type)
							if(crew_in_department <= 0)
								department_locked = TRUE
							else
								for(var/other_id in SSmapping.shuttle_templates)
									var/datum/map_template/shuttle/emergency/departmental/other_shuttle = SSmapping.shuttle_templates[other_id]
									if(!istype(other_shuttle) || other_shuttle == dept_shuttle || !other_shuttle.department_type)
										continue
									var/crew_in_other_department = get_department_employee_count(other_shuttle.department_name)
									if(crew_in_department < crew_in_other_department)
										department_locked = TRUE
										break

					shuttles += list(list(
						"name" = chinese_template_display(shuttle_template.name),
						"description" = shuttle_template.description,
						"occupancy_limit" = shuttle_template.occupancy_limit,
						"creditCost" = shuttle_template.credit_cost,
						"initial_cost" = initial(shuttle_template.credit_cost),
						"emagOnly" = shuttle_template.emag_only,
						"prerequisites" = shuttle_template.prerequisites,
						"ref" = REF(shuttle_template),
						"department_locked" = department_locked,
						"department_name" = department_name_string,
					))

				data["budget"] = bank_account.account_balance
				data["shuttles"] = shuttles
			if (STATE_CHANGING_STATUS)
				data["upperText"] = last_status_display ? last_status_display[1] : ""
				data["lowerText"] = last_status_display ? last_status_display[2] : ""

	return data

/obj/machinery/computer/communications/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "CommunicationsConsole")
		ui.open()

/obj/machinery/computer/communications/ui_static_data(mob/user)
	return list(
		"callShuttleReasonMinLength" = CALL_SHUTTLE_REASON_LENGTH,
		"maxStatusLineLength" = MAX_STATUS_LINE_LENGTH,
		"maxMessageLength" = MAX_MESSAGE_LEN,
		"displayed_currency_full_name" = " [MONEY_NAME]",
		"displayed_currency_name" = " [MONEY_SYMBOL]",
	)

/obj/machinery/computer/communications/Topic(href, href_list)
	if (href_list["reject_cross_comms_message"])
		if (!usr.client?.holder)
			usr.log_message("tried to reject a cross-comms message without being an admin.", LOG_ADMIN)
			message_admins("[key_name(usr)]尝试在没有管理员权限的情况下拒绝跨站通讯消息。")
			return

		if (isnull(send_cross_comms_message_timer))
			to_chat(usr, span_warning("太迟了！"))
			return

		deltimer(send_cross_comms_message_timer)
		GLOB.communications_controller.soft_filtering = FALSE
		send_cross_comms_message_timer = null

		log_admin("[key_name(usr)] has cancelled the outgoing cross-comms message.")
		message_admins("[key_name(usr)]取消了待发送的跨站通讯消息。")

		return TRUE

	return ..()

/// Returns whether or not the communications console can communicate with the station
/obj/machinery/computer/communications/proc/has_communication()
	var/turf/current_turf = get_turf(src)
	var/z_level = current_turf.z
	if(syndicate)
		return TRUE
	return is_station_level(z_level) || is_centcom_level(z_level)

/obj/machinery/computer/communications/proc/set_state(mob/user, new_state)
	if (HAS_SILICON_ACCESS(user))
		cyborg_state = new_state
	else
		state = new_state

/// Returns TRUE if the user can buy shuttles.
/// If they cannot, returns FALSE or a string detailing why.
/obj/machinery/computer/communications/proc/can_buy_shuttles(mob/user)
	if (!SSmapping.current_map.allow_custom_shuttles)
		return FALSE
	if (HAS_SILICON_ACCESS(user))
		return FALSE

	var/has_access = FALSE

	for (var/access in SSshuttle.has_purchase_shuttle_access)
		if (access in authorize_access)
			has_access = TRUE
			break

	if (!has_access)
		return FALSE

	if (SSshuttle.emergency.mode != SHUTTLE_RECALL && SSshuttle.emergency.mode != SHUTTLE_IDLE)
		return "穿梭机已经在航行中。"
	if (SSshuttle.shuttle_purchased == SHUTTLEPURCHASE_PURCHASED)
		return "已经购买了替换穿梭机。"
	if (SSshuttle.shuttle_purchased == SHUTTLEPURCHASE_FORCED)
		return "由于意外情况，现已无法购买穿梭机。"
	return TRUE

/// Returns whether we are authorized to buy this specific shuttle.
/// Does not handle prerequisite checks, as those should still *show*.
/obj/machinery/computer/communications/proc/can_purchase_this_shuttle(datum/map_template/shuttle/shuttle_template)
	if (isnull(shuttle_template.who_can_purchase))
		return FALSE

	if (shuttle_template.emag_only)
		return !!(obj_flags & EMAGGED)

	for (var/access in authorize_access)
		if (access in shuttle_template.who_can_purchase)
			return TRUE

	return FALSE

/// Used in checks of dept-locked shuttles.
/// Determines number of employees in department.
/obj/machinery/computer/communications/proc/get_department_employee_count(datum/job_department/target_department_type)
	if(!target_department_type)
		return
	var/datum/job_department/current_department = SSjob.joinable_departments_by_type[target_department_type]
	if(!istype(current_department))
		return
	var/total_crew_count = 0
	for(var/datum/job/current_job in current_department.department_jobs)
		total_crew_count += current_job.current_positions
	return total_crew_count

/obj/machinery/computer/communications/proc/can_send_messages_to_other_sectors(mob/user)
	if (!authenticated_as_non_silicon_captain(user))
		return

	return length(CONFIG_GET(keyed_list/cross_server)) > 0

/obj/machinery/computer/communications/proc/make_announcement(mob/living/user)
	var/is_ai = HAS_SILICON_ACCESS(user)
	if(!GLOB.communications_controller.can_announce(user, is_ai))
		to_chat(user, span_alert("内部通讯系统正在充能，请稍候。"))
		return
	var/input = tgui_input_text(user, "向空间站船员广播的消息", "公告", max_length = MAX_MESSAGE_LEN)
	if(!input || !user.can_perform_action(src, ALLOW_SILICON_REACH))
		return
	if(user.try_speak(input))
		//Adds slurs and so on. Someone should make this use languages too.
		var/list/input_data = user.treat_message(input)
		input = input_data["message"]
	else
		//No cheating, mime/random mute guy!
		input = "..."
		user.visible_message(
			span_notice("[user]按住[src]的广播按钮，开着麦克风陷入尴尬的沉默。"),
			span_notice("你开着麦克风，陷入尴尬的沉默……"),
			span_hear("不知为何，你听到了一阵尴尬的沉默。"),
			vision_distance = 4,
		)

	var/list/players = get_communication_players()
	GLOB.communications_controller.make_announcement(user, is_ai, input, syndicate || (obj_flags & EMAGGED), players)
	deadchat_broadcast("在[span_name("[chinese_area_display(get_area_name(user, TRUE))]")]发布了优先公告。", span_name("[user.real_name]"), user, message_type=DEADCHAT_ANNOUNCEMENT)

/obj/machinery/computer/communications/proc/get_communication_players()
	return GLOB.player_list

/obj/machinery/computer/communications/proc/post_status(command, data1, data2)

	var/datum/radio_frequency/frequency = SSradio.return_frequency(FREQ_STATUS_DISPLAYS)

	if(!frequency)
		return

	var/datum/signal/status_signal = new(list("command" = command))
	switch(command)
		if("message")
			status_signal.data["top_text"] = data1
			status_signal.data["bottom_text"] = data2
			log_game("[key_name(usr)] has changed the station status display message to \"[data1] [data2]\" [loc_name(usr)]")

		if("alert")
			status_signal.data["picture_state"] = data1
			log_game("[key_name(usr)] has changed the station status display message to \"[data1]\" [loc_name(usr)]")


	frequency.post_signal(src, status_signal)

/obj/machinery/computer/communications/Destroy()
	GLOB.shuttle_caller_list -= src
	SSshuttle.autoEvac()
	return ..()

/// Override the cooldown for special actions
/// Used in places such as CentCom messaging back so that the crew can answer right away
/obj/machinery/computer/communications/proc/override_cooldown()
	COOLDOWN_RESET(src, important_action_cooldown)

/obj/machinery/computer/communications/proc/add_message(datum/comm_message/new_message)
	LAZYADD(messages, new_message)

/// Defines for the various hack results.
#define HACK_PIRATE "Pirates"
#define HACK_FUGITIVES "Fugitives"
#define HACK_SLEEPER "Sleeper Agents"

/// The minimum number of ghosts / observers to have the chance of spawning pirates.
#define MIN_GHOSTS_FOR_PIRATES 4
/// The minimum number of ghosts / observers to have the chance of spawning fugitives.
#define MIN_GHOSTS_FOR_FUGITIVES 6
/// The maximum percentage of the population to be ghosts before we no longer have the chance of spawning Sleeper Agents.
#define MAX_PERCENT_GHOSTS_FOR_SLEEPER 0.2

/// Begin the process of hacking into the comms console to call in a threat.
/obj/machinery/computer/communications/proc/try_hack_console(mob/living/hacker, duration = 30 SECONDS)
	if(!can_hack(hacker, feedback = TRUE))
		return FALSE

	AI_notify_hack()
	if(!do_after(hacker, duration, src, extra_checks = CALLBACK(src, PROC_REF(can_hack), hacker)))
		return FALSE

	hack_console(hacker)
	return TRUE

/// Checks if this console is hackable. Used as a callback during try_hack_console's doafter as well.
/obj/machinery/computer/communications/proc/can_hack(mob/living/hacker, feedback = FALSE)
	if(machine_stat & (NOPOWER|BROKEN))
		if(feedback && hacker)
			balloon_alert(hacker, "无法入侵！")
		return FALSE
	var/area/console_area = get_area(src)
	if(!console_area || !(console_area.area_flags & VALID_TERRITORY))
		if(feedback && hacker)
			balloon_alert(hacker, "信号太弱！")
		return FALSE
	return TRUE

/**
 * The communications console hack,
 * called by certain antagonist actions.
 *
 * Brings in additional threats to the round.
 *
 * hacker - the mob that caused the hack
 */
/obj/machinery/computer/communications/proc/hack_console(mob/living/hacker)
	// All hack results we'll choose from.
	var/list/hack_options = list(HACK_SLEEPER)

	// If we have a certain amount of ghosts, we'll add some more !!fun!! options to the list
	var/num_ghosts = length(GLOB.current_observers_list) + length(GLOB.dead_player_list)

	// Pirates / Fugitives have enough lead in time that there's no point summoning them if the shuttle is called
	// Both of these events also summon space ships and so cannot run on planetary maps
	if (EMERGENCY_IDLE_OR_RECALLED && !SSmapping.is_planetary())
		// Pirates require ghosts for the pirates obviously
		if(num_ghosts >= MIN_GHOSTS_FOR_PIRATES)
			hack_options += HACK_PIRATE
		// Fugitives require ghosts for both fugitives and hunters (Please no waldo)
		if(num_ghosts >= MIN_GHOSTS_FOR_FUGITIVES)
			hack_options += HACK_FUGITIVES

	var/picked_option = pick(hack_options)
	message_admins("[ADMIN_LOOKUPFLW(hacker)]入侵了位于[ADMIN_VERBOSEJMP(src)]的[name]，引发了[picked_option == HACK_PIRATE ? "海盗" : picked_option == HACK_FUGITIVES ? "逃犯" : "潜伏特工"]事件！")
	hacker.log_message("hacked a communications console, resulting in: [picked_option].", LOG_GAME, log_globally = TRUE)
	switch(picked_option)
		if(HACK_PIRATE) // Triggers pirates, which the crew may be able to pay off to prevent
			var/list/pirate_rulesets = list(
				/datum/dynamic_ruleset/midround/pirates,
				/datum/dynamic_ruleset/midround/pirates/heavy,
			)
			SSdynamic.force_run_midround(pick(pirate_rulesets))

		if(HACK_FUGITIVES) // Triggers fugitives, which can cause confusion / chaos as the crew decides which side help
			priority_announce(
				"全体船员注意：星区监控发现一艘身份不明的飞船正跃迁至你们所在星系。请做好可能发生接触的准备。",
				"[command_name()]高优先级通报",
			)
			SSdynamic.force_run_midround(/datum/dynamic_ruleset/midround/from_ghosts/fugitives)

		if(HACK_SLEEPER) // Trigger one or multiple sleeper agents with the crew (or for latejoining crew)
			priority_announce(
				"全体船员注意，你站似乎有人劫持了电信系统，并广播了未知信号。",
				"[command_name()]高优先级通报",
			)
			var/max_number_of_sleepers = clamp(round(length(GLOB.alive_player_list) / 40), 1, 3)
			if(!SSdynamic.force_run_midround(/datum/dynamic_ruleset/midround/from_living/traitor, forced_max_cap = max_number_of_sleepers))
				SSdynamic.queue_ruleset(/datum/dynamic_ruleset/latejoin/traitor)

#undef HACK_PIRATE
#undef HACK_FUGITIVES
#undef HACK_SLEEPER

#undef MIN_GHOSTS_FOR_PIRATES
#undef MIN_GHOSTS_FOR_FUGITIVES
#undef MAX_PERCENT_GHOSTS_FOR_SLEEPER

/datum/comm_message
	var/title
	var/content
	var/list/possible_answers = list()
	var/answered = FALSE
	var/datum/callback/answer_callback

/datum/comm_message/New(new_title,new_content,new_possible_answers)
	..()
	if(new_title)
		title = new_title
	if(new_content)
		content = new_content
	if(new_possible_answers)
		possible_answers = new_possible_answers

/datum/comm_message/Destroy()
	answer_callback = null
	return ..()

#undef IMPORTANT_ACTION_COOLDOWN
#undef EMERGENCY_ACCESS_COOLDOWN
#undef STATE_BUYING_SHUTTLE
#undef STATE_CHANGING_STATUS
#undef STATE_MAIN
#undef STATE_MESSAGES

//SKYRAT EDIT ADDITION
#undef EMERGENCY_RESPONSE_POLICE
#undef EMERGENCY_RESPONSE_ATMOS
#undef EMERGENCY_RESPONSE_EMT
#undef EMERGENCY_RESPONSE_EMAG
//SKYRAT EDIT END
