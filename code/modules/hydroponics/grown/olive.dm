// Olive
/obj/item/seeds/olive
	name = "橄榄种子包"
	desc = "这些种子会长成橄榄树。"
	icon_state = "seed-olive"
	species = "olive"
	plantname = "橄榄树"
	product = /obj/item/food/grown/olive
	lifespan = 150
	endurance = 35
	yield = 5
	maturation = 10
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	icon_grow = "olive-grow"
	icon_dead = "olive-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/one_bite)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/olive
	seed = /obj/item/seeds/olive
	name = "橄榄"
	desc = "一颗小而呈圆柱形、带咸味的果实，与芒果亲缘相近。可以磨成糊状并与水混合，制成优质油脂。"
	icon_state = "olive"
	foodtypes = FRUIT
	tastes = list("橄榄" = 1)

/obj/item/food/grown/olive/grind_results()
	return list(/datum/reagent/consumable/olivepaste = 0)
