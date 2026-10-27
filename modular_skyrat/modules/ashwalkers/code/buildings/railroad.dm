/obj/item/stack/rail_track
	name = "铁轨"
	singular_name = "铁轨"
	desc = "一种原始的运输方式。放在任意地板上即可开始铺设铁路。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "rail_item"
	merge_type = /obj/item/stack/rail_track

/obj/item/stack/rail_track/ten
	amount = 10

/obj/item/stack/rail_track/fifty
	amount = 50

/obj/item/stack/rail_track/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isopenturf(interacting_with))
		return NONE
	var/turf/open/target_turf = get_turf(interacting_with)
	var/obj/structure/railroad/check_rail = locate() in target_turf
	if(check_rail || !use(1))
		return NONE
	to_chat(user, span_notice("你把 [src] 铺在了 [target_turf] 上。"))
	new /obj/structure/railroad(target_turf)
	return ITEM_INTERACT_SUCCESS

/obj/structure/railroad
	name = "铁轨"
	desc = "一种原始的运输方式。你也许能在上面看到几辆轨道车。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "rail"
	anchored = TRUE

/obj/structure/railroad/Initialize(mapload)
	. = ..()
	for(var/obj/structure/railroad/rail in range(2, src))
		rail.change_look()

/obj/structure/railroad/Destroy()
	for(var/obj/structure/railroad/rail in range(2, src))
		rail.change_look(src)
	return ..()

/obj/structure/railroad/proc/change_look(obj/structure/target_structure = null)
	icon_state = "rail"
	var/turf/src_turf = get_turf(src)
	for(var/direction in GLOB.cardinals)
		var/obj/structure/railroad/locate_rail = locate() in get_step(src_turf, direction)
		if(!locate_rail || (target_structure && locate_rail == target_structure))
			continue
		icon_state = "[icon_state][direction]"
	update_appearance()

/obj/structure/railroad/crowbar_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	new /obj/item/stack/rail_track(get_turf(src))
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/vehicle/ridden/rail_cart
	name = "轨道车"
	desc = "一种绝妙的代步方式。它只能在轨道上行驶。它还带有储物空间。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "railcart"
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR
	/// The mutable appearance used for the overlay over buckled mobs.
	var/mutable_appearance/railoverlay
	/// whether there is sand in the cart
	var/has_sand = FALSE

/obj/vehicle/ridden/rail_cart/examine(mob/user)
	. = ..()
	. += span_notice("<br><b>Alt 点击</b>可将一辆轨道车挂接到这辆车上。")
	. += span_notice("<br>填入<b>10 份沙子</b>后，它就能当作种植箱使用！")

/obj/vehicle/ridden/rail_cart/Initialize(mapload)
	. = ..()
	attach_trailer()
	railoverlay = mutable_appearance(icon, "railoverlay", ABOVE_MOB_LAYER, src, ABOVE_GAME_PLANE)
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/rail_cart)

	create_storage(max_total_storage = 21, max_slots = 21)

/obj/vehicle/ridden/rail_cart/post_buckle_mob(mob/living/M)
	. = ..()
	update_overlays(UPDATE_OVERLAYS)

/obj/vehicle/ridden/rail_cart/post_unbuckle_mob(mob/living/M)
	. = ..()
	update_overlays(UPDATE_OVERLAYS)

/obj/vehicle/ridden/rail_cart/update_overlays()
	. = ..()
	if(has_buckled_mobs())
		add_overlay(railoverlay)
	else
		cut_overlay(railoverlay)

/obj/vehicle/ridden/rail_cart/relaymove(mob/living/user, direction)
	var/obj/structure/railroad/locate_rail = locate() in get_step(src, direction)
	if(!canmove || !locate_rail)
		return FALSE
	if(is_driver(user))
		return relaydrive(user, direction)
	return FALSE

/obj/vehicle/ridden/rail_cart/click_alt(mob/user)
	attach_trailer()
	return CLICK_ACTION_SUCCESS

/obj/vehicle/ridden/rail_cart/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	atom_storage?.show_contents(user)

/obj/vehicle/ridden/rail_cart/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/ore/glass))
		var/obj/item/stack/ore/glass/use_item = attacking_item
		if(has_sand || !use_item.use(10))
			return ..()
		AddComponent(/datum/component/simple_farm, TRUE, TRUE, list(0, 16))
		has_sand = TRUE
		RemoveElement(/datum/element/ridable)
		return

	if(attacking_item.tool_behaviour == TOOL_SHOVEL)
		var/datum/component/remove_component = GetComponent(/datum/component/simple_farm)
		if(!remove_component)
			return ..()
		qdel(remove_component)
		has_sand = FALSE
		AddElement(/datum/element/ridable, /datum/component/riding/vehicle/rail_cart)
		return

	return ..()

/// searches the cardinal directions to add this cart to another cart's trailer
/obj/vehicle/ridden/rail_cart/proc/attach_trailer()
	if(trailer)
		remove_trailer()
		return
	for(var/direction in GLOB.cardinals)
		var/obj/vehicle/ridden/rail_cart/locate_cart = locate() in get_step(src, direction)
		if(!locate_cart || locate_cart.trailer == src)
			continue
		add_trailer(locate_cart)
		break

/datum/component/riding/vehicle/rail_cart
	vehicle_move_delay = 0.5
	ride_check_flags = RIDER_NEEDS_LEGS | RIDER_NEEDS_ARMS | UNBUCKLE_DISABLED_RIDER

/datum/component/riding/vehicle/rail_cart/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	return list(
		TEXT_NORTH = list(0, 13, OBJ_LAYER),
		TEXT_SOUTH = list(0, 13, OBJ_LAYER),
		TEXT_EAST = list(0, 13, OBJ_LAYER),
		TEXT_WEST = list(0, 13, OBJ_LAYER),
	)
