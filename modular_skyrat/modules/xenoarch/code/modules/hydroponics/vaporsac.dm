/obj/item/seeds/vaporsac
	name = "雾囊草种子包"
	desc = "这些种子能长成雾囊草。雾囊草通常通过在空中飘浮并爆裂来传播，幸好这个品种不会。"
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "vaporsac"
	species = "vaporsac"
	plantname = "雾囊草"
	product = /obj/item/food/grown/vaporsac
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "vaporsac-stage"
	growthstages = 3
	genes = list(/datum/plant_gene/trait/squash, /datum/plant_gene/trait/smoke)
	reagents_add = list(/datum/reagent/nitrous_oxide = 0.1, /datum/reagent/medicine/muscle_stimulant = 0.1, /datum/reagent/medicine/coagulant = 0.1)

/obj/item/food/grown/vaporsac
	seed = /obj/item/seeds/vaporsac
	name = "雾囊"
	desc = "轻盈的雾囊，里面充满气溶胶化的化学物质。"
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "vaporsac"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	tastes = list("睡意" = 1)

/obj/item/food/grown/vaporsac/juice_typepath()
	return /datum/reagent/nitrous_oxide
