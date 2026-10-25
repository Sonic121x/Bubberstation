/datum/buildmode_mode/copy
	key = "copy"
	var/atom/movable/stored = null

/datum/buildmode_mode/copy/Destroy()
	stored = null
	return ..()

/datum/buildmode_mode/copy/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("生成所选目标的副本")] -> 在 obj/turf/mob 上按鼠标左键\n\
		[span_bold("选择要复制的目标")] -> 在 obj/mob 上按鼠标右键"))
	)

/datum/buildmode_mode/copy/handle_click(client/c, params, obj/object)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		var/turf/T = get_turf(object)
		if(stored)
			duplicate_object(stored, spawning_location = T)
			log_admin("建造模式：[key_name(c)] 将 [stored] 复制到了 [AREACOORD(object)]")
	else if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(ismovable(object)) // No copying turfs for now.
			to_chat(c, span_notice("[object] 已设为模板。"))
			stored = object
