/obj/machinery/computer/nanite_chamber_control
	name = "纳米机器人舱控制台"
	desc = "控制已连接的纳米机器人舱。可接种纳米机器人、加载程序并分析现有的纳米机器人集群。"
	icon = 'modular_zubbers/icons/obj/machines/computer.dmi'
	icon_screen = "nanite_chamber_control"
	circuit = /obj/item/circuitboard/computer/nanite_chamber_control
	var/obj/machinery/nanite_chamber/chamber

/obj/machinery/computer/nanite_chamber_control/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	find_chamber()

/obj/machinery/computer/nanite_chamber_control/proc/find_chamber()
	for(var/direction in GLOB.cardinals)
		var/C = locate(/obj/machinery/nanite_chamber, get_step(src, direction))
		if(C)
			var/obj/machinery/nanite_chamber/NC = C
			set_connected_chamber(NC)

/obj/machinery/computer/nanite_chamber_control/interact()
	if(!chamber)
		find_chamber()
	..()

/obj/machinery/computer/nanite_chamber_control/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NaniteChamberControl", name)
		ui.open()

/obj/machinery/computer/nanite_chamber_control/ui_data()
	var/list/data = list()

	if(!chamber)
		data["status_msg"] = "未检测到舱体。"
		return data

	if(!chamber.occupant)
		data["status_msg"] = "未检测到使用者。"
		return data

	var/mob/living/L = chamber.occupant

	if(!CAN_HAVE_NANITES(L))
		data["status_msg"] = "使用者无法兼容纳米机器人。"
		return data

	if(chamber.busy)
		data["status_msg"] = chamber.busy_message
		return data

	data["status_msg"] = null
	data["scan_level"] = chamber.scan_level
	data["locked"] = chamber.locked
	data["occupant_name"] = chamber.occupant.name

	SEND_SIGNAL(L, COMSIG_NANITE_UI_DATA, data, chamber.scan_level)

	return data

/obj/machinery/computer/nanite_chamber_control/ui_static_data(mob/user)
	. = ..()

	.["min_cloud_id"] = NANITE_MIN_CLOUD_ID
	.["max_cloud_id"] = NANITE_MAX_CLOUD_ID

/obj/machinery/computer/nanite_chamber_control/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("toggle_lock")
			chamber.locked = !chamber.locked
			chamber.update_appearance()
			. = TRUE
		if("set_safety")
			var/threshold = text2num(params["value"])
			if(!isnull(threshold))
				chamber.set_safety(clamp(round(threshold, 1),0,500))
				playsound(src, "terminal_type", 25, FALSE)
				chamber.occupant.investigate_log("的纳米机器人安全阈值被 [key_name(usr)] 通过 [src] 在 [AREACOORD(src)] 设置为 [threshold]。", INVESTIGATE_NANITES)
			. = TRUE
		if("set_cloud")
			var/cloud_id = text2num(params["value"])
			if(!isnull(cloud_id))
				chamber.set_cloud(clamp(round(cloud_id, 1),NANITE_MIN_CLOUD_ID,NANITE_MAX_CLOUD_ID))
				playsound(src, "terminal_type", 25, FALSE)
				chamber.occupant.investigate_log("的纳米机器人云 ID 被 [key_name(usr)] 通过 [src] 在 [AREACOORD(src)] 设置为 [cloud_id]。", INVESTIGATE_NANITES)
			. = TRUE
		if("connect_chamber")
			find_chamber()
			. = TRUE
		if("remove_nanites")
			playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 25, FALSE)
			chamber.remove_nanites()
			log_combat(usr, chamber.occupant, "清除了以下对象的纳米机器人", null, "通过 [src]")
			chamber.occupant.investigate_log("的纳米机器人被 [key_name(usr)] 通过 [src] 在 [AREACOORD(src)] 清除。", INVESTIGATE_NANITES)
			. = TRUE
		if("nanite_injection")
			playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 25, FALSE)
			chamber.inject_nanites()
			log_combat(usr, chamber.occupant, "向以下对象注射了纳米机器人", null, "通过 [src]")
			chamber.occupant.investigate_log("被 [key_name(usr)] 通过 [src] 在 [AREACOORD(src)] 注射了纳米机器人。", INVESTIGATE_NANITES)
			. = TRUE

/obj/machinery/computer/nanite_chamber_control/proc/set_connected_chamber(new_chamber)
	if(chamber)
		UnregisterSignal(chamber, COMSIG_PREQDELETED)
	chamber = new_chamber
	if(chamber)
		RegisterSignal(chamber, COMSIG_PREQDELETED, PROC_REF(react_to_chamber_del))

/obj/machinery/computer/nanite_chamber_control/proc/react_to_chamber_del(datum/source)
	SIGNAL_HANDLER
	set_connected_chamber(null)
