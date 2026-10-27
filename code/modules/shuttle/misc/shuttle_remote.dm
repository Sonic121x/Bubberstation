/obj/item/shuttle_remote
	name = "穿梭机遥控器"
	desc = "用于派遣或召回穿梭机的遥控器。"
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "shuttleremote"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	/// if the docks may be changed
	var/may_change_docks = TRUE //if this is set to FALSE make sure the shuttle it will be linked to does NOT get to have multiple instances of itself
	/// the port where the shuttle leaves to
	var/shuttle_away_id = "whiteship_lavaland"
	/// the port where the shuttle returns to
	var/shuttle_home_id = "whiteship_home"
	/// var which will hold the nav computer
	var/datum/weakref/computer_ref
	/// var which will hold the mobile port
	var/obj/docking_port/mobile/our_port

/obj/item/shuttle_remote/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	var/obj/machinery/computer/shuttle/our_computer = computer_ref?.resolve()
	if(may_change_docks && our_computer)
		context[SCREENTIP_CONTEXT_LMB] = "使用"
		context[SCREENTIP_CONTEXT_ALT_RMB] = "更换穿梭机停靠点"

/obj/item/shuttle_remote/examine(mob/user)
	. = ..()
	var/obj/machinery/computer/shuttle/our_computer = computer_ref?.resolve()
	if(may_change_docks && our_computer)
		. += span_notice("你可以用[EXAMINE_HINT("Alt 右键")]更改 [get_area_name(SSshuttle.getShuttle(our_computer.shuttleId))] 的停靠位置。")

/obj/item/shuttle_remote/Initialize(mapload)
	. = ..()
	if(!mapload)
		return
	var/obj/machinery/computer/shuttle/computer = locate(/obj/machinery/computer/shuttle) in loc
	if(!computer)
		return
	computer.remote_ref = WEAKREF(src)
	computer_ref = WEAKREF(computer)

/obj/item/shuttle_remote/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/machinery/computer/shuttle/our_computer = computer_ref?.resolve()
	if(!istype(interacting_with, /obj/machinery/computer/shuttle))
		return NONE
	if(our_computer || our_port)
		balloon_alert(user, "已链接！")
		return ITEM_INTERACT_BLOCKING
	var/obj/machinery/computer/shuttle/new_computer = interacting_with
	if(new_computer.remote_ref || !new_computer.may_be_remote_controlled)
		balloon_alert(user, "信号已被占用！")
		return ITEM_INTERACT_BLOCKING
	new_computer.remote_ref = WEAKREF(src)
	computer_ref = WEAKREF(new_computer)
	our_port = SSshuttle.getShuttle(new_computer.shuttleId)
	playsound(src, 'sound/machines/beep/beep.ogg', 30)
	balloon_alert(user, "已链接")
	return ITEM_INTERACT_SUCCESS

/obj/item/shuttle_remote/attack_self(mob/user)
	var/obj/machinery/computer/shuttle/our_computer = computer_ref?.resolve()
	if(!our_port)
		our_port = SSshuttle.getShuttle(our_computer.shuttleId) //incase we were maploaded
	if(!can_use(user))
		return

	var/obj/docking_port/home = SSshuttle.getDock(shuttle_home_id)
	var/obj/docking_port/away = SSshuttle.getDock(shuttle_away_id)
	var/obj/docking_port/dock = our_port.get_docked()

	var/send_off_text = "你确定要将 [get_area_name(SSshuttle.getShuttle(our_computer.shuttleId))] 派遣到 [away.name] 吗？"
	var/list/send_off_options = list("是", "否")
	var/destination = null

	if(home == dock || ("[our_computer.shuttleId]_custom" == dock.shuttle_id))
		switch(tgui_alert(user, send_off_text, "派遣穿梭机？", send_off_options))
			if("是")
				destination = away.shuttle_id
	else if(away == dock)
		send_off_text = "你确定要将 [get_area_name(SSshuttle.getShuttle(our_computer.shuttleId))] 召唤到 [home.name] 吗？"
		for(var/list/possible_destinations in our_computer.get_valid_destinations())
			if(LAZYACCESS(possible_destinations, "id") == "[our_computer.shuttleId]_custom")
				send_off_text += "\n\n已加载自定义位置，尝试停靠？"
				send_off_options += "送往自定义位置"
				break
		switch(tgui_alert(user, send_off_text, "召唤穿梭机？", send_off_options))
			if("是")
				destination = home.shuttle_id
			if("送往自定义位置")
				destination = "[our_computer.shuttleId]_custom"

	if(!destination || !can_use(user))
		return
	if(!our_port.canDock(SSshuttle.getDock(destination)))
		balloon_alert(user, "目的地已被占用！")
		return
	transit_shuttle(user, destination)

/obj/item/shuttle_remote/click_alt_secondary(mob/user)
	var/obj/machinery/computer/shuttle/our_computer = computer_ref?.resolve()
	if(!may_change_docks || !our_computer)
		return NONE
	var/list/destinations_list = our_computer.get_valid_destinations()
	var/list/destination_names = list()
	var/list/destination_ids = list()
	for(var/list/destination_data in destinations_list)
		if((destination_data["id"] == shuttle_away_id) || (destination_data["id"] == shuttle_home_id))
			continue //don't display ports that are already designated
		if(destination_data["id"] == "[our_computer.shuttleId]_custom")
			continue //we already handle custom docking
		LAZYADD(destination_names, destination_data["name"])
		LAZYADDASSOC(destination_ids, destination_data["name"], destination_data["id"])
	if(destination_names.len < 1)
		balloon_alert(user, "没有有效的目的地！")
		return NONE
	var/picked_home = tgui_input_list(user, "选择要指定为穿梭机母港的停靠点……", "选择母港停靠点", destination_names)
	var/picked_away = tgui_input_list(user, "选择要指定为穿梭机外派点的停靠点……", "选择外派停靠点", destination_names)
	if(picked_home && can_use(user))
		shuttle_home_id = LAZYACCESS(destination_ids, picked_home)
	if(picked_away && can_use(user))
		shuttle_away_id = LAZYACCESS(destination_ids, picked_away)
	return CLICK_ACTION_SUCCESS

/obj/item/shuttle_remote/proc/can_use(mob/user)
	var/obj/machinery/computer/shuttle/our_computer = computer_ref?.resolve()
	if(!user.can_perform_action(src))
		return FALSE
	if(is_reserved_level(loc.z))
		balloon_alert(user, "无法在此使用！")
		return FALSE
	if(!our_computer)
		balloon_alert(user, "没有导航计算机！")
		return FALSE
	if(our_computer.locked)
		balloon_alert(user, "导航计算机已锁定！")
		return FALSE
	if(our_port.mode != SHUTTLE_IDLE)
		balloon_alert(user, "引擎充能中！")
		return FALSE
	if(!our_port.canDock(SSshuttle.getDock(shuttle_home_id)))
		balloon_alert(user, "母港停靠点已被占用！")
		return FALSE
	if(!our_port.canDock(SSshuttle.getDock(shuttle_away_id)))
		balloon_alert(user, "外派停靠点已被占用！")
		return FALSE
	return TRUE

/obj/item/shuttle_remote/proc/transit_shuttle(mob/user, destination)
	var/obj/machinery/computer/shuttle/our_computer = computer_ref?.resolve()
	our_computer.send_shuttle(destination, user)
	our_computer.destination = destination
