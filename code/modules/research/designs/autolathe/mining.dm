// Autolathe-able circuitboards for starting with boulder processing machines.
/datum/design/board/smelter
	name = "巨石熔炼炉电路板"
	desc = "巨石熔炼炉的电路板。技术含量很低，可以直接用车床打印。"
	build_type = AUTOLATHE
	materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/circuitboard/machine/smelter
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/refinery
	name = "巨石精炼机电路板"
	desc = "巨石精炼机的电路板。技术含量很低，可以直接用车床打印。"
	build_type = AUTOLATHE
	materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/circuitboard/machine/refinery
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO
