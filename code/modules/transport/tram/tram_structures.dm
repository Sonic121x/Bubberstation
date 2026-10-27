/**
 * the tram has a few objects mapped onto it at roundstart, by default many of those objects have unwanted properties
 * for example grilles and windows have the atmos_sensitive element applied to them, which makes them register to
 * themselves moving to re register signals onto the turf via connect_loc. this is bad and dumb since it makes the tram
 * more expensive to move.
 *
 * if you map something on to the tram, make SURE if possible that it doesnt have anything reacting to its own movement
 * it will make the tram more expensive to move and we dont want that because we dont want to return to the days where
 * the tram took a third of the tick per movement when it's just carrying its default mapped in objects
 */

/obj/structure/grille/tram/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/atmos_sensitive, mapload)
	//atmos_sensitive applies connect_loc which 1. reacts to movement in order to 2. unregister and register signals to
	//the old and new locs. we dont want that, pretend these grilles and windows are plastic or something idk

/obj/structure/tram/Initialize(mapload, direct)
	. = ..()
	RemoveElement(/datum/element/atmos_sensitive, mapload)

/obj/structure/tram
	name = "电车墙板"
	desc = "一种由钛硅酸盐面板构成的轻质钛复合材料结构。"
	icon = 'icons/obj/tram/tram_structure.dmi'
	icon_state = "tram-part-0"
	base_icon_state = "tram-part"
	max_integrity = 150
	layer = TRAM_WALL_LAYER
	density = TRUE
	opacity = FALSE
	anchored = TRUE
	flags_1 = PREVENT_CLICK_UNDER_1
	pass_flags_self = PASSWINDOW
	armor_type = /datum/armor/tram_structure
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TRAM_STRUCTURE
	canSmoothWith = SMOOTH_GROUP_TRAM_STRUCTURE
	can_atmos_pass = ATMOS_PASS_DENSITY
	explosion_block = 3
	receive_ricochet_chance_mod = 1.2
	rad_insulation = RAD_MEDIUM_INSULATION
	/// What state of de/construction it's in
	var/state = TRAM_SCREWED_TO_FRAME
	/// Mineral to return when deconstructed
	var/mineral = /obj/item/stack/sheet/titaniumglass
	/// Amount of mineral to return when deconstructed
	var/mineral_amount = 2
	/// Type of structure made out of girder
	var/tram_wall_type = /obj/structure/tram
	/// Type of girder made when deconstructed
	var/girder_type = /obj/structure/girder/tram
	var/mutable_appearance/damage_overlay
	/// Sound when it breaks
	var/break_sound = SFX_SHATTER
	/// Sound when hit without combat mode
	var/knock_sound = 'sound/effects/glass/glassknock.ogg'
	/// Sound when hit with combat mode
	var/bash_sound = 'sound/effects/glass/glassbash.ogg'

/obj/structure/tram/split
	base_icon_state = "tram-split"

/datum/armor/tram_structure
	melee = 40
	bullet = 10
	laser = 10
	bomb = 45
	fire = 90
	acid = 100

/obj/structure/tram/Initialize(mapload)
	AddElement(/datum/element/blocks_explosives)
	. = ..()
	var/obj/item/stack/initialized_mineral = new mineral
	set_custom_materials(initialized_mineral.mats_per_unit, mineral_amount)
	qdel(initialized_mineral)
	air_update_turf(TRUE, TRUE)
	register_context()

/obj/structure/tram/examine(mob/user)
	. = ..()
	switch(state)
		if(TRAM_SCREWED_TO_FRAME)
			. += span_notice("面板[EXAMINE_HINT("用螺丝固定")]在框架上。要拆卸请使用[EXAMINE_HINT("螺丝刀")]。")
		if(TRAM_IN_FRAME)
			. += span_notice("面板已[EXAMINE_HINT("拧下")]，但仍[EXAMINE_HINT("嵌")]在框架里。要拆卸请使用[EXAMINE_HINT("撬棍")]。")
		if(TRAM_OUT_OF_FRAME)
			. += span_notice("面板已从框架中[EXAMINE_HINT("撬出")]，但仍[EXAMINE_HINT("连着线")]。要拆卸请使用[EXAMINE_HINT("剪线钳")]。")

