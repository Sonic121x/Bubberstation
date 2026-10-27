/obj/item/seeds/surik
	name = "熔晶草种子包"
	desc = "这些种子能长成熔晶草，据说蕴含因德西菲瑞斯的精髓。"
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "surik"
	species = "surik"
	plantname = "熔晶草"
	product = /obj/item/food/grown/surik
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "surik-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/fire_resistance)
	reagents_add = list(/datum/reagent/brimdust = 0.1, /datum/reagent/medicine/omnizine/godblood = 0.1, /datum/reagent/wittel = 0.1)

/obj/item/food/grown/surik
	seed = /obj/item/seeds/surik
	name = "熔晶"
	desc = "闪闪发光的熔晶，宝石中心随着火山活动而震颤。"
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "surik"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	tastes = list("晶体" = 1)

/obj/item/food/grown/surik/juice_typepath()
	return /datum/reagent/brimdust
