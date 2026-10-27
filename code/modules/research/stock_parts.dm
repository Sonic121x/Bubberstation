/*Power cells are in code\modules\power\cell.dm

If you create T5+ please take a pass at mech_fabricator.dm. The parts being good enough allows it to go into minus values and create materials out of thin air when printing stuff.*/

/obj/item/stock_parts
	name = "标准部件"
	desc = "什么？"
	icon = 'icons/obj/devices/stock_parts.dmi'
	///The generic category type that the stock part belongs to.  Generic objects that should not be instantiated should have the same type and abstract_type
	abstract_type = /obj/item/stock_parts
	w_class = WEIGHT_CLASS_SMALL
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP
	var/rating = 1
	///Used when a base part has a different name to higher tiers of part. For example, machine frames want any servo and not just a micro-servo.
	var/base_name
	var/energy_rating = 1

/obj/item/stock_parts/Initialize(mapload)
	. = ..()
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)

/obj/item/stock_parts/get_part_rating()
	return rating

//Rating 1

/obj/item/stock_parts/capacitor
	name = "电容器"
	desc = "用于制造各种设备的基础电容器。"
	icon_state = "capacitor"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/scanning_module
	name = "扫描模块"
	desc = "用于制造某些设备的紧凑型高分辨率扫描模块。"
	icon_state = "scan_module"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/stock_parts/servo
	name = "微型伺服电机"
	desc = "用于制造某些设备的小型伺服电机。"
	icon_state = "micro_servo"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT)
	base_name = "伺服电机"

/obj/item/stock_parts/micro_laser
	name = "微型激光器"
	desc = "用于某些设备的小型激光器。"
	icon_state = "micro_laser"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/stock_parts/matter_bin
	name = "物质储箱"
	desc = "设计用于盛装压缩物质、等待重构的容器。"
	icon_state = "matter_bin"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT)

//Rating 2

/obj/item/stock_parts/capacitor/adv
	name = "高级电容器"
	desc = "用于制造各种设备的高级电容器。"
	icon_state = "adv_capacitor"
	rating = 2
	energy_rating = 3
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.5)

/obj/item/stock_parts/scanning_module/adv
	name = "高级扫描模块"
	desc = "用于制造某些设备的紧凑型高分辨率扫描模块。"
	icon_state = "adv_scan_module"
	rating = 2
	energy_rating = 3
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/servo/nano
	name = "纳型伺服电机"
	desc = "用于制造某些设备的小型伺服电机。"
	icon_state = "nano_servo"
	rating = 2
	energy_rating = 3
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.5)

/obj/item/stock_parts/micro_laser/high
	name = "高功率微型激光器"
	desc = "用于某些设备的小型激光器。"
	icon_state = "high_micro_laser"
	rating = 2
	energy_rating = 3
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/matter_bin/adv
	name = "高级物质储箱"
	desc = "设计用于盛装压缩物质、等待重构的容器。"
	icon_state = "advanced_matter_bin"
	rating = 2
	energy_rating = 3
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.5)

//Rating 3

/obj/item/stock_parts/capacitor/super
	name = "超级电容器"
	desc = "用于制造各种设备的超高容量电容器。"
	icon_state = "super_capacitor"
	rating = 3
	energy_rating = 5
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2, /datum/material/gold = SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/scanning_module/phasic
	name = "相位扫描模块"
	desc = "用于制造某些设备的紧凑型高分辨率相位扫描模块。"
	icon_state = "super_scan_module"
	rating = 3
	energy_rating = 5
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 0.6)

/obj/item/stock_parts/servo/pico
	name = "皮型伺服电机"
	desc = "用于制造某些设备的小型伺服电机。"
	icon_state = "pico_servo"
	rating = 3
	energy_rating = 5
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/stock_parts/micro_laser/ultra
	name = "超高功率微型激光器"
	icon_state = "ultra_high_micro_laser"
	desc = "用于某些设备的小型激光器。"
	rating = 3
	energy_rating = 5
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 0.6)

