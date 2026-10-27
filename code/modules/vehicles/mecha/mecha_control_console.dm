/obj/machinery/computer/mecha
	name = "机甲控制台"
	desc = "用于远程定位或锁定机甲。"
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/mecha")
	icon_screen = "mecha"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_ROBOTICS)
	circuit = /obj/item/circuitboard/computer/mecha_control

/obj/machinery/computer/mecha/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ExosuitControlConsole", name)
		ui.open()

/obj/machinery/computer/mecha/ui_data(mob/user)
	var/list/data = list()

	var/list/trackerlist = list()
	for(var/obj/vehicle/sealed/mecha/MC in GLOB.mechas_list)
		trackerlist += MC.trackers

	data["mechs"] = list()
	for(var/obj/item/mecha_parts/mecha_tracking/MT in trackerlist)
		if(!MT.chassis)
			continue
		var/obj/vehicle/sealed/mecha/M = MT.chassis
		var/list/mech_data = list(
			name = M.name,
			integrity = round((M.get_integrity() / M.max_integrity) * 100),
			charge = M.cell ? round(M.cell.percent()) : null,
			airtank = (M.mecha_flags & IS_ENCLOSED) ? M.return_pressure() : null,
			pilot = M.return_drivers(),
			location = get_area_name(M, TRUE),
			emp_recharging = MT.recharging,
			tracker_ref = REF(MT)
		)
		if(istype(M, /obj/vehicle/sealed/mecha/ripley))
			var/obj/vehicle/sealed/mecha/ripley/workmech = M
			mech_data += list(
				cargo_space = round(workmech.cargo_hold.contents.len / workmech.cargo_hold.cargo_capacity * 100)
		)

		data["mechs"] += list(mech_data)

	return data

/obj/machinery/computer/mecha/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("send_message")
			var/obj/item/mecha_parts/mecha_tracking/our_mecha_tracker = locate(params["tracker_ref"])
			if(!istype(our_mecha_tracker))
				return
			var/message = tgui_input_text(usr, "输入消息", "发送消息", max_length = MAX_MESSAGE_LEN)
			var/obj/vehicle/sealed/mecha/our_mecha = our_mecha_tracker.chassis
			if(trim(message) && our_mecha)
				to_chat(our_mecha.occupants, message)
				to_chat(usr, span_notice("消息已发送。"))
				. = TRUE
		if("shock")
			var/obj/item/mecha_parts/mecha_tracking/our_mecha_tracker = locate(params["tracker_ref"])
			if(!istype(our_mecha_tracker))
				return
			var/obj/vehicle/sealed/mecha/our_mecha = our_mecha_tracker.chassis
			if(our_mecha)
				our_mecha_tracker.remote_emp_triggered()
				usr.log_message("对位于 [loc_name(our_mecha)] 的机甲 [our_mecha] 激活了远程 EMP，该机甲当前[LAZYLEN(our_mecha.occupants) ? "由 [our_mecha.occupants.Join(", ")] 驾驶。" : "无人驾驶。"]", LOG_ATTACK)
				usr.log_message("对位于 [loc_name(our_mecha)] 的机甲 [our_mecha] 激活了远程 EMP，该机甲当前[LAZYLEN(our_mecha.occupants) ? "由 [our_mecha.occupants.Join(", ")] 驾驶。" : "无人驾驶。"]", LOG_GAME, log_globally = FALSE)
				message_admins("[key_name_admin(usr)][ADMIN_FLW(usr)] 对机甲 [our_mecha][ADMIN_JMP(our_mecha)] 激活了远程 EMP，该机甲当前[LAZYLEN(our_mecha.occupants) ? "由 [our_mecha.occupants.Join(",")][ADMIN_FLW(our_mecha)] 驾驶。" : "无人驾驶。"]")
				. = TRUE

