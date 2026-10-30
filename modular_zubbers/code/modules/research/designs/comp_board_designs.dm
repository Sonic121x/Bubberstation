/datum/design/board/minesweeper
	name = "扫雷街机电路板"
	desc = "可用于建造新扫雷街机的电路板。"
	build_path = /obj/item/circuitboard/computer/arcade/minesweeper
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENTERTAINMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/mechpad_console
	name = "轨道机甲平台控制台电路板"
	desc = "轨道机甲平台控制台的电路板。"
	build_path = /obj/item/circuitboard/computer/mechpad
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
