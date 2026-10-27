/turf/closed/wall/r_wall
	name = "强化墙"
	desc = "一大块用于分隔房间的强化金属。"
	icon = 'icons/turf/walls/reinforced_wall.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"
	opacity = TRUE
	density = TRUE
	turf_flags = IS_SOLID
	smoothing_flags = SMOOTH_BITMASK
	hardness = 10
	sheet_type = /obj/item/stack/sheet/plasteel
	sheet_amount = 1
	girder_type = /obj/structure/girder/reinforced
	girder_state = GIRDER_REINF
	make_delay = 5 SECONDS
	explosive_resistance = 2
	rad_insulation = RAD_HEAVY_INSULATION
	rust_resistance = RUST_RESISTANCE_REINFORCED
	heat_capacity = 312500 //a little over 5 cm thick , 312500 for 1 m by 2.5 m by 0.25 m plasteel wall. also indicates the temperature at wich the wall will melt (currently only able to melt with H/E pipes)
	///Dismantled state, related to deconstruction.
	var/d_state = INTACT
	///Base icon state to use for deconstruction
	var/base_decon_state = "r_wall"

/turf/closed/wall/r_wall/deconstruction_hints(mob/user)
	switch(d_state)
		if(INTACT)
			return span_notice("外侧<b>格栅</b>完好无损。")
		if(SUPPORT_LINES)
			return span_notice("外侧<i>格栅</i>已被剪开，支撑线被<b>螺丝</b>牢固地固定在外盖上。")
		if(COVER)
			return span_notice("支撑线已被<i>拧松</i>，金属盖被<b>焊接</b>固定在原位。")
		if(CUT_COVER)
			return span_notice("金属盖已被<i>切开</i>，与梁架<b>连接松动</b>。")
		if(ANCHOR_BOLTS)
			return span_notice("外盖已被<i>撬开</i>，固定支撑杆的螺栓被<b>扳紧</b>在原位。")
		if(SUPPORT_RODS)
			return span_notice("固定支撑杆的螺栓已被<i>松开</i>，但仍<b>焊接</b>牢固地固定在梁架上。")
		if(SHEATH)
			return span_notice("支撑杆已被<i>切开</i>，外壳体与梁架<b>连接松动</b>。")

/turf/closed/wall/r_wall/devastate_wall()
	new sheet_type(src, sheet_amount)
	new /obj/item/stack/sheet/iron(src, 2)

/turf/closed/wall/r_wall/hulk_recoil(obj/item/bodypart/arm, mob/living/carbon/human/hulkman, damage = 41)
	return ..()

/turf/closed/wall/r_wall/try_decon(obj/item/W, mob/user, turf/T)
	//DECONSTRUCTION
	switch(d_state)
		if(INTACT)
			if(W.tool_behaviour == TOOL_WIRECUTTER)
				W.play_tool_sound(src, 100)
				d_state = SUPPORT_LINES
				update_appearance()
				to_chat(user, span_notice("你剪开了外侧格栅。"))
				return TRUE

		if(SUPPORT_LINES)
			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, span_notice("你开始拆卸固定支撑线……"))
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_LINES)
						return TRUE
					d_state = COVER
					update_appearance()
					to_chat(user, span_notice("你拆下了支撑线的固定。"))
				return TRUE

			else if(W.tool_behaviour == TOOL_WIRECUTTER)
				W.play_tool_sound(src, 100)
				d_state = INTACT
				update_appearance()
				to_chat(user, span_notice("你修复了外侧格栅。"))
				return TRUE

		if(COVER)
			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=2, heat_required = HIGH_TEMPERATURE_REQUIRED))
					return
				to_chat(user, span_notice("你开始切开金属盖……"))
				if(W.use_tool(src, user, 60, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != COVER)
						return TRUE
					d_state = CUT_COVER
					update_appearance()
					to_chat(user, span_notice("你用力按住盖子，把它顶了下来。"))
				return TRUE

			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, span_notice("你开始固定支撑线……"))
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != COVER)
						return TRUE
					d_state = SUPPORT_LINES
					update_appearance()
					to_chat(user, span_notice("支撑线已被固定。"))
				return TRUE

		if(CUT_COVER)
			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, span_notice("你费力地撬着盖子……"))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != CUT_COVER)
						return TRUE
					d_state = ANCHOR_BOLTS
					update_appearance()
					to_chat(user, span_notice("你撬开了盖子。"))
				return TRUE

			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=2, heat_required = HIGH_TEMPERATURE_REQUIRED))
					return
				to_chat(user, span_notice("你开始把金属盖重新焊回框架……"))
				if(W.use_tool(src, user, 60, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != CUT_COVER)
						return TRUE
					d_state = COVER
					update_appearance()
					to_chat(user, span_notice("金属盖已牢固地焊在框架上。"))
				return TRUE

		if(ANCHOR_BOLTS)
			if(W.tool_behaviour == TOOL_WRENCH)
				to_chat(user, span_notice("你开始拧松把支撑杆固定在框架上的锚固螺栓……"))
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != ANCHOR_BOLTS)
						return TRUE
					d_state = SUPPORT_RODS
					update_appearance()
					to_chat(user, span_notice("你取下了固定支撑杆的螺栓。"))
				return TRUE

			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, span_notice("你开始把盖子撬回原位……"))
				if(W.use_tool(src, user, 20, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != ANCHOR_BOLTS)
						return TRUE
					d_state = CUT_COVER
					update_appearance()
					to_chat(user, span_notice("金属盖已被撬回原位。"))
				return TRUE

		if(SUPPORT_RODS)
			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=2, heat_required = HIGH_TEMPERATURE_REQUIRED))
					return
				to_chat(user, span_notice("你开始切开支撑杆……"))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_RODS)
						return TRUE
					d_state = SHEATH
					update_appearance()
					to_chat(user, span_notice("你切断了支撑杆。"))
				return TRUE

			if(W.tool_behaviour == TOOL_WRENCH)
				to_chat(user, span_notice("你开始拧紧把支撑杆固定在框架上的螺栓……"))
				W.play_tool_sound(src, 100)
				if(W.use_tool(src, user, 40))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_RODS)
						return TRUE
					d_state = ANCHOR_BOLTS
					update_appearance()
					to_chat(user, span_notice("你拧紧了固定支撑杆的螺栓。"))
				return TRUE

		if(SHEATH)
			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, span_notice("你费力地撬着外壳体……"))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SHEATH)
						return TRUE
					to_chat(user, span_notice("你撬开了外壳体。"))
					dismantle_wall()
				return TRUE

			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=0, heat_required = HIGH_TEMPERATURE_REQUIRED))
					return
				to_chat(user, span_notice("你开始把支撑杆重新焊合……"))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SHEATH)
						return TRUE
					d_state = SUPPORT_RODS
					update_appearance()
					to_chat(user, span_notice("你把支撑杆重新焊合了。"))
				return TRUE
	return FALSE

