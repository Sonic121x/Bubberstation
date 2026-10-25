/obj/item/seeds/garlic
	name = "大蒜种子包"
	desc = "一包气味极为刺鼻的种子。"
	icon_state = "seed-garlic"
	species = "garlic"
	plantname = "大蒜幼苗"
	product = /obj/item/food/grown/garlic
	yield = 6
	potency = 25
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	reagents_add = list(/datum/reagent/consumable/garlic = 0.15, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/garlic
	seed = /obj/item/seeds/garlic
	name = "大蒜"
	desc = "美味，但气味可能浓烈得让人受不了。"
	icon_state = "garlic"
	tastes = list("大蒜" = 1)
	wine_power = 10
	foodtypes = VEGETABLES
