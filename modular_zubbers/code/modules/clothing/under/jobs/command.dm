/obj/item/clothing/under/rank/civilian/head_of_personnel/stripper
	desc = "这是一套暴露的蓝色脱衣舞服装，配有金色纹饰，无论配给人事主管还是舰长都很合适。严格来说未经纳米传讯批准，如今配备了 Pycroft 多彩颜料技术。"
	name = "指挥级脱衣舞制服"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/civilian/head_of_personnel/stripper"
	post_init_icon_state = "cso"
	greyscale_config = /datum/greyscale_config/cso
	greyscale_config_worn = /datum/greyscale_config/cso/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/captain.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/captain.dmi'
	greyscale_colors = "#081027#41579a#c06822"

	can_adjust = FALSE

/obj/item/clothing/under/rank/civilian/head_of_personnel/stripper/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/rank/nanotrasen_consultant/stripper
	desc = "这是一套绿色脱衣舞服装，配有金色纹饰，标明了“纳米传讯顾问”的头衔。严格来说未经纳米传讯批准，如今配备了 Pycroft 多彩颜料技术。"
	name = "顾问的脱衣舞制服"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/nanotrasen_consultant/stripper"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/captain.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/captain.dmi'
	greyscale_config = /datum/greyscale_config/cso
	greyscale_config_worn = /datum/greyscale_config/cso/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	post_init_icon_state = "cso"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	greyscale_colors = "#081027#46b946#e6b917"

	can_adjust = FALSE

/obj/item/clothing/under/rank/nanotrasen_consultant/stripper/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/rank/captain
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/command_teshari.dmi'

/obj/item/clothing/under/rank/blueshield
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/command_teshari.dmi'

/obj/item/clothing/under/rank/civilian/head_of_personnel
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/civilian_teshari.dmi'

/obj/item/clothing/under/rank/bridge_assistant
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/command_teshari.dmi'
