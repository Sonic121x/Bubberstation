/obj/machinery/nanite_chamber
	name = "纳米机器人舱"
	desc = "一种能够扫描、重新编程并注射纳米机器人的装置。"
	circuit = /obj/item/circuitboard/machine/nanite_chamber
	icon = 'icons/obj/machines/bci_implanter.dmi'
	icon_state = "bci_implanter"
	base_icon_state = "bci_implanter"
	layer = ABOVE_WINDOW_LAYER
	use_power = IDLE_POWER_USE
	anchored = TRUE
	density = TRUE
	idle_power_usage = 50
	active_power_usage = 300

	var/locked = FALSE
	var/breakout_time = 1200
	var/scan_level
	var/busy = FALSE
	var/busy_icon_state
	var/busy_message
	var/message_cooldown = 0

/obj/machinery/nanite_chamber/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	occupant_typecache = GLOB.typecache_living

/obj/machinery/nanite_chamber/RefreshParts()
	. = ..()
	scan_level = 0
	for(var/datum/stock_part/P in component_parts)
		scan_level += P.tier

/obj/machinery/nanite_chamber/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("状态显示屏显示：扫描模块已升级至 <b>[scan_level]</b> 级。")

/obj/machinery/nanite_chamber/proc/set_busy(status, message, working_icon)
	busy = status
	busy_message = message
	busy_icon_state = working_icon
	update_appearance()

/obj/machinery/nanite_chamber/proc/set_safety(threshold)
	if(!occupant)
		return
	SEND_SIGNAL(occupant, COMSIG_NANITE_SET_SAFETY, threshold)

/obj/machinery/nanite_chamber/proc/set_cloud(cloud_id)
	if(!occupant)
		return
	SEND_SIGNAL(occupant, COMSIG_NANITE_SET_CLOUD, cloud_id)

/obj/machinery/nanite_chamber/proc/inject_nanites()
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if((machine_stat & MAINT) || panel_open)
		return
	if(!occupant || busy)
		return

	var/locked_state = locked
	locked = TRUE

	//TODO OMINOUS MACHINE SOUNDS
	set_busy(TRUE, "正在初始化注射协议……", "[initial(icon_state)]_raising")
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "正在分析宿主的生物结构……", "[initial(icon_state)]_active"), 20)
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "正在预备纳米机器人……", "[initial(icon_state)]_active"), 40)
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "正在注射……", "[initial(icon_state)]_active"), 70)
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "正在激活纳米机器人……", "[initial(icon_state)]_falling"), 110)
	addtimer(CALLBACK(src, PROC_REF(complete_injection), locked_state), 130)

/obj/machinery/nanite_chamber/proc/complete_injection(locked_state)
	//TODO MACHINE DING
	locked = locked_state
	set_busy(FALSE)
	if(!occupant)
		return
	occupant.AddComponent(/datum/component/nanites, 100)

/obj/machinery/nanite_chamber/proc/remove_nanites(datum/nanite_program/NP)
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if((machine_stat & MAINT) || panel_open)
		return
	if(!occupant || busy)
		return

	var/locked_state = locked
	locked = TRUE

	//TODO OMINOUS MACHINE SOUNDS
	set_busy(TRUE, "正在初始化清理协议……", "[initial(icon_state)]_raising")
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "正在分析宿主的生物结构……", "[initial(icon_state)]_active"), 20)
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "正在呼叫纳米机器人……", "[initial(icon_state)]_active"), 40)
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "正在启动优雅自毁程序……", "[initial(icon_state)]_active"), 70)
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "正在清理残骸……", "[initial(icon_state)]_falling"), 110)
	addtimer(CALLBACK(src, PROC_REF(complete_removal), locked_state), 130)

/obj/machinery/nanite_chamber/proc/complete_removal(locked_state)
	//TODO MACHINE DING
	locked = locked_state
	set_busy(FALSE)
	if(!occupant)
		return
	SEND_SIGNAL(occupant, COMSIG_NANITE_DELETE)

/obj/machinery/nanite_chamber/update_icon_state()
	//running and someone in there
	if(occupant)
		icon_state = busy ? busy_icon_state : "[base_icon_state]_occupied"
		return ..()
	//running
	icon_state = "[base_icon_state][state_open ? "_open" : null]"
	return ..()

/obj/machinery/nanite_chamber/update_overlays()
	. = ..()

	if((machine_stat & MAINT) || panel_open)
		. += "maint"
		return

	if(machine_stat & (NOPOWER|BROKEN))
		return

	if(busy || locked)
		. += "red"
		if(locked)
			. += "bolted"
		return

	. += "green"

/obj/machinery/nanite_chamber/proc/toggle_open(mob/user)
	if(panel_open)
		to_chat(user, span_notice("请先关闭维修面板。"))
		return

	if(state_open)
		close_machine()
		return

	else if(locked)
		to_chat(user, span_notice("插销已锁死，舱门被牢牢固定。"))
		return

	open_machine()

/obj/machinery/nanite_chamber/container_resist_act(mob/living/user)
	if(!locked)
		open_machine()
		return
	if(busy)
		return
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_notice("你看到 [user] 正在猛踹 [src] 的舱门！"), \
		span_notice("你靠住 [src] 的后壁，开始用力推门……（大约需要 [DisplayTimeText(breakout_time)]。）"), \
		span_hear("你听到 [src] 传来金属吱嘎声。"))
	if(do_after(user,(breakout_time), target = src))
		if(!user || !IS_UNCONSCIOUS_OR_CRIT(user) || user.loc != src || state_open || !locked || busy)
			return
		locked = FALSE
		user.visible_message(span_warning("[user] 成功从 [src] 中挣脱！"), \
			span_notice("你成功从 [src] 中挣脱！"))
		open_machine()

/obj/machinery/nanite_chamber/close_machine(mob/living/carbon/user, density_to_set = TRUE)
	if(!state_open)
		return FALSE

	..(user)
	return TRUE

/obj/machinery/nanite_chamber/open_machine(drop = TRUE, density_to_set = FALSE)
	if(state_open)
		return FALSE

	..()

	return TRUE

/obj/machinery/nanite_chamber/relaymove(mob/living/user, direction)
	if(user.stat || locked)
		if(message_cooldown <= world.time)
			message_cooldown = world.time + 50
			to_chat(user, span_warning("[src] 的舱门纹丝不动！"))
		return
	open_machine()

/obj/machinery/nanite_chamber/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(occupant)
		balloon_alert(user, "有人在内！")
		return ITEM_INTERACT_BLOCKING
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/nanite_chamber/attackby(obj/item/I, mob/user, params)
	if(default_pry_open(I))
		return

	if(default_deconstruction_crowbar(I))
		return

	return ..()

/obj/machinery/nanite_chamber/interact(mob/user)
	toggle_open(user)

/obj/machinery/nanite_chamber/mouse_drop_receive(atom/target, mob/user, params)
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH|SILENT_ADJACENCY) || !iscarbon(target))
		return
	if(close_machine(target))
		log_combat(user, target, "将以下对象塞入", null, "进入 [src]")
	add_fingerprint(user)
