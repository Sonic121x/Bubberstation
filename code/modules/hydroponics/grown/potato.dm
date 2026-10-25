// Potato
/obj/item/seeds/potato
	name = "马铃薯种子包"
	desc = "煮了它！捣了它！丢进炖锅里！"
	icon_state = "seed-potato"
	species = "potato"
	plantname = "马铃薯植株"
	product = /obj/item/food/grown/potato
	lifespan = 30
	maturation = 10
	production = 1
	yield = 4
	growthstages = 4
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_grow = "potato-grow"
	icon_dead = "potato-dead"
	genes = list(/datum/plant_gene/trait/soil_lover, /datum/plant_gene/trait/battery, /datum/plant_gene/trait/one_bite)
	mutatelist = list(/obj/item/seeds/potato/sweet)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)
	graft_gene = /datum/plant_gene/trait/battery

/obj/item/food/grown/potato
	seed = /obj/item/seeds/potato
	name = "马铃薯"
	desc = "煮了它！捣了它！丢进炖锅里！"
	icon_state = "potato"
	foodtypes = VEGETABLES
	distill_reagent = /datum/reagent/consumable/ethanol/vodka

/obj/item/food/grown/potato/juice_typepath()
	return /datum/reagent/consumable/potato_juice

/obj/item/food/grown/potato/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/baked_potato, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/grown/potato/wedges
	name = "马铃薯角"
	desc = "切得整整齐齐的马铃薯块。"
	icon_state = "potato_wedges"
	bite_consumption_mod = 100

/obj/item/food/grown/potato/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!tool.get_sharpness())
		return NONE
	to_chat(user, span_notice("你用 [tool] 把马铃薯切成了角。"))
	var/obj/item/food/grown/potato/wedges/slices = new /obj/item/food/grown/potato/wedges
	remove_item_from_storage(user)
	qdel(src)
	user.put_in_hands(slices)
	return ITEM_INTERACT_SUCCESS


// Sweet Potato
/obj/item/seeds/potato/sweet
	name = "红薯种子包"
	desc = "这些种子会长成红薯植株。"
	icon_state = "seed-sweetpotato"
	species = "sweetpotato"
	plantname = "红薯植株"
	product = /obj/item/food/grown/potato/sweet
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.1, /datum/reagent/consumable/sugar = 0.1, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/potato/sweet
	seed = /obj/item/seeds/potato/sweet
	name = "红薯"
	desc = "很甜。"
	icon_state = "sweetpotato"
	distill_reagent = /datum/reagent/consumable/ethanol/sbiten

/obj/item/food/grown/potato/sweet/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/yakiimo, rand(15 SECONDS, 35 SECONDS), TRUE, TRUE)
