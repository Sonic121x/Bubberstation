/datum/design/board/rbmk2_reactor
	name = "RB-MK2 反应堆（机器电路板）"
	desc = "RB-MK2 反应堆的电路板。"
	id = "rbmk2_reactor"
	build_path = /obj/item/circuitboard/machine/rbmk2
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/rbmk2_reactor_sniffer
	name = "RB-MK2“轰鸣盒”反应堆探测器"
	desc = "RB-MK2“轰鸣盒”反应堆探测器的电路板。"
	id = "rbmk2_sniffer"
	build_path = /obj/item/circuitboard/machine/rbmk2_sniffer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rbmk2_rod
	name = "RB-MK2 反应堆棒"
	desc = "一种专供 RB-MK2 反应堆使用的棒体。"
	id = "rbmk2_rod"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT*2)
	construction_time = 100
	build_path = /obj/item/tank/rbmk2_rod
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/energy_manipulation/New(...)
	design_ids += list(
		"rbmk2_reactor",
		"rbmk2_rod",
		"rbmk2_sniffer"
	)
	. = ..()

/datum/design/rbmk2_upgrade_auto_vent
	name = "RB-MK2 软件升级磁盘——自动通风"
	desc = "一张磁盘，可让你为 RB-MK 安装升级，自动控制通风使用，以在任何温度配置下最大化发电量。"
	id = "rbmk2_disk_auto_vent"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/silver =SHEET_MATERIAL_AMOUNT, /datum/material/titanium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/rbmk_upgrade/auto_vent
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rbmk2_upgrade_safeties
	name = "RB-MK2 软件升级磁盘——安全系统优化"
	desc = "一张磁盘，可让你为 RB-MK 安装升级，将安全阈值从 75% 有效降至 95%，防止过早喷出。"
	id = "rbmk2_disk_safeties"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/gold =SHEET_MATERIAL_AMOUNT, /datum/material/uranium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/rbmk_upgrade/safeties
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rbmk2_upgrade_overclock
	name = "RB-MK2 软件升级磁盘——超频"
	desc = "一张磁盘，可让你为 RB-MK 安装升级，启用反应堆超频。"
	id = "rbmk2_disk_overlock"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT, /datum/material/uranium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/rbmk_upgrade/overclock
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/rbmk_upgrades
	id = "rbmk_disk_upgrade_node"
	display_name = "RB-MK2 软件升级磁盘"
	description = "各种（可能非法的）软件升级，能以某种方式改进（？）RB-MK2 反应堆。"
	prereq_ids = list(TECHWEB_NODE_ENERGY_MANIPULATION, TECHWEB_NODE_APPLIED_BLUESPACE)
	design_ids = list(
		"rbmk2_disk_overlock",
		"rbmk2_disk_safeties",
		"rbmk2_disk_auto_vent"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)
