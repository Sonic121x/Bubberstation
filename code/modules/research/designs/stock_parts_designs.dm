////////////////////////////////////////
/////////////Stock Parts////////////////
////////////////////////////////////////

/datum/design/rped
	name = "快速部件更换装置"
	desc = "一种特殊的机械模块，用于储存、分类并安装标准机器部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/storage/part_replacer
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_EXCHANGERS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/bs_rped
	name = "蓝空间 RPED"
	desc = "由蓝空间技术驱动，这种 RPED 变体可远距离升级建筑，无需先拆下面板。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT*2.5)
	build_path = /obj/item/storage/part_replacer/bluespace
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_EXCHANGERS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

//Capacitors
/datum/design/basic_capacitor
	name = "基础电容器"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/capacitor
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_1
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/adv_capacitor
	name = "高级电容器"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT*1.5)
	build_path = /obj/item/stock_parts/capacitor/adv
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_2
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/super_capacitor
	name = "超级电容器"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2, /datum/material/gold =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/capacitor/super
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_3
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/quadratic_capacitor
	name = "二次方电容器"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2, /datum/material/gold =SMALL_MATERIAL_AMOUNT, /datum/material/diamond =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/capacitor/quadratic
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_4
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

//Scanning modules
/datum/design/basic_scanning
	name = "基础扫描模块"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/stock_parts/scanning_module
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_1
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/adv_scanning
	name = "高级扫描模块"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/scanning_module/adv
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_2
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/phasic_scanning
	name = "相位扫描模块"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT*0.6)
	build_path = /obj/item/stock_parts/scanning_module/phasic
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_3
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/triphasic_scanning
	name = "三相扫描模块"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2, /datum/material/diamond = SMALL_MATERIAL_AMOUNT*0.3, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/stock_parts/scanning_module/triphasic
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_4
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

//Maipulators
/datum/design/micro_servo
	name = "微型伺服电机"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/servo
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_1
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/nano_servo
	name = "纳型伺服电机"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5)
	build_path = /obj/item/stock_parts/servo/nano
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_2
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/pico_servo
	name = "皮型伺服电机"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/stock_parts/servo/pico
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_3
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/femto_servo
	name = "飞型伺服电机"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2, /datum/material/diamond = SMALL_MATERIAL_AMOUNT*0.3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT*0.3)
	build_path = /obj/item/stock_parts/servo/femto
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_4
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

//Micro-lasers
/datum/design/basic_micro_laser
	name = "基础微型激光器"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/stock_parts/micro_laser
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_1
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/high_micro_laser
	name = "高功率微型激光器"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/micro_laser/high
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_2
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/ultra_micro_laser
	name = "超高功率微型激光器"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT*0.6)
	build_path = /obj/item/stock_parts/micro_laser/ultra
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_3
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/quadultra_micro_laser
	name = "四重超强微型激光器"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2, /datum/material/uranium =SMALL_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT*0.6)
	build_path = /obj/item/stock_parts/micro_laser/quadultra
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_4
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/basic_matter_bin
	name = "基础物质储箱"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/matter_bin
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_1
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/adv_matter_bin
	name = "高级物质储箱"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*1.5)
	build_path = /obj/item/stock_parts/matter_bin/adv
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_2
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/super_matter_bin
	name = "超级物质储箱"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/stock_parts/matter_bin/super
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_3
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/bluespace_matter_bin
	name = "蓝空间物质储箱"
	desc = "一种用于制造各类设备的库存部件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*2.5, /datum/material/diamond =SMALL_MATERIAL_AMOUNT, /datum/material/bluespace =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/matter_bin/bluespace
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_4
	)
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

//T-Comms devices
/datum/design/subspace_ansible
	name = "亚空间安塞波"
	desc = "一种能够感知异次元活动的紧凑模块。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT, /datum/material/silver =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/subspace/ansible
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/hyperwave_filter
	name = "超波滤波器"
	desc = "一种能过滤并转换超强无线电波的小型装置。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT, /datum/material/silver =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/subspace/filter
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/subspace_amplifier
	name = "亚空间放大器"
	desc = "一种能放大微弱亚空间传输的紧凑微型机器。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT, /datum/material/gold =SMALL_MATERIAL_AMOUNT, /datum/material/uranium =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/subspace/amplifier
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/subspace_treatment
	name = "亚空间处理盘"
	desc = "一种能拉伸超压缩无线电波的紧凑微型机器。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT, /datum/material/silver =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/stock_parts/subspace/treatment
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/subspace_analyzer
	name = "亚空间波长分析仪"
	desc = "一种能够分析隐秘亚空间波长的精密分析仪。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT, /datum/material/gold =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/subspace/analyzer
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/subspace_crystal
	name = "安塞波晶体"
	desc = "一种能够分析隐秘亚空间波长的精密分析仪。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT*8, /datum/material/silver =SMALL_MATERIAL_AMOUNT, /datum/material/gold =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/subspace/crystal
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/subspace_transmitter
	name = "亚空间发射器"
	desc = "一台用于打开通往亚空间维度窗口的大型设备。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT, /datum/material/silver =SMALL_MATERIAL_AMOUNT, /datum/material/uranium =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stock_parts/subspace/transmitter
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/card_reader
	name = "读卡器"
	desc = "一个小型磁条读卡器，用于收取和传输全息信用点的设备。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.1)
	build_path = /obj/item/stock_parts/card_reader
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/water_recycler
	name = "水循环器"
	desc = "一个小型静水回收器，它从空气中吸收水分并将其送回源头。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/plastic =SMALL_MATERIAL_AMOUNT * 2, /datum/material/iron =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/stock_parts/water_recycler
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE
