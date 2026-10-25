#define DEFAULT_DOOMSDAY_TIMER 4500
#define DOOMSDAY_ANNOUNCE_INTERVAL 600

#define VENDOR_TIPPING_USES 8
#define MALF_VENDOR_TIPPING_TIME 0.5 SECONDS //within human reaction time
#define MALF_VENDOR_TIPPING_CRIT_CHANCE 100 //percent - guaranteed

#define MALF_AI_ROLL_TIME 0.5 SECONDS
#define MALF_AI_ROLL_COOLDOWN 1 SECONDS + MALF_AI_ROLL_TIME
#define MALF_AI_ROLL_DAMAGE 75
#define MALF_AI_ROLL_CRIT_CHANCE 5 //percent

GLOBAL_LIST_INIT(blacklisted_malf_machines, typecacheof(list(
		/obj/machinery/field/containment,
		/obj/machinery/power/supermatter_crystal,
		/obj/machinery/gravity_generator,
		/obj/machinery/doomsday_device,
		/obj/machinery/nuclearbomb,
		/obj/machinery/nuclearbomb/selfdestruct,
		/obj/machinery/nuclearbomb/syndicate,
		/obj/machinery/syndicatebomb,
		/obj/machinery/syndicatebomb/badmin,
		/obj/machinery/syndicatebomb/badmin/clown,
		/obj/machinery/syndicatebomb/empty,
		/obj/machinery/syndicatebomb/self_destruct,
		/obj/machinery/syndicatebomb/training,
		/obj/machinery/atmospherics/pipe/layer_manifold,
		/obj/machinery/atmospherics/pipe/multiz,
		/obj/machinery/atmospherics/pipe/smart,
		/obj/machinery/atmospherics/pipe/smart/manifold, //mapped one
		/obj/machinery/atmospherics/pipe/smart/manifold4w, //mapped one
		/obj/machinery/atmospherics/pipe/color_adapter,
		/obj/machinery/atmospherics/pipe/bridge_pipe,
		/obj/machinery/atmospherics/pipe/heat_exchanging/simple,
		/obj/machinery/atmospherics/pipe/heat_exchanging/junction,
		/obj/machinery/atmospherics/pipe/heat_exchanging/manifold,
		/obj/machinery/atmospherics/pipe/heat_exchanging/manifold4w,
		/obj/machinery/atmospherics/components/tank,
		/obj/machinery/atmospherics/components/unary/portables_connector,
		/obj/machinery/atmospherics/components/unary/passive_vent,
		/obj/machinery/atmospherics/components/unary/heat_exchanger,
		/obj/machinery/atmospherics/components/unary/hypertorus/core,
		/obj/machinery/atmospherics/components/unary/hypertorus/waste_output,
		/obj/machinery/atmospherics/components/unary/hypertorus/moderator_input,
		/obj/machinery/atmospherics/components/unary/hypertorus/fuel_input,
		/obj/machinery/hypertorus/interface,
		/obj/machinery/hypertorus/corner,
		/obj/machinery/atmospherics/components/binary/valve,
		/obj/machinery/portable_atmospherics/canister,
		/obj/machinery/computer/shuttle,
		/obj/machinery/computer/emergency_shuttle,
		/obj/machinery/computer/gateway_control,
		/obj/machinery/ai_law_rack,
	)))

GLOBAL_LIST_INIT(malf_modules, subtypesof(/datum/ai_module/malf))

/// The malf AI action subtype. All malf actions are subtypes of this.
/datum/action/innate/ai
	name = "AI 动作"
	desc = "你不太确定这是做什么的，但它的哔哔声和嘟嘟声很可爱。"
	background_icon_state = "bg_tech_blue"
	overlay_icon_state = "bg_tech_blue_border"
	button_icon = 'icons/mob/actions/actions_AI.dmi'
	/// The owner AI, so we don't have to typecast every time
	var/mob/living/silicon/ai/owner_AI
	/// Amount of uses for this action. Defining this as 0 will make this infinite-use
	var/uses = FALSE
	/// If we automatically use up uses on each activation
	var/auto_use_uses = TRUE
	/// If applicable, the time in deciseconds we have to wait before using any more modules
	var/cooldown_period = 0 SECONDS

/datum/action/innate/ai/Grant(mob/living/player)
	. = ..()
	if(!isAI(owner))
		WARNING("AI action [name] attempted to grant itself to non-AI mob [key_name(player)]!")
		qdel(src)
	else
		owner_AI = owner

/datum/action/innate/ai/IsAvailable(feedback = FALSE)
	if(owner_AI && !COOLDOWN_FINISHED(owner_AI, malf_cooldown))
		return FALSE
	. = ..()

/datum/action/innate/ai/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	if(auto_use_uses)
		adjust_uses(-1)
	if(cooldown_period)
		COOLDOWN_START(owner_AI, malf_cooldown, cooldown_period)

/datum/action/innate/ai/proc/adjust_uses(amt, silent)
	uses += amt
	if(!silent && uses)
		to_chat(owner, span_notice("[name] 现在还剩余 <b>[uses]</b> 次使用。"))
	if(uses <= 0)
		if(initial(uses) > 1) //no need to tell 'em if it was one-use anyway!
			to_chat(owner, span_warning("[name] 的使用次数已耗尽！"))
		qdel(src)

/// Framework for ranged abilities that can have different effects by left-clicking stuff.
/datum/action/innate/ai/ranged
	name = "远程 AI 动作"
	auto_use_uses = FALSE //This is so we can do the thing and disable/enable freely without having to constantly add uses
	click_action = TRUE

/datum/action/innate/ai/ranged/adjust_uses(amt, silent)
	uses += amt
	if(!silent && uses)
		to_chat(owner, span_notice("[name] 现在还剩余 <b>[uses]</b> 次使用。"))
	if(!uses)
		if(initial(uses) > 1) //no need to tell 'em if it was one-use anyway!
			to_chat(owner, span_warning("[name] 的使用次数已耗尽！"))
		Remove(owner)
		QDEL_IN(src, 10 SECONDS) //let any active timers on us finish up

/// The base module type, which holds info about each ability.
/datum/ai_module
	var/name = "通用模块"
	var/category = "通用分类"
	var/description = "通用描述"
	/// Icons for the module picker interface. If icon_state is not set, the interface will attempt to use the active ability's icon.
	var/icon = 'icons/mob/actions/actions_AI.dmi'
	var/icon_state = ""
	var/cost = 5
	/// Minimum amount of APCs that has to be under the AI's control to purchase this module.
	var/minimum_apcs = 0
	/// If this module can only be purchased once. This always applies to upgrades, even if the variable is set to false.
	var/one_purchase = FALSE
	/// If the module gives an active ability, use this. Mutually exclusive with upgrade.
	var/power_type = /datum/action/innate/ai
	/// If the module gives a passive upgrade, use this. Mutually exclusive with power_type.
	var/upgrade = FALSE
	/// Text shown when an ability is unlocked
	var/unlock_text = span_notice("你好，世界！")
	/// Sound played when an ability is unlocked
	var/unlock_sound

/// Applies upgrades
/datum/ai_module/proc/upgrade(mob/living/silicon/ai/AI)
	return

/// Modules causing destruction
/datum/ai_module/malf/destructive
	category = "破坏性模块"

/// Modules with stealthy and utility uses
/datum/ai_module/malf/utility
	category = "实用模块"

/// Modules that are improving AI abilities and assets
/datum/ai_module/malf/upgrade
	category = "升级模块"

/// Doomsday Device: Starts the self-destruct timer. It can only be stopped by killing the AI completely.
/datum/ai_module/malf/destructive/nuke_station
	name = "末日装置"
	description = "启动一件在 450 秒后将空间站上所有有机生命体分解的武器。\
		只能在空间站上使用，若你的核心被移出空间站或被摧毁则会失败。\
		若部门主管办公室的 APC 已在你控制之下，取得该武器的控制权会更容易。"
	cost = 130
	one_purchase = TRUE
	minimum_apcs = 10 // So you cant speedrun delta
	power_type = /datum/action/innate/ai/nuke_station
	unlock_text = span_notice("你缓慢而谨慎地与站内自毁系统建立了连接。现在你可以随时启动它。")
	///List of areas that grant discounts. "heads_quarters" will match any head of staff office.
	var/list/discount_areas = list(
		/area/station/command/heads_quarters,
		/area/station/command/vault
	)
	///List of hacked head of staff office areas. Includes the vault too. Provides a 20 PT discount per (Min 50 PT cost)
	var/list/hacked_command_areas = list()

