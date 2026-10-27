/obj/item/food/eggplantparm
	name = "帕尔马茄子"
	desc = "茄子唯一好吃的做法。"
	icon_state = "eggplantparm"

	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("茄子" = 3, "奶酪" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/yakiimo
	name = "烤红薯"
	desc = "用烤红薯做的！"
	icon_state = "yakiimo"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("红薯" = 1)
	foodtypes = VEGETABLES | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/roastparsnip
	name = "烤欧防风"
	desc = "香甜又爽脆。"
	icon_state = "roastparsnip"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("欧防风" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

// Potatoes
/obj/item/food/tatortot
	name = "炸薯球"
	desc = "一大块油炸土豆块，可能会、也可能不会想把你当作目标。"
	icon_state = "tatortot"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("土豆" = 3, "有效目标" = 1)
	foodtypes = FRIED | VEGETABLES
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/tatortot/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/mashed_potatoes
	name = "土豆泥"
	desc = "一份香浓顺滑的土豆泥，许多感恩节晚餐的主食。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "mashed_potatoes"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("香浓土豆泥" = 1, "大蒜" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/baked_potato
	name = "烤土豆"
	desc = "一个在烤箱里烤得滚烫的土豆。单吃有点寡淡。"
	icon_state = "baked_potato"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("烤土豆" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/buttered_baked_potato
	name = "黄油烤土豆"
	desc = "一个烤得滚烫的土豆，现在还拌进了一片黄油。完美。"
	icon_state = "buttered_baked_potato"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("烤土豆" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/loaded_baked_potato
	name = "豪华烤土豆"
	desc = "一个烤得滚烫的土豆，内瓤被挖出后与培根碎、奶酪和卷心菜拌在一起。"
	icon_state = "loaded_baked_potato"
	food_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/consumable/nutriment/protein = 4)
	tastes = list("烤土豆" = 1, "培根" = 1, "奶酪" = 1, "卷心菜" = 1)
	foodtypes = VEGETABLES | DAIRY | MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

// Fries
/obj/item/food/fries
	name = "太空薯条"
	desc = "又名：法式薯条、自由薯条等等。"
	icon_state = "fries"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("薯条" = 3, "盐" = 1)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	preserved_food = TRUE
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/fries/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/cheesyfries
	name = "芝士薯条"
	desc = "薯条。裹上芝士。这不是明摆着吗。"
	icon_state = "cheesyfries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("薯条" = 3, "奶酪" = 1)
	foodtypes = VEGETABLES|DAIRY|FRIED
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	preserved_food = TRUE
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cheesyfries/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/carrotfries
	name = "胡萝卜薯条"
	desc = "用新鲜胡萝卜做成的美味薯条。"
	icon_state = "carrotfries"

	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("胡萝卜" = 3, "盐" = 1)
	foodtypes = VEGETABLES|FRIED
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/carrotfries/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/poutine
	name = "肉汁奶酪薯条"
	desc = "裹着奶酪凝块和肉汁的薯条。"
	icon_state = "poutine"
	food_reagents = list(/datum/reagent/consumable/nutriment = 7)
	tastes = list("土豆" = 3, "肉汁" = 1, "吱吱奶酪" = 1)
	foodtypes = VEGETABLES|DAIRY|FRIED|MEAT
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	preserved_food = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/poutine/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/sauteed_eggplant
	name = "香煎茄子"
	desc = "厚切的茄子片用油和蒜末煎制，做成一款柔软、酥脆又健康的点心。"
	icon_state = "sauteed_eggplant"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("煎茄子" = 4, "大蒜" = 2, "橄榄油" = 3)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/baba_ghanoush
	name = "巴巴甘努什"
	desc = "用茄子泥、橄榄油、大蒜和柠檬汁调成的浓稠蘸酱，配上皮塔饼用来蘸食。你要么爱它，要么恨它。"
	icon_state = "baba_ghanoush"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("茄子泥" = 5, "皮塔饼" = 4, "大蒜" = 3, "橄榄油" = 4, "柠檬汁" = 2)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/falafel
	name = "法拉费"
	desc = "把豆子、香草、洋葱和大蒜捣碎和成丸子，再下锅油炸。香草让它的内部呈现出独特的绿色。"
	icon_state = "falafel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("蚕豆" = 5, "大蒜" = 3, "洋葱" = 2, "新鲜香草" = 4)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
