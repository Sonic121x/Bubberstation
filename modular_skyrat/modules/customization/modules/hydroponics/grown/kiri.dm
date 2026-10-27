// Kiri
/obj/item/seeds/kiri
	name = "基里种子包"
	desc = "这种细菌菌落会生长成基里果实。"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-kiri"
	species = "kiri"
	plantname = "基里菌落"
	product = /obj/item/food/grown/kiri
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "kiri-grow"
	icon_dead = "kiri-dead"
	lifespan = 60
	endurance = 50
	growthstages = 4
	reagents_add = list(/datum/reagent/consumable/kiri_jelly = 0.04, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/kiri
	seed = /obj/item/seeds/kiri
	name = "基里果实"
	desc = "一种奇特的蛋形果实，表面布满鲜艳的粉色与黄色条纹。摸起来有些坚实，但整颗都能食用。内含一种极甜的果冻，常用于特沙利料理，也可以直接烤制，做成令人愉悦的小点心。"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "kiri"
	foodtypes = FRUIT | SUGAR
	distill_reagent = /datum/reagent/consumable/ethanol/shakiri
	tastes = list("极甜的果冻" = 1)

/obj/item/food/grown/kiri/grind_results()
	return list(/datum/reagent/consumable/kiri_jelly = 0.1)

/obj/item/food/grown/kiri/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/baked_kiri, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)
