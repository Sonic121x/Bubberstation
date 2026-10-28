/obj/item/borg/upgrade/transform/ntjack
	name = "半机械人模块选择器（中央指挥部）"
	desc = "让你能把半机械人转变为实验性纳米传讯半机械人。"
	icon_state = "module_illegal"
	new_model = /obj/item/robot_model/centcom

/obj/item/borg/upgrade/transform/ntjack/action(mob/living/silicon/robot/cyborg, user = usr)
	return ..()

/obj/item/borg/upgrade/transform/security
	name = "半机械人型号选择器（安保）"
	desc = "让你能把半机械人转变为安保型号，随之而来的自然是满地的烂安保。"
	icon_state = "module_security"
	new_model = /obj/item/robot_model/security

//Research borg upgrades

//ADVANCED ROBOTICS REPAIR
/obj/item/borg/upgrade/healthanalyzer
	name = "科研半机械人高级健康分析仪"
	desc = "将科研型号半机械人的标准健康分析仪升级为高级型号。"
	icon_state = "module_medical"
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/healthanalyzer/advanced)
	items_to_remove = list(/obj/item/healthanalyzer)


//Science inducer
/obj/item/borg/upgrade/inducer_sci
	name = "科研集成式感应充电器"
	desc = "一种集成式感应充电器，可利用半机械人提供的电力为设备的内部电池充电。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/inducer/cyborg/sci)

//Bluespace RPED
/obj/item/borg/upgrade/brped
	name = "科研半机械人快速部件更换装置升级"
	desc = "将科研型号半机械人的标准 RPED 升级为蓝空间型号。"
	icon_state = "module_engineer"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/storage/part_replacer/bluespace)
	items_to_remove = list(/obj/item/storage/part_replacer)

// Drapes upgrades
/obj/item/borg/upgrade/processor/Initialize(mapload)
	. = ..()
	model_type += /obj/item/robot_model/sci
	model_flags += BORG_MODEL_RESEARCH

// Engineering BRPED
/obj/item/borg/upgrade/rped/Initialize(mapload)
	. = ..()
	items_to_add = list(/obj/item/storage/part_replacer/bluespace)
	items_to_add -= list(/obj/item/storage/part_replacer)

//Upgrade for the experi scanner
/obj/item/borg/upgrade/experi_scanner
	name = "科研半机械人蓝空间实验扫描仪"
	desc = "将科研型号半机械人的标准健康分析仪升级为高级型号。"
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/experi_scanner/bluespace)
	items_to_remove = list(/obj/item/experi_scanner)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)


// Borg Dom Aura :)
/obj/item/borg/upgrade/dominatrixmodule/action(mob/living/silicon/robot/borg, mob/living/user)
	if(borg.hasToys)
		to_chat(usr, span_warning("本单位已安装了“娱乐”模块！"))
		return FALSE
	. = ..()
	if(.)
		borg.hasToys = TRUE
		borg.add_quirk(/datum/quirk/dominant_aura)

/obj/item/borg/upgrade/dominatrixmodule/deactivate(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	if(.)
		if(borg.hasToys)
			borg.hasToys = FALSE
		borg.remove_quirk(/datum/quirk/dominant_aura)

// Engineering RLD
/obj/item/borg/upgrade/rld
	name = "工程半机械人快速照明装置升级"
	desc = "一种升级模块，让半机械人得以使用快速照明装置。"
	icon_state = "module_engineer"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/janitor)
	model_flags = list(BORG_MODEL_ENGINEERING, BORG_MODEL_JANITOR)
	items_to_add = list(/obj/item/construction/rld/cyborg)

// Borg Advanced Xenoarchaeology Bag

/obj/item/borg/upgrade/xenoarch/adv
	name = "半机械人高级异星考古袋"
	desc = "一种改进型收纳袋，用于为科研拾取奇异的岩石。"
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner, /obj/item/robot_model/sci)
	model_flags = list(BORG_MODEL_MINER, BORG_MODEL_RESEARCH)
	items_to_add = list(/obj/item/storage/bag/xenoarch/adv)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 2.5)

// Mining Borg Vent Pinpointer

