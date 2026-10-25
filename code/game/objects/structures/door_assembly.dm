/obj/structure/door_assembly
	name = "气闸组件"
	icon = 'icons/obj/doors/airlocks/station/public.dmi'
	icon_state = "construction"
	var/overlays_file = 'icons/obj/doors/airlocks/station/overlays.dmi'
	anchored = FALSE
	density = TRUE
	max_integrity = 200
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4)
	/// Airlock's current construction state
	var/state = AIRLOCK_ASSEMBLY_NEEDS_WIRES
	var/base_name = "气闸"
	var/created_name = null
	var/mineral = null
	var/obj/item/electronics/airlock/electronics = null
	/// Do we perform the extra checks required for multi-tile (large) airlocks
	var/multi_tile = FALSE
	/// The type path of the airlock once completed (solid version)
	var/airlock_type = /obj/machinery/door/airlock
	/// The type path of the airlock once completed (glass version)
	var/glass_type = /obj/machinery/door/airlock/glass
	/// FALSE = glass can be installed. TRUE = glass is already installed.
	var/glass = FALSE
	/// Whether to heat-proof the finished airlock
	var/heat_proof_finished = FALSE
	/// If you're changing the airlock material, what is the previous type
	var/previous_assembly = /obj/structure/door_assembly
	/// Airlocks with no glass version, also cannot be modified with sheets
	var/noglass = FALSE
	/// Airlock with glass version, but cannot be modified with sheets
	var/nomineral = FALSE
	/// What type of material the airlock drops when deconstructed
	var/material_type = /obj/item/stack/sheet/iron
	/// Amount of material the airlock drops when deconstructed
	var/material_amt = 4

/obj/structure/door_assembly/multi_tile
	name = "大型气闸组件"
	icon = 'icons/obj/doors/airlocks/multi_tile/public/glass.dmi'
	overlays_file = 'icons/obj/doors/airlocks/multi_tile/public/overlays.dmi'
	base_name = "大型气闸"
	glass_type = /obj/machinery/door/airlock/multi_tile/public/glass
	airlock_type = /obj/machinery/door/airlock/multi_tile/public/glass
	dir = EAST
	multi_tile = TRUE
	glass = TRUE
	nomineral = TRUE
	material_amt = 8

/obj/structure/door_assembly/Initialize(mapload)
	. = ..()
	obj_flags |= UNIQUE_RENAME | RENAME_NO_DESC
	update_appearance()
	update_name()

/obj/structure/door_assembly/multi_tile/Initialize(mapload)
	. = ..()
	set_bounds()
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/door_assembly/multi_tile/Move()
	. = ..()
	set_bounds()