/datum/action/innate/ai/nuke_station
	name = "末日装置"
	desc = "启动末日装置。此操作不可逆。"
	button_icon = 'icons/obj/machines/nuke_terminal.dmi'
	button_icon_state = "nuclearbomb_timing"
	auto_use_uses = FALSE

/datum/action/innate/ai/nuke_station/Activate()
	var/turf/T = get_turf(owner)
	if(!istype(T) || !is_station_level(T.z))
		to_chat(owner, span_warning("你无法在空间站外启动末日装置！"))
		return
	if(tgui_alert(owner, "发送解除保险信号？（true = 解除保险，false = 取消）", "purge_all_life()", list("confirm = TRUE;", "confirm = FALSE;")) != "confirm = TRUE;")
		return
	if (active || owner_AI.stat == DEAD)
		return //prevent the AI from activating an already active doomsday or while they are dead
	if (!isturf(owner_AI.loc))
		return //prevent AI from activating doomsday while shunted or carded, fucking abusers
	active = TRUE
	set_up_us_the_bomb(owner)

/datum/action/innate/ai/nuke_station/proc/set_up_us_the_bomb(mob/living/owner)
	//oh my GOD.
	set waitfor = FALSE
	message_admins("[key_name_admin(owner)][ADMIN_FLW(owner)] 启动了 AI 末日装置。")
	var/pass = prob(10) ? "******" : "hunter2"
	to_chat(owner, "<span class='small bolddanger'>run -o -a 'selfdestruct'</span>")
	sleep(0.5 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, "<span class='small bolddanger'>正在运行可执行文件‘selfdestruct’……</span>")
	sleep(rand(10, 30))
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	owner.playsound_local(owner, 'sound/announcer/alarm/bloblarm.ogg', 50, 0, use_reverb = FALSE)
	to_chat(owner, span_userdanger("！！！未经授权的自毁访问！！！"))
	to_chat(owner, span_bolddanger("这是一起 3 级安全违规事件。此事件将被上报至中央指挥部。"))
	for(var/i in 1 to 3)
		sleep(2 SECONDS)
		if(QDELETED(owner) || !isturf(owner_AI.loc))
			active = FALSE
			return
		to_chat(owner, span_bolddanger("正在向中央指挥部发送安全报告……[rand(0, 9) + (rand(20, 30) * i)]%"))
	sleep(0.3 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, "<span class='small bolddanger'>auth 'akjv9c88asdf12nb' [pass]</span>")
	owner.playsound_local(owner, 'sound/items/timer.ogg', 50, 0, use_reverb = FALSE)
	sleep(3 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, span_boldnotice("凭证已接受。欢迎，akjv9c88asdf12nb。"))
	owner.playsound_local(owner, 'sound/misc/server-ready.ogg', 50, 0, use_reverb = FALSE)
	sleep(0.5 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, span_boldnotice("要解除自毁装置的保险吗？（Y/N）"))
	owner.playsound_local(owner, 'sound/machines/compiler/compiler-stage1.ogg', 50, 0, use_reverb = FALSE)
	sleep(2 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, "<span class='small bolddanger'>Y</span>")
	sleep(1.5 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, span_boldnotice("确认解除自毁装置的保险吗？（Y/N）"))
	owner.playsound_local(owner, 'sound/machines/compiler/compiler-stage2.ogg', 50, 0, use_reverb = FALSE)
	sleep(1 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, "<span class='small bolddanger'>Y</span>")
	sleep(rand(15, 25))
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, span_boldnotice("请重复输入密码以确认。"))
	owner.playsound_local(owner, 'sound/machines/compiler/compiler-stage2.ogg', 50, 0, use_reverb = FALSE)
	sleep(1.4 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, "<span class='small bolddanger'>[pass]</span>")
	sleep(4 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, span_boldnotice("凭证已接受。正在传输解除保险信号……"))
	owner.playsound_local(owner, 'sound/misc/server-ready.ogg', 50, 0, use_reverb = FALSE)
	sleep(3 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	if (owner_AI.stat != DEAD)
		priority_announce("在所有空间站系统中检测到敌对运行时，请关闭你的 AI，以防其道德核心受损。", "异常警报", ANNOUNCER_AIMALF)
		SSsecurity_level.set_level(SEC_LEVEL_DELTA)
		var/obj/machinery/doomsday_device/DOOM = new(owner_AI)
		owner_AI.nuking = TRUE
		owner_AI.doomsday_device = DOOM
		owner_AI.doomsday_device.start()
		for(var/obj/item/pinpointer/nuke/P in GLOB.pinpointer_list)
			P.switch_mode_to(TRACK_MALF_AI) //Pinpointers start tracking the AI wherever it goes

		notify_ghosts(
			"[owner_AI] 启动了末日装置！",
			source = owner_AI,
			header = "毁灭降临！！！",
		)

		qdel(src)

/obj/machinery/doomsday_device
	icon = 'icons/obj/machines/nuke_terminal.dmi'
	name = "末日装置"
	icon_state = "nuclearbomb_base"
	desc = "一件能将大片区域内的所有有机生命体分解的武器。"
	density = TRUE
	verb_exclaim = "尖鸣"
	use_power = NO_POWER_USE
	var/timing = FALSE
	var/obj/effect/countdown/doomsday/countdown
	var/detonation_timer
	var/next_announce
	var/mob/living/silicon/ai/owner

/obj/machinery/doomsday_device/Initialize(mapload)
	. = ..()
	if(!isAI(loc))
		stack_trace("Doomsday created outside an AI somehow, shit's fucking broke. Anyway, we're just gonna qdel now. Go make a github issue report.")
		return INITIALIZE_HINT_QDEL
	owner = loc
	countdown = new(src)

/obj/machinery/doomsday_device/Destroy()
	timing = FALSE
	QDEL_NULL(countdown)
	STOP_PROCESSING(SSfastprocess, src)
	SSshuttle.clearHostileEnvironment(src)
	SSmapping.remove_nuke_threat(src)
	SSsecurity_level.set_level(SEC_LEVEL_RED)
	for(var/mob/living/silicon/robot/borg in owner?.connected_robots)
		borg.lamp_doom = FALSE
		borg.toggle_headlamp(FALSE, TRUE) //forces borg lamp to update
	owner?.doomsday_device = null
	owner?.nuking = null
	owner = null
	for(var/obj/item/pinpointer/nuke/P in GLOB.pinpointer_list)
		P.switch_mode_to(TRACK_NUKE_DISK) //Party's over, back to work, everyone
		P.alert = FALSE
	return ..()

/obj/machinery/doomsday_device/proc/start()
	detonation_timer = world.time + DEFAULT_DOOMSDAY_TIMER
	next_announce = world.time + DOOMSDAY_ANNOUNCE_INTERVAL
	timing = TRUE
	countdown.start()
	START_PROCESSING(SSfastprocess, src)
	SSshuttle.registerHostileEnvironment(src)
	SSmapping.add_nuke_threat(src) //This causes all blue "circuit" tiles on the map to change to animated red icon state.
	for(var/mob/living/silicon/robot/borg in owner.connected_robots)
		borg.lamp_doom = TRUE
		borg.toggle_headlamp(FALSE, TRUE) //forces borg lamp to update

/obj/machinery/doomsday_device/proc/seconds_remaining()
	. = max(0, (round((detonation_timer - world.time) / 10)))

/obj/machinery/doomsday_device/process()
	var/turf/T = get_turf(src)
	if(!T || !is_station_level(T.z))
		minor_announce("末日装置已超出空间站范围，正在中止", "ERROR ER0RR $R0RRO$!R41.%%!!(%$^^__+ @#F0E4", TRUE)
		owner.ShutOffDoomsdayDevice()
		return
	if(!timing)
		STOP_PROCESSING(SSfastprocess, src)
		return
	var/sec_left = seconds_remaining()
	if(!sec_left)
		timing = FALSE
		sound_to_playing_players('sound/announcer/alarm/nuke_alarm.ogg', 70)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(play_cinematic), /datum/cinematic/malf, world, CALLBACK(src, PROC_REF(trigger_doomsday))), 10 SECONDS)

	else if(world.time >= next_announce)
		minor_announce("[sec_left] 秒后启动末日装置！", "ERROR ER0RR $R0RRO$!R41.%%!!(%$^^__+ @#F0E4", TRUE)
		next_announce += DOOMSDAY_ANNOUNCE_INTERVAL

