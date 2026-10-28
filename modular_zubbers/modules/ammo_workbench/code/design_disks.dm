/obj/item/disk/ammo_workbench
	name = "弹药蓝图数据盘"
	desc = "你不该看到这个！"

/// For doing things when installed/downloaded onto an ammo bench.
/// Really only used for setting variables, but if someone expands the system to have disks per ammo type, I guess this could be more useful.
/obj/item/disk/ammo_workbench/proc/on_bench_install(obj/machinery/ammo_workbench/ammobench)
	return

/obj/item/disk/ammo_workbench/advanced
	name = "高级弹药数据盘"
	desc = "一张数据盘，存有供弹药工作台使用的高级弹药制造数据，包括此前未启用的致命弹药类型。 \
	若事先绕过了保险装置，任何由此引发的事故，各方均不承担责任。"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/disk/ammo_workbench/advanced/on_bench_install(obj/machinery/ammo_workbench/ammobench)
	ammobench.allowed_harmful = TRUE
	ammobench.allowed_advanced = TRUE