/obj/structure/tram/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(held_item?.tool_behaviour == TOOL_WELDER && atom_integrity < max_integrity)
		context[SCREENTIP_CONTEXT_LMB] = "修理"
	if(held_item?.tool_behaviour == TOOL_SCREWDRIVER && state == TRAM_SCREWED_TO_FRAME)
		context[SCREENTIP_CONTEXT_RMB] = "拧下面板"
	if(held_item?.tool_behaviour == TOOL_CROWBAR && state == TRAM_IN_FRAME)
		context[SCREENTIP_CONTEXT_RMB] = "取下面板"
	if(held_item?.tool_behaviour == TOOL_WIRECUTTER && state == TRAM_OUT_OF_FRAME)
		context[SCREENTIP_CONTEXT_RMB] = "断开面板接线"

	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/tram/update_overlays(updates = ALL)
	. = ..()
	var/ratio = atom_integrity / max_integrity
	ratio = ceil(ratio * 4) * 25
	cut_overlay(damage_overlay)
	if(ratio > 75)
		return

	damage_overlay = mutable_appearance('icons/obj/structures.dmi', "damage[ratio]", -(layer + 0.1))
	. += damage_overlay

/obj/structure/tram/attack_hand(mob/living/user, list/modifiers)
	. = ..()

	if(!user.combat_mode)
		user.visible_message(span_notice("[user] 敲了敲 [src]。"), \
			span_notice("你敲了敲 [src]。"))
		playsound(src, knock_sound, 50, TRUE)
	else
		user.visible_message(span_warning("[user] 猛砸 [src]！"), \
			span_warning("你猛砸 [src]！"))
		playsound(src, bash_sound, 100, TRUE)

/obj/structure/tram/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_DECONSTRUCT)
			return list("mode" = RCD_DECONSTRUCT, "delay" = 3 SECONDS, "cost" = 10)
	return FALSE

/obj/structure/tram/rcd_act(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_DECONSTRUCT)
			qdel(src)
			return TRUE
	return FALSE

/obj/structure/tram/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	. = ..()
	if(.) //received damage
		update_appearance()

/obj/structure/tram/narsie_act()
	add_atom_colour(NARSIE_WINDOW_COLOUR, FIXED_COLOUR_PRIORITY)

/obj/structure/tram/singularity_pull(atom/singularity, current_size)
	..()

	if(current_size >= STAGE_FIVE)
		deconstruct(disassembled = FALSE)

/obj/structure/tram/welder_act(mob/living/user, obj/item/tool)
	if(atom_integrity >= max_integrity)
		to_chat(user, span_warning("[src] 状况完好！"))
		return ITEM_INTERACT_SUCCESS
	if(!tool.tool_start_check(user, amount = 0, heat_required = HIGH_TEMPERATURE_REQUIRED))
		return FALSE
	to_chat(user, span_notice("你开始修理 [src]……"))
	if(tool.use_tool(src, user, 4 SECONDS, volume = 50))
		atom_integrity = max_integrity
		to_chat(user, span_notice("你修好了 [src]。"))
		update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/tram/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	if(tool.tool_behaviour)
		switch(state)
			if(TRAM_SCREWED_TO_FRAME)
				to_chat(user, span_warning("需要先拆下防拆螺丝！"))
				return ITEM_INTERACT_BLOCKING

			if(TRAM_OUT_OF_FRAME)
				to_chat(user, span_warning("需要先剪断线缆！"))
				return ITEM_INTERACT_BLOCKING
	return NONE

/obj/structure/tram/crowbar_act_secondary(mob/living/user, obj/item/tool)
	switch(state)
		if(TRAM_IN_FRAME)
			user.visible_message(span_notice("[user] 把 \the [tool] 楔入电车面板与框架之间的缝隙，开始撬动……"),
								span_notice("你把 \the [tool] 楔入电车面板与框架之间的缝隙，开始撬动……"))
			if(!tool.use_tool(src, user, 1 SECONDS, volume = 50))
				return ITEM_INTERACT_BLOCKING
			state = TRAM_OUT_OF_FRAME
			to_chat(user, span_notice("面板从框架中弹出，露出一些看起来可以剪断的线缆。"))
			return ITEM_INTERACT_SUCCESS

		if(TRAM_OUT_OF_FRAME)
			user.visible_message(span_notice("[user] 把电车面板咔哒一声装回原位。"),
								span_notice("你把电车面板咔哒一声装回原位。"))
			state = TRAM_IN_FRAME
			return ITEM_INTERACT_SUCCESS

	return NONE //Head back to item_interaction_secondary() to get the same message as other unsuitable tools

