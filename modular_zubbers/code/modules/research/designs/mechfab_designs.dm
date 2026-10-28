// Empty shell

/datum/design/synthclone
	name = "空白合成人躯壳"
	id = "blanksynth"
	build_type = MECHFAB
	construction_time = 60 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.25
	)
	category = list(RND_CATEGORY_MECHFAB_SYNTH + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS)
	inherit_materials = DESIGN_DONT_INHERIT_MATS

	build_path = /mob/living/carbon/human/species/synth/empty

/datum/design/borg_upgrade_advcutter
	name = "高级等离子切割器"
	id = "borg_upgrade_advcutter"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/advcutter
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 40
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

//research cyborg upgrades
/datum/design/borg_upgrade_advancedhealth
	name = "研究型高级健康分析仪"
	id = "borg_upgrade_advancedanalyzer"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/healthanalyzer
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH,
	)

//Blue space Rped upgrade
/datum/design/borg_upgrade_brped
	name = "蓝空间快速部件更换装置"
	id = "borg_upgrade_brped"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/brped
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/borg_upgrade_research_rcd
	name = "研究型半机械人合成体修复工具"
	id = "borg_upgrade_research_rcd"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/robotics_rcd
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/borg_upgrade_inducer_sci
	name = "研究型半机械人感应充电器"
	id = "borg_upgrade_inducer_sci"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/inducer_sci
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/borg_dominatrix
	name = "半机械人调教模块"
	id = "dominatrixmodule"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/dominatrixmodule
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_obedience
	name = "半机械人服从模块"
	id = "obediencemodule"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/obediencemodule
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_waddle
	name = "半机械人摇摆模块"
	id = "waddle_module"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/waddle_module
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

//so we have our own category
/datum/design/borg_upgrade_surgical_processor_sci
	name = "研究型外科手术处理器"
	id = "borg_upgrade_surgicalprocessor_sci"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/processor
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

//Some new toys
/datum/design/experi_scanner/bluespace_borg
	name = "半机械人蓝空间实验扫描仪"
	desc = "一种实验扫描仪的变体，可远程执行实验扫描。"
	id = "bs_experi_scanner_cyborg"
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/experi_scanner
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/module/mind_transfer
	name = "思维转移模块"
	id = "mod_mind_transfer"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/mod/module/mind_swap
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/rld
	name = "半机械人快速照明装置"
	desc = "一种可快速、远距离部署照明灯与荧光棒的工具。"
	id = "rld_cyborg"
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/rld
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)

//	JANITOR CYBORG UPGRADES

/datum/design/borg_upgrade_detailer
	name = "细节修饰工具"
	id = "borg_upgrade_detailer"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/detailer
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*15.25,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*1.5,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)

/datum/design/rld_janitor
	name = "半机械人快速照明装置"
	desc = "一种可快速、远距离部署照明灯与荧光棒的工具。"
	id = "rld_cyborg_janitor"
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/rld
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)

/datum/design/cyborg_cable_coil
	name = "集成电缆线圈"
	desc = "紧凑的线轴技术让清洁模块也能携带线缆工具。"
	id = "cable_coil_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/cyborg_cable_coil
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)

/datum/design/xenoarch/equipment/bag_adv_borg
	name = "半机械人高级异星考古袋"
	desc = "一种改进型袋子，用于为科学研究收集奇特的岩石。"
	id = "adv_xenoarchbag_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/borg/upgrade/xenoarch/adv
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/pinpointer/vent
	name = "矿脉指示器"
	desc = "一种模块化追踪装置，可定位并指向附近的矿脉喷口。"
	id = "pinpointer_vent_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/pinpointer/vent
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/module/protean/servo
	name = "普罗蒂安伺服模块"
	id = "mod_protean_servo"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/protean_servo

/datum/design/module/hat_stabilizer
	name = "MOD 帽子固定模块"
	id = "mod_hat_stabilizer"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/mod/module/hat_stabilizer
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

//Borg PKAs

/datum/design/kinetic_accelerator/railgun/cyborg
	name = "原型动能轨道炮"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::desc
	id = "pka_railgun_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/railgun/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/repeater/cyborg
	name = "原型动能连发枪"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::desc
	id = "pka_repeater_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/repeater/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/shotgun/cyborg
	name = "原型动能霰弹枪"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::desc
	id = "pka_shotgun_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/shotgun/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/glock/cyborg
	name = "原型动能手枪"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::desc
	id = "pka_pistol_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/glock/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/shockwave/cyborg
	name = "原型动能冲击波发生器"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::desc
	id = "pka_shockwave_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/shockwave/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/m79/cyborg
	name = "原型动能榴弹发射器"
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::desc
	id = "pka_m79_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/m79/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)
