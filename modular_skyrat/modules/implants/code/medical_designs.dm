/datum/design/cyberimp_mantis
	name = "螳螂刃植入体"
	desc = "一柄安装在前臂内部的长而锋利的螳螂式刀刃，可作为致命的防身武器。"
	id = "ci-mantis"
	build_type = MECHFAB
	materials = list (
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	construction_time = 200
	build_path = /obj/item/organ/cyberimp/arm/toolkit/armblade
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/cyberimp_claws
	name = "剃刀利爪植入体"
	desc = "安装在手指内部的长而锋利的双刃刀片，可用于切割。各种意义上的切割。"
	id = "ci-razor"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list (
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	construction_time = 20 SECONDS
	build_path = /obj/item/organ/cyberimp/arm/toolkit/razor_claws
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_TOOLS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SECURITY

/datum/design/cyberimp_flash
	name = "光子投射器植入体"
	desc = "一种安装在受术者手臂上的集成式投射器，可用作强力的闪光装置。"
	id = "ci-flash"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list (
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	construction_time = 200
	build_path = /obj/item/organ/cyberimp/arm/toolkit/flash
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_botany
	name = "园艺手臂植入体"
	desc = "园艺师所需的一切都集成在了一个手臂植入体中，设计用于安装到受术者的手臂上。"
	id = "ci-botany"
	build_type = MECHFAB | PROTOLATHE
	materials = list (
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	construction_time = 200
	build_path = /obj/item/organ/cyberimp/arm/toolkit/botany
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_TOOLS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE

/datum/design/cyberimp_nv
	name = "夜视义眼"
	desc = "这些义眼能赋予你夜视能力。又大、又凶、又绿。"
	id = "ci-nv"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/organ/eyes/night_vision/cyber
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_antisleep
	name = "CNS 应急启动植入体"
	desc = "这种植入体会自动尝试把你从昏迷中电醒，两次电击之间冷却时间较短。与 CNS 重启植入体冲突。"
	id = "ci-antisleep"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/organ/cyberimp/brain/anti_sleep
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_scanner
	name = "内置医疗分析仪"
	desc = "这种植入体与宿主身体对接，可在受令时通过心灵传送关于躯体状况的详细读数。"
	id = "ci-scanner"
	build_type = MECHFAB | PROTOLATHE
	construction_time = 40
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/organ/cyberimp/chest/scanner
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_janitor
	name = "清洁工手臂植入体"
	desc = "一套装在手臂植入体里的清洁工具，设计用于安装到受术者的手臂上。"
	id = "ci-janitor"
	build_type = PROTOLATHE | MECHFAB
	materials = list (
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	construction_time = 200
	build_path = /obj/item/organ/cyberimp/arm/toolkit/janitor
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_TOOLS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE

/datum/design/cyberimp_lighter
	name = "打火机手臂植入体"
	desc = "一个安装在受术者手臂里的打火机。毫无用处。"
	id = "ci-lighter"
	build_type = PROTOLATHE | MECHFAB
	materials = list (
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	construction_time = 100
	build_path = /obj/item/organ/cyberimp/arm/toolkit/lighter
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_MISC,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE

/datum/design/cyberimp_thermals
	name = "热成像义眼"
	id = "ci-thermals"
	build_type = AWAY_LATHE | MECHFAB
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/cyberimp_reviver
	name = "复活植入体"
	id = "ci-reviver"
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
