// Chili
/obj/item/seeds/chili
	name = "辣椒种子包"
	desc = "这些种子会长成辣椒植株。辣！辣！辣！"
	icon_state = "seed-chili"
	species = "chili"
	plantname = "辣椒植株"
	product = /obj/item/food/grown/chili
	lifespan = 20
	maturation = 5
	production = 5
	yield = 4
	potency = 20
	instability = 30
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_grow = "chili-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "chili-dead" // Same for the dead icon
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/chili/ice, /obj/item/seeds/chili/ghost)
	reagents_add = list(/datum/reagent/consumable/capsaicin = 0.25, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04)

/obj/item/food/grown/chili
	seed = /obj/item/seeds/chili
	name = "辣椒"
	desc = "好辣！等等……它把我烧起来了！！"
	icon_state = "chilipepper"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	wine_power = 20

// Ice Chili
/obj/item/seeds/chili/ice
	name = "冰凉椒种子包"
	desc = "这些种子会长成冰凉椒植株。"
	icon_state = "seed-icepepper"
	species = "chiliice"
	plantname = "冰凉椒植株"
	product = /obj/item/food/grown/icepepper
	lifespan = 25
	maturation = 4
	production = 4
	rarity = PLANT_MODERATELY_RARE
	genes = list(/datum/plant_gene/trait/chem_cooling)
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/frostoil = 0.25, /datum/reagent/consumable/nutriment/vitamin = 0.02, /datum/reagent/consumable/nutriment = 0.02)
	graft_gene = /datum/plant_gene/trait/chem_cooling

/obj/item/food/grown/icepepper
	seed = /obj/item/seeds/chili/ice
	name = "冰凉椒"
	desc = "这是辣椒的一个突变品种。"
	icon_state = "icepepper"
	bite_consumption_mod = 5
	foodtypes = VEGETABLES
	wine_power = 30

// Ghost Chili
/obj/item/seeds/chili/ghost
	name = "幽灵辣椒种子包"
	desc = "这些种子会长成据说是银河系中最辣的辣椒。"
	icon_state = "seed-chilighost"
	species = "chilighost"
	plantname = "幽灵辣椒植株"
	product = /obj/item/food/grown/ghost_chili
	endurance = 10
	maturation = 10
	production = 10
	yield = 3
	rarity = PLANT_MODERATELY_RARE
	genes = list(/datum/plant_gene/trait/chem_heating, /datum/plant_gene/trait/backfire/chili_heat)
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/condensedcapsaicin = 0.3, /datum/reagent/consumable/capsaicin = 0.55, /datum/reagent/consumable/nutriment = 0.04)
	graft_gene = /datum/plant_gene/trait/chem_heating

/obj/item/food/grown/ghost_chili
	seed = /obj/item/seeds/chili/ghost
	name = "幽灵辣椒"
	desc = "它似乎在轻轻颤动。"
	icon_state = "ghostchilipepper"
	bite_consumption_mod = 5
	foodtypes = VEGETABLES
	wine_power = 50

// Bell Pepper
/obj/item/seeds/chili/bell_pepper
	name = "甜椒种子包"
	desc = "这些种子会长成甜椒植株。温和！温和！温和！"
	icon_state = "seed-bell-pepper"
	species = "bellpepper"
	plantname = "甜椒植株"
	product = /obj/item/food/grown/bell_pepper
	endurance = 10
	maturation = 10
	production = 10
	yield = 3
	rarity = PLANT_MODERATELY_RARE
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.08, /datum/reagent/consumable/nutriment = 0.04)

/obj/item/food/grown/bell_pepper
	seed = /obj/item/seeds/chili/bell_pepper
	name = "甜椒"
	desc = "一种温和的大甜椒，用途广泛。"
	icon_state = "bell_pepper"
	foodtypes = VEGETABLES

/obj/item/food/grown/bell_pepper/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/roasted_bell_pepper, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)
