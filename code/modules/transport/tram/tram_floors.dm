/turf/open/floor/noslip/tram
	name = "高摩擦力电车月台"
	icon = 'icons/turf/tram.dmi'
	icon_state = "noslip_tram"
	base_icon_state = "noslip_tram"
	floor_tile = /obj/item/stack/tile/noslip/tram

/turf/open/floor/tram
	name = "电车导轨"
	icon = 'icons/turf/tram.dmi'
	icon_state = "tram_platform"
	base_icon_state = "tram_platform"
	floor_tile = /obj/item/stack/tile/tram
	footstep = FOOTSTEP_CATWALK
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_turf = FALSE
	rcd_proof = TRUE

/turf/open/floor/tram/examine(mob/user)
	. += ..()
	. += span_notice("加强螺栓已[EXAMINE_HINT("扳紧")]固定到位。使用[EXAMINE_HINT("扳手")]即可拆下板材。")

/turf/open/floor/tram/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stack/thermoplastic))
		build_with_transport_tiles(tool, user)
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/stack/sheet/mineral/titanium))
		build_with_titanium(tool, user)
		return ITEM_INTERACT_SUCCESS
	return NONE

/turf/open/floor/tram/make_plating(force = FALSE)
	if(force)
		return ..()
	return //unplateable

/turf/open/floor/tram/try_replace_tile(obj/item/stack/tile/replacement_tile, mob/user, list/modifiers)
	return

/turf/open/floor/tram/crowbar_act(mob/living/user, obj/item/item)
	return

/turf/open/floor/tram/wrench_act(mob/living/user, obj/item/item)
	..()
	to_chat(user, span_notice("你开始拆下板材……"))
	if(item.use_tool(src, user, 30, volume=80))
		if(!istype(src, /turf/open/floor/tram))
			return TRUE
		if(floor_tile)
			new floor_tile(src, 2)
		ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	return TRUE

/turf/open/floor/tram/ex_act(severity, target)
	if(target == src)
		ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		return TRUE
	if(is_explosion_shielded(severity))
		return FALSE

	switch(severity)
		if(EXPLODE_DEVASTATE)
			if(prob(80))
				if(!ispath(baseturf_at_depth(2), /turf/open/floor))
					attempt_lattice_replacement()
				else
					ScrapeAway(2, flags = CHANGETURF_INHERIT_AIR)
			else
				break_tile()
		if(EXPLODE_HEAVY)
			if(prob(30))
				if(!ispath(baseturf_at_depth(2), /turf/open/floor))
					attempt_lattice_replacement()
				else
					ScrapeAway(2, flags = CHANGETURF_INHERIT_AIR)
			else
				break_tile()
		if(EXPLODE_LIGHT)
			if(prob(50))
				break_tile()

	return TRUE

/turf/open/floor/tram/broken_states()
	return list("tram_platform-damaged1","tram_platform-damaged2")

/turf/open/floor/tram/tram_platform/burnt_states()
	return list("tram_platform-scorched1","tram_platform-scorched2")

/turf/open/floor/tram/plate
	name = "线性感应板"
	desc = "为电车供电的线性感应板。"
	icon = 'icons/turf/tram.dmi'
	icon_state = "tram_plate"
	base_icon_state = "tram_plate"
	flags_1 = NONE

/turf/open/floor/tram/plate/broken_states()
	return list("tram_plate-damaged1","tram_plate-damaged2")

/turf/open/floor/tram/plate/burnt_states()
	return list("tram_plate-scorched1","tram_plate-scorched2")

/turf/open/floor/tram/plate/energized
	desc = "为电车供电的线性感应板。它目前处于通电状态。"
	/// Inbound station
	var/inbound
	/// Outbound station
	var/outbound
	/// Transport ID of the tram
	var/specific_transport_id = TRAMSTATION_LINE_1

/turf/open/floor/tram/plate/energized/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/energized, inbound, outbound, specific_transport_id)

/turf/open/floor/tram/plate/energized/examine(mob/user)
	. = ..()
	if(broken || burnt)
		. += span_danger("它看起来已经损坏，电气元件暴露在外！")
		. += span_notice("可以用[EXAMINE_HINT("钛板")]修理这块板材。")

