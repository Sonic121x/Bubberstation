/// Helper to open the panel
/datum/lootpanel/proc/open(turf/tile)
	if (tile != source_turf)
		if (source_turf)
			UnregisterSignal(source_turf, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON))
		RegisterSignals(tile, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON), PROC_REF(on_source_turf_entered))

	source_turf = tile

#if !defined(OPENDREAM) && !defined(UNIT_TESTS)
	if(!notified)
		var/build = owner.byond_build
		var/version = owner.byond_version
		if(build < 515 || (build == 515 && version < 1635))
			to_chat(owner.mob, boxed_message(span_info("\
				<span class='bolddanger'>你的 BYOND 版本不支持快速图像加载。</span>\n\
				检测到：[version].[build]\n\
				此功能所需版本：<b>515.1635</b> 或更高。\n\
				请访问 <a href=\"https://secure.byond.com/download\">BYOND 官方网站</a> 获取最新版 BYOND。\n\
			")))

			notified = TRUE
#endif

	populate_contents()
	ui_interact(owner.mob)


/**
 * Called by SSlooting whenever this datum is added to its backlog.
 * Iterates over to_image list to create icons, then removes them.
 * Returns boolean - whether this proc has finished the queue or not.
 */
/datum/lootpanel/proc/process_images()
	for(var/datum/search_object/index as anything in to_image)
		to_image -= index

		if(QDELETED(index) || index.icon)
			continue

		index.generate_icon(owner)

		if(TICK_CHECK)
			break

	var/datum/tgui/window = SStgui.get_open_ui(owner.mob, src)
	if(isnull(window))
		reset_contents()
		return TRUE

	window.send_update()

	return !length(to_image)
