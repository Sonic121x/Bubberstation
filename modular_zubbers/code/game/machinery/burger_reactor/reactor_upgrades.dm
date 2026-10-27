
/obj/item/rbmk_upgrade
	name = "\improper RB-MK2 软件升级磁盘"
	desc = "里面似乎是空的。程序员们，干得真他妈漂亮。"
	icon = 'icons/obj/devices/floppy_disks.dmi'
	icon_state = "datadisk2"

/obj/item/rbmk_upgrade/proc/apply_upgrade(obj/machinery/power/rbmk2/machine)
	return TRUE

/obj/item/rbmk_upgrade/proc/can_upgrade(obj/machinery/power/rbmk2/machine)
	return TRUE

//machine handles it.
/obj/machinery/power/rbmk2/item_interaction(mob/living/user, obj/item/tool, list/modifiers)

	if(istype(tool,/obj/item/rbmk_upgrade))
		var/obj/item/rbmk_upgrade/upgrade_disk = tool
		if(upgrade_disk.can_upgrade(src))
			upgrade_disk.apply_upgrade(src)
			balloon_alert(user, "升级完成！")
		else
			balloon_alert(user, "无法升级！")
		return TRUE


	. = ..()


//Auto Vent
/obj/item/rbmk_upgrade/auto_vent
	name = "\improper RB-MK2 软件升级磁盘——自动通风"
	desc = "可为 RB-MK 安装自动通风升级的磁盘，在各种温度配置下自动控制通风，使发电收益最大化。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/silver =SHEET_MATERIAL_AMOUNT, /datum/material/titanium =SHEET_MATERIAL_AMOUNT)

/obj/item/rbmk_upgrade/auto_vent/apply_upgrade(obj/machinery/power/rbmk2/machine)
	machine.auto_vent_upgrade = TRUE
	return TRUE

/obj/item/rbmk_upgrade/auto_vent/can_upgrade(obj/machinery/power/rbmk2/machine)
	return !machine.auto_vent_upgrade

//Safeties
/obj/item/rbmk_upgrade/safeties
	name = "\improper RB-MK2 软件升级磁盘——安全系统优化"
	desc = "可为 RB-MK 安装安全系统优化升级的磁盘，将安全触发阈值从75%调整至95%，防止过早弹出。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/gold =SHEET_MATERIAL_AMOUNT, /datum/material/uranium =SHEET_MATERIAL_AMOUNT)

/obj/item/rbmk_upgrade/safeties/apply_upgrade(obj/machinery/power/rbmk2/machine)
	machine.safeties_upgrade = TRUE
	machine.RefreshParts()
	return TRUE

/obj/item/rbmk_upgrade/safeties/can_upgrade(obj/machinery/power/rbmk2/machine)
	return !machine.safeties_upgrade

//Overclock
/obj/item/rbmk_upgrade/overclock
	name = "\improper RB-MK2 软件升级磁盘——超频"
	desc = "可为 RB-MK 安装超频功能升级的磁盘。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT, /datum/material/uranium =SHEET_MATERIAL_AMOUNT)

/obj/item/rbmk_upgrade/overclock/apply_upgrade(obj/machinery/power/rbmk2/machine)
	machine.overclocked_upgrade = TRUE
	return TRUE

/obj/item/rbmk_upgrade/overclock/can_upgrade(obj/machinery/power/rbmk2/machine)
	return !machine.overclocked_upgrade




