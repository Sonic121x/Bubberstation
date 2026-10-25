/obj/structure/light_construct
	name = "灯具框架"
	desc = "正在建造中的灯具。"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "tube-construct-stage1"
	anchored = TRUE
	layer = WALL_OBJ_LAYER
	max_integrity = 200
	armor_type = /datum/armor/structure_light_construct

	///Light construction stage (LIGHT_CONSTRUCT_EMPTY, LIGHT_CONSTRUCT_WIRED, LIGHT_CONSTRUCT_CLOSED)
	var/stage = LIGHT_CONSTRUCT_EMPTY
	///Type of fixture for icon state
	var/fixture_type = "tube"
	///Amount of sheets gained on deconstruction
	var/sheets_refunded = 2
	///Reference for light object
	var/obj/machinery/light/new_light = null
	///Reference for the internal cell
	var/obj/item/stock_parts/power_store/cell
	///Can we support a cell?
	var/cell_connectors = TRUE

/datum/armor/structure_light_construct
	melee = 50
	bullet = 10
	laser = 10
	fire = 80
	acid = 50

/obj/structure/light_construct/Initialize(mapload)
	. = ..()
	if(mapload && !find_and_mount_on_atom(mark_for_late_init = TRUE))
		return INITIALIZE_HINT_LATELOAD

/obj/structure/light_construct/LateInitialize()
	find_and_mount_on_atom(late_init = TRUE)

/obj/structure/light_construct/Destroy()
	QDEL_NULL(cell)
	return ..()

/obj/structure/light_construct/get_turfs_to_mount_on()
	return list(get_step(src, dir))

/obj/structure/light_construct/get_cell()
	return cell

/obj/structure/light_construct/examine(mob/user)
	. = ..()
	switch(stage)
		if(LIGHT_CONSTRUCT_EMPTY)
			. += span_notice("这是个空框架，还没有接电线。")
		if(LIGHT_CONSTRUCT_WIRED)
			. += span_notice("已经接好电线，但螺栓还没拧上。")
		if(LIGHT_CONSTRUCT_CLOSED)
			. += span_notice("外壳已合上。")
	if(cell_connectors)
		if(cell)
			. += span_notice("你看到外壳里有 [cell]。")
		else
			. += span_notice("外壳里没有用于备用电源的电池。")
	else
		. += span_danger("这种外壳不支持安装备用电源电池。")

/obj/structure/light_construct/attack_hand(mob/user, list/modifiers)
	if(!cell)
		return
	user.visible_message(span_notice("[user] 从 [src] 中取出了 [cell]！"), span_notice("你取出了 [cell]。"))
	user.put_in_hands(cell)
	cell = null
	add_fingerprint(user)

/obj/structure/light_construct/attack_tk(mob/user)
	if(!cell)
		return
	to_chat(user, span_notice("你用念力取出了 [cell]。"))
	var/obj/item/stock_parts/power_store/cell_reference = cell
	cell = null
	cell_reference.forceMove(drop_location())
	return cell_reference.attack_tk(user)

