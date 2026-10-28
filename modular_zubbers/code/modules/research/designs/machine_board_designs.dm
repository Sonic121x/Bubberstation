/datum/design/board/plantgenes
	name = "植物 DNA 操控器（机器电路板）"
	desc = "植物基因编辑机的电路板。"
	id = "plantgene"
	build_path = /obj/item/circuitboard/machine/plantgenes
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BOTANY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/mechpad
	name = "机甲轨道投送平台（机器电路板）"
	desc = "机甲轨道投送平台的电路板。"
	id = "mechlauncher_pad"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/mechpad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/megacell_charger
	name = "机器设计（巨型电池充电器电路板）"
	desc = "巨型电池充电器的电路板。"
	id = "megacell_charger"
	build_path = /obj/item/circuitboard/machine/megacell_charger
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
