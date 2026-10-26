/datum/design/monkey_helmet
	name = "猴子心智放大头盔"
	desc = "一顶脆弱、内嵌电路的头盔，用于把猴子的智力提升到更高水平。"
	id = "monkey_helmet"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/clothing/head/helmet/monkey_sentience
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_EQUIPMENT_SCIENCE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/plumbing_eng
	name = "工程管道建造器"
	desc = "一种用于操纵流体的管道建造器。"
	id = "plumbing_eng"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 40,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/construction/plumbing/engineering
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/smartdartgun
	name = "医疗智能飞镖枪"
	desc = "医疗注射枪的改装版本，仅允许装填智能飞镖。"
	id = "smartdartgun"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5.3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/gun/syringe/smartdart
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/breath_machine
	name = "呼吸机部件套件"
	desc = "包含组装便携式呼吸机及支架所需全部部件的套件，不含气罐。"
	id = "breath_machine"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/breath_machine_kit
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/*
/datum/design/time_clock_frame
	name = "Time Clock Frame"
	desc = "A frame for a time clock console, contains all of the parts needed to build a new time clock"
	id = "time_clock_frame"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/wallframe/time_clock
	category = list(
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SERVICE
*/

/datum/design/vox_gas_filter
	name = "Vox 大气气体过滤器"
	id = "vox_gas_filter"
	build_type = PROTOLATHE | AUTOLATHE | COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/gas_filter/vox
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS_EQUIPMENT,
	)
	departmental_flags = ALL
