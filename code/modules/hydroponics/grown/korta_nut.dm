//Korta Nut
/obj/item/seeds/korta_nut
	name = "科塔坚果种子包"
	desc = "这些种子会长成原产于提兹拉的科塔坚果树丛。"
	icon_state = "seed-korta"
	species = "kortanut"
	plantname = "科塔坚果树丛"
	product = /obj/item/food/grown/korta_nut
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	icon_grow = "kortanut-grow"
	icon_dead = "kortanut-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/one_bite)
	mutatelist = list(/obj/item/seeds/korta_nut/sweet)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/korta_nut
	seed = /obj/item/seeds/korta_nut
	name = "科塔坚果"
	desc = "一粒意义重大的小坚果。外壳带着胡椒味，可以磨成面粉；内部柔软多肉，榨汁后能得到乳状液体。你也可以整颗吃下，当作快速零食。"
	icon_state = "korta_nut"
	foodtypes = NUTS
	tastes = list("胡椒辛香" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/kortara

/obj/item/food/grown/korta_nut/grind_results()
	return list(/datum/reagent/consumable/korta_flour = 0)

/obj/item/food/grown/korta_nut/juice_typepath()
	return /datum/reagent/consumable/korta_milk

//Sweet Korta Nut
/obj/item/seeds/korta_nut/sweet
	name = "甜科塔坚果种子包"
	desc = "这些种子会长成甜科塔坚果，它是原种的变种，能产出提兹拉人用于甜点的浓稠糖浆。"
	icon_state = "seed-sweetkorta"
	species = "kortanut"
	plantname = "甜科塔坚果树丛"
	product = /obj/item/food/grown/korta_nut/sweet
	maturation = 10
	production = 10
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/korta_nectar = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)
	rarity = PLANT_MODERATELY_RARE

/obj/item/food/grown/korta_nut/sweet
	seed = /obj/item/seeds/korta_nut/sweet
	name = "甜科塔坚果"
	desc = "蜥蜴们爱吃的甜食。"
	icon_state = "korta_nut"
	tastes = list("胡椒甜香" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/kortara

/obj/item/food/grown/korta_nut/sweet/grind_results()
	return list(/datum/reagent/consumable/korta_flour = 0)

/obj/item/food/grown/korta_nut/sweet/juice_typepath()
	return /datum/reagent/consumable/korta_nectar
