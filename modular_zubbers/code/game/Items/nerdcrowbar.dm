/obj/item/crowbar/large/heavy/science
	name = "物理学家的撬棍"
	desc = "一根巨大的撬棍，属于某个显然想弥补什么的科学家。因为太大，所以放不进口袋。拿起来却出奇地轻……"
	force = 4 // ~3 times less
	throwforce = 12
	attack_speed = CLICK_CD_RAPID //4 times faster.

	toolspeed = 0.25
	demolition_mod = 2
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT,
		)
