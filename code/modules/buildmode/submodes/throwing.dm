/datum/buildmode_mode/throwing
	key = "throw"

	var/atom/movable/throw_atom = null

/datum/buildmode_mode/throwing/Destroy()
	throw_atom = null
	return ..()

/datum/buildmode_mode/throwing/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("选择")] -> 在 turf/obj/mob 上按鼠标左键\n\
		[span_bold("投掷")] -> 在 turf/obj/mob 上按鼠标右键"))
	)

/datum/buildmode_mode/throwing/handle_click(client/c, params, obj/object)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		if(isturf(object))
			return
		throw_atom = object
		to_chat(c, "已选择物体 '[throw_atom]'")
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(throw_atom)
			throw_atom.throw_at(object, 10, 1, c.mob)
			log_admin("建造模式：[key_name(c)] 将 [throw_atom] 投掷向 [object] ([AREACOORD(object)])")
