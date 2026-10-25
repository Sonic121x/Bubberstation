// Tribal undershirt accessories, made from bone or sinew.
/obj/item/clothing/accessory/talisman
	name = "骨制护符"
	desc = "猎人的护符，有人说旧日神明会对佩戴者微笑。"
	icon_state = "talisman"
	attachment_slot = NONE
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/clothing/accessory/skullcodpiece
	name = "骷髅护裆"
	desc = "一个骷髅形状的装饰品，意在保护生命中最重要的东西。"
	icon_state = "skull"
	attachment_slot = GROIN
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/clothing/accessory/skilt
	name = "腱制短裙"
	desc = "最后再说一次。这是苏格兰裙，不是裙子。"
	icon_state = "skilt"
	minimize_when_attached = FALSE
	attachment_slot = GROIN
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)
