/obj/item/clothing/head/utility/welding/hat
	name = "焊工帽"
	desc = "贴合头部的鸭舌帽，配有宽大的焊接面罩。"
	worn_icon = 'modular_skyrat/modules/tarkon/icons/mob/clothing/head.dmi'
	icon = 'modular_skyrat/modules/tarkon/icons/obj/clothing/head.dmi'
	icon_state = "welderhat"
	inhand_icon_state = "" //no unique inhands
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	custom_materials = list(/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT*1.75, /datum/material/glass=SMALL_MATERIAL_AMOUNT * 4)
	flash_protect = FLASH_PROTECTION_WELDER
	tint = 2
	armor_type = /datum/armor/utility_welding
	flags_inv = HIDEEARS|HIDEEYES
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_inv = HIDEEARS|HIDEEYES
	visor_flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/utility/welding/hat/Initialize(mapload)
	. = ..()
	visor_toggling()
