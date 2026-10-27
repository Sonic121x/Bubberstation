///// Bubber added Tarkon Tech /////
/datum/design/tarkonpowerator
	name = "塔肯电力贩子"
	desc = "一种可出售电力的机器电路板。"
	id = "powerator_tarkon"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/machine/powerator/tarkon
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/tarkonexpressconsole
	name = "塔肯快速补给控制台"
	desc = "用于采购货物的电脑电路板。"
	id = "cargoconsole_tarkon"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/computer/cargo/express/interdyne/tarkon
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/bountypad
	name = "塔肯悬赏交货平台"
	desc = "用于出售货物的机器电路板。"
	id = "bountypad_tarkon"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/machine/syndiepad/tarkon
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/bountypadconsole
	name = "塔肯悬赏控制终端"
	desc = "用于出售货物的塔肯控制终端电路板。"
	id = "bountyconsole_tarkon"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/computer/syndiepad/tarkon
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
