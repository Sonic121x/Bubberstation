/obj/item/stack/sheet/mineral/stone
	name = "石材"
	desc = "石砖。"
	singular_name = "石块"
	icon = 'modular_skyrat/modules/stone/icons/ore.dmi'
	icon_state = "sheet-stone"
	inhand_icon_state = "sheet-metal"
	mats_per_unit = list(/datum/material/stone=SHEET_MATERIAL_AMOUNT)
	force = 10
	throwforce = 15
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/mineral/stone
	material_type = /datum/material/stone
	matter_amount = 0
	source = null
	walltype = /turf/closed/wall/mineral/stone
	stairs_type = /obj/structure/stairs/stone

GLOBAL_LIST_INIT(stone_recipes, list ( \
	new/datum/stack_recipe("石砖墙", /turf/closed/wall/mineral/stone, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_TRANSFERS_REAGENT_COMPONENTS, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("石砖地砖", /obj/item/stack/tile/mineral/stone, 1, 4, 20, category = CAT_TILES),
	new/datum/stack_recipe("石磨", /obj/structure/millstone, 6, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("石制大锅", /obj/machinery/cauldron, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("石灶", /obj/machinery/primitive_stove, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("石烤炉", /obj/machinery/oven/stone, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("石煎台", /obj/machinery/griddle/stone, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	))

/obj/item/stack/sheet/mineral/stone/get_main_recipes()
	. = ..()
	. += GLOB.stone_recipes

/datum/material/stone
	name = "stone"
	desc = "这是石头。"
	mat_flags = MATERIAL_CLASS_RIGID | MATERIAL_BASIC_RECIPES
	sheet_type = /obj/item/stack/sheet/mineral/stone
	color = "#59595a"
	greyscale_color = "#59595a"
	value_per_unit = 0.0025
	mat_properties = list(
		MATERIAL_BEAUTY = 0.3,
	)
	turf_sound_override = FOOTSTEP_PLATING

/obj/item/stack/stone
	name = "粗石"
	desc = "未经切割的大块石头，强度足以安全地用于建造……前提是你能将它们切成可用的形状。"
	icon = 'modular_skyrat/modules/stone/icons/ore.dmi'
	icon_state = "stone_ore"
	singular_name = "粗糙巨石"
	mats_per_unit = list(/datum/material/stone = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/stone
	force = 10
	throwforce = 15

/obj/item/stack/stone/examine()
	. = ..()
	. += span_notice("用<b>凿子</b>，甚至随便一把<b>镐</b>，就能把它切成<b>石块</b>。")

/obj/item/stack/stone/attackby(obj/item/attacking_item, mob/user, params)
	if((attacking_item.tool_behaviour != TOOL_MINING) && !(istype(attacking_item, /obj/item/chisel)))
		return ..()
	playsound(src, 'sound/effects/pickaxe/picaxe1.ogg', 50, TRUE)
	balloon_alert_to_viewers("正在切割……")
	if(!do_after(user, 5 SECONDS, target = src))
		balloon_alert_to_viewers("停止切割")
		return FALSE
	new /obj/item/stack/sheet/mineral/stone(get_turf(src), amount)
	qdel(src)

/obj/item/stack/tile/mineral/stone
	name = "石地砖"
	singular_name = "石制地砖"
	desc = "用石砖制成的地砖，营造堡垒般的外观。"
	icon_state = "tile_herringbone"
	inhand_icon_state = "tile"
	turf_type = /turf/open/floor/stone
	mineralType = "stone"
	mats_per_unit = list(/datum/material/stone = HALF_SHEET_MATERIAL_AMOUNT / 2)
	merge_type = /obj/item/stack/tile/mineral/stone

/turf/open/floor/stone
	desc = "按地砖样式铺排的石块。真奇怪，竟然看起来像真的石头——因为它本来就是！" //A play on the original description for stone tiles
	slowdown = -0.3

/turf/closed/wall/mineral/stone
	name = "石墙"
	desc = "用坚实石砖砌成的墙。"
	icon = 'modular_skyrat/modules/stone/icons/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	sheet_type = /obj/item/stack/sheet/mineral/stone
	explosive_resistance = 2 // Rock and stone to the bone, or at least a bit longer than walls made of metal sheets!
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS
	custom_materials = list(
		/datum/material/stone = SHEET_MATERIAL_AMOUNT  * 2,
	)

/turf/closed/wall/mineral/stone/try_decon(obj/item/item_used, mob/user) // Lets you break down stone walls with stone breaking tools
	if(item_used.tool_behaviour != TOOL_MINING)
		return ..()

	if(!item_used.tool_start_check(user, amount = 0))
		return FALSE

	balloon_alert_to_viewers("正在拆除……")

	if(!item_used.use_tool(src, user, 5 SECONDS))
		return FALSE
	dismantle_wall()
	return TRUE

/turf/closed/indestructible/stone
	name = "石墙"
	desc = "用异常坚固的石砖砌成的墙。"
	icon = 'modular_skyrat/modules/stone/icons/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS
	custom_materials = list(
		/datum/material/stone = SHEET_MATERIAL_AMOUNT  * 2,
	)

/obj/structure/falsewall/stone
	name = "石墙"
	desc = "用坚实石砖砌成的墙。"
	icon = 'modular_skyrat/modules/stone/icons/wall.dmi'
	icon_state = "wall-open"
	base_icon_state = "wall"
	fake_icon = 'modular_skyrat/modules/stone/icons/wall.dmi'
	mineral = /obj/item/stack/sheet/mineral/stone
	walltype = /turf/closed/wall/mineral/stone
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS

/turf/closed/mineral/gets_drilled(mob/user, give_exp = FALSE)
	if(prob(5))
		new /obj/item/stack/stone(src)

	return ..()
