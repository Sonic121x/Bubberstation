/obj/item/disk/surgery
	name = "手术程序磁盘"
	desc = "内含高级手术程序的磁盘，必须载入手术控制台。"
	icon_state = "datadisk1"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass=SMALL_MATERIAL_AMOUNT)
	/// List of surgical operations contained on this disk
	var/list/surgeries

/obj/item/disk/surgery/debug
	name = "调试手术磁盘"
	desc = "内含所有现有手术程序的磁盘。"
	icon_state = "datadisk1"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass=SMALL_MATERIAL_AMOUNT)

/obj/item/disk/surgery/debug/Initialize(mapload)
	. = ..()
	surgeries = list()
	for(var/datum/surgery_operation/operation as anything in GLOB.operations.get_instances_from(subtypesof(/datum/surgery_operation)))
		surgeries += operation.type

/obj/item/disk/surgery/advanced_plastic_surgery
	name = "高级整形手术磁盘"
	desc = "提供如何执行更复杂的整形手术的说明。"

	surgeries = list(
		/datum/surgery_operation/limb/add_plastic,
	)

/obj/item/disk/surgery/advanced_plastic_surgery/examine(mob/user)
	. = ..()
	. += span_info("解锁<b>[/datum/surgery_operation/limb/add_plastic::name]</b>手术。")
	. += span_info("在<i>[/datum/surgery_operation/limb/plastic_surgery::name]</i>之前执行此操作可升级该手术，\
		让你能复制任何人的外貌——\
		只要手术期间副手持有他们的照片。")

/obj/item/disk/surgery/advanced_plastic_surgery/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore = "由于基因技术的进步，大多数整形手术都已过时。\
			非常基础的方法仍在使用，但已十分罕见，主要用于修复患者的外貌损伤。\
			因此，这件物品成了许多收藏家眼中的古董——\
			不过仍有一些后巷外科医生会为了它那如今罕见的学识而四处寻找。" \
	)

/obj/item/disk/surgery/brainwashing
	name = "洗脑手术磁盘"
	desc = "提供如何向大脑植入命令、使其成为患者首要目标的说明。"
	surgeries = list(
		/datum/surgery_operation/organ/brainwash,
		/datum/surgery_operation/organ/brainwash/mechanic,
	)

/obj/item/disk/surgery/sleeper_protocol
	name = "可疑手术磁盘"
	desc = "提供如何将患者转化为辛迪加沉睡特工的说明。"
	surgeries = list(
		/datum/surgery_operation/organ/brainwash/sleeper,
		/datum/surgery_operation/organ/brainwash/sleeper/mechanic,
	)
