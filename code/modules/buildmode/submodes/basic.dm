/datum/buildmode_mode/basic
	key = "basic"

/datum/buildmode_mode/basic/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("建造 / 升级")] -> 鼠标左键\n\
		[span_bold("拆除 / 删除 / 降级")] -> 鼠标右键\n\
		[span_bold("强化窗")] -> 鼠标左键 + Ctrl\n\
		[span_bold("气闸")] -> 鼠标左键 + Alt \n\
		\n\
		使用左上角的按钮来改变建造物体的朝向。"))
	)

/datum/buildmode_mode/basic/handle_click(client/c, params, obj/object)
	var/list/modifiers = params2list(params)

	var/left_click = LAZYACCESS(modifiers, LEFT_CLICK)
	var/right_click = LAZYACCESS(modifiers, RIGHT_CLICK)
	var/alt_click = LAZYACCESS(modifiers, ALT_CLICK)
	var/ctrl_click = LAZYACCESS(modifiers, CTRL_CLICK)

	if(istype(object,/turf) && left_click && !alt_click && !ctrl_click)
		var/turf/clicked_turf = object
		if(isplatingturf(object))
			clicked_turf.place_on_top(/turf/open/floor/iron, flags = CHANGETURF_INHERIT_AIR)
		else if(isfloorturf(object))
			clicked_turf.place_on_top(/turf/closed/wall)
		else if(iswallturf(object))
			clicked_turf.place_on_top(/turf/closed/wall/r_wall)
		else
			clicked_turf.place_on_top(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR) // Gotta do something
		log_admin("建造模式：[key_name(c)] 在 [AREACOORD(clicked_turf)] 建造了 [clicked_turf]")
		return
	else if(right_click)
		log_admin("建造模式：[key_name(c)] 在 [AREACOORD(object)] 删除了 [object]")
		if(isturf(object))
			var/turf/T = object
			T.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		else if(isobj(object))
			qdel(object)
		return
	else if(istype(object,/turf) && alt_click && left_click)
		log_admin("建造模式：[key_name(c)] 在 [AREACOORD(object)] 建造了一个气闸")
		new/obj/machinery/door/airlock(get_turf(object))
	else if(istype(object,/turf) && ctrl_click && left_click)
		var/obj/structure/window/reinforced/window
		if(BM.build_dir in GLOB.diagonals)
			window = new /obj/structure/window/reinforced/fulltile(get_turf(object))
		else
			window = new /obj/structure/window/reinforced(get_turf(object))
			window.setDir(BM.build_dir)
		log_admin("建造模式：[key_name(c)] 在 [AREACOORD(object)] 建造了一扇窗户")
