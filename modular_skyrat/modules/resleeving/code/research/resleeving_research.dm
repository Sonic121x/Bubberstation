/datum/design/rsd_interface
	name = "共鸣模拟装置命匣"
	desc = "一种大脑接口，可从唤灵者等型号的手持共鸣模拟装置中转移共鸣。"
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
	category = list(
		RND_CATEGORY_EQUIPMENT,
	)
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/rsd_interface

