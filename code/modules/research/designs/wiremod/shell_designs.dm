/datum/design/wiremod_shell
	abstract_type = /datum/design/wiremod_shell
	build_type = COMPONENT_PRINTER
	category = list(
		RND_CATEGORY_CIRCUITRY_SHELLS
	)

/datum/design/wiremod_shell/compact_remote
	name = "紧凑遥控器外壳"
	desc = "一种带有一个大按钮的手持外壳。"
	build_path = /obj/item/compact_remote
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5)

/datum/design/wiremod_shell/controller
	name = "控制器外壳"
	desc = "一种带有多个按钮的手持外壳。"
	build_path = /obj/item/controller
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/iron = SHEET_MATERIAL_AMOUNT*3.5)

/datum/design/wiremod_shell/scanner
	name = "扫描器外壳"
	desc = "一种可扫描实体的手持扫描器外壳。"
	build_path = /obj/item/wiremod_scanner
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/iron = SHEET_MATERIAL_AMOUNT*3.5)

/datum/design/wiremod_shell/keyboard
	name = "键盘外壳"
	desc = "一种可让用户输入字符串的手持外壳。"
	build_path = /obj/item/keyboard_shell
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/iron = SHEET_MATERIAL_AMOUNT*5)

/datum/design/wiremod_shell/gun
	name = "枪械外壳"
	desc = "一种可发射弹丸、将实体作为信号输出的手持外壳。"
	build_path = /obj/item/gun/energy/wiremod_gun
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/iron = SHEET_MATERIAL_AMOUNT*5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT)

/datum/design/wiremod_shell/bot
	name = "机器人外壳"
	desc = "一种无法移动、可容纳更多元件的外壳。配有 USB 接口，可连接电脑与机器。"
	build_path = /obj/item/shell/bot
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/iron = SHEET_MATERIAL_AMOUNT*5)

/datum/design/wiremod_shell/money_bot
	name = "金钱机器人外壳"
	desc = "一种无法移动的外壳，与普通机器人外壳类似，但能接收金额输入，也能分发金钱。"
	build_path = /obj/item/shell/money_bot
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/iron = SHEET_MATERIAL_AMOUNT*5, /datum/material/gold =SMALL_MATERIAL_AMOUNT*0.5)

/datum/design/wiremod_shell/drone
	name = "无人机外壳"
	desc = "一种能够自行移动的外壳。"
	build_path = /obj/item/shell/drone
	materials = list(
		/datum/material/glass =SHEET_MATERIAL_AMOUNT,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*5.5,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*5,
	)

/datum/design/wiremod_shell/server
	name = "服务器外壳"
	desc = "一种体型巨大、无法移动的外壳。可容纳最多的元件。"
	materials = list(
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/shell/server

/datum/design/wiremod_shell/airlock
	name = "气闸外壳"
	desc = "一种组装后无法移动的门外壳。"
	materials = list(
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5,
	)
	build_path = /obj/item/shell/airlock

/datum/design/wiremod_shell/dispenser
	name = "售货机外壳"
	desc = "一种可分发物品的售货机外壳。"
	materials = list(
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5,
	)
	build_path = /obj/item/shell/dispenser

/datum/design/wiremod_shell/bci
	name = "脑机接口外壳"
	desc = "一种可植入使用者头部、让其用大脑控制电路的植入体。"
	materials = list(
		/datum/material/glass =SHEET_MATERIAL_AMOUNT,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*4,
	)
	build_path = /obj/item/shell/bci

/datum/design/wiremod_shell/scanner_gate
	name = "扫描门外壳"
	desc = "一种扫描门外壳，可在人员通过时对其进行中等深度的扫描。"
	materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT*2,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*6,
	)
	build_path = /obj/item/shell/scanner_gate

/datum/design/wiremod_shell/assembly
	name = "装配件外壳"
	desc = "一种可附着在电线与其他装配件上的装配件外壳。"
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/assembly/wiremod

/datum/design/wiremod_shell/mod_module
	name = "MOD 模块外壳"
	desc = "一种模块外壳，可让电路插入 MOD 外骨骼并与之交互。"
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/mod/module/circuit

/datum/design/wiremod_shell/undertile
	name = "地板下外壳"
	desc = "一种可安装在地板下的小型外壳。"
	materials = list(
		/datum/material/glass=HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*2.5,
	)
	build_path = /obj/item/undertile_circuit


/datum/design/wiremod_shell/wallmount
	name = "壁挂外壳"
	desc = "一种可安装在墙上的大型外壳。"
	materials = list(
		/datum/material/glass=SHEET_MATERIAL_AMOUNT,
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/wallframe/circuit

/datum/design/wiremod_shell/implant
	name = "植入体外壳盒"
	desc = "一种可植入生物体内的小型外壳。"
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 5,
	)
	transfered_materials = list(
		/obj/item/implantcase/circuit = /obj/item/implantcase/circuit::custom_materials,
		/obj/item/implant/circuit = /obj/item/implant/circuit::custom_materials,
	)
	build_path = /obj/item/implantcase/circuit

//This design has a different path but it's still a wiremod design.
/datum/design/board/bci_implanter
	name = "脑机接口操作舱"
	desc = "一种机器，装入脑机接口后可将其植入舱内人员体内；若没有，则会取出其已有的脑机接口。"
	build_path = /obj/item/circuitboard/machine/bci_implanter
	build_type = COMPONENT_PRINTER
	category = list(
		RND_CATEGORY_CIRCUITRY_SHELLS
	)