/obj/structure/tram/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	switch(state)
		if(TRAM_SCREWED_TO_FRAME)
			user.visible_message(span_notice("[user] 开始从框架上拧下电车面板……"),
								span_notice("你开始从框架上拧下电车面板……"))
			if(!tool.use_tool(src, user, 1 SECONDS, volume = 50))
				return ITEM_INTERACT_BLOCKING
			state = TRAM_IN_FRAME
			to_chat(user, span_notice("螺丝被拧出，面板边缘出现了一道缝隙。"))
			return ITEM_INTERACT_SUCCESS

		if(TRAM_IN_FRAME)
			user.visible_message(span_notice("[user] 重新把电车面板固定到框架上……"),
								span_notice("你重新把电车面板固定到框架上。"))
			state = TRAM_SCREWED_TO_FRAME
			return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/tram/wirecutter_act_secondary(mob/living/user, obj/item/tool)
	if(state != TRAM_OUT_OF_FRAME)
		return NONE
	user.visible_message(span_notice("[user] 开始剪断 \the [src] 上的连接线缆……"),
						span_notice("你开始剪断 \the [src] 上的连接线缆"))
	if(!tool.use_tool(src, user, 1 SECONDS, volume = 50))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("面板脱落，露出框架背板。"))
	deconstruct(disassembled = TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/structure/tram/atom_deconstruct(disassembled = TRUE)
	if(disassembled)
		new girder_type(loc)
	if(mineral_amount)
		for(var/i in 1 to mineral_amount)
			new mineral(loc)

/*
 * Other misc tramwall types
 */
/obj/structure/tram/alt

/obj/structure/tram/alt/titanium
	name = "实心电车墙板"
	desc = "一种轻质钛复合材料结构。在面板通常连接框架的位置还有额外的实心板。"
	icon = 'icons/turf/walls/shuttle_wall.dmi'
	icon_state = "shuttle_wall-0"
	base_icon_state = "shuttle_wall"
	mineral = /obj/item/stack/sheet/mineral/titanium
	tram_wall_type = /obj/structure/tram/alt/titanium
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TITANIUM_WALLS + SMOOTH_GROUP_WALLS
	canSmoothWith = SMOOTH_GROUP_SHUTTLE_PARTS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_TITANIUM_WALLS

/obj/structure/tram/alt/plastitanium
	name = "加固电车墙板"
	desc = "一块由等离子与钛打造的邪恶电车墙板。"
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "plastitanium_wall-0"
	base_icon_state = "plastitanium_wall"
	mineral = /obj/item/stack/sheet/mineral/plastitanium
	tram_wall_type = /obj/structure/tram/alt/plastitanium
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_PLASTITANIUM_WALLS + SMOOTH_GROUP_WALLS
	canSmoothWith = SMOOTH_GROUP_SHUTTLE_PARTS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_PLASTITANIUM_WALLS

/obj/structure/tram/alt/gold
	name = "黄金电车墙板"
	desc = "一块纯金电车墙板。有范儿！"
	icon = 'icons/turf/walls/gold_wall.dmi'
	icon_state = "gold_wall-0"
	base_icon_state = "gold_wall"
	mineral = /obj/item/stack/sheet/mineral/gold
	tram_wall_type = /obj/structure/tram/alt/gold
	explosion_block = 0 //gold is a soft metal you dingus.
	smoothing_groups = SMOOTH_GROUP_GOLD_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_GOLD_WALLS
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/tram/alt/silver
	name = "白银电车墙板"
	desc = "一块纯银电车墙板。闪闪发光！"
	icon = 'icons/turf/walls/silver_wall.dmi'
	icon_state = "silver_wall-0"
	base_icon_state = "silver_wall"
	mineral = /obj/item/stack/sheet/mineral/silver
	tram_wall_type = /obj/structure/tram/alt/silver
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_SILVER_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_SILVER_WALLS
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/tram/alt/diamond
	name = "钻石电车墙板"
	desc = "一种带镶钻面板的复合材料结构。看起来锋利得吓人……"
	icon = 'icons/turf/walls/diamond_wall.dmi'
	icon_state = "diamond_wall-0"
	base_icon_state = "diamond_wall"
	mineral = /obj/item/stack/sheet/mineral/diamond
	tram_wall_type = /obj/structure/tram/alt/diamond //diamond wall takes twice as much time to slice
	max_integrity = 800
	explosion_block = 3
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_DIAMOND_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_DIAMOND_WALLS
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/tram/alt/bananium
	name = "香蕉矿电车墙板"
	desc = "一种覆有香蕉矿镀层的复合材料结构。嘀嘀！"
	icon = 'icons/turf/walls/bananium_wall.dmi'
	icon_state = "bananium_wall-0"
	base_icon_state = "bananium_wall"
	mineral = /obj/item/stack/sheet/mineral/bananium
	tram_wall_type = /obj/structure/tram/alt/bananium
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_BANANIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_BANANIUM_WALLS
	custom_materials = list(/datum/material/bananium = SHEET_MATERIAL_AMOUNT*2)

/obj/structure/tram/alt/sandstone
	name = "砂岩电车墙板"
	desc = "一种覆有砂岩镀层的复合材料结构。粗糙。"
	icon = 'icons/turf/walls/sandstone_wall.dmi'
	icon_state = "sandstone_wall-0"
	base_icon_state = "sandstone_wall"
	mineral = /obj/item/stack/sheet/mineral/sandstone
	tram_wall_type = /obj/structure/tram/alt/sandstone
	explosion_block = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_SANDSTONE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_SANDSTONE_WALLS
	custom_materials = list(/datum/material/sandstone = SHEET_MATERIAL_AMOUNT*2)

/obj/structure/tram/alt/uranium
	article = "a"
	name = "铀电车墙板"
	desc = "一种覆有铀镀层的复合材料结构。这大概不是个好主意。"
	icon = 'icons/turf/walls/uranium_wall.dmi'
	icon_state = "uranium_wall-0"
	base_icon_state = "uranium_wall"
	mineral = /obj/item/stack/sheet/mineral/uranium
	tram_wall_type = /obj/structure/tram/alt/uranium
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_URANIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_URANIUM_WALLS
	custom_materials = list(/datum/material/uranium = SHEET_MATERIAL_AMOUNT*2)

	/// Mutex to prevent infinite recursion when propagating radiation pulses
	var/active = null

	/// The last time a radiation pulse was performed
	var/last_event = 0

/obj/structure/tram/alt/uranium/attackby(obj/item/W, mob/user, list/modifiers, list/attack_modifiers)
	radiate()
	return ..()

/obj/structure/tram/alt/uranium/attack_hand(mob/user, list/modifiers)
	radiate()
	return ..()

/obj/structure/tram/alt/uranium/proc/radiate()
	SIGNAL_HANDLER
	if(active)
		return
	if(world.time <= last_event + 1.5 SECONDS)
		return
	active = TRUE
	radiation_pulse(
		src,
		max_range = 3,
		threshold = RAD_LIGHT_INSULATION,
		chance = URANIUM_IRRADIATION_CHANCE,
		minimum_exposure_time = URANIUM_RADIATION_MINIMUM_EXPOSURE_TIME,
	)
	propagate_radiation_pulse()
	last_event = world.time
	active = FALSE

/obj/structure/tram/alt/plasma
	name = "等离子电车墙板"
	desc = "一种覆有等离子镀层的复合材料结构。这绝对不是个好主意。"
	icon = 'icons/turf/walls/plasma_wall.dmi'
	icon_state = "plasma_wall-0"
	base_icon_state = "plasma_wall"
	mineral = /obj/item/stack/sheet/mineral/plasma
	tram_wall_type = /obj/structure/tram/alt/plasma
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_PLASMA_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_PLASMA_WALLS
	custom_materials = list(/datum/material/plasma = SHEET_MATERIAL_AMOUNT*2)

/obj/structure/tram/alt/wood
	name = "木质电车墙板"
	desc = "一块木框结构的电车墙板。易燃。现在我们改用金属是有原因的。"
	icon = 'icons/turf/walls/wood_wall.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"
	mineral = /obj/item/stack/sheet/mineral/wood
	tram_wall_type = /obj/structure/tram/alt/wood
	explosion_block = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_WOOD_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_WOOD_WALLS
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT*2)

