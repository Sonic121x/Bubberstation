/obj/item/clothing/under/scarl
	name = "SCAR-L的制服"
	desc = "只是一套制服……"
	icon = 'modular_z121/icons/scar-l/scarl.dmi'
	icon_state = "scar_uniform"
	worn_icon = 'modular_z121/icons/scar-l/scarlworn.dmi'
	worn_icon_state = "scar_uniform"
	armor_type = /datum/armor/scarl

/datum/armor/scarl
	melee = 0
	bullet = 0
	laser = 0
	energy = 0
	bio = 10
	bomb = 0
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/suit/armor/scarl
	name = "SCAR-L的外套"
	desc = "SCAR-L的装甲外套，内衬防弹填充物，并采用防刺面料。"
	icon = 'modular_z121/icons/scar-l/scarl.dmi'
	icon_state = "scar_coat"
	worn_icon = 'modular_z121/icons/scar-l/scarl.dmi'
	worn_icon_state = "scar_coat_w"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor_type = /datum/armor/scarl/coat ///datum/armor/none

/datum/armor/scarl/coat
	melee = 30//25
	bullet = 20//25
	laser = 10
	energy = 20//30
	bomb = 70//20
	fire = 50
	acid = 50
	wound = 20

/obj/item/clothing/suit/armor/scarl/unarmored
	desc = "SCAR-L的装甲外套。"
	armor_type = /datum/armor/none

/datum/crafting_recipe/scarl
	name = "改装SCAR-L的外套"
	result = /obj/item/clothing/suit/armor/scarl
	reqs = list(
		/obj/item/clothing/suit/armor/scarl/unarmored = 1,
		/obj/item/forging/complete/chain = 5,
		)
	time = 3 SECONDS
	category = CAT_CLOTHING
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY


/obj/item/storage/belt/military/scarl
	name = "SCAR-L的斜挎包"
	desc = "SCAR-L的斜挎包，里面通常装着许许多多有趣的东西。"
	icon = 'modular_z121/icons/scar-l/scarl.dmi'
	icon_state = "scar_bag"
	worn_icon = 'modular_z121/icons/scar-l/scarl.dmi'
	worn_icon_state = "scar_bag_w"

/obj/item/clothing/head/scarl
	name = "SCAR-L的针织帽"
	desc = "SCAR-L的针织帽，像太阳一样驱散寒意。"
	icon = 'modular_z121/icons/scar-l/scarl.dmi'
	icon_state = "scar_hat_alt"
	worn_icon = 'modular_z121/icons/scar-l/scarl.dmi'
	worn_icon_state = "scar_hat_alt_w"
	armor_type = /datum/armor/scarl/coat

/obj/item/clothing/head/scarl/unarmored
	armor_type = /datum/armor/none

/datum/crafting_recipe/scarlhat
	name = "改装SCAR-L的针织帽"
	result = /obj/item/clothing/head/scarl
	reqs = list(
		/obj/item/clothing/head/scarl/unarmored = 1,
		/obj/item/forging/complete/chain = 3,
		)
	time = 3 SECONDS
	category = CAT_CLOTHING
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

/obj/item/clothing/shoes/jackboots/scarl
	name = "SCAR-L的靴子"
	desc = "SCAR-L的靴子，可以藏一把刀。"
	icon = 'modular_z121/icons/scar-l/scarl.dmi'
	icon_state = "scar_boots"
	worn_icon = 'modular_z121/icons/scar-l/scarl.dmi'
	worn_icon_state = "scar_boots_w"

/obj/item/clothing/neck/scarl
	name = "SCAR-L的围巾"
	desc = "SCAR-L的围巾……"
	icon = 'modular_z121/icons/scar-l/scarl.dmi'
	icon_state = "scar_scarf_alt"
	worn_icon = 'modular_z121/icons/scar-l/scarl.dmi'
	worn_icon_state = "scar_scarf_alt_w"
