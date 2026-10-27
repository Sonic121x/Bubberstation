/datum/phystool_mode/color_mode
	name = "颜色模式"
	desc = "使用左键为物体染色。使用右键设置默认颜色。在手中使用以选择颜色。"

	var/selected_color

/datum/phystool_mode/color_mode/use_act(mob/user)
	. = ..()
	selected_color = tgui_color_picker(user, "选择新的效果颜色", "物理枪颜色") // BUBBERSTATION EDIT: TGUI COLOR PICKER

/datum/phystool_mode/color_mode/main_act(atom/target, mob/user)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		if(L.client)
			user.balloon_alert(user, "无法染色！")
			return FALSE
	if(!selected_color)
		selected_color = COLOR_WHITE
	target.color = selected_color
	return TRUE

/datum/phystool_mode/color_mode/secondnary_act(atom/target, mob/user)
	. = ..()
	target.color = initial(target.color)
	return TRUE
