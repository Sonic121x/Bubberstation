/proc/chinese_structure_choice_display(value)
	var/static/list/names
	if(isnull(names))
		names = list("Cargo" = "货运", "Engineering" = "工程", "Engineering Secure" = "工程安全柜", "Radiation" = "辐射防护", "Tool Storage" = "工具存放", "Fire Equipment" = "消防设备", "Emergency" = "应急", "Hydroponics" = "水培", "Medical" = "医疗", "Science" = "科研", "Security" = "安保", "Mining" = "采矿", "Virology" = "病毒学", "Personal" = "个人", "Job" = "职位", "None" = "无")
	return names[value] || list("Internals" = "呼吸设备", "Medical Plus" = "医疗加强型", "Hydrophonics" = "水培", "Robotics" = "机器人学", "Solar" = "太阳能", "Atmospherics" = "大气技术", "Command" = "指挥")[value] || value

/proc/chinese_structure_choice(mob/user, message, title, list/choices)
	var/list/display_choices = list()
	for(var/choice in choices)
		display_choices[chinese_structure_choice_display(choice)] = choice
	var/selection = tgui_input_list(user, message, title, display_choices)
	return isnull(selection) ? null : display_choices[selection]
