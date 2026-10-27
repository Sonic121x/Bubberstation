/obj/structure/frame/computer
	name = "计算机框架"
	desc = "用于组装你自己的计算机的框架。你想叫它控制台也行，随你喜欢。"
	icon_state = "0"
	base_icon_state = ""
	state = FRAME_COMPUTER_STATE_EMPTY
	board_type = /obj/item/circuitboard/computer

/obj/structure/frame/computer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/simple_rotation)
	register_context()

/obj/structure/frame/computer/atom_deconstruct(disassembled = TRUE)
	var/atom/drop_loc = drop_location()
	if(state == FRAME_COMPUTER_STATE_GLASSED)
		if(disassembled)
			new /obj/item/stack/sheet/glass(drop_loc, 2)
		else
			new /obj/item/shard(drop_loc)
			new /obj/item/shard(drop_loc)
	if(state >= FRAME_COMPUTER_STATE_WIRED)
		new /obj/item/stack/cable_coil(drop_loc, 5)
	return ..()

/obj/structure/frame/computer/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = NONE
	if(isnull(held_item))
		return

	switch(state)
		if(FRAME_COMPUTER_STATE_EMPTY)
			if(held_item.tool_behaviour == TOOL_WRENCH)
				context[SCREENTIP_CONTEXT_LMB] = "[anchored ? "解除固定" : "固定"]"
				return CONTEXTUAL_SCREENTIP_SET
			else if(anchored && istype(held_item, /obj/item/circuitboard/computer))
				context[SCREENTIP_CONTEXT_LMB] = "安装电路板"
				return CONTEXTUAL_SCREENTIP_SET
			else if(held_item.tool_behaviour == TOOL_WELDER)
				context[SCREENTIP_CONTEXT_LMB] = "熔拆框架"
				return CONTEXTUAL_SCREENTIP_SET
			else if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
				context[SCREENTIP_CONTEXT_LMB] = "拆卸框架"
				return CONTEXTUAL_SCREENTIP_SET
		if(FRAME_COMPUTER_STATE_BOARD_INSTALLED)
			if(held_item.tool_behaviour == TOOL_CROWBAR)
				context[SCREENTIP_CONTEXT_LMB] = "撬出电路板"
				return CONTEXTUAL_SCREENTIP_SET
			else if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
				context[SCREENTIP_CONTEXT_LMB] = "固定电路板"
				return CONTEXTUAL_SCREENTIP_SET
		if(FRAME_COMPUTER_STATE_BOARD_SECURED)
			if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
				context[SCREENTIP_CONTEXT_LMB] = "松开电路板"
				return CONTEXTUAL_SCREENTIP_SET
			else if(istype(held_item, /obj/item/stack/cable_coil))
				context[SCREENTIP_CONTEXT_LMB] = "安装电缆"
				return CONTEXTUAL_SCREENTIP_SET
		if(FRAME_COMPUTER_STATE_WIRED)
			if(held_item.tool_behaviour == TOOL_WIRECUTTER)
				context[SCREENTIP_CONTEXT_LMB] = "剪除电缆"
				return CONTEXTUAL_SCREENTIP_SET
			else if(istype(held_item, /obj/item/stack/sheet/glass))
				context[SCREENTIP_CONTEXT_LMB] = "安装面板"
				return CONTEXTUAL_SCREENTIP_SET
		if(FRAME_COMPUTER_STATE_GLASSED)
			if(held_item.tool_behaviour == TOOL_CROWBAR)
				context[SCREENTIP_CONTEXT_LMB] = "撬出玻璃"
				return CONTEXTUAL_SCREENTIP_SET
			else if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
				context[SCREENTIP_CONTEXT_LMB] = "完成组装"
				return CONTEXTUAL_SCREENTIP_SET

/obj/structure/frame/computer/examine(user)
	. = ..()

	switch(state)
		if(FRAME_STATE_EMPTY)
			. += span_notice("可以用[EXAMINE_HINT("扳手")][anchored ? "解除固定。" : "将它固定。"]")
			if(anchored)
				. += span_warning("它缺少电路板！")
			else
				. += span_notice("可以用[EXAMINE_HINT("焊枪")]或[EXAMINE_HINT("螺丝刀")]将它拆解。")
		if(FRAME_COMPUTER_STATE_BOARD_INSTALLED)
			. += span_notice("可以[EXAMINE_HINT("撬出")]电路板。")
			. += span_info("已装入电路板，需要用[EXAMINE_HINT("螺丝刀")]固定。")
		if(FRAME_COMPUTER_STATE_BOARD_SECURED)
			. += span_notice("可以用[EXAMINE_HINT("螺丝刀")]松开电路板。")
			. += span_info("需要使用5段电缆[EXAMINE_HINT("接线")]。")
		if(FRAME_COMPUTER_STATE_WIRED)
			. += span_notice("可以[EXAMINE_HINT("剪除")]电线。")
			. += span_info("需要[EXAMINE_HINT("安装")]2块玻璃板。")
		if(FRAME_COMPUTER_STATE_GLASSED)
			. += span_notice("可以[EXAMINE_HINT("撬出")]屏幕。")
			. += span_info("用[EXAMINE_HINT("螺丝刀")]固定显示器即可完成组装。")

