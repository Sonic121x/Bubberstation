ADMIN_VERB_VISIBILITY(debug_air_status, ADMIN_VERB_VISIBLITY_FLAG_MAPPING_DEBUG)

ADMIN_VERB(debug_air_status, R_DEBUG, "调试空气状态" , ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_TURF, VERB_ARG_SOURCE_WORLD, /turf)
	atmos_scan(user.mob, target, silent = TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Show Air Status")

ADMIN_VERB_VISIBILITY(fix_next_move, ADMIN_VERB_VISIBLITY_FLAG_MAPPING_DEBUG)
ADMIN_VERB(fix_next_move, R_DEBUG, "修复下次移动", "解除所有被冻结生物的移动限制。", ADMIN_CATEGORY_DEBUG)
	var/largest_move_time = 0
	var/largest_click_time = 0
	var/mob/largest_move_mob = null
	var/mob/largest_click_mob = null
	for(var/mob/frozen_mob as anything in GLOB.player_list)
		if(frozen_mob.next_move >= largest_move_time)
			largest_move_mob = frozen_mob
			if(frozen_mob.next_move > world.time)
				largest_move_time = frozen_mob.next_move - world.time
			else
				largest_move_time = 1
		if(frozen_mob.next_click >= largest_click_time)
			largest_click_mob = frozen_mob
			if(frozen_mob.next_click > world.time)
				largest_click_time = frozen_mob.next_click - world.time
			else
				largest_click_time = 0
		log_admin("DEBUG: [key_name(frozen_mob)]  next_move = [frozen_mob.next_move]  lastDblClick = [frozen_mob.next_click]  world.time = [world.time]")
		frozen_mob.next_move = 1
		frozen_mob.next_click = 0
	message_admins("[ADMIN_LOOKUPFLW(largest_move_mob)] 的移动延迟最大，为 [largest_move_time] 帧 / [DisplayTimeText(largest_move_time)]！")
	message_admins("[ADMIN_LOOKUPFLW(largest_click_mob)] 的点击延迟最大，为 [largest_click_time] 帧 / [DisplayTimeText(largest_click_time)]！")
	message_admins("world.time = [world.time]")
	BLACKBOX_LOG_ADMIN_VERB("Unfreeze Everyone")

ADMIN_VERB_VISIBILITY(radio_report, ADMIN_VERB_VISIBLITY_FLAG_MAPPING_DEBUG)
ADMIN_VERB(radio_report, R_DEBUG, "无线电报告", "显示所有无线电设备及其过滤器的报告。", ADMIN_CATEGORY_DEBUG)
	var/output = "<b>无线电报告</b><hr>"
	for (var/fq in SSradio.frequencies)
		output += "<b>频率：[fq]</b><br>"
		var/datum/radio_frequency/fqs = SSradio.frequencies[fq]
		if (!fqs)
			output += "&nbsp;&nbsp;<b>错误</b><br>"
			continue
		for (var/filter in fqs.devices)
			var/list/filtered = fqs.devices[filter]
			if (!filtered)
				output += "&nbsp;&nbsp;[filter]：错误<br>"
				continue
			output += "&nbsp;&nbsp;[filter]：[filtered.len]<br>"
			for(var/datum/weakref/device_ref as anything in filtered)
				var/atom/device = device_ref.resolve()
				if(!device)
					filtered -= device_ref
					continue
				if (istype(device, /atom))
					var/atom/A = device
					output += "&nbsp;&nbsp;&nbsp;&nbsp;[device] ([AREACOORD(A)])<br>"
				else
					output += "&nbsp;&nbsp;&nbsp;&nbsp;[device]<br>"

	var/datum/browser/browser = new(user, "radioreport", "无线电日志", 400, 440)
	browser.set_content(output)
	browser.open()
	BLACKBOX_LOG_ADMIN_VERB("Show Radio Report")

ADMIN_VERB(reload_admins, R_NONE, "重新加载管理员", "从数据库重新加载所有管理员。", ADMIN_CATEGORY_MAIN)
	var/confirm = tgui_alert(user, "确定要重新加载所有管理员吗？", "确认", list("Yes", "No"))
	if(confirm != "Yes")
		return

	load_admins()
	BLACKBOX_LOG_ADMIN_VERB("Reload All Admins")
	message_admins("[key_name_admin(user)] 手动重新加载了管理员")

ADMIN_VERB(toggle_cdn, R_SERVER|R_DEBUG, "切换 CDN", "切换服务器的 CDN。", ADMIN_CATEGORY_SERVER)
	var/static/admin_disabled_cdn_transport = null
	if (alert(user, "确定要切换 CDN 资源传输吗？", "确认", "Yes", "No") != "Yes")
		return
	var/current_transport = CONFIG_GET(string/asset_transport)
	if (!current_transport || current_transport == "simple")
		if (admin_disabled_cdn_transport)
			CONFIG_SET(string/asset_transport, admin_disabled_cdn_transport)
			admin_disabled_cdn_transport = null
			SSassets.OnConfigLoad()
			message_admins("[key_name_admin(user)] 重新启用了 CDN 资源传输")
			log_admin("[key_name(user)] 重新启用了 CDN 资源传输")
		else
			to_chat(user, span_adminnotice("CDN 未启用！"))
			if (tgui_alert(user, "CDN 资源传输未启用！如果你遇到资源问题，也可以尝试禁用文件名变换。", "CDN 资源传输未启用！", list("Try disabling filename mutations", "Nevermind")) == "Try disabling filename mutations")
				SSassets.transport.dont_mutate_filenames = !SSassets.transport.dont_mutate_filenames
				message_admins("[key_name_admin(user)] [(SSassets.transport.dont_mutate_filenames ? "禁用" : "重新启用")]了资源文件名变换")
				log_admin("[key_name(user)] [(SSassets.transport.dont_mutate_filenames ? "禁用" : "重新启用")]了资源文件名变换")
	else
		admin_disabled_cdn_transport = current_transport
		CONFIG_SET(string/asset_transport, "simple")
		SSassets.OnConfigLoad()
		message_admins("[key_name_admin(user)] 禁用了 CDN 资源传输")
		log_admin("[key_name(user)] 禁用了 CDN 资源传输")
