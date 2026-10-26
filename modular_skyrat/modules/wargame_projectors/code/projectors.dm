/obj/item/wargame_projector
	name = "全息投影器"
	desc = "纳米传讯海军司令部为兵棋推演开发的便捷全息投影器，这个似乎坏了。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/wargame_projector"
	post_init_icon_state = "projector"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	force = 0
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	item_flags = NOBLUDGEON
	greyscale_config = /datum/greyscale_config/wargame_hologram_projector
	greyscale_colors = COLOR_WHITE
	/// All of the signs this projector is maintaining
	var/list/projections
	/// The maximum number of projections this can support
	var/max_signs = 1
	/// The color to give holograms when created
	var/holosign_color = COLOR_WHITE
	/// The type of hologram to spawn on click
	var/holosign_type = /obj/structure/wargame_hologram
	/// A list containing all of the possible holosigns this can choose from
	var/list/holosign_options = list(
		/obj/structure/wargame_hologram,
	)
	/// Contains all of the colors that the holograms can be changed to spawn as
	var/static/list/color_options = list(
		"红色" = COLOR_RED_LIGHT,
		"橙色" = COLOR_LIGHT_ORANGE,
		"黄色" = COLOR_VIVID_YELLOW,
		"绿色" = COLOR_VIBRANT_LIME,
		"蓝色" = COLOR_BLUE_LIGHT,
		"粉色" = COLOR_FADED_PINK,
		"白色" = COLOR_WHITE,
		"灰色" = COLOR_GRAY,
		"棕色" = COLOR_BROWN,
		"冰蓝色" = COLOR_BLUE_GRAY,
	)
	/// Will hold the choices for radial menu use, populated on init
	var/list/radial_choices = list()
	/// A names to path list for the projections filled out by populate_radial_choice_lists() on init
	var/list/projection_names_to_path = list()

/obj/item/wargame_projector/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/openspace_item_click_handler)
	set_greyscale(holosign_color)
	populate_radial_choice_lists()

/obj/item/wargame_projector/handle_openspace_click(turf/target, mob/user, click_parameters)
	ranged_interact_with_atom(target, user, params2list(click_parameters))

/obj/item/wargame_projector/examine(mob/user)
	. = ..()
	if(projections)
		. += span_notice("目前维持着 <b>[projections.len]/[max_signs]</b> 个投影。")
	. += span_notice("<b>在手中使用</b>投影器可更改生成的全息影像类型。")
	. += span_notice("<b>Alt 点击</b>投影器可更改下一个全息影像的颜色。")
	. += span_warning("<b>Ctrl 点击</b>投影器可清除所有现有全息影像。")

/obj/item/wargame_projector/proc/populate_radial_choice_lists()
	if(!length(radial_choices) || !length(projection_names_to_path))
		for(var/obj/structure/wargame_hologram/hologram as anything in holosign_options)
			projection_names_to_path[initial(hologram.name)] = hologram
			radial_choices[initial(hologram.name)] = image(icon = initial(hologram.icon), icon_state = initial(hologram.icon_state))

/// Changes the selected hologram to one of the options from the hologram list
/obj/item/wargame_projector/proc/select_hologram(mob/user)
	var/picked_choice = show_radial_menu(
		user,
		src,
		radial_choices,
		require_near = TRUE,
		tooltips = TRUE,
		)

	if(isnull(picked_choice))
		return

	holosign_type = projection_names_to_path[picked_choice]

/obj/item/wargame_projector/attack_self(mob/user)
	select_hologram(user)

/obj/item/wargame_projector/click_alt(mob/user)
	var/selected_color = tgui_input_list(user, "选择颜色", "颜色选择", color_options)
	if(isnull(selected_color))
		balloon_alert(user, "未更改颜色")
		return
	var/color_to_set_to = color_options[selected_color]
	holosign_color = color_to_set_to
	balloon_alert(user, "已更改颜色")
	set_greyscale(holosign_color)
	return CLICK_ACTION_SUCCESS

