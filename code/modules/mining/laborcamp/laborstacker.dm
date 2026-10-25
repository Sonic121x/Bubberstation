/**********************Prisoners' Console**************************/

/obj/machinery/mineral/labor_claim_console
	name = "积分领取控制台"
	desc = "一台带有电磁写入器的堆叠控制台，用于记录囚犯开采的矿石。"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "console"
	density = FALSE
	/// Connected stacking machine
	var/obj/machinery/mineral/stacking_machine/laborstacker/stacking_machine
	/// Whether the claim console initiated the launch.
	var/initiated_launch = FALSE
	/// Cooldown for console says.
	COOLDOWN_DECLARE(say_cooldown)

/obj/machinery/mineral/labor_claim_console/Initialize(mapload)
	. = ..()
	locate_stacking_machine()
	if(!SSshuttle.initialized)
		RegisterSignal(SSshuttle, COMSIG_SUBSYSTEM_POST_INITIALIZE, PROC_REF(register_shuttle_signal))
	else
		register_shuttle_signal()
	//If we can't find a stacking machine end it all ok?
	if(!stacking_machine)
		return INITIALIZE_HINT_QDEL

/obj/machinery/mineral/labor_claim_console/proc/register_shuttle_signal()
	SIGNAL_HANDLER
	var/obj/docking_port/mobile/laborshuttle = SSshuttle.getShuttle("laborcamp")
	if(laborshuttle)
		RegisterSignal(laborshuttle, COMSIG_SHUTTLE_SHOULD_MOVE, PROC_REF(on_laborshuttle_can_move))
	UnregisterSignal(SSshuttle, COMSIG_SUBSYSTEM_POST_INITIALIZE)

/obj/machinery/mineral/labor_claim_console/Destroy()
	if(stacking_machine)
		stacking_machine.labor_console = null
		stacking_machine = null
	return ..()

/proc/cmp_sheet_list(list/a, list/b)
	return a["value"] - b["value"]

/obj/machinery/mineral/labor_claim_console/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "LaborClaimConsole", name)
		ui.open()

/obj/machinery/mineral/labor_claim_console/ui_data(mob/user)
	var/list/data = list()
	var/can_go_home = FALSE

	if(obj_flags & EMAGGED)
		can_go_home = TRUE
	var/obj/item/card/id/worn_id
	if(isliving(user))
		var/mob/living/living_user = user
		worn_id = living_user.get_idcard(TRUE)
	if(istype(worn_id, /obj/item/card/id/advanced/prisoner))
		var/obj/item/card/id/advanced/prisoner/worn_prisoner_id = worn_id
		data["id_points"] = worn_prisoner_id.points
		if(!worn_prisoner_id.goal)
			data["status_info"] = "未设定目标！"
		else if(worn_prisoner_id.points >= worn_prisoner_id.goal)
			can_go_home = TRUE
			data["status_info"] = "目标已达成！"
		else
			data["status_info"] = "你还差 [(worn_prisoner_id.goal - worn_prisoner_id.points)] 积分。"
	else
		data["status_info"] = "未检测到囚犯 ID。"
		data["id_points"] = 0

	if(stacking_machine)
		data["unclaimed_points"] = stacking_machine.points

	data["can_go_home"] = can_go_home
	return data

/obj/machinery/mineral/labor_claim_console/ui_static_data(mob/user)
	var/list/data = list()
	data["shuttle_exists"] = !isnull(SSshuttle.getShuttle("laborcamp"))
	return data

/obj/machinery/mineral/labor_claim_console/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/user_mob = usr

	switch(action)

		if("claim_points")
			var/obj/item/card/id/worn_id
			if(isliving(user_mob))
				var/mob/living/living_mob = user_mob
				worn_id = living_mob.get_idcard(TRUE)
			if(istype(worn_id, /obj/item/card/id/advanced/prisoner))
				var/obj/item/card/id/advanced/prisoner/worn_prisoner_id = worn_id
				worn_prisoner_id.points += stacking_machine.points
				stacking_machine.points = 0
				say("积分已转移。")
				return TRUE
			else
				if(COOLDOWN_FINISHED(src, say_cooldown))
					say("未检测到可用于转移积分的有效 ID。")
					COOLDOWN_START(src, say_cooldown, 2 SECONDS)

		if("move_shuttle")
			if(isnull(SSshuttle.getShuttle("laborcamp")))
				if(COOLDOWN_FINISHED(src, say_cooldown))
					say("未找到穿梭机。")
					COOLDOWN_START(src, say_cooldown, 2 SECONDS)
				return

			var/list/labor_shuttle_mobs = find_labor_shuttle_mobs()
			if(length(labor_shuttle_mobs) > 1 || labor_shuttle_mobs[1] != user_mob)
				if(COOLDOWN_FINISHED(src, say_cooldown))
					say("囚犯一次只能释放一人。")
					COOLDOWN_START(src, say_cooldown, 2 SECONDS)
				return

			switch(SSshuttle.moveShuttle("laborcamp", "laborcamp_home", TRUE))
				if(1)
					if(COOLDOWN_FINISHED(src, say_cooldown))
						say("未找到穿梭机。")
						COOLDOWN_START(src, say_cooldown, 2 SECONDS)
				if(2)
					if(COOLDOWN_FINISHED(src, say_cooldown))
						say("穿梭机已在空间站。")
						COOLDOWN_START(src, say_cooldown, 2 SECONDS)
				if(3)
					if(COOLDOWN_FINISHED(src, say_cooldown))
						say("未能获得停泊许可。")
						COOLDOWN_START(src, say_cooldown, 2 SECONDS)
				else
					if(!(obj_flags & EMAGGED))
						var/datum/record/crew/target = find_record(user_mob.real_name)
						target?.wanted_status = WANTED_PAROLE

						aas_config_announce(/datum/aas_config_entry/security_labor_stacker, list("PERSON" = user_mob.real_name), src, list(RADIO_CHANNEL_SECURITY))
					user_mob.log_message("已完成劳动积分目标，正在把劳改营穿梭机送回空间站。", LOG_GAME)
					say("劳役刑期结束，穿梭机正在返回。")
					initiated_launch = TRUE
					return TRUE