/obj/item/mecha_parts/mecha_tracking
	name = "机甲追踪信标"
	desc = "用于传输机甲数据的装置。"
	icon = 'icons/obj/devices/new_assemblies.dmi'
	icon_state = "motion2"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5)
	/// If this beacon allows for AI control. Exists to avoid using istype() on checking
	var/ai_beacon = FALSE
	/// Cooldown variable for EMP pulsing
	var/recharging = FALSE
	/// The Mecha that this tracking beacon is attached to
	var/obj/vehicle/sealed/mecha/chassis
	/// The type of flag this part checks before being able to be installed into the mech
	var/flag_to_check = BEACON_TRACKABLE

/**
 * Returns a html formatted string describing attached mech status
 */
/obj/item/mecha_parts/mecha_tracking/proc/get_mecha_info()
	if(!chassis)
		return FALSE

	var/list/output = list()

	var/cell_charge = chassis.get_charge()
	output += "[span_bold("名称：")] [chassis.name]"
	output += "[span_bold("完整度：")] [round((chassis.get_integrity()/chassis.max_integrity * 100), 0.01)]%"
	output += "[span_bold("电池电量：")] [isnull(cell_charge) ? "未找到":"[chassis.cell.percent()]%"]"
	output += "[span_bold("座舱压力：")] [(chassis.mecha_flags & IS_ENCLOSED) ? "[round(chassis.return_pressure(), 0.01)] kPa" : "未密封"]"
	output += "[span_bold("驾驶员：")] [english_list(chassis.return_drivers(), nothing_text = "无")]"
	output += "[span_bold("当前位置：")] [get_area_name(chassis, TRUE) || "未知"]"

	if(istype(chassis, /obj/vehicle/sealed/mecha/ripley))
		var/obj/item/mecha_parts/mecha_equipment/ejector/cargo_holder = locate(/obj/item/mecha_parts/mecha_equipment/ejector) in chassis.equip_by_category[MECHA_UTILITY]
		output += "[span_bold("已用货舱空间：")] [round((cargo_holder.contents.len / cargo_holder.cargo_capacity * 100), 0.01)]%"

	return jointext(output, "\n")

/obj/item/mecha_parts/mecha_tracking/Destroy()
	if(chassis)
		if(src in chassis.trackers)
			chassis.trackers -= src
	chassis = null
	return ..()

/obj/item/mecha_parts/mecha_tracking/try_attach_part(mob/user, obj/vehicle/sealed/mecha/mecha_to_attach, attach_right = FALSE)
	if(!(mecha_to_attach.mecha_flags & flag_to_check))
		to_chat(user, span_notice("[src] 与 [mecha_to_attach] 不兼容。"))
		return

	for(var/obj/item/mecha_parts/mecha_tracking/tracker as anything in mecha_to_attach.trackers)
		if(tracker.flag_to_check == flag_to_check)
			to_chat(user, span_notice("[mecha_to_attach] 上已经安装了 [src]。"))
			return

	if(!..())
		return
	mecha_to_attach.trackers += src
	mecha_to_attach.diag_hud_set_mechtracking()
	chassis = mecha_to_attach

/**
 * Attempts to EMP mech that the tracker is attached to, if there is one and tracker is not on cooldown
 */
/obj/item/mecha_parts/mecha_tracking/proc/remote_emp_triggered()
	if(recharging)
		return
	if(!chassis)
		return
	chassis.emp_act(EMP_HEAVY)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/mecha_parts/mecha_tracking, recharge)), 5 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)
	recharging = TRUE

/**
 * Resets recharge variable, allowing tracker to be EMP pulsed again
 */
/obj/item/mecha_parts/mecha_tracking/proc/recharge()
	recharging = FALSE

/obj/item/mecha_parts/mecha_tracking/ai_control
	name = "机甲 AI 控制信标"
	desc = "用于传输机甲数据的装置。同时允许活跃的 AI 单位接管该机甲。"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 2)
	ai_beacon = TRUE
	flag_to_check = BEACON_CONTROLLABLE
