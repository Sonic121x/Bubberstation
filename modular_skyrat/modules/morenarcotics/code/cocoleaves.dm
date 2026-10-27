/obj/item/seeds/cocaleaf
	name = "古柯种子包"
	desc = "这些种子能长成古柯灌木。光是看着它们就让你精神一振……"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_state = "seed-cocoleaf"
	species = "cocoleaf"
	plantname = "古柯"
	maturation = 8
	potency = 20
	growthstages = 1
	product = /obj/item/food/grown/cocaleaf
	mutatelist = list()
	reagents_add = list(/datum/reagent/drug/coca_powder = 0.3, /datum/reagent/consumable/nutriment = 0.15)

/obj/item/food/grown/cocaleaf
	seed = /obj/item/seeds/cocaleaf
	name = "古柯叶"
	desc = "一片古柯灌木的叶子，含有名为“可卡因”的强效精神活性生物碱。"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "cocoleaf"
	foodtypes = FRUIT //i guess? i mean it grows on trees...
	tastes = list("树叶" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/sins_delight //Cocaine is one hell of a sin.
