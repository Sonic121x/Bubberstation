/**
 * Return the markup to for the dropdown list for the VV panel for this atom
 *
 * Override in subtypes to add custom VV handling in the VV panel
 */
/atom/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("", "--- /atom ---")
	if(!ismovable(src))
		var/turf/curturf = get_turf(src)
		if(curturf)
			. += "<a href='byond://?_src_=holder;[HrefToken()];adminplayerobservecoodjump=1;X=[curturf.x];Y=[curturf.y];Z=[curturf.z]' style='display:none;'>跳转到此处</a>"
	VV_DROPDOWN_OPTION(VV_HK_MODIFY_TRANSFORM, "修改变换")
	VV_DROPDOWN_OPTION(VV_HK_DEBUG_APPEARANCE, "调试外观")
	VV_DROPDOWN_OPTION(VV_HK_DOWNLOAD_SPRITE, "下载精灵图")
	VV_DROPDOWN_OPTION(VV_HK_SPIN_ANIMATION, "旋转动画")
	VV_DROPDOWN_OPTION(VV_HK_STOP_ALL_ANIMATIONS, "停止所有动画")
	VV_DROPDOWN_OPTION(VV_HK_SHOW_HIDDENPRINTS, "显示隐藏指纹日志")
	VV_DROPDOWN_OPTION(VV_HK_ADD_REAGENT, "添加试剂")
	VV_DROPDOWN_OPTION(VV_HK_TRIGGER_EMP, "电磁脉冲")
	VV_DROPDOWN_OPTION(VV_HK_TRIGGER_EXPLOSION, "爆炸")
	VV_DROPDOWN_OPTION(VV_HK_EDIT_FILTERS, "编辑滤镜")
	VV_DROPDOWN_OPTION(VV_HK_EDIT_COLOR_MATRIX, "以矩阵编辑颜色")
	VV_DROPDOWN_OPTION(VV_HK_TEST_MATRIXES, "测试矩阵")
	VV_DROPDOWN_OPTION(VV_HK_ADD_AI, "添加 AI 控制器")
	VV_DROPDOWN_OPTION(VV_HK_ARMOR_MOD, "修改护甲")
	if(greyscale_colors)
		VV_DROPDOWN_OPTION(VV_HK_MODIFY_GREYSCALE, "修改灰度着色")