/turf/closed/wall/r_wall/update_icon(updates=ALL)
	. = ..()
	if(d_state != INTACT)
		smoothing_flags = NONE
		return
	if (!(updates & UPDATE_SMOOTHING))
		return
	smoothing_flags = SMOOTH_BITMASK
	QUEUE_SMOOTH_NEIGHBORS(src)
	QUEUE_SMOOTH(src)

// We don't react to smoothing changing here because this else exists only to "revert" intact changes
/turf/closed/wall/r_wall/update_icon_state()
	if(d_state != INTACT)
		icon = 'modular_zubbers/icons/turf/walls/reinforced_states.dmi' // BUBBER EDIT CHANGE - ORIGINAL: icon = 'icons/turf/walls/reinforced_states.dmi'
		icon_state = "[base_decon_state]-[d_state]"
	else
		icon = initial(icon)
		icon_state = "[base_icon_state]-[smoothing_junction]"
	return ..()

/turf/closed/wall/r_wall/wall_singularity_pull(current_size)
	if(current_size >= STAGE_FIVE)
		if(prob(30))
			dismantle_wall()

/turf/closed/wall/r_wall/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if (the_rcd.construction_mode == RCD_WALLFRAME)
		return ..()
	if(!the_rcd.canRturf)
		return
	. = ..()
	if (.)
		.["delay"] *= RCD_RWALL_DELAY_MULT

/turf/closed/wall/r_wall/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, list/rcd_data)
	if(the_rcd.canRturf || rcd_data[RCD_DESIGN_MODE] == RCD_WALLFRAME)
		return ..()

/turf/closed/wall/r_wall/rust_turf(magic = FALSE)
	if(HAS_TRAIT(src, TRAIT_RUSTY))
		ChangeTurf(/turf/closed/wall/rust)
		return TRUE
	return ..()

/turf/closed/wall/r_wall/plastitanium
	name = /turf/closed/wall/mineral/plastitanium::name
	desc = "一面由等离子体与钛合金制成、并用塑钢杆加固的格外耐用的墙。"
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "plastitanium_wall-0"
	base_icon_state = "plastitanium_wall"
	sheet_type = /obj/item/stack/sheet/mineral/plastitanium
	hardness = 25 //plastitanium
	turf_flags = IS_SOLID
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	smoothing_groups = SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS + SMOOTH_GROUP_SYNDICATE_WALLS
	canSmoothWith = SMOOTH_GROUP_SHUTTLE_PARTS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_PLASTITANIUM_WALLS + SMOOTH_GROUP_SYNDICATE_WALLS
	rust_resistance = RUST_RESISTANCE_TITANIUM

/turf/closed/wall/r_wall/plastitanium/nodiagonal
	icon = MAP_SWITCH('icons/turf/walls/plastitanium_wall.dmi', 'icons/turf/walls/misc_wall.dmi')
	icon_state = MAP_SWITCH("plastitanium_wall-0", "plastitanium_nd")
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/r_wall/plastitanium/overspace
	icon = MAP_SWITCH('icons/turf/walls/plastitanium_wall.dmi', 'icons/turf/walls/misc_wall.dmi')
	icon_state = MAP_SWITCH("plastitanium_wall-0", "plastitanium_overspace")
	fixed_underlay = list("space" = TRUE)

/turf/closed/wall/r_wall/plastitanium/syndicate
	name = "船体"
	desc = "一艘外形不祥的船只的装甲外壳。"
	explosive_resistance = 20

/turf/closed/wall/r_wall/plastitanium/syndicate/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	return FALSE

/turf/closed/wall/r_wall/plastitanium/syndicate/nodiagonal
	icon = MAP_SWITCH('icons/turf/walls/plastitanium_wall.dmi', 'icons/turf/walls/misc_wall.dmi')
	icon_state = MAP_SWITCH("plastitanium_wall-0", "plastitanium_nd")
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/r_wall/plastitanium/syndicate/overspace
	icon = MAP_SWITCH('icons/turf/walls/plastitanium_wall.dmi', 'icons/turf/walls/misc_wall.dmi')
	icon_state = MAP_SWITCH("plastitanium_wall-0", "plastitanium_overspace")
	fixed_underlay = list("space" = TRUE)
