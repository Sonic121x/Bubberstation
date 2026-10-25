/**
 * PLATINGS
 *
 * Handle interaction with tiles and lets you put stuff on top of it.
 */
/turf/open/floor/plating
	name = "地板基板"
	icon_state = "plating"
	base_icon_state = "plating"
	overfloor_placed = FALSE
	underfloor_accessibility = UNDERFLOOR_INTERACTABLE
	baseturfs = /turf/baseturf_bottom
	footstep = FOOTSTEP_PLATING
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	rust_resistance = RUST_RESISTANCE_BASIC

	//Can this plating have reinforced floors placed ontop of it
	var/attachment_holes = TRUE

	//Used for upgrading this into R-Plating
	var/upgradable = TRUE

/turf/open/floor/plating/broken_states()
	return list("damaged1", "damaged2", "damaged4")

/turf/open/floor/plating/burnt_states()
	return list("floorscorched1", "floorscorched2")

/turf/open/floor/plating/examine(mob/user)
	. = ..()
	if(broken || burnt)
		. += span_notice("这些凹痕似乎可以<i>焊接</i>平整。")
		return
	if(attachment_holes)
		. += span_notice("这里有几个安装孔，可以装新的<i>地砖</i>或加固<i>金属杆</i>。")
	else
		. += span_notice("你也许可以用一些<i>地砖</i>在上面铺设……")
	if(upgradable)
		. += span_notice("用一些塑钢也许能让这块基板更坚固。")

#define PLATE_REINFORCE_COST 2

/turf/open/floor/plating/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(ITEM_INTERACT_ANY_BLOCKER & .)
		return .

	if(istype(tool, /obj/item/stack/rods) && attachment_holes)
		if(broken || burnt)
			to_chat(user, span_warning("先修理基板！使用焊接工具[iscyborg(user) ? "或基板修复工具" : ""]来修复损伤。"))
			return ITEM_INTERACT_BLOCKING

		var/obj/item/stack/rods/material = tool
		if (material.get_amount() < 2)
			to_chat(user, span_warning("你需要两根金属杆才能做成加固地板！"))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("你开始加固地板……"))
		if(!do_after(user, 3 SECONDS, target = src))
			return ITEM_INTERACT_BLOCKING

		if (material.get_amount() < 2 || istype(src, /turf/open/floor/engine))
			return ITEM_INTERACT_BLOCKING

		place_on_top(/turf/open/floor/engine, flags = CHANGETURF_INHERIT_AIR)
		playsound(src, 'sound/items/deconstruct.ogg', 80, TRUE)
		material.use(2)
		to_chat(user, span_notice("你加固了地板。"))
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stack/tile))
		if(broken || burnt)
			balloon_alert(user, "损坏太严重，请使用焊接[iscyborg(user) ? "或基板修复" : ""]工具！")
			return ITEM_INTERACT_BLOCKING

		for(var/obj/blocker in src)
			for(var/mob/sitter as anything in blocker.buckled_mobs)
				to_chat(user, span_warning("有人被扣在[blocker]上！解开[sitter]的扣具，把对方挪开。"))
				return ITEM_INTERACT_BLOCKING

		var/obj/item/stack/tile/tile = tool
		tile.place_tile(src, user)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/cautery/prt)) //plating repair tool
		if((!broken && !burnt) || !tool.use_tool(src, user, 0, volume=80))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_danger("你修好了破损基板上的一些凹痕。"))
		icon_state = base_icon_state
		burnt = FALSE
		broken = FALSE
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stack/sheet/plasteel) && upgradable) //Reinforcement!
		if(broken || burnt)
			balloon_alert(user, "损坏太严重，请使用焊接[iscyborg(user) ? "或基板修复" : ""]工具！")
			return ITEM_INTERACT_BLOCKING

		var/obj/item/stack/sheet/sheets = tool
		if(sheets.get_amount() < PLATE_REINFORCE_COST)
			return ITEM_INTERACT_BLOCKING

		balloon_alert(user, "正在加固基板……")
		if(!do_after(user, 12 SECONDS, target = src))
			return ITEM_INTERACT_BLOCKING
		if(sheets.get_amount() < PLATE_REINFORCE_COST || istype(src, /turf/open/floor/plating/reinforced))
			return ITEM_INTERACT_BLOCKING
		sheets.use(PLATE_REINFORCE_COST)
		playsound(src, 'sound/machines/creak.ogg', 100, vary = TRUE)
		place_on_top(/turf/open/floor/plating/reinforced, CHANGETURF_INHERIT_AIR)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stack/sheet/mineral/plastitanium) && attachment_holes)
		if(broken || burnt)
			to_chat(user, span_warning("先修理基板！使用焊接工具[iscyborg(user) ? "或基板修复工具" : ""]来修复损伤。"))
			return ITEM_INTERACT_BLOCKING

		var/obj/item/stack/sheet/mineral/plastitanium/sheet = tool
		if (sheet.get_amount() < 1)
			to_chat(user, span_warning("你手里真的什么都没拿。")) // finally a reasonable message
			return ITEM_INTERACT_BLOCKING

		balloon_alert(user, "正在铺设绝缘地板……")
		if(!do_after(user, 1.5 SECONDS, target = src))
			return ITEM_INTERACT_BLOCKING

		if(sheet.get_amount() < 1 || istype(src, /turf/open/floor/engine/insulation))
			return ITEM_INTERACT_BLOCKING

		place_on_top(/turf/open/floor/engine/insulation, flags = CHANGETURF_INHERIT_AIR)
		playsound(src, 'sound/items/deconstruct.ogg', 80, TRUE)
		sheet.use(1)
		to_chat(user, span_notice("你为地板铺上了绝缘层。"))
		balloon_alert(user, "已绝缘！")
		return ITEM_INTERACT_SUCCESS

