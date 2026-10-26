/obj/item/seeds/telriis
	name = "乳汁草种子包"
	desc = "这些种子能长成乳汁草。它是乳草的远亲，真的能榨出乳汁。"
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "telriis"
	species = "telriis"
	plantname = "乳汁草"
	product = /obj/item/food/grown/telriis
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "telriis-stage"
	growthstages = 4
	plant_icon_offset = 7
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/invasive)
	reagents_add = list(/datum/reagent/consumable/milk = 0.1, /datum/reagent/consumable/soymilk = 0.1, /datum/reagent/consumable/korta_milk)

/obj/item/food/grown/telriis
	seed = /obj/item/seeds/telriis
	name = "乳汁草"
	desc = "一捆乳汁草，可以研磨或榨取乳状液体。"
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "telriis"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	tastes = list("牛奶" = 1)

/obj/item/food/grown/telriis/juice_typepath()
	return /datum/reagent/consumable/coconut_milk
