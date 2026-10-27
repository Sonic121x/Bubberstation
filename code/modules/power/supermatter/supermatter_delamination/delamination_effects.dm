#define DELAM_MAX_DEVASTATION 17.5

// These are supposed to be discrete effects so we can tell at a glance what does each override
// of [/datum/sm_delam/proc/delaminate] does.
// Please keep them discrete and give them proper, descriptive function names.
// Oh and all of them returns true if the effect succeeded.

/// Irradiates mobs around 20 tiles of the sm.
/// Just the mobs apparently.
/datum/sm_delam/proc/effect_irradiate(obj/machinery/power/supermatter_crystal/sm)
	var/turf/sm_turf = get_turf(sm)
	for (var/mob/living/victim in range(DETONATION_RADIATION_RANGE, sm))
		if(!is_valid_z_level(get_turf(victim), sm_turf))
			continue
		if(victim.z == 0)
			continue
		SSradiation.irradiate(victim)
	return TRUE

/// Hallucinates and makes mobs in Z level sad.
/datum/sm_delam/proc/effect_demoralize(obj/machinery/power/supermatter_crystal/sm)
	var/turf/sm_turf = get_turf(sm)
	for(var/mob/living/victim as anything in GLOB.alive_mob_list)
		if(!istype(victim) || !is_valid_z_level(get_turf(victim), sm_turf))
			continue
		if(victim.z == 0)
			continue

		//Hilariously enough, running into a closet should make you get hit the hardest.
		//duration between min and max, calculated by distance from the supermatter and size of the delam explosion
		var/hallucination_amount = LERP(DETONATION_HALLUCINATION_MIN, DETONATION_HALLUCINATION_MAX, 1 - get_dist(victim, sm) / 128) * LERP(0.75, 1.25, calculate_explosion(sm) * 0.5 / DELAM_MAX_DEVASTATION)
		victim.adjust_hallucinations(hallucination_amount)

	for(var/mob/victim as anything in GLOB.player_list)
		var/turf/victim_turf = get_turf(victim)
		if(!is_valid_z_level(victim_turf, sm_turf))
			continue
		victim.playsound_local(victim_turf, 'sound/effects/magic/charge.ogg')
		if(victim.z == 0) //victim is inside an object, this is to maintain an old bug turned feature with lockers n shit i guess. tg issue #69687
			var/message = ""
			var/location = victim.loc
			if(istype(location, /obj/structure/disposalholder)) // sometimes your loc can be a disposalsholder when you're inside a disposals type, so let's just pass a message that makes sense.
				message = "现实本身在扭曲，你听到周围垃圾管道里传来密集的哗啦声。不过，你感到很安全。"
			else
				message = "现实在你周围扭曲，你死死抓住 \the [victim.loc]。你感到很安全。"
			to_chat(victim, span_bolddanger(message))
			continue
		to_chat(victim, span_bolddanger("你感到现实在瞬间扭曲了……"))
		if (isliving(victim))
			var/mob/living/living_victim = victim
			living_victim.add_mood_event("delam", /datum/mood_event/delam)
	return TRUE

/// Spawns anomalies all over the station. Half instantly, the other half over time.
/datum/sm_delam/proc/effect_anomaly(obj/machinery/power/supermatter_crystal/sm)
	var/anomalies = 10
	var/list/anomaly_types = list(GRAVITATIONAL_ANOMALY = 55, HALLUCINATION_ANOMALY = 45, DIMENSIONAL_ANOMALY = 35, BIOSCRAMBLER_ANOMALY = 35, FLUX_ANOMALY = 25, PYRO_ANOMALY = 5, VORTEX_ANOMALY = 1)
	var/list/anomaly_places = GLOB.generic_event_spawns

	// Spawns this many anomalies instantly. Spawns the rest with callbacks.
	var/cutoff_point = round(anomalies * 0.5, 1)

	for(var/i in 1 to anomalies)
		var/anomaly_to_spawn = pick_weight(anomaly_types)
		var/anomaly_location = pick_n_take(anomaly_places)

		if(i < cutoff_point)
			supermatter_anomaly_gen(anomaly_location, anomaly_to_spawn, has_changed_lifespan = FALSE)
			continue

		var/current_spawn = rand(5 SECONDS, 10 SECONDS)
		var/next_spawn = rand(5 SECONDS, 10 SECONDS)
		var/extended_spawn = 0
		if(SPT_PROB(1, next_spawn))
			extended_spawn = rand(5 MINUTES, 15 MINUTES)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(supermatter_anomaly_gen), anomaly_location, anomaly_to_spawn, TRUE), current_spawn + extended_spawn)
	return TRUE

