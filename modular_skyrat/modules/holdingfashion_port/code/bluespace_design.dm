/datum/design/satchel_holding
	name = "惰性次元挎包"
	desc = "一块金属，安装蓝空间异常核心后即可转变为次元挎包。"
	id = "satchel_holding"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5,
		/datum/material/bluespace =SHEET_MATERIAL_AMOUNT
		)
	build_path = /obj/item/satchel_of_holding_inert
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_BLUESPACE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/duffel_holding
	name = "惰性次元行李袋"
	desc = "一块金属，安装蓝空间异常核心后即可转变为次元行李袋。"
	id = "duffel_holding"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5,
		/datum/material/bluespace =SHEET_MATERIAL_AMOUNT
		)
	build_path = /obj/item/duffel_of_holding_inert
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_BLUESPACE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