/atom/vv_do_topic(list/href_list)
	. = ..()

	if(!.)
		return

	if(href_list[VV_HK_ADD_REAGENT])
		if(!reagents)
			var/amount = tgui_input_number(usr, "指定[src]的试剂容量", "设置试剂容量", 50)
			if(!amount)
				return
			create_reagents(amount)

		if(!reagents)
			return

		var/chosen_id
		switch(tgui_alert(usr, "选择一种方式。", "添加试剂", list("搜索", "从列表选择", "试试手气")))
			if("搜索")
				var/valid_id
				while(!valid_id)
					chosen_id = tgui_input_text(usr, "输入要添加的试剂 ID。", "搜索试剂")
					if(isnull(chosen_id)) //Get me out of here!
						break
					if (!ispath(text2path(chosen_id)))
						chosen_id = pick_closest_path(chosen_id, make_types_fancy(subtypesof(/datum/reagent)))
						if (ispath(chosen_id))
							valid_id = TRUE
					else
						valid_id = TRUE
					if(!valid_id)
						to_chat(usr, span_warning("不存在使用该 ID 的试剂！"))
			if("从列表选择")
				chosen_id = tgui_input_list(usr, "选择要添加的试剂。", "选择试剂", sort_list(subtypesof(/datum/reagent), GLOBAL_PROC_REF(cmp_typepaths_asc)))
			if("试试手气")
				chosen_id = pick(subtypesof(/datum/reagent))

		if(!chosen_id)
			return
		var/amount = tgui_input_number(usr, "选择添加量。", "选择数量", reagents.maximum_volume - reagents.total_volume, reagents.maximum_volume)
		if(!amount)
			return
		reagents.add_reagent(chosen_id, amount)
		log_admin("[key_name(usr)] has added [amount] units of [chosen_id] to [src]")
		message_admins(span_notice("[key_name(usr)]向[src]添加了[amount]单位[chosen_id]"))

	if(href_list[VV_HK_TRIGGER_EXPLOSION])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/admin_explosion, src)

	if(href_list[VV_HK_TRIGGER_EMP])
		return SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/admin_emp, src)

	if(href_list[VV_HK_SHOW_HIDDENPRINTS])
		if(!check_rights(R_ADMIN))
			return
		usr.client.cmd_show_hiddenprints(src)

	if(href_list[VV_HK_ARMOR_MOD])
		var/list/picker_list = list()
		var/list/armor_list = get_armor().get_rating_list()
		for (var/rating in armor_list)
			picker_list += list(list("value" = armor_list[rating], "name" = rating))

		var/list/result = present_picker(usr, "修改护甲", "修改护甲：[src]", button_1 = "保存", button_2 = "取消", timeout = FALSE, input_type = "text", values = picker_list)
		if(!islist(result))
			return
		if(result["button"] == 2) // If the user pressed the cancel button
			return

		var/list/armor_all = ARMOR_LIST_ALL
		// text2num conveniently returns a null on invalid values
		var/list/converted = list()
		for(var/armor_key in armor_all)
			converted[armor_key] = text2num(result["values"][armor_key])
		set_armor(get_armor().generate_new_with_specific(converted))

		var/message = "[key_name(usr)]将[src]（[type]）的护甲修改为："
		for(var/armor_key in armor_all)
			message += "[armor_key]=[get_armor_rating(armor_key)],"
		message = copytext(message, 1, -1)
		log_admin(span_notice(message))
		message_admins(span_notice(message))

	if(href_list[VV_HK_ADD_AI])
		var/result = tgui_input_list(usr, "选择应用到此原子的 AI 控制器。警告：并非所有 AI 都适用于所有原子。", "AI 控制器", sort_list(subtypesof(/datum/ai_controller), GLOBAL_PROC_REF(cmp_typepaths_asc)))
		if(result)
			ai_controller = new result(src)

	if(href_list[VV_HK_MODIFY_TRANSFORM])
		var/result = input(usr, "选择要应用的变换","修改变换") as null|anything in list("缩放","平移","旋转","错切")
		var/matrix/M = transform
		if(!result)
			return
		switch(result)
			if("缩放")
				var/x = input(usr, "选择 X 轴系数","修改变换") as null|num
				var/y = input(usr, "选择 Y 轴系数","修改变换") as null|num
				if(isnull(x) || isnull(y))
					return
				transform = M.Scale(x,y)
			if("平移")
				var/x = input(usr, "选择 X 轴位移（负值向左，正值向右）","修改变换") as null|num
				var/y = input(usr, "选择 Y 轴位移（负值向下，正值向上）","修改变换") as null|num
				if(isnull(x) || isnull(y))
					return
				transform = M.Translate(x,y)
			if("错切")
				var/x = input(usr, "选择 X 轴系数","修改变换") as null|num
				var/y = input(usr, "选择 Y 轴系数","修改变换") as null|num
				if(isnull(x) || isnull(y))
					return
				transform = M.Shear(x,y)
			if("旋转")
				var/angle = input(usr, "选择旋转角度","修改变换") as null|num
				if(isnull(angle))
					return
				transform = M.Turn(angle)
		SEND_SIGNAL(src, COMSIG_ATOM_VV_MODIFY_TRANSFORM)

	if(href_list[VV_HK_SPIN_ANIMATION])
		var/num_spins = input(usr, "是否无限旋转？", "旋转动画") in list("是", "否")
		if(num_spins == "否")
			num_spins = input(usr, "旋转多少圈？", "旋转动画") as null|num
		else
			num_spins = -1
		if(!num_spins)
			return
		var/spins_per_sec = input(usr, "每秒旋转多少圈？", "旋转动画") as null|num
		if(!spins_per_sec)
			return
		var/direction = input(usr, "选择方向", "旋转动画") in list("顺时针", "逆时针")
		switch(direction)
			if("顺时针")
				direction = 1
			if("逆时针")
				direction = 0
			else
				return
		SpinAnimation(1 SECONDS / spins_per_sec, num_spins, direction)

	if(href_list[VV_HK_STOP_ALL_ANIMATIONS])
		// Critical: Needs to be accessible in case of animation spam breaking shit
		// Do not TGUIfy
		var/result = input(usr, "确定吗？", "停止动画") in list("是", "否")
		if(result == "是")
			animate(src, transform = null, flags = ANIMATION_END_NOW) // Literally just fucking stop animating entirely because admin said so
		return

	if(href_list[VV_HK_AUTO_RENAME])
		var/newname = input(usr, "要将它重命名为什么？", "自动重命名") as null|text
		// Check the new name against the chat filter. If it triggers the IC chat filter, give an option to confirm.
		if(newname && !(is_ic_filtered(newname) || is_soft_ic_filtered(newname) && tgui_alert(usr, "所选名称包含角色内聊天过滤器限制的词语。确认使用此名称？", "角色内聊天过滤冲突", list("确认", "取消")) != "确认"))
			vv_auto_rename(newname)

	if(href_list[VV_HK_EDIT_FILTERS])
		usr.client?.open_filter_editor(src)

	if(href_list[VV_HK_EDIT_COLOR_MATRIX])
		usr.client?.open_color_matrix_editor(src)

	if(href_list[VV_HK_TEST_MATRIXES])
		usr.client?.open_matrix_tester(src)

	if(href_list[VV_HK_DOWNLOAD_SPRITE])
		var/icon/target_icon = getFlatIcon(src)
		usr << ftp(target_icon, "[name].png")