/// Explodes
/datum/sm_delam/proc/effect_explosion(obj/machinery/power/supermatter_crystal/sm)
	var/turf/sm_turf = get_turf(sm)
	explosion(origin = sm_turf,
		devastation_range = calculate_explosion(sm) * 0.5, // max 17.5
		heavy_impact_range = calculate_explosion(sm) + 2, // max 37
		light_impact_range = calculate_explosion(sm) + 4, // max 39
		flash_range = calculate_explosion(sm) + 6, //max 41
		adminlog = TRUE,
		ignorecap = TRUE
	)
	return TRUE

/datum/sm_delam/proc/calculate_explosion(obj/machinery/power/supermatter_crystal/sm)
	return sm.explosion_power * max(sm.gas_heat_power_generation, 0.205)

/// Spawns a scrung and eat the SM.
/datum/sm_delam/proc/effect_singulo(obj/machinery/power/supermatter_crystal/sm)
	var/turf/sm_turf = get_turf(sm)
	if(!sm_turf)
		stack_trace("Supermatter [sm] failed to spawn singularity, cant get current turf.")
		return FALSE
	var/obj/singularity/created_singularity = new(sm_turf)
	created_singularity.energy = 800
	created_singularity.consume(sm)
	return TRUE

/// Teslas
/datum/sm_delam/proc/effect_tesla(obj/machinery/power/supermatter_crystal/sm)
	var/turf/sm_turf = get_turf(sm)
	if(!sm_turf)
		stack_trace("Supermatter [sm] failed to spawn tesla, cant get current turf.")
		return FALSE
	var/obj/energy_ball/created_tesla = new(sm_turf)
	created_tesla.energy = 200 //Gets us about 9 balls
	return TRUE

/// Mail the shuttle off to buy milk.
/datum/sm_delam/proc/effect_strand_shuttle()
	set waitfor = FALSE
	// set timer to infinity, so shuttle never arrives
	SSshuttle.emergency.setTimer(INFINITY)
	// disallow shuttle recalls, so people cannot cheese the timer
	SSshuttle.emergency_no_recall = TRUE
	// set supermatter cascade to true, to prevent auto evacuation due to no way of calling the shuttle
	SSshuttle.supermatter_cascade = TRUE
	// set hijack completion timer to infinity, so that you cant prematurely end the round with a hijack
	for(var/obj/machinery/computer/emergency_shuttle/console as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/computer/emergency_shuttle))
		console.hijack_completion_flight_time_set = INFINITY

	/* This logic is to keep uncalled shuttles uncalled
	In SSshuttle, there is not much of a way to prevent shuttle calls, unless we mess with admin panel vars
	SHUTTLE_STRANDED is different here, because it *can* block the shuttle from being called, however if we don't register a hostile
	environment, it gets unset immediately. Internally, it checks if the count of HEs is zero
	and that the shuttle is in stranded mode, then frees it with an announcement.
	This is a botched solution to a problem that could be solved with a small change in shuttle code, however-
	*/
	if(SSshuttle.emergency.mode == SHUTTLE_IDLE)
		SSshuttle.emergency.mode = SHUTTLE_STRANDED
		SSshuttle.registerHostileEnvironment(src)
		return

	// say goodbye to that shuttle of yours
	if(SSshuttle.emergency.mode != SHUTTLE_ESCAPE)
		priority_announce(
			text = "紧急穿梭机上链路在航行途中发生致命错误。无法重建连接。",
			title = "穿梭机故障",
			sound = ANNOUNCER_SHUTTLE, // SKYRAT EDIT CHANGE - Announcer Sounds - ORIGINAL: sound = 'sound/announcer/announcement/announce_dig.ogg',
			sender_override = "紧急穿梭机上链警报",
			color_override = "grey",
		)
	else
	// except if you are on it already, then you are safe c:
		minor_announce("错误：导航协议中检测到损坏。与应答机 #XCC-P5831-ES13 的连接已丢失。 \
				备份撤离路线协议已解密。正在校准路线……",
			"紧急穿梭机", TRUE) // wait out until the rift on the station gets destroyed and the final message plays
		var/list/mobs = mobs_in_area_type(list(/area/shuttle/escape))
		for(var/mob/living/mob as anything in mobs) // emulate mob/living/lateShuttleMove() behaviour
			if(mob.buckled)
				continue
			if(mob.client)
				shake_camera(mob, 3 SECONDS * 0.25, 1)
			mob.Paralyze(3 SECONDS, TRUE)

