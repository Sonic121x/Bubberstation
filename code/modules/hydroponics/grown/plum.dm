// Plum
/obj/item/seeds/plum
	name = "李子种子包"
	desc = "这些种子会长成李树。"
	icon_state = "seed-plum"
	species = "plum"
	plantname = "李树"
	product = /obj/item/food/grown/plum
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	icon_grow = "plum-grow"
	icon_dead = "plum-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/one_bite)
	mutatelist = list(/obj/item/seeds/plum/plumb)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1, /datum/reagent/impurity/rosenol = 0.04)

/obj/item/food/grown/plum
	seed = /obj/item/seeds/plum
	name = "李子"
	desc = "诗人最爱的水果。真不错。"
	icon_state = "plum"
	foodtypes = FRUIT
	tastes = list("李子" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/plumwine

/obj/item/food/grown/plum/juice_typepath()
	return /datum/reagent/consumable/plumjuice

// Plumb
/obj/item/seeds/plum/plumb
	name = "铅李种子包"
	desc = "这些种子会长成铅李树。"
	icon_state = "seed-plumb"
	species = "plumb"
	plantname = "铅李树"
	product = /obj/item/food/grown/plum/plumb
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1, /datum/reagent/lead = 0.04)
	rarity = 30

/obj/item/food/grown/plum/plumb
	seed = /obj/item/seeds/plum/plumb
	name = "铅李"
	desc = "它摸起来非常沉。"
	icon_state = "plumb"
	distill_reagent = null
	wine_power = 50
