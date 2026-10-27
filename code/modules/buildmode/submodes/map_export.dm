/datum/buildmode_mode/map_export
	key = "mapexport"
	use_corner_selection = TRUE
	/// Variable with the flag value to understand how to treat the shuttle zones.
	var/shuttle_flag = SAVE_SHUTTLEAREA_DONTCARE
	/// Variable with a flag value to indicate what should be saved (for example, only objects or only mobs).
	var/save_flag = ALL

/datum/buildmode_mode/map_export/change_settings(client/builder)
	var/static/list/options = list(
		"Object Saving" = SAVE_OBJECTS,
		"Mob Saving" = SAVE_MOBS,
		"Turf Saving" = SAVE_TURFS,
		"Area Saving" = SAVE_AREAS,
		"Space Turf Saving" = SAVE_SPACE,
		"Object Property Saving" = SAVE_OBJECT_PROPERTIES,
		"Atmos Saving" = SAVE_ATMOS,
	)
	var/what_to_change = tgui_input_list(builder, "你想切换哪项导出设置？", "地图导出器", options)
	if (!what_to_change)
		return
	save_flag ^= options[what_to_change]
	to_chat(builder, span_notice("[what_to_change] 现已 [save_flag & options[what_to_change] ? "启用" : "禁用"]。"))

/datum/buildmode_mode/map_export/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("选择对角")] -> 在 obj/turf/mob 上按鼠标左键\n\
		[span_bold("设置导出选项")] -> 在建造模式按钮上按鼠标右键"))
	)

/datum/buildmode_mode/map_export/handle_selected_area(client/builder, params)
	var/list/listed_params = params2list(params)
	var/left_click = listed_params.Find("left")

	//Ensure the selection is actually done
	if(!left_click)
		to_chat(builder, span_warning("无效的选择。"))
		return

	//If someone somehow gets build mode, stop them from using this.
	if(!check_rights(R_DEBUG))
		message_admins("[ckey(builder)] 试图运行地图保存生成器，但因权限不足被拒绝。")
		to_chat(builder, span_warning("你必须拥有 +ADMIN 权限才能使用此功能。"))
		return
	//Emergency check
	if(get_dist(cornerA, cornerB) > 60 || cornerA.z != cornerB.z)
		var/confirm = tgui_alert(builder, "确定要这样做吗？导出大地图可能要花很长时间。", "地图导出器", list("Yes", "No"))
		if(confirm != "Yes")
			return

	if(cornerA == cornerB)
		return

	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(_save_map), cornerA, cornerB, save_flag, shuttle_flag)

/// A guard variable to prevent more than one map export process from occurring at the same time.
GLOBAL_VAR_INIT(map_writing_running, FALSE)
/// Hey bud don't call this directly, it exists so we can invoke async and prevent the buildmode datum being qdel'd from halting this proc
/proc/_save_map(turf/cornerA, turf/cornerB, save_flag, shuttle_flag)
	if(!check_rights(R_DEBUG))
		message_admins("[ckey(usr)] 试图运行地图保存生成器，但因权限不足被拒绝。")
		to_chat(usr, span_warning("你必须拥有 +ADMIN 权限才能使用此功能。"))
		return
	if(GLOB.map_writing_running)
		to_chat(usr, span_warning("已经有人在运行生成器了！请稍后再试。"))
		return

	to_chat(usr, span_warning("正在保存，请稍等……"))
	GLOB.map_writing_running = TRUE

	//I put this before the actual saving of the map because it likely won't log if it crashes the fucking server
	log_admin("建造模式：[key_name(usr)] 正在导出从 [AREACOORD(cornerA)] 到 [AREACOORD(cornerB)] 的地图区域")

	//oversimplified for readability and understandibility

	var/minx = min(cornerA.x, cornerB.x)
	var/miny = min(cornerA.y, cornerB.y)
	var/minz = min(cornerA.z, cornerB.z)

	var/maxx = max(cornerA.x, cornerB.x)
	var/maxy = max(cornerA.y, cornerB.y)
	var/maxz = max(cornerA.z, cornerB.z)

	//Step 1: Get the data (This can take a while)
	var/dat = write_map(minx, miny, minz, maxx, maxy, maxz, save_flag, shuttle_flag)

	//Step 2: Write the data to a file and give map to client
	var/date = time2text(world.timeofday, "YYYY-MM-DD_hh-mm-ss", TIMEZONE_UTC)
	var/file_name = sanitize_filename(tgui_input_text(usr, "文件名？", "地图导出器", "exported_map_[date]"))
	send_exported_map(usr, file_name, dat)
	to_chat(usr, span_green("地图已成功保存！"))
	GLOB.map_writing_running = FALSE
