// BUBBER ADDITION: Preserve transport installation identifiers in translated menus.
/proc/chinese_tram_install_display(value)
	var/static/list/display_names = list(NORMAL_WINDOW = "普通窗装", SPLIT_WINDOW = "分体窗装", STANDALONE = "独立式")
	return display_names[value] || value

/proc/chinese_tram_install_choice(mob/user)
	var/list/choices = list("普通窗装" = NORMAL_WINDOW, "分体窗装" = SPLIT_WINDOW, "独立式" = STANDALONE)
	var/selection = tgui_input_list(user, "窗装还是独立式？", "电车配置", choices)
	return isnull(selection) ? null : choices[selection]
