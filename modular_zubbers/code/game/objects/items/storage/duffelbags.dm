/obj/item/storage/backpack/hydro_duffel //No zipping or slowdown on this one, it's a duffelbag in name only
	name = "古老大气之神行李袋"
	desc = "用金属氢加固的超大行李袋，兼具坚固与轻便。尖端拉链永不卡住，让携带者能立刻取用袋中物品。"
	icon = 'modular_zubbers/icons/obj/clothing/back/backpack.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/back/backpack.dmi'
	icon_state = "duffel-hydro"
	inhand_icon_state = "duffel-hydro"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/backpack_righthand.dmi'
	storage_type = /datum/storage/hydro_duffel
	resistance_flags = FIRE_PROOF
	custom_materials = list(/datum/material/metalhydrogen = SHEET_MATERIAL_AMOUNT * 2)

/datum/storage/hydro_duffel
	max_total_storage = 35
	max_slots = 25
