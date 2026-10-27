// Muli
/obj/item/seeds/muli
	name = "穆利种子包"
	desc = "这种细菌菌落会生长成穆利荚。"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-muli"
	species = "muli"
	plantname = "穆利菌落"
	product = /obj/item/food/grown/muli
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "muli-grow"
	icon_dead = "muli-dead"
	lifespan = 60
	endurance = 50
	growthstages = 4
	reagents_add = list(/datum/reagent/consumable/muli_juice = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/muli
	seed = /obj/item/seeds/muli
	name = "穆利荚"
	desc = "柔软的椭圆形荚果，内含带薄荷味的淡蓝色汁液，在特沙利料理中有许多用途。"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "muli"
	foodtypes = VEGETABLES
	tastes = list("薄荷与鲜甜" = 1)

/obj/item/food/grown/muli/grind_results()
	return list(/datum/reagent/consumable/muli_juice = 0.1)

/obj/item/food/grown/muli/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/baked_muli, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)