/turf/open/floor/plating/welder_act(mob/living/user, obj/item/tool)
	if((!broken && !burnt) || !tool.use_tool(src, user, 0, volume=80))
		return NONE
	to_chat(user, span_danger("你修好了破损基板上的一些凹痕。"))
	icon_state = base_icon_state
	burnt = FALSE
	broken = FALSE
	update_appearance()
	return ITEM_INTERACT_SUCCESS

#undef PLATE_REINFORCE_COST



/turf/open/floor/plating/make_plating(force = FALSE)
	return

/turf/open/floor/plating/foam
	name = "金属泡沫基板"
	desc = "由金属泡沫制成的薄而脆弱的地板。设计上便于在战斗状态下用地砖快速替换。"
	icon_state = "foam_plating"
	upgradable = FALSE
	attachment_holes = FALSE

/turf/open/floor/plating/foam/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/tool_blocker, TOOL_WELDER, TOOL_ACT_PRIMARY)

/turf/open/floor/plating/foam/burn_tile()
	return //jetfuel can't melt steel foam

/turf/open/floor/plating/foam/break_tile()
	return //jetfuel can't break steel foam...

/turf/open/floor/plating/foam/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!ismetaltile(tool))
		return NONE

	var/obj/item/stack/tile/tiles = tool
	if(!tiles.use(1))
		return ITEM_INTERACT_BLOCKING
	var/obj/lattice = locate(/obj/structure/lattice) in src
	if(lattice)
		qdel(lattice)
	to_chat(user, span_notice("你用地砖加固了泡沫基板。"))
	playsound(src, 'sound/items/weapons/Genhit.ogg', 50, TRUE)
	ChangeTurf(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
	return ITEM_INTERACT_SUCCESS

/turf/open/floor/plating/foam/attackby(obj/item/attacking_item, mob/user, list/modifiers)
	playsound(src, 'sound/items/weapons/tap.ogg', 100, TRUE) //The attack sound is muffled by the foam itself
	user.changeNext_move(CLICK_CD_MELEE)
	user.do_attack_animation(src)
	if(prob(attacking_item.force * 20 - 25))
		user.visible_message(span_danger("[user]砸穿了[src]！"), \
						span_danger("你用[attacking_item]砸穿了[src]！"))
		ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	else
		to_chat(user, span_danger("你击打[src]，毫无效果！"))

/turf/open/floor/plating/foam/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.mode == RCD_TURF && the_rcd.rcd_design_path == /turf/open/floor/plating/rcd)
		return list("delay" = 0, "cost" = 1)

