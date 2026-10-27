#define ARRIVALS_STATION "arrivals_stationary"
#define ARRIVALS_INTERLINK "arrivals_shuttle"
#define CONSOLE_ANNOUNCE_COOLDOWN 5 SECONDS

/obj/docking_port/mobile/arrivals_skyrat
	name = "NTV 中继号"
	shuttle_id = "arrivals_shuttle"
	dir = WEST
	port_direction = SOUTH

	callTime = 15 SECONDS
	ignitionTime = 6 SECONDS
	rechargeTime = 15 SECONDS

	movement_force = list("KNOCKDOWN" = 3, "THROW" = 0)

	///Our shuttle's control console
	var/obj/machinery/computer/shuttle/arrivals/console
	///How much time are we waiting before returning to interlink. Sets itself automatically from config file. 0 = no auto return
	var/wait_time
	///State variable. True when our shuttle is waiting before autoreturn
	var/waiting = FALSE // would've been better to use shuttle's mode variable, but check() resets it to SHUTTLE_IDLE so it's more sane way to make this fully modular

/obj/docking_port/mobile/arrivals_skyrat/Initialize(mapload)
	. = ..()
	wait_time = CONFIG_GET(number/arrivals_wait)
	return INITIALIZE_HINT_LATELOAD

/obj/docking_port/mobile/arrivals_skyrat/LateInitialize()
	console = get_control_console()

/obj/docking_port/mobile/arrivals_skyrat/check()
	. = ..()

	if(!wait_time) //0 disables autoreturn
		return

	if(mode != SHUTTLE_IDLE)
		return

	if(waiting && !timer)
		SSshuttle.moveShuttle(shuttle_id, ARRIVALS_INTERLINK, TRUE) // times up, we're leaving
		waiting = FALSE

	var/current_dock = getDockedId()
	if (current_dock != ARRIVALS_STATION)
		return

	if(check_occupied())
		if(!waiting)
			return

		timer = 0
		waiting = FALSE

		if(console && console.last_cancel_announce + CONSOLE_ANNOUNCE_COOLDOWN <= world.time)
			console.say("检测到舱内有生命体征，自动返航已中止。")
			console.last_cancel_announce = world.time

		return

	if(timer || waiting)
		return

	setTimer(wait_time)
	waiting = TRUE

	if(console && console.last_depart_announce + CONSOLE_ANNOUNCE_COOLDOWN <= world.time)
		console.say("将在 [wait_time / 10] 秒后启动自动返航子程序。")
		console.last_depart_announce = world.time

/obj/docking_port/mobile/arrivals_skyrat/getModeStr()
	. = ..()
	return waiting ? "RTN" : .

/**
 * Checks if our shuttle is occupied by someone alive, and returns `TRUE` if it is, `FALSE` otherwise.
*/
/obj/docking_port/mobile/arrivals_skyrat/proc/check_occupied()
	for(var/alive_player in GLOB.alive_player_list)
		if (get_area(alive_player) in shuttle_areas)
			return TRUE

	return FALSE

/obj/machinery/computer/shuttle/arrivals
	name = "抵达穿梭机控制台"
	desc = "用于控制抵达接驳穿梭机的终端。"
	shuttleId = "arrivals_shuttle"
	possible_destinations = "arrivals_stationary;arrivals_shuttle"
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/computer.dmi'
	icon_state = "computer_frame"
	icon_keyboard = "arrivals_key"
	icon_screen = "arrivals"
	light_color = COLOR_ORANGE_BROWN
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	connectable = FALSE //connecting_computer change: since icon_state is not a typical console, it cannot be connectable.
	no_destination_swap = TRUE

	///[world.time] when console last announced departure
	var/last_depart_announce
	///[world.time] when console last announced canceling shuttle's return
	var/last_cancel_announce

/obj/machinery/computer/shuttle/arrivals/recall
	name = "抵达穿梭机召回终端"
	desc = "如果你的朋友把你落下了，就用这个。"
	possible_destinations = "arrivals_stationary;arrivals_shuttle"

/*
*	MAP TEMPLATES
*/

/datum/map_template/shuttle/ferry
	name = "NAV Monarch (Ferry)"
	prefix = "_maps/shuttles/skyrat/"
	port_id = "ferry"
	suffix = "skyrat"
	who_can_purchase = null

/datum/map_template/shuttle/cargo/skyrat
	name = "NLV Consign (Cargo)"
	prefix = "_maps/shuttles/skyrat/"
	port_id = "cargo"
	suffix = "skyrat"

/datum/map_template/shuttle/cargo/skyrat/delta
	suffix = "delta_skyrat"	//I hate this. Delta station is one tile different docking-wise, which fucks it ALL up unless we either a) change the map (this would be nonmodular and also press the engine against disposals) or b) this (actually easy, just dumb)

/datum/map_template/shuttle/whiteship/blueshift
	name = "SFS Christian"
	description = "一艘大型轻型护卫舰，似乎遭到了某种外星生物侵染的攻击。若能清理干净并修复，将是一笔真正的财富。"
	prefix = "_maps/shuttles/skyrat/"
	port_id = "whiteship"
	suffix = "blueshift"

/datum/map_template/shuttle/cargo/skyrat/ouroboros
	suffix = "ouroboros"

/datum/map_template/shuttle/whiteship/ouroboros
	name = "JN Chasse-Galerie"
	description = "一艘吉姆·诺顿的小型穿梭机，本打算用作移动咖啡馆。船上没有敌对生物，但有多具吉姆·诺顿员工的尸体。"
	prefix = "_maps/shuttles/skyrat/"
	port_id = "whiteship"
	suffix = "ouroboros"

/datum/map_template/shuttle/arrivals_skyrat
	name = "NTV Relay (Arrivals)"
	prefix = "_maps/shuttles/skyrat/"
	port_id = "arrivals"
	suffix = "skyrat"
	who_can_purchase = null

/datum/map_template/shuttle/emergency/default
	prefix = "_maps/shuttles/skyrat/"
	suffix = "skyrat"
	name = "Standard Emergency Shuttle"
	description = "纳米传讯的标准配发紧急穿梭机。"
	occupancy_limit = 60

/datum/map_template/shuttle/labour/skyrat
	name = "NMC Drudge (Labour)"
	prefix = "_maps/shuttles/skyrat/"
	suffix = "skyrat"

/obj/docking_port/stationary/laborcamp_home
	roundstart_template = /datum/map_template/shuttle/labour/skyrat

/obj/docking_port/stationary/laborcamp_home/kilo
	roundstart_template = /datum/map_template/shuttle/labour/skyrat

/datum/map_template/shuttle/mining_common/skyrat
	name = "NMC Chimera (Mining)"
	prefix = "_maps/shuttles/skyrat/"
	suffix = "skyrat"

/obj/docking_port/stationary/mining_home/common
	roundstart_template = /datum/map_template/shuttle/mining_common/skyrat

/obj/docking_port/stationary/mining_home/common/kilo
	roundstart_template = /datum/map_template/shuttle/mining_common/skyrat

/datum/map_template/shuttle/mining/skyrat
	name = "NMC Phoenix (Mining)"
	prefix = "_maps/shuttles/skyrat/"
	suffix = "skyrat"

/obj/docking_port/stationary/mining_home
	roundstart_template = /datum/map_template/shuttle/mining/skyrat

/datum/map_template/shuttle/mining/skyrat/large
	name = "NMC Manticore (Mining)"
	suffix = "large_skyrat"

#undef ARRIVALS_STATION
#undef ARRIVALS_INTERLINK
#undef CONSOLE_ANNOUNCE_COOLDOWN
