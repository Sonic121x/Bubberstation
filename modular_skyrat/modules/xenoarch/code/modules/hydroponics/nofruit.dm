/obj/item/seeds/nofruit
	name = "虚无果种子包"
	desc = "这些种子能长成虚无果，一种常由默剧演员栽培的奇异植物。"
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "nofruit"
	species = "nofruit"
	plantname = "虚无果植株"
	product = /obj/item/food/grown/nofruit
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "nofruit-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nothing = 0.1, /datum/reagent/toxin/mimesbane = 0.1, /datum/reagent/toxin/mutetoxin = 0.1)

/obj/item/food/grown/nofruit
	seed = /obj/item/seeds/nofruit
	name = "虚无果"
	desc = "立方体形的虚无果，顶部叶片正疯狂地比划着。"
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "nofruit"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	tastes = list("虚无" = 1)

/obj/item/food/grown/nofruit/juice_typepath()
	return /datum/reagent/consumable/nothing
