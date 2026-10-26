// FOOD ITEMS
/obj/item/food/mince_pie
	name = "百果馅饼"
	desc = "圣诞欢乐的可食用化身。"
	w_class = WEIGHT_CLASS_TINY
	icon = 'modular_skyrat/modules/modular_items/icons/pastries.dmi'
	icon_state = "mince_pie"
	food_flags = FOOD_FINGER_FOOD
	foodtypes = GRAIN | SUGAR | FRUIT
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("水果" = 1, "葡萄干" = 1, "圣诞精神" = 1)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/mimce_pie
	name = "拟馅饼"
	desc = "一种带星形盖的糕点，里面填着“虚无”。"
	w_class = WEIGHT_CLASS_TINY
	icon = 'modular_skyrat/modules/modular_items/icons/pastries.dmi'
	icon_state = "mimce_pie"
	food_flags = FOOD_FINGER_FOOD
	foodtypes = GRAIN | SUGAR | FRUIT
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("虚无" = 1, "圣诞精神" = 1)
	crafting_complexity = FOOD_COMPLEXITY_3

// RECIPE

/datum/crafting_recipe/food/mince_pie
	removed_foodtypes = JUNKFOOD | DAIRY
	name = "百果馅饼"
	reqs = list(
		/obj/item/food/no_raisin = 1,
		/obj/item/food/grown/apple = 1,
		/obj/item/food/pastrybase = 1
	)
	result = /obj/item/food/mince_pie
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/mimce_pie
	removed_foodtypes = JUNKFOOD | DAIRY
	name = "拟馅饼"
	reqs = list(
		/obj/item/food/no_raisin = 1,
		/obj/item/food/grown/apple = 1,
		/datum/reagent/consumable/nothing = 25,
		/obj/item/food/pastrybase = 1
	)
	result = /obj/item/food/mimce_pie
	dish_category = DISH_PASTRY
