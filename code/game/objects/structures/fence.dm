//Chain link fences
//Sprites ported from /VG/


#define CUT_TIME 100
#define CLIMB_TIME 150

#define NO_HOLE 0 //section is intact
#define MEDIUM_HOLE 1 //medium hole in the section - can climb through
#define LARGE_HOLE 2 //large hole in the section - can walk through
#define MAX_HOLE_SIZE LARGE_HOLE

/obj/structure/fence
	name = "围栏"
	desc = "一道链条网围栏。虽然不如墙壁有效，但通常也能把人挡在外面。"
	density = TRUE
	anchored = TRUE

	icon = 'icons/obj/fence.dmi'
	icon_state = "straight"
	tacmap_color = TACMAP_FENCE

	var/cuttable = TRUE
	var/hole_size= NO_HOLE
	var/invulnerable = FALSE

/obj/structure/fence/Initialize(mapload)
	. = ..()

	update_cut_status()

/obj/structure/fence/examine(mob/user)
	. = ..()

	switch(hole_size)
		if(MEDIUM_HOLE)
			. += "[src]上有一个大洞。"
		if(LARGE_HOLE)
			. += "[src]已经被完全剪开了。"

/obj/structure/fence/end
	icon_state = "end"
	cuttable = FALSE

/obj/structure/fence/corner
	icon_state = "corner"
	cuttable = FALSE

/obj/structure/fence/post
	icon_state = "post"
	cuttable = FALSE

/obj/structure/fence/cut/medium
	icon_state = "straight_cut2"
	hole_size = MEDIUM_HOLE

/obj/structure/fence/cut/large
	icon_state = "straight_cut3"
	hole_size = LARGE_HOLE

/obj/structure/fence/wirecutter_act(mob/living/user, obj/item/tool)
	if(!cuttable)
		to_chat(user, span_warning("这段围栏无法剪断！"))
		return ITEM_INTERACT_BLOCKING

	if(invulnerable)
		to_chat(user, span_warning("这围栏太结实了，剪不断！"))
		return ITEM_INTERACT_BLOCKING

	var/current_stage = hole_size
	if(current_stage >= MAX_HOLE_SIZE)
		to_chat(user, span_warning("这围栏已经被剪掉太多了！"))
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_danger("[user]开始用[tool]剪开[src]。"),\
						span_danger("你开始用[tool]剪开[src]。"))

	if(!tool.use_tool(src, user, CUT_TIME))
		return ITEM_INTERACT_BLOCKING
	if(current_stage != hole_size)
		return ITEM_INTERACT_BLOCKING
	switch(++hole_size)
		if(MEDIUM_HOLE)
			visible_message(span_notice("[user]又往[src]上剪了几下。"))
			to_chat(user, span_info("你现在大概能从那个洞里钻过去了。不过如果把洞剪得更大，翻越会快得多。"))
			AddElement(/datum/element/climbable)
		if(LARGE_HOLE)
			visible_message(span_notice("[user]完全剪断了[src]。"))
			to_chat(user, span_info("[src]上的洞现在大到可以走过去了。"))
			RemoveElement(/datum/element/climbable)
	update_cut_status()
	return ITEM_INTERACT_SUCCESS

/obj/structure/fence/proc/update_cut_status()
	if(!cuttable)
		return
	var/new_density = TRUE
	switch(hole_size)
		if(NO_HOLE)
			icon_state = initial(icon_state)
		if(MEDIUM_HOLE)
			icon_state = "straight_cut2"
		if(LARGE_HOLE)
			icon_state = "straight_cut3"
			new_density = FALSE
	set_density(new_density)

//FENCE DOORS

/obj/structure/fence/door
	name = "围栏门"
	desc = "没有一把真正的锁，作用不大。"
	icon_state = "door_closed"
	cuttable = FALSE

/obj/structure/fence/door/Initialize(mapload)
	. = ..()

	update_icon_state()

/obj/structure/fence/door/opened
	icon_state = "door_opened"
	density = FALSE

/obj/structure/fence/door/attack_hand(mob/user, list/modifiers)
	if(can_open(user))
		toggle(user)

	return TRUE

/obj/structure/fence/door/proc/toggle(mob/user)
	visible_message(span_notice("[user][density ? "打开" : "关上"]了[src]。"))
	set_density(!density)
	update_icon_state()
	playsound(src, 'sound/machines/click.ogg', 100, TRUE)

/obj/structure/fence/door/update_icon_state()
	icon_state = density ? "door_closed" : "door_opened"
	return ..()

/obj/structure/fence/door/proc/can_open(mob/user)
	return TRUE

#undef CUT_TIME
#undef CLIMB_TIME

#undef NO_HOLE
#undef MEDIUM_HOLE
#undef LARGE_HOLE
#undef MAX_HOLE_SIZE
