/*
Mineral Sheets
	Contains:
		- Sandstone
		- Sandbags
		- Diamond
		- Snow
		- Uranium
		- Plasma
		- Gold
		- Silver
		- Clown
		- Titanium
		- Plastitanium
	Others:
		- Adamantine
		- Mythril
		- Alien Alloy
		- Coal
*/

/*
 * Sandstone
 */

GLOBAL_LIST_INIT(sandstone_recipes, list ( \
	new/datum/stack_recipe("砂岩门", /obj/structure/mineral_door/sandstone, 10, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("砂岩平台", /obj/structure/platform/sandstone, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("分解为沙子", /obj/item/stack/ore/glass, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_NO_MATERIALS, category = CAT_MISC), \
))

/obj/item/stack/sheet/mineral
	abstract_type = /obj/item/stack/sheet/mineral

/obj/item/stack/sheet/mineral/sandstone
	name = "砂岩砖"
	desc = "这似乎是沙与石的结合体。"
	singular_name = "砂岩砖"
	icon_state = "sheet-sandstone"
	worn_icon_state = null
	inhand_icon_state = null
	throw_speed = 3
	throw_range = 5
	mats_per_unit = list(/datum/material/sandstone=SHEET_MATERIAL_AMOUNT)
	construction_path_type = "sandstone"
	merge_type = /obj/item/stack/sheet/mineral/sandstone
	walltype = /turf/closed/wall/mineral/sandstone
	material_type = /datum/material/sandstone
	drop_sound = SFX_STONE_DROP
	pickup_sound = SFX_STONE_PICKUP

/obj/item/stack/sheet/mineral/sandstone/get_main_recipes()
	. = ..()
	. += GLOB.sandstone_recipes

/obj/item/stack/sheet/mineral/sandstone/thirty
	amount = 30

/*
 * Sandbags
 */

/obj/item/stack/sheet/mineral/sandbags
	name = "沙袋"
	icon_state = "sandbags"
	singular_name = "沙袋"
	layer = LOW_ITEM_LAYER
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/mineral/sandbags

GLOBAL_LIST_INIT(sandbag_recipes, list ( \
	new/datum/stack_recipe("沙袋", /obj/structure/barricade/sandbags, 1, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	))

/obj/item/stack/sheet/mineral/sandbags/get_main_recipes()
	. = ..()
	. += GLOB.sandbag_recipes

/obj/item/stack/sheet/mineral/sandbags/fifty
	amount = 50

/obj/item/emptysandbag
	name = "空沙袋"
	desc = "用来装沙子的袋子。"
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "sandbag"
	w_class = WEIGHT_CLASS_TINY

/obj/item/emptysandbag/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stack/ore/glass))
		return NONE
	var/obj/item/stack/ore/glass/sand = tool
	to_chat(user, span_notice("你装满了沙袋。"))
	var/obj/item/stack/sheet/mineral/sandbags/filled_bag = new (drop_location())
	qdel(src)
	if(Adjacent(user) && !issilicon(user))
		user.put_in_hands(filled_bag)
	sand.use(1)
	return ITEM_INTERACT_SUCCESS

/*
 * Diamond
 */
/obj/item/stack/sheet/mineral/diamond
	name = "钻石"
	icon_state = "sheet-diamond"
	worn_icon_state = "purified_soulstone"
	inhand_icon_state = "sheet-diamond"
	singular_name = "钻石"
	construction_path_type = "diamond"
	mats_per_unit = list(/datum/material/diamond=SHEET_MATERIAL_AMOUNT)
	gulag_value = 100
	merge_type = /obj/item/stack/sheet/mineral/diamond
	material_type = /datum/material/diamond
	walltype = /turf/closed/wall/mineral/diamond

GLOBAL_LIST_INIT(diamond_recipes, list ( \
	new/datum/stack_recipe("钻石门", /obj/structure/mineral_door/transparent/diamond, 10, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("钻石地砖", /obj/item/stack/tile/mineral/diamond, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES),  \
	))

/obj/item/stack/sheet/mineral/diamond/get_main_recipes()
	. = ..()
	. += GLOB.diamond_recipes

/obj/item/stack/sheet/mineral/diamond/five
	amount = 5

/obj/item/stack/sheet/mineral/diamond/fifty
	amount = 50

/*
 * Uranium
 */
/obj/item/stack/sheet/mineral/uranium
	name = "铀"
	icon_state = "sheet-uranium"
	worn_icon_state = "sheet-uranium"
	inhand_icon_state = "sheet-uranium"
	singular_name = "铀板"
	construction_path_type = "uranium"
	mats_per_unit = list(/datum/material/uranium=SHEET_MATERIAL_AMOUNT)
	gulag_value = 50
	merge_type = /obj/item/stack/sheet/mineral/uranium
	material_type = /datum/material/uranium
	walltype = /turf/closed/wall/mineral/uranium

GLOBAL_LIST_INIT(uranium_recipes, list ( \
	new/datum/stack_recipe("铀门", /obj/structure/mineral_door/uranium, 10, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("贫铀平台", /obj/structure/platform/uranium, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("铀地砖", /obj/item/stack/tile/mineral/uranium, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	))

/obj/item/stack/sheet/mineral/uranium/get_main_recipes()
	. = ..()
	. += GLOB.uranium_recipes

/obj/item/stack/sheet/mineral/uranium/five
	amount = 5

/obj/item/stack/sheet/mineral/uranium/half
	amount = 25

/obj/item/stack/sheet/mineral/uranium/fifty
	amount = 50

/*
 * Plasma
 */
/obj/item/stack/sheet/mineral/plasma
	name = "固态等离子体"
	icon_state = "sheet-plasma"
	worn_icon_state = "sheet-plasma"
	inhand_icon_state = "sheet-plasma"
	singular_name = "等离子体板"
	construction_path_type = "plasma"
	resistance_flags = FLAMMABLE
	max_integrity = 100
	mats_per_unit = list(/datum/material/plasma=SHEET_MATERIAL_AMOUNT)
	gulag_value = 5
	merge_type = /obj/item/stack/sheet/mineral/plasma
	material_type = /datum/material/plasma
	walltype = /turf/closed/wall/mineral/plasma

/obj/item/stack/sheet/mineral/plasma/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始舔[src]！看起来是想自杀！"))
	return TOXLOSS//dont you kids know that stuff is toxic?

GLOBAL_LIST_INIT(plasma_recipes, list ( \
	new/datum/stack_recipe("等离子体门", /obj/structure/mineral_door/transparent/plasma, 10, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("等离子体地砖", /obj/item/stack/tile/mineral/plasma, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	))

/obj/item/stack/sheet/mineral/plasma/get_main_recipes()
	. = ..()
	. += GLOB.plasma_recipes

/obj/item/stack/sheet/mineral/plasma/five
	amount = 5

/obj/item/stack/sheet/mineral/plasma/thirty
	amount = 30

/obj/item/stack/sheet/mineral/plasma/fifty
	amount = 50

/*
 * Gold
 */
/obj/item/stack/sheet/mineral/gold
	name = "黄金"
	icon_state = "sheet-gold"
	worn_icon_state = "sheet-gold"
	inhand_icon_state = "sheet-gold"
	singular_name = "金条"
	construction_path_type = "gold"
	mats_per_unit = list(/datum/material/gold=SHEET_MATERIAL_AMOUNT)
	gulag_value = 20
	merge_type = /obj/item/stack/sheet/mineral/gold
	material_type = /datum/material/gold
	walltype = /turf/closed/wall/mineral/gold

GLOBAL_LIST_INIT(gold_recipes, list ( \
	new/datum/stack_recipe("黄金门", /obj/structure/mineral_door/gold, 10, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("黄金平台", /obj/structure/platform/gold, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("黄金地砖", /obj/item/stack/tile/mineral/gold, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	new/datum/stack_recipe("空白牌匾", /obj/item/plaque, 1, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("简易王冠", /obj/item/clothing/head/costume/crown, 5, crafting_flags = NONE, category = CAT_CLOTHING), \
	))

/obj/item/stack/sheet/mineral/gold/get_main_recipes()
	. = ..()
	. += GLOB.gold_recipes

/obj/item/stack/sheet/mineral/gold/fifty
	amount = 50

/*
 * Silver
 */
/obj/item/stack/sheet/mineral/silver
	name = "白银"
	icon_state = "sheet-silver"
	worn_icon_state = "sheet-silver"
	inhand_icon_state = "sheet-silver"
	singular_name = "银条"
	construction_path_type = "silver"
	mats_per_unit = list(/datum/material/silver=SHEET_MATERIAL_AMOUNT)
	gulag_value = 10
	merge_type = /obj/item/stack/sheet/mineral/silver
	material_type = /datum/material/silver
	table_type = /obj/structure/table/optable
	walltype = /turf/closed/wall/mineral/silver

GLOBAL_LIST_INIT(silver_recipes, list ( \
	new/datum/stack_recipe("白银门", /obj/structure/mineral_door/silver, 10, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("白银平台", /obj/structure/platform/silver, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("白银地砖", /obj/item/stack/tile/mineral/silver, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	))

/obj/item/stack/sheet/mineral/silver/get_main_recipes()
	. = ..()
	. += GLOB.silver_recipes

/obj/item/stack/sheet/mineral/silver/fifty
	amount = 50

/*
 * Clown
 */
/obj/item/stack/sheet/mineral/bananium
	name = "香蕉矿"
	icon_state = "sheet-bananium"
	lefthand_file = 'icons/mob/inhands/items/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/food_righthand.dmi'
	inhand_icon_state = "banana_peel"
	singular_name = "香蕉矿板"
	construction_path_type = "bananium"
	mats_per_unit = list(/datum/material/bananium=SHEET_MATERIAL_AMOUNT)
	gulag_value = -5
	merge_type = /obj/item/stack/sheet/mineral/bananium
	material_type = /datum/material/bananium
	walltype = /turf/closed/wall/mineral/bananium

GLOBAL_LIST_INIT(bananium_recipes, list ( \
	new/datum/stack_recipe("香蕉矿地砖", /obj/item/stack/tile/mineral/bananium, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	))

/obj/item/stack/sheet/mineral/bananium/get_main_recipes()
	. = ..()
	. += GLOB.bananium_recipes

/obj/item/stack/sheet/mineral/bananium/five
	amount = 5

/*
 * Titanium
 */
/obj/item/stack/sheet/mineral/titanium
	name = "钛"
	icon_state = "sheet-titanium"
	worn_icon_state = "sheet-titanium"
	inhand_icon_state = "sheet-titanium"
	singular_name = "钛板"
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 1
	throw_range = 3
	construction_path_type = "titanium"
	mats_per_unit = list(/datum/material/titanium=SHEET_MATERIAL_AMOUNT)
	gulag_value = 10
	merge_type = /obj/item/stack/sheet/mineral/titanium
	material_type = /datum/material/titanium
	walltype = /turf/closed/wall/mineral/titanium

GLOBAL_LIST_INIT(titanium_recipes, list ( \
	new /datum/stack_recipe("钛地砖", /obj/item/stack/tile/mineral/titanium, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	new/datum/stack_recipe("钛平台", /obj/structure/platform/titanium, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	new /datum/stack_recipe("穿梭机座椅", /obj/structure/chair/comfy/shuttle, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new /datum/stack_recipe("有轨电车门组件", /obj/structure/door_assembly/multi_tile/door_assembly_tram, 8, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	))

/obj/item/stack/sheet/mineral/titanium/get_main_recipes()
	. = ..()
	. += GLOB.titanium_recipes

/obj/item/stack/sheet/mineral/titanium/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	add_fingerprint(user)
	if(!istype(tool, /obj/item/stack/rods))
		return ..()
	var/obj/item/stack/rods/old_rods = tool
	if(old_rods.merge_type != /obj/item/stack/rods)
		to_chat(user, span_warning("你无法用这种棒材制作穿梭机框架棒材！"))
		return ITEM_INTERACT_BLOCKING

	if (old_rods.get_amount() < 5 && get_amount() < 1)
		to_chat(user, span_warning("制作穿梭机框架棒材需要五根棒材和一张钛板！"))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/stack/rods/shuttle/five/new_rods = new (get_turf(user))
	if(!QDELETED(new_rods))
		new_rods.add_fingerprint(user)
	var/replace = user.get_inactive_held_item() == src
	old_rods.use(5)
	use(1)
	if(QDELETED(src) && replace && !QDELETED(new_rods))
		user.put_in_hands(new_rods)
	return ITEM_INTERACT_SUCCESS

/obj/item/stack/sheet/mineral/titanium/fifty
	amount = 50

/*
 * Plastitanium
 */
/obj/item/stack/sheet/mineral/plastitanium
	name = "塑钛"
	icon_state = "sheet-plastitanium"
	worn_icon_state = "sheet-plastitanium"
	inhand_icon_state = "sheet-plastitanium"
	singular_name = "塑钛板"
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 1
	throw_range = 3
	construction_path_type = "plastitanium"
	mats_per_unit = list(/datum/material/alloy/plastitanium=SHEET_MATERIAL_AMOUNT)
	gulag_value = 20
	material_type = /datum/material/alloy/plastitanium
	merge_type = /obj/item/stack/sheet/mineral/plastitanium
	material_flags = NONE
	walltype = /turf/closed/wall/mineral/plastitanium

GLOBAL_LIST_INIT(plastitanium_recipes, list ( \
	new/datum/stack_recipe("塑钛地砖", /obj/item/stack/tile/mineral/plastitanium, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	new/datum/stack_recipe("塑钛墙体填充", /obj/item/stack/wall_filling/plastitanium/basic, 2, 1, 10, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("塑钛平台", /obj/structure/platform/plastitanium, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	))

/obj/item/stack/sheet/mineral/plastitanium/get_main_recipes()
	. = ..()
	. += GLOB.plastitanium_recipes


/*
 * Snow
 */

/obj/item/stack/sheet/mineral/snow
	name = "雪"
	icon_state = "sheet-snow"
	worn_icon_state = null
	inhand_icon_state = null
	mats_per_unit = list(/datum/material/snow = SHEET_MATERIAL_AMOUNT)
	singular_name = "雪块"
	force = 1
	throwforce = 2
	merge_type = /obj/item/stack/sheet/mineral/snow
	walltype = /turf/closed/wall/mineral/snow
	material_type = /datum/material/snow
	pickup_sound = 'sound/items/handling/materials/snow_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/snow_drop.ogg'

GLOBAL_LIST_INIT(snow_recipes, list ( \
	new/datum/stack_recipe("雪墙", /turf/closed/wall/mineral/snow, 5, time = 4 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("雪人", /obj/structure/statue/snow/snowman, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("雪球", /obj/item/toy/snowball, 1, crafting_flags = NONE, category = CAT_WEAPON_RANGED), \
	new/datum/stack_recipe("雪地砖", /obj/item/stack/tile/mineral/snow, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
))

/obj/item/stack/sheet/mineral/snow/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()
	AddComponent(/datum/component/storm_hating)

/obj/item/stack/sheet/mineral/snow/get_main_recipes()
	. = ..()
	. += GLOB.snow_recipes

/****************************** Others ****************************/

/*
 * Adamantine
*/


GLOBAL_LIST_INIT(adamantine_recipes, list(
	new /datum/stack_recipe("未完成的仆从魔像外壳", /obj/item/golem_shell/servant, req_amount=3, res_amount=1, category = CAT_ROBOT),
	))

/obj/item/stack/sheet/mineral/adamantine
	name = "精金"
	icon_state = "sheet-adamantine"
	worn_icon_state = "sheet-adamantine"
	inhand_icon_state = "sheet-adamantine"
	singular_name = "精金板"
	mats_per_unit = list(/datum/material/adamantine=SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/mineral/adamantine

/obj/item/stack/sheet/mineral/adamantine/get_main_recipes()
	. = ..()
	. += GLOB.adamantine_recipes

/*
 * Runite
 */

/obj/item/stack/sheet/mineral/runite
	name = "符文矿"
	desc = "在遥远之地发现的稀有材料。"
	singular_name = "符文矿锭"
	icon_state = "sheet-runite"
	worn_icon_state = "sheet-runite"
	inhand_icon_state = "sheet-runite"
	mats_per_unit = list(/datum/material/runite=SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/mineral/runite
	material_type = /datum/material/runite


/*
 * Mythril
 */
/obj/item/stack/sheet/mineral/mythril
	name = "秘银"
	icon_state = "sheet-mythril"
	worn_icon_state = "sheet-mythril"
	inhand_icon_state = "sheet-mythril"
	singular_name = "秘银板"
	novariants = TRUE
	mats_per_unit = list(/datum/material/mythril=SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/mineral/mythril

/*
 * Alien Alloy
 */
/obj/item/stack/sheet/mineral/abductor
	name = "异形合金"
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "sheet-abductor"
	worn_icon_state = "sheet-abductor"
	inhand_icon_state = "sheet-abductor"
	singular_name = "异形合金板"
	construction_path_type = "abductor"
	mats_per_unit = list(/datum/material/alloy/alien=SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/mineral/abductor
	material_type = /datum/material/alloy/alien
	walltype = /turf/closed/wall/mineral/abductor

GLOBAL_LIST_INIT(abductor_recipes, list ( \
	new/datum/stack_recipe("异形床", /obj/structure/bed/abductor, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("异形储物柜", /obj/structure/closet/abductor, 2, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("奇异储物柜", /obj/structure/closet/acloset, 2, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("异形桌架", /obj/structure/table_frame/abductor, 1, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("异形气闸组件", /obj/structure/door_assembly/door_assembly_abductor, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	null, \
	new/datum/stack_recipe("异形地砖", /obj/item/stack/tile/mineral/abductor, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	))

/obj/item/stack/sheet/mineral/abductor/get_main_recipes()
	. = ..()
	. += GLOB.abductor_recipes

/*
 * Coal
 */

/obj/item/stack/sheet/mineral/coal
	name = "煤炭"
	desc = "有人上了淘气名单。"
	icon = 'icons/obj/ore.dmi'
	icon_state = "slag"
	singular_name = "煤块"
	merge_type = /obj/item/stack/sheet/mineral/coal
	novariants = TRUE

/obj/item/stack/sheet/mineral/coal/grind_results()
	return list(/datum/reagent/carbon = 20)

/obj/item/stack/sheet/mineral/coal/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(tool.get_temperature() < FIRE_MINIMUM_TEMPERATURE_TO_EXIST) //If the temperature of the object is hot enough to start a fire, then ignite
		return ..()
	var/turf/jumpturf = get_turf(src)
	message_admins("煤炭被 [ADMIN_LOOKUPFLW(user)] 在 [ADMIN_VERBOSEJMP(jumpturf)] 点燃")
	user.log_message("ignited coal", LOG_GAME)
	fire_act(tool.get_temperature())
	return ITEM_INTERACT_SUCCESS


/obj/item/stack/sheet/mineral/coal/fire_act(exposed_temperature, exposed_volume)
	atmos_spawn_air("[GAS_CO2]=[amount*10];[TURF_TEMPERATURE(exposed_temperature)]")
	qdel(src)

/obj/item/stack/sheet/mineral/coal/five
	amount = 5

/obj/item/stack/sheet/mineral/coal/ten
	amount = 10

//Metal Hydrogen
GLOBAL_LIST_INIT(metalhydrogen_recipes, list(
	new /datum/stack_recipe("未完成的仆从魔像外壳", /obj/item/golem_shell/servant, req_amount=20, res_amount=1, crafting_flags = NONE, category = CAT_ROBOT),
	//new /datum/stack_recipe("ancient armor", /obj/item/clothing/suit/armor/elder_atmosian, req_amount = 5, res_amount = 1, crafting_flags = NONE, category = CAT_CLOTHING), BUBBER REMOVE
	//new /datum/stack_recipe("ancient helmet", /obj/item/clothing/head/helmet/elder_atmosian, req_amount = 3, res_amount = 1, crafting_flags = NONE, category = CAT_CLOTHING), BUBBER REMOVE
	new /datum/stack_recipe("金属氢斧", /obj/item/fireaxe/metal_h2_axe, req_amount = 15, res_amount = 1, crafting_flags = NONE, category = CAT_WEAPON_MELEE),
	new /datum/stack_recipe("金属氢弩箭", /obj/item/ammo_casing/rebar/hydrogen, req_amount = 1, res_amount = 1, crafting_flags = NONE, category = CAT_WEAPON_AMMO),
	))

/obj/item/stack/sheet/mineral/metal_hydrogen
	name = "金属氢"
	icon_state = "sheet-metalhydrogen"
	worn_icon_state = "sheet-metalhydrogen"
	worn_icon_state = "sheet-metalhydrogen"
	inhand_icon_state = "sheet-metalhydrogen"
	singular_name = "金属氢板"
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF | LAVA_PROOF | ACID_PROOF | BOMB_PROOF
	gulag_value = 100
	mats_per_unit = list(/datum/material/metalhydrogen = SHEET_MATERIAL_AMOUNT)
	material_type = /datum/material/metalhydrogen
	merge_type = /obj/item/stack/sheet/mineral/metal_hydrogen
	armor_type = /datum/armor/metal_hydrogen_sheet

/obj/item/stack/sheet/mineral/metal_hydrogen/get_main_recipes()
	. = ..()
	. += GLOB.metalhydrogen_recipes

/datum/armor/metal_hydrogen_sheet
	melee = 100
	bullet = 100
	laser = 100
	energy = 100
	bomb = 100
	fire = 100
	acid = 100
	bio = 100

GLOBAL_LIST_INIT(zaukerite_recipes, list(
	new /datum/stack_recipe("灼蚀晶体碎片", /obj/item/ammo_casing/rebar/zaukerite, req_amount=1, res_amount=1, category = CAT_WEAPON_AMMO),
	))

/obj/item/stack/sheet/mineral/zaukerite
	name = "灼蚀晶体"
	icon_state = "zaukerite"
	inhand_icon_state = "sheet-zaukerite"
	worn_icon_state = "shard_white"
	singular_name = "灼蚀晶体"
	w_class = WEIGHT_CLASS_NORMAL
	gulag_value = 100
	mats_per_unit = list(/datum/material/zaukerite = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/mineral/zaukerite
	material_type = /datum/material/zaukerite

/obj/item/stack/sheet/mineral/zaukerite/get_main_recipes()
	. = ..()
	. += GLOB.zaukerite_recipes