/datum/sm_delam/proc/effect_cascade_demoralize()
	for(var/mob/player as anything in GLOB.player_list)
		if(!isdead(player))
			var/mob/living/living_player = player
			to_chat(player, span_bolddanger("你周围的一切都在与一股强大的能量共振。这可不是什么好事。"))
			living_player.add_mood_event("cascade", /datum/mood_event/cascade)
		SEND_SOUND(player, 'sound/effects/magic/charge.ogg')

/datum/sm_delam/proc/effect_emergency_state()
	if(SSsecurity_level.get_current_level_as_number() != SEC_LEVEL_DELTA)
		SSsecurity_level.set_level(SEC_LEVEL_DELTA) // skip the announcement and shuttle timer adjustment in set_security_level()
	make_maint_all_access()
	for(var/obj/machinery/light/light_to_break as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/light))
		if(prob(35))
			light_to_break.set_major_emergency_light()
			continue
		light_to_break.break_light_tube()

/// Spawn an evacuation rift for people to go through.
/datum/sm_delam/proc/effect_evac_rift_start()
	var/obj/cascade_portal/rift = new /obj/cascade_portal(get_turf(pick(GLOB.generic_event_spawns)))
	priority_announce("我们遭到了一次全星区范围的电磁脉冲打击。我们所有系统都严重受损，包括那些 \
		进行穿梭机导航所必需的。我们只能合理推断：你们的空间站上或附近正在发生超物质级联。\n\n\
		常规手段的撤离已不可能；不过，我们在 [get_area_name(rift)] 附近打开了一道裂隙。 \
		现要求所有人员以任何可用手段进入该裂隙。\n\n\
		[Gibberish("在必要设施恢复后，我们将执行幸存者回收。", FALSE, 5)] \
		[Gibberish("祝你们好运——", FALSE, 25)]")
	return rift

/// Announce the destruction of the rift and end the round.
/datum/sm_delam/proc/effect_evac_rift_end()
	priority_announce("[Gibberish("裂隙已被摧毁，我们再也无法帮助你们了。", FALSE, 5)]")

	sleep(25 SECONDS)

	priority_announce("报告显示，共振偏移事件后形成了晶体种子。 \
		晶体团块正随着引力增强而成比例地迅速扩张。 \
		可以预见物质将因引力吸引而坍缩。",
		"纳米传讯星象观测协会")

	sleep(25 SECONDS)

	priority_announce("[Gibberish("所有撤离尝试现已停止，我们已从你们的星区回收全部资产。\n \
		致 [station_name()] 仅存的幸存者：永别了。", FALSE, 5)]")

	if(SSshuttle.emergency.mode == SHUTTLE_ESCAPE)
		// special message for hijacks
		var/shuttle_msg = "导航协议已设为[SSshuttle.emergency.is_hijacked() ? "\[错误\]" : "备份路线"]。 \
			正在将蓝空间载具转向出口矢量。预计抵达时间 15 秒。"
		// garble the special message
		if(SSshuttle.emergency.is_hijacked())
			shuttle_msg = Gibberish(shuttle_msg, TRUE, 15)
		minor_announce(shuttle_msg, "紧急穿梭机", TRUE)
		SSshuttle.emergency.setTimer(15 SECONDS)
		return

	sleep(10 SECONDS)

	SSticker.news_report = SUPERMATTER_CASCADE
	SSticker.force_ending = FORCE_END_ROUND

/// Scatters crystal mass over the event spawns as long as they are at least 30 tiles away from whatever we want to avoid.
/datum/sm_delam/proc/effect_crystal_mass(obj/machinery/power/supermatter_crystal/sm, avoid)
	new /obj/crystal_mass(get_turf(sm))
	var/list/possible_spawns = GLOB.generic_event_spawns.Copy()
	for(var/i in 1 to rand(4,6))
		var/spawn_location
		do
			spawn_location = pick_n_take(possible_spawns)
		while(get_dist(spawn_location, avoid) < 30)
		new /obj/crystal_mass(get_turf(spawn_location))

#undef DELAM_MAX_DEVASTATION
