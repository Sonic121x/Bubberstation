// Plastic panel walls, how colony of you

/turf/closed/wall/prefab_plastic
	name = "预制墙"
	desc = "保守搭建的金属框架，外覆塑料板材，里面是一层薄薄的气密层。 \
		这有点让人不安，但总比什么都没有强。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/prefab_wall.dmi'
	icon_state = "prefab-0"
	base_icon_state = "prefab"
	can_engrave = FALSE
	girder_type = null
	hardness = 70
	slicing_duration = 5 SECONDS
	sheet_type = /obj/item/stack/sheet/plastic_wall_panel
	sheet_amount = 1

GLOBAL_LIST_INIT(plastic_wall_panel_recipes, list(
	new/datum/stack_recipe("预制墙", /turf/closed/wall/prefab_plastic, time = 3 SECONDS,  crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("预制窗", /obj/structure/window/fulltile/colony_fabricator, time = 1 SECONDS,  crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION | CRAFT_IS_FULLTILE, category = CAT_WINDOWS), \
	))

/obj/item/stack/sheet/plastic_wall_panel
	name = "塑料板"
	singular_name = "塑料板"
	desc = "还有什么材料比薄薄的塑料板更适合用来搭建你未来的家呢？\
		金属？你在说什么，这种经济环境下还想着金属墙？它也可以用来建造\
		墙壁以外的结构。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles_item.dmi'
	icon_state = "sheet-plastic"
	inhand_icon_state = "sheet-plastic"
	mats_per_unit = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	has_unique_girder = TRUE
	material_type = /datum/material/plastic
	merge_type = /obj/item/stack/sheet/plastic_wall_panel
	walltype = /turf/closed/wall/prefab_plastic

/obj/item/stack/sheet/plastic_wall_panel/examine(mob/user)
	. = ..()
	. += span_notice("你可以右键点击空地板来建造预制墙。")

/obj/item/stack/sheet/plastic_wall_panel/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isopenturf(interacting_with))
		return NONE
	var/turf/open/build_on = interacting_with
	if(isgroundlessturf(build_on))
		user.balloon_alert(user, "不能放在这里！")
		return ITEM_INTERACT_BLOCKING
	if(build_on.is_blocked_turf())
		user.balloon_alert(user, "这块地砖被挡住了！")
		return ITEM_INTERACT_BLOCKING
	if(get_amount() < 1)
		user.balloon_alert(user, "材料不足！")
		return ITEM_INTERACT_BLOCKING
	if(!do_after(user, 3 SECONDS, build_on))
		return ITEM_INTERACT_BLOCKING
	if(build_on.is_blocked_turf())
		user.balloon_alert(user, "这块地砖被挡住了！")
		return ITEM_INTERACT_BLOCKING
	if(!use(1))
		user.balloon_alert(user, "材料不足！")
		return ITEM_INTERACT_BLOCKING
	build_on.place_on_top(walltype, flags = CHANGETURF_INHERIT_AIR)
	return ITEM_INTERACT_SUCCESS

/obj/item/stack/sheet/plastic_wall_panel/get_main_recipes()
	. = ..()
	. += GLOB.plastic_wall_panel_recipes

/obj/item/stack/sheet/plastic_wall_panel/ten
	amount = 10

/obj/item/stack/sheet/plastic_wall_panel/fifty
	amount = 50

// Stacks of floor tiles

/obj/item/stack/tile/catwalk_tile/colony_lathe
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles_item.dmi'
	icon_state = "prefab_catwalk"
	mats_per_unit = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2.5)
	turf_type = /turf/open/floor/catwalk_floor/colony_fabricator
	merge_type = /obj/item/stack/tile/catwalk_tile/colony_lathe
	tile_reskin_types = null

/obj/item/stack/tile/iron/colony
	name = "预制地板砖"
	singular_name = "预制地板砖"
	desc = "一叠大块地板砖，在边疆殖民地和预制建筑中十分常见。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles_item.dmi'
	icon_state = "colony_grey"
	turf_type = /turf/open/floor/iron/colony
	merge_type = /obj/item/stack/tile/iron/colony
	tile_reskin_types = list(
		/obj/item/stack/tile/iron/colony,
		/obj/item/stack/tile/iron/colony/texture,
		/obj/item/stack/tile/iron/colony/bolts,
		/obj/item/stack/tile/iron/colony/white,
		/obj/item/stack/tile/iron/colony/white/texture,
		/obj/item/stack/tile/iron/colony/white/bolts,
	)

// Grated floor tile, for seeing wires under

/turf/open/floor/catwalk_floor/colony_fabricator
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles.dmi'
	icon_state = "prefab_above"
	catwalk_type = "prefab"
	baseturfs = /turf/open/floor/plating
	floor_tile = /obj/item/stack/tile/catwalk_tile/colony_lathe

// "Normal" floor tiles

/obj/item/stack/tile/iron/colony/texture
	icon_state = "colony_grey_texture"
	turf_type = /turf/open/floor/iron/colony/texture

/obj/item/stack/tile/iron/colony/bolts
	icon_state = "colony_grey_bolts"
	turf_type = /turf/open/floor/iron/colony/bolts

/turf/open/floor/iron/colony
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles.dmi'
	icon_state = "colony_grey"
	base_icon_state = "colony_grey"
	floor_tile = /obj/item/stack/tile/iron/colony
	tiled_turf = FALSE

/turf/open/floor/iron/colony/texture
	icon_state = "colony_grey_texture"
	base_icon_state = "colony_grey_texture"
	floor_tile = /obj/item/stack/tile/iron/colony/texture

/turf/open/floor/iron/colony/bolts
	icon_state = "colony_grey_bolts"
	base_icon_state = "colony_grey_bolts"
	floor_tile = /obj/item/stack/tile/iron/colony/bolts

// White variants of the above tiles

/obj/item/stack/tile/iron/colony/white
	icon_state = "colony_white"
	turf_type = /turf/open/floor/iron/colony/white

/obj/item/stack/tile/iron/colony/white/texture
	icon_state = "colony_white_texture"
	turf_type = /turf/open/floor/iron/colony/white/texture

/obj/item/stack/tile/iron/colony/white/bolts
	icon_state = "colony_white_bolts"
	turf_type = /turf/open/floor/iron/colony/white/bolts

/turf/open/floor/iron/colony/white
	icon_state = "colony_white"
	base_icon_state = "colony_white"
	floor_tile = /obj/item/stack/tile/iron/colony/white

/turf/open/floor/iron/colony/white/texture
	icon_state = "colony_white_texture"
	base_icon_state = "colony_white_texture"
	floor_tile = /obj/item/stack/tile/iron/colony/white/texture

/turf/open/floor/iron/colony/white/bolts
	icon_state = "colony_white_bolts"
	base_icon_state = "colony_white_bolts"
	floor_tile = /obj/item/stack/tile/iron/colony/white/bolts