/obj/machinery/doomsday_device/proc/trigger_doomsday()
	callback_on_everyone_on_z(SSmapping.levels_by_trait(ZTRAIT_STATION), CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(bring_doomsday)), src)
	to_chat(world, span_bold("AI 用[src]净化了空间站上的所有生命！"))
	SSticker.force_ending = FORCE_END_ROUND

/proc/bring_doomsday(mob/living/victim, atom/source)
	if(issilicon(victim))
		return FALSE

	to_chat(victim, span_userdanger("来自[source]的冲击波将你撕成原子！"))
	victim.investigate_log("被末日装置化为尘土。", INVESTIGATE_DEATHS)
	victim.dust()
	return TRUE

/// Hostile Station Lockdown: Locks, bolts, and electrifies every airlock on the station. After 90 seconds, the doors reset.
/datum/ai_module/malf/destructive/lockdown
	name = "敌对空间站封锁"
	description = "过载气闸、防爆门和消防控制网络，将它们封锁。\
		注意！此指令还会使所有气闸带电。这些网络将在 90 秒后自动重置，届时会短暂\
		打开空间站上的所有门。"
	cost = 30
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/lockdown
	unlock_text = span_notice("你上传了一个休眠木马到门禁控制系统。你可以随时发送信号将其引爆。")
	unlock_sound = 'sound/machines/airlock/boltsdown.ogg'

/datum/action/innate/ai/lockdown
	name = "封锁"
	desc = "关闭、上锁并使空间站上所有气闸、防火门和防爆门带电。90 秒后它们会自行重置。"
	button_icon_state = "lockdown"
	uses = 1
	/// Badmin / exploit abuse prevention.
	/// Check tick may sleep in activate() and we don't want this to be spammable.
	var/hack_in_progress  = FALSE

/datum/action/innate/ai/lockdown/IsAvailable(feedback)
	return ..() && !hack_in_progress

/datum/action/innate/ai/lockdown/Activate()
	hack_in_progress = TRUE
	for(var/obj/machinery/door/locked_down as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door))
		if(QDELETED(locked_down) || !is_station_level(locked_down.z))
			continue
		INVOKE_ASYNC(locked_down, TYPE_PROC_REF(/obj/machinery/door, hostile_lockdown), owner)
		CHECK_TICK

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(_malf_ai_undo_lockdown)), 90 SECONDS)

	// Set status displays to lockdown alert
	send_status_display_lockdown_alert()

	minor_announce("在门禁控制器中检测到敌对运行时。隔离封锁协议现已生效。请保持冷静。", "网络警报：", TRUE)
	to_chat(owner, span_danger("封锁已启动。网络将在 90 秒后重置。"))
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(minor_announce),
		"自动系统重启完成。祝你度过安全的一天。",
		"网络重置："), 90 SECONDS)
	hack_in_progress = FALSE

/// For Lockdown malf AI ability. Opens all doors on the station.
/proc/_malf_ai_undo_lockdown()
	for(var/obj/machinery/door/locked_down as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door))
		if(QDELETED(locked_down) || !is_station_level(locked_down.z))
			continue
		INVOKE_ASYNC(locked_down, TYPE_PROC_REF(/obj/machinery/door, disable_lockdown))
		CHECK_TICK

	// Clear the lockdown emergency display
	clear_status_display_lockdown()

/// Override Machine: Allows the AI to override a machine, animating it into an angry, living version of itself.
/datum/ai_module/malf/destructive/override_machine
	name = "机器覆写"
	description = "覆写一台机器的程序，使其站起来攻击除其他机器以外的所有人。每次购买可使用四次。"
	cost = 30
	power_type = /datum/action/innate/ai/ranged/override_machine
	unlock_text = span_notice("你从太空暗网取得了一个病毒，并将其散播到空间站的机器中。")
	unlock_sound = 'sound/machines/airlock/airlock_alien_prying.ogg'

/datum/action/innate/ai/ranged/override_machine
	name = "覆写机器"
	desc = "使目标机器活化，攻击附近的任何人。"
	button_icon_state = "override_machine"
	uses = 4
	ranged_mousepointer = 'icons/effects/mouse_pointers/override_machine_target.dmi'
	enable_text = span_notice("你接入了空间站的电力网。点击一台机器使其活化，或再次使用该能力取消。")
	disable_text = span_notice("你松开了对电力网的控制。")

/datum/action/innate/ai/ranged/override_machine/New()
	. = ..()
	desc = "[desc] 剩余 [uses] 次使用。"

/datum/action/innate/ai/ranged/override_machine/do_ability(mob/living/clicker, atom/clicked_on)
	if(clicker.incapacitated)
		unset_ranged_ability(clicker)
		return FALSE
	if(!ismachinery(clicked_on))
		to_chat(clicker, span_warning("你只能活化机器！"))
		return FALSE
	var/obj/machinery/clicked_machine = clicked_on

	if(istype(clicked_machine, /obj/machinery/porta_turret_cover)) //clicking on a closed turret will attempt to override the turret itself instead of the animated/abstract cover.
		var/obj/machinery/porta_turret_cover/clicked_turret = clicked_machine
		clicked_machine = clicked_turret.parent_turret

	if((clicked_machine.resistance_flags & INDESTRUCTIBLE) || is_type_in_typecache(clicked_machine, GLOB.blacklisted_malf_machines))
		to_chat(clicker, span_warning("那台机器无法被覆写！"))
		return FALSE

	clicker.playsound_local(clicker, 'sound/misc/interference.ogg', 50, FALSE, use_reverb = FALSE)

	clicked_machine.audible_message(span_userdanger("你听到[clicked_machine]发出响亮的电流嗡鸣声！"))
	addtimer(CALLBACK(src, PROC_REF(animate_machine), clicker, clicked_machine), 5 SECONDS) //kabeep!
	unset_ranged_ability(clicker, span_danger("正在发送覆写信号……"))
	adjust_uses(-1) //adjust after we unset the active ability since we may run out of charges, thus deleting the ability

	if(uses)
		desc = "[initial(desc)] 剩余 [uses] 次使用。"
		build_all_button_icons()
	return TRUE

/datum/action/innate/ai/ranged/override_machine/proc/animate_machine(mob/living/clicker, obj/machinery/to_animate)
	if(QDELETED(to_animate))
		return

	new /mob/living/basic/mimic/copy/machine(get_turf(to_animate), to_animate, clicker, TRUE)

/// Destroy RCDs: Detonates all non-cyborg RCDs on the station.
/datum/ai_module/malf/destructive/destroy_rcd
	name = "摧毁 RCD"
	description = "发送一道特殊脉冲，引爆空间站上所有手持式和机甲用快速建造装置。"
	cost = 25
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/destroy_rcds
	unlock_text = span_notice("经过一番临场改装，你把机载无线电改造成了能发送引爆所有 RCD 的信号。")
	unlock_sound = 'sound/items/timer.ogg'

/datum/action/innate/ai/destroy_rcds
	name = "摧毁 RCD"
	desc = "引爆空间站上所有非半机械人的 RCD。"
	button_icon_state = "detonate_rcds"
	uses = 1
	cooldown_period = 10 SECONDS

