/obj/item/food/nekoroll
	name = "猫脸寿司卷"
	desc = "可爱的猫脸形状寿司卷，几乎让人舍不得吃。"
	icon = 'modular_zubbers/icons/obj/food/food.dmi'
	icon_state = "nekoroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("米饭" = 1, "鱼" = 1, "可爱" = 1)
	foodtypes = GRAIN | MEAT
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/bignekoroll
	name = "壮猫饭团"
	desc = "一大团米饭，上面捏着一张粗糙的猫脸，还散发着鱼腥味。"
	icon = 'modular_zubbers/icons/obj/food/food.dmi'
	icon_state = "bignekoroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/sugar = 2,
	)
	tastes = list("米饭" = 1, "鱼" = 1, "浪费" = 1)
	foodtypes = GRAIN | MEAT
	w_class = WEIGHT_CLASS_SMALL
