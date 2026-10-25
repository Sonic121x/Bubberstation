/datum/round_event_control/aurora_caelus
	name = "天穹极光"
	typepath = /datum/round_event/aurora_caelus
	max_occurrences = 1
	weight = 1
	earliest_start = 5 MINUTES
	category = EVENT_CATEGORY_FRIENDLY
	description = "透过部分窗户可以看到一场绚丽的表演。厨房里也能看到。"

/datum/round_event_control/aurora_caelus/can_spawn_event(players, allow_magic = FALSE)
	if(!SSmapping.empty_space)
		return FALSE
	return ..()

/datum/round_event/aurora_caelus
	announce_when = 1
	start_when = 21
	end_when = 80

/datum/round_event/aurora_caelus/announce(fake)
	priority_announce("[station_name()]：一团无害的离子云正在接近你的空间站，其能量将在冲击船体时消耗殆尽。纳米传讯已批准全体员工短暂休息，以放松并观赏这一极其罕见的现象。在此期间，星光将明亮而柔和，在宁静的绿色与蓝色之间变换。任何想亲眼观看这些光芒的员工，都可以前往附近设有朝向太空观察窗的区域。希望你们喜欢这片光芒。",
	sound = 'sound/announcer/notice/notice2.ogg',
	sender_override = "纳米传讯气象部")
	if (fake)
		return
	for(var/V in GLOB.player_list)
		var/mob/M = V
		var/pref_volume = M.client.prefs.read_preference(/datum/preference/numeric/volume/sound_midi)
		if(pref_volume > 0 && is_station_level(M.z))
			M.playsound_local(M, 'sound/ambience/aurora_caelus/aurora_caelus.ogg', 20 * (pref_volume/100), FALSE, pressure_affected = FALSE)
	fade_space(fade_in = TRUE)
	fade_kitchen(fade_in = TRUE)

/datum/round_event/aurora_caelus/start()
	if(!prob(1) && !check_holidays(APRIL_FOOLS))
		return

	var/list/human_blacklist = list()
	for(var/area/station/service/kitchen/affected_area in GLOB.areas)
		var/obj/machinery/oven/roast_ruiner = locate() in affected_area
		if(roast_ruiner)
			roast_ruiner.balloon_alert_to_viewers("哦，天哪！")
			var/turf/ruined_roast = get_turf(roast_ruiner)
			ruined_roast.atmos_spawn_air("[GAS_PLASMA]=100;[TURF_TEMPERATURE(1000)]")
			message_admins("天穹极光事件导致 [ADMIN_VERBOSEJMP(ruined_roast)] 处的烤箱起火了。")
			log_game("天穹极光事件导致 [loc_name(ruined_roast)] 处的烤箱起火。")
			announce_to_ghosts(roast_ruiner)
			for(var/mob/living/carbon/human/seymour in viewers(7, roast_ruiner))
				if (seymour in human_blacklist)
					continue
				human_blacklist += seymour
				if(seymour.mind && istype(seymour.mind.assigned_role, /datum/job/cook))
					seymour.say("我的烤肉全毁了！！！", forced = "ruined roast")
					seymour.emote("scream")

/datum/round_event/aurora_caelus/tick()
	if(activeFor % 8 != 0)
		return
	var/aurora_color = hsl_gradient((activeFor - start_when) / (end_when - start_when), 0, "#A2FF80", 1, "#A2FFEE")
	set_starlight(aurora_color)

	for(var/area/station/service/kitchen/affected_area in GLOB.areas)
		for(var/turf/open/kitchen_floor in affected_area.get_turfs_from_all_zlevels())
			kitchen_floor.set_light(l_color = aurora_color)

/datum/round_event/aurora_caelus/end()
	fade_space()
	fade_kitchen()
	priority_announce("天穹极光现象即将结束。星光条件将逐步恢复正常。待其完全结束后，请返回各自的工作岗位照常工作。祝你们值班愉快，[station_name()]，也感谢你们与我们一起观赏。",
	sound = 'sound/announcer/notice/notice2.ogg',
	sender_override = "纳米传讯气象部")

/datum/round_event/aurora_caelus/proc/fade_space(fade_in = FALSE)
	set waitfor = FALSE
	// iterate all glass tiles
	var/start_color = hsl_gradient(1, 0, "#A2FF80", 1, "#A2FFEE")
	var/start_range = GLOB.starlight_range * 1.75
	var/start_power = GLOB.starlight_power * 0.6
	var/end_color = GLOB.base_starlight_color
	var/end_range = GLOB.starlight_range
	var/end_power = GLOB.starlight_power
	if(fade_in)
		end_color = hsl_gradient(0, 0, "#A2FF80", 1, "#A2FFEE")
		end_range = start_range
		end_power = start_power
		start_color = GLOB.base_starlight_color
		start_range = GLOB.starlight_range
		start_power = GLOB.starlight_power

	for(var/i in 1 to 5)
		var/walked_color = hsl_gradient(i/5, 0, start_color, 1, end_color)
		var/walked_range = LERP(start_range, end_range, i/5)
		var/walked_power = LERP(start_power, end_power, i/5)
		set_starlight(walked_color, walked_range, walked_power)
		sleep(8 SECONDS)
	set_starlight(end_color, end_range, end_power)

/datum/round_event/aurora_caelus/proc/fade_kitchen(fade_in = FALSE)
	set waitfor = FALSE
	var/start_color = hsl_gradient(1, 0, "#A2FF80", 1, "#A2FFEE")
	var/start_range = 1
	var/start_power = 0.75
	var/end_color = COLOR_BLACK
	var/end_range = 0.5
	var/end_power = 0
	if(fade_in)
		end_color = hsl_gradient(0, 0, "#A2FF80", 1, "#A2FFEE")
		end_range = start_range
		end_power = start_power
		start_color = COLOR_BLACK
		start_range = 0.5
		start_power = 0

	for(var/i in 1 to 5)
		var/walked_color = hsl_gradient(i/5, 0, start_color, 1, end_color)
		var/walked_range = LERP(start_range, end_range, i/5)
		var/walked_power = LERP(start_power, end_power, i/5)
		for(var/area/station/service/kitchen/affected_area in GLOB.areas)
			for(var/turf/open/kitchen_floor in affected_area.get_turfs_from_all_zlevels())
				kitchen_floor.set_light(walked_range, walked_power, walked_color)
		sleep(8 SECONDS)
	for(var/area/station/service/kitchen/affected_area in GLOB.areas)
		for(var/turf/open/kitchen_floor in affected_area.get_turfs_from_all_zlevels())
			kitchen_floor.set_light(end_range, end_power, end_color)