/turf/open/floor/tram/plate/energized/broken_states()
	return list("energized_plate_damaged")

/turf/open/floor/tram/plate/energized/burnt_states()
	return list("energized_plate_damaged")

/turf/open/floor/tram/plate/energized/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!broken && !burnt)
		return NONE
	if(!istype(tool, /obj/item/stack/sheet/mineral/titanium))
		return NONE
	if(!tool.use(1))
		return ITEM_INTERACT_BLOCKING
	broken = FALSE
	update_appearance()
	balloon_alert(user, "板材已更换")
	return ITEM_INTERACT_SUCCESS

/turf/open/floor/tram/plate/energized/broken
	broken = TRUE

// Resetting the tram contents to its original state needs the turf to be there
/turf/open/indestructible/tram
	name = "电车导轨"
	icon = 'icons/turf/tram.dmi'
	icon_state = "tram_platform"
	base_icon_state = "tram_platform"
	footstep = FOOTSTEP_CATWALK
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/indestructible/tram/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stack/thermoplastic))
		build_with_transport_tiles(tool, user)
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/stack/sheet/mineral/titanium))
		build_with_titanium(tool, user)
		return ITEM_INTERACT_SUCCESS
	return NONE

/turf/open/indestructible/tram/plate
	name = "线性感应板"
	desc = "为电车供电的线性感应板。"
	icon_state = "tram_plate"
	base_icon_state = "tram_plate"
	flags_1 = NONE

/turf/open/floor/glass/reinforced/tram/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/atmos_sensitive, mapload)

/turf/open/floor/glass/reinforced/tram
	name = "电车天桥"
	desc = "踩上去会有点晃，但能让你快速往返两侧！"

/obj/structure/thermoplastic
	name = "电车地板"
	desc = "一种轻质热塑性地板。"
	icon = 'icons/turf/tram.dmi'
	icon_state = "tram_dark"
	base_icon_state = "tram_dark"
	density = FALSE
	anchored = TRUE
	max_integrity = 150
	integrity_failure = 0.75
	armor_type = /datum/armor/tram_floor
	layer = TRAM_FLOOR_LAYER
	plane = GAME_PLANE
	obj_flags = BLOCK_Z_OUT_DOWN | BLOCK_Z_OUT_UP
	appearance_flags = PIXEL_SCALE|KEEP_TOGETHER
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT / 2)
	var/secured = TRUE
	var/floor_tile = /obj/item/stack/thermoplastic
	var/mutable_appearance/damage_overlay

/obj/structure/thermoplastic/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/force_move_pulled)

/datum/armor/tram_floor
	melee = 40
	bullet = 10
	laser = 10
	bomb = 45
	fire = 90
	acid = 100

/obj/structure/thermoplastic/light
	icon_state = "tram_light"
	base_icon_state = "tram_light"
	floor_tile = /obj/item/stack/thermoplastic/light

/obj/structure/thermoplastic/examine(mob/user)
	. = ..()

	if(secured)
		. += span_notice("它用一组[EXAMINE_HINT("螺丝")]固定。要拆下地砖，请使用[EXAMINE_HINT("螺丝刀")]。")
	else
		. += span_notice("你可以用[EXAMINE_HINT("撬棍")]拆下地砖。")
		. += span_notice("可以用[EXAMINE_HINT("螺丝刀")]重新固定。")

/obj/structure/thermoplastic/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	. = ..()
	if(.) //received damage
		update_appearance()

/obj/structure/thermoplastic/update_icon_state()
	. = ..()
	var/ratio = atom_integrity / max_integrity
	ratio = ceil(ratio * 4) * 25
	if(ratio > 75)
		icon_state = base_icon_state
		return

	icon_state = "[base_icon_state]_damage[ratio]"

