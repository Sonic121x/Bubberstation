// Nakati
/obj/item/seeds/nakati
	name = "纳卡提种子包"
	desc = "这种细菌菌落会生长成会发光的纳卡提植株。"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-nakati"
	species = "nakati"
	plantname = "纳卡提菌落"
	product = /obj/item/food/grown/nakati
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "nakati-grow"
	icon_dead = "nakati-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	lifespan = 60
	endurance = 50
	growthstages = 4
	reagents_add = list(/datum/reagent/consumable/nakati_spice = 0.25)

/obj/item/food/grown/nakati
	seed = /obj/item/seeds/nakati
	name = "纳卡提树皮"
	desc = "一段取自纳卡提植株的芳香褐色“树皮”，磨碎后成为特沙利料理中广泛使用的辛香调料。"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "nakati"
	foodtypes = VEGETABLES
	tastes = list("铺天盖地的辛辣" = 1)

/obj/item/food/grown/nakati/grind_results()
	return list(/datum/reagent/consumable/nakati_spice = 0)


