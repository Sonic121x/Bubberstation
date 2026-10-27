// Note, the order these in are deliberate, as it affects
// the order they are shown via radial.
GLOBAL_LIST_INIT(runed_metal_recipes, list( \
	new /datum/stack_recipe/radial( \
		title = "尖塔", \
		result_type = /obj/structure/destructible/cult/pylon, \
		req_amount = 4, \
		time = 4 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("尖塔：治疗并再生附近血教徒与构装体的血液，还会将附近地砖 \
			转化为雕纹地板，使血教徒能更快地绘制符文。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \
	new /datum/stack_recipe/radial( \
		title = "祭坛", \
		result_type = /obj/structure/destructible/cult/item_dispenser/altar, \
		req_amount = 3, \
		time = 4 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("祭坛：可制造邪异磨石、构装体外壳与不洁之水烧瓶。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \
	new /datum/stack_recipe/radial( \
		title = "档案馆", \
		result_type = /obj/structure/destructible/cult/item_dispenser/archives, \
		req_amount = 3, \
		time = 4 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("档案馆：可制造狂信徒眼罩、穿梭机诅咒宝珠 \
			与帷幕行者装备。会发光。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \
	new /datum/stack_recipe/radial( \
		title = "恶魔熔炉", \
		result_type = /obj/structure/destructible/cult/item_dispenser/forge, \
		req_amount = 3, \
		time = 4 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("恶魔熔炉：可制造纳尔西硬化护甲与邪异长剑。会发光。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \
	new /datum/stack_recipe/radial( \
		title = "符文门", \
		result_type = /obj/machinery/door/airlock/cult, \
		time = 5 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("符文门：一扇脆弱的门，触碰它的非血教徒会被电击麻痹。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \
	new /datum/stack_recipe/radial( \
		title = "符文钢梁", \
		result_type = /obj/structure/girder/cult, \
		time = 5 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("符文钢梁：一种脆弱的钢梁，可被仪式匕首瞬间摧毁。 \
			不推荐将符文金属用于此用途。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \

	new /datum/stack_recipe("符文石平台", /obj/structure/platform/cult, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
))

/obj/item/stack/sheet/runed_metal
	name = "符文金属"
	desc = "冰冷的金属板，上面有不断游移的铭文。"
	singular_name = "符文金属板"
	icon_state = "sheet-runed"
	worn_icon_state = "sheet-runed"
	inhand_icon_state = "sheet-runed"
	icon = 'icons/obj/stack_objects.dmi'
	mats_per_unit = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT)
	construction_path_type = "runed"
	merge_type = /obj/item/stack/sheet/runed_metal
	material_type = /datum/material/runedmetal
	has_unique_girder = TRUE
	use_radial = TRUE

/obj/item/stack/sheet/runed_metal/grind_results()
	return list(/datum/reagent/iron = 5, /datum/reagent/blood = 15)

/obj/item/stack/sheet/runed_metal/interact(mob/user)
	if(!IS_CULTIST(user))
		to_chat(user, span_warning("只有掌握禁忌知识之人才能加工这种金属……"))
		return FALSE

	var/turf/user_turf = get_turf(user)
	var/area/user_area = get_area(user)

	var/is_valid_turf = user_turf && (is_station_level(user_turf.z) || is_mining_level(user_turf.z))
	var/is_valid_area = user_area && (user_area.area_flags & CULT_PERMITTED)

	if(!is_valid_turf || !is_valid_area)
		to_chat(user, span_warning("此处的帷幕还不够薄弱。"))
		return FALSE

	return ..()

/obj/item/stack/sheet/runed_metal/radial_check(mob/builder)
	return ..() && IS_CULTIST(builder)

/obj/item/stack/sheet/runed_metal/get_main_recipes()
	. = ..()
	. += GLOB.runed_metal_recipes

/obj/item/stack/sheet/runed_metal/fifty
	amount = 50

/obj/item/stack/sheet/runed_metal/ten
	amount = 10

/obj/item/stack/sheet/runed_metal/five
	amount = 5