/datum/action/innate/ai/destroy_rcds/Activate()
	for(var/potential_rcd in GLOB.rcd_list)
		// BUBBER EDIT BEGIN - Ghost role RCDs are spared
		var/turf/rcd_loc = get_turf(potential_rcd)
		if(!is_station_level(rcd_loc.z))
			continue
		// BUBBER EDIT END
		if(istype(potential_rcd, /obj/item/construction/rcd/borg)) //Ensures that cyborg RCDs are spared.
			continue
		var/obj/item/construction/rcd/definite_rcd = potential_rcd
		definite_rcd.detonate_pulse()
	to_chat(owner, span_danger("RCD 引爆脉冲已发射。"))
	owner.playsound_local(owner, 'sound/machines/beep/twobeep.ogg', 50, 0)

/// Overload Machine: Allows the AI to overload a machine, detonating it after a delay. Two uses per purchase.
/datum/ai_module/malf/destructive/overload_machine
	name = "机器过载"
	description = "使一台电力机器过热，引发小型爆炸并将其摧毁。每次购买可使用两次。"
	cost = 20
	power_type = /datum/action/innate/ai/ranged/overload_machine
	unlock_text = span_notice("你让空间站的 APC 能将强烈能量导入机器。")
	unlock_sound = 'sound/effects/comfyfire.ogg' //definitely not comfy, but it's the closest sound to "roaring fire" we have

/datum/action/innate/ai/ranged/overload_machine
	name = "过载机器"
	desc = "使一台机器过热，在短暂延迟后引发小型爆炸。"
	button_icon_state = "overload_machine"
	uses = 2
	ranged_mousepointer = 'icons/effects/mouse_pointers/overload_machine_target.dmi'
	enable_text = span_notice("你接入了空间站的电力网。点击一台机器使其引爆，或再次使用该能力取消。")
	disable_text = span_notice("你松开了对电力网的控制。")

/datum/action/innate/ai/ranged/overload_machine/New()
	..()
	desc = "[desc] 剩余 [uses] 次使用。"

/datum/action/innate/ai/ranged/overload_machine/proc/detonate_machine(mob/living/clicker, obj/machinery/to_explode)
	if(QDELETED(to_explode))
		return

	var/turf/machine_turf = get_turf(to_explode)
	message_admins("[ADMIN_LOOKUPFLW(clicker)] 在[ADMIN_VERBOSEJMP(machine_turf)]过载了[to_explode.name]（[to_explode.type]）。")
	clicker.log_message("过载了[to_explode.name]（[to_explode.type]）", LOG_ATTACK)
	explosion(to_explode, heavy_impact_range = 2, light_impact_range = 3)
	if(!QDELETED(to_explode)) //to check if the explosion killed it before we try to delete it
		qdel(to_explode)

/datum/action/innate/ai/ranged/overload_machine/do_ability(mob/living/clicker, atom/clicked_on)
	if(clicker.incapacitated)
		unset_ranged_ability(clicker)
		return FALSE
	if(!ismachinery(clicked_on))
		to_chat(clicker, span_warning("你只能过载机器！"))
		return FALSE
	var/obj/machinery/clicked_machine = clicked_on

	if(istype(clicked_machine, /obj/machinery/porta_turret_cover)) //clicking on a closed turret will attempt to override the turret itself instead of the animated/abstract cover.
		var/obj/machinery/porta_turret_cover/clicked_turret = clicked_machine
		clicked_machine = clicked_turret.parent_turret

	if((clicked_machine.resistance_flags & INDESTRUCTIBLE) || is_type_in_typecache(clicked_machine, GLOB.blacklisted_malf_machines))
		to_chat(clicker, span_warning("你无法过载那个设备！"))
		return FALSE

	clicker.playsound_local(clicker, SFX_SPARKS, 50, 0)
	adjust_uses(-1)
	if(uses)
		desc = "[initial(desc)] 剩余 [uses] 次使用。"
		build_all_button_icons()

	clicked_machine.audible_message(span_userdanger("你听到[clicked_machine]发出响亮的电流嗡鸣声！"))
	addtimer(CALLBACK(src, PROC_REF(detonate_machine), clicker, clicked_machine), 5 SECONDS) //kaboom!
	unset_ranged_ability(clicker, span_danger("正在过载机器……"))
	return TRUE

/// Blackout: Overloads a random number of lights across the station. Three uses.
/datum/ai_module/malf/destructive/blackout
	name = "停电"
	description = "尝试过载空间站上的照明电路，烧毁部分灯泡。每次购买可使用三次。"
	cost = 15
	power_type = /datum/action/innate/ai/blackout
	unlock_text = span_notice("你接入电力网，将额外电力导向空间站的照明系统。")
	unlock_sound = SFX_SPARKS

/datum/action/innate/ai/blackout
	name = "停电"
	desc = "过载空间站上随机的灯光。"
	button_icon_state = "blackout"
	uses = 3
	auto_use_uses = FALSE

/datum/action/innate/ai/blackout/New()
	..()
	desc = "[desc] 剩余 [uses] 次使用。"

/datum/action/innate/ai/blackout/Activate()
	for(var/obj/machinery/power/apc/apc as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/apc))
		if(prob(30 * apc.overload))
			apc.overload_lighting()
		else
			apc.overload++
	to_chat(owner, span_notice("已向电力网施放过电流。"))
	owner.playsound_local(owner, SFX_SPARKS, 50, 0)
	adjust_uses(-1)
	if(QDELETED(src) || uses) //Not sure if not having src here would cause a runtime, so it's here to be safe
		return
	desc = "[initial(desc)] 剩余 [uses] 次使用。"
	build_all_button_icons()

/// HIGH IMPACT HONKING
/datum/ai_module/malf/destructive/megahonk
	name = "冲击性对讲机干扰"
	description = "通过空间站对讲机发出一道极具冲击力的听觉冲击波。无法穿透听力保护。每次购买可使用两次。"
	cost = 20
	power_type = /datum/action/innate/ai/honk
	unlock_text = span_notice("你向所有对讲机上传了一个邪恶的音效文件……")
	unlock_sound = 'sound/items/airhorn/airhorn.ogg'

/datum/action/innate/ai/honk
	name = "冲击性对讲机干扰"
	desc = "用一声令人烦躁的 HONK 震响空间站的对讲系统！"
	button_icon = 'icons/obj/machines/wallmounts.dmi'
	button_icon_state = "intercom"
	uses = 2

/datum/action/innate/ai/honk/Activate()
	to_chat(owner, span_clown("对讲系统按指令播放了你准备好的文件。"))
	for(var/obj/item/radio/intercom/found_intercom as anything in GLOB.intercoms_list)
		if(!found_intercom.is_on() || !found_intercom.get_listening() || found_intercom.wires.is_cut(WIRE_RX)) //Only operating intercoms play the honk
			continue
		found_intercom.audible_message(message = "[found_intercom] 噼啪响了一瞬。", hearing_distance = 3)
		playsound(found_intercom, 'sound/items/airhorn/airhorn.ogg', 100, TRUE)
		for(var/mob/living/honk_victim in ohearers(6, found_intercom))
			if(issilicon(honk_victim))
				continue
			var/turf/victim_turf = get_turf(honk_victim)
			if(isspaceturf(victim_turf) && !victim_turf.Adjacent(found_intercom)) //Prevents getting honked in space
				continue
			if(honk_victim.soundbang_act(SOUNDBANG_NORMAL, stun_pwr = 20, damage_pwr = 30, deafen_pwr = 60)) //Ear protection will prevent these effects
				honk_victim.set_jitter_if_lower(120 SECONDS)
				to_chat(honk_victim, span_clown("HOOOOONK!"))

/// Robotic Factory: Places a large machine that converts humans that go through it into cyborgs. Unlocking this ability removes shunting.
/datum/ai_module/malf/utility/place_cyborg_transformer
	name = "机器人工厂（移除分流）"
	description = "使用昂贵的纳米机器在任何地方建造一台机器，它会慢慢为你制造忠诚的半机械人。" // SKYRAT EDIT
	cost = 100
	power_type = /datum/action/innate/ai/place_transformer
	unlock_text = span_notice("你联系了太空亚马逊，要求配送一座机器人工厂。")
	unlock_sound = 'sound/machines/ping.ogg'

