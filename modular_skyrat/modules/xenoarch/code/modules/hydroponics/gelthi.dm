/obj/item/seeds/gelthi
	name = "蜜荚草种子包"
	desc = "这些种子能长成蜜荚草。它独特的产蜜能力深受厨师赞赏，也常因此被大量囤积。"
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "gelthi"
	species = "gelthi"
	plantname = "蜜荚草"
	product = /obj/item/food/grown/gelthi
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "gelthi-stage"
	growthstages = 3
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/squash)
	reagents_add = list(/datum/reagent/consumable/sprinkles = 0.1, /datum/reagent/consumable/astrotame = 0.1, /datum/reagent/consumable/honey = 0.2)

/obj/item/food/grown/gelthi
	seed = /obj/item/seeds/gelthi
	name = "蜜荚"
	desc = "一簇蜜荚草的果荚。每个果荚含有不同的甜味剂，还能榨出原糖。"
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "gelthi"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	tastes = list("甜得发腻" = 1)

/obj/item/food/grown/gelthi/juice_typepath()
	return /datum/reagent/consumable/sugar
