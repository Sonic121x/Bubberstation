// Wooden shelves that force items placed on them to be visually placed them

/obj/structure/rack/wooden
	name = "木架"
	icon_state = "shelf_wood"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	resistance_flags = FLAMMABLE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/rack/wooden/mouse_drop_receive(atom/movable/object, mob/living/user, params)
	. = ..()
	var/list/modifiers = params2list(params)
	if(!LAZYACCESS(modifiers, ICON_X) || !LAZYACCESS(modifiers, ICON_Y))
		return

	object.pixel_x = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(world.icon_size / 3), world.icon_size / 3)
	object.pixel_y = text2num(LAZYACCESS(modifiers, ICON_Y)) > 16 ? 10 : -4

/obj/structure/rack/wooden/wrench_act_secondary(mob/living/user, obj/item/tool)
	return NONE

/obj/structure/rack/wooden/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("正在拆卸……")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 100))
		return
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/structure/rack/wooden/atom_deconstruct(disassembled = TRUE)
	set_density(FALSE)
	var/obj/item/stack/sheet/mineral/wood/planks = new(drop_location(), 2)
	transfer_fingerprints_to(planks)

// Barrel but it works like a crate

/obj/structure/closet/crate/wooden/storage_barrel
	name = "储物桶"
	desc = "这个桶装不了液体，但能装下各种物品！"
	icon_state = "barrel"
	base_icon_state = "barrel"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	resistance_flags = FLAMMABLE
	material_drop = /obj/item/stack/sheet/mineral/wood
	material_drop_amount = 4
	cutting_tool = /obj/item/crowbar
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 4)

//Wooden-storage "fridges"

/obj/machinery/smartfridge/wooden
	name = "调试用木制智能储物架"
	desc = "你不应该看到这个！"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	icon_state = "producebin"
	base_icon_state = "producebin"
	contents_overlay_icon = "produce"
	resistance_flags = FLAMMABLE
	base_build_path = /obj/machinery/smartfridge/wooden
	use_power = NO_POWER_USE
	light_power = 0
	idle_power_usage = 0
	circuit = null
	has_emissive = FALSE
	can_atmos_pass = ATMOS_PASS_YES
	visible_contents = TRUE

/obj/machinery/smartfridge/wooden/Initialize(mapload)
	. = ..()
	if(type == /obj/machinery/smartfridge/wooden) // don't even let these prototypes exist
		return INITIALIZE_HINT_QDEL

// previously NO_DECONSTRUCTION
/obj/machinery/smartfridge/wooden/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/smartfridge/wooden/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("正在拆卸……")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/smartfridge/wooden/structure_examine()
	. = span_info("整个架子都可以[EXAMINE_HINT("撬开")]拆卸。")

/obj/machinery/smartfridge/wooden/produce_bin
	name = "农产品储物箱"
	icon_state = "producebin"
	base_icon_state = "producebin"
	contents_overlay_icon = "produce"
	desc = "一个木制储物箱，用于存放农产品，并尽量防止害虫侵扰。"
	base_build_path = /obj/machinery/smartfridge/wooden/produce_bin
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)

/obj/machinery/smartfridge/wooden/produce_bin/accept_check(obj/item/weapon)
	if(weapon.w_class >= WEIGHT_CLASS_BULKY)
		return FALSE
	if(IS_EDIBLE(weapon))
		return TRUE
	if(istype(weapon, /obj/item/food/grown) || istype(weapon, /obj/item/grown) || istype(weapon, /obj/item/graft))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/wooden/seed_shelf
	name = "种子架"
	desc = "一个用于存放种子的木架，可防止种子提前发芽。"
	icon_state = "seedshelf"
	base_icon_state = "seedshelf"
	contents_overlay_icon = "seed"
	base_build_path = /obj/machinery/smartfridge/wooden/seed_shelf
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)

/obj/machinery/smartfridge/wooden/seed_shelf/accept_check(obj/item/weapon)
	if(istype(weapon, /obj/item/seeds))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/wooden/ration_shelf
	name = "口粮架"
	desc = "一个储存食物的木架……最好是经过保鲜处理的食物。"
	icon_state = "seedshelf"
	base_icon_state = "seedshelf"
	contents_overlay_icon = "ration"
	base_build_path = /obj/machinery/smartfridge/wooden/ration_shelf
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)

/obj/machinery/smartfridge/wooden/ration_shelf/accept_check(obj/item/weapon)
	if(weapon.w_class >= WEIGHT_CLASS_BULKY)
		return FALSE
	if(IS_EDIBLE(weapon))
		return TRUE
	if(istype(weapon, /obj/item/reagent_containers/cup/bowl) && weapon.reagents?.total_volume > 0)
		return TRUE
	return FALSE

/obj/machinery/smartfridge/wooden/produce_display
	name = "农产品展示台"
	desc = "一张带遮棚的木桌，用于展示农产品。"
	icon_state = "producedisplay"
	base_icon_state = "producedisplay"
	contents_overlay_icon = "nonfood"
	base_build_path = /obj/machinery/smartfridge/wooden/produce_display
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)

/obj/machinery/smartfridge/wooden/produce_display/accept_check(obj/item/weapon)
	if(istype(weapon, /obj/item/grown) || istype(weapon, /obj/item/bouquet) || istype(weapon, /obj/item/clothing/head/costume/garland))
		return TRUE
	if(istype(weapon, /obj/item/stack/sheet/cloth)  || istype(weapon, /obj/item/stack/sheet/durathread)  || istype(weapon, /obj/item/stack/sheet/leather))
		return TRUE
	if(istype(weapon, /obj/item/stack/sheet/mineral/wood) || istype(weapon, /obj/item/stack/sheet/mineral/bamboo) || istype(weapon, /obj/item/stack/rods))
		return TRUE
