/obj/structure/girder
	icon = 'icons/obj/smooth_structures/girder.dmi'
	name = "钢梁"
	base_icon_state = "girder"
	icon_state = "girder-0"
	desc = "由金属构成的大型结构组件；需要铺设一层铁板才能算作墙壁。"
	anchored = TRUE
	density = TRUE
	max_integrity = 200
	rad_insulation = RAD_VERY_LIGHT_INSULATION
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_GIRDER
	canSmoothWith = SMOOTH_GROUP_GIRDER + SMOOTH_GROUP_WALLS
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

	/// The stack type required to construct and dropped upon deconstructing the girder.
	var/stack_type = /obj/item/stack/sheet/iron
	/// The stack amount required to construct and dropped upon deconstructing the girder.
	var/stack_amount = 2
	/// Always drops the stack in full, even when demolished rather than disassembled.
	var/always_drop_stack = FALSE

	/// The current state of the girder. Used for construction.
	var/state = GIRDER_NORMAL
	/// Whether the girder can be unanchored by wrenching it.
	var/can_displace = TRUE
	/// Whether the girder can be welded apart. (for cult and bronze girders)
	var/can_weld_apart = FALSE

	/// The percentage chance (0-100) that a projectile passes through the girder.
	var/projectile_pass_chance = 20

/obj/structure/girder/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/uses_girder_wall_recipes)

/obj/structure/girder/examine(mob/user)
	. = ..()
	switch(state)
		if(GIRDER_REINF)
			. += span_notice("支撑柱已用<b>螺丝</b>固定到位。")
		if(GIRDER_REINF_STRUTS)
			. += span_notice("支撑柱已<i>松开螺丝</i>，内部<b>格栅</b>完好。")
		if(GIRDER_NORMAL)
			if(can_displace)
				. += span_notice("螺栓已用<b>扳手</b>固定到位。")
		if(GIRDER_DISPLACED)
			. += span_notice("螺栓已<i>松开</i>，但<b>螺丝</b>仍将[src]固定在一起。")
		if(GIRDER_TRAM)
			. += span_notice("[src]专为电车使用而设计。可用螺丝刀拆卸！")
	if (can_weld_apart)
		. += span_notice("框架看起来足够脆弱，可以用<b>焊接</b>切开。")
	else
		. += span_notice("框架可以用<b>等离子切割器</b>切开。")

/obj/structure/girder/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if (user.combat_mode)
		return
	if (istype(tool, /obj/item/stack/sheet/plasteel))
		if (try_construction_step(user, tool, 5 SECONDS, req_state = GIRDER_NORMAL, start_alert = "正在加固框架……", amount = 1))
			replace_girder(/obj/structure/girder/reinforced)
			return ITEM_INTERACT_SUCCESS
		return ITEM_INTERACT_BLOCKING

/obj/structure/girder/screwdriver_act(mob/user, obj/item/tool)
	. = ITEM_INTERACT_BLOCKING
	switch (state)
		if (GIRDER_TRAM)
			if (try_construction_step(user, tool, 4 SECONDS, req_state = GIRDER_TRAM, start_alert = "正在拆卸框架……"))
				deconstruct(disassembled = TRUE)
				return ITEM_INTERACT_SUCCESS
		if (GIRDER_DISPLACED)
			if (try_construction_step(user, tool, 4 SECONDS, req_state = GIRDER_DISPLACED, start_alert = "正在拆卸框架……"))
				deconstruct(disassembled = TRUE)
				return ITEM_INTERACT_SUCCESS
		if (GIRDER_REINF)
			if (try_construction_step(user, tool, 4 SECONDS, req_state = GIRDER_REINF, start_alert = "正在松开支撑柱……"))
				state = GIRDER_REINF_STRUTS
				return ITEM_INTERACT_SUCCESS
		if (GIRDER_REINF_STRUTS)
			if (try_construction_step(user, tool, 4 SECONDS, req_state = GIRDER_REINF_STRUTS, start_alert = "正在固定支撑柱……"))
				state = GIRDER_REINF
				return ITEM_INTERACT_SUCCESS

/obj/structure/girder/wirecutter_act(mob/user, obj/item/tool)
	. = ITEM_INTERACT_BLOCKING
	if (try_construction_step(user, tool, 4 SECONDS, req_state = GIRDER_REINF_STRUTS, start_alert = "正在拆除内部格栅……"))
		new /obj/item/stack/sheet/plasteel(get_turf(src))
		replace_girder(/obj/structure/girder)
		return ITEM_INTERACT_SUCCESS

/obj/structure/girder/wrench_act(mob/user, obj/item/tool)
	. = ITEM_INTERACT_BLOCKING
	if (!can_displace)
		balloon_alert(user, "没有螺栓！")
		return
	switch (state)
		if (GIRDER_NORMAL)
			if (try_construction_step(user, tool, 4 SECONDS, req_state = GIRDER_NORMAL, start_alert = "正在松开框架……"))
				replace_girder(/obj/structure/girder/displaced)
				return ITEM_INTERACT_SUCCESS
		if (GIRDER_DISPLACED)
			if (try_construction_step(user, tool, 4 SECONDS, req_state = GIRDER_DISPLACED, start_alert = "正在固定框架……"))
				replace_girder(/obj/structure/girder)
				return ITEM_INTERACT_SUCCESS

