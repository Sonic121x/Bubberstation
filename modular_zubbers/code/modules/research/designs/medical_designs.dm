/datum/design/empathic_sensor
	name = "共情传感器植入体"
	desc = "一种能让人直觉感知他人想法的植入体。"
	id = "ci_empathic_sensor"
	build_type = PROTOLATHE | MECHFAB
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
		)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/organ/cyberimp/brain/empathic_sensor
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE


/datum/design/internal_wound_scanner
	name = "内置伤口分析芯片"
	desc = "一种植入大脑的伤口分析芯片。"
	id = "wound_scanner_internal"
	build_type = PROTOLATHE | MECHFAB
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
		)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/organ/cyberimp/brain/wound_scanner
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

//////////Medical Lathe Designs////////////

/datum/design/surgical_processor
	name = "手术处理器"
	id = "surgical_processor"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
		)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/surgical_processor
	category = list(
	RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/defibrillator
	name = "除颤器"
	desc = "一台便携式除颤器，用于抢救刚去世的船员。"
	id = "defibrillator"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/defibrillator
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver =SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
