/obj/item/seeds/thaadra
	name = "银药花种子包"
	desc = "这些种子能长成银药花，一种富含独特药物和银的奇花。"
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "thaadra"
	species = "thaadra"
	plantname = "银药花"
	product = /obj/item/food/grown/thaadra
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "thaadra-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/preserved)
	reagents_add = list(/datum/reagent/silver = 0.1, /datum/reagent/medicine/sansufentanyl = 0.1, /datum/reagent/medicine/cordiolis_hepatico = 0.1)

/obj/item/food/grown/thaadra
	seed = /obj/item/seeds/thaadra
	name = "银药花瓣"
	desc = "一簇银药花瓣，富含用途特殊的药用化学物质。"
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "thaadra"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	tastes = list("银" = 1)

/obj/item/food/grown/thaadra/juice_typepath()
	return /datum/reagent/silver
