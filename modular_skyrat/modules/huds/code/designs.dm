/datum/design/health_hud_prescription
	name = "处方生命扫描 HUD"
	desc = "一种平视显示器，可扫描视野内的人形生物并提供其健康状况的准确数据。此款配备处方镜片。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/hud/health/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/security_hud_prescription
	name = "处方安保 HUD"
	desc = "一种平视显示器，可扫描视野内的人形生物并提供其 ID 状态的准确数据。此款配备处方镜片。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/hud/security/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/diagnostic_hud_prescription
	name = "处方诊断 HUD"
	desc = "一种用于分析并判定机械装置故障的 HUD。此款配备处方镜片。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/hud/diagnostic/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/science_hud_prescription
	name = "处方科研 HUD"
	desc = "这副护目镜可扫描容器的内容物，并以易于阅读的格式呈现给使用者。此款配备处方镜片。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/science/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/mesons_prescription
	name = "处方光学介子扫描仪"
	desc = "供工程与采矿人员使用，可透过墙壁看到基础结构与地形布局，不受光照条件影响。此设计已加入处方镜片。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/meson/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/engine_goggles_prescription
	name = "处方工程扫描眼镜"
	desc = "工程师使用的眼镜。介子扫描模式可让你隔着墙壁看到基础结构与地形布局，不受光照条件影响。T 射线扫描模式则让你看到地板下的物体，如电缆和管道。此设计已加入处方镜片。"
	build_type = PROTOLATHE | AWAY_LATHE | COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SMALL_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/meson/engine/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/tray_goggles_prescription
	name = "处方光学 T 射线扫描仪"
	desc = "供工程人员使用，可看到地板下的物体，如电缆和管道。此设计已加入处方镜片。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/clothing/glasses/meson/engine/tray/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
