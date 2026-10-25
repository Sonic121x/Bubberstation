/obj/item/clothing/head/costume/crown
	name = "王冠"
	desc = "一顶配得上国王的王冠，也许只是个小小国王。"
	icon_state = "crown"
	armor_type = /datum/armor/costume_crown
	resistance_flags = FIRE_PROOF
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5)

/datum/armor/costume_crown
	melee = 15
	energy = 10
	fire = 100
	acid = 50
	wound = 5

/obj/item/clothing/head/costume/crown/fancy
	name = "华丽王冠"
	desc = "只有 <s>陆地</s> 太空 的至高皇帝才会佩戴的王冠。"
	icon_state = "fancycrown"