/obj/machinery/mineral/labor_claim_console/proc/find_labor_shuttle_mobs()
	var/list/prisoners = mobs_in_area_type(list(get_area(src)))

	// security personnel and nonhumans do not count towards this
	for(var/mob/living/mob as anything in prisoners)
		var/obj/item/card/id/card = mob.get_idcard(FALSE)
		if(!ishuman(mob) || (ACCESS_BRIG in card?.GetAccess()))
			prisoners -= mob

	return prisoners

/obj/machinery/mineral/labor_claim_console/proc/on_laborshuttle_can_move(obj/docking_port/mobile/source)
	SIGNAL_HANDLER

	if(initiated_launch && length(find_labor_shuttle_mobs()) > 1)
		initiated_launch = FALSE
		say("起飞中止。囚犯一次只能释放一人。")
		return BLOCK_SHUTTLE_MOVE

/obj/machinery/mineral/labor_claim_console/proc/locate_stacking_machine()
	stacking_machine = locate(/obj/machinery/mineral/stacking_machine) in dview(2, get_turf(src))
	if(stacking_machine)
		stacking_machine.labor_console = src

/obj/machinery/mineral/labor_claim_console/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (obj_flags & EMAGGED)
		return FALSE

	obj_flags |= EMAGGED
	balloon_alert(user, "ID 验证器短路了")
	visible_message(span_warning("[src] 冒出了几颗火花！"))
	do_sparks(2, TRUE, src)
	return TRUE

/**********************Prisoner Collection Unit**************************/

/obj/machinery/mineral/stacking_machine/laborstacker
	name = "劳改营收集装置"
	force_connect = TRUE
	damage_deflection = 21 //otherwise prisoners will destroy it
	///Idle points sitting in the machine left to be claimed.
	var/points = 0
	///Labor claim console synced to our stacking machine, set by the console.
	var/obj/machinery/mineral/labor_claim_console/labor_console

/obj/machinery/mineral/stacking_machine/laborstacker/Destroy()
	if(labor_console)
		labor_console.stacking_machine = null
		labor_console = null
	return ..()

/obj/machinery/mineral/stacking_machine/laborstacker/process_stack(obj/item/stack/input)
	if (!istype(input, /obj/item/stack/sheet))
		return ..()
	var/obj/item/stack/sheet/sheet = input
	if (sheet.manufactured && sheet.gulag_value)
		points += sheet.gulag_value * sheet.amount
	return ..()

/obj/machinery/mineral/stacking_machine/laborstacker/base_item_interaction(mob/living/user, obj/item/weapon, list/modifiers)
	if (is_type_in_typecache(weapon, accepted_types))
		process_stack(weapon)
		return ITEM_INTERACT_SUCCESS
	return ..()

/**********************Point Lookup Console**************************/

/obj/machinery/mineral/labor_points_checker
	name = "积分查询控制台"
	desc = "供囚犯查询配额进度的控制台。刷一下囚犯 ID 即可。"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "console"
	density = FALSE

/obj/machinery/mineral/labor_points_checker/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(. || user.is_blind())
		return
	user.examinate(src)

/obj/machinery/mineral/labor_points_checker/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/card/id/advanced/prisoner))
		return NONE

	var/obj/item/card/id/advanced/prisoner/prisoner_id = tool
	if(!prisoner_id.goal) //no goal to reach
		say("此 ID 无需达成目标。")
		return ITEM_INTERACT_BLOCKING

	say("ID：[prisoner_id.registered_name]。")
	say("已收集积分：[prisoner_id.points] / [prisoner_id.goal]。")
	say("把冶炼好的矿物送到劳改穿梭机堆叠机即可收集积分。达到配额即可获释。")
	return ITEM_INTERACT_SUCCESS

/datum/aas_config_entry/security_labor_stacker
	name = "安保警报：劳改营释放"
	announcement_lines_map = list(
		"Message" = "%PERSON 已返回空间站。矿物与囚犯 ID 卡可供领取。"
	)
	vars_and_tooltips_map = list(
		"PERSON" = "将替换为囚犯的名字。"
	)
