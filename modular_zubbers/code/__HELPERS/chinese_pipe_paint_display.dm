/proc/chinese_pipe_paint_choice(mob/user)
	var/list/choices = list()
	for(var/color_name in GLOB.pipe_paint_colors)
		choices[chinese_color_display(color_name)] = color_name
	var/choice = tgui_input_list(user, "要使用什么颜色？", "管道喷漆器", choices)
	return choices[choice]
