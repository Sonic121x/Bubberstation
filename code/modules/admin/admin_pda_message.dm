
ADMIN_VERB(message_pda, R_ADMIN, "PDA 消息", "向用户的 PDA 发送消息。", ADMIN_CATEGORY_EVENTS)
	user.holder.message_pda()

///Opens up the PDA Message Panel
/datum/admins/proc/message_pda()
	if(!check_rights(R_ADMIN))
		return

	if(!length(GLOB.pda_messengers))
		to_chat(usr, span_warning("错误：没有你可以发送消息的用户"))
		return

	var/datum/admin_pda_panel/ui = new(usr)
	ui.ui_interact(usr)

/// Panel
/datum/admin_pda_panel

/datum/admin_pda_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AdminPDA")
		ui.open()

/datum/admin_pda_panel/ui_state(mob/user)
	return ADMIN_STATE(R_ADMIN)

/datum/admin_pda_panel/ui_static_data(mob/user)
	var/list/data = list()
	var/list/available_messengers = list()
	for(var/datum/computer_file/program/messenger/messenger as anything in GLOB.pda_messengers_by_name)
		available_messengers[REF(messenger)] = list(
			ref = REF(messenger),
			username = get_messenger_name(messenger),
			invisible = messenger.invisible,
		)
	data["users"] = available_messengers
	return data

/datum/admin_pda_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return

	if(!check_rights(R_ADMIN))
		return

	switch(action)
		if("sendMessage")
			var/targets = list()
			var/spam = params["spam"]
			var/ref = params["ref"]
			var/force = params["force"]
			if(!spam && (ref in GLOB.pda_messengers))
				targets += GLOB.pda_messengers[ref]
			else
				for(var/datum/computer_file/program/messenger/messenger as anything in GLOB.pda_messengers_by_name)
					if(messenger.invisible && !params["include_invisible"])
						continue
					targets += messenger

			if(!length(targets))
				to_chat(usr, span_warning("错误：目标不可用。"))
				return FALSE

			var/datum/signal/subspace/messaging/tablet_message/signal = new(null, list(
				"fakename" = params["name"],
				"fakejob" = params["job"],
				"message" = params["message"],
				"everyone" = spam,
				"ref" = null,
				"targets" = targets,
				"rigged" = FALSE,
				"automated" = FALSE,
			))

			if(force)
				signal.broadcast()
			else
				signal.levels = SSmapping.levels_by_trait(ZTRAIT_STATION)
				signal.send_to_receivers()

			if(!(force || signal.data["reject"]))
				to_chat(usr, span_warning("错误：PDA 消息被电信系统拒绝。"))
				return FALSE

			var/recipient = spam ? "所有人" : get_messenger_name(targets[1])

			message_admins("[key_name_admin(usr)] 向 [recipient] 发送了一条自定义 PDA 消息。")
			log_admin("[key_name(usr)] 向 [recipient] 发送了一条自定义 PDA 消息。消息：[params["message"]]。")
			log_pda("[key_name(usr)] 向 [recipient] 发送了一条管理员自定义 PDA 消息。消息：[params["message"]]")
			return TRUE
