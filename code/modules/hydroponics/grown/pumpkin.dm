// Pumpkin
/obj/item/seeds/pumpkin
	name = "南瓜种子包"
	desc = "这些种子会长成南瓜藤。"
	icon_state = "seed-pumpkin"
	plant_icon_offset = 4
	species = "pumpkin"
	plantname = "南瓜藤"
	product = /obj/item/food/grown/pumpkin
	lifespan = 50
	endurance = 40
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	icon_grow = "pumpkin-grow"
	icon_dead = "pumpkin-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/pumpkin/blumpkin)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.2)

/obj/item/food/grown/pumpkin
	seed = /obj/item/seeds/pumpkin
	name = "南瓜"
	desc = "它又大又吓人。"
	icon_state = "pumpkin"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	wine_power = 20
	///Which type of lantern this gourd produces when carved.
	var/carved_type = /obj/item/clothing/head/utility/hardhat/pumpkinhead

/obj/item/food/grown/pumpkin/juice_typepath()
	return /datum/reagent/consumable/pumpkinjuice

/obj/item/food/grown/pumpkin/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!tool.get_sharpness())
		return NONE

	to_chat(user, span_notice("你在 [src] 上刻出一张脸！"))
	new carved_type(user.loc)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

// Blumpkin
/obj/item/seeds/pumpkin/blumpkin
	name = "蓝瓜种子包"
	desc = "这些种子会长成蓝瓜藤。"
	icon_state = "seed-blumpkin"
	species = "blumpkin"
	plantname = "蓝瓜藤"
	product = /obj/item/food/grown/pumpkin/blumpkin
	mutatelist = null
	reagents_add = list(/datum/reagent/ammonia = 0.2, /datum/reagent/chlorine = 0.1, /datum/reagent/consumable/nutriment = 0.2)
	rarity = PLANT_MODERATELY_RARE

/obj/item/food/grown/pumpkin/blumpkin
	seed = /obj/item/seeds/pumpkin/blumpkin
	name = "蓝瓜"
	desc = "南瓜的有毒兄弟。"
	icon_state = "blumpkin"
	bite_consumption_mod = 3
	wine_power = 50
	carved_type = /obj/item/clothing/head/utility/hardhat/pumpkinhead/blumpkin

/obj/item/food/grown/pumpkin/blumpkin/juice_typepath()
	return /datum/reagent/consumable/blumpkinjuice
