/// The default command report announcement sound.
#define DEFAULT_ANNOUNCEMENT_SOUND "default_announcement"

/// Preset central command names to chose from for centcom reports.
#define CENTCOM_PRESET "Central Command"
#define SYNDICATE_PRESET "The Syndicate"
#define WIZARD_PRESET "The Wizard Federation"
#define CUSTOM_PRESET "Custom Command Name"
#define CUSTOM_SOUND_PRESET "Custom Sound"

ADMIN_VERB(change_command_name, R_ADMIN, "更改指挥部名称", "更改中央指挥部的名称。", ADMIN_CATEGORY_EVENTS)
	var/input = input(user, "请输入中央指挥部的新名称。", "什么？", "") as text|null
	if(!input)
		return
	change_command_name(input)
	message_admins("[key_name_admin(user)] 将中央指挥部的名称更改为 [input]")
	log_admin("[key_name(user)] 将中央指挥部名称更改为：[input]")

/// Verb to open the create command report window and send command reports.
ADMIN_VERB(create_command_report, R_ADMIN, "创建指挥部报告", "创建一份要发送到空间站的指挥部报告。", ADMIN_CATEGORY_EVENTS)
	BLACKBOX_LOG_ADMIN_VERB("Create Command Report")
	var/datum/command_report_menu/tgui = new /datum/command_report_menu(user.mob)
	tgui.ui_interact(user.mob)

/// Datum for holding the TGUI window for command reports.
/datum/command_report_menu
	/// The mob using the UI.
	var/mob/ui_user
	/// The name of central command that will accompany our report
	var/command_name = CENTCOM_PRESET
	/// Whether we are using a custom name instead of a preset.
	var/custom_name
	/// The actual contents of the report we're going to send.
	var/command_report_content
	/// Whether the report's contents are announced.
	var/announce_contents = TRUE
	/// Whether a copy of the report is printed at every console.
	var/print_report = TRUE
	/// The sound that's going to accompany our message.
	var/played_sound = DEFAULT_ANNOUNCEMENT_SOUND
	/// The colour of the announcement when sent
	var/announcement_color = "default"
	/// The subheader to include when sending the announcement. Keep blank to not include a subheader
	var/subheader = ""
	/// A static list of preset names that can be chosen.
	var/list/preset_names = list(CENTCOM_PRESET, SYNDICATE_PRESET, WIZARD_PRESET, CUSTOM_PRESET)

/datum/command_report_menu/New(mob/user)
	ui_user = user
	if(command_name() != CENTCOM_PRESET)
		command_name = command_name()
		preset_names.Insert(1, command_name())

/datum/command_report_menu/ui_state(mob/user)
	return ADMIN_STATE(R_ADMIN)

/datum/command_report_menu/ui_close()
	qdel(src)

/datum/command_report_menu/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CommandReport")
		ui.open()

/datum/command_report_menu/ui_data(mob/user)
	var/list/data = list()
	data["command_name"] = command_name
	data["custom_name"] = custom_name
	data["command_report_content"] = command_report_content
	data["announce_contents"] = announce_contents
	data["print_report"] = print_report
	data["played_sound"] = played_sound
	data["announcement_color"] = announcement_color
	data["subheader"] = subheader

	return data

/datum/command_report_menu/ui_static_data(mob/user)
	var/list/data = list()
	data["command_name_presets"] = preset_names
	data["announcer_sounds"] = list(DEFAULT_ANNOUNCEMENT_SOUND) + GLOB.announcer_keys + CUSTOM_SOUND_PRESET
	data["announcement_colors"] = ANNOUNCEMENT_COLORS

	return data

/datum/command_report_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("update_command_name")
			if(params["updated_name"] == CUSTOM_PRESET)
				custom_name = TRUE
			else if (params["updated_name"] in preset_names)
				custom_name = FALSE

			command_name = params["updated_name"]
		if("set_report_sound")
			if(params["picked_sound"] == CUSTOM_SOUND_PRESET)
				played_sound = DEFAULT_ANNOUNCEMENT_SOUND // fallback by default
				var/sound_file = input(ui_user, "选择声音文件", "上传声音") as sound|null
				if(!sound_file)
					tgui_alert(ui_user, "无法加载自定义声音，将播放标准声音。", "加载错误", list("确定"))
					return

				if(!IS_SOUND_FILE(sound_file))
					tgui_alert(ui_user, "文件类型无效。请选择一个声音文件。", "加载错误", list("确定"))
					return

				played_sound = sound_file
			else
				played_sound = params["picked_sound"]
		if("toggle_announce")
			announce_contents = !announce_contents
		if("toggle_printing")
			print_report = !print_report
		if("update_announcement_color")
			var/colors = ANNOUNCEMENT_COLORS
			var/chosen_color = params["updated_announcement_color"]
			if(chosen_color in colors)
				announcement_color = chosen_color
		if("set_subheader")
			subheader = params["new_subheader"]
		if("submit_report")
			if(!command_name)
				to_chat(ui_user, span_danger("没有指挥部名称，你无法发送报告。"))
				return
			if(!params["report"])
				to_chat(ui_user, span_danger("没有内容，你无法发送报告。"))
				return
			command_report_content = params["report"]
			send_announcement()

	return TRUE

/*
 * The actual proc that sends the priority announcement and reports
 *
 * Uses the variables set by the user on our datum as the arguments for the report.
 */
/datum/command_report_menu/proc/send_announcement()
	/// Our current command name to swap back to after sending the report.
	var/original_command_name = command_name()
	change_command_name(command_name)

	/// The sound we're going to play on report.
	var/report_sound = played_sound
	if(played_sound == DEFAULT_ANNOUNCEMENT_SOUND)
		report_sound = SSstation.announcer.get_rand_report_sound()

	if(announce_contents)
		var/chosen_color = announcement_color
		if(chosen_color == "default")
			if(command_name == SYNDICATE_PRESET)
				chosen_color = "red"
			else if(command_name == WIZARD_PRESET)
				chosen_color = "purple"
		priority_announce(command_report_content, subheader == ""? null : subheader, report_sound, has_important_message = TRUE, color_override = chosen_color)

	if(!announce_contents || print_report)
		print_command_report(command_report_content, "[announce_contents ? "" : "机密 "][command_name] 更新", !announce_contents, contains_advanced_html = TRUE)

	change_command_name(original_command_name)

	log_admin("[key_name(ui_user)] 创建了一份指挥部报告：“[command_report_content]”，由“[command_name]”发出，声音为“[played_sound]”。")

	message_admins("[key_name_admin(ui_user)] 创建了一份指挥部报告，由“[command_name]”发出，声音为“[played_sound]”")
	if(!announce_contents)
		message_admins("消息内容为：[command_report_content]")


#undef DEFAULT_ANNOUNCEMENT_SOUND

#undef CENTCOM_PRESET
#undef SYNDICATE_PRESET
#undef WIZARD_PRESET
#undef CUSTOM_PRESET
#undef CUSTOM_SOUND_PRESET