/obj/structure/frame/computer/circuit_added(obj/item/circuitboard/added)
	state = FRAME_COMPUTER_STATE_BOARD_INSTALLED
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/frame/computer/circuit_removed(obj/item/circuitboard/removed)
	state = FRAME_COMPUTER_STATE_EMPTY
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/frame/computer/install_board(mob/living/user, obj/item/circuitboard/computer/board, by_hand)
	if(state != FRAME_COMPUTER_STATE_EMPTY)
		balloon_alert(user, "已经安装了电路板！")
		return FALSE
	. = ..()
	if(. && !by_hand) // Installing via RPED auto-secures it
		state = FRAME_COMPUTER_STATE_BOARD_SECURED
		update_appearance(UPDATE_ICON_STATE)
	return .

/obj/structure/frame/computer/install_parts_from_part_replacer(mob/living/user, obj/item/storage/part_replacer/replacer, no_sound = FALSE)
	switch(state)
		if(FRAME_COMPUTER_STATE_BOARD_SECURED)
			var/obj/item/stack/cable_coil/cable = locate() in replacer
			if(isnull(cable))
				return FALSE

			if(add_cabling(user, cable, time = 0))
				if(!no_sound)
					replacer.play_rped_effect()
					no_sound = TRUE
				return install_parts_from_part_replacer(user, replacer, no_sound = no_sound)  // Recursive call to handle the next part

			return FALSE

		if(FRAME_COMPUTER_STATE_WIRED)
			var/obj/item/stack/sheet/glass/glass_sheets = locate() in replacer
			if(isnull(glass_sheets))
				return FALSE

			if(add_glass(user, glass_sheets, time = 0))
				if(!no_sound)
					replacer.play_rped_effect()
				return TRUE

			return FALSE

/obj/structure/frame/computer/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .

	switch(state)
		if(FRAME_COMPUTER_STATE_EMPTY)
			if(istype(tool, /obj/item/storage/part_replacer))
				return install_circuit_from_part_replacer(user, tool) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

		if(FRAME_COMPUTER_STATE_BOARD_SECURED)
			if(istype(tool, /obj/item/stack/cable_coil))
				return add_cabling(user, tool) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

			if(istype(tool, /obj/item/storage/part_replacer))
				return install_parts_from_part_replacer(user, tool) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

		if(FRAME_COMPUTER_STATE_WIRED)
			if(istype(tool, /obj/item/stack/sheet/glass))
				return add_glass(user, tool) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

			if(istype(tool, /obj/item/storage/part_replacer))
				return install_parts_from_part_replacer(user, tool) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

/obj/structure/frame/computer/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .

	switch(state)
		if(FRAME_COMPUTER_STATE_BOARD_INSTALLED)
			tool.play_tool_sound(src)
			balloon_alert(user, "电路板已固定")
			state = FRAME_COMPUTER_STATE_BOARD_SECURED
			update_appearance(UPDATE_ICON_STATE)
			return ITEM_INTERACT_SUCCESS

		if(FRAME_COMPUTER_STATE_BOARD_SECURED)
			tool.play_tool_sound(src)
			balloon_alert(user, "电路板已松开")
			state = FRAME_COMPUTER_STATE_BOARD_INSTALLED
			update_appearance(UPDATE_ICON_STATE)
			return ITEM_INTERACT_SUCCESS

		if(FRAME_COMPUTER_STATE_WIRED)
			if(!user.combat_mode)
				balloon_alert(user, "没有玻璃！")
				return ITEM_INTERACT_BLOCKING

		if(FRAME_COMPUTER_STATE_GLASSED)
			if(finalize_construction(user, tool))
				return ITEM_INTERACT_SUCCESS
			return ITEM_INTERACT_BLOCKING

