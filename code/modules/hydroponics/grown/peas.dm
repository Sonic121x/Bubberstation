// Finally, peas. Base plant.
/obj/item/seeds/peas
	name = "豌豆荚种子包"
	desc = "这些种子会长成富含维生素的豌豆！"
	icon_state = "seed-peas"
	species = "peas"
	plantname = "豌豆藤"
	product = /obj/item/food/grown/peas
	maturation = 3
	potency = 25
	instability = 15
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_grow = "peas-grow"
	icon_dead = "peas-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/peas/laugh)
	reagents_add = list (/datum/reagent/consumable/nutriment/vitamin = 0.1, /datum/reagent/consumable/nutriment = 0.05, /datum/reagent/water = 0.05)

/obj/item/food/grown/peas
	seed = /obj/item/seeds/peas
	name = "豌豆荚"
	desc = "终于……豌豆。"
	icon_state = "peas"
	foodtypes = VEGETABLES
	tastes = list ("豌豆" = 1, "粉笔般的咸味" = 1)
	wine_power = 50
	wine_flavor = "令人不安的是，这是发酵的豌豆。"

// Laughin' Peas
/obj/item/seeds/peas/laugh
	name = "欢笑豌豆种子包"
	desc = "这些种子散发着非常柔和的紫色微光……它们应该会长成欢笑豌豆。"
	icon_state = "seed-laughpeas"
	species = "laughpeas"
	plantname = "欢笑豌豆"
	product = /obj/item/food/grown/laugh
	maturation = 7
	potency = 10
	yield = 7
	production = 5
	growthstages = 3
	icon_grow = "laughpeas-grow"
	icon_dead = "laughpeas-dead"
	genes = list (/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow/purple, /datum/plant_gene/trait/plant_laughter)
	mutatelist = list (/obj/item/seeds/peas/laugh/peace)
	reagents_add = list (/datum/reagent/consumable/laughter = 0.05, /datum/reagent/consumable/sugar = 0.05, /datum/reagent/consumable/nutriment = 0.07)
	rarity = 25 //It actually might make Central Command Officials loosen up a smidge, eh?
	graft_gene = /datum/plant_gene/trait/plant_laughter

/obj/item/food/grown/laugh
	seed = /obj/item/seeds/peas/laugh
	name = "欢笑豌豆荚"
	desc = "Ridens Cicer，保证食用后能大幅改善你的心情！"
	icon_state = "laughpeas"
	foodtypes = VEGETABLES
	tastes = list ("一只蹦跳的兔子" = 1) //Vib Ribbon sends her regards.. wherever she is.
	wine_power = 90
	wine_flavor = "一只矢量图形兔子在你舌上起舞"

/obj/item/food/grown/laugh/juice_typepath()
	return /datum/reagent/consumable/laughsyrup

// World Peas - Peace at last, peace at last...
/obj/item/seeds/peas/laugh/peace
	name = "世界豌豆种子包"
	desc = "这些相当大的种子散发着令人平静的蓝色微光……"
	icon_state = "seed-worldpeas"
	species = "worldpeas"
	plantname = "世界豌豆"
	product = /obj/item/food/grown/peace
	maturation = 20
	potency = 75
	yield = 1
	production = 10
	instability = 45 //The world is a very unstable place. Constantly changing.
	growthstages = 3
	icon_grow = "worldpeas-grow"
	icon_dead = "worldpeas-dead"
	genes = list (/datum/plant_gene/trait/glow/blue)
	reagents_add = list (/datum/reagent/pax = 0.1, /datum/reagent/drug/happiness = 0.1, /datum/reagent/consumable/nutriment = 0.15)
	rarity = 50 // This absolutely will make even the most hardened Syndicate Operators relax.
	graft_gene = /datum/plant_gene/trait/glow/blue
	mutatelist = null

/obj/item/food/grown/peace
	seed = /obj/item/seeds/peas/laugh/peace
	name = "世界豌豆串"
	desc = "一种通过大量基因工程和反复嫁接培育出的植物。据传任何食用它的人都会获得和平。在更广泛的农业科研圈里，它得到了“Pax Mundi”的绰号。" //at last... world peas. I'm not sorry.
	icon_state = "worldpeas"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	tastes = list ("麻木的宁静" = 2, "温暖" = 1)
	wine_power = 100
	wine_flavor = "令人头脑麻木的和平与温暖"