/obj/structure/light_construct/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	add_fingerprint(user)
	if(istype(tool, /obj/item/stock_parts/power_store/cell))
		if(!cell_connectors)
			to_chat(user, span_warning("这个[name]无法安装电池！"))
			return ITEM_INTERACT_BLOCKING

		if(!user.temporarilyRemoveItemFromInventory(tool))
			to_chat(user, span_warning("[tool] 粘在你手上了！"))
			return ITEM_INTERACT_BLOCKING

		if(cell)
			to_chat(user, span_warning("已经装有一块电池了！"))
			return ITEM_INTERACT_BLOCKING

		user.visible_message(span_notice("[user] 把 [tool] 接到了 [src] 上。"), \
		span_notice("你把 [tool] 装到了 [src] 上。"))
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		tool.forceMove(src)
		cell = tool
		add_fingerprint(user)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/light))
		to_chat(user, span_warning("这个[name]还没建造完成！"))
		return ITEM_INTERACT_BLOCKING

	if(stage == LIGHT_CONSTRUCT_EMPTY && istype(tool, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/coil = tool
		if(!coil.use(1))
			to_chat(user, span_warning("你需要一段电缆才能为 [src] 接线！"))
			return ITEM_INTERACT_BLOCKING
		icon_state = "[fixture_type]-construct-stage2"
		stage = LIGHT_CONSTRUCT_WIRED
		user.visible_message(span_notice("[user.name] 给 [src] 接上了电线。"), \
							span_notice("你给 [src] 接上了电线。"))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/light_construct/wrench_act(mob/living/user, obj/item/tool)
	switch(stage)
		if(LIGHT_CONSTRUCT_EMPTY)
			if(cell)
				to_chat(user, span_warning("你必须先取出电池！"))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你开始拆解 [src]……"))
			if (!tool.use_tool(src, user, 30, volume=50))
				return ITEM_INTERACT_BLOCKING
			user.visible_message(span_notice("[user.name] 拆解了 [src]。"), \
								span_notice("你拆解了 [src]。"), \
								span_hear("你听到棘轮声。"))
			playsound(src, 'sound/items/deconstruct.ogg', 75, TRUE)
			deconstruct()
			return ITEM_INTERACT_SUCCESS
		if(LIGHT_CONSTRUCT_WIRED)
			to_chat(usr, span_warning("你必须先拆除电线！"))
			return ITEM_INTERACT_BLOCKING
	return NONE

/obj/structure/light_construct/screwdriver_act(mob/living/user, obj/item/tool)
	if(stage != LIGHT_CONSTRUCT_WIRED)
		return NONE
	user.visible_message(span_notice("[user.name] 合上了 [src] 的外壳。"), \
						span_notice("你合上了 [src] 的外壳。"), \
						span_hear("你听到拧螺丝声。"))
	tool.play_tool_sound(src, 75)
	switch(fixture_type)
		if("tube")
			new_light = new /obj/machinery/light/empty(loc)
		if("bulb")
			new_light = new /obj/machinery/light/small/empty(loc)
		if("floor")
			new_light = new /obj/machinery/light/floor/empty(loc)
	new_light.setDir(dir)
	new_light.find_and_mount_on_atom()
	transfer_fingerprints_to(new_light)
	if(!QDELETED(cell))
		new_light.cell = cell
		cell.forceMove(new_light)
		cell = null
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/structure/light_construct/wirecutter_act(mob/living/user, obj/item/tool)
	if(stage != LIGHT_CONSTRUCT_WIRED)
		return NONE
	stage = LIGHT_CONSTRUCT_EMPTY
	icon_state = "[fixture_type]-construct-stage1"
	new /obj/item/stack/cable_coil(drop_location(), 1, "red")
	user.visible_message(span_notice("[user.name] 拆除了 [src] 上的电线。"), \
						span_notice("你拆除了 [src] 上的电线。"), \
						span_hear("你听到咔哒声。"))
	tool.play_tool_sound(src, 100)
	return ITEM_INTERACT_SUCCESS

/obj/structure/light_construct/blob_act(obj/structure/blob/attacking_blob)
	if(attacking_blob && attacking_blob.loc == loc)
		deconstruct(FALSE)

/obj/structure/light_construct/atom_deconstruct(disassembled)
	new /obj/item/stack/sheet/iron(loc, sheets_refunded)
	if(stage == LIGHT_CONSTRUCT_WIRED)
		new /obj/item/stack/cable_coil(drop_location(), 1, "red")

/obj/structure/light_construct/small
	name = "小型灯具框架"
	icon_state = "bulb-construct-stage1"
	fixture_type = "bulb"
	sheets_refunded = 1

/obj/structure/light_construct/floor
	name = "地面灯具框架"
	icon_state = "floor-construct-stage1"
	fixture_type = "floor"
	sheets_refunded = 1

/obj/structure/light_construct/floor/get_turfs_to_mount_on()
	return list(get_turf(src))

/obj/structure/light_construct/floor/is_mountable_turf(turf/target)
	return !isgroundlessturf(target)
