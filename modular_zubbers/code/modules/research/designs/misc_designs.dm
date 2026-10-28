/datum/design/diskplantgene
	name = "植物数据磁盘"
	desc = "用于储存植物基因数据的磁盘。"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1,
		)
	transfered_materials = list(/obj/item/disk/computer/plantgene = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT))
	build_path = /obj/item/disk/computer/plantgene
	category = list("Electronics")
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/nitrogen_tank
	name = "氮气罐"
	desc = "一个空氮气罐。"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/tank/internals/nitrogen/empty
	category = list(RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/* Uncomment in case nitrogen internal tanks get refactored to no longer be 25L
* /datum/design/nitrogen_tank_belt
*	name = "Nitrogen Internals Tank"
*	desc = "An empty nitrogen tank."
*	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
*	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
*	build_path = /obj/item/tank/internals/nitrogen/belt/empty
*	category = list(RND_CATEGORY_INITIAL,
*		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS,
*	)
*	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO
*/

/datum/design/anesthetic_tank
	name = "麻醉气体罐"
	desc = "一种专为配合麻醉剂使用而设计的空罐。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/tank/internals/anesthetic/empty
	category = list(RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/civilian_hud
	name = "民用 HUD"
	desc = "一种平视显示器，可扫描周围的人形生物并显示其 ID 状态。专家称其用途远超 9000 种。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/clothing/glasses/hud/civilian
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/cyberimp_civ_hud
	name = "民用 HUD 植入体"
	desc = "这些义眼会在你看到的一切之上叠加民用 HUD。转动眼球以控制。"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 5 SECONDS
	//just about half the materials of a sechudimplant but no silver
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/organ/cyberimp/eyes/hud/civilian
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/umbrella
	name = "雨伞"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.75, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.25)
	transfered_materials = list(/obj/item/umbrella = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5))
	build_path = /obj/item/umbrella
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/normtrash/New()
	. = ..()
	build_type |= AUTOLATHE
	category += list(RND_CATEGORY_INITIAL)
