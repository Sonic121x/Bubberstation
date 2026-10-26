/obj/item/seeds/amauri
	name = "毒囊草种子包"
	desc = "这些种子能长成毒囊草，结出充满强效毒素的球茎。"
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "amauri"
	species = "amauri"
	plantname = "毒囊草"
	product = /obj/item/food/grown/amauri
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "amauri-stage"
	growthstages = 3
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/preserved)
	reagents_add = list(/datum/reagent/toxin = 0.1, /datum/reagent/toxin/venom = 0.1, /datum/reagent/toxin/hot_ice = 0.1)

/obj/item/food/grown/amauri
	seed = /obj/item/seeds/amauri
	name = "毒囊草球茎"
	desc = "有毒的毒囊草球茎，千万别吃。"
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "amauri"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	tastes = list("毒药" = 1)

/obj/item/food/grown/amauri/juice_typepath()
	return /datum/reagent/toxin
