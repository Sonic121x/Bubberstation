GLOBAL_VAR_INIT(dchat_allowed, TRUE)

ADMIN_VERB(toggledchat, R_ADMIN, "切换死亡聊天", "切换这玩意。", ADMIN_CATEGORY_SERVER)
	toggle_dchat()
	log_admin("[key_name(usr)] 切换了死亡聊天。")
	message_admins("[key_name_admin(usr)] 切换了死亡聊天。")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle DCHAT", "[GLOB.dchat_allowed ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/proc/toggle_dchat(toggle = null)
	if(toggle != null) // if we're specifically en/disabling dead chat
		if(toggle != GLOB.dchat_allowed)
			GLOB.dchat_allowed = toggle
		else
			return
	else // otherwise just toggle it
		GLOB.dchat_allowed = !GLOB.dchat_allowed
	to_chat(world, span_oocplain("<B>死亡聊天频道已在全局[GLOB.dchat_allowed ? "启用" : "禁用"]。</B>"))

/datum/admin_help
	/// Have we requested this ticket to stop being part of the Ticket Ping subsystem?
	var/ticket_ping_stop = FALSE
	/// Are we added to the ticket ping subsystem in the first place
	var/ticket_ping = FALSE
	/// Who is handling this admin help?
	var/handler
	/// All sanitized text
	var/full_text

/datum/admin_help/ClosureLinks(ref_src)
	. = ..()
	. += " (<A href='byond://?_src_=holder;[HrefToken(forceGlobal = TRUE)];ahelp=[ref_src];ahelp_action=handle_issue'>处理</A>)"
	. += " (<A href='byond://?_src_=holder;[HrefToken(forceGlobal = TRUE)];ahelp=[ref_src];ahelp_action=pingmute'>静音提示</A>)"
	. += " (<A href='byond://?_src_=holder;[HrefToken(forceGlobal = TRUE)];ahelp=[ref_src];ahelp_action=convert'>导师帮助</A>)"

//Let the initiator know their ahelp is being handled
/datum/admin_help/proc/handle_issue(key_name = key_name_admin(usr))
	if(state != AHELP_ACTIVE)
		return FALSE

	if(handler && handler == usr.ckey) // No need to handle it twice as the same person ;)
		return TRUE

	if(handler && handler != usr.ckey)
		var/response = tgui_alert(usr, "该工单已由 [handler] 处理。你想继续吗？", "工单已分配", list("Yes", "No"))
		if(!response || response == "No")
			return FALSE

	var/msg = span_adminhelp("你的工单现在由 [usr?.client?.holder?.fakekey ? usr?.client?.holder?.fakekey : "一位管理员"] 处理！请稍候，他们正在输入回复和/或收集相关信息。")

	if(initiator)
		to_chat(initiator, msg)

	SSblackbox.record_feedback("tally", "ahelp_stats", 1, "handling")
	msg = "工单 [TicketHref("#[id]")] 正由 [key_name] 处理"
	message_admins(msg)
	log_admin_private(msg)
	AddInteraction("由 [key_name] 处理", "由 [key_name_admin(usr, FALSE)] 处理")

	handler = "[usr.ckey]"
	return TRUE

///Proc which converts an admin_help ticket to a mentorhelp
/datum/admin_help/proc/convert_to_mentorhelp(key_name = key_name_admin(usr))
	if(state != AHELP_ACTIVE)
		return FALSE

	if(handler && handler != usr.ckey)
		var/response = tgui_alert(usr, "该工单已由 [handler] 处理。你想继续吗？", "工单已分配", list("Yes", "No"))
		if(!response || response == "No")
			return FALSE

	ASSIGN_GAME_VERB(initiator, /client, mentorhelp) // Way to override mentorhelp cooldown.

	to_chat(initiator, span_adminhelp("你的工单已转换为导师帮助"))
	initiator.mentorhelp(full_text)
	initiator.giveadminhelpverb()

	message_admins("[key_name] 将来自 [initiator_key_name] 的工单 #[id] 转换为导师帮助")
	log_admin("[usr.client] 将来自 [initiator_ckey] 的工单 #[id] 转换为导师帮助")

	Close(key_name, TRUE)
