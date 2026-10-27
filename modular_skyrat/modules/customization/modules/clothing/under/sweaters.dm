/obj/item/clothing/under/sweater
	name = "绞花针织毛衣"
	desc = "为什么要为了舒适牺牲风格？现在你下半身可以什么都不穿，上半身依旧暖和。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/sweater"
	post_init_icon_state = "cableknit_sweater"
	greyscale_config = /datum/greyscale_config/cableknit_sweater
	greyscale_config_worn = /datum/greyscale_config/cableknit_sweater/worn
	greyscale_colors = "#b2a484"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = TRUE
	flags_1 = IS_PLAYER_COLORABLE_1
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/sweater/black
	name = "黑色绞花针织毛衣"
	icon_state = "/obj/item/clothing/under/sweater/black"
	greyscale_colors = "#4f4f4f"

/obj/item/clothing/under/sweater/red
	name = "红色绞花针织毛衣"
	icon_state = "/obj/item/clothing/under/sweater/red"
	greyscale_colors = "#9a0000"

/obj/item/clothing/under/sweater/keyhole
	name = "钥匙孔毛衣"
	desc = "让我理理清楚。他们把一件本该保暖的衣服挖了个露乳沟的洞……为什么？“现在你下半身可以什么都不穿，胸口却冻得冰凉”可不是什么好口号！"
	icon_state = "/obj/item/clothing/under/sweater/keyhole"
	post_init_icon_state = "keyhole_sweater"
	greyscale_colors = "#c5699c"
