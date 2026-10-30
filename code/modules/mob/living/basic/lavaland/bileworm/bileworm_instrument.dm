/obj/item/instrument/bilehorn
	name = "胆汁号角"
	desc = "把胆汁虫的身体零件重新拼装而成，能奏出美妙的音乐而非胆汁。名字倒是留了下来，因为作为乐器，它确实相当恶心。"
	force = 5
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "bilehorn"
	allowed_instrument_ids = "bilehorn"
	inhand_icon_state = null
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 8, /datum/material/bone = SHEET_MATERIAL_AMOUNT * 2)

/datum/crafting_recipe/bilehorn
	name = "胆汁号角"
	reqs = list(
		/obj/item/stack/sheet/animalhide/bileworm = 4,
		/obj/item/stack/sheet/bone = 2,
		/obj/item/crusher_trophy/bileworm_spewlet = 1,
	)
	result = /obj/item/instrument/bilehorn
	category = CAT_ENTERTAINMENT
