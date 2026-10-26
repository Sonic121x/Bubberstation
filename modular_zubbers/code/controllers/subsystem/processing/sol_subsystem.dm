

PROCESSING_SUBSYSTEM_DEF(sunlight)
	name = "Sol"
	can_fire = FALSE
	runlevels = RUNLEVEL_GAME
	wait = 2 SECONDS
	ss_flags = SS_NO_INIT | SS_TICKER

	///If the Sun is currently out our not.
	var/sunlight_active = FALSE
	///The time between the next cycle, randomized every night.
	var/time_til_cycle = TIME_BLOODSUCKER_NIGHT_MAX
	///If Bloodsucker levels for the night has been given out yet.
	var/issued_XP = FALSE
	/// Mobs that make use of the sunlight system, doesn't use weakrefs as that makes removing them a pain, and we already cleanup on qdel.
	var/list/sun_sufferers = list()

/datum/controller/subsystem/processing/sunlight/fire(resumed = FALSE)
	time_til_cycle--
	if(sunlight_active)
		if(time_til_cycle > 0)
			SEND_SIGNAL(src, COMSIG_SOL_RISE_TICK)
			if(!issued_XP && time_til_cycle <= 15)
				issued_XP = TRUE
				SEND_SIGNAL(src, COMSIG_SOL_RANKUP_BLOODSUCKERS)
		if(time_til_cycle <= 1)
			sunlight_active = FALSE
			issued_XP = FALSE
			//randomize the next sol timer
			time_til_cycle = rand(TIME_BLOODSUCKER_NIGHT_MIN, TIME_BLOODSUCKER_NIGHT_MAX)
			message_admins("吸血鬼通知：白昼结束，重置为夜晚（持续 [time_til_cycle / 60] 分钟）。")
			SEND_SIGNAL(src, COMSIG_SOL_END)
			warn_daylight(
				danger_level = DANGER_LEVEL_SOL_ENDED,
				vampire_warning_message = span_announce("太阳耀斑已结束，白昼的危险暂时过去了……"),
				ghoul_warning_message = span_announce("太阳耀斑已结束，白昼的危险暂时过去了……"),
			)
		return ..()

	switch(time_til_cycle)
		if(TIME_BLOODSUCKER_DAY_WARN)
			SEND_SIGNAL(src, COMSIG_SOL_NEAR_START)
			warn_daylight(
				danger_level = DANGER_LEVEL_FIRST_WARNING,
				vampire_warning_message = span_danger("太阳耀斑将在 [TIME_BLOODSUCKER_DAY_WARN / 60] 分钟后以危险的紫外辐射轰击空间站。<b>准备躲进棺材或储物柜。</b>"),
			)
		if(TIME_BLOODSUCKER_DAY_FINAL_WARN)
			message_admins("吸血鬼通知：白昼将在 [TIME_BLOODSUCKER_DAY_FINAL_WARN] 秒后开始。")
			warn_daylight(
				danger_level = DANGER_LEVEL_SECOND_WARNING,
				vampire_warning_message = span_userdanger("太阳耀斑即将轰击空间站！你有 [TIME_BLOODSUCKER_DAY_FINAL_WARN] 秒寻找掩蔽处！"),
				ghoul_warning_message = span_danger("[TIME_BLOODSUCKER_DAY_FINAL_WARN] 秒后，你的主人将面临太阳耀斑的威胁。务必让主人找到掩蔽处！"),
			)
		if(TIME_BLOODSUCKER_BURN_INTERVAL)
			warn_daylight(
				danger_level = DANGER_LEVEL_THIRD_WARNING,
				vampire_warning_message = span_userdanger("太阳升起了，快找掩蔽处！"),
			)
		if(NONE)
			sunlight_active = TRUE
			//set the timer to countdown daytime now.
			time_til_cycle = TIME_BLOODSUCKER_DAY
			message_admins("吸血鬼通知：白昼开始（持续 [TIME_BLOODSUCKER_DAY / 60] 分钟）。")
			warn_daylight(
				danger_level = DANGER_LEVEL_SOL_ROSE,
				vampire_warning_message = span_userdanger("太阳耀斑正以致命的紫外线轰击空间站！接下来的 [TIME_BLOODSUCKER_DAY / 60] 分钟内请留在掩蔽处，否则可能迎来最终死亡！"),
				ghoul_warning_message = span_userdanger("太阳耀斑正以紫外线轰击空间站！"),
			)
	..()

