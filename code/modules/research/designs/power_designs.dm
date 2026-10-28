////////////////////////////////////////
//////////////////Power/////////////////
////////////////////////////////////////

/datum/design/basic_cell
	name = "基础电池"
	desc = "一种基础电池，可储存 10 KW 能量。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE |MECHFAB
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 0.5)
	build_path = /obj/item/stock_parts/power_store/cell/empty
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/high_cell
	name = "高容量电池"
	desc = "一种可储存 100 KW 能量的电池。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE | MECHFAB
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.6)
	build_path = /obj/item/stock_parts/power_store/cell/high/empty
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/super_cell
	name = "超大容量电池"
	desc = "一种可储存 200 KW 能量的电池。"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.7)
	build_path = /obj/item/stock_parts/power_store/cell/super/empty
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_2
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/hyper_cell
	name = "超高容量电池"
	desc = "一种可储存 300 KW 能量的电池。"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.8)
	build_path = /obj/item/stock_parts/power_store/cell/hyper/empty
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/bluespace_cell
	name = "蓝空间电池"
	desc = "一种可储存 400 KW 能量的电池。"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 8, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 1.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.6, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 1.6, /datum/material/titanium =SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/power_store/cell/bluespace/empty
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_4
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/basic_battery
	name = "基础电池组"
	desc = "一种基础电池组，可储存 1 MJ 能量。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE |MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2)
	construction_time = 5 SECONDS
	build_path = /obj/item/stock_parts/power_store/battery/empty
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/high_battery
	name = "高容量电池组"
	desc = "一种可储存 10 MJ 能量的电池组。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE | MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3)
	construction_time = 5 SECONDS
	build_path = /obj/item/stock_parts/power_store/battery/high/empty
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_2
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/super_battery
	name = "超大容量电池组"
	desc = "一种可储存 20 MJ 能量的电池组。"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 4)
	construction_time = 5 SECONDS
	build_path = /obj/item/stock_parts/power_store/battery/super/empty
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/hyper_battery
	name = "超高容量电池组"
	desc = "一种可储存 30 MJ 能量的电池组。"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	construction_time = 5 SECONDS
	build_path = /obj/item/stock_parts/power_store/battery/hyper/empty
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/bluespace_battery
	name = "蓝空间电池组"
	desc = "一种可储存 40 MJ 能量的电池组。"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 1.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 6, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 1.6, /datum/material/titanium =SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace =SMALL_MATERIAL_AMOUNT)
	construction_time = 5 SECONDS
	build_path = /obj/item/stock_parts/power_store/battery/bluespace/empty
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_4
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING


/datum/design/inducer
	name = "感应充电器"
	desc = "NT-75 电磁感应充电器能以无线方式在物体中感生电荷，让你无需取出电池即可为其充电。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/inducer/sci
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/inducerengi
	name = "感应充电器"
	desc = "NT-75 电磁感应充电器能以无线方式在物体中感生电荷，让你无需取出电池即可为其充电。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/inducer/empty
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/pacman
	name = "P.A.C.M.A.N. 型发电机电路板"
	desc = "用于建造 P.A.C.M.A.N. 型便携式发电机，消耗等离子体产生适量电能。"
	build_path = /obj/item/circuitboard/machine/pacman
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/plankman
	name = "木板人电路板"
	desc = "用于木板人型便携式发电机的电路板。"
	build_path = /obj/item/circuitboard/machine/plankman
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/bioelec_gen
	name = "水族箱生物电套件"
	desc = "将水族箱改装为生物发电机所需的组件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/gold = SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/aquarium_upgrade/bioelec_gen
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/turbine_part_compressor
	name = "涡轮压缩机"
	desc = "基础等级的压缩机叶片。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5)
	construction_time = 10 SECONDS
	build_path = /obj/item/turbine_parts/compressor
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_TURBINE
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/turbine_part_rotor
	name = "涡轮转子"
	desc = "基础等级的转子轴。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5)
	construction_time = 10 SECONDS
	build_path = /obj/item/turbine_parts/rotor
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_TURBINE
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/turbine_part_stator
	name = "涡轮定子"
	desc = "基础等级的定子。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*5)
	construction_time = 10 SECONDS
	build_path = /obj/item/turbine_parts/stator
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_TURBINE
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/diode_disk_stamina
	name = "电击瓦解型二极管磁盘"
	desc = "一种可削减耐力并治疗超物质晶体的二极管磁盘，应放入发射器内。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT, /datum/material/gold =SMALL_MATERIAL_AMOUNT)
	construction_time = 0.5 SECONDS
	build_path = /obj/item/emitter_disk/stamina
	category = list(
		RND_CATEGORY_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/diode_disk_healing
	name = "生物再生型二极管磁盘"
	desc = "一种可治疗生物的二极管磁盘，应放入发射器内。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT, /datum/material/silver =SMALL_MATERIAL_AMOUNT) //silver is medical metal. Why? who knows.
	construction_time = 0.5 SECONDS
	build_path = /obj/item/emitter_disk/healing
	category = list(
		RND_CATEGORY_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/diode_disk_incendiary
	name = "燃烧型二极管磁盘"
	desc = "一种高能燃烧型二极管磁盘，应放入发射器内。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT, /datum/material/diamond =SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT * 2)
	construction_time = 0.5 SECONDS
	build_path = /obj/item/emitter_disk/incendiary
	category = list(
		RND_CATEGORY_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/diode_disk_sanity
	name = "心灵虹吸型二极管磁盘"
	desc = "一种可安抚超物质、却令生物沮丧的二极管磁盘，应放入发射器内。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT, /datum/material/uranium =SMALL_MATERIAL_AMOUNT * 0.5) //Uranium, the metal of love and warmth (from decay heat).
	construction_time = 0.5 SECONDS
	build_path = /obj/item/emitter_disk/sanity
	category = list(
		RND_CATEGORY_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/diode_disk_magnetic
	name = "磁力生成型二极管磁盘"
	desc = "一种吸收气体并吸引物品的二极管磁盘，应放入发射器内。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT, /datum/material/titanium =SMALL_MATERIAL_AMOUNT * 0.5)
	construction_time = 0.5 SECONDS
	build_path = /obj/item/emitter_disk/magnetic
	category = list(
		RND_CATEGORY_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING
