/datum/buildmode_mode/advanced
	key = "advanced"
	var/atom/objholder = null

/datum/buildmode_mode/advanced/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("设置对象类型")] -> 在建造模式按钮上按鼠标右键\n\
		[span_bold("复制对象类型")] -> 在地块/物体上按鼠标左键 + Alt\n\
		[span_bold("放置物体")] -> 在地块/物体上按鼠标左键\n\
		[span_bold("删除物体")] -> 鼠标右键\n\
		\n\
		使用左上角的按钮来改变建造物体的朝向。"))
	)

/datum/buildmode_mode/advanced/change_settings(client/c)
	var/target_path = input(c, "输入类型路径：", "类型路径", "/obj/structure/closet")
	objholder = text2path(target_path)
	if(!ispath(objholder))
		objholder = pick_closest_path(target_path)
		if(!objholder)
			tgui_alert(usr,"未选择任何路径")
			return
		else if(ispath(objholder, /area))
			objholder = null
			tgui_alert(usr,"不允许使用该路径。")
			return
	BM.preview_selected_item(objholder)

/datum/buildmode_mode/advanced/handle_click(client/c, params, obj/object)
	var/list/modifiers = params2list(params)
	var/left_click = LAZYACCESS(modifiers, LEFT_CLICK)
	var/right_click = LAZYACCESS(modifiers, RIGHT_CLICK)
	var/alt_click = LAZYACCESS(modifiers, ALT_CLICK)

	if(left_click && alt_click)
		if (istype(object, /turf) || isobj(object) || istype(object, /mob))
			objholder = object.type
			to_chat(c, span_notice("已选择 [initial(object.name)]（[object.type]）。"))
			BM.preview_selected_item(objholder)
		else
			to_chat(c, span_notice("[initial(object.name)] 不是地块、物体或生物！请重新选择。"))
	else if(left_click)
		if(ispath(objholder,/turf))
			var/turf/T = get_turf(object)
			log_admin("建造模式：[key_name(c)] 将 [AREACOORD(object)] 的 [T] 修改为 [objholder]")
			T = T.ChangeTurf(objholder)
			T.setDir(BM.build_dir)
		else if(ispath(objholder, /obj/effect/turf_decal))
			var/turf/T = get_turf(object)
			T.AddElement(/datum/element/decal, initial(objholder.icon), initial(objholder.icon_state), BM.build_dir, null, null, initial(objholder.alpha), initial(objholder.color), null, FALSE, null)
			log_admin("建造模式：[key_name(c)] 在 [AREACOORD(object)] 向 [T] 添加了一个 [initial(objholder.name)] 贴花，朝向为 [BM.build_dir]")
		else if(!isnull(objholder))
			var/obj/A = new objholder (get_turf(object))
			A.setDir(BM.build_dir)
			log_admin("建造模式：[key_name(c)] 将 [A] 在 [COORD(A)] 的朝向修改为 [BM.build_dir]")
		else
			to_chat(c, span_warning("请先选择对象类型。"))
	else if(right_click)
		if(isobj(object))
			log_admin("建造模式：[key_name(c)] 删除了 [AREACOORD(object)] 处的 [object]")
			qdel(object)
