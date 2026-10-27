/datum/buildmode_mode/varedit
	key = "edit"
	// Varedit mode
	var/varholder = null
	var/valueholder = null

/datum/buildmode_mode/varedit/Destroy()
	varholder = null
	valueholder = null
	return ..()

/datum/buildmode_mode/varedit/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("选择变量(类型)与值")] -> 在建造模式按钮上按鼠标右键\n\
		[span_bold("设置变量(类型)与值")] -> 在地块/物体/生物上按鼠标左键\n\
		[span_bold("重置变量的值")] -> 在地块/物体/生物上按鼠标右键"))
	)

/datum/buildmode_mode/varedit/Reset()
	. = ..()
	varholder = null
	valueholder = null

/datum/buildmode_mode/varedit/change_settings(client/c)
	varholder = input(c, "输入变量名：" ,"名称", "name")

	if(!vv_varname_lockcheck(varholder))
		return

	var/temp_value = c.vv_get_value()
	if(isnull(temp_value["class"]))
		Reset()
		to_chat(c, span_notice("变量已取消设置。"))
		return
	valueholder = temp_value["value"]

/datum/buildmode_mode/varedit/handle_click(client/c, params, obj/object)
	var/list/modifiers = params2list(params)

	if(isnull(varholder))
		to_chat(c, span_warning("请先选择一个要修改的变量。"))
		return
	if(LAZYACCESS(modifiers, LEFT_CLICK))
		if(object.vars.Find(varholder))
			if(object.vv_edit_var(varholder, valueholder) == FALSE)
				to_chat(c, span_warning("你的修改被该对象拒绝了。"))
				return
			log_admin("建造模式：[key_name(c)] 把 [object.name] 的 [varholder] 修改为 [valueholder]")
		else
			to_chat(c, span_warning("[initial(object.name)] 没有名为 '[varholder]' 的变量"))
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(object.vars.Find(varholder))
			var/reset_value = initial(object.vars[varholder])
			if(object.vv_edit_var(varholder, reset_value) == FALSE)
				to_chat(c, span_warning("你的修改被该对象拒绝了。"))
				return
			log_admin("建造模式：[key_name(c)] 把 [object.name] 的 [varholder] 修改为 [reset_value]")
		else
			to_chat(c, span_warning("[initial(object.name)] 没有名为 '[varholder]' 的变量"))

