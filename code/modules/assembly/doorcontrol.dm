/obj/item/assembly/control
	name = "控制器组件"
	desc = "一个控制某种东西的组件。它的设计如此含糊，大概本就不该存在。"
	icon_state = "control"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5)
	/// The ID of the electronics to match to the ID of the machine being used.
	var/id = -1
	/// Cooldown of the controller. Updates when pressed (activate())
	var/cooldown = FALSE
	/// Should we toggle open/close of doors based on their current state
	/// Also used for curtains
	var/sync_doors = TRUE
	/// If this controller's ID should be adjustable by players through multitools.
	var/generically_adjustable = FALSE
	/// If this controller's ID should be copyable by hitting with an identical controller.
	var/copyable = FALSE

/obj/item/assembly/control/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/assembly/control/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = NONE
	if(istype(held_item, type) && copyable)
		context[SCREENTIP_CONTEXT_LMB] = "复制 ID"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/assembly/control/examine(mob/user)
	. = ..()
	if(generically_adjustable)
		. += span_notice("你可以用[EXAMINE_HINT("多功能工具")]调整它的 ID。")

	if(copyable)
		. += span_notice("你可以与另一个控制器交互，以复制其 ID。")

	if(!id)
		return

	if(id != -1)
		. += span_notice("其频道 ID 为“[id]”。")

/obj/item/assembly/control/multitool_act(mob/living/user)
	if(!generically_adjustable)
		return

	var/change_id = tgui_input_number(user, "设置[name]的 ID", "控制器 ID", id, 100)
	if(!change_id || QDELETED(user) || QDELETED(src) || !usr.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	id = change_id
	to_chat(user, span_notice("你把 ID 改为[id]。"))

/obj/item/assembly/control/interact_with_atom(obj/item/assembly/control/interacting_with, mob/living/user, list/modifiers)
	. = NONE
	if(!copyable)
		return

	if(istype(interacting_with))
		id = interacting_with.id
		balloon_alert(user, "ID 已更改")
		return ITEM_INTERACT_SUCCESS

/obj/item/assembly/control/blast_door
	name = "防爆门控制器"
	desc = "一个小型电子装置，可远程控制防爆门或卷帘。"
	copyable = TRUE

/obj/item/assembly/control/blast_door/examine(mob/user)
	. = ..()
	if(id && id == -1)
		. += span_notice("与防爆门或卷帘交互以生成新的 ID")

/obj/item/assembly/control/blast_door/multitool_act(mob/living/user)
	var/list/door_ids = list()
	var/list/display_ids = list("UNIQUE")
	for(var/obj/machinery/door/poddoor/M as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/poddoor))
		if(!M.id || (M.id in door_ids))
			continue
		door_ids += "[M.id]"
		if(M.owner?.resolve() != user)
			continue
		var/area/door_area = get_area(M)
		display_ids += "[door_area.name]([M.id])"

	var/change_id = tgui_input_list(user, "设置控制器 ID", "控制器 ID", display_ids)
	if(!change_id || QDELETED(user) || QDELETED(src) || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return

	if(change_id == "UNIQUE")
		id = -1
	else
		var/start = findtext(change_id, "(") + 1
		var/end = length(change_id) - 1
		if(start == end)
			id = "[change_id[start]]"
		else
			id = copytext(change_id, start, end)
	balloon_alert(user, "ID 已更改")
	if(id != -1)
		to_chat(user, span_notice("你把 ID 改为[id]。"))
	else
		to_chat(user, span_notice("现在你必须与一扇舱门交互，才能生成唯一的 ID。"))

/obj/item/assembly/control/blast_door/activate()
	var/openclose
	if(cooldown)
		return
	cooldown = TRUE
	for(var/obj/machinery/door/poddoor/M as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/poddoor))
		if(M.id == src.id)
			if(openclose == null || !sync_doors)
				openclose = M.density
			INVOKE_ASYNC(M, openclose ? TYPE_PROC_REF(/obj/machinery/door/poddoor, open) : TYPE_PROC_REF(/obj/machinery/door/poddoor, close))
	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 1 SECONDS)

/obj/item/assembly/control/curtain
	name = "窗帘控制器"
	desc = "一个小型电子装置，可远程控制机械窗帘。"

/obj/item/assembly/control/curtain/activate()
	var/openclose
	if(cooldown)
		return
	cooldown = TRUE
	for(var/obj/structure/curtain/cloth/fancy/mechanical/M in GLOB.curtains)
		if(M.id == src.id)
			if(openclose == null || !sync_doors)
				openclose = M.density
			INVOKE_ASYNC(M, openclose ? TYPE_PROC_REF(/obj/structure/curtain/cloth/fancy/mechanical, open) : TYPE_PROC_REF(/obj/structure/curtain/cloth/fancy/mechanical, close))
	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 0.5 SECONDS)