/obj/structure/girder/welder_act(mob/living/user, obj/item/tool)
	. = ITEM_INTERACT_BLOCKING
	// Plasmacutters can always slice apart girders.
	if (!can_weld_apart && !istype(tool, /obj/item/gun/energy/plasmacutter))
		balloon_alert(user, "无法焊接拆开！")
		return
	if (try_construction_step(user, tool, 4 SECONDS, start_alert = "正在切割……"))
		deconstruct(disassembled = TRUE)
		return ITEM_INTERACT_SUCCESS

/obj/structure/girder/proc/try_construction_step(mob/living/user, obj/item/tool, delay, req_state, req_floor, start_alert, volume = 100, amount = 0)
	if (!check_state(user, req_state, req_floor))
		return FALSE

	balloon_alert(user, start_alert)

	add_fingerprint(user)
	tool.add_fingerprint(user)

	return tool.use_tool(src, user, delay, amount, volume, CALLBACK(src, PROC_REF(check_state), user, req_state, req_floor))

/obj/structure/girder/proc/check_state(mob/living/user, req_state, req_anchored, req_floor)
	if (!isnull(req_state) && req_state != state)
		return FALSE
	if (req_floor && !isfloorturf(loc))
		balloon_alert(user, "需要地板！")
		return FALSE
	return TRUE

// We do this instead of state handling because of the large number of variables we would otherwise need to keep track of.
// That said, ultimately, it would be a better solution for all of it to just be [/obj/structure/girder] at base.
// For example right now if you paint a girder and use a wrench on it, it will magically lose that paint.
/obj/structure/girder/proc/replace_girder(girder_type)
	var/obj/structure/girder/new_girder = new girder_type(loc)
	transfer_fingerprints_to(new_girder)
	new_girder.update_integrity(new_girder.max_integrity * (atom_integrity / max_integrity))
	qdel(src)

/obj/structure/girder/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if((mover.pass_flags & PASSGRILLE) || isprojectile(mover))
		return prob(projectile_pass_chance)

/obj/structure/girder/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	if(!density)
		return TRUE
	if(pass_info.pass_flags & PASSGRILLE)
		return TRUE
	return FALSE

/obj/structure/girder/atom_deconstruct(disassembled = TRUE)
	if (disassembled || always_drop_stack)
		new stack_type(drop_location(), stack_amount)
	else
		var/remains = pick(/obj/item/stack/rods, stack_type)
		new remains(drop_location())

/obj/structure/girder/narsie_act()
	replace_girder(/obj/structure/girder/cult)

/obj/structure/girder/displaced
	name = "移位的钢梁"
	icon = 'icons/obj/structures.dmi'
	icon_state = "displaced"
	anchored = FALSE
	state = GIRDER_DISPLACED
	projectile_pass_chance = 25
	max_integrity = 120
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null

/obj/structure/girder/reinforced
	name = "加固钢梁"
	icon = 'icons/obj/smooth_structures/reinforced_girder.dmi'
	icon_state = "reinforced-0"
	base_icon_state = "reinforced"
	state = GIRDER_REINF
	projectile_pass_chance = 0
	max_integrity = 350

/obj/structure/girder/tram
	name = "电车钢梁"
	desc = "用于构建电车墙壁的钛制框架。可以覆上<b>钛玻璃</b>或其他墙体材料。"
	icon = 'icons/obj/structures.dmi'
	icon_state = "tram"
	state = GIRDER_TRAM
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	stack_type = /obj/item/stack/sheet/mineral/titanium

/obj/structure/girder/tram/corner
	name = "电车框架转角"

//////////////////////////////////////////// cult girder //////////////////////////////////////////////

/obj/structure/girder/cult
	name = "符文钢梁"
	desc = "由一种陌生且冰凉刺骨的金属制成的框架。似乎没有任何螺栓。"
	icon = 'icons/obj/antags/cult/structures.dmi'
	icon_state= "cultgirder"
	can_displace = FALSE
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	custom_materials = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT)
	stack_type = /obj/item/stack/sheet/runed_metal
	stack_amount = 1
	always_drop_stack = TRUE
	can_weld_apart = TRUE

/obj/structure/girder/cult/narsie_act()
	return

/obj/structure/girder/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_TURF)
			if(the_rcd.rcd_design_path != /turf/open/floor/plating/rcd)
				return FALSE

			return rcd_result_with_memory(
				list("delay" = 2 SECONDS, "cost" = 8),
				get_turf(src), RCD_MEMORY_WALL,
			)
		if(RCD_DECONSTRUCT)
			return list("delay" = 2 SECONDS, "cost" = 13)
	return FALSE

/obj/structure/girder/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, list/rcd_data)
	switch(rcd_data[RCD_DESIGN_MODE])
		if(RCD_TURF)
			if(the_rcd.rcd_design_path != /turf/open/floor/plating/rcd)
				return FALSE

			var/turf/T = get_turf(src)
			T.place_on_top(/turf/closed/wall)
			qdel(src)
			return TRUE
		if(RCD_DECONSTRUCT)
			qdel(src)
			return TRUE
	return FALSE

/obj/structure/girder/bronze
	name = "墙壁齿轮"
	desc = "由坚固青铜制成的钢梁，外形如同齿轮。"
	icon = 'icons/obj/structures.dmi'
	icon_state = "wall_gear"
	can_displace = FALSE
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	custom_materials = list(/datum/material/bronze = SHEET_MATERIAL_AMOUNT * 2)
	stack_type = /obj/item/stack/sheet/bronze
	stack_amount = 1
	always_drop_stack = TRUE
	can_weld_apart = TRUE
