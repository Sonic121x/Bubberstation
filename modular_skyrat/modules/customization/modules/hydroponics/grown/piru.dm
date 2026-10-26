// Piru
/obj/item/seeds/piru
	name = "皮鲁种子包"
	desc = "这种细菌菌落会生长成皮鲁叶。"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-piru"
	species = "piru"
	plantname = "皮鲁菌落"
	product = /obj/item/food/grown/piru
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "piru-grow"
	icon_dead = "piru-dead"
	lifespan = 60
	endurance = 50
	growthstages = 4
	reagents_add = list(/datum/reagent/consumable/piru_flour = 0.25)

/obj/item/food/grown/piru
	seed = /obj/item/seeds/piru
	name = "皮鲁叶"
	desc = "一片纤细的皮鲁叶，与其说像叶子，不如说更像一缕缕丝线。磨碎后成为特沙利料理所用的皮鲁面粉。"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "piru"
	foodtypes = VEGETABLES
	tastes = list("粉质的干涩" = 1)

/obj/item/food/grown/piru/grind_results()
	return list(/datum/reagent/consumable/piru_flour = 0)

