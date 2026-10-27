//Basetype

/obj/item/clothing/suit/crop_jacket
	name = "露脐夹克"
	desc = "这件夹克在很久以前大概是件相当好用的户外装备。而现在， \
		某个野蛮人把整条下半截都剪掉了。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/crop_jacket"
	post_init_icon_state = "crop_jacket"
	greyscale_config = /datum/greyscale_config/crop_jacket
	greyscale_config_worn = /datum/greyscale_config/crop_jacket/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/crop_jacket/worn/teshari
	greyscale_colors = "#ebebeb#a52f29#292929"
	body_parts_covered = CHEST|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/crop_jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/crop_jacket/shortsleeve
	name = "短袖露脐夹克"
	desc = "这件夹克在很久以前大概是件相当好用的户外装备。而现在， \
		某个野蛮人把整条下半截连同一半袖子都剪掉了。"
	icon_state = "/obj/item/clothing/suit/crop_jacket/shortsleeve"
	post_init_icon_state = "crop_jacket_short"
	greyscale_config = /datum/greyscale_config/shortsleeve_crop_jacket
	greyscale_config_worn = /datum/greyscale_config/shortsleeve_crop_jacket/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/shortsleeve_crop_jacket/worn/teshari

/obj/item/clothing/suit/crop_jacket/sleeveless
	name = "无袖露脐夹克"
	desc = "这件夹克在很久以前大概是件相当好用的户外装备。而现在， \
		某个野蛮人把整条下半截连同袖子都剪掉了。"
	icon_state = "/obj/item/clothing/suit/crop_jacket/sleeveless"
	post_init_icon_state = "crop_jacket_sleeveless"
	greyscale_config = /datum/greyscale_config/sleeveless_crop_jacket
	greyscale_config_worn = /datum/greyscale_config/sleeveless_crop_jacket/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/sleeveless_crop_jacket/worn/teshari
	greyscale_colors = "#ebebeb#a52f29"
	body_parts_covered = CHEST

/obj/item/clothing/suit/crop_jacket/long
	name = "运动夹克"
	desc = "一件大概是件相当好用的户外装备的夹克。"
	icon_state = "/obj/item/clothing/suit/crop_jacket/long"
	post_init_icon_state = "jacket"

/obj/item/clothing/suit/crop_jacket/shortsleeve/long
	name = "短袖运动夹克"
	desc = "这件夹克大概是件相当好用的户外装备。然而， \
		某个野蛮人把袖子剪掉了一半。"
	icon_state = "/obj/item/clothing/suit/crop_jacket/shortsleeve/long"
	post_init_icon_state = "jacket_short"

/obj/item/clothing/suit/crop_jacket/sleeveless/long
	name = "无袖运动夹克"
	desc = "这件夹克大概是件相当好用的户外装备。然而， \
		某个野蛮人把袖子剪掉了。"
	icon_state = "/obj/item/clothing/suit/crop_jacket/sleeveless/long"
	post_init_icon_state = "jacket_sleeveless"