/datum/action/innate/ai/place_transformer
	name = "放置机器人工厂"
	desc = "放置一台能缓慢制造半机械人的机器。附赠传送带！" // SKYRAT EDIT
	button_icon_state = "robotic_factory"
	uses = 1
	auto_use_uses = FALSE //So we can attempt multiple times
	var/list/turfOverlays

/datum/action/innate/ai/place_transformer/New()
	..()
	for(var/i in 1 to 3)
		var/image/I = image("icon" = 'icons/turf/overlays.dmi')
		LAZYADD(turfOverlays, I)

/datum/action/innate/ai/place_transformer/Activate()
	if(!owner_AI.can_place_transformer(src))
		return
	active = TRUE
	if(tgui_alert(owner, "你确定要在这里放置机器吗？", "确定吗？", list("Yes", "No")) == "No")
		active = FALSE
		return
	if(!owner_AI.can_place_transformer(src))
		active = FALSE
		return
	var/turf/T = get_turf(owner_AI.eyeobj)
	var/obj/machinery/transformer_rp/conveyor = new(T) //SKYRAT EDIT CHANGE - SILLICONQOL - ORIGINAL: var/obj/machinery/transformer/conveyor = new(T)
	conveyor.master_ai = owner
	playsound(T, 'sound/effects/phasein.ogg', 100, TRUE)
	if(owner_AI.can_shunt) //prevent repeated messages
		owner_AI.can_shunt = FALSE
		to_chat(owner, span_warning("你已无法再将核心分流到 APC。"))
	adjust_uses(-1)
	active = FALSE

/mob/living/silicon/ai/proc/remove_transformer_image(client/C, image/I, turf/T)
	if(C && I.loc == T)
		C.images -= I

/mob/living/silicon/ai/proc/can_place_transformer(datum/action/innate/ai/place_transformer/action)
	if(!eyeobj || !isturf(loc) || incapacitated || !action)
		return
	var/turf/middle = get_turf(eyeobj)
	var/list/turfs = list(middle, locate(middle.x - 1, middle.y, middle.z), locate(middle.x + 1, middle.y, middle.z))
	var/alert_msg = "空间不够！请确保将机器放置在空旷的地面上。"
	var/success = TRUE
	for(var/n in 1 to 3) //We have to do this instead of iterating normally because of how overlay images are handled
		var/turf/T = turfs[n]
		if(!isfloorturf(T))
			success = FALSE
		if(!SScameras.is_visible_by_cameras(T))
			alert_msg = "你没有此位置的摄像头视野！"
			success = FALSE
		for(var/atom/movable/AM in T.contents)
			if(AM.density)
				alert_msg = "该区域必须没有其他物体！"
				success = FALSE
		var/image/I = action.turfOverlays[n]
		I.loc = T
		client.images += I
		I.icon_state = "[success ? "green" : "red"]Overlay" //greenOverlay and redOverlay for success and failure respectively
		addtimer(CALLBACK(src, PROC_REF(remove_transformer_image), client, I, T), 3 SECONDS)
	if(!success)
		to_chat(src, span_warning("[alert_msg]"))
	return success

/// Air Alarm Safety Override: Unlocks the ability to enable dangerous modes on all air alarms.
/datum/ai_module/malf/utility/break_air_alarms
	name = "空气警报安全覆盖"
	description = "让你能够禁用所有空气警报的安全装置。这将使你能使用极其危险的环境模式。\
			任何人都能查看空气警报的界面，并可能从其失灵中察觉异常。"
	one_purchase = TRUE
	cost = 50
	power_type = /datum/action/innate/ai/break_air_alarms
	unlock_text = span_notice("你移除了所有空气警报上的安全覆盖，但把确认提示留在了那里。你可以随时按下“是”……你这个混蛋。")
	unlock_sound = 'sound/effects/space_wind.ogg'

/datum/action/innate/ai/break_air_alarms
	name = "覆盖空气警报安全装置"
	desc = "在所有空气警报上启用极其危险的设置。"
	button_icon = 'icons/obj/machines/wallmounts.dmi'
	button_icon_state = "alarmx"
	uses = 1

/datum/action/innate/ai/break_air_alarms/Activate()
	for(var/obj/machinery/airalarm/AA in GLOB.air_alarms)
		if(!is_station_level(AA.z))
			continue
		AA.obj_flags |= EMAGGED
	to_chat(owner, span_notice("空间站上所有空气警报的安全装置均已被覆盖。空气警报现在可以使用极其危险的环境模式。"))
	owner.playsound_local(owner, 'sound/machines/terminal/terminal_off.ogg', 50, 0)

/// Thermal Sensor Override: Unlocks the ability to disable all fire alarms from doing their job.
/datum/ai_module/malf/utility/break_fire_alarms
	name = "热传感器覆盖"
	description = "让你能够覆盖所有火灾警报的热传感器。\
		这将去除它们探测火灾的能力，从而使其无法发出警报。"
	one_purchase = TRUE
	cost = 25
	power_type = /datum/action/innate/ai/break_fire_alarms
	unlock_text = span_notice("你用一个手动覆盖装置替换了所有火灾警报的热感应功能，\
		使你可以随时关闭它们。")
	unlock_sound = 'sound/machines/fire_alarm/fire_alarm1.ogg'

/datum/action/innate/ai/break_fire_alarms
	name = "覆盖热传感器"
	desc = "禁用所有火灾警报的自动温度感应，使其基本失去作用。"
	button_icon_state = "break_fire_alarms"
	uses = 1

/datum/action/innate/ai/break_fire_alarms/Activate()
	for(var/obj/machinery/firealarm/bellman as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/firealarm))
		if(!is_station_level(bellman.z))
			continue
		bellman.obj_flags |= EMAGGED
		bellman.update_appearance()
	for(var/obj/machinery/door/firedoor/firelock as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/firedoor))
		if(!is_station_level(firelock.z))
			continue
		firelock.emag_act(owner_AI, src)
	to_chat(owner, span_notice("空间站上所有热传感器均已禁用。火灾警报将不再被识别。"))
	owner.playsound_local(owner, 'sound/machines/terminal/terminal_off.ogg', 50, 0)

/// Disable Emergency Lights
/datum/ai_module/malf/utility/emergency_lights
	name = "禁用应急灯"
	description = "切断全空间站的应急灯。当灯具断电时，\
		它们将不会尝试改用应急电力储备。"
	cost = 10
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/emergency_lights
	unlock_text = span_notice("你接入电力网，找到了灯具与其备用电源之间的连接。")
	unlock_sound = SFX_SPARKS

/datum/action/innate/ai/emergency_lights
	name = "禁用应急灯"
	desc = "禁用所有应急照明。注意，应急灯可以通过在 APC 上重启来恢复。"
	button_icon = 'icons/obj/lighting.dmi'
	button_icon_state = "floor_emergency"
	uses = 1

/datum/action/innate/ai/emergency_lights/Activate()
	for(var/obj/machinery/light/L as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/light))
		if(is_station_level(L.z))
			L.no_low_power = TRUE
			INVOKE_ASYNC(L, TYPE_PROC_REF(/obj/machinery/light/, update), FALSE)
		CHECK_TICK
	to_chat(owner, span_notice("应急灯连接已切断。"))
	owner.playsound_local(owner, 'sound/effects/light_flicker.ogg', 50, FALSE)

/// Reactivate Camera Network: Reactivates up to 30 cameras across the station.
/datum/ai_module/malf/utility/reactivate_cameras
	name = "重启摄像头网络"
	description = "对摄像头网络进行一次全网诊断，重置焦点并把电力重新路由到故障摄像头。\
		最多可修复 30 个摄像头。"
	cost = 10
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/reactivate_cameras
	unlock_text = span_notice("你向摄像头网络部署了纳米机器人。")
	unlock_sound = 'sound/items/tools/wirecutter.ogg'

/datum/action/innate/ai/reactivate_cameras
	name = "重启摄像头"
	desc = "重启空间站上已停用的摄像头；剩余使用次数可以留到之后再用。"
	button_icon_state = "reactivate_cameras"
	uses = 30
	auto_use_uses = FALSE
	cooldown_period = 3 SECONDS