/obj/structure/door_assembly/examine(mob/user)
	. = ..()
	switch(state)
		if(AIRLOCK_ASSEMBLY_NEEDS_WIRES)
			if(anchored)
				. += span_notice("固定螺栓已<b>用扳手拧紧</b>到位，但维护面板里缺少<i>线路</i>。")
			else
				. += span_notice("组件已<b>焊接在一起</b>，但固定螺栓<i>尚未用扳手拧紧</i>。")
		if(AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
			. += span_notice("维护面板已<b>接好线路</b>，但电路槽是<i>空的</i>。")
		if(AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
			. += span_notice("电路与插槽<b>连接松动</b>，维护面板<i>未拧螺丝、处于敞开状态</i>。")
	if(!mineral && !nomineral && !glass && !noglass)
		. += span_notice("有可用于玻璃窗和矿物外壳的<i>空</i>槽位。")
	else if(!mineral && !nomineral && glass && !noglass)
		. += span_notice("有可用于矿物外壳的<i>空</i>槽位。")
	else if(!glass && !noglass)
		. += span_notice("有可用于玻璃窗的<i>空</i>槽位。")
	if(created_name)
		. += span_notice("组件上贴着一个小小的<i>纸质</i>标牌，上面写着“[created_name]”。")

/obj/structure/door_assembly/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(anchored && state == AIRLOCK_ASSEMBLY_NEEDS_WIRES && istype(tool, /obj/item/stack/cable_coil))
		if(!tool.tool_start_check(user, amount=1))
			return ITEM_INTERACT_BLOCKING

		user.visible_message(span_notice("[user]给气闸组件接上了线路。"), \
							span_notice("你开始给气闸组件接线……"))
		if(!tool.use_tool(src, user, 40, amount=1))
			return ITEM_INTERACT_BLOCKING

		if(state != AIRLOCK_ASSEMBLY_NEEDS_WIRES)
			return ITEM_INTERACT_BLOCKING

		state = AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS
		to_chat(user, span_notice("你给气闸组件接好了线路。"))
		name = "已接线气闸组件"
		update_name()
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(state == AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS && istype(tool, /obj/item/electronics/airlock))
		tool.play_tool_sound(src, 100)
		user.visible_message(span_notice("[user]把电子元件装进了气闸组件。"), \
							span_notice("你开始把电子元件装进气闸组件……"))
		if(!do_after(user, 4 SECONDS, target = src))
			return ITEM_INTERACT_BLOCKING

		if(state != AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
			return ITEM_INTERACT_BLOCKING

		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("你装好了气闸电子元件。"))
		state = AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER
		name = "即将完成的气闸组件"
		electronics = tool
		update_name()
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stack/sheet))
		var/obj/item/stack/sheet/sheet = tool
		if(!glass && (istype(sheet, /obj/item/stack/sheet/rglass) || istype(sheet, /obj/item/stack/sheet/glass)))
			if(noglass)
				to_chat(user, span_warning("你无法把[sheet]加到[src]上！"))
				return ITEM_INTERACT_BLOCKING
			playsound(src, 'sound/items/tools/crowbar.ogg', 100, TRUE)
			user.visible_message(span_notice("[user]把[sheet.name]加到气闸组件上。"), \
								span_notice("你开始把[sheet.name]安装到气闸组件上……"))
			if(!do_after(user, 4 SECONDS, target = src))
				return ITEM_INTERACT_BLOCKING
			if(sheet.get_amount() < 1 || glass)
				return ITEM_INTERACT_BLOCKING
			if(sheet.type == /obj/item/stack/sheet/rglass)
				to_chat(user, span_notice("你把[sheet.name]窗安装到气闸组件上。"))
				heat_proof_finished = TRUE //reinforced glass makes the airlock heat-proof
				name = "即将完成的隔热玻璃窗气闸组件"
			else
				to_chat(user, span_notice("你把普通玻璃窗安装到气闸组件上。"))
				name = "即将完成的玻璃窗气闸组件"
			sheet.use(1)
			glass = TRUE
			update_name()
			update_appearance()
			return ITEM_INTERACT_SUCCESS

		if(istype(sheet, /obj/item/stack/sheet/mineral) && sheet.construction_path_type)
			if(nomineral || mineral)
				to_chat(user, span_warning("你无法把[sheet]加到[src]上！"))
				return ITEM_INTERACT_BLOCKING

			var/type_path_extension = sheet.construction_path_type
			var/mineralassembly = text2path("/obj/structure/door_assembly/door_assembly_[type_path_extension]")
			if(!ispath(mineralassembly))
				to_chat(user, span_warning("你无法把[sheet]加到[src]上！"))
				return ITEM_INTERACT_BLOCKING

			if(sheet.get_amount() < 2)
				to_chat(user, span_warning("你至少需要两块板材才能加装矿物外壳！"))
				return ITEM_INTERACT_BLOCKING

			playsound(src, 'sound/items/tools/crowbar.ogg', 100, TRUE)
			user.visible_message(span_notice("[user]把[sheet.name]加到气闸组件上。"), \
								span_notice("你开始把[sheet.name]安装到气闸组件上……"))
			if(!do_after(user, 4 SECONDS, target = src) || sheet.get_amount() < 2 || mineral)
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_notice("你把[type_path_extension]外壳安装到气闸组件上。"))
			sheet.use(2)
			var/obj/structure/door_assembly/replacement_assembly = new mineralassembly(loc)

			if(replacement_assembly.noglass && glass) //in case the new door doesn't support glass. prevents the new one from reverting to a normal airlock after being constructed.
				var/obj/item/stack/sheet/dropped_glass
				if(heat_proof_finished)
					dropped_glass = new /obj/item/stack/sheet/rglass(drop_location())
					heat_proof_finished = FALSE
				else
					dropped_glass = new /obj/item/stack/sheet/glass(drop_location())
				glass = FALSE
				to_chat(user, span_notice("完工时，一块[dropped_glass.singular_name]从[replacement_assembly]的框架里掉了出来。"))

			transfer_assembly_vars(src, replacement_assembly, TRUE)
			return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/door_assembly/welder_act(mob/living/user, obj/item/tool)
	if(!mineral && !glass && anchored)
		return ITEM_INTERACT_SKIP_TO_ATTACK

	if(!tool.tool_start_check(user, amount=1))
		return ITEM_INTERACT_BLOCKING

	if(mineral)
		var/obj/item/stack/sheet/mineral/mineral_path = text2path("/obj/item/stack/sheet/mineral/[mineral]")
		user.visible_message(span_notice("[user]把[mineral]外壳从气闸组件上焊了下来。"), span_notice("你开始把[mineral]外壳从气闸组件上焊下来……"))
		if(!tool.use_tool(src, user, 40, volume=50))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你把[mineral]外壳焊了下来。"))
		new mineral_path(loc, 2)
		var/obj/structure/door_assembly/PA = new previous_assembly(loc)
		transfer_assembly_vars(src, PA)
		update_name()
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(glass)
		user.visible_message(span_notice("[user]把玻璃板从气闸组件上焊了出来。"), \
							span_notice("你开始把玻璃板从气闸组件上焊出来……"))
		if(!tool.use_tool(src, user, 40, volume=50))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("你把玻璃板焊了下来。"))
		if(heat_proof_finished)
			new /obj/item/stack/sheet/rglass(get_turf(src))
			heat_proof_finished = FALSE
		else
			new /obj/item/stack/sheet/glass(get_turf(src))
		glass = FALSE
		update_name()
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(!anchored)
		user.visible_message(span_warning("[user]拆解了气闸组件。"), \
							span_notice("你开始拆解气闸组件……"))
		if(!tool.use_tool(src, user, 40, volume=50))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你拆解了气闸组件。"))
		deconstruct(TRUE)
		return ITEM_INTERACT_SUCCESS
	// no return NONE at end because it's not possible we end up here

