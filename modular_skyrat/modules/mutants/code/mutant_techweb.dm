/obj/item/circuitboard/machine/rna_recombinator
	name = "RNA重组机（机器电路板）"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/rna_recombinator
	req_components = list(
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/servo = 2,
		/datum/stock_part/micro_laser = 2,
	)

/datum/techweb_node/mutanttech
	id = TECHWEB_NODE_MUTANT_TECH
	display_name = "纳米传讯高级病毒生物武器技术"
	description = "来自纳米传讯病毒生物武器部门的研究设备！遭遇病毒问题？它能救你一命。"
	prereq_ids = list("exp_tools", "cytology")
	design_ids = list("rna_vial", "rna_extractor", "rna_recombinator")
	research_costs = list(TECHWEB_NODE_SURGERY_TOOLS, TECHWEB_NODE_CYTOLOGY)

/datum/design/rna_vial
	name = "空RNA样本瓶"
	desc = "用于储存遗传信息的空RNA样本瓶。"
	id = "rna_vial"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/rna_vial
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL + RND_SUBCATEGORY_EQUIPMENT_SCIENCE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/rna_extractor
	name = "RNA提取装置"
	desc = "一台RNA提取装置，对想提取RNA数据的对象使用。需要装入RNA样本瓶才能工作。"
	id = "rna_extractor"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/rna_extractor
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL + RND_SUBCATEGORY_EQUIPMENT_SCIENCE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/rna_recombinator
	name = "机器设计（RNA重组机）"
	desc = "信使RNA重组机采用纳米传讯最先进的技术之一，能够精确重组病毒RNA。"
	id = "rna_recombinator"
	build_path = /obj/item/circuitboard/machine/rna_recombinator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL
