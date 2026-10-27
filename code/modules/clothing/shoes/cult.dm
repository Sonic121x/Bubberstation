/obj/item/clothing/shoes/cult
	name = "\improper 纳尔西靴"
	desc = "纳尔西的追随者所穿的一双靴子。"
	icon_state = "cult"
	inhand_icon_state = null
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT
	lace_time = 10 SECONDS

/obj/item/clothing/shoes/cult/alt
	name = "\improper 纳尔西召唤者靴"
	icon_state = "cultalt"

/obj/item/clothing/shoes/cult/alt/ghost
	item_flags = DROPDEL

/obj/item/clothing/shoes/cult/alt/ghost/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CULT_TRAIT)