/obj/item/wargame_projector/item_ctrl_click(mob/user)
	if(tgui_alert(user,"清除所有现有全息影像？", "清除全息影像", list("是", "否")) == "是")
		for(var/hologram in projections)
			qdel(hologram)

/// Can we place a hologram at the target location?
/obj/item/wargame_projector/proc/check_can_place_hologram(atom/target, mob/user, team)
	if(!check_allowed_items(target, not_inside = TRUE))
		return FALSE
	var/turf/target_turf = get_turf(target)
	if(target_turf.is_blocked_turf(TRUE))
		return FALSE
	if(LAZYLEN(projections) >= max_signs)
		balloon_alert(user, "已达数量上限！")
		return FALSE
	return TRUE

/// Spawn a hologram with pixel offset based on where the user clicked
/obj/item/wargame_projector/proc/create_hologram(atom/target, mob/user, list/modifiers)
	var/obj/target_holosign = new holosign_type(get_turf(target), src)

	var/click_x
	var/click_y

	if(LAZYACCESS(modifiers, ICON_X) && LAZYACCESS(modifiers, ICON_Y))
		click_x = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(world.icon_size/2), world.icon_size/2)
		click_y = clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(world.icon_size/2), world.icon_size/2)

	target_holosign.pixel_x = click_x
	target_holosign.pixel_y = click_y

	target_holosign.color = holosign_color

	playsound(loc, 'sound/machines/click.ogg', 20, TRUE)

/obj/item/wargame_projector/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/structure/wargame_hologram))
		qdel(interacting_with)
		return ITEM_INTERACT_SUCCESS
	if(!check_can_place_hologram(interacting_with, user, 1))
		return NONE
	create_hologram(interacting_with, user, modifiers)
	return ITEM_INTERACT_SUCCESS

/obj/item/wargame_projector/Destroy()
	QDEL_LAZYLIST(projections)
	. = ..()

/*
Actual projector types, split between the 'categories' of things they can project
*/

/obj/item/wargame_projector/ships
	name = "单位全息投影器"
	desc = "纳米传讯海军司令部为兵棋推演开发的便捷全息投影器，用于生成“单位”标记。"
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	max_signs = 30
	holosign_color = COLOR_BLUE_LIGHT
	holosign_type = /obj/structure/wargame_hologram/ship_marker
	holosign_options = list(
		/obj/structure/wargame_hologram/unidentified,
		/obj/structure/wargame_hologram/missile_warning,
		/obj/structure/wargame_hologram/strike_craft,
		/obj/structure/wargame_hologram/strike_craft/wing,
		/obj/structure/wargame_hologram/ship_marker,
		/obj/structure/wargame_hologram/ship_marker/medium,
		/obj/structure/wargame_hologram/ship_marker/large,
		/obj/structure/wargame_hologram/ship_marker/large/alternate,
		/obj/structure/wargame_hologram/probe,
		/obj/structure/wargame_hologram/stationary_structure,
		/obj/structure/wargame_hologram/stationary_structure/platform,
	)

/obj/item/wargame_projector/ships/red
	holosign_color = COLOR_RED_LIGHT

/obj/item/wargame_projector/terrain
	name = "地形全息投影器"
	desc = "纳米传讯海军司令部为兵棋推演开发的便捷全息投影器，用于生成太空“地形”标记。"
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	max_signs = 30
	holosign_color = COLOR_GRAY
	holosign_type = /obj/structure/wargame_hologram/asteroid
	// Some things, like stations, probes, and unidentified contacts, can be in the terrain one just because I can see situations where that's desired
	holosign_options = list(
		/obj/structure/wargame_hologram/unidentified,
		/obj/structure/wargame_hologram/dust,
		/obj/structure/wargame_hologram/asteroid,
		/obj/structure/wargame_hologram/asteroid/large,
		/obj/structure/wargame_hologram/asteroid/cluster,
		/obj/structure/wargame_hologram/planet,
		/obj/structure/wargame_hologram/probe,
		/obj/structure/wargame_hologram/stationary_structure,
		/obj/structure/wargame_hologram/stationary_structure/platform,
	)
