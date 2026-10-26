/obj/item/seeds/shand
	name = "化生草种子包"
	desc = "这些种子能长成化生草。虽然本身用途不多，却富含其他植物无法产生的化学物质，是杂交育种的好选择。"
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "shand"
	species = "shand"
	plantname = "化生草"
	product = /obj/item/food/grown/shand
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "shand-stage"
	growthstages = 3
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/maxchem)
	reagents_add = list(/datum/reagent/bromine = 0.1, /datum/reagent/sodium = 0.1, /datum/reagent/copper = 0.1)

/obj/item/food/grown/shand
	seed = /obj/item/seeds/shand
	name = "化生草叶"
	desc = "一把油腻的化生草叶，闻起来像实验室。"
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "shand"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	tastes = list("化学药品" = 1)

/obj/item/food/grown/shand/juice_typepath()
	return /datum/reagent/bromine
