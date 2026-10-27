// BUBBER ADDITION: Localize downstream antagonist choices without replacing internal keys.
/proc/chinese_heretic_trick_display(value)
	var/static/list/labels = list(
		"Spawn Confetti" = "喷洒彩纸",
		"Clean" = "清洁",
		"Add A Glow To Any Item" = "使物品发光",
		"Enhance Taste & Add Healing To Food" = "改善食物口味并赋予疗效",
	)
	return labels[value] || value

/proc/chinese_heretic_trick_radial(mob/user, list/choices)
	var/list/display_choices = list()
	var/list/original_choices = list()
	for(var/value in choices)
		var/label = chinese_heretic_trick_display(value)
		display_choices[label] = choices[value]
		original_choices[label] = value
	var/selection = show_radial_menu(user, user, display_choices)
	return isnull(selection) ? null : original_choices[selection]

/proc/chinese_heretic_job_input(mob/user, message, title, default_value)
	var/input_value = tgui_input_text(user, message, title, chinese_job_display(default_value), max_length = MAX_NAME_LEN)
	if(isnull(input_value))
		return null
	var/list/job_names = chinese_job_display(null, return_mapping = TRUE)
	for(var/raw_name in job_names)
		if(job_names[raw_name] == input_value)
			return raw_name
	return input_value

/proc/chinese_zubbers_malf_module_display(value)
	var/static/list/labels = list("Positronic Chassis Hacking" = "正电子机体入侵", "Manual Law Override" = "手动覆盖法则")
	return labels[value] || value

/proc/chinese_zubbers_malf_module_storage(value)
	var/static/list/names = list("正电子机体入侵" = "Positronic Chassis Hacking", "手动覆盖法则" = "Manual Law Override")
	return names[value] || value

/proc/chinese_zubbers_heretic_category_display(value)
	if(value == "Icewalker")
		return "冰行者"
	if(value == "Icemoon Dwellers")
		return "冰月居民"
	var/static/list/names = list("Acolyte" = "侍徒", "Acolytes" = "侍徒", "Acolyte (No Influence Spawning)" = "侍徒（不生成影响）", "Hacked Synthetic" = "被入侵的合成人", "Syndicate Boarder" = "辛迪加登船者")
	return names[value] || value
