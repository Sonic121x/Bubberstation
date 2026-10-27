/obj/item/food/fishmeat/shrimp
	name = "生虾"
	desc = "一只刚处理好的虾。"
	icon = 'modular_zubbers/icons/obj/food/meat.dmi'
	icon_state = "shrimp"
	tastes = list("生虾" = 1)
	bite_consumption = 3
	fillet_name = "生%NAME"

/obj/item/food/fishmeat/shrimp/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/fried_shrimp, rand(40 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/fried_shrimp
	name = "炸虾"
	desc = "被人油炸过的虾。"
	icon = 'modular_zubbers/icons/obj/food/meat.dmi'
	icon_state = "shrimp_cooked"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	bite_consumption = 3
	tastes = list("虾" = 1)
	foodtypes = JUNKFOOD | SEAFOOD | FRIED
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2
