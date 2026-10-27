/datum/export/toolbox
	cost = CARGO_CRATE_VALUE * 0.02
	unit_name = "工具箱"
	export_types = list(/obj/item/storage/toolbox)

// mechanical toolbox: 22cr
// emergency toolbox: 17-20cr
// electrical toolbox: 36cr
// robust: priceless

// Basic tools
/datum/export/screwdriver
	cost = CARGO_CRATE_VALUE * 0.01
	unit_name = "螺丝刀"
	export_types = list(/obj/item/screwdriver)
	include_subtypes = FALSE

/datum/export/wrench
	cost = CARGO_CRATE_VALUE * 0.01
	unit_name = "扳手"
	export_types = list(/obj/item/wrench)

/datum/export/crowbar
	cost = CARGO_CRATE_VALUE * 0.01
	unit_name = "撬棍"
	export_types = list(/obj/item/crowbar)

/datum/export/wirecutters
	cost = CARGO_CRATE_VALUE * 0.01
	unit_name = "副"
	message = "剪线钳"
	export_types = list(/obj/item/wirecutters)


/datum/export/weldingtool
	cost = CARGO_CRATE_VALUE * 0.025
	unit_name = "焊接工具"
	export_types = list(/obj/item/weldingtool)
	include_subtypes = FALSE

/datum/export/weldingtool/emergency
	cost = CARGO_CRATE_VALUE * 0.01
	unit_name = "应急焊接工具"
	export_types = list(/obj/item/weldingtool/mini)

/datum/export/weldingtool/industrial
	cost = CARGO_CRATE_VALUE * 0.05
	unit_name = "工业焊接工具"
	export_types = list(/obj/item/weldingtool/largetank, /obj/item/weldingtool/hugetank)


/datum/export/extinguisher
	cost = CARGO_CRATE_VALUE * 0.075
	unit_name = "灭火器"
	export_types = list(/obj/item/extinguisher)
	include_subtypes = FALSE

/datum/export/extinguisher/mini
	cost = CARGO_CRATE_VALUE * 0.01
	unit_name = "袖珍灭火器"
	export_types = list(/obj/item/extinguisher/mini)


/datum/export/flashlight
	cost = CARGO_CRATE_VALUE * 0.025
	unit_name = "手电筒"
	export_types = list(/obj/item/flashlight)
	include_subtypes = FALSE

/datum/export/flashlight/flare
	cost = CARGO_CRATE_VALUE * 0.01
	unit_name = "照明棒"
	export_types = list(/obj/item/flashlight/flare)

/datum/export/flashlight/seclite
	cost = CARGO_CRATE_VALUE * 0.05
	unit_name = "安保手电"
	export_types = list(/obj/item/flashlight/seclite)


/datum/export/analyzer
	cost = CARGO_CRATE_VALUE * 0.025
	unit_name = "分析仪"
	export_types = list(/obj/item/analyzer)

/datum/export/analyzer/t_scanner
	cost = CARGO_CRATE_VALUE * 0.025
	unit_name = "T 射线扫描仪"
	export_types = list(/obj/item/t_scanner)


/datum/export/radio
	cost = CARGO_CRATE_VALUE * 0.025
	unit_name = "无线电"
	export_types = list(/obj/item/radio)
	exclude_types = list(/obj/item/radio/mech)

//Advanced/Power Tools.
/datum/export/weldingtool/experimental
	cost = CARGO_CRATE_VALUE * 0.45
	unit_name = "实验性焊接工具"
	export_types = list(/obj/item/weldingtool/experimental)

/datum/export/jawsoflife
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "救生钳"
	export_types = list(/obj/item/crowbar/power)

/datum/export/handdrill
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "手持电钻"
	export_types = list(/obj/item/screwdriver/power)

/datum/export/rld_mini
	cost = CARGO_CRATE_VALUE * 0.75
	unit_name = "微型快速照明装置"
	export_types = list(/obj/item/construction/rld/mini)

/datum/export/rsf
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "快速服务制造器"
	export_types = list(/obj/item/rsf)

/datum/export/rcd
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "快速建造装置"
	export_types = list(/obj/item/construction/rcd)

/datum/export/rcd_ammo
	cost = CARGO_CRATE_VALUE * 0.3
	unit_name = "压缩物质弹药筒"
	export_types = list(/obj/item/rcd_ammo)

/datum/export/rpd
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "快速管道投放器"
	export_types = list(/obj/item/pipe_dispenser)

//artisanal exports for the mom and pops
/datum/export/soap
	cost = CARGO_CRATE_VALUE * 0.375
	unit_name = "肥皂"
	export_types = list(/obj/item/soap)
	exclude_types = list(
		/obj/item/soap/homemade,
		/obj/item/soap/omega,
	)

/datum/export/soap/homemade
	cost = CARGO_CRATE_VALUE * 0.15
	unit_name = "手工肥皂"
	export_types = list(/obj/item/soap/homemade)
	exclude_types = list()

/datum/export/soap/omega
	cost = CARGO_CRATE_VALUE * 14
	unit_name = "欧米伽肥皂"
	export_types = list(/obj/item/soap/omega)
	exclude_types = list()

/datum/export/candle
	cost = CARGO_CRATE_VALUE * 0.06125
	unit_name = "蜡烛"
	export_types = list(/obj/item/flashlight/flare/candle)
