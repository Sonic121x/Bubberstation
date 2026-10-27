//attack with an item - open/close cover, insert cell, or (un)lock interface

/obj/machinery/power/apc/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = NONE
	if(HAS_TRAIT(tool, TRAIT_APC_SHOCKING))
		. = fork_outlet_act(user, tool)
		if(.)
			return .

	if(tool.GetID())
		togglelock(user)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stock_parts/power_store))
		. = cell_act(user, tool)
	else if(istype(tool, /obj/item/stack/cable_coil))
		. = cable_act(user, tool, LAZYACCESS(modifiers, RIGHT_CLICK))
	else if(istype(tool, /obj/item/electronics/apc))
		. = electronics_act(user, tool)
	else if(istype(tool, /obj/item/electroadaptive_pseudocircuit))
		. = pseudocircuit_act(user, tool)
	else if(istype(tool, /obj/item/wallframe/apc))
		. = wallframe_act(user, tool)
	if(.)
		return .

	if(panel_open && !opened && is_wire_tool(tool))
		wires.interact(user)
		return ITEM_INTERACT_SUCCESS

	return .

/// Called when we interact with the APC with an item with which we can get shocked when we stuff it into an APC
/obj/machinery/power/apc/proc/fork_outlet_act(mob/living/user, obj/item/tool)
	var/metal = 0
	var/shock_source = null
	metal += LAZYACCESS(tool.custom_materials, SSmaterials.get_material(/datum/material/iron))//This prevents wooden rolling pins from shocking the user

	if(cell || terminal) //The mob gets shocked by whichever powersource has the most electricity
		if(cell && terminal)
			shock_source = cell.charge > terminal.powernet.avail ? cell : terminal.powernet
		else
			shock_source = terminal?.powernet || cell

	if(shock_source && metal && (panel_open || opened)) //Now you're cooking with electricity
		if(!electrocute_mob(user, shock_source, src, siemens_coeff = 1, dist_check = TRUE))//People with insulated gloves just attack the APC normally. They're just short of magical anyway
			return NONE
		do_sparks(5, TRUE, src)
		user.visible_message(span_notice("[user.name] 把 [tool] 塞进 [src] 的内部组件，顿时爆出一连串火花！"))
		if(shock_source == cell)//If the shock is coming from the cell just fully discharge it, because it's funny
			cell.use(cell.charge)
		return ITEM_INTERACT_SUCCESS

/// Called when we interact with the APC with a cell, attempts to insert it
/obj/machinery/power/apc/proc/cell_act(mob/living/user, obj/item/stock_parts/power_store/new_cell)
	if(!opened)
		return NONE

	if(cell)
		balloon_alert(user, "已装有电池！")
		return ITEM_INTERACT_BLOCKING
	if(machine_stat & MAINT)
		balloon_alert(user, "没有电池接口！")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(new_cell, src))
		return ITEM_INTERACT_BLOCKING
	cell = new_cell
	user.visible_message(span_notice("[user.name] 把电池装进了 [src.name]！"))
	balloon_alert(user, "电池已插入")
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/// Checks if we can place a terminal on the APC
/obj/machinery/power/apc/proc/can_place_terminal(mob/living/user, obj/item/stack/cable_coil/installing_cable, silent = TRUE)
	if(!opened)
		return FALSE
	var/turf/host_turf = get_turf(src)
	if(host_turf.underfloor_accessibility < UNDERFLOOR_INTERACTABLE)
		if(!silent && user)
			balloon_alert(user, "先拆除地板！")
		return FALSE
	if(!isnull(terminal))
		if(!silent && user)
			balloon_alert(user, "已接有电线！")
		return FALSE
	if(!has_electronics)
		if(!silent && user)
			balloon_alert(user, "没有可接线的电路板！")
		return FALSE
	if(panel_open)
		if(!silent && user)
			balloon_alert(user, "电线妨碍安装端子！")
		return FALSE
	if(installing_cable.get_amount() < 10)
		if(!silent && user)
			balloon_alert(user, "需要十段电缆！")
		return FALSE
	return TRUE