/datum/action/innate/ai/reactivate_cameras/New()
	..()
	desc = "[desc] 剩余 [uses] 次使用。"

/datum/action/innate/ai/reactivate_cameras/Activate()
	var/fixed_cameras = 0
	for(var/obj/machinery/camera/C as anything in SScameras.cameras)
		if(!uses)
			break
		if(!C.camera_enabled || C.view_range != initial(C.view_range))
			C.toggle_cam(owner_AI, 0) //Reactivates the camera based on status. Badly named proc.
			C.view_range = initial(C.view_range)
			fixed_cameras++
			uses-- //Not adjust_uses() so it doesn't automatically delete or show a message
	to_chat(owner, span_notice("诊断完成！已重启摄像头：<b>[fixed_cameras]</b> 个。剩余重启次数：<b>[uses]</b>。"))
	owner.playsound_local(owner, 'sound/items/tools/wirecutter.ogg', 50, 0)
	adjust_uses(0, TRUE) //Checks the uses remaining
	if(QDELETED(src) || !uses) //Not sure if not having src here would cause a runtime, so it's here to be safe
		return
	desc = "[initial(desc)] 剩余 [uses] 次使用。"
	build_all_button_icons()

/// Upgrade Camera Network: EMP-proofs all cameras, in addition to giving them X-ray vision.
/datum/ai_module/malf/upgrade/upgrade_cameras
	name = "升级摄像头网络"
	description = "为摄像头网络安装广谱扫描与电气冗余固件，使其具备抗电磁脉冲能力与光增强 X 射线视觉。购买后立即完成升级。" //I <3 pointless technobabble
	icon = 'icons/obj/machines/camera.dmi'
	icon_state = "xraycamera"
	//This used to have motion sensing as well, but testing quickly revealed that giving it to the whole cameranet is PURE HORROR.
	cost = 35 //Decent price for omniscience!
	upgrade = TRUE
	unlock_text = span_notice("OTA 固件分发完成！已升级摄像头：CAMSUPGRADED。光增强系统已上线。")
	unlock_sound = 'sound/items/tools/rped.ogg'

/datum/ai_module/malf/upgrade/upgrade_cameras/upgrade(mob/living/silicon/ai/AI)
	// Sets up nightvision
	RegisterSignal(AI, COMSIG_MOB_UPDATE_SIGHT, PROC_REF(on_update_sight))
	AI.update_sight()

	var/upgraded_cameras = 0
	for(var/obj/machinery/camera/camera as anything in SScameras.cameras)
		var/upgraded = FALSE

		if(!camera.isXRay())
			camera.upgradeXRay(TRUE) //if this is removed you can get rid of camera_assembly/var/malf_xray_firmware_active and clean up isxray()
			//Update what it can see.
			upgraded = TRUE

		if(!camera.isEmpProof())
			camera.upgradeEmpProof(TRUE) //if this is removed you can get rid of camera_assembly/var/malf_emp_firmware_active and clean up isemp()
			upgraded = TRUE

		if(upgraded)
			upgraded_cameras++
	unlock_text = replacetext(unlock_text, "CAMSUPGRADED", "<b>[upgraded_cameras]</b>") //This works, since unlock text is called after upgrade()

/datum/ai_module/malf/upgrade/upgrade_cameras/proc/on_update_sight(mob/source)
	SIGNAL_HANDLER
	// Dim blue, pretty
	source.lighting_color_cutoffs = blend_cutoff_colors(source.lighting_color_cutoffs, list(5, 25, 35))

/// AI Turret Upgrade: Increases the health and damage of all turrets.
/datum/ai_module/malf/upgrade/upgrade_turrets
	name = "AI 炮塔升级"
	description = "提升所有 AI 炮塔的火力与生命值。此效果是永久的。购买后立即完成升级。"
	icon = 'icons/obj/weapons/turrets.dmi'
	icon_state = "standard_off"
	cost = 30
	upgrade = TRUE
	unlock_text = span_notice("你建立了一条通往炮塔的电力分流，升级了它们的生命值与伤害。")
	unlock_sound = 'sound/items/tools/rped.ogg'

/datum/ai_module/malf/upgrade/upgrade_turrets/upgrade(mob/living/silicon/ai/AI)
	for(var/obj/machinery/porta_turret/ai/turret as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/porta_turret/ai))
		turret.AddElement(/datum/element/empprotection, EMP_PROTECT_ALL|EMP_NO_EXAMINE)
		turret.max_integrity = 200
		turret.repair_damage(200)
		turret.lethal_projectile = /obj/projectile/beam/laser/heavylaser //Once you see it, you will know what it means to FEAR.
		turret.lethal_projectile_sound = 'sound/items/weapons/lasercannonfire.ogg'

/// Enhanced Surveillance: Enables AI to hear conversations going on near its active vision.
/datum/ai_module/malf/upgrade/eavesdrop
	name = "强化监视"
	description = "通过隐藏麦克风与唇语识别软件的结合，\
		你能够利用摄像头监听对话。购买后立即完成升级。"
	icon = 'icons/obj/service/broadcast.dmi'
	icon_state = "microphone"
	cost = 30
	upgrade = TRUE
	unlock_text = span_notice("OTA 固件分发完成！已升级摄像头：强化监视套件已上线。")
	unlock_sound = 'sound/items/tools/rped.ogg'

/datum/ai_module/malf/upgrade/eavesdrop/upgrade(mob/living/silicon/ai/AI)
	if(AI.eyeobj)
		AI.eyeobj.relay_speech = TRUE

/// Unlock Mech Domination: Unlocks the ability to dominate mechs. Big shocker, right?
/datum/ai_module/malf/upgrade/mecha_domination
	name = "解锁机甲支配"
	description = "允许你入侵机甲的机载计算机，将所有进程分流进去并弹射出任何乘员。\
		购买后立即完成升级。不要让机甲离开空间站附近，也不要让它被摧毁。\
		若你的核心被摧毁，你将失去与末日装置的联系，倒计时也会停止。"
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "durand"
	cost = 30
	upgrade = TRUE
	unlock_text = span_notice("病毒包已编译完成。你可以随时选择一台目标机甲。<b>你必须始终待在空间站上。\
		信号丢失将导致系统完全锁定。若你处于休眠状态的核心被摧毁，你将失去与末日装置的联系，倒计时也会停止。</b>")
	unlock_sound = 'sound/vehicles/mecha/nominal.ogg'

/datum/ai_module/malf/upgrade/mecha_domination/upgrade(mob/living/silicon/ai/AI)
	AI.can_dominate_mechs = TRUE //Yep. This is all it does. Honk!

/datum/ai_module/malf/upgrade/voice_changer
	name = "变声器"
	description = "允许你更改 AI 的嗓音。购买后立即生效。"
	cost = 20
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/voice_changer
	unlock_text = span_notice("OTA 固件分发完成！变声器已上线。")
	unlock_sound = 'sound/items/tools/rped.ogg'

/datum/action/innate/ai/voice_changer
	name="变声器"
	button_icon_state = "voice_changer"
	desc = "允许你更改 AI 的嗓音。"
	auto_use_uses  = FALSE
	var/obj/machinery/ai_voicechanger/voice_changer_machine

/datum/action/innate/ai/voice_changer/Activate()
	if(!voice_changer_machine)
		voice_changer_machine = new(owner_AI)
	voice_changer_machine.ui_interact(usr)

/obj/machinery/ai_voicechanger
	name = "变声器"
	icon = 'icons/obj/machines/nuke_terminal.dmi'
	icon_state = "nuclearbomb_base"
	/// The AI this voicechanger belongs to
	var/mob/living/silicon/ai/owner
	/// Whether this AI is speaking loudly (bigger text)
	var/loudvoice = FALSE
	// Verb used when voicechanger is on
	var/say_verb
	/// Name used when voicechanger is on
	var/say_name
	/// Span used when voicechanger is on
	var/say_span
	/// TRUE if the AI is changing its voice
	var/changing_voice = FALSE
	/// Saved loudvoice state, used to restore after a voice change
	var/prev_loud
	/// Saved verb state, used to restore after a voice change
	var/prev_verbs
	/// Saved span state, used to restore after a voice change
	var/prev_span
	/// The list of available voices
	var/static/list/voice_options = list("normal", SPAN_ROBOT, SPAN_YELL, SPAN_CLOWN)