/obj/item/stock_parts/matter_bin/super
	name = "超级物质储箱"
	desc = "设计用于盛装压缩物质、等待重构的容器。"
	icon_state = "super_matter_bin"
	rating = 3
	energy_rating = 5
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2)

//Rating 4

/obj/item/stock_parts/capacitor/quadratic
	name = "二次方电容器"
	desc = "一种用于制造各种设备的容量电容器。"
	icon_state = "quadratic_capacitor"
	rating = 4
	energy_rating = 10
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2, /datum/material/gold = SMALL_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/scanning_module/triphasic
	name = "三相扫描模块"
	desc = "用于制造某些设备的紧凑型超高分辨率三相扫描模块。"
	icon_state = "triphasic_scan_module"
	rating = 4
	energy_rating = 10
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 0.3)

/obj/item/stock_parts/servo/femto
	name = "飞型伺服电机"
	desc = "用于制造某些设备的小型伺服电机。"
	icon_state = "femto_servo"
	rating = 4
	energy_rating = 10
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 0.3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 0.3)

/obj/item/stock_parts/micro_laser/quadultra
	name = "四重超强微型激光器"
	icon_state = "quadultra_micro_laser"
	desc = "用于某些设备的小型激光器。"
	rating = 4
	energy_rating = 10
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2, /datum/material/uranium = SMALL_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 0.6)

/obj/item/stock_parts/matter_bin/bluespace
	name = "蓝空间物质储箱"
	desc = "设计用于盛装压缩物质、等待重构的容器。"
	icon_state = "bluespace_matter_bin"
	rating = 4
	energy_rating = 10
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2.5, /datum/material/diamond = SMALL_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT)

// Subspace stock parts

/obj/item/stock_parts/subspace
	name = "亚空间标准部件"
	desc = "什么？"
	abstract_type = /obj/item/stock_parts/subspace

/obj/item/stock_parts/subspace/ansible
	name = "亚空间安塞波"
	icon_state = "subspace_ansible"
	desc = "一种能够感知异次元活动的紧凑模块。"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/silver = SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/subspace/filter
	name = "超波滤波器"
	icon_state = "hyperwave_filter"
	desc = "一种能过滤并转换超强无线电波的小型装置。"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/silver = SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/subspace/amplifier
	name = "亚空间放大器"
	icon_state = "subspace_amplifier"
	desc = "一种能放大微弱亚空间传输的紧凑微型机器。"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT, /datum/material/uranium = SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/subspace/treatment
	name = "亚空间处理盘"
	icon_state = "treatment_disk"
	desc = "一种能拉伸超压缩无线电波的紧凑微型机器。"
	custom_materials = list(/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2, /datum/material/iron = SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/subspace/analyzer
	name = "亚空间波长分析仪"
	icon_state = "wavelength_analyzer"
	desc = "一种能够分析隐秘亚空间波长的精密分析仪。"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/subspace/crystal
	name = "安塞波晶体"
	icon_state = "ansible_crystal"
	desc = "由纯玻璃制成的水晶，用于将激光数据脉冲传送至亚空间。"
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8, /datum/material/silver = SMALL_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT)

/obj/item/stock_parts/subspace/transmitter
	name = "亚空间发射器"
	icon_state = "subspace_transmitter"
	desc = "一台用于打开通往亚空间维度窗口的大型设备。"
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/silver = SMALL_MATERIAL_AMOUNT, /datum/material/uranium = SMALL_MATERIAL_AMOUNT)

// Misc. Parts

/obj/item/stock_parts/card_reader
	name = "读卡器"
	icon_state = "card_reader"
	desc = "一个小型磁条读卡器，用于收取和传输全息信用点的设备。"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.1)

/obj/item/stock_parts/water_recycler
	name = "水循环器"
	icon_state = "water_recycler"
	desc = "一种化学品回收组件，用于随时间重新收集并过滤水。"
	custom_materials = list(/datum/material/plastic=SMALL_MATERIAL_AMOUNT * 2, /datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5)

/obj/item/research//Makes testing much less of a pain -Sieve
	name = "研究"
	icon = 'icons/obj/devices/stock_parts.dmi'
	icon_state = "capacitor"
	desc = "用于研究的调试物品。"