/// Called when we interact with the APC with a cable, attempts to wire the APC and create a terminal
/obj/machinery/power/apc/proc/cable_act(mob/living/user, obj/item/stack/cable_coil/installing_cable, is_right_clicking)
	if(!opened)
		return NONE
	if(!can_place_terminal(user, installing_cable, silent = FALSE))
		return ITEM_INTERACT_BLOCKING

	var/terminal_cable_layer = cable_layer // Default to machine's cable layer
	if(is_right_clicking)
		var/choice = tgui_input_list(user, "选择电力输入电缆层", "选择电缆层", GLOB.cable_name_to_layer)
		if(isnull(choice) \
			|| !user.is_holding(installing_cable) \
			|| !user.Adjacent(src) \
			|| user.incapacitated \
			|| !can_place_terminal(user, installing_cable, silent = TRUE) \
		)
			return ITEM_INTERACT_BLOCKING
		terminal_cable_layer = GLOB.cable_name_to_layer[choice]

	user.visible_message(span_notice("[user.name] 开始向区域电力控制器框架上添加电缆。"))
	balloon_alert(user, "正在添加电缆……")
	playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)

	if(!do_after(user, 2 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING
	if(!can_place_terminal(user, installing_cable, silent = TRUE))
		return ITEM_INTERACT_BLOCKING
	var/turf/our_turf = get_turf(src)
	var/obj/structure/cable/cable_node = our_turf.get_cable_node(terminal_cable_layer)
	if(prob(50) && electrocute_mob(usr, cable_node, cable_node, 1, TRUE))
		do_sparks(5, TRUE, src)
		return ITEM_INTERACT_BLOCKING
	installing_cable.use(10)
	user.visible_message(span_notice("[user.name] 向区域电力控制器框架上添加了电缆。"))
	balloon_alert(user, "电缆已添加")
	make_terminal(terminal_cable_layer)
	terminal.connect_to_network()
	return ITEM_INTERACT_SUCCESS

/// Called when we interact with the APC with APC electronics, attempts to install the board
/obj/machinery/power/apc/proc/electronics_act(mob/living/user, obj/item/electronics/apc/installing_board)
	if(!opened)
		return NONE

	if(has_electronics)
		balloon_alert(user, "已经装有电路板！")
		return ITEM_INTERACT_BLOCKING

	if(machine_stat & BROKEN)
		balloon_alert(user, "框架已损坏！")
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user.name] 将电力控制板插入 [src]。"))
	balloon_alert(user, "正在插入电路板……")
	playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)

	if(!do_after(user, 1 SECONDS, target = src) || has_electronics)
		return ITEM_INTERACT_BLOCKING

	has_electronics = APC_ELECTRONICS_INSTALLED
	locked = FALSE
	balloon_alert(user, "电路板已安装")
	qdel(installing_board)
	return ITEM_INTERACT_SUCCESS

/// Called when we interact with the APC with an electroadaptive pseudocircuit, used by cyborgs to install a board or weak cell
/obj/machinery/power/apc/proc/pseudocircuit_act(mob/living/user, obj/item/electroadaptive_pseudocircuit/pseudocircuit)
	if(!has_electronics)
		if(machine_stat & BROKEN)
			balloon_alert(user, "框架损坏过于严重！")
			return ITEM_INTERACT_BLOCKING
		if(!pseudocircuit.adapt_circuit(user, circuit_cost = 0.05 * STANDARD_CELL_CHARGE))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(
			span_notice("[user] 制造出一块电路并把它放进 [src]。"),
			span_notice("你改造出一块电力控制板，咔哒一声把它卡进 [src] 的内部。"),
		)
		has_electronics = APC_ELECTRONICS_INSTALLED
		locked = FALSE
		return ITEM_INTERACT_SUCCESS

	if(!cell)
		if(machine_stat & MAINT)
			balloon_alert(user, "没有可装电池的电路板！")
			return ITEM_INTERACT_BLOCKING
		if(!pseudocircuit.adapt_circuit(user, circuit_cost = 0.5 * STANDARD_CELL_CHARGE))
			return ITEM_INTERACT_BLOCKING
		var/obj/item/stock_parts/power_store/battery/crap/empty/bad_cell = new(src)
		bad_cell.forceMove(src)
		cell = bad_cell
		user.visible_message(
			span_notice("[user] 制造出一块弱电电池并把它放进 [src]。"),
			span_warning("你的 [pseudocircuit.name] 吃力地嗡嗡作响，你造出一块弱电电池并把它放进 [src]！"),
		)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	balloon_alert(user, "电路板和电池都已装好！")
	return ITEM_INTERACT_BLOCKING

