// Peanuts!
/obj/item/seeds/peanut
	name = "花生种子包"
	desc = "这些种子会长成花生植株。"
	icon_state = "seed-peanut"
	species = "peanut"
	plantname = "花生植株"
	product = /obj/item/food/grown/peanut
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'icons/obj/service/hydroponics/growing.dmi'
	icon_grow = "peanut-grow"
	icon_dead = "peanut-dead"
	genes = list(/datum/plant_gene/trait/one_bite)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/peanut
	seed = /obj/item/seeds/peanut
	name = "花生"
	desc = "一对藏在坚硬外壳里的美味坚果。"
	icon_state = "peanut"
	foodtypes = NUTS
	tastes = list("花生" = 1)

/obj/item/food/grown/peanut/grind_results()
	return list(/datum/reagent/consumable/peanut_butter = 0)
