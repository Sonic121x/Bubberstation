// Circuit boards, spare parts, etc.

/datum/export/solar_assembly
	cost = CARGO_CRATE_VALUE * 0.25
	unit_name = "太阳能板组件"
	export_types = list(/obj/item/solar_assembly)

/datum/export/tracker_board
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "太阳能追踪器电路板"
	export_types = list(/obj/item/electronics/tracker)

/datum/export/control_board
	cost = CARGO_CRATE_VALUE * 0.75
	unit_name = "太阳能板控制电路板"
	export_types = list(/obj/item/circuitboard/computer/solar_control)

//Data Disks
/datum/export/advanced_disk
	cost = CARGO_CRATE_VALUE * 0.4
	unit_name = "高级数据磁盘"
	export_types = list(/obj/item/disk/computer/advanced)
	include_subtypes = FALSE

/datum/export/super_disk
	cost = CARGO_CRATE_VALUE * 0.6
	unit_name = "超级数据磁盘"
	export_types = list(/obj/item/disk/computer/super)
	include_subtypes = FALSE

/datum/export/standard_disk
	cost = CARGO_CRATE_VALUE * 0.2
	unit_name = "数据磁盘"
	export_types = list(/obj/item/disk/computer)
	include_subtypes = TRUE

/datum/export/refill_canister
	cost = CARGO_CRATE_VALUE * 0.5 //If someone want to make this worth more as it empties, go ahead
	unit_name = "售货机补充罐"
	export_types = list(/obj/item/vending_refill)

/datum/export/refill_canister/total_printout(datum/export_report/ex, notes = TRUE)
	. = ..()
	if(. && notes)
		. += " 感谢你为空间站补货！"