/// Called when we interact with the APC with and APC frame, used for replacing a damaged cover/frame
/obj/machinery/power/apc/proc/wallframe_act(mob/living/user, obj/item/wallframe/apc/wallframe)
	if(!opened)
		return NONE

	if(!(machine_stat & BROKEN || opened == APC_COVER_REMOVED || atom_integrity < max_integrity)) // There is nothing to repair
		balloon_alert(user, "无需维修！")
		return ITEM_INTERACT_BLOCKING
	if((machine_stat & BROKEN) && opened == APC_COVER_REMOVED && has_electronics && terminal) // Cover is the only thing broken, we do not need to remove elctronicks to replace cover
		user.visible_message(span_notice("[user.name] 更换了缺失的区域电力控制器外壳。"))
		balloon_alert(user, "正在更换外壳……")
		if(!do_after(user, 2 SECONDS, target = src)) // replacing cover is quicker than replacing whole frame
			return ITEM_INTERACT_BLOCKING
		balloon_alert(user, "外壳已更换")
		qdel(wallframe)
		update_integrity(30) //needs to be welded to fully repair but can work without
		set_machine_stat(machine_stat & ~(BROKEN|MAINT))
		opened = APC_COVER_OPENED
		update_appearance()
		return ITEM_INTERACT_SUCCESS
	if(has_electronics)
		balloon_alert(user, "先取出里面的电路板！")
		return ITEM_INTERACT_BLOCKING
	user.visible_message(span_notice("[user.name] 用新的框架更换了损坏的区域电力控制器框架。"))
	balloon_alert(user, "正在更换损坏的框架……")
	if(!do_after(user, 5 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING
	balloon_alert(user, "框架已更换")
	qdel(wallframe)
	set_machine_stat(machine_stat & ~BROKEN)
	atom_integrity = max_integrity
	if(opened == APC_COVER_REMOVED)
		opened = APC_COVER_OPENED
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/apc/crowbar_act(mob/user, obj/item/crowbar)
	. = TRUE

	//Prying off broken cover
	if((opened == APC_COVER_CLOSED || opened == APC_COVER_OPENED) && (machine_stat & BROKEN))
		crowbar.play_tool_sound(src)
		balloon_alert(user, "正在撬开……")
		if(!crowbar.use_tool(src, user, 5 SECONDS))
			return
		opened = APC_COVER_REMOVED
		balloon_alert(user, "外壳已拆除")
		update_appearance()
		return

	//Opening and closing cover
	if((!opened && opened != APC_COVER_REMOVED) && !(machine_stat & BROKEN))
		if(coverlocked && !(machine_stat & MAINT)) // locked...
			balloon_alert(user, "外壳已上锁！")
			return
		else if(panel_open)
			balloon_alert(user, "电线妨碍打开！")
			return
		else
			opened = APC_COVER_OPENED
			update_appearance()
			return

	if((opened && has_electronics == APC_ELECTRONICS_SECURED) && !(machine_stat & BROKEN))
		opened = APC_COVER_CLOSED
		coverlocked = TRUE //closing cover relocks it
		balloon_alert(user, "正在锁定外壳")
		update_appearance()
		return

	//Taking out the electronics
	if(!opened || has_electronics != APC_ELECTRONICS_INSTALLED)
		return
	if(terminal)
		balloon_alert(user, "先断开电线！")
		return
	crowbar.play_tool_sound(src)
	if(!crowbar.use_tool(src, user, 50))
		return
	if(has_electronics != APC_ELECTRONICS_INSTALLED)
		return
	has_electronics = APC_ELECTRONICS_MISSING
	if(machine_stat & BROKEN)
		user.visible_message(span_notice("[user.name] 弄碎了 [name] 里面的电力控制板！"), \
			span_hear("你听到一声脆响。"))
		balloon_alert(user, "烧焦的电路板碎裂")
		return
	else if(obj_flags & EMAGGED)
		obj_flags &= ~EMAGGED
		user.visible_message(span_notice("[user.name] 从 [name] 中丢弃了一块被电磁篡改的电力控制板！"))
		balloon_alert(user, "已丢弃被篡改的电路板")
		return
	else if(malfhack)
		user.visible_message(span_notice("[user.name] 从 [name] 中丢弃了一块程序古怪的电力控制板！"))
		balloon_alert(user, "已丢弃被重新编程的电路板")
		malfai = null
		malfhack = 0
		return
	user.visible_message(span_notice("[user.name] 从 [name] 中取出了电力控制板！"))
	balloon_alert(user, "已取出电路板")
	new /obj/item/electronics/apc(loc)
	return

/obj/machinery/power/apc/screwdriver_act(mob/living/user, obj/item/W)
	if(..())
		return TRUE
	. = TRUE

	if(!opened)
		if(obj_flags & EMAGGED)
			balloon_alert(user, "接口已损坏！")
			return
		toggle_panel_open()
		balloon_alert(user, "电线[panel_open ? "已暴露" : "未暴露"]")
		W.play_tool_sound(src)
		update_appearance()
		return

	if(cell)
		user.visible_message(span_notice("[user] 从 [src] 中取出了 \the [cell]！"))
		balloon_alert(user, "电池已取出")
		var/turf/user_turf = get_turf(user)
		cell.forceMove(user_turf)
		cell = null
		charging = APC_NOT_CHARGING
		update_appearance()
		return

	switch (has_electronics)
		if(APC_ELECTRONICS_INSTALLED)
			has_electronics = APC_ELECTRONICS_SECURED
			set_machine_stat(machine_stat & ~MAINT)
			W.play_tool_sound(src)
			balloon_alert(user, "电路板已固定")
		if(APC_ELECTRONICS_SECURED)
			has_electronics = APC_ELECTRONICS_INSTALLED
			set_machine_stat(machine_stat | MAINT)
			W.play_tool_sound(src)
			balloon_alert(user, "电路板已松开")
		else
			balloon_alert(user, "没有可固定的电路板！")
			return
	update_appearance()

/obj/machinery/power/apc/wirecutter_act(mob/living/user, obj/item/W)
	. = ..()
	if(terminal && opened)
		terminal.dismantle(user, W)
		return TRUE

/obj/machinery/power/apc/welder_act(mob/living/user, obj/item/welder)
	. = ..()

	//repairing the cover
	if((atom_integrity < max_integrity) && has_electronics)
		if(opened == APC_COVER_REMOVED)
			balloon_alert(user, "没有可维修的外壳！")
			return
		if (machine_stat & BROKEN)
			balloon_alert(user, "损坏过于严重，无法维修！")
			return
		if(!welder.tool_start_check(user, amount=1))
			return
		balloon_alert(user, "正在维修……")
		if(welder.use_tool(src, user, 4 SECONDS, volume = 50))
			update_integrity(min(atom_integrity += 50,max_integrity))
			balloon_alert(user, "已修复")
		return ITEM_INTERACT_SUCCESS

	//disassembling the frame
	if(!opened || has_electronics || terminal)
		return
	if(!welder.tool_start_check(user, amount=1))
		return
	user.visible_message(span_notice("[user.name] 焊接了 [src]。"), \
						span_hear("你听到焊接声。"))
	balloon_alert(user, "正在焊接框架")
	if(!welder.use_tool(src, user, 50, volume=50))
		return
	if((machine_stat & BROKEN) || opened == APC_COVER_REMOVED)
		new /obj/item/stack/sheet/iron(loc)
		user.visible_message(span_notice("[user.name] 用 [welder] 把 [src] 切开。"))
		user.balloon_alert(user, "已拆解损坏的框架")
	else
		new /obj/item/wallframe/apc(loc)
		user.visible_message(span_notice("[user.name] 用 [welder] 把 [src] 从墙上切下。"))
		user.balloon_alert(user, "已从墙上切下框架")
	qdel(src)
	return TRUE

/obj/machinery/power/apc/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(!(the_rcd.construction_upgrades & RCD_UPGRADE_SIMPLE_CIRCUITS))
		return FALSE

	if(!has_electronics)
		if(machine_stat & BROKEN)
			balloon_alert(user, "框架损坏过于严重！")
			return FALSE
		return list("delay" = 2 SECONDS, "cost" = 1)

	if(!cell)
		if(machine_stat & MAINT)
			balloon_alert(user, "没有可装电池的电路板！")
			return FALSE
		return list("delay" = 5 SECONDS, "cost" = 10)

	balloon_alert(user, "电路板和电池都已装好！")
	return FALSE

/obj/machinery/power/apc/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, list/rcd_data)
	if(!(the_rcd.construction_upgrades & RCD_UPGRADE_SIMPLE_CIRCUITS) || rcd_data[RCD_DESIGN_MODE] != RCD_WALLFRAME)
		return FALSE

	if(!has_electronics)
		if(machine_stat & BROKEN)
			balloon_alert(user, "框架损坏过于严重！")
			return
		balloon_alert(user, "电路板已放置")
		has_electronics = TRUE
		locked = TRUE
		return TRUE

	if(!cell)
		if(machine_stat & MAINT)
			balloon_alert(user, "没有可装电池的电路板！")
			return FALSE
		var/obj/item/stock_parts/power_store/battery/crap/empty/C = new(src)
		C.forceMove(src)
		cell = C
		balloon_alert(user, "电池已安装")
		update_appearance()
		return TRUE

	balloon_alert(user, "电路板和电池都已装好！")
	return FALSE

/obj/machinery/power/apc/emag_act(mob/user, obj/item/card/emag/emag_card)
	if((obj_flags & EMAGGED) || malfhack)
		return FALSE

	if(opened)
		balloon_alert(user, "请先合上外壳！")
		return FALSE
	else if(panel_open)
		balloon_alert(user, "请先合上面板！")
		return FALSE
	else if(machine_stat & (BROKEN|MAINT))
		balloon_alert(user, "什么也没发生！")
		return FALSE
	else
		flick("apc-spark", src)
		playsound(src, SFX_SPARKS, 75, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		obj_flags |= EMAGGED
		locked = FALSE
		balloon_alert(user, "接口已损坏")
		update_appearance()
		flicker_hacked_icon()
		return TRUE

// damage and destruction acts
/obj/machinery/power/apc/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		if(cell)
			cell.emp_act(severity)
		if(occupier)
			occupier.emp_act(severity)
	if(. & EMP_PROTECT_SELF)
		return
	lighting = APC_CHANNEL_OFF
	equipment = APC_CHANNEL_OFF
	environ = APC_CHANNEL_OFF
	update_appearance()
	update()
	addtimer(CALLBACK(src, PROC_REF(reset), APC_RESET_EMP), 60 SECONDS)

/obj/machinery/power/apc/proc/togglelock(mob/living/user)
	if(obj_flags & EMAGGED)
		balloon_alert(user, "接口已损坏！")
	else if(opened)
		balloon_alert(user, "请先合上外壳！")
	else if(panel_open)
		balloon_alert(user, "请先合上面板！")
	else if(machine_stat & (BROKEN|MAINT))
		balloon_alert(user, "什么也没发生！")
	else
		if(allowed(usr) && !wires.is_cut(WIRE_IDSCAN) && ((!malfhack && !remote_control_user) || (malfhack && (malfai == user || (user in malfai.connected_robots)))))
			locked = !locked
			balloon_alert(user, locked ? "已上锁" : "已解锁")
			update_appearance()
		else
			balloon_alert(user, "访问被拒绝！")
