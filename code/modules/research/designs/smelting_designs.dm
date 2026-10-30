///////SMELTABLE ALLOYS///////

/datum/design/alloy
	abstract_type = /datum/design/alloy
	build_type = SMELTER | PROTOLATHE | AWAY_LATHE
	category = list(
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MATERIALS
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING
	//The resulting alloy sheets have different material types, but can be deconstructed back to their base mats with a recycler iirc.
	inherit_materials = DESIGN_DONT_INHERIT_MATS

/datum/design/alloy/plasteel_alloy
	name = "塑钢"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/plasteel

/datum/design/alloy/plastitanium
	name = "塑钛"
	materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/mineral/plastitanium

/datum/design/alloy/plaglass
	name = "等离子玻璃"
	materials = list(/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/plasmaglass

/datum/design/alloy/plasmarglass
	name = "强化等离子玻璃"
	materials = list(/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,  /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/plasmarglass

/datum/design/alloy/titaniumglass
	name = "钛玻璃"
	materials = list(/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/titaniumglass

/datum/design/alloy/plastitaniumglass
	name = "塑钛玻璃"
	materials = list(/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/plastitaniumglass

/datum/design/alloy/alien
	name = "异形合金"
	desc = "一片逆向工程得到的异形合金。"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/stack/sheet/mineral/abductor
