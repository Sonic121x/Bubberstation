/obj/item/clothing/glasses/hud/civilian
	name = "民用 HUD 眼镜"
	desc = "一种平视显示器，可扫描周围的人形生物并显示他们的身份卡状态。专家称其用途远超 9000 种。"
	icon = 'modular_zubbers/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/eyes.dmi'
	icon_state = "civhud"
	clothing_traits = list(TRAIT_SECURITY_HUD_ID_ONLY) //thanks honkbots for having that


/obj/item/clothing/glasses/hud/civilian/sunglasses
	name = "民用 HUD 太阳镜"
	desc = "带有民用 HUD 的太阳镜。"
	icon = 'modular_zubbers/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/eyes.dmi'
	icon_state = "sunhudciv"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.55)

/obj/item/clothing/glasses/hud/security
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/eyes_teshari.dmi'

/obj/item/clothing/glasses/hud/diagnostic
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/eyes_teshari.dmi'

/obj/item/clothing/glasses/science
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/eyes_teshari.dmi'

/obj/item/clothing/glasses/meson/engine
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/eyes_teshari.dmi'

/obj/item/clothing/glasses/hud/security/sunglasses/guard
	greyscale_config_worn_teshari = /datum/greyscale_config/guard_hudsunglasses/worn/teshari