/obj/item/assembly/control/airlock
	name = "气闸控制器"
	desc = "一个小型电子装置，可远程控制气闸。"
	id = "badmin" // Set it to null for MEGAFUN.
	var/specialfunctions = OPEN
	/*
	Bitflag, 1= open (OPEN)
				2= idscan (IDSCAN)
				4= bolts (BOLTS)
				8= shock (SHOCK)
				16= door safties (SAFE)
	*/

/obj/item/assembly/control/airlock/activate()
	if(cooldown)
		return
	cooldown = TRUE
	var/doors_need_closing = FALSE
	var/list/obj/machinery/door/airlock/open_or_close = list()
	for(var/obj/machinery/door/airlock/D as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/airlock))
		if(D.id_tag == src.id)
			if(specialfunctions & OPEN)
				open_or_close += D
				if(!D.density)
					doors_need_closing = TRUE
			if(specialfunctions & IDSCAN)
				D.aiDisabledIdScanner = !D.aiDisabledIdScanner
			if(specialfunctions & BOLTS)
				if(!D.wires.is_cut(WIRE_BOLTS) && D.hasPower())
					if(D.locked)
						D.unlock()
					else
						D.lock()
					D.update_appearance()
			if(specialfunctions & SHOCK)
				if(D.secondsElectrified)
					D.set_electrified(MACHINE_ELECTRIFIED_PERMANENT, usr)
				else
					D.set_electrified(MACHINE_NOT_ELECTRIFIED, usr)
			if(specialfunctions & SAFE)
				D.safe = !D.safe

	for(var/D in open_or_close)
		INVOKE_ASYNC(D,  doors_need_closing ? TYPE_PROC_REF(/obj/machinery/door/airlock, close) : TYPE_PROC_REF(/obj/machinery/door/airlock, open))

	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 1 SECONDS)


/obj/item/assembly/control/massdriver
	name = "质量驱动器控制器"
	desc = "一个小型电子装置，可控制质量驱动器。"

/obj/item/assembly/control/massdriver/activate()
	if(cooldown)
		return
	cooldown = TRUE
	for(var/obj/machinery/door/poddoor/M as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/poddoor))
		if (M.id == src.id)
			INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/machinery/door/poddoor, open))

	addtimer(CALLBACK(src, PROC_REF(activate_stage2)), 1 SECONDS)

/obj/item/assembly/control/massdriver/proc/activate_stage2()
	for(var/obj/machinery/mass_driver/M as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/mass_driver))
		if(M.id == src.id)
			M.drive()

	addtimer(CALLBACK(src, PROC_REF(activate_stage3)), 6 SECONDS)

/obj/item/assembly/control/massdriver/proc/activate_stage3()
	for(var/obj/machinery/door/poddoor/M as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/poddoor))
		if (M.id == src.id)
			INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/machinery/door/poddoor, close))

	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 1 SECONDS)


/obj/item/assembly/control/igniter
	name = "点火控制器"
	desc = "用于地板点火器或墙壁电火花器的遥控器。"
	generically_adjustable = TRUE
	copyable = TRUE
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/assembly/control/igniter/activate()
	if(cooldown)
		return
	cooldown = TRUE
	for(var/obj/machinery/sparker/M as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/sparker))
		if (M.id == src.id)
			INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/machinery/sparker, ignite))

	for(var/obj/machinery/igniter/M as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/igniter))
		if(M.id == src.id)
			INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/machinery/igniter, toggle))

	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 3 SECONDS)

/obj/item/assembly/control/flasher
	name = "闪光器控制器"
	desc = "用于壁挂式闪光器的遥控器。"

/obj/item/assembly/control/flasher/activate()
	if(cooldown)
		return
	cooldown = TRUE
	for(var/obj/machinery/flasher/M as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/flasher))
		if(M.id == src.id)
			INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/machinery/flasher, flash))

	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 5 SECONDS)


/obj/item/assembly/control/crematorium
	name = "火葬场控制器"
	desc = "一个看起来邪恶的火葬场遥控器。"

/obj/item/assembly/control/crematorium/activate()
	if(cooldown)
		return
	cooldown = TRUE
	for (var/obj/structure/bodycontainer/crematorium/C in GLOB.crematoriums)
		if (C.id == id)
			C.cremate(usr)

	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 5 SECONDS)
