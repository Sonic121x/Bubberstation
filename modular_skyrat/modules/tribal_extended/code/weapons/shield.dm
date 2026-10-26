/obj/item/shield/goliath
	name = "歌利亚盾牌"
	desc = "将歌利亚皮甲片交织而成的盾牌。"
	icon = 'modular_skyrat/modules/tribal_extended/icons/shields.dmi'
	icon_state = "goliath_shield"
	lefthand_file = 'modular_skyrat/modules/tribal_extended/icons/shields_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/tribal_extended/icons/shields_righthand.dmi'
	worn_icon = 'modular_skyrat/modules/tribal_extended/icons/back.dmi'
	worn_icon_state = "goliath_shield"
	inhand_icon_state = "goliath_shield"
	max_integrity = 200
	w_class = WEIGHT_CLASS_BULKY
	shield_break_sound = 'sound/effects/bang.ogg'
	shield_break_leftover = /obj/item/stack/sheet/animalhide/goliath_hide
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 4)
