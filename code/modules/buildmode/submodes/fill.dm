#define FILL_WARNING_MIN 150

/datum/buildmode_mode/fill
	key = "fill"

	use_corner_selection = TRUE
	var/atom/objholder = null

/datum/buildmode_mode/fill/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("选择角落")] -> 在 turf/obj/mob 上按鼠标左键\n\
		[span_bold("删除区域")] -> 在 turf/obj/mob 上按鼠标左键 + Alt\n\
		[span_bold("选择对象类型")] -> 在建造模式按钮上按鼠标右键"))
	)

/datum/buildmode_mode/fill/change_settings(client/c)
	var/target_path = input(c, "输入类型路径：" ,"类型路径","/obj/structure/closet")
	objholder = text2path(target_path)
	if(!ispath(objholder))
		objholder = pick_closest_path(target_path)
		if(!objholder)
			tgui_alert(usr,"未选择任何路径。")
			return
		else if(ispath(objholder, /area))
			objholder = null
			tgui_alert(usr,"本模式不支持区域路径，请改用区域编辑模式。")
			return
	BM.preview_selected_item(objholder)
	deselect_region()

/datum/buildmode_mode/fill/handle_click(client/c, params, obj/object)
	if(isnull(objholder))
		to_chat(c, span_warning("请先选择一个对象类型。"))
		deselect_region()
		return
	..()

/datum/buildmode_mode/fill/handle_selected_area(client/c, params)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK)) //rectangular
		if(LAZYACCESS(modifiers, ALT_CLICK))
			var/list/deletion_area = block(get_turf(cornerA),get_turf(cornerB))
			for(var/beep in deletion_area)
				var/turf/T = beep
				for(var/atom/movable/AM in T)
					qdel(AM)
				// extreme haircut
				T.ScrapeAway(INFINITY, CHANGETURF_DEFER_CHANGE)
			for(var/beep in deletion_area)
				var/turf/T = beep
				T.AfterChange()
			log_admin("建造模式：[key_name(c)] 从 [AREACOORD(cornerA)] 到 [AREACOORD(cornerB)] 删除了地砖")
			// if there's an analogous proc for this on tg lmk
			// empty_region(block(get_turf(cornerA),get_turf(cornerB)))
		else
			var/selection_size = abs(cornerA.x - cornerB.x) * abs(cornerA.y - cornerB.y)

			if(selection_size > FILL_WARNING_MIN) // Confirm fill if the number of tiles in the selection is greater than FILL_WARNING_MIN
				var/choice = tgui_alert(usr,"你选择的区域有 [selection_size] 格！是否继续？", "大范围填充确认", list("Yes", "No"))
				if(choice != "Yes")
					return

			for(var/turf/T in block(get_turf(cornerA),get_turf(cornerB)))
				if(ispath(objholder,/turf))
					T = T.ChangeTurf(objholder)
					T.setDir(BM.build_dir)
				else if(ispath(objholder, /obj/effect/turf_decal))
					T.AddElement(/datum/element/decal, initial(objholder.icon), initial(objholder.icon_state), BM.build_dir, null, null, initial(objholder.alpha), initial(objholder.color), null, FALSE, null)
				else
					var/obj/A = new objholder(T)
					A.setDir(BM.build_dir)
			log_admin("建造模式：[key_name(c)] 使用路径 [objholder] 填充了从 [AREACOORD(cornerA)] 到 [AREACOORD(cornerB)] 的区域")

#undef FILL_WARNING_MIN
