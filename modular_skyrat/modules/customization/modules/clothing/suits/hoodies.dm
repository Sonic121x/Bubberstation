/*
*	The hoodies and attached sprites [WERE ORIGINALLY FROM] https://github.com/Citadel-Station-13/Citadel-Station-13-RP before GAGSification
*	Respective datums can be found in modular_skyrat/modules/customization/datums/greyscale/hoodies
*	These are now a subtype of toggle/jacket too, so it properly toggles and isnt the unused 'storage' type
*/

/obj/item/clothing/suit/toggle/jacket/hoodie
	name = "连帽衫"
	desc = "一件暖和的连帽衫。你忍不住总想摆弄拉链……"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie"
	post_init_icon_state = "hoodie"
	greyscale_config = /datum/greyscale_config/hoodie
	greyscale_config_worn = /datum/greyscale_config/hoodie/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	min_cold_protection_temperature = T0C - 20	//Not as good as the base jacket

/obj/item/clothing/suit/toggle/jacket/hoodie/trim
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/trim"
	post_init_icon_state = "hoodie_trim"
	greyscale_config = /datum/greyscale_config/hoodie_trim
	greyscale_config_worn = /datum/greyscale_config/hoodie_trim/worn
	greyscale_colors = "#ffffff#313131"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/jacket/hoodie/trim/alt
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/trim/alt"
	post_init_icon_state = "hoodie_trim_alt"
	greyscale_colors = "#ffffff#313131"
	flags_1 = IS_PLAYER_COLORABLE_1

/*
*	PRESET GREYSCALES & BRANDED
*/

/obj/item/clothing/suit/toggle/jacket/hoodie/grey
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/grey"
	greyscale_colors = "#a8a8a8"

/obj/item/clothing/suit/toggle/jacket/hoodie/black
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/black"
	greyscale_colors = "#313131"

/obj/item/clothing/suit/toggle/jacket/hoodie/red
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/red"
	greyscale_colors = "#D13838"

/obj/item/clothing/suit/toggle/jacket/hoodie/blue
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/blue"
	greyscale_colors = "#034A8D"

/obj/item/clothing/suit/toggle/jacket/hoodie/green
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/green"
	greyscale_colors = "#1DA103"

/obj/item/clothing/suit/toggle/jacket/hoodie/orange
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/orange"
	greyscale_colors = "#F79305"

/obj/item/clothing/suit/toggle/jacket/hoodie/yellow
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/yellow"
	greyscale_colors = "#F0D655"

/obj/item/clothing/suit/toggle/jacket/hoodie/branded
	name = "纳米传讯连帽衫"
	desc = "一件暖和的蓝色卫衣。背后自豪地印着银色的纳米传讯徽标字样。边缘饰有银色滚边。"
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/branded"
	post_init_icon_state = "hoodie_NT"
	greyscale_config = /datum/greyscale_config/hoodie_branded
	greyscale_config_worn = /datum/greyscale_config/hoodie_branded/worn
	greyscale_colors = "#02519A#ffffff"	//white to prevent changing the actual color of the icon. I've no clue why it REQUIRES two inputs despite being set otherwise.
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/hoodie/branded/nrti
	name = "新雷克雅未克理工学院连帽衫"
	desc = "一件暖和的灰色卫衣。背后印有“NRT”字样，指的是西芙星首屈一指的理工学院。"
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/branded/nrti"
	post_init_icon_state = "hoodie_NRTI"
	greyscale_colors = "#747474#a83232"

/obj/item/clothing/suit/toggle/jacket/hoodie/branded/mu
	name = "莫哈韦大学连帽衫"
	desc = "一件暖和的灰色卫衣。正面印有“MU”字样，指的是那所著名的公立学院——莫哈韦大学。"
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/branded/mu"
	post_init_icon_state = "hoodie_MU"
	greyscale_colors = "#747474#ffffff"


/obj/item/clothing/suit/toggle/jacket/hoodie/branded/cti
	name = "CTI 连帽衫"
	desc = "一件暖和的黑色卫衣。背后印有“CTI”字样，指的是位于天仓五的著名学府——天仓技术学院。正面绣着一颗蓝色超新星，那是 CTI 的校徽。"
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/branded/cti"
	post_init_icon_state = "hoodie_CTI"
	greyscale_colors = "#313131#ffffff"

/obj/item/clothing/suit/toggle/jacket/hoodie/branded/smw
	name = "太空山风连帽衫"
	desc = "一件暖和的黑色卫衣。正面和背面都印有流行汽水“太空山风”的标志。"
	icon_state = "/obj/item/clothing/suit/toggle/jacket/hoodie/branded/smw"
	post_init_icon_state = "hoodie_SMW"
	greyscale_colors = "#313131#ffffff"
