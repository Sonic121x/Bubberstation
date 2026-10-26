/datum/design/cybernetic_tongue
	name = "义体舌头"
	desc = "一条义体舌头。"
	id = "cybernetic_tongue"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/organ/tongue/cybernetic
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_tongue/lizard
	name = "分叉义体舌头"
	desc = "一条分叉的义体舌头。"
	id = "cybernetic_tongue_lizard"
	build_path = /obj/item/organ/tongue/lizard/cybernetic

/datum/design/cyberimp_surgical/alien
	name = "外星手术臂植入体"
	desc = "一套隐藏在手臂暗格中的外星手术工具。"
	id = "ci-surgery-alien"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list (/datum/material/iron = SHEET_MATERIAL_AMOUNT*10.25, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 10.5, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 10.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT * 10, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 4.5)
	construction_time = 2 SECONDS
	build_path = /obj/item/organ/cyberimp/arm/toolkit/surgery/alien
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_toolset/alien
	name = "外星工具组臂植入体"
	desc = "精简版的工程工具组，配有绑架者工具，设计用于安装在使用者手臂上。"
	id = "ci-toolset-alien"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list (/datum/material/iron =SHEET_MATERIAL_AMOUNT * 15.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT*8.25, /datum/material/plasma =SHEET_MATERIAL_AMOUNT * 8.5, /datum/material/titanium =SHEET_MATERIAL_AMOUNT * 3, /datum/material/diamond =SHEET_MATERIAL_AMOUNT * 3)
	construction_time = 2 SECONDS
	build_path = /obj/item/organ/cyberimp/arm/toolkit/toolset/alien
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY + RND_SUBCATEGORY_TOOLS_ENGINEERING_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
