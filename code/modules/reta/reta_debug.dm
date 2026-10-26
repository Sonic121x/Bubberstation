/**
 * Request Emergency Temporary Access - Admin Verbs
 */

/// Admin command to manually trigger RETA access grant for admins
ADMIN_VERB(reta_manual_trigger, R_ADMIN, "RETA 门禁访问", "手动触发 RETA 门禁访问以进行测试", ADMIN_CATEGORY_EVENTS)

	var/calling_dept = tgui_input_list(user, "RETA - 哪个部门在呼叫支援？", "呼叫部门", list("Security", "Engineering", "Medical", "Science", "Service", "Command", "Cargo", "Mining"))
	if(!calling_dept)
		return

	var/list/available_depts = list("Security", "Engineering", "Medical", "Science", "Service", "Command", "Cargo", "Mining")
	available_depts -= calling_dept

	// Multi-select using repeated input_list calls
	var/list/selected_depts = list()
	var/list/remaining_depts = available_depts.Copy()

	while(length(remaining_depts))
		remaining_depts += "完成 - 结束选择"
		var/choice = tgui_input_list(user, "RETA - 选择要响应 [calling_dept] 的部门\n当前已选：[english_list(selected_depts)]\n\n选择另一个部门或“完成 - 结束选择”：", "响应部门", remaining_depts)

		if(!choice || choice == "完成 - 结束选择")
			break

		selected_depts += choice
		remaining_depts -= choice
		remaining_depts -= "完成 - 结束选择"

	if(!length(selected_depts))
		message_admins("未选择任何部门响应 RETA。")
		return

	var/duration = tgui_input_number(user, "持续时间（分钟）：", "RETA 持续时间", 5, 60, 1)
	if(!duration)
		return

	message_admins("[key_name_admin(user)] 正在手动触发 RETA：[calling_dept] 呼叫了支援，[english_list(selected_depts)] 将获得 [calling_dept] 区域的访问权限，持续 [duration] 分钟。")
	log_game("管理员：[key_name(user)] 正在手动触发 RETA：[calling_dept] 呼叫了支援，[english_list(selected_depts)] 将获得 [calling_dept] 区域的访问权限，持续 [duration] 分钟。")

	// Grant access to each responding department and collect results
	var/successful_grants = 0
	var/list/granted_depts = list()
	var/total_eligible_cards = 0

	for(var/responding_dept in selected_depts)
		var/dept_eligible_cards = 0
		var/list/job_trims = GLOB.reta_job_trims[responding_dept]

		for(var/mob/living/carbon/human/human_player as anything in GLOB.human_list)
			if(!human_player.client || human_player.stat == DEAD)
				continue

			var/obj/item/card/id/id_card = human_player.get_idcard(hand_first = FALSE)
			if(!id_card || !id_card.trim)
				continue

			if(is_type_in_list(id_card.trim, job_trims))
				dept_eligible_cards++

		total_eligible_cards += dept_eligible_cards
		message_admins("[responding_dept] 部门：来自在线玩家的 [dept_eligible_cards] 张合格证件")

		// Note: RETA grants access FROM calling_dept TO responding_dept personnel
		// So if Medical calls Security, Security personnel get Medical access
		if(reta_find_and_grant_access(responding_dept, calling_dept, duration MINUTES))
			successful_grants++
			granted_depts += responding_dept

	// Report results
	if(successful_grants > 0)
		message_admins("RETA 访问权限授予成功：[english_list(granted_depts)] 的人员现在拥有 [calling_dept] 访问权限。合格证件总数：[total_eligible_cards]")

		// Send department announcement like the normal system
		var/caller_info = "（由中央指挥部呼叫）"

		// Send announcements to all successfully granted departments
		for(var/dept in granted_depts)
			switch(dept)
				if("Security")
					aas_config_announce(/datum/aas_config_entry/rc_emergency, list("LOCATION" = calling_dept, "CALLER" = caller_info), null, list(RADIO_CHANNEL_SECURITY), "Security")
				if("Engineering")
					aas_config_announce(/datum/aas_config_entry/rc_emergency, list("LOCATION" = calling_dept, "CALLER" = caller_info), null, list(RADIO_CHANNEL_ENGINEERING), "Engineering")
				if("Medical")
					aas_config_announce(/datum/aas_config_entry/rc_emergency, list("LOCATION" = calling_dept, "CALLER" = caller_info), null, list(RADIO_CHANNEL_MEDICAL), "Medical")
				if("Science")
					aas_config_announce(/datum/aas_config_entry/rc_emergency, list("LOCATION" = calling_dept, "CALLER" = caller_info), null, list(RADIO_CHANNEL_SCIENCE), "Science")
				if("Service")
					aas_config_announce(/datum/aas_config_entry/rc_emergency, list("LOCATION" = calling_dept, "CALLER" = caller_info), null, list(RADIO_CHANNEL_SERVICE), "Service")
				if("Command")
					aas_config_announce(/datum/aas_config_entry/rc_emergency, list("LOCATION" = calling_dept, "CALLER" = caller_info), null, list(RADIO_CHANNEL_COMMAND), "Command")
				if("Cargo")
					aas_config_announce(/datum/aas_config_entry/rc_emergency, list("LOCATION" = calling_dept, "CALLER" = caller_info), null, list(RADIO_CHANNEL_SUPPLY), "Cargo")
				if("Mining")
					aas_config_announce(/datum/aas_config_entry/rc_emergency, list("LOCATION" = calling_dept, "CALLER" = caller_info), null, list(RADIO_CHANNEL_SUPPLY), "Mining")

		// Send confirmation to the calling department about who has been given access
		var/grantee = english_list(granted_depts)
		var/list/target_channels = list()
		switch(calling_dept)
			if("Security")
				target_channels += RADIO_CHANNEL_SECURITY
			if("Engineering")
				target_channels += RADIO_CHANNEL_ENGINEERING
			if("Medical")
				target_channels += RADIO_CHANNEL_MEDICAL
			if("Science")
				target_channels += RADIO_CHANNEL_SCIENCE
			if("Service")
				target_channels += RADIO_CHANNEL_SERVICE
			if("Command")
				target_channels += RADIO_CHANNEL_COMMAND
			if("Cargo")
				target_channels += RADIO_CHANNEL_SUPPLY
			if("Mining")
				target_channels += RADIO_CHANNEL_SUPPLY

		aas_config_announce(/datum/aas_config_entry/rc_reta_announcement, list("GRANTEE" = grantee, "CALLER" = caller_info), null, target_channels)
	else
		message_admins("所有部门的 RETA 访问权限授予均失败。")
