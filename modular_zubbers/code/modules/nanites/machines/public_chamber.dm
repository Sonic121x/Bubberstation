/obj/machinery/public_nanite_chamber
	name = "公共纳米机器人舱"
	desc = "一种无需外部操作员即可快速植入云端同步纳米机器人的装置。"
	circuit = /obj/item/circuitboard/machine/public_nanite_chamber
	icon = 'icons/obj/machines/bci_implanter.dmi'
	icon_state = "bci_implanter"
	base_icon_state = "bci_implanter"
	layer = ABOVE_WINDOW_LAYER
	use_power = IDLE_POWER_USE
	anchored = TRUE
	density = TRUE
	idle_power_usage = 50
	active_power_usage = 300

	var/cloud_id = 1
	var/locked = FALSE
	var/breakout_time = 1200
	var/busy = FALSE
	var/busy_icon_state
	var/message_cooldown = 0

/obj/machinery/public_nanite_chamber/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	occupant_typecache = GLOB.typecache_living

/obj/machinery/public_nanite_chamber/RefreshParts()
	. = ..()
	var/obj/item/circuitboard/machine/public_nanite_chamber/board = circuit
	if(board)
		cloud_id = board.cloud_id

/obj/machinery/public_nanite_chamber/proc/set_busy(status, working_icon)
	busy = status
	busy_icon_state = working_icon
	update_appearance()

/obj/machinery/public_nanite_chamber/proc/inject_nanites(mob/living/attacker)
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if((machine_stat & MAINT) || panel_open)
		return
	if(!occupant || busy)
		return

	var/locked_state = locked
	locked = TRUE

	//TODO OMINOUS MACHINE SOUNDS
	set_busy(TRUE, "[initial(icon_state)]_raising")
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "[initial(icon_state)]_active"), 20)
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "[initial(icon_state)]_falling"), 60)
	addtimer(CALLBACK(src, PROC_REF(complete_injection), locked_state, attacker), 80)

/obj/machinery/public_nanite_chamber/proc/complete_injection(locked_state, mob/living/attacker)
	//TODO MACHINE DING
	locked = locked_state
	set_busy(FALSE)
	if(!occupant)
		return
	if(attacker)
		occupant.investigate_log("被 [key_name(attacker)] 使用 [src] 在 [AREACOORD(src)] 注入了云 ID 为 [cloud_id] 的纳米机器人。", INVESTIGATE_NANITES)
		log_combat(attacker, occupant, "向以下对象注射了纳米机器人", null, "通过 [src]")
	occupant.AddComponent(/datum/component/nanites, 75, cloud_id)

/obj/machinery/public_nanite_chamber/proc/change_cloud(mob/living/attacker)
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if((machine_stat & MAINT) || panel_open)
		return
	if(!occupant || busy)
		return

	var/locked_state = locked
	locked = TRUE

	set_busy(TRUE, "[initial(icon_state)]_raising")
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "[initial(icon_state)]_active"), 20)
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "[initial(icon_state)]_falling"), 40)
	addtimer(CALLBACK(src, PROC_REF(complete_cloud_change), locked_state, attacker), 60)

/obj/machinery/public_nanite_chamber/proc/complete_cloud_change(locked_state, mob/living/attacker)
	locked = locked_state
	set_busy(FALSE)
	if(!occupant)
		return
	if(attacker)
		occupant.investigate_log("其纳米机器人云 ID 被 [key_name(attacker)] 使用 [src] 在 [AREACOORD(src)] 改为 [cloud_id]。", INVESTIGATE_NANITES)
	SEND_SIGNAL(occupant, COMSIG_NANITE_SET_CLOUD, cloud_id)

/obj/machinery/public_nanite_chamber/update_icon_state()
	//running and someone in there
	if(occupant)
		icon_state = busy ? busy_icon_state : "[base_icon_state]_occupied"
		return ..()
	//running
	icon_state = "[base_icon_state][state_open ? "_open" : null]"
	return ..()

/obj/machinery/public_nanite_chamber/update_overlays()
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

/obj/machinery/public_nanite_chamber/proc/toggle_open(mob/user)
	if(panel_open)
		to_chat(user, span_notice("请先关闭维修面板。"))
		return

	if(state_open)
		close_machine(null, user)
		return

	else if(locked)
		to_chat(user, span_notice("插销已锁死，舱门被牢牢固定。"))
		return

	open_machine()

/obj/machinery/public_nanite_chamber/container_resist_act(mob/living/user)
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

/obj/machinery/public_nanite_chamber/close_machine(mob/living/carbon/user, density_to_set = TRUE)
	if(!state_open)
		return FALSE

	..()

	. = TRUE

	addtimer(CALLBACK(src, PROC_REF(try_inject_nanites), user), 3 SECONDS) //If someone is shoved in give them a chance to get out before the injection starts

/obj/machinery/public_nanite_chamber/proc/try_inject_nanites(mob/living/attacker)
	if(occupant)
		var/mob/living/L = occupant
		if(SEND_SIGNAL(L, COMSIG_HAS_NANITES))
			var/datum/component/nanites/nanites = L.GetComponent(/datum/component/nanites)
			if(nanites && nanites.cloud_id != cloud_id)
				change_cloud(attacker)
			return
		if(CAN_HAVE_NANITES(L))
			inject_nanites(attacker)

/obj/machinery/public_nanite_chamber/open_machine(drop = TRUE, density_to_set = FALSE)
	. = ..()
	if(state_open)
		return FALSE

	..()

	return TRUE

/obj/machinery/public_nanite_chamber/relaymove(mob/living/user, direction)
	if(user.stat || locked)
		if(message_cooldown <= world.time)
			message_cooldown = world.time + 50
			to_chat(user, span_warning("[src] 的舱门纹丝不动！"))
		return
	open_machine()

/obj/machinery/public_nanite_chamber/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(occupant)
		balloon_alert(user, "有人在内！")
		return ITEM_INTERACT_BLOCKING
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/public_nanite_chamber/attackby(obj/item/I, mob/user, params)
	if(default_pry_open(I))
		return

	if(default_deconstruction_crowbar(I))
		return

	return ..()

/obj/machinery/public_nanite_chamber/interact(mob/user)
	toggle_open(user)

/obj/machinery/public_nanite_chamber/mouse_drop_receive(mob/living/M, mob/user, params)
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH | SILENT_ADJACENCY) || !iscarbon(M))
		return
	if(close_machine(M, user))
		log_combat(user, M, "将以下对象塞入", null, "进入 [src]")
	add_fingerprint(user)