/obj/structure/tram/alt/wood/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!tool.get_sharpness() || !tool.force)
		return NONE
	var/duration = ((4.8 SECONDS) / tool.force) * 2 //In seconds, for now.
	if(istype(tool, /obj/item/hatchet) || istype(tool, /obj/item/fireaxe))
		duration /= 4 //Much better with hatchets and axes.
	to_chat(user, span_notice("你开始拆解 [src]。"))
	if(!do_after(user, duration * (1 SECONDS), target=src)) //Into deciseconds.
		return ITEM_INTERACT_BLOCKING
	deconstruct(disassembled = FALSE)
	return ITEM_INTERACT_SUCCESS

/obj/structure/tram/alt/bamboo
	name = "竹制电车墙板"
	desc = "一块竹框结构的电车墙板。"
	icon = 'icons/turf/walls/bamboo_wall.dmi'
	icon_state = "bamboo_wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_BAMBOO_WALLS + SMOOTH_GROUP_WALLS  + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_BAMBOO_WALLS
	mineral = /obj/item/stack/sheet/mineral/bamboo
	tram_wall_type = /obj/structure/tram/alt/bamboo

/obj/structure/tram/alt/iron
	name = "粗糙铁电车墙板"
	desc = "一种覆有粗糙铁镀层的复合材料结构。"
	icon = 'icons/turf/walls/iron_wall.dmi'
	icon_state = "iron_wall-0"
	base_icon_state = "iron_wall"
	mineral = /obj/item/stack/rods
	mineral_amount = 5
	tram_wall_type = /obj/structure/tram/alt/iron
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_IRON_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_IRON_WALLS
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/structure/tram/alt/abductor
	name = "外星电车墙板"
	desc = "一种由某种外星合金制成的复合材料结构。"
	icon = 'icons/turf/walls/abductor_wall.dmi'
	icon_state = "abductor_wall-0"
	base_icon_state = "abductor_wall"
	mineral = /obj/item/stack/sheet/mineral/abductor
	tram_wall_type = /obj/structure/tram/alt/abductor
	explosion_block = 3
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_ABDUCTOR_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_ABDUCTOR_WALLS
	custom_materials = list(/datum/material/alloy/alien = SHEET_MATERIAL_AMOUNT*2)

