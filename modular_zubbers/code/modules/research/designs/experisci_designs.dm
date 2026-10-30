/datum/design/experi_scanner/bluespace
	name = "蓝空间实验扫描仪"
	desc = "一种实验扫描仪的变体，可远程执行实验扫描。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT*2.5)
	build_path = /obj/item/experi_scanner/bluespace
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