/datum/controller/subsystem/processing/sunlight/proc/warn_daylight(danger_level, vampire_warning_message, ghoul_warning_message)
	SEND_SIGNAL(src, COMSIG_SOL_WARNING_GIVEN, danger_level, vampire_warning_message, ghoul_warning_message)

/datum/controller/subsystem/processing/sunlight/proc/add_sun_sufferer(mob/victim)
	if(is_sufferer(victim))
		return FALSE
	var/atom/movable/screen/bloodsucker/sunlight_counter/sun_hud = new(null, victim.hud_used)
	victim.hud_used.add_screen_object(sun_hud, null, HUD_GROUP_INFO)
	victim.hud_used.show_hud(victim.hud_used.hud_version)
	sun_hud.update_sol_hud()
	RegisterSignal(victim, COMSIG_QDELETING, PROC_REF(remove_sun_sufferer), victim)
	RegisterSignal(sun_hud, COMSIG_QDELETING, PROC_REF(remove_sun_sufferer), victim)
	sun_sufferers[victim] = sun_hud
	if(length(sun_sufferers))
		can_fire = TRUE
	return TRUE

/datum/controller/subsystem/processing/sunlight/proc/signal_remove_sun_sufferer(subsystem, mob/victim)
	remove_sun_sufferer(victim)

/datum/controller/subsystem/processing/sunlight/proc/remove_sun_sufferer(mob/victim)
	if(!is_sufferer(victim))
		return FALSE
	var/atom/movable/screen/bloodsucker/sunlight_counter/sun_hud = sun_sufferers[victim]
	var/datum/hud/hud_used = victim?.hud_used
	if(sun_hud)
		hud_used?.remove_screen_object(sun_hud)
		UnregisterSignal(sun_hud, COMSIG_QDELETING)
	sun_sufferers -= victim
	UnregisterSignal(victim, COMSIG_QDELETING)
	if(!length(sun_sufferers))
		can_fire = FALSE
		sunlight_active = initial(sunlight_active)
		time_til_cycle = initial(time_til_cycle)
		issued_XP = initial(issued_XP)
	return TRUE

/datum/controller/subsystem/processing/sunlight/proc/warn_notify(mob/target, danger_level, message)
	if(!target)
		return
	to_chat(target, message)

	switch(danger_level)
		if(DANGER_LEVEL_FIRST_WARNING)
			target.playsound_local(null, 'modular_zubbers/sound/bloodsucker/griffin_3.ogg', 50, TRUE)
		if(DANGER_LEVEL_SECOND_WARNING)
			target.playsound_local(null, 'modular_zubbers/sound/bloodsucker/griffin_5.ogg', 50, TRUE)
		if(DANGER_LEVEL_THIRD_WARNING)
			target.playsound_local(null, 'sound/effects/alert.ogg', 75, TRUE)
		if(DANGER_LEVEL_SOL_ROSE)
			target.playsound_local(null, 'sound/ambience/misc/ambimystery.ogg', 75, TRUE)
		if(DANGER_LEVEL_SOL_ENDED)
			target.playsound_local(null, 'sound/music/antag/bloodcult/ghosty_wind.ogg', 90, TRUE)

/datum/controller/subsystem/processing/sunlight/proc/is_sufferer(mob/victim)
	if(!sun_sufferers)
		CRASH("Sol subsystem sun_sufferers list is null, when it should never be.")
	if(isnull(victim) || !length(sun_sufferers))
		return FALSE

	if(sun_sufferers[victim])
		return TRUE
	return FALSE
