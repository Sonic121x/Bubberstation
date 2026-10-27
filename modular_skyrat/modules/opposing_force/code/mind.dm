/datum/mind
	var/datum/opposing_force/opposing_force

/datum/mind/Destroy()
	QDEL_NULL(opposing_force)
	return ..()

GAME_VERB_DESC(/mob, opposing_force, "敌对势力", "查看你的敌对势力面板，或提交申请。", "OOC")
	// Mind checks
	if(!mind)
		var/fail_message = "你没有心智！"
		if(isobserver(src))
			fail_message += "你必须曾经参与当前回合才能拥有心智。"
		to_chat(src, span_warning(fail_message))
		return
	if(mind?.assigned_role.title == ROLE_GHOST_CAFE)
		to_chat(src, span_warning("你必须正在参与当前回合才能申请敌对势力。"))
		return
	if(is_banned_from(ckey, BAN_ANTAGONIST))
		to_chat(src, span_warning("你已被禁止担任反派！"))
		return

	if(is_banned_from(ckey, BAN_OPFOR))
		to_chat(src, span_warning("你已被禁止申请敌对势力！"))
		return

	if(!mind.opposing_force)
		var/datum/opposing_force/opposing_force = new(mind)
		mind.opposing_force = opposing_force
		SSopposing_force.new_opfor(opposing_force)
	mind.opposing_force.ui_interact(usr)
