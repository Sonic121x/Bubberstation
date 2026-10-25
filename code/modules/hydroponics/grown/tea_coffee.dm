// Tea
/obj/item/seeds/tea
	name = "苦茶种子包"
	desc = "这些种子会长成茶树。"
	icon_state = "seed-teaaspera"
	species = "teaaspera"
	plantname = "苦茶植株"
	product = /obj/item/food/grown/tea
	lifespan = 20
	maturation = 5
	production = 5
	yield = 5
	growthstages = 5
	icon_dead = "tea-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/tea/astra)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/toxin/teapowder = 0.1)

/obj/item/food/grown/tea
	seed = /obj/item/seeds/tea
	name = "苦茶嫩叶"
	desc = "这些芳香的茶树嫩叶晒干后可以制成茶。"
	icon_state = "tea_aspera_leaves"
	dry_grind = TRUE
	can_distill = FALSE

/obj/item/food/grown/tea/grind_results()
	return list(/datum/reagent/toxin/teapowder = 0)

// Tea Astra
/obj/item/seeds/tea/astra
	name = "星茶种子包"
	icon_state = "seed-teaastra"
	species = "teaastra"
	plantname = "星茶植株"
	product = /obj/item/food/grown/tea/astra
	mutatelist = null
	reagents_add = list(/datum/reagent/medicine/synaptizine = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/toxin/teapowder = 0.1)
	rarity = PLANT_MODERATELY_RARE

/obj/item/food/grown/tea/astra
	seed = /obj/item/seeds/tea/astra
	name = "星茶嫩叶"
	icon_state = "tea_astra_leaves"
	bite_consumption_mod = 2

/obj/item/food/grown/tea/astra/grind_results()
	return list(/datum/reagent/toxin/teapowder = 0, /datum/reagent/medicine/salglu_solution = 0)

// Coffee
/obj/item/seeds/coffee
	name = "阿拉比卡咖啡种子包"
	desc = "这些种子会长成阿拉比卡咖啡灌木。"
	icon_state = "seed-coffeea"
	species = "coffeea"
	plantname = "阿拉比卡咖啡灌木"
	product = /obj/item/food/grown/coffee
	lifespan = 30
	endurance = 20
	maturation = 5
	production = 5
	yield = 5
	instability = 20
	growthstages = 5
	icon_dead = "coffee-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/coffee/robusta)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/toxin/coffeepowder = 0.1, /datum/reagent/nitrogen = 0.05)

/obj/item/food/grown/coffee
	seed = /obj/item/seeds/coffee
	name = "阿拉比卡咖啡豆"
	desc = "把它们晒干就能制成咖啡。"
	icon_state = "coffee_arabica"
	dry_grind = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/kahlua

/obj/item/food/grown/coffee/grind_results()
	return list(/datum/reagent/toxin/coffeepowder = 0)

// Coffee Robusta
/obj/item/seeds/coffee/robusta
	name = "罗布斯塔咖啡种子包"
	desc = "这些种子会长成罗布斯塔咖啡灌木。"
	icon_state = "seed-coffeer"
	species = "coffeer"
	plantname = "罗布斯塔咖啡灌木"
	product = /obj/item/food/grown/coffee/robusta
	mutatelist = null
	reagents_add = list(/datum/reagent/medicine/ephedrine = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/toxin/coffeepowder = 0.1)
	rarity = PLANT_MODERATELY_RARE

/obj/item/food/grown/coffee/robusta
	seed = /obj/item/seeds/coffee/robusta
	name = "罗布斯塔咖啡豆"
	desc = "使强悍程度提升 37%！"
	icon_state = "coffee_robusta"

/obj/item/food/grown/coffee/robusta/grind_results()
	return list(/datum/reagent/toxin/coffeepowder = 0, /datum/reagent/medicine/morphine = 0)
