/obj/item/satchel_of_holding_inert
	name = "惰性次元挎包"
	desc = "目前只是一块笨重的金属，上面开有一个插槽，可用来安装蓝空间异常核心。"
	icon = 'modular_skyrat/modules/holdingfashion_port/icons/storage.dmi'
	icon_state = "inertsatchel"
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/storage/backpack/holding/satchel
	custom_materials = null
	name = "次元挎包"
	desc = "一个内部通向局域蓝空间口袋的挎包。"
	icon = 'modular_skyrat/modules/holdingfashion_port/icons/storage.dmi'
	icon_state = "holdingsatchel"
	worn_icon = 'modular_skyrat/modules/holdingfashion_port/icons/back.dmi'
	worn_icon_state = "holdingsatchel"
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 7.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/duffel_of_holding_inert
	name = "惰性次元行李袋"
	desc = "目前只是一块笨重的金属，上面开有一个插槽，可用来安装蓝空间异常核心。"
	icon = 'modular_skyrat/modules/holdingfashion_port/icons/storage.dmi'
	icon_state = "inertduffel"
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/storage/backpack/holding/duffel
	custom_materials = null
	name = "次元行李袋"
	desc = "一个内部通向局域蓝空间口袋的行李袋。"
	icon = 'modular_skyrat/modules/holdingfashion_port/icons/storage.dmi'
	icon_state = "holdingduffel"
	worn_icon = 'modular_skyrat/modules/holdingfashion_port/icons/back.dmi'
	worn_icon_state = "holdingduffel"
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 7.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)
