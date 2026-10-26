/obj/item/gun/ballistic/bow/tribalbow
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	lefthand_file = 'modular_skyrat/modules/tribal_extended/icons/bows_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/tribal_extended/icons/bows_righthand.dmi'
	worn_icon = 'modular_skyrat/modules/tribal_extended/icons/back.dmi'
	inhand_icon_state = "bow"
	icon_state = null
	base_icon_state = "bow"
	worn_icon_state = "bow"
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 0.5
	force = 20

/obj/item/gun/ballistic/bow/tribalbow/update_icon()
	. = ..()
	icon_state = "[base_icon_state][drawn ? "_drawn" : ""]"

/obj/item/gun/ballistic/bow/tribalbow/update_overlays()
	. = ..()
	if(chambered)
		. += "[chambered.base_icon_state][drawn ? "_drawn" : ""]"


/obj/item/gun/ballistic/bow/tribalbow/ashen
	name = "骨弓"
	desc = "用骨头和缠绕的筋腱制成的原始远程武器，结实得出奇。"
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	icon_state = "ashenbow"
	base_icon_state = "ashenbow"
	inhand_icon_state = "ashenbow"
	worn_icon_state = "ashenbow"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 4)

/obj/item/gun/ballistic/bow/tribalbow/pipe
	name = "管制弓"
	desc = "轻便流畅，不过拿根泳池浮力棒打人可能效果更好。"
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	icon_state = "pipebow"
	base_icon_state = "pipebow"
	worn_icon_state = "pipebow"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5)
