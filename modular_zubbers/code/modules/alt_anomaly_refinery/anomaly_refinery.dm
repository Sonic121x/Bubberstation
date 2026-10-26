#define REFINERY_ANOMALY_REFINEMENT_TIME (5 SECONDS)
#define REFINERY_ANOMALY_POWER_REQUIREMENT (1.21 MEGA WATTS) //This is NOT active power use. This is the amount of power it uses for a second when a bomb is detonated. This is about the same a stable SM generates in a second.

/obj/machinery/research/anomaly_refinery
	desc = "配备尖端炸弹预测软件的先进机器，能够通过内爆将原始异常核心压缩为成品。\
	内置耗电量巨大的稳定与消音力场，以免震动和噪声传遍全站，吵醒宿舍里的人。"
	var/requirement_timer
	var/requirement_mod = 0 //0 to 100. Decreases by 1 every 5 seconds. Increased by 40 after a test.

/obj/machinery/research/anomaly_refinery/examine(mob/user)
	. = ..()
	. += span_notice("使用这台机器会提高下一次实验所需的爆炸范围。")
	. += span_notice("使用时需要电网提供<b>[display_power(REFINERY_ANOMALY_POWER_REQUIREMENT)]</b>的功率。")
	. += span_notice("每次核心精炼需要<b>[DisplayTimeText(REFINERY_ANOMALY_REFINEMENT_TIME,1)]</b>完成。")

/obj/machinery/research/anomaly_refinery/get_required_radius(anomaly_type)
	. = ..()
	if(!isnum(.))
		return
	. *= 0.25 + (requirement_mod/100)*0.75

/obj/machinery/research/anomaly_refinery/start_test()

	if(active)
		say("错误：压缩测试已在进行中。")
		return

	if(!istype(inserted_core) || !istype(inserted_bomb))
		end_test("错误：设备缺失。物品已弹出。")
		return

	if(!inserted_bomb?.tank_one || !inserted_bomb?.tank_two || !(tank_to_target == inserted_bomb?.tank_one || tank_to_target == inserted_bomb?.tank_two))
		end_test("错误：转移阀故障。物品已弹出。")
		return

	if(!use_power_from_net(REFINERY_ANOMALY_POWER_REQUIREMENT))
		say("错误：电网供电不足，无法安全压缩核心。")
		return

	say("开始压缩测试。正在打开转移阀。")
	active = TRUE
	test_status = null

	if (obj_flags & EMAGGED)
		say("错误：启动过程中检测到固件问题。正在运行自动修补程序。")
		playsound(src, 'sound/machines/ding.ogg', 50, vary = TRUE)
		addtimer(CALLBACK(src, PROC_REF(error_test)), 2 SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_NO_HASH_WAIT) // Synced with the sound.
		return

	inserted_bomb.toggle_valve(tank_to_target)

	requirement_mod = min(requirement_mod + 20, 100) + round(REFINERY_ANOMALY_REFINEMENT_TIME/5,1)

	timeout_timer = addtimer(CALLBACK(src, PROC_REF(timeout_test)), REFINERY_ANOMALY_REFINEMENT_TIME, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME | TIMER_NO_HASH_WAIT)
	requirement_timer = addtimer(CALLBACK(src, PROC_REF(remove_requirement)), 5 SECONDS, TIMER_UNIQUE | TIMER_STOPPABLE | TIMER_DELETE_ME | TIMER_NO_HASH_WAIT | TIMER_LOOP)

	say("正在精炼核心。预计[DisplayTimeText(REFINERY_ANOMALY_REFINEMENT_TIME,1)]后完成。")

	playsound(
		src,
		pick('sound/effects/explosion/explosion1.ogg','sound/effects/explosion/explosion2.ogg','sound/effects/explosion/explosion3.ogg'),
		50
	)

	return

/obj/machinery/research/anomaly_refinery/proc/remove_requirement()

	requirement_mod = max(0,requirement_mod-1)

	if(requirement_mod <= 0)
		deltimer(requirement_timer)
		requirement_timer = null
		playsound(
			src,
			pick('modular_zubbers/sound/arcade/minesweeper_boardpress.ogg'),
			50
		)
		say("异常稳定性现已达到100%优化。")

/obj/machinery/research/anomaly_refinery/check_test(atom/source, list/arguments)

	. = COMSIG_CANCEL_EXPLOSION

	if(!inserted_core)
		test_status = "错误：引爆时未检测到核心。"
		playsound(
			src,
			pick('modular_zubbers/sound/arcade/minesweeper_winfail.ogg'),
			50
		)
		return

	var/heavy = arguments[EXARG_KEY_DEV_RANGE]
	var/medium = arguments[EXARG_KEY_HEAVY_RANGE]
	var/light = arguments[EXARG_KEY_LIGHT_RANGE]
	var/explosion_range = max(heavy, medium, light, 0)
	var/capped_explosion_range = min(explosion_range, DEFAULT_MESSAGE_RANGE)
	var/required_range = get_required_radius(inserted_core.anomaly_type)

	SSexplosions.shake_the_room(get_turf(src), capped_explosion_range*0.25, capped_explosion_range, capped_explosion_range*0.25, capped_explosion_range*0.25)

	if(explosion_range < required_range)
		test_status = "爆炸产生的内爆威力不足，无法压缩[inserted_core]。物品已弹出。"
		playsound(
			src,
			pick('modular_zubbers/sound/arcade/minesweeper_winfail.ogg'),
			50
		)
		return

	if(test_status)
		playsound(
			src,
			pick('modular_zubbers/sound/arcade/minesweeper_winfail.ogg'),
			50
		)
		return

	inserted_core = inserted_core.create_core(src, TRUE, TRUE)
	test_status = "成功。此次爆炸的理论范围为[explosion_range]，所需半径为[required_range]。核心生产完成。"

	playsound(
		src,
		pick('modular_zubbers/sound/arcade/minesweeper_win.ogg'),
		50
	)

	return

#undef REFINERY_ANOMALY_REFINEMENT_TIME
#undef REFINERY_ANOMALY_POWER_REQUIREMENT