/atom/vv_get_header()
	. = ..()
	var/refid = REF(src)
	. += "[VV_HREF_TARGETREF(refid, VV_HK_AUTO_RENAME, "<b id='name'>[src]</b>")]"
	. += "<br><font size='1'><a href='byond://?_src_=vars;[HrefToken()];rotatedatum=[refid];rotatedir=left'><<</a> <a href='byond://?_src_=vars;[HrefToken()];datumedit=[refid];varnameedit=dir' id='dir'>[dir2text(dir) || dir]</a> <a href='byond://?_src_=vars;[HrefToken()];rotatedatum=[refid];rotatedir=right'>>></a></font>"

/**
 * call back when a var is edited on this atom
 *
 * Can be used to implement special handling of vars
 *
 * At the atom level, if you edit a var named "color" it will add the atom colour with
 * admin level priority to the atom colours list
 *
 * Also, if GLOB.debugging_enabled is FALSE, it sets the [ADMIN_SPAWNED_1] flag on [flags_1][/atom/var/flags_1], which signifies
 * the object has been admin edited
 */
/atom/vv_edit_var(var_name, var_value)
	var/old_light_flags = light_flags
	// Disable frozen lights for now, so we can actually modify it
	light_flags &= ~LIGHT_FROZEN
	switch(var_name)
		if(NAMEOF(src, light_range))
			if(light_system == COMPLEX_LIGHT)
				set_light(l_range = var_value)
			else
				set_light_range(var_value)
			. = TRUE
		if(NAMEOF(src, light_power))
			if(light_system == COMPLEX_LIGHT)
				set_light(l_power = var_value)
			else
				set_light_power(var_value)
			. = TRUE
		if(NAMEOF(src, light_color))
			if(light_system == COMPLEX_LIGHT)
				set_light(l_color = var_value)
			else
				set_light_color(var_value)
			. = TRUE
		if(NAMEOF(src, light_angle))
			if(light_system == COMPLEX_LIGHT)
				set_light(l_angle = var_value)
				. = TRUE
		if(NAMEOF(src, light_dir))
			if(light_system == COMPLEX_LIGHT)
				set_light(l_dir = var_value)
				. = TRUE
		if(NAMEOF(src, light_height))
			if(light_system == COMPLEX_LIGHT)
				set_light(l_height = var_value)
				. = TRUE
		if(NAMEOF(src, light_on))
			if(light_system == COMPLEX_LIGHT)
				set_light(l_on = var_value)
			else
				set_light_on(var_value)
			. = TRUE
		if(NAMEOF(src, light_flags))
			set_light_flags(var_value)
			// I'm sorry
			old_light_flags = var_value
			. = TRUE
		if(NAMEOF(src, light_render_source))
			set_light_render_source(var_value)
			. = TRUE
		if(NAMEOF(src, light_angle))
			if(light_system == COMPLEX_LIGHT)
				set_light(l_angle = var_value)
			else
				set_light_angle(var_value)
			. = TRUE
		if(NAMEOF(src, light_dir))
			if(light_system == COMPLEX_LIGHT)
				set_light(l_dir = var_value)
			else
				set_light_dir(var_value)
			. = TRUE
		if(NAMEOF(src, light_height))
			if(light_system == COMPLEX_LIGHT)
				set_light(l_height = var_value)
			else
				set_light_height(var_value)
			. = TRUE
		if(NAMEOF(src, smoothing_junction))
			set_smoothed_icon_state(var_value)
			. = TRUE
		if(NAMEOF(src, opacity))
			set_opacity(var_value)
			. = TRUE
		if(NAMEOF(src, base_pixel_x))
			set_base_pixel_x(var_value)
			. = TRUE
		if(NAMEOF(src, base_pixel_y))
			set_base_pixel_y(var_value)
			. = TRUE
		if(NAMEOF(src, material_flags))
			toggle_material_flags(var_value)
			. = TRUE
		if(NAMEOF(src, material_modifier))
			change_material_modifier(var_value)
			. = TRUE

	light_flags = old_light_flags
	if(!isnull(.))
		datum_flags |= DF_VAR_EDITED
		return

	if(!GLOB.debugging_enabled)
		flags_1 |= ADMIN_SPAWNED_1

	. = ..()

	switch(var_name)
		if(NAMEOF(src, color))
			add_atom_colour(color, ADMIN_COLOUR_PRIORITY)
			update_appearance()

/atom/proc/vv_auto_rename(newname)
	name = newname
