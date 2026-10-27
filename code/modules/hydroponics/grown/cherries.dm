// Cherries
/obj/item/seeds/cherry
	name = "樱桃核种子包"
	desc = "小心别咬到核崩了牙……那可真是惨透了。"
	icon_state = "seed-cherry"
	species = "cherry"
	plantname = "樱桃树"
	product = /obj/item/food/grown/cherries
	lifespan = 35
	endurance = 35
	maturation = 5
	production = 5
	growthstages = 5
	instability = 15
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	icon_grow = "cherry-grow"
	icon_dead = "cherry-dead"
	icon_harvest = "cherry-harvest"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/cherry/blue, /obj/item/seeds/cherry/bulb)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.07, /datum/reagent/consumable/sugar = 0.07)

/obj/item/food/grown/cherries
	seed = /obj/item/seeds/cherry
	name = "樱桃"
	desc = "非常适合做配料！"
	icon_state = "cherry"
	gender = PLURAL
	bite_consumption_mod = 2
	foodtypes = FRUIT
	tastes = list("樱桃" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/maraschino

/obj/item/food/grown/cherries/grind_results()
	return list(/datum/reagent/consumable/cherryjelly = 0)

// Blue Cherries
/obj/item/seeds/cherry/blue
	name = "蓝樱桃核种子包"
	desc = "蓝色的那种樱桃。"
	icon_state = "seed-bluecherry"
	species = "bluecherry"
	plantname = "蓝樱桃树"
	product = /obj/item/food/grown/bluecherries
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.07, /datum/reagent/consumable/sugar = 0.07, /datum/reagent/oxygen = 0.07)
	rarity = 10

/obj/item/food/grown/bluecherries
	seed = /obj/item/seeds/cherry/blue
	name = "蓝樱桃"
	desc = "它们是蓝色的樱桃。"
	icon_state = "bluecherry"
	bite_consumption_mod = 2
	foodtypes = FRUIT
	tastes = list("蓝樱桃" = 1)
	wine_power = 50

/obj/item/food/grown/bluecherries/grind_results()
	return list(/datum/reagent/consumable/bluecherryjelly = 0)

//Cherry Bulbs
/obj/item/seeds/cherry/bulb
	name = "樱桃球核种子包"
	desc = "会发光的那种樱桃。"
	icon_state = "seed-cherrybulb"
	species = "cherrybulb"
	plantname = "樱桃球树"
	product = /obj/item/food/grown/cherrybulbs
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow/pink)
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.07, /datum/reagent/consumable/sugar = 0.07)
	rarity = 10
	graft_gene = /datum/plant_gene/trait/glow/pink

/obj/item/food/grown/cherrybulbs
	seed = /obj/item/seeds/cherry/bulb
	name = "樱桃球"
	desc = "它们就像小小的太空圣诞灯串！"
	icon_state = "cherry_bulb"
	bite_consumption_mod = 2
	foodtypes = FRUIT
	tastes = list("樱桃" = 1)
	wine_power = 50

/obj/item/food/grown/cherrybulbs/grind_results()
	return list(/datum/reagent/consumable/cherryjelly = 0)

//Cherry Bombs
/obj/item/seeds/cherry/bomb
	name = "樱桃炸弹核种子包"
	desc = "它们会让你产生不祥与挫败的感觉。"
	icon_state = "seed-cherry_bomb"
	species = "cherry_bomb"
	plantname = "樱桃炸弹树"
	product = /obj/item/food/grown/cherry_bomb
	mutatelist = null
	genes = list(/datum/plant_gene/trait/bomb_plant, /datum/plant_gene/trait/modified_volume/cherry_bomb)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1, /datum/reagent/consumable/sugar = 0.1, /datum/reagent/gunpowder = 0.7)
	rarity = 60 //See above

/obj/item/food/grown/cherry_bomb
	name = "樱桃炸弹"
	desc = "你似乎能听见一根小引线正在嘶嘶燃烧。"
	icon_state = "cherry_bomb"
	alt_icon = "cherry_bomb_lit"
	seed = /obj/item/seeds/cherry/bomb
	bite_consumption_mod = 3
	wine_power = 80