/obj/structure/thermoplastic/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	. = ..()
	if(secured)
		user.visible_message(span_notice("[user] 开始拧下地砖的螺丝……"),
		span_notice("你开始拧下地砖的螺丝……"))
		if(tool.use_tool(src, user, 1 SECONDS, volume = 50))
			secured = FALSE
			to_chat(user, span_notice("螺丝被拧出，地砖边缘出现了一道缝隙。"))
	else
		user.visible_message(span_notice("[user] 开始固定地砖……"),
		span_notice("你开始固定地砖……"))
		if(tool.use_tool(src, user, 1 SECONDS, volume = 50))
			secured = TRUE
			to_chat(user, span_notice("地砖已被牢牢拧紧固定。"))

	return ITEM_INTERACT_SUCCESS

/obj/structure/thermoplastic/crowbar_act_secondary(mob/living/user, obj/item/tool)
	. = ..()
	if(secured)
		to_chat(user, span_warning("需要先拆下固定螺丝！"))
		return FALSE

	else
		user.visible_message(span_notice("[user] 将 \the [tool] 楔入地砖边缘的缝隙，开始撬动……"),
		span_notice("你将 \the [tool] 楔入电车面板边框的缝隙，开始撬动……"))
		if(tool.use_tool(src, user, 1 SECONDS, volume = 50))
			to_chat(user, span_notice("面板从边框中弹了出来。"))
			var/obj/item/stack/thermoplastic/pulled_tile = new floor_tile()
			pulled_tile.update_integrity(atom_integrity)
			user.put_in_hands(pulled_tile)
			qdel(src)

	return ITEM_INTERACT_SUCCESS

/obj/structure/thermoplastic/welder_act(mob/living/user, obj/item/tool)
	if(atom_integrity >= max_integrity)
		to_chat(user, span_warning("[src] 的状况已经完好！"))
		return ITEM_INTERACT_SUCCESS
	if(!tool.tool_start_check(user, amount = 0, heat_required = HIGH_TEMPERATURE_REQUIRED))
		return FALSE
	to_chat(user, span_notice("你开始修理 [src]……"))
	var/integrity_to_repair = max_integrity - atom_integrity
	if(tool.use_tool(src, user, integrity_to_repair * 0.5, volume = 50))
		atom_integrity = max_integrity
		to_chat(user, span_notice("你修好了 [src]。"))
		update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/stack/thermoplastic
	name = "热塑性电车地板砖"
	singular_name = "热塑性电车地板砖"
	desc = "一块高摩擦力地砖。在光线下闪闪发亮。"
	icon = 'icons/obj/tiles.dmi'
	lefthand_file = 'icons/mob/inhands/items/tiles_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/tiles_righthand.dmi'
	icon_state = "tile_tram_dark"
	inhand_icon_state = "tile-tram"
	color = COLOR_TRAM_BLUE
	w_class = WEIGHT_CLASS_NORMAL
	force = 1
	throwforce = 1
	throw_speed = 3
	throw_range = 7
	max_amount = 60
	novariants = TRUE
	merge_type = /obj/item/stack/thermoplastic
	mats_per_unit = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT / 2)
	var/tile_type = /obj/structure/thermoplastic

/obj/item/stack/thermoplastic/light
	icon_state = "tile_tram_light"
	color = COLOR_TRAM_LIGHT_BLUE
	merge_type = /obj/item/stack/thermoplastic/light
	tile_type = /obj/structure/thermoplastic/light

/obj/item/stack/thermoplastic/Initialize(mapload, new_amount, merge = TRUE, list/mat_override=null, mat_amt=1)
	. = ..()
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3) //randomize a little

/obj/item/stack/thermoplastic/examine(mob/user)
	. = ..()
	if(throwforce && !is_cyborg) //do not want to divide by zero or show the message to borgs who can't throw
		var/damage_value
		switch(ceil(MAX_LIVING_HEALTH / throwforce)) //throws to crit a human
			if(1 to 3)
				damage_value = "极佳"
			if(4 to 6)
				damage_value = "很好"
			if(7 to 9)
				damage_value = "不错"
			if(10 to 12)
				damage_value = "还算可以"
			if(13 to 15)
				damage_value = "一般"
		if(!damage_value)
			return
		. += span_notice("这些拿来当投掷武器，效果[damage_value]。")
