/// Local display labels; leave subsystem, preference and gameplay keys unchanged.
/proc/chinese_skyrat_systems_display(value)
	var/static/list/labels = list("pro-skub" = "支持斯库布", "anti-skub" = "反对斯库布", "i don't frikkin' care" = "我才不在乎", "Runner" = "奔行者", "Sentinel" = "哨兵", "Defender" = "守卫", "Drone" = "雄蜂")
	return labels[value] || value

/proc/chinese_skyrat_systems_choice(mob/user, message, title, list/choices)
	var/list/display_choices = list()
	for(var/value in choices)
		display_choices[chinese_skyrat_systems_display(value)] = value
	var/selected = tgui_input_list(user, message, title, display_choices)
	return isnull(selected) ? null : display_choices[selected]

/proc/chinese_skyrat_systems_radial(mob/user, atom/anchor, list/choices, radius = 36, require_near = TRUE, tooltips = FALSE)
	var/list/images = list()
	var/list/values = list()
	for(var/value in choices)
		var/label = chinese_skyrat_systems_display(value)
		images[label] = choices[value]
		values[label] = value
	var/selected = show_radial_menu(user, anchor, images, radius = radius, require_near = require_near, tooltips = tooltips)
	return isnull(selected) ? null : values[selected]