/turf/open/floor/plating/foam/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, list/rcd_data)
	if(rcd_data[RCD_DESIGN_MODE] == RCD_TURF && rcd_data[RCD_DESIGN_PATH] == /turf/open/floor/plating/rcd)
		ChangeTurf(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
		return TRUE
	return FALSE

/turf/open/floor/plating/foam/ex_act()
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	return TRUE

//reinforced plating deconstruction states
#define PLATE_INTACT 0
#define PLATE_BOLTS_LOOSENED 1
#define PLATE_CUT 2

/turf/open/floor/plating/reinforced //RCD Proof plating designed to be used on Multi-Z maps to protect the rooms below
	name = "加固基板"
	desc = "由多层金属制成的厚实坚固的地板。"
	icon_state = "r_plate-0"

	thermal_conductivity = 0.025
	heat_capacity = INFINITY

	baseturfs = /turf/open/floor/plating
	rcd_proof = TRUE
	upgradable = FALSE
	rust_resistance = RUST_RESISTANCE_REINFORCED

	//Used to track which stage of deconstruction the plate is currently in, Intact > Bolts Loosened > Cut
	var/deconstruction_state = PLATE_INTACT

/turf/open/floor/plating/reinforced/examine(mob/user)
	. += ..()
	. += deconstruction_hints(user)

/turf/open/floor/plating/reinforced/proc/deconstruction_hints(mob/user)
	switch(deconstruction_state)
		if(PLATE_INTACT)
			return span_notice("基板的加固层已被<b>螺栓</b>牢牢固定。")
		if(PLATE_BOLTS_LOOSENED)
			return span_notice("基板的加固层螺栓已<i>松开</i>，但仍被<b>焊接</b>牢牢固定在基板上。")
		if(PLATE_CUT)
			return span_notice("基板的加固层已被<i>切开</i>，但仍<b>松松地</b>搁在原位。")

/turf/open/floor/plating/reinforced/update_icon_state()
	icon_state = "r_plate-[deconstruction_state]"
	return ..()

/turf/open/floor/plating/reinforced/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	user.changeNext_move(CLICK_CD_MELEE)
	if (!ISADVANCEDTOOLUSER(user))
		to_chat(user, span_warning("你的手不够灵巧，做不了这个！"))
		return ITEM_INTERACT_BLOCKING

	//get the user's location
	if(!isturf(user.loc))
		return ITEM_INTERACT_BLOCKING//can't do this stuff whilst inside objects and such

	add_fingerprint(user)

	if(deconstruct_steps(tool, user))
		return ITEM_INTERACT_SUCCESS

	return ..()

/turf/open/floor/plating/reinforced/proc/deconstruct_steps(obj/item/tool_used, mob/user)
	switch(deconstruction_state)
		if(PLATE_INTACT)
			if(tool_used.tool_behaviour == TOOL_WRENCH)
				balloon_alert(user, "正在松开螺栓……")
				if(tool_used.use_tool(src, user, 10 SECONDS, volume=100))
					if(!istype(src, /turf/open/floor/plating/reinforced) || deconstruction_state != PLATE_INTACT)
						return TRUE
					deconstruction_state = PLATE_BOLTS_LOOSENED
					update_appearance(UPDATE_ICON)
					drop_screws()
					balloon_alert(user, "已拆下螺栓")
				return TRUE

		if(PLATE_BOLTS_LOOSENED)
			switch(tool_used.tool_behaviour)
				if(TOOL_WELDER)
					if(!tool_used.tool_start_check(user, amount=3))
						return
					balloon_alert(user, "正在切割……")
					if(tool_used.use_tool(src, user, 15 SECONDS, volume=100))
						if(!istype(src, /turf/open/floor/plating/reinforced) || deconstruction_state != PLATE_BOLTS_LOOSENED)
							return TRUE
						deconstruction_state = PLATE_CUT
						update_appearance(UPDATE_ICON)
						balloon_alert(user, "已切断")
					return TRUE

				if(TOOL_SCREWDRIVER)
					balloon_alert(user, "正在固定螺栓……")
					if(tool_used.use_tool(src, user, 15 SECONDS, volume=100))
						if(!istype(src, /turf/open/floor/plating/reinforced) || deconstruction_state != PLATE_BOLTS_LOOSENED)
							return TRUE
						deconstruction_state = PLATE_INTACT
						update_appearance(UPDATE_ICON)
						balloon_alert(user, "已固定")
					return TRUE
			return FALSE

		if(PLATE_CUT)
			switch(tool_used.tool_behaviour)
				if(TOOL_CROWBAR)
					balloon_alert(user, "正在撬起……")
					if(tool_used.use_tool(src, user, 20 SECONDS, volume=100))
						if(!istype(src,  /turf/open/floor/plating/reinforced) || deconstruction_state != PLATE_CUT)
							return TRUE
						balloon_alert(user, "已撬下")
						new /obj/item/stack/sheet/plasteel(src, 2)
						ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
					return TRUE

				if(TOOL_WELDER)
					if(!tool_used.tool_start_check(user, amount=3))
						return
					balloon_alert(user, "正在重新焊上……")
					if(tool_used.use_tool(src, user, 15 SECONDS, volume=100))
						if(!istype(src,  /turf/open/floor/plating/reinforced) || deconstruction_state != PLATE_CUT)
							return TRUE
						deconstruction_state = PLATE_BOLTS_LOOSENED
						update_appearance(UPDATE_ICON)
						balloon_alert(user, "已重新焊上")
					return TRUE
			return FALSE
	return FALSE

/turf/open/floor/plating/reinforced/proc/drop_screws() //When you start dismantling R-Plates they'll drop their bolts on the Z-level below, a little visible warning.
	var/turf/below_turf = get_step_multiz(src, DOWN)
	while(istype(below_turf, /turf/open/openspace))
		below_turf = get_step_multiz(below_turf, DOWN)
	if(!isnull(below_turf) && !isspaceturf(below_turf))
		new /obj/effect/decal/cleanable/glass/plastitanium/screws(below_turf)
		playsound(src, 'sound/effects/structure_stress/pop3.ogg', 100, vary = TRUE)

/turf/open/floor/plating/reinforced/airless
	initial_gas_mix = AIRLESS_ATMOS

///not an actual turf its used just for rcd ui purposes
/turf/open/floor/plating/rcd
	name = "地板/墙壁"
	icon = 'icons/hud/radial.dmi'
	icon_state = "wallfloor"

#undef PLATE_INTACT
#undef PLATE_BOLTS_LOOSENED
#undef PLATE_CUT
