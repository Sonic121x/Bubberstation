// Soybeans
/obj/item/seeds/soya
	name = "大豆种子包"
	desc = "这些种子会长成大豆植株。"
	icon_state = "seed-soybean"
	species = "soybean"
	plantname = "大豆植株"
	product = /obj/item/food/grown/soybeans
	maturation = 4
	production = 4
	potency = 15
	growthstages = 4
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_grow = "soybean-grow"
	icon_dead = "soybean-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/soya/koi, /obj/item/seeds/soya/butter)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.05, /datum/reagent/consumable/nutriment/fat/oil = 0.03) //Vegetable oil!

/obj/item/food/grown/soybeans
	seed = /obj/item/seeds/soya
	name = "大豆"
	desc = "味道相当寡淡，但可能性无穷……"
	gender = PLURAL
	icon_state = "soybeans"
	foodtypes = VEGETABLES
	tastes = list("soy" = 1)
	distill_reagent = /datum/reagent/consumable/soysauce

/obj/item/food/grown/soybeans/juice_typepath()
	return /datum/reagent/consumable/soymilk

// Koibean
/obj/item/seeds/soya/koi
	name = "锦鲤豆种子包"
	desc = "这些种子会长成锦鲤豆植株。"
	icon_state = "seed-koibean"
	species = "koibean"
	plantname = "锦鲤豆植株"
	product = /obj/item/food/grown/koibeans
	potency = 10
	mutatelist = null
	reagents_add = list(/datum/reagent/toxin/carpotoxin = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.05)
	rarity = PLANT_MODERATELY_RARE

/obj/item/food/grown/koibeans
	seed = /obj/item/seeds/soya/koi
	name = "锦鲤豆"
	desc = "这些东西透着股鱼腥味，它们摸起来非常柔软，几乎能捏出水来！"
	icon_state = "koibeans"
	foodtypes = VEGETABLES
	tastes = list("koi" = 1)
	wine_power = 40

//Now squeezable for imitation carpmeat
/obj/item/food/grown/koibeans/attack_self(mob/living/user)
	user.visible_message(span_notice("[user] 把 [src] 捏成了一块类似鲤鱼肉的东西。"), span_notice("你把 [src] 捏成了形似鲤鱼肉块的东西。"))
	playsound(user, 'sound/effects/blob/blobattack.ogg', 50, TRUE)
	var/obj/item/food/fishmeat/carp/imitation/fishie = new(null)
	fishie.reagents.set_all_reagents_purity(seed.get_reagent_purity())
	qdel(src)
	user.put_in_hands(fishie)
	return TRUE

//Butterbeans, the beans wid da butta!
// Butterbeans! - Squeeze for a single butter slice!
/obj/item/seeds/soya/butter
	name = "黄油豆种子包"
	desc = "这些种子会长成黄油豆植株。"
	icon_state = "seed-butterbean"
	species = "butterbean"
	plantname = "黄油豆植株"
	product = /obj/item/food/grown/butterbeans
	potency = 10
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/milk = 0.05, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/cream = 0.05)
	rarity = 20

/obj/item/food/grown/butterbeans
	seed = /obj/item/seeds/soya/butter
	name = "黄油豆"
	desc = "柔软、细腻又乳香浓郁……你几乎可以把它们抹在吐司上。"
	icon_state = "butterbeans"
	foodtypes = VEGETABLES | DAIRY
	tastes = list("creamy butter" = 1)
	distill_reagent = /datum/reagent/consumable/yoghurt

/obj/item/food/grown/butterbeans/attack_self(mob/living/user)
	user.visible_message(span_notice("[user] 把 [src] 捏成了一块黄油。"), span_notice("你把 [src] 捏成了形似黄油的东西。"))
	playsound(user, 'sound/effects/blob/blobattack.ogg', 50, TRUE)
	var/obj/item/food/butterslice/butties = new(null)
	butties.reagents.set_all_reagents_purity(seed.get_reagent_purity())
	qdel(src)
	user.put_in_hands(butties)
	return TRUE

// Green Beans
/obj/item/seeds/greenbean
	name = "四季豆种子包"
	desc = "这些种子会长成四季豆植株。"
	icon_state = "seed-greenbean"
	species = "greenbean"
	plantname = "四季豆植株"
	product = /obj/item/food/grown/greenbeans
	instability = 0
	maturation = 4
	production = 3
	potency = 10
	growthstages = 4
	icon_dead = "bean-dead"
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/never_mutate, /datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/greenbean/jump)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/medicine/c2/multiver = 0.04) //They're good for you!
	graft_gene = /datum/plant_gene/trait/never_mutate

/obj/item/food/grown/greenbeans
	seed = /obj/item/seeds/greenbean
	name = "四季豆"
	desc = "简单又健康，你还想要什么？"
	gender = PLURAL
	icon_state = "greenbean"
	foodtypes = FRUIT
	tastes = list("beans" = 1)

// Jumping Bean
/obj/item/seeds/greenbean/jump
	name = "跳豆种子包"
	desc = "这些种子会长成跳豆植株。"
	icon_state = "seed-jumpingbean"
	species = "jumpingbean"
	plantname = "跳豆植株"
	product = /obj/item/food/grown/jumpingbeans
	yield = 2
	instability = 18
	maturation = 8
	production = 4
	potency = 20
	genes = list(/datum/plant_gene/trait/stable_stats, /datum/plant_gene/trait/repeated_harvest)
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.05, /datum/reagent/ants = 0.1) //IRL jumping beans contain insect larve, hence the ants
	graft_gene = /datum/plant_gene/trait/stable_stats
	rarity = PLANT_MODERATELY_RARE

/obj/item/food/grown/jumpingbeans
	seed = /obj/item/seeds/greenbean/jump
	name = "跳豆"
	desc = "呃，是什么让它那样动的？"
	icon_state = "jumpingbean"
	foodtypes = FRUIT | BUGS
	tastes = list("bugs" = 1)
