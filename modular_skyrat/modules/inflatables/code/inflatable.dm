
#define TAPE_REQUIRED_TO_FIX 2
#define INFLATABLE_DOOR_OPENED FALSE
#define INFLATABLE_DOOR_CLOSED TRUE
#define BOX_DOOR_AMOUNT 7
#define BOX_WALL_AMOUNT 14

/obj/structure/inflatable
	name = "充气墙"
	desc = "一层充气薄膜。请勿刺破。按住 Alt 点击可放气。"
	can_atmos_pass = ATMOS_PASS_DENSITY
	density = TRUE
	anchored = TRUE
	max_integrity = 40
	icon = 'modular_skyrat/modules/inflatables/icons/inflatable.dmi'
	icon_state = "wall"
	/// The type we drop when damaged.
	var/torn_type = /obj/item/inflatable/torn
	/// The type we drop when deflated.
	var/deflated_type = /obj/item/inflatable
	/// The hitsound made when we're... hit...
	var/hit_sound = 'sound/effects/glass/glasshit.ogg'
	/// How quickly we deflate when manually deflated.
	var/manual_deflation_time = 3 SECONDS
	/// Whether or not the inflatable has been deflated
	var/has_been_deflated = FALSE

/obj/structure/inflatable/Initialize(mapload)
	. = ..()
	air_update_turf(TRUE, !density)

/obj/structure/inflatable/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			qdel(src)
			return
		if(EXPLODE_HEAVY)
			deflate(TRUE)
			return
		if(EXPLODE_LIGHT)
			if(prob(50))
				deflate(TRUE)
				return

/obj/structure/inflatable/atom_destruction(damage_flag)
	deflate(TRUE)
	return ..()

/obj/structure/inflatable/attackby(obj/item/attacking_item, mob/user, params)
	if(attacking_item.sharpness)
		visible_message(span_danger("<b>[user] 用 [attacking_item] 刺破了 [src]！</b>"))
		deflate(TRUE)
		return
	return ..()

/obj/structure/inflatable/click_alt(mob/user)
	deflate(FALSE)
	return CLICK_ACTION_SUCCESS

/obj/structure/inflatable/play_attack_sound(damage_amount, damage_type, damage_flag)
	playsound(src, hit_sound, 75, TRUE)

// Deflates the airbag and drops a deflated airbag item. If violent, drops a broken item instantly.
/obj/structure/inflatable/proc/deflate(violent)
	if(has_been_deflated) // We do not ever want to deflate more than once.
		return

	has_been_deflated = TRUE

	playsound(src, 'sound/machines/hiss.ogg', 75, 1)
	if(!violent)
		balloon_alert_to_viewers("缓缓放气！")
		addtimer(CALLBACK(src, PROC_REF(slow_deflate_finish)), manual_deflation_time)
		return

	var/turf/inflatable_loc = get_turf(src)
	inflatable_loc.balloon_alert_to_viewers("[src] 迅速放气！") // just so we don't balloon alert from the qdeleted inflatable object
	if(torn_type)
		new torn_type(get_turf(src))
	qdel(src)

// Called when the airbag is calmly deflated, drops a non-broken item.
/obj/structure/inflatable/proc/slow_deflate_finish()
	if(deflated_type)
		new deflated_type(get_turf(src))
	qdel(src)

GAME_VERB_SRC(/obj/structure/inflatable, hand_deflate, oview(1), "放气", "Object")
	if(usr.stat || usr.can_interact())
		return
	deflate(FALSE)


/obj/structure/inflatable/door
	name = "充气门"
	can_atmos_pass = ATMOS_PASS_DENSITY
	icon = 'modular_skyrat/modules/inflatables/icons/inflatable.dmi'
	icon_state = "door_closed"
	base_icon_state = "door"
	torn_type = /obj/item/inflatable/door/torn
	deflated_type = /obj/item/inflatable/door
	/// Are we open(FALSE), or are we closed(TRUE)?
	var/door_state = INFLATABLE_DOOR_CLOSED

/obj/structure/inflatable/door/Initialize(mapload)
	. = ..()
	density = door_state

/obj/structure/inflatable/door/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!user.can_interact_with(src))
		return
	toggle_door()
	to_chat(user, span_notice("你[door_state ? "关闭" : "打开"]了 [src]！"))

/obj/structure/inflatable/door/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[door_state ? "closed" : "open"]"

/obj/structure/inflatable/door/proc/toggle_door()
	if(door_state) // opening
		door_state = INFLATABLE_DOOR_OPENED
		flick("[base_icon_state]_opening", src)
	else // Closing
		door_state = INFLATABLE_DOOR_CLOSED
		flick("[base_icon_state]_closing", src)
	density = door_state
	air_update_turf(TRUE, !density)
	update_appearance()


