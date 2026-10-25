/obj/item/clothing/head/mod
	name = "MOD 头盔"
	desc = "MOD 外骨骼的头盔。"
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "standard-helmet"
	base_icon_state = "helmet"
	worn_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	armor_type = /datum/armor/none
	body_parts_covered = HEAD
	heat_protection = HEAD
	cold_protection = HEAD

// Even without a hat stabilizer, hats can be worn - however, they'll fall off very easily
/obj/item/clothing/head/mod/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_SPEED_POTION, INNATE_TRAIT)
	AddComponent(/datum/component/hat_stabilizer, loose_hat = TRUE)

/obj/item/clothing/suit/mod
	name = "MOD 胸甲"
	desc = "MOD 外骨骼的胸甲。"
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "standard-chestplate"
	base_icon_state = "chestplate"
	worn_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	blood_overlay_type = "armor"
	allowed = list(
		/obj/item/tank/internals,
		/obj/item/flashlight,
		/obj/item/tank/jetpack/captain,
	)
	armor_type = /datum/armor/none
	body_parts_covered = CHEST|GROIN
	heat_protection = CHEST|GROIN
	cold_protection = CHEST|GROIN
	drop_sound = null

/obj/item/clothing/suit/mod/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_SPEED_POTION, INNATE_TRAIT)

/obj/item/clothing/gloves/mod
	name = "MOD 护手"
	desc = "MOD 外骨骼的一副护手。"
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "standard-gauntlets"
	base_icon_state = "gauntlets"
	worn_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	armor_type = /datum/armor/none
	body_parts_covered = HANDS|ARMS
	heat_protection = HANDS|ARMS
	cold_protection = HANDS|ARMS
	equip_sound = null
	pickup_sound = null
	drop_sound = null

/obj/item/clothing/gloves/mod/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_SPEED_POTION, INNATE_TRAIT)

/obj/item/clothing/shoes/mod
	name = "MOD 靴子"
	desc = "MOD 外骨骼的一双靴子。"
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "standard-boots"
	base_icon_state = "boots"
	worn_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	armor_type = /datum/armor/none
	body_parts_covered = FEET|LEGS
	heat_protection = FEET|LEGS
	cold_protection = FEET|LEGS
	item_flags = IGNORE_DIGITIGRADE
	fastening_type = SHOES_SLIPON
	equip_sound = null

/obj/item/clothing/shoes/mod/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_SPEED_POTION, INNATE_TRAIT)

/obj/item/clothing/glasses/mod
	name = "MOD 眼镜"
	desc = "MOD 外骨骼的一副眼镜。"
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "standard-glasses"
	base_icon_state = "glasses"
	worn_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	armor_type = /datum/armor/none
	equip_sound = null
	pickup_sound = null
	drop_sound = null

/obj/item/clothing/glasses/mod/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_SPEED_POTION, INNATE_TRAIT)

/obj/item/clothing/neck/mod
	name = "MOD 领带"
	desc = "MOD 外骨骼的领带。"
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "standard-tie"
	base_icon_state = "tie"
	worn_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	armor_type = /datum/armor/none
	equip_sound = null
	pickup_sound = null
	drop_sound = null

/obj/item/clothing/neck/mod/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_SPEED_POTION, INNATE_TRAIT)