/obj/structure/door_assembly/wrench_act(mob/living/user, obj/item/tool)
	if(anchored)
		user.visible_message(span_notice("[user]解除了气闸组件在地面上的固定。"), \
							span_notice("你开始解除气闸组件在地面上的固定……"), \
							span_hear("你听到扳手拧动的声音。"))
		if(!tool.use_tool(src, user, 40, volume=100))
			return ITEM_INTERACT_BLOCKING

		if(!anchored)
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("你解除了气闸组件的固定。"))
		name = "气闸组件"
		set_anchored(FALSE)
		update_name()
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	var/door_check = FALSE
	for(var/obj/machinery/door/competitor in loc)
		if(!competitor.sub_door)
			door_check = TRUE
			break

	if(door_check)
		to_chat(user, "这里还有另一扇门！")
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user]把气闸组件固定在地面上。"), \
						span_notice("你开始把气闸组件固定在地面上……"), \
						span_hear("你听到扳手拧动的声音。"))

	if(!tool.use_tool(src, user, 40, volume=100))
		return ITEM_INTERACT_BLOCKING

	if(anchored)
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把气闸组件固定好了。"))
	name = "已固定的气闸组件"
	set_anchored(TRUE)
	update_name()
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/door_assembly/wirecutter_act(mob/living/user, obj/item/tool)
	if(state != AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
		return ITEM_INTERACT_SKIP_TO_ATTACK
	user.visible_message(span_notice("[user]剪断了气闸组件的线路。"), \
						span_notice("你开始剪断气闸组件的线路……"))

	if(!tool.use_tool(src, user, 40, volume=100))
		return ITEM_INTERACT_BLOCKING
	if(state != AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("你剪断了气闸组件的线路。"))
	new/obj/item/stack/cable_coil(get_turf(user), 1)
	state = AIRLOCK_ASSEMBLY_NEEDS_WIRES
	name = "已固定的气闸组件"
	update_name()
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/door_assembly/crowbar_act(mob/living/user, obj/item/tool)
	if(state != AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
		return ITEM_INTERACT_SKIP_TO_ATTACK
	user.visible_message(span_notice("[user]从气闸组件里取出了电子元件。"), \
						span_notice("你开始从气闸组件里取出电子元件……"))

	if(!tool.use_tool(src, user, 40, volume=100))
		return ITEM_INTERACT_BLOCKING

	if(state != AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你取出了气闸电子元件。"))
	state = AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS
	name = "已接线气闸组件"
	var/obj/item/electronics/airlock/ae
	if (!electronics)
		ae = new/obj/item/electronics/airlock(loc)
	else
		ae = electronics
		electronics = null
		ae.forceMove(src.loc)
	update_name()
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/door_assembly/screwdriver_act(mob/living/user, obj/item/tool)
	if(state != AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
		return ITEM_INTERACT_SKIP_TO_ATTACK

	user.visible_message(span_notice("[user]完成了气闸。"), \
						span_notice("你开始完成气闸的组装……"))
	if(!tool.use_tool(src, user, 40, volume=100))
		return ITEM_INTERACT_BLOCKING

	if(!loc || state != AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("你完成了气闸。"))
	finish_door()
	return ITEM_INTERACT_SUCCESS

/obj/structure/door_assembly/proc/finish_door()
	var/obj/machinery/door/airlock/door
	if(glass)
		door = new glass_type( loc )
	else
		door = new airlock_type( loc )
	door.setDir(dir)
	door.unres_sides = electronics.unres_sides
	door.electronics = electronics
	door.heat_proof = heat_proof_finished
	door.security_level = 0
	if(electronics.shell)
		door.AddComponent( \
			/datum/component/shell, \
			unremovable_circuit_components = list(new /obj/item/circuit_component/airlock, new /obj/item/circuit_component/airlock_access_event, new /obj/item/circuit_component/remotecam/airlock), \
			capacity = SHELL_CAPACITY_LARGE, \
			shell_flags = SHELL_FLAG_ALLOW_FAILURE_ACTION|SHELL_FLAG_REQUIRE_ANCHOR \
		)
	if(electronics.one_access)
		door.req_one_access = electronics.accesses
	else
		door.req_access = electronics.accesses
	if(created_name)
		door.name = created_name
	else if(electronics.passed_name)
		door.name = sanitize(electronics.passed_name)
	else
		door.name = base_name
	if(electronics.passed_cycle_id)
		door.closeOtherId = electronics.passed_cycle_id
		door.update_other_id()
	if(door.unres_sides)
		door.unres_latch = TRUE
	door.previous_airlock = previous_assembly
	electronics.forceMove(door)
	door.autoclose = TRUE
	door.close()
	door.update_appearance()

	qdel(src)
	return door

/obj/structure/door_assembly/update_overlays()
	. = ..()
	if(!glass)
		. += get_airlock_overlay("fill_construction", icon, src, TRUE)
	else
		. += get_airlock_overlay("glass_construction", overlays_file, src, TRUE)
	. += get_airlock_overlay("panel_c[state+1]", overlays_file, src, TRUE)

/obj/structure/door_assembly/update_name()
	name = ""
	switch(state)
		if(AIRLOCK_ASSEMBLY_NEEDS_WIRES)
			if(anchored)
				name = "已固定的"
		if(AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
			name = "已接线"
		if(AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
			name = "即将完成的"
	name += "[heat_proof_finished ? "隔热" : ""][glass ? "玻璃窗" : ""][base_name]组件"
	return ..()

/obj/structure/door_assembly/proc/transfer_assembly_vars(obj/structure/door_assembly/source, obj/structure/door_assembly/target, previous = FALSE)
	target.glass = source.glass
	target.heat_proof_finished = source.heat_proof_finished
	target.created_name = source.created_name
	target.state = source.state
	target.set_anchored(source.anchored)
	if(previous)
		target.previous_assembly = source.type
	if(electronics)
		target.electronics = source.electronics
		source.electronics.forceMove(target)
	target.update_appearance()
	target.update_name()
	qdel(source)

/obj/structure/door_assembly/atom_deconstruct(disassembled = TRUE)
	var/turf/target_turf = get_turf(src)
	if(!disassembled)
		material_amt = rand(2,4)
	new material_type(target_turf, material_amt)
	if(glass)
		if(disassembled)
			if(heat_proof_finished)
				new /obj/item/stack/sheet/rglass(target_turf)
			else
				new /obj/item/stack/sheet/glass(target_turf)
		else
			new /obj/item/shard(target_turf)
	if(mineral)
		var/obj/item/stack/sheet/mineral/mineral_path = text2path("/obj/item/stack/sheet/mineral/[mineral]")
		new mineral_path(target_turf, 2)

/obj/structure/door_assembly/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.mode == RCD_DECONSTRUCT)
		return list("delay" = 5 SECONDS, "cost" = 16)
	return FALSE

/obj/structure/door_assembly/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, list/rcd_data)
	if(rcd_data[RCD_DESIGN_MODE] == RCD_DECONSTRUCT)
		qdel(src)
		return TRUE
	return FALSE

/obj/structure/door_assembly/nameformat(input, mob/living/user)
	created_name = input
	return input

/obj/structure/door_assembly/rename_reset()
	created_name = null