// The deployable item
/obj/item/inflatable
	name = "充气墙"
	desc = "一层折叠的薄膜，激活后会迅速膨胀成大型立方体。"
	icon = 'modular_skyrat/modules/inflatables/icons/inflatable.dmi'
	icon_state = "folded_wall"
	base_icon_state = "folded_wall"
	w_class = WEIGHT_CLASS_SMALL
	/// The structure we deploy when used.
	var/structure_type = /obj/structure/inflatable
	/// Are we torn?
	var/torn = FALSE

/obj/item/inflatable/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/inflatable/torn
	torn = TRUE

/obj/item/inflatable/attack_self(mob/user)
	. = ..()
	if(torn)
		to_chat(user, span_warning("[src] 损坏严重，无法使用！"))
		return
	if(locate(structure_type) in get_turf(user))
		to_chat(user, span_warning("这里已经有一堵墙了！"))
		return
	playsound(loc, 'sound/items/zip/zip.ogg', 75, 1)
	to_chat(user, span_notice("你给 [src] 充了气。"))
	if(do_after(user, 1 SECONDS, src))
		new structure_type(get_turf(user))
		qdel(src)

/obj/item/inflatable/attackby(obj/item/attacking_item, mob/user)
	if(!istype(attacking_item, /obj/item/stack/medical/wrap/sticky_tape))
		return ..()
	if(!torn)
		to_chat(user, span_notice("[src] 不需要修补！"))
		return
	var/obj/item/stack/medical/wrap/sticky_tape/attacking_tape = attacking_item
	if(attacking_tape.use(TAPE_REQUIRED_TO_FIX, check = TRUE))
		to_chat(user, span_danger("[attacking_tape] 不够了！你至少需要 [TAPE_REQUIRED_TO_FIX] 段！"))
		return
	if(!do_after(user, 2 SECONDS, src))
		return
	playsound(user, 'modular_skyrat/modules/inflatables/sound/ducttape1.ogg', 50, 1)
	to_chat(user, span_notice("你用 [attacking_tape] 修好了 [src]！"))
	attacking_tape.use(TAPE_REQUIRED_TO_FIX)
	torn = FALSE
	update_appearance()

/obj/item/inflatable/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][torn ? "_torn" : ""]"

/obj/item/inflatable/examine(mob/user)
	. = ..()
	if(torn)
		. += span_warning("它破损严重，无法使用！看起来可以用一些<b>胶带</b>修补。")

/obj/item/inflatable/suicide_act(mob/living/user)
	visible_message(user, span_danger("[user] 开始把 [src] 往自己屁股里塞！看样子就要拉绳子了，我靠！"))
	playsound(user.loc, 'sound/machines/hiss.ogg', 75, 1)
	new structure_type(user.loc)
	user.gib()
	return BRUTELOSS

/obj/item/inflatable/door
	name = "充气门"
	desc = "一层折叠的薄膜，激活后会迅速膨胀成一扇简易门。"
	icon = 'modular_skyrat/modules/inflatables/icons/inflatable.dmi'
	icon_state = "folded_door"
	base_icon_state = "folded_door"
	structure_type = /obj/structure/inflatable/door

/obj/item/inflatable/door/torn
	torn = TRUE


/// The storage for the inflatables box.
/datum/storage/inflatables_box
	max_slots = (BOX_DOOR_AMOUNT + BOX_WALL_AMOUNT)
	max_specific_storage = WEIGHT_CLASS_SMALL
	max_total_storage = (BOX_DOOR_AMOUNT + BOX_WALL_AMOUNT) * WEIGHT_CLASS_SMALL


/// The box full of inflatables
/obj/item/storage/inflatable
	icon = 'modular_skyrat/modules/more_briefcases/icons/briefcases.dmi'
	name = "充气屏障箱"
	desc = "内含充气墙和充气门。"
	icon_state = "briefcase_inflate"
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/inflatables_box

/obj/item/storage/inflatable/Initialize(mapload)
	. = ..()
	atom_storage.set_holdable(typesof(/obj/item/inflatable))

/obj/item/storage/inflatable/PopulateContents()
	for(var/i = 0, i < BOX_DOOR_AMOUNT, i++)
		new /obj/item/inflatable/door(src)
	for(var/i = 0, i < BOX_WALL_AMOUNT, i ++)
		new /obj/item/inflatable(src)

#undef TAPE_REQUIRED_TO_FIX
#undef INFLATABLE_DOOR_OPENED
#undef INFLATABLE_DOOR_CLOSED
#undef BOX_DOOR_AMOUNT
#undef BOX_WALL_AMOUNT
