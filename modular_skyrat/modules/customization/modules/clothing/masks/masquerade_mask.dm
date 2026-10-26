/obj/item/clothing/mask/masquerade
	name = "化装舞会面具"
	desc = "你绝对猜不出面具下是谁，这是完美的伪装！"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/masquerade"
	post_init_icon_state = "maskerade"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/mask/masquerade_mask_worn.dmi'
	flags_1 = IS_PLAYER_COLORABLE_1
	clothing_flags = MASKINTERNALS
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION | CLOTHING_SNOUTED_VOX_VARIATION | CLOTHING_SNOUTED_BETTER_VOX_VARIATION
	greyscale_colors = "#ececec#333333#9b1e1e"
	greyscale_config = /datum/greyscale_config/masquerade_mask
	greyscale_config_worn = /datum/greyscale_config/masquerade_mask/worn
	greyscale_config_worn_muzzled = /datum/greyscale_config/masquerade_mask/worn/snouted
	greyscale_config_worn_better_vox = /datum/greyscale_config/masquerade_mask/worn/better_vox
	greyscale_config_worn_vox = /datum/greyscale_config/masquerade_mask/worn/vox
	greyscale_config_worn_teshari = /datum/greyscale_config/masquerade_mask/worn/teshari

/obj/item/clothing/mask/masquerade/feathered
	name = "羽饰化装舞会面具"
	desc = "你绝对猜不出面具下是谁，这是完美的伪装！这一款还带一根羽毛，更加华丽！"
	post_init_icon_state = "maskerade_feather"

/obj/item/clothing/mask/masquerade/two_colors
	name = "双色化装舞会面具"
	desc = "你绝对猜不出面具下是谁，这是完美的伪装！甚至还用了两种颜色，让迷惑效果更上一层楼！"
	post_init_icon_state = "maskerade_two_colors"

/obj/item/clothing/mask/masquerade/two_colors/feathered
	name = "羽饰双色化装舞会面具"
	desc = "你绝对猜不出面具下是谁，这是完美的伪装！甚至有两种颜色外加一根羽毛，堪称迄今最华丽的化装舞会面具！"
	post_init_icon_state = "maskerade_two_colors_feather"
