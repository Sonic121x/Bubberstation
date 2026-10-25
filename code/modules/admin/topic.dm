/datum/admins/proc/CheckAdminHref(href, href_list)
	var/auth = href_list["admin_token"]
	. = auth && (auth == href_token || auth == GLOB.href_token)
	if(.)
		return
	var/msg = !auth ? "缺失的" : "错误的"
	message_admins("[key_name_admin(usr)] 点击了一个使用[msg]授权密钥的 href 链接！")
	if(CONFIG_GET(flag/debug_admin_hrefs))
		message_admins("调试模式已启用，调用未被拦截。请让你们的程序员查看本回合的日志。")
		log_world("UAH: [href]")
		return TRUE
	log_admin_private("[key_name(usr)] 点击了一个使用[msg]授权密钥的 href 链接！[href]")

/datum/admins/Topic(href, href_list)
	..()

	if(usr.client != src.owner || !check_rights(0))
		message_admins("[usr.key] 试图覆盖管理员面板！")
		log_admin("[key_name(usr)] 试图在未授权的情况下使用管理员面板。")
		return

	if(!CheckAdminHref(href, href_list))
		return

	if(href_list["ahelp"])
		if(!check_rights(R_ADMIN, TRUE))
			return

		var/ahelp_ref = href_list["ahelp"]
		var/datum/admin_help/AH = locate(ahelp_ref)
		if(AH)
			AH.Action(href_list["ahelp_action"])
		else
			to_chat(usr, "工单 [ahelp_ref] 已被删除！", confidential = TRUE)

	else if(href_list["ahelp_tickets"])
		GLOB.ahelp_tickets.BrowseTickets(text2num(href_list["ahelp_tickets"]))

	else if(href_list["stickyban"])
		stickyban(href_list["stickyban"],href_list)

	else if(href_list["getplaytimewindow"])
		if(!check_rights(R_ADMIN))
			return
		var/mob/M = locate(href_list["getplaytimewindow"]) in GLOB.mob_list
		if(!M)
			to_chat(usr, span_danger("错误：未找到生物。"), confidential = TRUE)
			return
		cmd_show_exp_panel(M.client)

	// BUBBER EDIT START - Job exemption
	else if (href_list["getjobexemptwindow"])
		var/target_ckey = href_list["getjobexemptwindow"]
		show_job_exempt_menu(usr, target_ckey)
	else if (href_list["getjobexempttask"])
		var/target_ckey = href_list["getjobexempttask"]
		handle_job_exempt_menu_topic(usr, href, href_list, target_ckey)
	// BUBBER EDIT END

	else if(href_list["editrightsbrowser"])
		edit_admin_permissions(PERMISSIONS_PAGE_PERMISSIONS)

	else if(href_list["editrightsbrowserranks"])
		if(href_list["editrightsaddrank"])
			add_rank()
		else if(href_list["editrightsremoverank"])
			remove_rank(href_list["editrightsremoverank"])
		else if(href_list["editrightseditrank"])
			change_rank(href_list["editrightseditrank"])
		edit_admin_permissions(PERMISSIONS_PAGE_RANKS)

	else if(href_list["editrightsbrowserlogging"])
		edit_admin_permissions(PERMISSIONS_PAGE_LOGGING, href_list["editrightslogtarget"], href_list["editrightslogactor"], href_list["editrightslogoperation"], href_list["editrightslogpage"])

	if(href_list["editrightsbrowserhousekeep"])
		if(href_list["editrightschange"])
			change_admin_rank(ckey(href_list["editrightschange"]), href_list["editrightschange"], TRUE)
		else if(href_list["editrightsremove"])
			remove_admin(ckey(href_list["editrightsremove"]), href_list["editrightsremove"], TRUE)
		else if(href_list["editrightsremoverank"])
			remove_rank(href_list["editrightsremoverank"])
		edit_admin_permissions(PERMISSIONS_PAGE_HOUSEKEEPING)

	else if(href_list["editrights"])
		edit_rights_topic(href_list)

	else if(href_list["gamemode_panel"])
		// dynamic_panel(usr) // BUBBER EDIT - STORYTELLER
		SSgamemode.ui_interact(usr) // BUBBER EDIT - STORYTELLER

	else if(href_list["call_shuttle"])
		if(!check_rights(R_ADMIN))
			return


		switch(href_list["call_shuttle"])
			if("1")
				if(EMERGENCY_AT_LEAST_DOCKED)
					return
				SSshuttle.emergency.request()
				log_admin("[key_name(usr)] 呼叫了紧急穿梭机。")
				message_admins(span_adminnotice("[key_name_admin(usr)] 将紧急穿梭机呼叫至空间站。"))

			if("2")
				if(EMERGENCY_AT_LEAST_DOCKED)
					return
				switch(SSshuttle.emergency.mode)
					if(SHUTTLE_CALL)
						SSshuttle.cancel_evac(usr) // note that this does provide logging/feedback of its own but it's better for backcompatibility to retain the following logging lines
						log_admin("[key_name(usr)] 将紧急穿梭机送回了。")
						message_admins(span_adminnotice("[key_name_admin(usr)] 将紧急穿梭机送回了。"))
					else
						SSshuttle.emergency.request()
						log_admin("[key_name(usr)] 呼叫了紧急穿梭机。")
						message_admins(span_adminnotice("[key_name_admin(usr)] 将紧急穿梭机呼叫至空间站。"))



	else if(href_list["edit_shuttle_time"])
		if(!check_rights(R_SERVER))
			return

		var/timer = input("输入新的穿梭机时长（秒）：","编辑穿梭机剩余时间", SSshuttle.emergency.timeLeft() ) as num|null
		if(!timer)
			return
		SSshuttle.emergency.setTimer(timer SECONDS)
		log_admin("[key_name(usr)] 将紧急穿梭机的剩余时间改为 [timer] 秒。")
		minor_announce("紧急穿梭机将在 [DisplayTimeText(timer SECONDS)] 后抵达目的地。")
		message_admins(span_adminnotice("[key_name_admin(usr)] 将紧急穿梭机的剩余时间改为 [timer] 秒。"))
	else if(href_list["trigger_centcom_recall"])
		if(!check_rights(R_ADMIN))
			return

		usr.client.trigger_centcom_recall()

	else if(href_list["move_shuttle"])
		if(!check_rights(R_ADMIN))
			return

		var/obj/docking_port/mobile/shuttle = SSshuttle.getShuttle(href_list["move_shuttle"])
		if(!shuttle)
			return
		shuttle.admin_fly_shuttle(usr)

	else if(href_list["unlock_shuttle"])
		if(!check_rights(R_ADMIN))
			return

		var/obj/machinery/computer/shuttle/shuttle_console = locate(href_list["unlock_shuttle"])
		if(!shuttle_console)
			return
		shuttle_console.admin_controlled = !shuttle_console.admin_controlled
		to_chat(usr, "[shuttle_console] 已[shuttle_console.admin_controlled ? "锁定" : "解锁"]。", confidential = TRUE)

	else if(href_list["delay_round_end"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/delay_round_end)

	else if(href_list["undelay_round_end"])
		if(!check_rights(R_SERVER))
			return

		if(tgui_alert(usr, "真的要取消当前的回合结束延迟吗？当前延迟的原因是：“[SSticker.admin_delay_notice]”", "取消回合结束延迟", list("Yes", "No")) == "No")
			return

		SSticker.admin_delay_notice = null
		SSticker.delay_end = FALSE

		log_admin("[key_name(usr)] 取消了回合结束延迟。")
		if(SSticker.ready_for_reboot)
			message_admins("[key_name_admin(usr)] 取消了回合结束延迟。你现在必须手动重启世界才能开始下一个班次。")
		else
			message_admins("[key_name_admin(usr)] 取消了回合结束延迟。")
	else if(href_list["end_round"])
		if(!check_rights(R_ADMIN))
			return

		message_admins(span_adminnotice("[key_name_admin(usr)] 正在考虑结束本回合。"))
		if(tgui_alert(usr, "这将结束本回合，你确定要这么做吗？", "确认", list("Yes", "No")) == "Yes")
			if(tgui_alert(usr, "最终确认：现在就结束本回合？", "确认", list("Yes", "No")) == "Yes")
				message_admins(span_adminnotice("[key_name_admin(usr)] 结束了本回合。"))
				SSticker.force_ending = ADMIN_FORCE_END_ROUND //Yeah there we go APC destroyed mission accomplished
				return
			else
				message_admins(span_adminnotice("[key_name_admin(usr)] 决定不结束本回合。"))
		else
			message_admins(span_adminnotice("[key_name_admin(usr)] 决定不结束本回合。"))

	else if(href_list["simplemake"])
		if(!check_rights(R_SPAWN))
			return

		var/mob/M = locate(href_list["mob"])
		if(!ismob(M))
			to_chat(usr, "此操作只能用于 /mob 类型的实例。", confidential = TRUE)
			return

		var/delmob = TRUE
		if(!isobserver(M))
			switch(tgui_alert(usr,"删除旧生物？","消息",list("Yes","No","Cancel")))
				if("Cancel")
					return
				if("No")
					delmob = FALSE

		log_admin("[key_name(usr)] 对 [key_name(M)] 使用了基础变形。正在变形为 [href_list["simplemake"]]。; deletemob=[delmob]")
		message_admins(span_adminnotice("[key_name_admin(usr)] 对 [key_name_admin(M)] 使用了基础变形。正在变形为 [href_list["simplemake"]]。; deletemob=[delmob]"))
		switch(href_list["simplemake"])
			if("observer")
				M.change_mob_type( /mob/dead/observer , null, null, delmob )
			if("human")
				var/posttransformoutfit = usr.client.robust_dress_shop()
				if (!posttransformoutfit)
					return
				var/mob/living/carbon/human/newmob = M.change_mob_type( /mob/living/carbon/human , null, null, delmob )
				if(posttransformoutfit && istype(newmob))
					newmob.equipOutfit(posttransformoutfit)
			if("monkey")
				if(ishuman(M))
					var/mob/living/carbon/human/human = M
					human.dna.add_mutation(/datum/mutation/race, MUTATION_SOURCE_ACTIVATED)
				else
					M.change_mob_type(/mob/living/carbon/human/species/monkey , null, null, delmob )
			if("robot")
				M.change_mob_type( /mob/living/silicon/robot , null, null, delmob )

	else if(href_list["boot2"])
		if(!check_rights(R_ADMIN))
			return
		var/mob/M = locate(href_list["boot2"])
		if(ismob(M))
			if(!check_if_greater_rights_than(M.client))
				to_chat(usr, span_danger("错误：他们的权限比你高。"), confidential = TRUE)
				return
			if(tgui_alert(usr, "踢出 [key_name(M)]？", "确认", list("Yes", "No")) != "Yes")
				return
			if(!M)
				to_chat(usr, span_danger("错误：[M] 已不存在！"), confidential = TRUE)
				return
			if(!M.client)
				to_chat(usr, span_danger("错误：[M] 已不再有客户端！"), confidential = TRUE)
				return
			to_chat(M, span_danger("你已被[usr.client.holder.fakekey ? "一名管理员" : "[usr.client.key]"]踢出服务器。"), confidential = TRUE)
			log_admin("[key_name(usr)] 踢出了 [key_name(M)]。")
			message_admins(span_adminnotice("[key_name_admin(usr)] 踢出了 [key_name_admin(M)]。"))
			qdel(M.client)

	else if(href_list["addmessage"])
		if(!check_rights(R_ADMIN))
			return
		var/target_key = href_list["addmessage"]
		create_message("message", target_key, secret = 0)

	else if(href_list["addnote"])
		if(!check_rights(R_ADMIN))
			return
		var/target_key = href_list["addnote"]
		create_message("note", target_key)

	else if(href_list["addwatch"])
		if(!check_rights(R_ADMIN))
			return
		var/target_key = href_list["addwatch"]
		create_message("watchlist entry", target_key, secret = 1)

	else if(href_list["addmemo"])
		if(!check_rights(R_ADMIN))
			return
		create_message("memo", secret = 0, browse = 1)

	else if(href_list["addmessageempty"])
		if(!check_rights(R_ADMIN))
			return
		create_message("message", secret = 0)

	else if(href_list["addnoteempty"])
		if(!check_rights(R_ADMIN))
			return
		create_message("note")

	else if(href_list["addwatchempty"])
		if(!check_rights(R_ADMIN))
			return
		create_message("watchlist entry", secret = 1)

	else if(href_list["deletemessage"])
		if(!check_rights(R_ADMIN))
			return
		var/safety = tgui_alert(usr,"删除留言/备注？",,list("Yes","No"));
		if (safety == "Yes")
			var/message_id = href_list["deletemessage"]
			delete_message(message_id)

	else if(href_list["deletemessageempty"])
		if(!check_rights(R_ADMIN))
			return
		var/safety = tgui_alert(usr,"删除留言/备注？",,list("Yes","No"));
		if (safety == "Yes")
			var/message_id = href_list["deletemessageempty"]
			delete_message(message_id, browse = TRUE)

	else if(href_list["editmessage"])
		if(!check_rights(R_ADMIN))
			return
		var/message_id = href_list["editmessage"]
		edit_message(message_id)

	else if(href_list["editmessageempty"])
		if(!check_rights(R_ADMIN))
			return
		var/message_id = href_list["editmessageempty"]
		edit_message(message_id, browse = 1)

	else if(href_list["editmessageexpiry"])
		if(!check_rights(R_ADMIN))
			return
		var/message_id = href_list["editmessageexpiry"]
		edit_message_expiry(message_id)

	else if(href_list["editmessageexpiryempty"])
		if(!check_rights(R_ADMIN))
			return
		var/message_id = href_list["editmessageexpiryempty"]
		edit_message_expiry(message_id, browse = 1)

	else if(href_list["editmessageseverity"])
		if(!check_rights(R_ADMIN))
			return
		var/message_id = href_list["editmessageseverity"]
		edit_message_severity(message_id)

	else if(href_list["secretmessage"])
		if(!check_rights(R_ADMIN))
			return
		var/message_id = href_list["secretmessage"]
		toggle_message_secrecy(message_id)

	else if(href_list["searchmessages"])
		if(!check_rights(R_ADMIN))
			return
		var/target = href_list["searchmessages"]
		browse_messages(index = target)

	else if(href_list["nonalpha"])
		if(!check_rights(R_ADMIN))
			return
		var/target = href_list["nonalpha"]
		target = text2num(target)
		browse_messages(index = target)

	else if(href_list["showmessages"])
		if(!check_rights(R_ADMIN))
			return
		var/target = href_list["showmessages"]
		browse_messages(index = target)

	else if(href_list["showmemo"])
		if(!check_rights(R_ADMIN))
			return
		browse_messages("memo")

	else if(href_list["showwatch"])
		if(!check_rights(R_ADMIN))
			return
		browse_messages("watchlist entry")

	else if(href_list["showwatchfilter"])
		if(!check_rights(R_ADMIN))
			return
		browse_messages("watchlist entry", filter = 1)

	else if(href_list["showmessageckey"])
		if(!check_rights(R_ADMIN))
			return
		var/target = href_list["showmessageckey"]
		var/agegate = TRUE
		if (href_list["showall"])
			agegate = FALSE
		browse_messages(target_ckey = target, agegate = agegate)

	else if(href_list["showmessageckeylinkless"])
		var/target = href_list["showmessageckeylinkless"]
		browse_messages(target_ckey = target, linkless = 1)

	else if(href_list["messageedits"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/db_query/query_get_message_edits = SSdbcore.NewQuery(
			"SELECT edits FROM [format_table_name("messages")] WHERE id = :message_id",
			list("message_id" = href_list["messageedits"])
		)
		if(!query_get_message_edits.warn_execute())
			qdel(query_get_message_edits)
			return
		if(query_get_message_edits.NextRow())
			var/edit_log = query_get_message_edits.item[1]
			if(!QDELETED(usr))
				var/datum/browser/browser = new(usr, "Note edits", "备注编辑")
				browser.set_content(jointext(edit_log, ""))
				browser.open()
		qdel(query_get_message_edits)

	else if(href_list["mute"])
		if(!check_rights(R_ADMIN))
			return
		cmd_admin_mute(href_list["mute"], text2num(href_list["mute_type"]))

	else if(href_list["forcespeech"])
		if(!check_rights(R_FUN))
			return

		var/mob/M = locate(href_list["forcespeech"])
		if(!ismob(M))
			to_chat(usr, "此操作只能用于 /mob 类型的实例。", confidential = TRUE)
			return
		var/speech = input("你要让 [key_name(M)] 说什么？", "强制发言", "")// Don't need to sanitize, since it does that in say(), we also trust our admins.
		if(!speech)
			return
		M.say(speech, forced = "管理员发言")
		speech = sanitize(speech) // Nah, we don't trust them
		log_admin("[key_name(usr)] 强制 [key_name(M)] 说出：[speech]")
		message_admins(span_adminnotice("[key_name_admin(usr)] 强制 [key_name_admin(M)] 说出：[speech]"))

	else if(href_list["applyquirks"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/living/carbon/human/target = locate(href_list["applyquirks"])
		if(!istype(target))
			to_chat(usr, "此操作只能用于 /mob/living/carbon/human 类型的实例。", confidential = TRUE)
			return
		if(!target.client)
			to_chat(usr, "[target] 没有客户端！", confidential = TRUE)
			return
		SSquirks.AssignQuirks(target, target.client)
		log_admin("[key_name(usr)] 对 [key_name(target)] 应用了客户端特质。")
		message_admins(span_adminnotice("[key_name_admin(usr)] 对 [key_name_admin(target)] 应用了客户端特质。"))

	else if(href_list["sendtoprison"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["sendtoprison"])
		if(!ismob(M))
			to_chat(usr, "此操作只能用于 /mob 类型的实例。", confidential = TRUE)
			return
		if(isAI(M))
			to_chat(usr, "此操作不能用于 /mob/living/silicon/ai 类型的实例。", confidential = TRUE)
			return

		if(tgui_alert(usr, "将 [key_name(M)] 送入监狱？", "消息", list("Yes", "No")) != "Yes")
			return

		// BUBBER EDIT - START - Immersion-friendly Admin Prison
		do_sparks(10, TRUE, M, spark_type = /datum/effect_system/basic/spark_spread/quantum)
		// BUBBER EDIT - END

		to_chat(M, span_adminnotice("你已被送入监狱！"), confidential = TRUE)

		log_admin("[key_name(usr)] 已将 [key_name(M)] 送入监狱！")
		message_admins("[key_name_admin(usr)] 已将 [key_name_admin(M)] 送入监狱！")

	else if(href_list["sendbacktolobby"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["sendbacktolobby"])

		if(!isobserver(M))
			to_chat(usr, span_notice("你只能将幽灵玩家送回大厅。"), confidential = TRUE)
			return

		if(!M.client)
			to_chat(usr, span_warning("[M] 似乎没有活跃的客户端。"), confidential = TRUE)
			return

		if(tgui_alert(usr, "将 [key_name(M)] 送回大厅？", "消息", list("Yes", "No")) != "Yes")
			return

		log_admin("[key_name(usr)] 已将 [key_name(M)] 送回大厅。")
		message_admins("[key_name(usr)] 已将 [key_name(M)] 送回大厅。")

		var/mob/dead/new_player/NP = new()
		NP.ckey = M.ckey
		qdel(M)

	else if(href_list["tdome1"])
		if(!check_rights(R_FUN))
			return

		if(tgui_alert(usr, "确认？", "消息", list("Yes", "No")) != "Yes")
			return

		var/mob/M = locate(href_list["tdome1"])
		if(!isliving(M))
			to_chat(usr, "此操作只能用于 /mob/living 类型的实例。", confidential = TRUE)
			return
		if(isAI(M))
			to_chat(usr, "此操作不能用于 /mob/living/silicon/ai 类型的实例。", confidential = TRUE)
			return
		var/mob/living/L = M

		for(var/obj/item/I in L)
			L.dropItemToGround(I, TRUE)

		L.Unconscious(100)
		sleep(0.5 SECONDS)
		L.forceMove(pick(GLOB.tdome1))
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), L, span_adminnotice("你已被送入雷霆竞技场。")), 5 SECONDS)
		log_admin("[key_name(usr)] 已将 [key_name(L)] 送入雷霆竞技场。（队伍 1）")
		message_admins("[key_name_admin(usr)] 已将 [key_name_admin(L)] 送入雷霆竞技场。（队伍 1）")

	else if(href_list["tdome2"])
		if(!check_rights(R_FUN))
			return

		if(tgui_alert(usr, "确认？", "消息", list("Yes", "No")) != "Yes")
			return

		var/mob/M = locate(href_list["tdome2"])
		if(!isliving(M))
			to_chat(usr, "此操作只能用于 /mob/living 类型的实例。", confidential = TRUE)
			return
		if(isAI(M))
			to_chat(usr, "此操作不能用于 /mob/living/silicon/ai 类型的实例。", confidential = TRUE)
			return
		var/mob/living/L = M

		for(var/obj/item/I in L)
			L.dropItemToGround(I, TRUE)

		L.Unconscious(100)
		sleep(0.5 SECONDS)
		L.forceMove(pick(GLOB.tdome2))
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), L, span_adminnotice("你已被送入雷霆竞技场。")), 5 SECONDS)
		log_admin("[key_name(usr)] 已将 [key_name(L)] 送入雷霆竞技场。（队伍 2）")
		message_admins("[key_name_admin(usr)] 已将 [key_name_admin(L)] 送入雷霆竞技场。（队伍 2）")

	else if(href_list["tdomeadmin"])
		if(!check_rights(R_FUN))
			return

		if(tgui_alert(usr, "确认？", "消息", list("Yes", "No")) != "Yes")
			return

		var/mob/M = locate(href_list["tdomeadmin"])
		if(!isliving(M))
			to_chat(usr, "此操作只能用于 /mob/living 类型的实例。", confidential = TRUE)
			return
		if(isAI(M))
			to_chat(usr, "此操作不能用于 /mob/living/silicon/ai 类型的实例。", confidential = TRUE)
			return
		var/mob/living/L = M

		L.Unconscious(100)
		sleep(0.5 SECONDS)
		L.forceMove(pick(GLOB.tdomeadmin))
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), L, span_adminnotice("你已被送入雷霆竞技场。")), 5 SECONDS)
		log_admin("[key_name(usr)] 已将 [key_name(L)] 送入雷霆竞技场。（管理员）")
		message_admins("[key_name_admin(usr)] 已将 [key_name_admin(L)] 送入雷霆竞技场。（管理员）")

	else if(href_list["tdomeobserve"])
		if(!check_rights(R_FUN))
			return

		if(tgui_alert(usr, "确认？", "消息", list("Yes", "No")) != "Yes")
			return

		var/mob/M = locate(href_list["tdomeobserve"])
		if(!isliving(M))
			to_chat(usr, "此操作只能用于 /mob/living 类型的实例。", confidential = TRUE)
			return
		if(isAI(M))
			to_chat(usr, "此操作不能用于 /mob/living/silicon/ai 类型的实例。", confidential = TRUE)
			return
		var/mob/living/L = M

		for(var/obj/item/I in L)
			L.dropItemToGround(I, TRUE)

		if(ishuman(L))
			var/mob/living/carbon/human/observer = L
			observer.equip_to_slot_or_del(new /obj/item/clothing/under/costume/buttondown/slacks/service(observer), ITEM_SLOT_ICLOTHING)
			observer.equip_to_slot_or_del(new /obj/item/clothing/neck/tie/black/tied(observer), ITEM_SLOT_NECK)
			observer.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(observer), ITEM_SLOT_FEET)
		L.Unconscious(100)
		sleep(0.5 SECONDS)
		L.forceMove(pick(GLOB.tdomeobserve))
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), L, span_adminnotice("你已被送入雷霆竞技场。")), 5 SECONDS)
		log_admin("[key_name(usr)] 已将 [key_name(L)] 送入雷霆竞技场。（观察者）")
		message_admins("[key_name_admin(usr)] 已将 [key_name_admin(L)] 送入雷霆竞技场。（观察者）")

	else if(href_list["revive"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/living/L = locate(href_list["revive"])
		if(!istype(L))
			to_chat(usr, "此操作只能用于 /mob/living 类型的实例。", confidential = TRUE)
			return

		L.revive(ADMIN_HEAL_ALL)
		message_admins(span_danger("管理员 [key_name_admin(usr)] 治疗/复活了 [key_name_admin(L)]！"))
		log_admin("[key_name(usr)] 治疗/复活了 [key_name(L)]。")

	else if(href_list["makeai"])
		if(!check_rights(R_SPAWN))
			return

		var/mob/our_mob = locate(href_list["makeai"])
		if(!istype(our_mob))
			return
		if(isAI(our_mob))
			to_chat(usr, "那已经是一个 AI 了。", confidential = TRUE)
			return

		var/move = TRUE
		switch(tgui_alert(usr,"将新 AI 移动到 AI 出生点？","移动 AI？", list("Yes", "No","Cancel")))
			if("Cancel", null)
				return
			if("No")
				move = FALSE
		if(QDELETED(our_mob))
			to_chat(usr, span_danger("对象已被删除。变形已取消。"))
			return
		message_admins(span_danger("管理员 [key_name_admin(usr)] 将 [key_name_admin(our_mob)] 转化为 AI！"))
		log_admin("[key_name(usr)] 将 [key_name(our_mob)] 转化为 AI。")
		our_mob.AIize(our_mob.client, move)

	else if(href_list["makerobot"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/cmd_admin_robotize, locate(href_list["makerobot"]))

	else if(href_list["adminplayeropts"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/show_player_panel, locate(href_list["adminplayeropts"]))

	else if(href_list["ppbyckey"])
		var/target_ckey = href_list["ppbyckey"]
		var/mob/original_mob = locate(href_list["ppbyckeyorigmob"]) in GLOB.mob_list
		var/mob/target_mob = get_mob_by_ckey(target_ckey)
		if(!target_mob)
			to_chat(usr, span_warning("未找到该 ckey 对应的生物。"))
			return

		if(original_mob == target_mob)
			to_chat(usr, span_warning("[target_ckey] 仍在其原本的生物体内：[original_mob]。"))
			return

		to_chat(usr, span_notice("正在跳转到 [target_ckey] 的新生物体：[target_mob]！"))
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/show_player_panel, target_mob)

	else if(href_list["adminplayerobservefollow"])
		if(!isobserver(usr) && !check_rights(R_ADMIN))
			return

		usr.client?.admin_follow(locate(href_list["adminplayerobservefollow"]))
	else if(href_list["admingetmovable"])
		if(!check_rights(R_ADMIN))
			return

		var/atom/movable/AM = locate(href_list["admingetmovable"])
		if(QDELETED(AM))
			return
		AM.forceMove(get_turf(usr))

	else if(href_list["adminplayerobservecoodjump"])
		return SSadmin_verbs.dynamic_invoke_verb(
			usr,
			/datum/admin_verb/jump_to_coord,
			text2num(href_list["X"]),
			text2num(href_list["Y"]),
			text2num(href_list["Z"]),
		)

	else if(href_list["adminchecklaws"])
		if(!check_rights(R_ADMIN))
			return
		output_ai_laws()

	else if(href_list["adminmoreinfo"])
		var/mob/subject = locate(href_list["adminmoreinfo"]) in GLOB.mob_list
		if(!ismob(subject))
			to_chat(usr, "此操作只能用于 /mob 类型的实例。", confidential = TRUE)
			return

		var/location_description = ""
		var/special_role_description = ""
		var/health_description = ""
		var/gender_description = ""
		var/turf/position = get_turf(subject)

		//Location
		if(isturf(position))
			if(isarea(position.loc))
				location_description = "[subject.loc == position ? "位于坐标" : "位于 [position.loc] 内的坐标"] [position.x], [position.y], [position.z]，区域为 <b>[position.loc]</b>"
			else
				location_description = "[subject.loc == position ? "位于坐标" : "位于 [subject.loc] 内的坐标"] [position.x], [position.y], [position.z]"

		//Job + antagonist
		if(subject.mind)
			special_role_description = "职业：<b>[subject.mind.assigned_role.title]</b>；反派：<font color='red'><b>"

			if(subject.mind.antag_datums)
				var/iterable = 0
				for(var/datum/antagonist/role in subject.mind.antag_datums)
					special_role_description += "[role.name]"
					iterable++
					if(iterable != length(subject.mind.antag_datums))
						special_role_description += ", "
				special_role_description += "</b></font>"
			else
				special_role_description += "无</b></font>"
		else
			special_role_description = "职业：<i>意识数据缺失</i> 反派：<i>意识数据缺失</i>"

		//Health
		if(isliving(subject))
			var/mob/living/lifer = subject
			var/status
			switch (subject.stat)
				if(STABLE)
					status = "存活"
				if(SOFT_CRIT)
					status = "<font color='orange'><b>濒危</b></font>"
				if(HARD_CRIT)
					status = "<font color='orange'><b>无意识</b></font>"
				if(DEAD)
					status = "<font color='red'><b>死亡</b></font>"
			health_description = "状态：[status]"
			health_description += "<br>钝击：[lifer.get_brute_loss()] - 烧伤：[lifer.get_fire_loss()] - 毒素：[lifer.get_tox_loss()] - 窒息：[lifer.get_oxy_loss()]"
			health_description += "<br>大脑：[lifer.get_organ_loss(ORGAN_SLOT_BRAIN)] - 耐力：[lifer.get_stamina_loss()]"
		else
			health_description = "这种生物没有值得一提的生命值。"

		//Gender
		switch(subject.gender)
			if(MALE,FEMALE,PLURAL)
				gender_description = "[subject.gender]"
			else
				gender_description = "<font color='red'><b>[subject.gender]</b></font>"

		//Full Output
		var/exportable_text = "[span_bold("关于 [subject.name] 的信息：")]<br>"
		exportable_text += "账号 - [span_bold(subject.key)]<br>"
		exportable_text += "生物类型 - [subject.type]<br>"
		exportable_text += "性别 - [gender_description]<br>"
		exportable_text += "[health_description]<br>"
		exportable_text += "名称：[span_bold(subject.name)] - 真实姓名：[subject.real_name] - 意识名称：[subject.mind?"[subject.mind.name]":""]<br>"
		exportable_text += "位置为 [location_description]<br>"
		exportable_text += "[special_role_description]<br>"
		exportable_text += ADMIN_FULLMONTY_NONAME(subject)

		to_chat(src.owner, boxed_message(exportable_text), confidential = TRUE)

	else if(href_list["addjobslot"])
		if(!check_rights(R_ADMIN))
			return

		var/Add = href_list["addjobslot"]

		for(var/datum/job/job as anything in SSjob.joinable_occupations)
			if(job.title == Add)
				job.total_positions += 1
				log_job_debug("[key_name(usr)] 为 [job.title] 增加了一个名额")
				break

		src.manage_free_slots()


	else if(href_list["customjobslot"])
		if(!check_rights(R_ADMIN))
			return

		var/Add = href_list["customjobslot"]

		for(var/datum/job/job as anything in SSjob.joinable_occupations)
			if(job.title == Add)
				var/newslots = null
				newslots = input(usr, "你想要多少个职业名额？", "添加职业名额", "[newslots]") as num|null
				if(!isnull(newslots))
					to_chat(src.owner, "[job.title] 的职业名额已设为 [newslots]" , confidential = TRUE)
					job.total_positions = newslots
					log_job_debug("[key_name(usr)] 将 [job.title] 的职业上限设为 [newslots]")
					break

		src.manage_free_slots()

	else if(href_list["removejobslot"])
		if(!check_rights(R_ADMIN))
			return

		var/Remove = href_list["removejobslot"]

		for(var/datum/job/job as anything in SSjob.joinable_occupations)
			if(job.title == Remove && job.total_positions - job.current_positions > 0)
				job.total_positions -= 1
				log_job_debug("[key_name(usr)] 从 [job.title] 移除了一个名额")
				break

		src.manage_free_slots()

	else if(href_list["unlimitjobslot"])
		if(!check_rights(R_ADMIN))
			return

		var/Unlimit = href_list["unlimitjobslot"]

		for(var/datum/job/job as anything in SSjob.joinable_occupations)
			if(job.title == Unlimit)
				job.total_positions = -1
				log_job_debug("[key_name(usr)] 移除了 [job.title] 的名额限制")
				break

		src.manage_free_slots()

	else if(href_list["limitjobslot"])
		if(!check_rights(R_ADMIN))
			return

		var/Limit = href_list["limitjobslot"]

		for(var/datum/job/job as anything in SSjob.joinable_occupations)
			if(job.title == Limit)
				job.total_positions = job.current_positions
				log_job_debug("[key_name(usr)] 将 [job.title] 的限制设为其当前名额数 [job.total_positions]")
				break

		src.manage_free_slots()


	else if(href_list["adminspawncookie"])
		if(!check_rights(R_ADMIN|R_FUN))
			return

		var/mob/living/carbon/human/H = locate(href_list["adminspawncookie"])
		if(!ishuman(H))
			to_chat(usr, "此操作只能用于 /mob/living/carbon/human 类型的实例。", confidential = TRUE)
			return
		var/obj/item/new_item = new H.dna.species.species_cookie(H)
		if(H.put_in_hands(new_item))
			H.update_held_items()
		else
			qdel(new_item)
			log_admin("[key_name(H)] 双手已满，因此没有拿到由 [key_name(src.owner)] 生成的 [new_item.name]。")
			message_admins("[key_name(H)] 双手已满，因此没有拿到由 [key_name(src.owner)] 生成的 [new_item.name]。")
			return

		log_admin("[key_name(H)] 拿到了由 [key_name(src.owner)] 生成的 [new_item]。")
		message_admins("[key_name(H)] 拿到了由 [key_name(src.owner)] 生成的 [new_item]。")
		SSblackbox.record_feedback("amount", "admin_cookies_spawned", 1)
		to_chat(H, span_adminnotice("你的祈祷得到了回应！！你获得了<b>最棒的 [new_item.name]！</b>"), confidential = TRUE)
		SEND_SOUND(H, sound('sound/effects/pray_chaplain.ogg'))

	else if (href_list["adminpopup"])
		if (!check_rights(R_ADMIN))
			return

		var/message = input(owner, "除了弹窗外，他们还会收到一条可供回复的消息。你希望消息内容是什么？", "消息") as text|null
		if (!message)
			to_chat(owner, span_notice("弹窗已取消。"))
			return

		var/client/target = locate(href_list["adminpopup"])
		if (!istype(target))
			to_chat(owner, span_notice("该生物已不存在！"))
			return

		give_admin_popup(target, owner, message)

	else if(href_list["adminsmite"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/admin_smite, locate(href_list["adminsmite"]))

	else if(href_list["CentComReply"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["CentComReply"])
		usr.client.admin_headset_message(M, RADIO_CHANNEL_CENTCOM)

	else if(href_list["SyndicateReply"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["SyndicateReply"])
		usr.client.admin_headset_message(M, RADIO_CHANNEL_SYNDICATE)

	else if(href_list["HeadsetMessage"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["HeadsetMessage"])
		usr.client.admin_headset_message(M)

	else if(href_list["reject_custom_name"])
		if(!check_rights(R_ADMIN))
			return
		var/obj/item/station_charter/charter = locate(href_list["reject_custom_name"])
		if(istype(charter))
			charter.reject_proposed(usr)

	else if(href_list["jumpto"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/jump_to_mob, locate(href_list["jumpto"]))

	else if(href_list["getmob"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/get_mob, locate(href_list["getmob"]))

	else if(href_list["sendmob"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/send_mob, locate(href_list["sendmob"]))

	else if(href_list["narrateto"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/cmd_admin_direct_narrate, locate(href_list["narrateto"]))

	else if(href_list["subtlemessage"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/cmd_admin_subtle_message, locate(href_list["subtlemessage"]))

	else if(href_list["playsoundto"])
		if(!check_rights(R_SOUND))
			return

		var/mob/M = locate(href_list["playsoundto"])
		var/S = input("", "选择声音文件",) as null|sound
		if(S)
			SSadmin_verbs.dynamic_invoke_verb(usr.client, /datum/admin_verb/play_direct_mob_sound, S, M)

	else if(href_list["individuallog"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["individuallog"]) in GLOB.mob_list
		if(!ismob(M))
			to_chat(usr, "此操作只能用于 /mob 类型的实例。", confidential = TRUE)
			return

		show_individual_logging_panel(M, href_list["log_src"], href_list["log_type"])
	else if(href_list["languagemenu"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["languagemenu"]) in GLOB.mob_list
		if(!ismob(M))
			to_chat(usr, "此操作只能用于 /mob 类型的实例。", confidential = TRUE)
			return
		M.get_language_holder().open_language_menu(usr)

	else if(href_list["rpreminder"])
		var/mob/rper = locate(href_list["rpreminder"]) in GLOB.player_list
		if(QDELETED(rper))
			return
		// literally just gives them a sound and a message
		SEND_SOUND(rper, sound('sound/misc/roleplay.ogg'))
		to_chat(rper, boxed_message("你听到脑海中有一个喋喋不休的声音……[span_hypnophrase("请进行恰当的角色扮演。")]"))
		message_admins("[ADMIN_LOOKUPFLW(usr)] 提醒 [ADMIN_LOOKUPFLW(rper)] 进行恰当的角色扮演。")
		log_admin("[key_name(usr)] 提醒 [key_name(rper)] 进行恰当的角色扮演。")

	else if(href_list["traitor"])
		if(!check_rights(R_ADMIN))
			return

		if(!SSticker.HasRoundStarted())
			tgui_alert(usr,"游戏还未开始！")
			return

		var/mob/M = locate(href_list["traitor"])
		if(!ismob(M))
			var/datum/mind/D = M
			if(!istype(D))
				to_chat(usr, "此操作只能用于 /mob 和 /mind 类型的实例", confidential = TRUE)
				return
			else
				D.traitor_panel()
		else
			SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/show_traitor_panel, M)
		return

	else if(href_list["skill"])
		if(!check_rights(R_ADMIN))
			return

		if(!SSticker.HasRoundStarted())
			tgui_alert(usr,"游戏还未开始！")
			return

		var/target = locate(href_list["skill"])
		var/datum/mind/target_mind
		if(ismob(target))
			var/mob/target_mob = target
			target_mind = target_mob.mind
		else if (istype(target, /datum/mind))
			target_mind = target
		else
			to_chat(usr, "此操作只能用于 /mob 和 /mind 类型的实例", confidential = TRUE)
			return
		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/show_skill_panel, target_mind)
		return

	else if(href_list["borgpanel"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/borg_panel, locate(href_list["borgpanel"]))

	else if(href_list["initmind"])
		if(!check_rights(R_ADMIN))
			return
		var/mob/M = locate(href_list["initmind"])
		if(!ismob(M) || M.mind)
			to_chat(usr, "此操作只能用于没有意识的生物", confidential = TRUE)
			return
		M.mind_initialize()

	else if(href_list["player_ticket_history"])
		if(!check_rights(R_ADMIN))
			return
		var/target_ckey = href_list["player_ticket_history"]
		GLOB.player_ticket_history.cache_history_for_ckey(target_ckey)
		GLOB.player_ticket_history.user_selections[usr.ckey] = target_ckey
		GLOB.player_ticket_history.ui_interact(usr)
		return

	else if(href_list["spawn_panel"])
		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/spawn_panel)

	else if(href_list["dupe_marked_datum"])
		if(!check_rights(R_SPAWN))
			return
		return duplicate_object(marked_datum, spawning_location = get_turf(usr))

	else if(href_list["check_antagonist"])
		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/check_antagonists)

	else if(href_list["kick_all_from_lobby"])
		if(!check_rights(R_ADMIN))
			return
		if(SSticker.IsRoundInProgress())
			var/afkonly = text2num(href_list["afkonly"])
			if(tgui_alert(usr,"你确定要将所有[afkonly ? "挂机" : ""]客户端踢出大厅吗？？","消息",list("Yes","Cancel")) != "Yes")
				to_chat(usr, "已中止踢出大厅客户端", confidential = TRUE)
				return
			var/list/listkicked = kick_clients_in_lobby(span_danger("你被[usr.client.holder.fakekey ? "一名管理员" : "[usr.client.key]"]踢出了大厅。"), afkonly)

			var/strkicked = ""
			for(var/name in listkicked)
				strkicked += "[name], "
			message_admins("[key_name_admin(usr)] 已将[afkonly ? "所有挂机" : "所有"]客户端踢出大厅。共踢出 [length(listkicked)] 个客户端：[strkicked ? strkicked : "--"]")
			log_admin("[key_name(usr)] 已将[afkonly ? "所有挂机" : "所有"]客户端踢出大厅。共踢出 [length(listkicked)] 个客户端：[strkicked ? strkicked : "--"]")
		else
			to_chat(usr, "你只能在游戏进行时使用此功能。", confidential = TRUE)

	else if(href_list["set_selfdestruct_code"])
		if(!check_rights(R_ADMIN))
			return
		var/code = random_nukecode()
		for(var/obj/machinery/nuclearbomb/selfdestruct/SD as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/nuclearbomb/selfdestruct))
			SD.r_code = code
		message_admins("[key_name_admin(usr)] 将自毁 \
			密码设为“[code]”。")

	else if(href_list["add_station_goal"])
		if(!check_rights(R_ADMIN))
			return
		var/list/type_choices = typesof(/datum/station_goal)
		var/picked = tgui_input_list(usr, "选择目标类型", "空间站目标", type_choices)
		if(!picked)
			return
		var/datum/station_goal/G = new picked()
		if(picked == /datum/station_goal)
			var/newname = input("输入目标名称：") as text|null
			if(!newname)
				return
			G.name = newname
			var/description = input("输入中央指挥部消息内容：") as message|null
			if(!description)
				return
			G.report_message = description
		message_admins("[key_name(usr)] 创建了“[G.name]”空间站目标。")
		modify_goals()

	else if(href_list["change_lag_switch"])
		if(!check_rights(R_ADMIN))
			return

		switch(href_list["change_lag_switch"])
			if("ALL_ON")
				SSlag_switch.set_all_measures(TRUE)
				log_admin("[key_name(usr)] 开启了所有卡顿开关措施。")
				message_admins("[key_name_admin(usr)] 开启了所有卡顿开关措施。")
			if("ALL_OFF")
				SSlag_switch.set_all_measures(FALSE)
				log_admin("[key_name(usr)] 关闭了所有卡顿开关措施。")
				message_admins("[key_name_admin(usr)] 关闭了所有卡顿开关措施。")
			else
				var/switch_index = text2num(href_list["change_lag_switch"])
				if(!SSlag_switch.set_measure(switch_index, !LAZYACCESS(SSlag_switch.measures, switch_index)))
					to_chat(src, span_danger("切换该卡顿开关时出错。请查看运行时错误以获取更多信息。"), confidential = TRUE)
				else
					log_admin("[key_name(usr)] 将索引 ([switch_index]) 处的卡顿开关措施[LAZYACCESS(SSlag_switch.measures, switch_index) ? "开启" : "关闭"]")
					message_admins("[key_name_admin(usr)] 将一项卡顿开关措施[LAZYACCESS(SSlag_switch.measures, switch_index) ? "开启" : "关闭"]")

		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/lag_switch_panel)

	else if(href_list["change_lag_switch_option"])
		if(!check_rights(R_ADMIN))
			return

		switch(href_list["change_lag_switch_option"])
			if("CANCEL")
				if(SSlag_switch.cancel_auto_enable_in_progress())
					log_admin("[key_name(usr)] 取消了正在进行的卡顿开关自动启用。")
					message_admins("[key_name_admin(usr)] 取消了正在进行的卡顿开关自动启用。")
				return // return here to avoid (re)rendering the panel for this case
			if("TOGGLE_AUTO")
				SSlag_switch.toggle_auto_enable()
				log_admin("[key_name(usr)] 切换了卡顿开关自动启用：[SSlag_switch.auto_switch ? "开启" : "关闭"]。")
				message_admins("[key_name_admin(usr)] 切换了卡顿开关自动启用：[SSlag_switch.auto_switch ? "开启" : "关闭"]。")
			if("NUM")
				var/new_num = input("输入新的阈值：", "数值") as null|num
				if(!isnull(new_num))
					SSlag_switch.trigger_pop = new_num
					log_admin("[key_name(usr)] 将卡顿开关的自动触发人口设为 [new_num]。")
					message_admins("[key_name_admin(usr)] 将卡顿开关的自动触发人口设为 [new_num]。")
			if("SLOWCOOL")
				var/new_num = input("输入新的冷却时间（秒）：", "数值") as null|num
				if(!isnull(new_num))
					SSlag_switch.change_slowmode_cooldown(new_num)
					log_admin("[key_name(usr)] 将卡顿开关的慢速模式冷却设为 [new_num] 秒。")
					message_admins("[key_name_admin(usr)] 将卡顿开关的慢速模式冷却设为 [new_num] 秒。")

		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/lag_switch_panel)

	else if(href_list["viewruntime"])
		var/datum/error_viewer/error_viewer = locate(href_list["viewruntime"])
		if(!istype(error_viewer))
			to_chat(usr, span_warning("该运行时错误查看器已不存在。"), confidential = TRUE)
			return

		if(href_list["viewruntime_backto"])
			error_viewer.show_to(owner, locate(href_list["viewruntime_backto"]), href_list["viewruntime_linear"])
		else
			error_viewer.show_to(owner, null, href_list["viewruntime_linear"])

	else if(href_list["showrelatedacc"])
		if(!check_rights(R_ADMIN))
			return
		var/client/C = locate(href_list["client"]) in GLOB.clients
		var/thing_to_check
		if(href_list["showrelatedacc"] == "cid")
			thing_to_check = C.related_accounts_cid
		else
			thing_to_check = C.related_accounts_ip
		thing_to_check = splittext(thing_to_check, ", ")


		var/list/dat = list("按 [uppertext(href_list["showrelatedacc"])] 关联的账号：")
		dat += thing_to_check

		var/datum/browser/browser = new(usr, "related_[C]", "[C.ckey] 的关联账号", 420, 300)
		browser.set_content(dat.Join("<br>"))
		browser.open()

	else if(href_list["centcomlookup"])
		if(href_list) // BUBBER EDIT BEGIN - Crash Bandaid
			message_admins("一名调皮的管理员试图发送外部查询挂起服务器，已被阻止。")
			return // BUBBER EDIT END - Crash Bandaid
		if(!check_rights(R_ADMIN))
			return

		open_centcom_bans(href_list["centcomlookup"])

	else if(href_list["slowquery"])
		if(!check_rights(R_ADMIN))
			return

		var/data = list("key" = usr.key)
		var/answer = href_list["slowquery"]
		if(answer == "yes")
			if(tgui_alert(usr, "你刚才是否按了任何管理员按钮？", "查询服务器挂起报告", list("Yes", "No")) == "Yes")
				var/response = input(usr,"你刚才在做什么？","查询服务器挂起报告") as null|text
				if(response)
					data["response"] = response
			logger.Log(LOG_CATEGORY_DEBUG_SQL, "server hang", data)
		else if(answer == "no")
			logger.Log(LOG_CATEGORY_DEBUG_SQL, "no server hang", data)

	else if(href_list["ctf_toggle"])
		if(!check_rights(R_ADMIN))
			return
		toggle_id_ctf(usr, CTF_GHOST_CTF_GAME_ID)

	else if(href_list["rebootworld"])
		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/restart)

	else if(href_list["check_teams"])
		if(!check_rights(R_ADMIN))
			return
		check_teams()

	else if(href_list["team_command"])
		if(!check_rights(R_ADMIN))
			return
		switch(href_list["team_command"])
			if("create_team")
				admin_create_team(usr)
			if("rename_team")
				var/datum/team/T = locate(href_list["team"]) in GLOB.antagonist_teams
				if(T)
					T.admin_rename(usr)
			if("communicate")
				var/datum/team/T = locate(href_list["team"]) in GLOB.antagonist_teams
				if(T)
					T.admin_communicate(usr)
			if("delete_team")
				var/datum/team/T = locate(href_list["team"]) in GLOB.antagonist_teams
				if(T)
					T.admin_delete(usr)
			if("add_objective")
				var/datum/team/T = locate(href_list["team"]) in GLOB.antagonist_teams
				if(T)
					T.admin_add_objective(usr)
			if("remove_objective")
				var/datum/team/T = locate(href_list["team"]) in GLOB.antagonist_teams
				if(!T)
					return
				var/datum/objective/O = locate(href_list["tobjective"]) in T.objectives
				if(O)
					T.admin_remove_objective(usr,O)
			if("add_member")
				var/datum/team/T = locate(href_list["team"]) in GLOB.antagonist_teams
				if(T)
					T.admin_add_member(usr)
			if("remove_member")
				var/datum/team/T = locate(href_list["team"]) in GLOB.antagonist_teams
				if(!T)
					return
				var/datum/mind/M = locate(href_list["tmember"]) in T.members
				if(M)
					T.admin_remove_member(usr,M)
		check_teams()

	else if(href_list["newbankey"])
		var/player_key = href_list["newbankey"]
		var/player_ip = href_list["newbanip"]
		var/player_cid = href_list["newbancid"]
		ban_panel(player_key, player_ip, player_cid)

	else if(href_list["intervaltype"]) //check for ban panel, intervaltype is used as it's the only value which will always be present
		if(href_list["roleban_delimiter"])
			ban_parse_href(href_list)
		else
			ban_parse_href(href_list, TRUE)

	else if(href_list["searchunbankey"] || href_list["searchunbanadminkey"] || href_list["searchunbanip"] || href_list["searchunbancid"])
		var/player_key = href_list["searchunbankey"]
		var/admin_key = href_list["searchunbanadminkey"]
		var/player_ip = href_list["searchunbanip"]
		var/player_cid = href_list["searchunbancid"]
		unban_panel(player_key, admin_key, player_ip, player_cid)

	else if(href_list["unbanpagecount"])
		var/page = href_list["unbanpagecount"]
		var/player_key = href_list["unbankey"]
		var/admin_key = href_list["unbanadminkey"]
		var/player_ip = href_list["unbanip"]
		var/player_cid = href_list["unbancid"]
		unban_panel(player_key, admin_key, player_ip, player_cid, page)

	else if(href_list["editbanid"])
		var/edit_id = href_list["editbanid"]
		var/player_key = href_list["editbankey"]
		var/player_ip = href_list["editbanip"]
		var/player_cid = href_list["editbancid"]
		var/role = href_list["editbanrole"]
		var/duration = href_list["editbanduration"]
		var/applies_to_admins = text2num(href_list["editbanadmins"])
		var/reason = url_decode(href_list["editbanreason"])
		var/page = href_list["editbanpage"]
		var/admin_key = href_list["editbanadminkey"]
		ban_panel(player_key, player_ip, player_cid, role, duration, applies_to_admins, reason, edit_id, page, admin_key)

	else if(href_list["unbanid"])
		var/ban_id = href_list["unbanid"]
		var/player_key = href_list["unbankey"]
		var/player_ip = href_list["unbanip"]
		var/player_cid = href_list["unbancid"]
		var/role = href_list["unbanrole"]
		var/page = href_list["unbanpage"]
		var/admin_key = href_list["unbanadminkey"]
		unban(ban_id, player_key, player_ip, player_cid, role, page, admin_key)

	else if(href_list["rebanid"])
		var/ban_id = href_list["rebanid"]
		var/player_key = href_list["rebankey"]
		var/player_ip = href_list["rebanip"]
		var/player_cid = href_list["rebancid"]
		var/role = href_list["rebanrole"]
		var/page = href_list["rebanpage"]
		var/admin_key = href_list["rebanadminkey"]
		var/applies_to_admins = href_list["applies_to_admins"]
		reban(ban_id, applies_to_admins, player_key, player_ip, player_cid, role, page, admin_key)

	else if(href_list["unbanlog"])
		var/ban_id = href_list["unbanlog"]
		ban_log(ban_id)

	else if(href_list["reloadpolls"])
		GLOB.polls.Cut()
		GLOB.poll_options.Cut()
		load_poll_data()
		poll_list_panel()

	else if(href_list["newpoll"])
		poll_management_panel()

	else if(href_list["editpoll"])
		var/datum/poll_question/poll = locate(href_list["editpoll"]) in GLOB.polls
		poll_management_panel(poll)

	else if(href_list["deletepoll"])
		var/datum/poll_question/poll = locate(href_list["deletepoll"]) in GLOB.polls
		poll.delete_poll()
		poll_list_panel()

	else if(href_list["initializepoll"])
		poll_parse_href(href_list)

	else if(href_list["submitpoll"])
		var/datum/poll_question/poll = locate(href_list["submitpoll"]) in GLOB.polls
		poll_parse_href(href_list, poll)

	else if(href_list["clearpollvotes"])
		var/datum/poll_question/poll = locate(href_list["clearpollvotes"]) in GLOB.polls
		poll.clear_poll_votes()
		poll_management_panel(poll)

	else if(href_list["addpolloption"])
		var/datum/poll_question/poll = locate(href_list["addpolloption"]) in GLOB.polls
		poll_option_panel(poll)

	else if(href_list["editpolloption"])
		var/datum/poll_option/option = locate(href_list["editpolloption"]) in GLOB.poll_options
		var/datum/poll_question/poll = locate(href_list["parentpoll"]) in GLOB.polls
		poll_option_panel(poll, option)

	else if(href_list["deletepolloption"])
		var/datum/poll_option/option = locate(href_list["deletepolloption"]) in GLOB.poll_options
		var/datum/poll_question/poll = option.delete_option()
		poll_management_panel(poll)

	else if(href_list["submitoption"])
		var/datum/poll_option/option = locate(href_list["submitoption"]) in GLOB.poll_options
		var/datum/poll_question/poll = locate(href_list["submitoptionpoll"]) in GLOB.polls
		poll_option_parse_href(href_list, poll, option)

	else if(href_list["admincommend"])
		var/mob/heart_recepient = locate(href_list["admincommend"])
		if(!heart_recepient?.ckey)
			to_chat(usr, span_warning("该生物要么已不存在，要么已不再由任何人控制！"))
			return

		switch(tgui_alert(usr, "你希望效果立即生效还是在回合结束时生效？立即生效会明确显示这是管理员嘉奖。", "<3?", list("Apply now", "Apply at round end", "Cancel")))
			if("Apply now")
				heart_recepient.receive_heart(usr, instant = TRUE)
			if("Apply at round end")
				heart_recepient.receive_heart(usr)
			else
				return

	else if(href_list["force_war"])
		if(!check_rights(R_ADMIN))
			return
		var/obj/item/nuclear_challenge/button = locate(href_list["force_war"])
		button.force_war()

	else if(href_list["give_reinforcement"])
		var/datum/team/nuclear/nuketeam = locate(href_list["give_reinforcement"]) in GLOB.antagonist_teams
		nuketeam.admin_spawn_reinforcement(usr)

	else if (href_list["interview"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/interview/I = locate(href_list["interview"])
		if (I)
			I.ui_interact(usr)

	else if (href_list["interview_man"])
		if(!check_rights(R_ADMIN))
			return
		GLOB.interviews.ui_interact(usr)

	else if(href_list["tag_datum"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/datum_to_tag = locate(href_list["tag_datum"])
		if(!datum_to_tag)
			return
		return add_tagged_datum(datum_to_tag)

	else if(href_list["del_tag"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/datum_to_remove = locate(href_list["del_tag"])
		if(!datum_to_remove)
			return
		return remove_tagged_datum(datum_to_remove)

	else if(href_list["show_tags"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/display_tags)

	else if(href_list["mark_datum"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/datum_to_mark = locate(href_list["mark_datum"])
		if(!datum_to_mark)
			return
		return usr.client?.mark_datum(datum_to_mark)

#ifndef DISABLE_DREAMLUAU
	else if(href_list["lua_state"])
		if(!check_rights(R_DEBUG))
			return
		var/datum/lua_state/state_to_view = locate(href_list["lua_state"])
		if(!state_to_view)
			return
		var/datum/lua_editor/editor = new(state_to_view)
		var/log_index = href_list["log_index"]
		if(log_index)
			log_index = text2num(log_index)
		if(log_index <= state_to_view.log.len)
			var/list/log_entry = state_to_view.log[log_index]
			if(log_entry["chunk"])
				editor.force_view_chunk = log_entry["chunk"]
				editor.force_modal = "viewChunk"
		editor.ui_interact(usr)
#endif

	else if(href_list["show_paper"])
		if(!check_rights(R_ADMIN))
			return

		var/obj/item/paper/paper_to_show = locate(href_list["show_paper"])
		if(!paper_to_show)
			return
		paper_to_show.ui_interact(usr)
	else if (href_list["print_fax"])
		if(!check_rights(R_ADMIN))
			return

		for(var/obj/machinery/fax/admin/FAX as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/fax/admin))
			if(FAX.fax_id != href_list["destination"])
				continue
			FAX.receive(locate(href_list["print_fax"]), href_list["sender_name"])
			return
	// SKYRAT EDIT ADDITION START
	else if(href_list["pass_opfor_candidate"])
		if(!check_rights(R_ADMIN))
			return

		if(!SSdynamic.force_run_midround(/datum/dynamic_ruleset/midround/from_living/opfor_candidate, admin = usr))
			message_admins("无法选出敌对势力候选人。")
	// SKYRAT EDIT ADDITION END
	else if(href_list["play_internet"])
		if(!check_rights(R_SOUND))
			return

		var/credit = href_list["credit"]
		var/link_url = href_list["play_internet"]
		if(!link_url)
			return

		web_sound(usr, link_url, credit)

	else if(href_list["debug_z_levels"])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/debug_z_levels)
