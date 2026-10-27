
/////////////////////////////////////////
///////////////Bluespace/////////////////
/////////////////////////////////////////

/datum/design/beacon
	name = "追踪信标"
	desc = "一台蓝空间追踪信标。"
	id = "beacon"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/beacon
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_BLUESPACE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SECURITY

/datum/design/bag_holding
	name = "惰性次元背包"
	desc = "一块金属，安装蓝空间异常核心后即可转变为次元背包。"
	id = "bag_holding"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/diamond =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT*2.5, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/bag_of_holding_inert
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/bluespace_crystal
	name = "人造蓝空间水晶"
	desc = "一块带有神秘特性的蓝色小晶体。"
	id = "bluespace_crystal"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/stack/ore/bluespace_crystal/artificial
	category = list(
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MATERIALS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING
	inherit_materials = DESIGN_DONT_INHERIT_MATS

/datum/design/telesci_gps
	name = "全球定位系统"
	desc = "能随时追踪自身位置的小玩意儿。"
	id = "telesci_gps"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/gps
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_BLUESPACE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO
	//autolathe_exportable = FALSE //SKYRAT EDIT REMOVAL

/datum/design/desynchronizer
	name = "失同步器"
	desc = "一台能使使用者脱离时空同步的装置。"
	id = "desynchronizer"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/desynchronizer
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_BLUESPACE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/miningsatchel_holding
	name = "次元采矿挎包"
	desc = "一只可以容纳无限矿石的采矿挎包。"
	id = "minerbag_holding"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/gold = SMALL_MATERIAL_AMOUNT*2.5, /datum/material/uranium =SMALL_MATERIAL_AMOUNT*5) //quite cheap, for more convenience
	build_path = /obj/item/storage/bag/ore/holding
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/swapper
	name = "量子自旋反转器"
	desc = "通过交换粒子自旋值来互换两个实体位置的实验设备。必须连接另一台设备才能运作。"
	id = "swapper"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/swapper
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_BLUESPACE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
