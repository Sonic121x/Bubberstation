/datum/tgs_event_handler/impl
	var/datum/timedevent/reattach_timer

/datum/tgs_event_handler/impl/HandleEvent(event_code, ...)
	switch(event_code)
		if(TGS_EVENT_REBOOT_MODE_CHANGE)
			var/list/reboot_mode_lookup = list ("[TGS_REBOOT_MODE_NORMAL]" = "正常重启", "[TGS_REBOOT_MODE_SHUTDOWN]" = "关闭服务器", "[TGS_REBOOT_MODE_RESTART]" = "强制重启服务器")
			var/old_reboot_mode = args[2]
			var/new_reboot_mode = args[3]
			message_admins("TGS：重启操作已从[reboot_mode_lookup["[old_reboot_mode]"]]改为[reboot_mode_lookup["[new_reboot_mode]"]]")
		if(TGS_EVENT_PORT_SWAP)
			message_admins("TGS：端口从[world.port]改为[args[2]]")
		if(TGS_EVENT_INSTANCE_RENAMED)
			message_admins("TGS：实例从[world.TgsInstanceName()]重命名为[args[2]]")
		if(TGS_EVENT_COMPILE_START)
			message_admins("TGS：部署已开始，新的游戏版本即将到来……")
		if(TGS_EVENT_COMPILE_CANCELLED)
			message_admins("TGS：部署已取消！")
		if(TGS_EVENT_COMPILE_FAILURE)
			message_admins("TGS：部署失败！")
		if(TGS_EVENT_DEPLOYMENT_COMPLETE)
			message_admins("TGS：部署完成！")
			to_chat(world, span_boldannounce("服务器已更新，更改将在下一轮生效……"))
		if(TGS_EVENT_WATCHDOG_DETACH)
			message_admins("TGS正在重启……")
			reattach_timer = addtimer(CALLBACK(src, PROC_REF(LateOnReattach)), 1 MINUTES, TIMER_STOPPABLE)
		if(TGS_EVENT_WATCHDOG_REATTACH)
			var/datum/tgs_version/old_version = world.TgsVersion()
			var/datum/tgs_version/new_version = args[2]
			if(!old_version.Equals(new_version))
				to_chat(world, span_boldannounce("TGS已更新至v[new_version.deprefixed_parameter]"))
			else
				message_admins("TGS：已恢复在线")
			if(reattach_timer)
				deltimer(reattach_timer)
				reattach_timer = null
		if(TGS_EVENT_WATCHDOG_SHUTDOWN)
			to_chat_immediate(world, span_boldannounce("服务器正在关闭！"))

/datum/tgs_event_handler/impl/proc/LateOnReattach()
	message_admins("警告：已经整整一分钟没有收到TGS恢复在线的通知！是否出现了问题？")