/obj/item/borg/upgrade/pinpointer/vent
	name = "通风口定位仪"
	desc = "一种模块化追踪装置，能定位并指向附近的通风口。"
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/pinpointer/vent)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT)

//Borg Proto-Kinetic Accelerators

/obj/item/borg/upgrade/modkit/action(mob/living/silicon/robot/mining_mods)
	. = ..()
	if (.)
		for(var/obj/item/gun/energy/recharge/kinetic_accelerator/pkamods in mining_mods.model.modules)
			return install(pkamods, usr, FALSE)

/obj/item/gun/energy/recharge/kinetic_accelerator/railgun/cyborg
	desc = "便携式粒子加速器，仅可在熔岩地带使用。"
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/repeater/cyborg
	desc = "一种配备三发弹匣的 PKA。"
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/shotgun/cyborg
	desc = "一种一次射出三发、冷却时间更长的 PKA。"
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/glock/cyborg
	desc = "一种短管 PKA，模式容量更高，但伤害与射程较低。"
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave/cyborg
	desc = "在用户周围制造冲击波，威力与基础 PKA 相同。"
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/m79/cyborg
	desc = "发射采矿 MOD 模块化外骨骼所用的同款炸弹，仅可在熔岩地带使用。"
	holds_charge = TRUE
	unique_frequency = TRUE

// Mining Borg PKA Upgrades

/obj/item/borg/upgrade/kinetic_accelerator/railgun/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/railgun/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)

/obj/item/borg/upgrade/kinetic_accelerator/repeater/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/repeater/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/borg/upgrade/kinetic_accelerator/shotgun/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/shotgun/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT)

/obj/item/borg/upgrade/kinetic_accelerator/glock/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/glock/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT)

/obj/item/borg/upgrade/kinetic_accelerator/shockwave/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)

/obj/item/borg/upgrade/kinetic_accelerator/m79/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/m79/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)

/// "Good Borg" Obedience Training
/mob/living/silicon/robot
	var/hasToys = FALSE

/obj/item/borg/upgrade/obediencemodule
	name = "半机械人服从模块"
	desc = "一种大幅提升半机械人表达亲昵能力的模块。"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_lust"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	custom_price = 0

	items_to_add = list(/obj/item/kinky_shocker,
						/obj/item/clothing/mask/leatherwhip,
						/obj/item/spanking_pad,
						/obj/item/tickle_feather,
						/obj/item/clothing/erp_leash,
						)

// WellTrained Obedience Behaviour
/obj/item/borg/upgrade/obediencemodule/action(mob/living/silicon/robot/borg, mob/living/user)
	if(borg.hasToys)
		to_chat(usr, span_warning("本单位已安装了“娱乐”模块！"))
		return FALSE
	. = ..()
	if(.)
		borg.hasToys = TRUE
		borg.add_quirk(/datum/quirk/well_trained)

/obj/item/borg/upgrade/obediencemodule/deactivate(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	if(.)
		if(borg.hasToys)
			borg.hasToys = FALSE

		borg.remove_quirk(/datum/quirk/well_trained)

/obj/item/borg/upgrade/detailer
	name = "清洁半机械人细节处理工具组"
	desc = "升级清洁半机械人的铺砖能力，并额外赋予修改地板贴花的能力。"
	icon_state = "module_janitor"
	custom_materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*15.25,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*1.5,
	)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR

	items_to_add = list(/obj/item/construction/rtd/borg,
						/obj/item/airlock_painter/decal/cyborg,
						)

/obj/item/borg/upgrade/cyborg_cable_coil
	name = "集成电缆盘"
	desc = "压缩卷绕技术让清洁半机械人模块也能携带线缆工具。"
	icon_state = "module_janitor"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR

	items_to_add = list (/obj/item/stack/cable_coil)

//Research cyborg RCD

/obj/item/borg/upgrade/robotics_rcd
	name = "科研半机械人合成体维修工具"
	desc = "一种精简版 RCD，专为协助合成体维修而设计。"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/construction/rcd/borg/robotics_rcd)

/obj/item/borg/upgrade/hypospray
	model_type = list(/obj/item/robot_model/medical, /obj/item/robot_model/tarkon)
	model_flags = list(BORG_MODEL_MEDICAL, BORG_MODEL_TARKON)
