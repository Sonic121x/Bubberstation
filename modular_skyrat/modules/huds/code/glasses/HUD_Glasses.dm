/obj/item/clothing/glasses/hud/health/prescription
	name = "处方生命扫描 HUD"
	desc = "一种平视显示器，可扫描视野中的人形生物并提供其健康状况的准确数据。此款配备处方镜片。"
	icon = 'modular_skyrat/modules/huds/icons/huds.dmi'
	icon_state = "glasses_healthhud"
	worn_icon = 'modular_skyrat/modules/huds/icons/hudeyes.dmi'
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)

/obj/item/clothing/glasses/hud/health/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/diagnostic/prescription
	name = "处方诊断 HUD"
	desc = "一种平视显示器，能分析机器人和外骨骼的完整性与状态。此款配备处方镜片。"
	icon = 'modular_skyrat/modules/huds/icons/huds.dmi'
	icon_state = "glasses_diagnostichud"
	worn_icon = 'modular_skyrat/modules/huds/icons/hudeyes.dmi'
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
	)

/obj/item/clothing/glasses/hud/diagnostic/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/security/prescription
	name = "处方安保 HUD"
	desc = "一种平视显示器，可扫描视野中的人形生物并提供其 ID 状态和安保记录的准确数据。此款配备处方镜片。"
	icon = 'modular_skyrat/modules/huds/icons/huds.dmi'
	icon_state = "glasses_securityhud"
	worn_icon = 'modular_skyrat/modules/huds/icons/hudeyes.dmi'
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)

/obj/item/clothing/glasses/hud/security/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/science/prescription
	name = "处方科研护目镜"
	desc = "这副护目镜可扫描容器的内容物，并以易于阅读的格式呈现给使用者。此款配备处方镜片。"
	icon = 'modular_skyrat/modules/huds/icons/huds.dmi'
	icon_state = "glasses_sciencehud"
	worn_icon = 'modular_skyrat/modules/huds/icons/hudeyes.dmi'
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
	)
	glass_colour_type = /datum/client_colour/glass_colour/purple
	armor_type = /datum/armor/prescription_science

/obj/item/clothing/glasses/science/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/datum/armor/prescription_science
	fire = 80
	acid = 100

/obj/item/clothing/glasses/meson/prescription
	name = "处方光学介子扫描仪"
	desc = "供工程与采矿人员使用，可透过墙壁看到基础结构与地形布局，不受光照条件影响。此款已装上处方镜片。"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)

/obj/item/clothing/glasses/meson/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/meson/engine/prescription
	name = "处方工程扫描眼镜"
	desc = "工程师使用的眼镜。介子扫描模式可让你隔着墙壁看到基础结构与地形布局，T 射线扫描模式可让你看到地板下的物体，如电缆和管道，辐射扫描模式则能让你看到受辐射污染的物体。每片镜片均已替换为矫正镜片。"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SMALL_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)

/obj/item/clothing/glasses/meson/engine/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/meson/engine/tray/prescription
	name = "处方光学 T 射线扫描仪"
	desc = "工程师使用的眼镜。介子扫描模式可让你隔着墙壁看到基础结构与地形布局，T 射线扫描模式可让你看到地板下的物体，如电缆和管道，辐射扫描模式则能让你看到受辐射污染的物体。此款的镜片有助于矫正视力。"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT,
	)

/obj/item/clothing/glasses/meson/engine/tray/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)
