// Look, I had to make its name start with A so it'd be top of the list, fight me

#define FABRICATOR_SUBCATEGORY_STRUCTURES "/自动建造结构"

// Techweb node that shouldnt show up anywhere ever specifically for the fabricator to work with

/datum/techweb_node/colony_fabricator_structures
	display_name = "殖民地制造机结构设计"
	description = "包含殖民地制造机的所有结构设计。"
	unlocked_designs = list(
		/datum/design/prefab_airlock_kit,
		/datum/design/prefab_manual_airlock_kit,
		/datum/design/prefab_shutters_kit,
		/datum/design/prefab_floor_tile,
		/datum/design/prefab_cat_floor_tile,
		/datum/design/colony_fab_plastic_wall_panel,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = INFINITY) // God save you
	node_flags = TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL

// Airlock kit

/datum/design/prefab_airlock_kit
	name = "预制气闸"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/flatpacked_machine/airlock_kit
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 10 SECONDS

// Manul Airlock kit

/datum/design/prefab_manual_airlock_kit
	name = "预制手动气闸"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/flatpacked_machine/airlock_kit_manual
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 5 SECONDS

// Shutters kit

/datum/design/prefab_shutters_kit
	name = "预制卷帘门"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/flatpacked_machine/shutter_kit
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 10 SECONDS

// Fancy floor tiles

/datum/design/prefab_floor_tile
	name = "预制地板砖"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT / 4,
	)
	build_path = /obj/item/stack/tile/iron/colony
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 0.5 SECONDS

// Fancy catwalk floor tiles

/datum/design/prefab_cat_floor_tile
	name = "预制栈桥地板"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT / 4,
	)
	build_path = /obj/item/stack/tile/catwalk_tile/colony_lathe
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 0.5 SECONDS

// Plastic wall panels, twice the wall for the same price in plastic, efficient!

/datum/design/colony_fab_plastic_wall_panel
	name = "塑料板材"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/stack/sheet/plastic_wall_panel
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 1 SECONDS

#undef FABRICATOR_SUBCATEGORY_STRUCTURES