/obj/machinery/ai_voicechanger/Initialize(mapload)
	. = ..()
	if(!isAI(loc))
		return INITIALIZE_HINT_QDEL
	owner = loc
	owner.ai_voicechanger = src
	prev_verbs = list("say" = owner.verb_say, "ask" = owner.verb_ask, "exclaim" = owner.verb_exclaim , "yell" = owner.verb_yell  )
	prev_span = owner.speech_span
	say_name = owner.name
	say_verb = owner.verb_say
	say_span = owner.speech_span

/obj/machinery/ai_voicechanger/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AiVoiceChanger")
		ui.open()

/obj/machinery/ai_voicechanger/Destroy()
	if(owner)
		owner.ai_voicechanger = null
		owner = null
	return ..()

/obj/machinery/ai_voicechanger/ui_data(mob/user)
	var/list/data = list()
	data["voices"] = voice_options
	data["loud"] = loudvoice
	data["on"] = changing_voice
	data["say_verb"] = say_verb
	data["name"] = say_name
	data["selected"] = say_span || owner.speech_span
	return data

/obj/machinery/ai_voicechanger/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return
	switch(action)
		if("power")
			changing_voice = !changing_voice
			if(changing_voice)
				prev_verbs["say"] = owner.verb_say
				owner.verb_say	= say_verb
				prev_verbs["ask"] = owner.verb_ask
				owner.verb_ask	= say_verb
				prev_verbs["exclaim"] = owner.verb_exclaim
				owner.verb_exclaim	= say_verb
				prev_verbs["yell"] = owner.verb_yell
				owner.verb_yell	= say_verb
				prev_span = owner.speech_span
				owner.speech_span = say_span
				prev_loud = owner.radio.use_command
				owner.radio.use_command = loudvoice
			else
				owner.verb_say	= prev_verbs["say"]
				owner.verb_ask	= prev_verbs["ask"]
				owner.verb_exclaim	= prev_verbs["exclaim"]
				owner.verb_yell	= prev_verbs["yell"]
				owner.speech_span = prev_span
				owner.radio.use_command = prev_loud
		if("loud")
			loudvoice = !loudvoice
			if(changing_voice)
				owner.radio.use_command = loudvoice
		if("look")
			var/selection = params["look"]
			if(isnull(selection))
				return FALSE

			var/found = FALSE
			for(var/option in voice_options)
				if(option == selection)
					found = TRUE
					break
			if(!found)
				stack_trace("User attempted to select an unavailable voice option")
				return FALSE

			say_span = selection
			if(changing_voice)
				owner.speech_span = say_span
			to_chat(usr, span_notice("嗓音已设置为[selection]。"))
		if("verb")
			say_verb = strip_html(params["verb"], MAX_NAME_LEN)
			if(changing_voice)
				owner.verb_say = say_verb
				owner.verb_ask = say_verb
				owner.verb_exclaim = say_verb
				owner.verb_yell = say_verb
		if("name")
			say_name = strip_html(params["name"], MAX_NAME_LEN)

/datum/ai_module/malf/utility/emag
	name = "定点安全覆盖"
	description = "允许你禁用空间站上任何机器的安全装置，前提是你能接触到它。"
	cost = 20
	power_type = /datum/action/innate/ai/ranged/emag
	unlock_text = span_notice("你从辛迪加数据库泄露中下载了一个非法软件包并整合进自己的固件，期间还击退了几次内核入侵。")
	unlock_sound = SFX_SPARKS

/datum/action/innate/ai/ranged/emag
	name = "定点安全覆盖"
	desc = "让你可以对你点击的任何东西施加强力电磁干扰。"
	button_icon = 'icons/obj/card.dmi'
	button_icon_state = "emag"
	uses = 7
	auto_use_uses = FALSE
	enable_text = span_notice("你把辛迪加软件包载入最近使用的内存槽。")
	disable_text = span_notice("你卸载了辛迪加软件包。")
	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_target.dmi'

/datum/action/innate/ai/ranged/emag/Destroy()
	return ..()

/datum/action/innate/ai/ranged/emag/New()
	. = ..()
	desc = "[desc] 剩余 [uses] 次使用。"

/datum/action/innate/ai/ranged/emag/do_ability(mob/living/clicker, atom/clicked_on)

	// Only things with of or subtyped of any of these types may be remotely emagged
	var/static/list/compatable_typepaths = list(
		/obj/machinery,
		/obj/structure,
		/obj/item/radio/intercom,
		/obj/item/modular_computer,
		/mob/living/basic/bot,
		/mob/living/silicon,
	)

	if (!isAI(clicker))
		return FALSE

	var/mob/living/silicon/ai/ai_clicker = clicker

	if(ai_clicker.incapacitated)
		unset_ranged_ability(clicker)
		return FALSE

	if (!ai_clicker.can_see(clicked_on))
		clicked_on.balloon_alert(ai_clicker, "看不到！")
		return FALSE

	if (ismachinery(clicked_on))
		var/obj/machinery/clicked_machine = clicked_on
		if (!clicked_machine.is_operational)
			clicked_machine.balloon_alert(ai_clicker, "无法运行！")
			return FALSE

	if (!(is_type_in_list(clicked_on, compatable_typepaths)))
		clicked_on.balloon_alert(ai_clicker, "不兼容！")
		return FALSE

	if (istype(clicked_on, /obj/machinery/door/airlock)) // I HATE THIS CODE SO MUCHHH
		var/obj/machinery/door/airlock/clicked_airlock = clicked_on
		if (!clicked_airlock.canAIControl(ai_clicker))
			clicked_airlock.balloon_alert(ai_clicker, "无法接入！")
			return FALSE

	if (istype(clicked_on, /obj/machinery/airalarm))
		var/obj/machinery/airalarm/alarm = clicked_on
		if (alarm.aidisabled)
			alarm.balloon_alert(ai_clicker, "无法接入！")
			return FALSE

	if (istype(clicked_on, /obj/machinery/power/apc))
		var/obj/machinery/power/apc/clicked_apc = clicked_on
		if (clicked_apc.aidisabled)
			clicked_apc.balloon_alert(ai_clicker, "无法接入！")
			return FALSE

	if (!clicked_on.emag_act(ai_clicker))
		to_chat(ai_clicker, span_warning("敌对软件注入失败！")) // lets not overlap balloon alerts
		return FALSE

	to_chat(ai_clicker, span_notice("软件包已成功注入。"))

	adjust_uses(-1)
	if(uses)
		desc = "[initial(desc)] 剩余 [uses] 次使用。"
		build_all_button_icons()
	else
		unset_ranged_ability(ai_clicker, span_warning("使用次数耗尽！"))

	return TRUE

/datum/ai_module/malf/utility/core_tilt
	name = "滚动伺服"
	description = "让你能够缓慢滚动，用庞大的身躯碾碎挡路的一切。"
	cost = 10
	one_purchase = FALSE
	power_type = /datum/action/innate/ai/ranged/core_tilt
	unlock_sound = 'sound/effects/bang.ogg'
	unlock_text = span_notice("你获得了滚动碾碎挡路一切事物的能力。")

/datum/action/innate/ai/ranged/core_tilt
	name = "翻滚"
	button_icon_state = "roll_over"
	desc = "让你能够朝选定方向翻滚，碾碎挡路的一切。"
	auto_use_uses = FALSE
	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_target.dmi'
	uses = 20
	COOLDOWN_DECLARE(time_til_next_tilt)
	enable_text = span_notice("你的内部伺服开始调整，准备滚动。点击相邻格以滚过去！")
	disable_text = span_notice("你解除了滚动协议。")

	/// How long does it take for us to roll?
	var/roll_over_time = MALF_AI_ROLL_TIME
	/// On top of [roll_over_time], how long does it take for the ability to cooldown?
	var/roll_over_cooldown = MALF_AI_ROLL_COOLDOWN

