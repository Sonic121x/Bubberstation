/datum/computer_file/program/ai_restorer
	filename = "ai_restore"
	filedesc = "AI 管理与恢复"
	downloader_category = PROGRAM_CATEGORY_SCIENCE
	program_open_overlay = "generic"
	extended_desc = "固件修复套件，能够重建受损的 AI 系统。需要通过智能卡槽与 AI 直接连接。"
	size = 12
	can_run_on_flags = PROGRAM_CONSOLE | PROGRAM_LAPTOP
	download_access = list(ACCESS_RD)
	tgui_id = "NtosAiRestorer"
	program_icon = "laptop-code"

	/// The AI stored in the program
	var/obj/item/aicard/stored_card
	/// Variable dictating if we are in the process of restoring the AI in the inserted intellicard
	var/restoring = FALSE

/datum/computer_file/program/ai_restorer/on_examine(obj/item/modular_computer/source, mob/user)
	var/list/examine_text = list()
	if(!stored_card)
		examine_text += "它装有一个智能卡槽。"
		return examine_text

	if(computer.Adjacent(user))
		examine_text += "它装有一个智能卡槽，其中装有：[stored_card.name]"
	else
		examine_text += "它装有一个智能卡槽，看起来已被占用。"
	examine_text += span_info("按住 Alt 点击可弹出智能卡。")
	return examine_text

/datum/computer_file/program/ai_restorer/kill_program(mob/user)
	try_eject(forced = TRUE)
	return ..()

/datum/computer_file/program/ai_restorer/process_tick(seconds_per_tick)
	. = ..()
	if(!restoring) //Put the check here so we don't check for an ai all the time
		return

	var/mob/living/silicon/ai/A = stored_card.AI
	if(stored_card.flush)
		restoring = FALSE
		return
	A.adjust_oxy_loss(-5, FALSE)
	A.adjust_fire_loss(-5, FALSE)
	A.adjust_brute_loss(-5, FALSE)

	// Please don't forget to update health, otherwise the below if statements will probably always fail.
	A.updatehealth()
	if(A.health >= 0 && A.stat == DEAD)
		A.revive()
		stored_card.update_appearance()

	// Finished restoring
	if(A.health >= 100)
		restoring = FALSE

	return TRUE

/datum/computer_file/program/ai_restorer/application_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/aicard))
		return aicard_act(user, tool)

/datum/computer_file/program/ai_restorer/proc/aicard_act(mob/living/user, obj/item/aicard/used_aicard)
	if(!computer)
		return NONE
	if(stored_card)
		to_chat(user, span_warning("你试着把 \the [used_aicard] 插入 \the [computer.name]，但插槽已被占用。"))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(used_aicard, computer))
		return ITEM_INTERACT_BLOCKING

	stored_card = used_aicard
	to_chat(user, span_notice("你把 \the [used_aicard] 插入 \the [computer.name]。"))
	return ITEM_INTERACT_SUCCESS

/datum/computer_file/program/ai_restorer/try_eject(mob/living/user, forced = FALSE)
	if(!stored_card)
		if(user)
			to_chat(user, span_warning("\the [computer.name] 里没有卡。"))
		return FALSE

	if(restoring && !forced)
		if(user)
			to_chat(user, span_warning("安全机制禁止你在重建完成前取出卡片……"))
		return FALSE

	if(user && computer.Adjacent(user))
		to_chat(user, span_notice("你从 [computer.name] 中取出了 [stored_card]。"))
		user.put_in_hands(stored_card)
	else
		stored_card.forceMove(computer.drop_location())

	stored_card = null
	restoring = FALSE
	return TRUE


/datum/computer_file/program/ai_restorer/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("PRG_beginReconstruction")
			if(!stored_card || !stored_card.AI)
				return FALSE
			var/mob/living/silicon/ai/A = stored_card.AI
			if(A && A.health < 100)
				restoring = TRUE
				A.notify_revival("你的核心文件正在被恢复！", source = computer)
			return TRUE
		if("PRG_eject")
			if(stored_card)
				try_eject(usr)
				return TRUE

/datum/computer_file/program/ai_restorer/ui_data(mob/user)
	var/list/data = list()

	data["ejectable"] = TRUE
	data["AI_present"] = !!stored_card?.AI
	data["error"] = null

	if(!stored_card)
		data["error"] = "请插入一张智能卡。"
	else if(!stored_card.AI)
		data["error"] = "未找到 AI……"
	else if(stored_card.flush)
		data["error"] = "正在执行清除！"
	else
		data["name"] = stored_card.AI.name
		data["restoring"] = restoring
		data["health"] = (stored_card.AI.health + 100) / 2
		data["isDead"] = stored_card.AI.stat == DEAD
		data["laws"] = stored_card.AI.laws.get_law_list(include_zeroth = TRUE, render_html = FALSE)

	return data
