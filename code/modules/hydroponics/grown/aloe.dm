
// aloe
/obj/item/seeds/aloe
	name = "芦荟种子包"
	desc = "这些种子会长成芦荟。"
	icon_state = "seed-aloe"
	species = "aloe"
	plantname = "芦荟"
	product = /obj/item/food/grown/aloe
	lifespan = 60
	endurance = 25
	maturation = 4
	production = 4
	yield = 6
	growthstages = 5
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.05, /datum/reagent/consumable/nutriment = 0.05)

/obj/item/food/grown/aloe
	seed = /obj/item/seeds/aloe
	name = "芦荟"
	desc = "从芦荟植株上切下的叶片。"
	icon_state = "aloe"
	bite_consumption_mod = 3
	foodtypes = VEGETABLES
	distill_reagent = /datum/reagent/consumable/ethanol/tequila

/obj/item/food/grown/aloe/juice_typepath()
	return /datum/reagent/consumable/aloejuice

/obj/item/food/grown/aloe/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/stack/medical/aloe/fresh, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/grown/aloe/make_microwaveable()
	AddElement(/datum/element/microwavable, /obj/item/stack/medical/aloe/fresh)