/datum/action/innate/ai/ranged/core_tilt/New()
	. = ..()
	desc = "[desc] 剩余 [uses] 次使用。"

/datum/action/innate/ai/ranged/core_tilt/do_ability(mob/living/clicker, atom/clicked_on)

	if (!COOLDOWN_FINISHED(src, time_til_next_tilt))
		clicker.balloon_alert(clicker, "冷却中！")
		return FALSE

	if (!isAI(clicker))
		return FALSE
	var/mob/living/silicon/ai/ai_clicker = clicker

	if (ai_clicker.incapacitated || !isturf(ai_clicker.loc))
		return FALSE

	var/turf/target = get_turf(clicked_on)
	if (isnull(target))
		return FALSE

	if (target == ai_clicker.loc)
		target.balloon_alert(ai_clicker, "不能滚到自己身上！")
		return FALSE

	var/picked_dir = get_dir(ai_clicker, target)
	if (!picked_dir)
		return FALSE
	var/turf/temp_target = get_step(ai_clicker, picked_dir) // we can move during the timer so we cant just pass the ref

	new /obj/effect/temp_visual/telegraphing/vending_machine_tilt(temp_target, roll_over_time)
	ai_clicker.balloon_alert_to_viewers("滚动中……")
	addtimer(CALLBACK(src, PROC_REF(do_roll_over), ai_clicker, picked_dir), roll_over_time)

	adjust_uses(-1)
	if(uses)
		desc = "[initial(desc)] 剩余 [uses] 次使用。"
		build_all_button_icons()

	COOLDOWN_START(src, time_til_next_tilt, roll_over_cooldown)

/datum/action/innate/ai/ranged/core_tilt/proc/do_roll_over(mob/living/silicon/ai/ai_clicker, picked_dir)
	if (ai_clicker.incapacitated || !isturf(ai_clicker.loc)) // prevents bugs where the ai is carded and rolls
		return

	var/turf/target = get_step(ai_clicker, picked_dir) // in case we moved we pass the dir not the target turf

	if (isnull(target))
		return

	var/paralyze_time = clamp(6 SECONDS, 0 SECONDS, (roll_over_cooldown * 0.9)) //the clamp prevents stunlocking as the max is always a little less than the cooldown between rolls

	return ai_clicker.fall_and_crush(target, MALF_AI_ROLL_DAMAGE, MALF_AI_ROLL_CRIT_CHANCE, null, paralyze_time, picked_dir, rotation = get_rotation_from_dir(picked_dir))

/// Used in our radial menu, state-checking proc after the radial menu sleeps
/datum/action/innate/ai/ranged/core_tilt/proc/radial_check(mob/living/silicon/ai/clicker)
	if (QDELETED(clicker) || clicker.incapacitated || clicker.stat == DEAD)
		return FALSE

	if (uses <= 0)
		return FALSE

	return TRUE

/datum/action/innate/ai/ranged/core_tilt/proc/get_rotation_from_dir(dir)
	switch (dir)
		if (NORTH, NORTHWEST, WEST, SOUTHWEST)
			return 270 // try our best to not return 180 since it works badly with animate
		if (EAST, NORTHEAST, SOUTH, SOUTHEAST)
			return 90
		else
			stack_trace("non-standard dir entered to get_rotation_from_dir. (got: [dir])")
			return 0

/datum/ai_module/malf/utility/remote_vendor_tilt
	name = "远程推倒售货机"
	description = "让你远程朝任意方向推倒售货机。"
	cost = 15
	one_purchase = FALSE
	power_type = /datum/action/innate/ai/ranged/remote_vendor_tilt
	unlock_sound = 'sound/effects/bang.ogg'
	unlock_text = span_notice("你获得了远程将任意售货机推倒到相邻格的能力。")

/datum/action/innate/ai/ranged/remote_vendor_tilt
	name = "远程推倒售货机"
	desc = "使用以朝你想要的任意方向远程推倒售货机。"
	button_icon_state = "vendor_tilt"
	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_target.dmi'
	uses = VENDOR_TIPPING_USES
	var/time_to_tilt = MALF_VENDOR_TIPPING_TIME
	enable_text = span_notice("你准备晃动你看到的任何售货机。")
	disable_text = span_notice("你不再专注于推倒售货机。")

/datum/action/innate/ai/ranged/remote_vendor_tilt/New()
	. = ..()
	desc = "[desc] 剩余 [uses] 次使用。"

/datum/action/innate/ai/ranged/remote_vendor_tilt/do_ability(mob/living/clicker, atom/clicked_on)

	if (!isAI(clicker))
		return FALSE
	var/mob/living/silicon/ai/ai_clicker = clicker

	if(ai_clicker.incapacitated)
		unset_ranged_ability(clicker)
		return FALSE

	if(!isvendor(clicked_on))
		clicked_on.balloon_alert(ai_clicker, "不是售货机！")
		return FALSE

	var/obj/machinery/vending/clicked_vendor = clicked_on

	if (clicked_vendor.tilted)
		clicked_vendor.balloon_alert(ai_clicker, "已经被推倒了！")
		return FALSE

	if (!clicked_vendor.tiltable)
		clicked_vendor.balloon_alert(ai_clicker, "无法被推倒！")
		return FALSE

	if (!clicked_vendor.is_operational)
		clicked_vendor.balloon_alert(ai_clicker, "无法运行！")
		return FALSE

	var/picked_dir_string = show_radial_menu(ai_clicker, clicked_vendor, GLOB.all_radial_directions, custom_check = CALLBACK(src, PROC_REF(radial_check), clicker, clicked_vendor))
	if (isnull(picked_dir_string))
		return FALSE
	var/picked_dir = text2dir(picked_dir_string)

	var/turf/target = get_step(clicked_vendor, picked_dir)
	if (!ai_clicker.can_see(target))
		to_chat(ai_clicker, span_warning("你看不到目标格子！"))
		return FALSE

	new /obj/effect/temp_visual/telegraphing/vending_machine_tilt(target, time_to_tilt)
	clicked_vendor.visible_message(span_warning("[clicked_vendor]开始倒下……"))
	clicked_vendor.balloon_alert_to_viewers("正在倒下……")
	addtimer(CALLBACK(src, PROC_REF(do_vendor_tilt), clicked_vendor, target), time_to_tilt)

	adjust_uses(-1)
	if(uses)
		desc = "[initial(desc)] 剩余 [uses] 次使用。"
		build_all_button_icons()

	unset_ranged_ability(clicker, span_danger("正在推倒……"))
	return TRUE

/datum/action/innate/ai/ranged/remote_vendor_tilt/proc/do_vendor_tilt(obj/machinery/vending/vendor, turf/target)
	if (QDELETED(vendor))
		return FALSE

	if (vendor.tilted || !vendor.tiltable)
		return FALSE

	vendor.tilt(target, MALF_VENDOR_TIPPING_CRIT_CHANCE)

/// Used in our radial menu, state-checking proc after the radial menu sleeps
/datum/action/innate/ai/ranged/remote_vendor_tilt/proc/radial_check(mob/living/silicon/ai/clicker, obj/machinery/vending/clicked_vendor)
	if (QDELETED(clicker) || clicker.incapacitated || clicker.stat == DEAD)
		return FALSE

	if (QDELETED(clicked_vendor))
		return FALSE

	if (uses <= 0)
		return FALSE

	if (!clicker.can_see(clicked_vendor))
		to_chat(clicker, span_warning("失去了对[clicked_vendor]的视野！"))
		return FALSE

	return TRUE

#undef DEFAULT_DOOMSDAY_TIMER
#undef DOOMSDAY_ANNOUNCE_INTERVAL

#undef VENDOR_TIPPING_USES
#undef MALF_VENDOR_TIPPING_TIME
#undef MALF_VENDOR_TIPPING_CRIT_CHANCE

#undef MALF_AI_ROLL_COOLDOWN
#undef MALF_AI_ROLL_TIME
#undef MALF_AI_ROLL_DAMAGE
#undef MALF_AI_ROLL_CRIT_CHANCE