/obj/structure/frame/computer/crowbar_act(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return NONE

	switch(state)
		if(FRAME_COMPUTER_STATE_BOARD_INSTALLED)
			tool.play_tool_sound(src)
			balloon_alert(user, "电路板已移除")
			circuit.add_fingerprint(user)
			circuit.forceMove(drop_location())
			return ITEM_INTERACT_SUCCESS

		if(FRAME_COMPUTER_STATE_BOARD_SECURED)
			balloon_alert(user, "先松开电路板！")
			return ITEM_INTERACT_BLOCKING

		if(FRAME_COMPUTER_STATE_WIRED)
			balloon_alert(user, "先移除电线！")
			return ITEM_INTERACT_BLOCKING

		if(FRAME_COMPUTER_STATE_GLASSED)
			tool.play_tool_sound(src)
			balloon_alert(user, "玻璃已移除")
			state = FRAME_COMPUTER_STATE_WIRED
			update_appearance(UPDATE_ICON_STATE)
			var/obj/item/stack/sheet/glass/dropped_glass = new (drop_location(), 2)
			if (!QDELETED(dropped_glass))
				dropped_glass.add_fingerprint(user)
			return ITEM_INTERACT_SUCCESS

/obj/structure/frame/computer/wirecutter_act(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return NONE

	if(state != FRAME_COMPUTER_STATE_WIRED)
		return ITEM_INTERACT_BLOCKING

	tool.play_tool_sound(src)
	balloon_alert(user, "电缆已移除")
	state = FRAME_COMPUTER_STATE_BOARD_SECURED
	update_appearance(UPDATE_ICON_STATE)

	var/obj/item/stack/cable_coil/dropped_cables = new (drop_location(), 5)
	if (!QDELETED(dropped_cables))
		dropped_cables.add_fingerprint(user)
	return ITEM_INTERACT_SUCCESS

/**
 * Adds cable to the computer to wire it
 * Arguments
 *
 * * mob/living/user - the player who is adding the cable
 * * obj/item/stack/cable_coil/cable - the cable we are trying to add
 * * time - time taken to complete the operation
 */
/obj/structure/frame/computer/proc/add_cabling(mob/living/user, obj/item/stack/cable_coil/cable, time = 2 SECONDS)
	PRIVATE_PROC(TRUE)

	if(state != FRAME_COMPUTER_STATE_BOARD_SECURED)
		return FALSE
	if(!cable.tool_start_check(user, amount = 5))
		return FALSE
	if(time > 0)
		balloon_alert(user, "正在安装电缆……")
	if(!cable.use_tool(src, user, time, volume = 50, amount = 5) || state != FRAME_COMPUTER_STATE_BOARD_SECURED)
		return FALSE

	state = FRAME_COMPUTER_STATE_WIRED
	update_appearance(UPDATE_ICON_STATE)
	return TRUE

/**
 * Adds glass sheets to the computer to complete the screen
 * Arguments
 *
 * * mob/living/user - the player who is adding the glass
 * * obj/item/stack/sheet/glass/glass - the glass we are trying to add
 * * time - time taken to complete the operation
 */
/obj/structure/frame/computer/proc/add_glass(mob/living/user, obj/item/stack/sheet/glass/glass, time = 2 SECONDS)
	PRIVATE_PROC(TRUE)

	if(state != FRAME_COMPUTER_STATE_WIRED)
		return FALSE
	if(!glass.tool_start_check(user, amount = 2))
		return FALSE
	if(time > 0)
		playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
		balloon_alert(user, "正在安装玻璃……")
	if(!glass.use_tool(src, user, time, amount = 2) || state != FRAME_COMPUTER_STATE_WIRED)
		return FALSE

	state = FRAME_COMPUTER_STATE_GLASSED
	update_appearance(UPDATE_ICON_STATE)
	return TRUE

/obj/structure/frame/computer/finalize_construction(mob/living/user, obj/item/tool)
	if(!anchored)
		balloon_alert(user, "必须先固定框架！")
		return FALSE

	tool.play_tool_sound(src)
	var/obj/machinery/new_machine = new circuit.build_path(loc)
	new_machine.balloon_alert(user, "显示器已连接")
	new_machine.setDir(dir)
	transfer_fingerprints_to(new_machine)
	// BUBBER EDIT - Connecting Computers
	for(var/obj/machinery/computer/selected in range(1, src))
		selected.update_appearance()
	for (var/obj/machinery/modular_computer/selected in range(1, src))
		selected.update_appearance()
	// BUBBER EDIT END - Connecting Computers

	if(istype(new_machine, /obj/machinery/computer))
		var/obj/machinery/computer/new_computer = new_machine

		new_machine.clear_components()

		// Set anchor state and move the frame's parts over to the new machine.
		// Then refresh parts and call on_construction().
		new_computer.set_anchored(anchored)
		new_computer.component_parts = list(circuit)
		new_computer.circuit = circuit

		circuit.forceMove(new_computer)

		for(var/atom/movable/movable_part in src)
			movable_part.forceMove(new_computer)
			new_computer.component_parts += movable_part

		new_computer.RefreshParts()
		new_computer.on_construction(user)

	qdel(src)
	return TRUE

/// Helpers for rcd
/obj/structure/frame/computer/rcd
	icon = 'icons/hud/radial.dmi'
	icon_state = "cnorth"
	anchored = TRUE

/obj/structure/frame/computer/rcd/Initialize(mapload)
	// yeah...
	name = "计算机框架"
	icon = 'icons/obj/devices/stock_parts.dmi'
	return ..()

/obj/structure/frame/computer/rcd/north
	dir = NORTH
	name = "朝北计算机"
	icon_state = "cnorth"

/obj/structure/frame/computer/rcd/south
	dir = SOUTH
	name = "朝南计算机"
	icon_state = "csouth"

/obj/structure/frame/computer/rcd/east
	dir = EAST
	name = "朝东计算机"
	icon_state = "ceast"

/obj/structure/frame/computer/rcd/west
	dir = WEST
	name = "朝西计算机"
	icon_state = "cwest"