/obj/structure/tram/get_dumping_location()
	return null

/obj/structure/tram/spoiler
	name = "电车扰流板"
	icon = 'icons/obj/tram/tram_structure.dmi'
	desc = "纳米传讯买了豪华套餐，以为钛制扰流板能让电车跑得更快。它们纯粹是装饰，或者用来捅穿挡路的人。"
	icon_state = "tram-spoiler-retracted"
	max_integrity = 400
	obj_flags = CAN_BE_HIT
	mineral = /obj/item/stack/sheet/mineral/titanium
	girder_type = /obj/structure/girder/tram/corner
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	/// Position of the spoiler
	var/deployed = FALSE
	/// Locked in position
	var/locked = FALSE
	/// Weakref to the tram piece we control
	var/datum/weakref/tram_ref
	/// The tram we're attached to
	var/tram_id = TRAMSTATION_LINE_1

/obj/structure/tram/spoiler/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/tram/spoiler/LateInitialize()
	RegisterSignal(SStransport, COMSIG_TRANSPORT_UPDATED, PROC_REF(set_spoiler))

/obj/structure/tram/spoiler/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item?.tool_behaviour == TOOL_MULTITOOL && (obj_flags & EMAGGED))
		context[SCREENTIP_CONTEXT_LMB] = "修理"

	if(held_item?.tool_behaviour == TOOL_WELDER && atom_integrity >= max_integrity)
		context[SCREENTIP_CONTEXT_LMB] = "[locked ? "修理" : "破坏"]"

	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/tram/spoiler/examine(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		. += span_warning("电子面板偶尔会打火。可以用[EXAMINE_HINT("多功能工具")]重置。")

	if(locked)
		. += span_warning("扰流板已[EXAMINE_HINT("焊死")]在原位！")
	else
		. += span_notice("可以用[EXAMINE_HINT("焊接器")]把扰流板锁定在原位。")

/obj/structure/tram/spoiler/proc/set_spoiler(source, controller, controller_active, controller_status, travel_direction)
	SIGNAL_HANDLER

	var/spoiler_direction = travel_direction
	if(locked || controller_status & COMM_ERROR || obj_flags & EMAGGED)
		if(!deployed)
			// Bring out the blades
			if(locked)
				visible_message(span_danger("\the [src] 因伺服电机过热而卡死！"))
			do_sparks(3, cardinal_only = FALSE, source = src)
			deploy_spoiler()
		return

	if(!controller_active)
		return

	switch(spoiler_direction)
		if(SOUTH, EAST)
			switch(dir)
				if(NORTH, EAST)
					retract_spoiler()
				if(SOUTH, WEST)
					deploy_spoiler()

		if(NORTH, WEST)
			switch(dir)
				if(NORTH, EAST)
					deploy_spoiler()
				if(SOUTH, WEST)
					retract_spoiler()
	return

/obj/structure/tram/spoiler/proc/deploy_spoiler()
	if(deployed)
		return
	flick("tram-spoiler-deploying", src)
	icon_state = "tram-spoiler-deployed"
	deployed = TRUE
	update_appearance()

/obj/structure/tram/spoiler/proc/retract_spoiler()
	if(!deployed)
		return
	flick("tram-spoiler-retracting", src)
	icon_state = "tram-spoiler-retracted"
	deployed = FALSE
	update_appearance()

/obj/structure/tram/spoiler/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	to_chat(user, span_warning("你让 [src] 的伺服电机短路过热！"), type = MESSAGE_TYPE_INFO)
	playsound(src, SFX_SPARKS, 100, vary = TRUE, extrarange = SHORT_RANGE_SOUND_EXTRARANGE)
	do_sparks(5, cardinal_only = FALSE, source = src)
	obj_flags |= EMAGGED

/obj/structure/tram/spoiler/multitool_act(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return FALSE

	if(obj_flags & EMAGGED)
		balloon_alert(user, "电子系统已重置！")
		obj_flags &= ~EMAGGED
		return TRUE

	return FALSE

/obj/structure/tram/spoiler/welder_act(mob/living/user, obj/item/tool)
	if(!tool.tool_start_check(user, amount = 1, heat_required = HIGH_TEMPERATURE_REQUIRED))
		return FALSE

	if(atom_integrity >= max_integrity)
		to_chat(user, span_warning("你开始焊接 \the [src]，[locked ? "修复损伤" : "防止其回缩"]。"))
		if(!tool.use_tool(src, user, 4 SECONDS, volume = 50))
			return
		locked = !locked
		user.visible_message(span_warning("[user] 用 [tool] [locked ? "把 \the [src] 焊死在原位" : "修理 \the [src]"]。"), \
			span_warning("你完成了 \the [src] 的焊接，[locked ? "将其锁定在原位。" : "它又能自由活动了！"]"), null, COMBAT_MESSAGE_RANGE)

		if(locked)
			deploy_spoiler()

		update_appearance()
		return ITEM_INTERACT_SUCCESS

	to_chat(user, span_notice("你开始修理 [src]……"))
	if(!tool.use_tool(src, user, 4 SECONDS, volume = 50))
		return
	atom_integrity = max_integrity
	to_chat(user, span_notice("你修好了 [src]。"))
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/tram/spoiler/update_overlays()
	. = ..()
	if(deployed && locked)
		. += mutable_appearance(icon, "tram-spoiler-welded")

/obj/structure/chair/sofa/bench/tram
	name = "长椅"
	desc = "专为坐得舒服而设计，睡起来则如同地狱。"
	icon_state = "/obj/structure/chair/sofa/bench/tram"
	post_init_icon_state = "bench_middle"
	greyscale_config = /datum/greyscale_config/bench_middle
	greyscale_colors = COLOR_TRAM_BLUE

/obj/structure/chair/sofa/bench/tram/left
	icon_state = "/obj/structure/chair/sofa/bench/tram/left"
	post_init_icon_state = "bench_left"
	greyscale_config = /datum/greyscale_config/bench_left

/obj/structure/chair/sofa/bench/tram/right
	icon_state = "/obj/structure/chair/sofa/bench/tram/right"
	post_init_icon_state = "bench_right"
	greyscale_config = /datum/greyscale_config/bench_right

/obj/structure/chair/sofa/bench/tram/corner
	icon_state = "/obj/structure/chair/sofa/bench/tram/corner"
	post_init_icon_state = "bench_corner"
	greyscale_config = /datum/greyscale_config/bench_corner

/obj/structure/chair/sofa/bench/tram/solo
	icon_state = "/obj/structure/chair/sofa/bench/tram/solo"
	post_init_icon_state = "bench_solo"
	greyscale_config = /datum/greyscale_config/bench_solo
