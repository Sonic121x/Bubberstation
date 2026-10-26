/obj/item/seeds/vale
	name = "焰叶树种子包"
	desc = "这些种子能长成焰叶树。它曾凭独特美感作为奢侈品出售，后来因树木突然自燃而遭到下架。"
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "vale"
	species = "vale"
	plantname = "焰叶树"
	product = /obj/item/food/grown/vale
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "vale-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow/pink)
	reagents_add = list(/datum/reagent/stable_plasma = 0.1, /datum/reagent/toxin/plasma = 0.1, /datum/reagent/napalm = 0.1)

/obj/item/food/grown/vale
	seed = /obj/item/seeds/vale
	name = "焰叶"
	desc = "一簇焰叶树叶，请远离明火。"
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "vale"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	tastes = list("等离子体" = 1)

/obj/item/food/grown/vale/juice_typepath()
	return /datum/reagent/toxin/plasma
