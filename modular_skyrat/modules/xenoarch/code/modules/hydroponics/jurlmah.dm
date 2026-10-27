/obj/item/seeds/jurlmah
	name = "霜愈果种子包"
	desc = "这些种子能长成霜愈果。在无法架设专用低温治疗舱的地方，它常被用作临时低温疗法。"
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "jurlmah"
	species = "jurlmah"
	plantname = "霜愈果植株"
	product = /obj/item/food/grown/jurlmah
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "jurlmah-stage"
	growthstages = 5
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow/blue)
	reagents_add = list(/datum/reagent/medicine/cryoxadone = 0.1, /datum/reagent/inverse/healing/tirimol  = 0.1, /datum/reagent/consumable/frostoil = 0.1)

/obj/item/food/grown/jurlmah
	seed = /obj/item/seeds/jurlmah
	name = "霜愈果"
	desc = "结着霜的霜愈果，摸起来冰冰凉凉。"
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "jurlmah"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	tastes = list("雪" = 1)

/obj/item/food/grown/jurlmah/juice_typepath()
	return /datum/reagent/medicine/cryoxadone
