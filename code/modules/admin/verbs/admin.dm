ADMIN_VERB(show_tip, R_ADMIN, "显示小贴士", "向所有玩家发送一条小贴士。", ADMIN_CATEGORY_MAIN)
	var/input = input(user, "请指定你想发送给玩家的小贴士。", "小贴士", "") as message|null
	if(!input)
		return

	if(!SSticker)
		return

	// If we've already tipped, then send it straight away.
	if(SSticker.tipped)
		send_tip_of_the_round(world, input)
	else
		SSticker.selected_tip = input

	message_admins("[key_name_admin(user)] 发送了本回合小贴士。")
	log_admin("[key_name(user)] 发送了“[input]”作为本回合小贴士。")
	BLACKBOX_LOG_ADMIN_VERB("Show Tip")

ADMIN_VERB(announce, R_ADMIN, "公告", "向全世界宣告你的意愿。", ADMIN_CATEGORY_MAIN)
	var/message = input(user, "要发送的全局消息：", "管理员公告")  as message|null
	if(!message)
		return

	if(!user.holder.check_for_rights(R_SERVER))
		message = adminscrub(message,500)
	send_ooc_announcement(message, "来自 [user.holder.fakekey ? "管理员" : user.key]")
	log_admin("公告：[key_name(user)]：[message]")
	BLACKBOX_LOG_ADMIN_VERB("Announce")

