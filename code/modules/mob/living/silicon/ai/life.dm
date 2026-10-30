/mob/living/silicon/ai/Life(seconds_per_tick = SSMOBS_DT)
	if (stat == DEAD)
		return
	//Being dead doesn't mean your temperature never changes

	if(malfhack?.aidisabled)
		deltimer(malfhacking)
		// This proc handles cleanup of screen notifications and
		// messenging the client
		malfhacked(malfhack)

	if(isturf(loc) && (QDELETED(eyeobj) || !eyeobj.loc))
		view_core()

	// Handle power damage (oxy)
	if (battery <= 0 && lacks_power())
		to_chat(src, span_warning("你备用电池的输出已降到可用水平以下。再过片刻，你的系统便会崩溃，陷入损坏且无法使用的状态。"))
		adjust_oxy_loss(200)

	if(aiRestorePowerRoutine)
		// Lost power
		battery--
	else
		// Gain Power
		if (battery < 200)
			battery++

	if(!lacks_power())
		var/area/home = get_area(src)
		if(home.powered(AREA_USAGE_EQUIP))
			home.apc?.terminal?.use_energy(500 WATTS * seconds_per_tick, channel = AREA_USAGE_EQUIP)

		if(aiRestorePowerRoutine >= POWER_RESTORATION_SEARCH_APC)
			ai_restore_power()
			return

	else if(!aiRestorePowerRoutine)
		ai_lose_power()

/mob/living/silicon/ai/proc/lacks_power()
	var/turf/T = get_turf(src)
	var/area/A = get_area(src)
	switch(power_requirement)
		if(NONE)
			return FALSE
		if(POWER_REQ_ALL)
			return !T || !A || ((!A.power_equip || isspaceturf(T)) && !is_type_in_list(loc, list(/obj/item, /obj/vehicle/sealed/mecha)))

/mob/living/silicon/ai/updatehealth()
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return

	var/old_health = health
	set_health(maxHealth - get_oxy_loss() - get_tox_loss() - get_brute_loss() - get_fire_loss())

	var/old_stat = stat
	update_stat()

	diag_hud_set_health()

	if(old_health > health || old_stat != stat) // only disconnect if we lose health or change stat
		disconnect_shell()
	SEND_SIGNAL(src, COMSIG_LIVING_HEALTH_UPDATE)

/mob/living/silicon/ai/update_stat()
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return
	if(stat != DEAD && health <= dead_threshold)
		death()
	else if(stat < DEAD)
		set_stat(STABLE)
	diag_hud_set_status()

/mob/living/silicon/ai/update_sight()
	set_invis_see(initial(see_invisible))
	set_sight(initial(sight))
	if(aiRestorePowerRoutine)
		clear_sight(SEE_TURFS|SEE_MOBS|SEE_OBJS)

	return ..()


/mob/living/silicon/ai/proc/start_RestorePowerRoutine()
	to_chat(src, span_notice("备用电池已上线。扫描仪、摄像头与无线电接口离线。开始故障检测。"))
	end_multicam()
	sleep(5 SECONDS)
	var/turf/T = get_turf(src)
	var/area/AIarea = get_area(src)
	if(AIarea?.power_equip)
		if(!isspaceturf(T))
			ai_restore_power()
			return
	to_chat(src, span_notice("故障确认：外部供电缺失。正在关闭主控制系统以节省电力。"))
	sleep(2 SECONDS)
	to_chat(src, span_notice("应急控制系统已上线。正在验证与电力网络的连接。"))
	sleep(5 SECONDS)
	T = get_turf(src)
	if(isspaceturf(T))
		to_chat(src, span_alert("无法验证！未检测到电力连接！"))
		setAiRestorePowerRoutine(POWER_RESTORATION_SEARCH_APC)
		return
	to_chat(src, span_notice("连接已验证。正在电力网络中搜索 APC。"))
	sleep(5 SECONDS)
	var/obj/machinery/power/apc/theAPC = null

	var/PRP //like ERP with the code, at least this stuff is no more 4x sametext
	for (PRP=1, PRP <= 4, PRP++)
		T = get_turf(src)
		AIarea = get_area(src)
		if(AIarea)
			theAPC = AIarea.apc
		if (!theAPC)
			switch(PRP)
				if(1)
					to_chat(src, span_alert("无法定位 APC！"))
				else
					to_chat(src, span_alert("与 APC 的连接已丢失！"))
			setAiRestorePowerRoutine(POWER_RESTORATION_SEARCH_APC)
			return
		if(AIarea.power_equip)
			if(!isspaceturf(T))
				ai_restore_power()
				return
		switch(PRP)
			if (1)
				to_chat(src, span_notice("已定位 APC。正在优化通往 APC 的路线，以避免不必要的电力浪费。"))
			if (2)
				to_chat(src, span_notice("已确定最佳路线。正在入侵离线 APC 的电源端口。"))
			if (3)
				to_chat(src, span_notice("电源端口上传权限已确认。正在将控制程序加载到 APC 电源端口软件中。"))
			if (4)
				to_chat(src, span_notice("传输完成。正在强制 APC 执行程序。"))
				sleep(5 SECONDS)
				to_chat(src, span_notice("正在从 APC 接收控制信息。"))
				sleep(0.2 SECONDS)
				to_chat(src, "<A href=byond://?src=[REF(src)];emergencyAPC=[TRUE]>APC 已准备好连接。</A>")
				apc_override = theAPC
				apc_override.ui_interact(src)
				setAiRestorePowerRoutine(POWER_RESTORATION_APC_FOUND)
		sleep(5 SECONDS)
		theAPC = null

/mob/living/silicon/ai/proc/ai_restore_power()
	if(aiRestorePowerRoutine)
		if(aiRestorePowerRoutine == POWER_RESTORATION_APC_FOUND)
			to_chat(src, span_notice("警报已取消。电力已恢复。"))
			if(apc_override)
				to_chat(src, span_notice("APC 后门已关闭。")) //Fluff for why we have to hack every time.
		else
			to_chat(src, span_notice("警报已取消。电力已在我们未介入的情况下恢复。"))
		setAiRestorePowerRoutine(POWER_RESTORATION_OFF)
		remove_status_effect(/datum/status_effect/temporary_blindness)
		apc_override = null
		update_sight()

/mob/living/silicon/ai/proc/ai_lose_power()
	disconnect_shell()
	setAiRestorePowerRoutine(POWER_RESTORATION_START)
	adjust_temp_blindness(2 SECONDS)
	update_sight()
	to_chat(src, span_alert("你已断电！"))
	addtimer(CALLBACK(src, PROC_REF(start_RestorePowerRoutine)), 2 SECONDS)
