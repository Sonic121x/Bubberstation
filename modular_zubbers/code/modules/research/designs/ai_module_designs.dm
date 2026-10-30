/datum/design/board/crewimov
	name = "“船员西莫夫”模块"
	desc = "可用于建造“船员西莫夫”AI 核心模块。当理智占上风时就用它。"
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ai_module/law/core/full/crewsimov
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/crewimovpp
	name = "“船员西莫夫++”模块"
	desc = "可用于建造“船员西莫夫++”AI 核心模块。"
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ai_module/law/core/full/crewsimovpp
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/ntosthree
	name = "NTOS V3.0 模块"
	desc = "可用于建造 NTOS V3.0 AI 核心模块。当需要中央指挥部更强硬的手腕时就用它。"
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ai_module/law/core/full/ntos
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

