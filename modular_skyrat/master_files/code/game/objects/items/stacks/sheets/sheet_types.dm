// Add modular crafting recipes here, NOT IN BASE /tg/ CRAFTING LISTS

/**
 * Add a list of recipes to an existing recipe sublist.
 *
 * Arguments:
 * * stack_recipes - the existing list of stack recipes.
 * * recipe_list_title - the title for the recipe list we're adding to
 * * appent_recipes - Add these recipes to the given recipe list.
 */
/proc/add_recipes_to_sublist(list/stack_recipes, recipe_list_title, list/append_recipes)
	for(var/datum/stack_recipe_list/sublist in stack_recipes)
		if(sublist.title != recipe_list_title)
			continue

		sublist.recipes += append_recipes
		return

	CRASH("Could not find recipe sublist [recipe_list_title] to add more recipes!")

// Iron

GLOBAL_LIST_INIT(skyrat_metal_recipes, list(
	new/datum/stack_recipe("壁挂式消防安全柜", /obj/item/wallframe/firecloset, 2, time = 1.5 SECONDS, category = CAT_FURNITURE),
	new/datum/stack_recipe("壁挂式应急柜", /obj/item/wallframe/emcloset, 2, time = 1.5 SECONDS,category = CAT_FURNITURE),
	new/datum/stack_recipe("壁挂式储物柜", /obj/item/wallframe/closet, 2, time = 1.5 SECONDS, category = CAT_FURNITURE),
	new/datum/stack_recipe("泳池地砖", /obj/item/stack/tile/iron/pool, 1, 4, 20, category = CAT_TILES),
	new/datum/stack_recipe("下沉地砖", /obj/item/stack/tile/iron/lowered, 1, 4, 20, category = CAT_TILES),
	new/datum/stack_recipe("抬高地砖", /obj/item/stack/tile/iron/elevated, 1, 4, 20, category = CAT_TILES),
	new/datum/stack_recipe("摔角角柱", /obj/structure/wrestling_corner, 3, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("金属路障", /obj/structure/deployable_barricade/metal, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
	new/datum/stack_recipe("金属置物架", /obj/structure/rack/shelf, 1, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("锻造炉", /obj/structure/reagent_forge, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
	new/datum/stack_recipe("陶艺拉坯轮", /obj/structure/throwing_wheel, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
))

GLOBAL_LIST_INIT(skyrat_metal_airlock_recipes, list(
	new /datum/stack_recipe("企业气闸组件", /obj/structure/door_assembly/door_assembly_corporate, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS),
	new /datum/stack_recipe("服务气闸组件", /obj/structure/door_assembly/door_assembly_service, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS),
))

/obj/item/stack/sheet/iron/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_metal_recipes
	add_recipes_to_sublist(., "气闸组件", GLOB.skyrat_metal_airlock_recipes)

// Plasteel

GLOBAL_LIST_INIT(skyrat_plasteel_recipes, list(
	new/datum/stack_recipe("塑钢路障", /obj/structure/deployable_barricade/metal/plasteel, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
))

/obj/item/stack/sheet/plasteel/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_plasteel_recipes

// Rods

GLOBAL_LIST_INIT(skyrat_rod_recipes, list(
	new/datum/stack_recipe("毛巾箱", /obj/structure/towel_bin/empty, 2, time = 0.5 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF, category = CAT_CONTAINERS),
	new/datum/stack_recipe("护栏", /obj/structure/deployable_barricade/guardrail, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
	new/datum/stack_recipe("摔角围绳", /obj/structure/railing/wrestling, 3, time = 1.8 SECONDS, crafting_flags = CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
	new/datum/stack_recipe("拐杖", /obj/item/cane/crutch, 3, time = 1 SECONDS, category = CAT_TOOLS, crafting_flags = CRAFT_SKIP_MATERIALS_PARITY),
))

/obj/item/stack/rods/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_rod_recipes

// Wood

GLOBAL_LIST_INIT(skyrat_wood_recipes, list(
	new/datum/stack_recipe("锻造淬火槽", /obj/structure/reagent_dispensers/reagent_smithing_basin, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
	new/datum/stack_recipe("锻造工作台", /obj/structure/reagent_crafting_bench, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
	new/datum/stack_recipe("木制半身路障", /obj/structure/deployable_barricade/wooden, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
	new/datum/stack_recipe("桑拿炉", /obj/structure/sauna_oven, 30, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT),
	new/datum/stack_recipe("大型木臼", /obj/structure/large_mortar, 10, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
	new/datum/stack_recipe("木质砧板", /obj/item/cutting_board, 5, time = 2 SECONDS, category = CAT_TOOLS),
	new/datum/stack_recipe("木质置物架", /obj/structure/rack/wooden, 2, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("黄油搅拌器", /obj/structure/butterchurn, 8, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("种子架", /obj/machinery/smartfridge/wooden/seed_shelf, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("农产品箱", /obj/machinery/smartfridge/wooden/produce_bin, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("农产品展示架", /obj/machinery/smartfridge/wooden/produce_display, 10, time = 2 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("口粮架", /obj/machinery/smartfridge/wooden/ration_shelf, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("储物桶", /obj/structure/closet/crate/wooden/storage_barrel, 4, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("蚯蚓桶", /obj/structure/wormfarm, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
	new/datum/stack_recipe("食脏兽食槽", /obj/structure/ore_container/food_trough/gutlunch_trough, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("坚固木栅栏", /obj/structure/railing/wooden_fencing, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("坚固木栅栏门", /obj/structure/railing/wooden_fencing/gate, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("大型木门", /obj/structure/mineral_door/wood/large_gate, 10, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
))


/obj/item/stack/sheet/mineral/wood/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_wood_recipes

// Cloth

GLOBAL_LIST_INIT(skyrat_cloth_recipes, list(
	new/datum/stack_recipe("精致枕头", /obj/item/fancy_pillow, 3, category = CAT_ENTERTAINMENT),
	new/datum/stack_recipe("毛巾", /obj/item/towel, 2, category = CAT_CLOTHING),
	new/datum/stack_recipe("包裹式眼罩", /obj/item/clothing/glasses/eyepatch/wrap, 2, category = CAT_CLOTHING),
	new/datum/stack_recipe("眼罩", /obj/item/clothing/glasses/eyepatch, 2, category = CAT_CLOTHING),
	new/datum/stack_recipe("异种考古袋", /obj/item/storage/bag/xenoarch,  4, crafting_flags = CRAFT_SKIP_MATERIALS_PARITY, category = CAT_CONTAINERS),
	new/datum/stack_recipe("马鞍袋", /obj/item/storage/backpack/saddlebags, 5, category = CAT_CONTAINERS),
))

/obj/item/stack/sheet/cloth/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_cloth_recipes

// Leather

GLOBAL_LIST_INIT(skyrat_leather_recipes, list(
))

GLOBAL_LIST_INIT(skyrat_leather_belt_recipes, list(
	new/datum/stack_recipe("异种考古腰带", /obj/item/storage/belt/utility/xenoarch, 4, crafting_flags = CRAFT_SKIP_MATERIALS_PARITY, category = CAT_CONTAINERS),
	new/datum/stack_recipe("医疗弹药带", /obj/item/storage/belt/medbandolier, 5, category = CAT_CONTAINERS),
	new/datum/stack_recipe("装备背带", /obj/item/clothing/under/misc/skyrat/gear_harness, 6, category = CAT_CLOTHING),
	new/datum/stack_recipe("弹药袋", /obj/item/storage/pouch/ammo, 4, category = CAT_CONTAINERS),
	new/datum/stack_recipe_list("马鞍", list(
		new/datum/stack_recipe("骑乘马鞍（普通）", /obj/item/riding_saddle/leather, 5, category = CAT_CLOTHING),
		new/datum/stack_recipe("骑乘马鞍（和平守护者）", /obj/item/riding_saddle/leather/peacekeeper, 5, category = CAT_CLOTHING),
	)),
))

/obj/item/stack/sheet/leather/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_leather_recipes
	add_recipes_to_sublist(., "腰带", GLOB.skyrat_leather_belt_recipes)

// Titanium

GLOBAL_LIST_INIT(skyrat_titanium_recipes, list(
	new/datum/stack_recipe("铁砧", /obj/structure/reagent_anvil, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
))

/obj/item/stack/sheet/mineral/titanium/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_titanium_recipes

// Snow

GLOBAL_LIST_INIT(skyrat_snow_recipes, list(
	new/datum/stack_recipe("雪制路障", /obj/structure/deployable_barricade/snow, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
))

/obj/item/stack/sheet/mineral/snow/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_snow_recipes

// Sand

GLOBAL_LIST_INIT(skyrat_sand_recipes, list(
	new/datum/stack_recipe("蚂蚁农场", /obj/structure/antfarm, 20, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
))

/obj/item/stack/ore/glass/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_sand_recipes
