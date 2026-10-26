/obj/item/food/lava_chicken
	name = "熔岩鸡"
	desc = "好吃得要命！可这也是一次熔岩袭击！"
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	icon = 'modular_zubbers/icons/obj/food/meat.dmi'
	icon_state = "lava_chicken"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/toxin/spore_burning = 50)
	tastes = list("熔、熔、熔岩" = 40, "鸡、鸡、鸡肉" = 40)
	foodtypes = MEAT | FRIED
	junkiness = 25
	w_class = WEIGHT_CLASS_SMALL
