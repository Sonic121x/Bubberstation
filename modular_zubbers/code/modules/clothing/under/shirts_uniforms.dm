/obj/item/clothing/under/greyscale
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/greyscale_clothing.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/greyscale_clothing_digi.dmi'
	// Defaults to FALSE for this type because greyscale items are less commonly adjustable
	can_adjust = FALSE

/*
*	This file is for things that are recolorable and/or mix-and-match. Things like Jeans, T-Shirts, Skirts.
*	Basically the hope is that items here will reuse component icons that already exist in the .dmis where possible.
*
*	(Do not put items here that are too specific. These should generally be generic, customizable uniforms.)
*	These will likely fit in the CASUALWEAR loadout category.
*/

/obj/item/clothing/under/greyscale/turtleneck
	name = "高领衫配长裤"
	desc = "一件相当舒适的高领衫，搭配长裤。这才叫够强劲的衣料。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/turtleneck"
	post_init_icon_state = "turtleneck"
	greyscale_config = /datum/greyscale_config/turtlenecks
	greyscale_config_worn = /datum/greyscale_config/turtlenecks/worn
	greyscale_config_worn_digi = /datum/greyscale_config/turtlenecks/worn/digi
	greyscale_colors = "#787878#252525"
	can_adjust = TRUE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/greyscale/turtleneck/skirt
	name = "高领衫配短裙"
	desc = "一件相当舒适的高领衫，搭配短裙。要是你愿意，也可以叫它“裙领衫”。"
	icon_state = "/obj/item/clothing/under/greyscale/turtleneck/skirt"
	post_init_icon_state = "skirtleneck"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/greyscale/gorkas
	name = "戈尔卡连体服"
	desc = "一件还算舒适的戈尔卡套服，和普通连体服一样舒服，但设计更独特。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/gorkas"
	post_init_icon_state = "gags_gorka"
	greyscale_config = /datum/greyscale_config/gorkas
	greyscale_config_worn = /datum/greyscale_config/gorkas/worn
	greyscale_config_worn_digi = /datum/greyscale_config/gorkas/worn/digi
	greyscale_colors = "#787878#252525"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/greyscale/overalls
	name = "高领衫配背带裤"
	desc = "高领衫外穿背带裤。这套组合既舒适又有遮盖……至少遮盖是有的。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/overalls"
	post_init_icon_state = "overalls"
	greyscale_config = /datum/greyscale_config/sus_overalls
	greyscale_config_worn = /datum/greyscale_config/sus_overalls/worn
	greyscale_config_worn_digi = /datum/greyscale_config/sus_overalls/worn/digi
	greyscale_colors = "#787878#252525#CCCED1"
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = TRUE

/obj/item/clothing/under/greyscale/overalls/skirt
	name = "高领衫配背带短裙"
	desc = "高领衫外穿背带短裙。这套组合既舒适又有遮盖……至少——不，等等，这两样其实都没有。"
	icon_state = "/obj/item/clothing/under/greyscale/overalls/skirt"
	post_init_icon_state = "overalls_skirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/greyscale/playsuit
	name = "连身运动装"
	desc = "为了对这项运动的热爱。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/playsuit"
	post_init_icon_state = "playsuit"
	greyscale_config = /datum/greyscale_config/playsuit
	greyscale_config_worn = /datum/greyscale_config/playsuit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/playsuit/worn/digi
	greyscale_colors = "#787878#252525#CCCED1#787878"
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = FALSE

/obj/item/clothing/under/pants/camo
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/camo"
	post_init_icon_state = "camopants"
	greyscale_config = /datum/greyscale_config/camo_pants
	greyscale_config_worn = /datum/greyscale_config/camo_pants/worn
	greyscale_config_worn_digi = /datum/greyscale_config/camo_pants/worn/digi
	greyscale_colors = "#69704C#6E5B4C#343741"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/pants/greyscale/big_pants
	name = "\improper JUNCO 超大工装裤"
	desc = "对技术古典主义者而言这是必备款，这种极限宽腿裤每隔一阵就会重新流行起来。 \
		这一条还带有充裕的内置储物空间。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/greyscale/big_pants"
	post_init_icon_state = "big_pants"
	greyscale_config = /datum/greyscale_config/big_pants
	greyscale_config_worn = /datum/greyscale_config/big_pants/worn
	greyscale_config_worn_digi = /datum/greyscale_config/big_pants/worn/digi
	greyscale_colors = "#874f16"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = LOW_FACEMASK_LAYER

/obj/item/clothing/under/pants/greyscale/loose_pants
	name = "宽松长裤"
	desc = "一条宽松的长裤，腰带看起来很舒服。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/greyscale/loose_pants"
	post_init_icon_state = "loose_pants"
	greyscale_config = /datum/greyscale_config/loose_pants
	greyscale_config_worn = /datum/greyscale_config/loose_pants/worn
	greyscale_colors = "#4d4d4d#666633#c0c0c0"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = LOW_FACEMASK_LAYER

/obj/item/clothing/under/pants/greyscale/wide_leg
	name = "宽腿长裤"
	desc = "一条透气的宽腿长裤，腰线相当高。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/greyscale/wide_leg"
	post_init_icon_state = "wide_leg"
	greyscale_config = /datum/greyscale_config/wide_leg //The naming conventions behind the icons/configs here are a travesty, and I'm very sorry.
	greyscale_config_worn = /datum/greyscale_config/wide_leg/worn	//It will happen again.
	greyscale_config_worn_digi = /datum/greyscale_config/wide_leg/worn/digi
	greyscale_colors = "#ba917d"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = LOW_FACEMASK_LAYER
