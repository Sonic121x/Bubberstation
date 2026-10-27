
#define ANNOUNCEMENT_COOLDOWN (10 MINUTES)

/obj/machinery/computer/centcom_announcement
	name = "舰队公告控制台"
	desc = "用于发布纳米传讯优先指挥报告的控制台。"
	icon_screen = "comm"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_CENT_CAPTAIN)
	circuit = /obj/item/circuitboard/computer/communications
	light_color = LIGHT_COLOR_BLUE

	/// The name of central command that will accompany our report
	var/command_name = "纳米传讯舰队指挥部"
	/// The actual contents of the report we're going to send.
	var/command_report_content
	/// The title of our report, if anything.
	var/command_report_title
	/// Whether the report's contents are announced.
	var/announce_contents = TRUE
	/// Custom report sound.
	var/report_sound = null
	/// The error we encountered while trying to send a report.
	var/error = ""

	/// Cooldown for sending messages
	COOLDOWN_DECLARE(static/announcement_cooldown)

/obj/machinery/computer/centcom_announcement/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CommandReportConsole")
		ui.open()

/obj/machinery/computer/centcom_announcement/ui_data(mob/user)
	var/list/data = list()
	data["command_report_content"] = command_report_content
	data["announce_contents"] = announce_contents
	data["error"] = error
	data["command_report_title"] = command_report_title
	return data

/obj/machinery/computer/centcom_announcement/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("update_report_contents")
			command_report_content = params["updated_contents"]
		if("update_report_title")
			command_report_title = params["updated_title"]
		if("toggle_announce")
			announce_contents = !announce_contents
		if("submit_report")
			error = ""
			if(!command_report_content)
				error = "错误：内容为空"
				return
			if (!COOLDOWN_FINISHED(src, announcement_cooldown))
				error = "错误：系统正在充能，剩余：[announcement_cooldown - world.time]"
				return
			send_announcement()
	return TRUE

/*
 * The actual proc that sends the priority announcement and reports
 */
/obj/machinery/computer/centcom_announcement/proc/send_announcement()
	if (!COOLDOWN_FINISHED(src, announcement_cooldown))
		return

	if(!report_sound)
		report_sound = SSstation.announcer.get_rand_report_sound()

	if(announce_contents)
		priority_announce(command_report_content, command_report_title, report_sound, sender_override = command_name, has_important_message = TRUE)
	print_command_report(command_report_content, "[announce_contents ? "" : "机密 "][command_name]通报", !announce_contents)

	log_admin("[key_name(usr)] 创建了一份指挥报告：“[command_report_content]”，发送者为“[command_name]”。")
	message_admins("[key_name_admin(usr)] 创建了一份指挥报告，发送者为“[command_name]”。")

	COOLDOWN_START(src, announcement_cooldown, ANNOUNCEMENT_COOLDOWN)

/obj/item/circuitboard/computer/centcom_announcement
	name = "舰队公告（计算机电路板）"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/centcom_announcement

#undef ANNOUNCEMENT_COOLDOWN