ADMIN_VERB(unprison, R_ADMIN, "解除监禁", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(prisoner, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	if(!is_centcom_level(prisoner.z))
		tgui_alert(user, "[prisoner.name] 并未被监禁。")
		return

	SSjob.send_to_late_join(prisoner)
	message_admins("[key_name_admin(user)] 解除了 [key_name_admin(prisoner)] 的监禁")
	log_admin("[key_name(user)] 解除了 [key_name(prisoner)] 的监禁")
	BLACKBOX_LOG_ADMIN_VERB("Unprison")

ADMIN_VERB(cmd_admin_check_player_exp, R_ADMIN, "玩家游戏时长", "查看玩家的游戏时长。", ADMIN_CATEGORY_MAIN)
	if(!CONFIG_GET(flag/use_exp_tracking))
		to_chat(user, span_warning("服务器配置文件中未启用追踪功能。"), confidential = TRUE)
		return

	var/list/msg = list()
	msg += "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>游戏时长报告</title></head><body>游戏时长：<BR><UL>"
	for(var/client/client in sort_list(GLOB.clients, GLOBAL_PROC_REF(cmp_playtime_asc)))
		msg += "<LI> [ADMIN_PP(client.mob)] [key_name_admin(client)]: <A href='byond://?_src_=holder;[HrefToken()];getplaytimewindow=[REF(client.mob)]'>" + client.get_exp_living() + "</a></LI>"
	msg += "</UL></BODY></HTML>"
	user << browse(msg.Join(), "window=Player_playtime_check")

/client/proc/trigger_centcom_recall()
	if(!check_rights(R_ADMIN))
		return
	var/message = pick(GLOB.admiral_messages)
	message = input("输入值班上将的消息，将写入召回报告中。", "上将消息", message) as text|null

	if(!message)
		return

	if(!SSshuttle.centcom_recall(usr, SSshuttle.emergency.timer, message)) // feedback handled within
		return

	message_admins("[key_name_admin(usr)] 触发了一次中央指挥部召回，上将消息为：[message]")
	usr.log_message("触发了一次中央指挥部召回，消息为：[message]", LOG_GAME)


/datum/admins/proc/cmd_show_exp_panel(client/client_to_check)
	if(!check_rights(R_ADMIN))
		return
	if(!client_to_check)
		to_chat(usr, span_danger("错误：未找到客户端。"), confidential = TRUE)
		return
	if(!CONFIG_GET(flag/use_exp_tracking))
		to_chat(usr, span_warning("服务器配置文件中未启用追踪功能。"), confidential = TRUE)
		return

	new /datum/job_report_menu(client_to_check, usr)

/datum/admins/proc/toggle_exempt_status(client/C)
	if(!check_rights(R_ADMIN))
		return
	if(!C)
		to_chat(usr, span_danger("错误：未找到客户端。"), confidential = TRUE)
		return

	if(!C.set_db_player_flags())
		to_chat(usr, span_danger("错误：无法从数据库读取玩家标记。请检查日志。"), confidential = TRUE)
	var/dbflags = C.prefs.db_flags
	var/newstate = FALSE
	if(dbflags & DB_FLAG_EXEMPT)
		newstate = FALSE
	else
		newstate = TRUE

	if(C.update_flag_db(DB_FLAG_EXEMPT, newstate))
		to_chat(usr, span_danger("错误：无法更新玩家标记。请检查日志。"), confidential = TRUE)
	else
		message_admins("[key_name_admin(usr)] [newstate ? "启用" : "停用"]了 [key_name_admin(C)] 的职业经验豁免状态")
		log_admin("[key_name(usr)] [newstate ? "启用" : "停用"]了 [key_name(C)] 的职业经验豁免状态")

/// Allow admin to add or remove traits of datum
/datum/admins/proc/modify_traits(datum/D)
	if(!D)
		return
	if(!check_rights(R_VAREDIT))
		return

	var/add_or_remove = input("移除/添加？", "特质移除/添加") as null|anything in list("Add","Remove")
	if(!add_or_remove)
		return
	var/list/available_traits = list()

	switch(add_or_remove)
		if("Add")
			for(var/key in GLOB.admin_visible_traits)
				if(istype(D,key))
					available_traits += GLOB.admin_visible_traits[key]
		if("Remove")
			if(!GLOB.admin_trait_name_map)
				GLOB.admin_trait_name_map = generate_admin_trait_name_map()
			for(var/trait in D._status_traits)
				var/name = GLOB.admin_trait_name_map[trait] || trait
				available_traits[name] = trait

	var/chosen_trait = input("选择要修改的特质", "特质") as null|anything in sort_list(available_traits)
	if(!chosen_trait)
		return
	chosen_trait = available_traits[chosen_trait]

	var/source = TRAIT_ADMIN_GRANTED
	switch(add_or_remove)
		if("Add") //Not doing source choosing here intentionally to make this bit faster to use, you can always vv it.
			if(GLOB.movement_type_trait_to_flag[chosen_trait]) //include the required element.
				D.AddElement(/datum/element/movetype_handler)
			ADD_TRAIT(D,chosen_trait,source)
		if("Remove")
			var/specific = input("所有来源还是特定来源？", "特质移除/添加") as null|anything in list("All","Specific")
			if(!specific)
				return
			switch(specific)
				if("All")
					source = null
				if("Specific")
					source = input("要移除的来源","特质移除/添加") as null|anything in sort_list(GET_TRAIT_SOURCES(D, chosen_trait))
					if(!source)
						return
			REMOVE_TRAIT(D,chosen_trait,source)

///////////////////////////////////////////////////////////////////////////////////////////////

ADMIN_VERB(drop_everything, R_ADMIN, "丢弃所有物品", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(dropee, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob/living)
	var/confirm = tgui_alert(user, "要让 [dropee] 丢弃所有物品吗？", "消息", list("Yes", "No"))
	if(confirm != "Yes")
		return

	dropee.drop_everything(del_on_drop = FALSE, force = TRUE, del_if_nodrop = TRUE)
	dropee.regenerate_icons()

	log_admin("[key_name(user)] 让 [key_name(dropee)] 丢弃了所有物品！")
	var/msg = "[key_name_admin(user)] 让 [ADMIN_LOOKUPFLW(dropee)] 丢弃了所有物品！"
	message_admins(msg)
	admin_ticket_log(dropee, msg)
	BLACKBOX_LOG_ADMIN_VERB("Drop Everything")

/proc/cmd_admin_mute(whom, mute_type, automute = 0)
	if(!whom)
		return

	var/muteunmute
	var/mute_string
	var/feedback_string
	switch(mute_type)
		if(MUTE_IC)
			mute_string = "IC（发言与表情）"
			feedback_string = "IC"
		if(MUTE_OOC)
			mute_string = "OOC"
			feedback_string = "OOC"
		if(MUTE_PRAY)
			mute_string = "祈祷"
			feedback_string = "Pray"
		if(MUTE_ADMINHELP)
			mute_string = "管理员求助、管理员私信与 ASAY"
			feedback_string = "Adminhelp"
		if(MUTE_DEADCHAT)
			mute_string = "死亡聊天与 DSAY"
			feedback_string = "Deadchat"
		// SKYRAT EDIT ADDITION START - LOOC muting again.
		if(MUTE_LOOC)
			mute_string = "LOOC"
			feedback_string = "LOOC"
		// SKYRAT EDIT ADDITION END - LOOC muting again.
		if(MUTE_INTERNET_REQUEST)
			mute_string = "网络音效请求"
			feedback_string = "Internet Sound Requests"
		if(MUTE_ALL)
			mute_string = "一切"
			feedback_string = "Everything"
		else
			return

	var/client/C
	if(istype(whom, /client))
		C = whom
	else if(istext(whom))
		C = GLOB.directory[whom]
	else
		return

	var/datum/preferences/P
	if(C)
		P = C.prefs
	else
		P = GLOB.preferences_datums[whom]
	if(!P)
		return

	if(automute)
		if(!CONFIG_GET(flag/automute_on))
			return
	else
		if(!check_rights())
			return

	if(automute)
		muteunmute = "禁言"
		P.muted |= mute_type
		log_admin("垃圾信息自动禁言：[muteunmute] [key_name(whom)]，范围 [mute_string]")
		message_admins("垃圾信息自动禁言：[muteunmute] [key_name_admin(whom)]，范围 [mute_string]。")
		if(C)
			to_chat(C, "你已被垃圾信息自动禁言系统禁言：[mute_string]。请联系管理员。", confidential = TRUE)
		SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Auto Mute [feedback_string]", "1")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!
		return

	if(P.muted & mute_type)
		muteunmute = "解除禁言"
		P.muted &= ~mute_type
	else
		muteunmute = "禁言"
		P.muted |= mute_type

	log_admin("[key_name(usr)] 已对 [key_name(whom)] 执行[muteunmute]，范围 [mute_string]")
	message_admins("[key_name_admin(usr)] 已对 [key_name_admin(whom)] 执行[muteunmute]，范围 [mute_string]。")
	if(C)
		to_chat(C, "你已被 [key_name(usr, include_name = FALSE)] [muteunmute]，范围 [mute_string]。", confidential = TRUE)
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Mute [feedback_string]", "[P.muted & mute_type]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

/proc/immerse_player(mob/living/carbon/target, toggle=TRUE, remove=FALSE)
	var/list/immersion_components = list(/datum/component/manual_breathing, /datum/component/manual_blinking)

	for(var/immersies in immersion_components)
		var/has_component = target.GetComponent(immersies)

		if(has_component && (toggle || remove))
			qdel(has_component)
		else if(toggle || !remove)
			target.AddComponent(immersies)

/proc/mass_immerse(remove=FALSE)
	for(var/mob/living/carbon/M in GLOB.mob_list)
		immerse_player(M, toggle=FALSE, remove=remove)
