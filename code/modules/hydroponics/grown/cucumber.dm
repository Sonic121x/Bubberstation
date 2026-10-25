// CUCUMBERS YEAH
/obj/item/seeds/cucumber
	name = "黄瓜种子包"
	desc = "这些种子会长成黄瓜植株。"
	icon_state = "seed-cucumber"
	species = "cucumber"
	plantname = "黄瓜植株"
	product = /obj/item/food/grown/cucumber
	maturation = 10
	production = 1
	yield = 5
	instability = 15
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_grow = "cucumber-grow"
	icon_dead = "cucumber-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/cucumber
	seed = /obj/item/seeds/cucumber
	name = "黄瓜"
	desc = "长圆形、绿色、带小疙瘩，是沙拉的标配。"
	icon_state = "cucumber"
	foodtypes = VEGETABLES
	tastes = list("黄瓜" = 1)

/obj/item/food/grown/cucumber/juice_typepath()
	return /datum/reagent/consumable/cucumberjuice
