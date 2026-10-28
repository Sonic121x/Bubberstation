/*
* Designs
*/

/datum/design/health_hud_aviator
	name = "医疗 HUD 飞行员眼镜"
	desc = "一种头戴式显示器，可扫描视野中的人形生物，并提供其健康状况的准确数据。这款 HUD 被装进了一副太阳镜里。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/hud/ar/aviator/health
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/security_hud_aviator
	name = "安保 HUD 飞行员眼镜"
	desc = "一种头戴式显示器，可扫描视野中的人类，并提供其证件状态的准确数据。这款 HUD 被装进了一副太阳镜里。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/clothing/glasses/hud/ar/aviator/security
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/diagnostic_hud_aviator
	name = "诊断 HUD 飞行员眼镜"
	desc = "一种用于分析并判定机械装置故障的头戴式显示器。这款 HUD 被装进了一副太阳镜里。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/hud/ar/aviator/diagnostic
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/meson_hud_aviator
	name = "介子 HUD 飞行员眼镜"
	desc = "工程与采矿人员使用的头戴式显示器，可不受光照条件影响，隔着墙壁看到基础结构与地形布局。这款 HUD 被装进了一副太阳镜里。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/hud/ar/aviator/meson
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/science_hud_aviator
	name = "科学飞行员眼镜"
	desc = "一副俗气的紫色飞行员太阳镜，佩戴者只需一瞥就能辨认各种化合物。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/hud/ar/aviator/science
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/health_hud_projector
	name = "视网膜投影医疗 HUD"
	desc = "一副配有扫描镜片和内置视网膜投影器的头戴式设备。它不提供任何眼部防护，但比护目镜更不显眼。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/hud/ar/projector/health
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/security_hud_projector
	name = "视网膜投影安保 HUD"
	desc = "一副配有扫描镜片和内置视网膜投影器的头戴式设备。它不提供任何眼部防护，但比护目镜更不显眼。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/clothing/glasses/hud/ar/projector/security
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/diagnostic_hud_projector
	name = "视网膜投影诊断 HUD"
	desc = "一副配有扫描镜片和内置视网膜投影器的头戴式设备。它不提供任何眼部防护，但比护目镜更不显眼。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/hud/ar/projector/diagnostic
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/meson_hud_projector
	name = "视网膜投影介子 HUD"
	desc = "一副配有扫描镜片和内置视网膜投影器的头戴式设备。它不提供任何眼部防护，但比护目镜更不显眼。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/hud/ar/projector/meson
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/science_hud_projector
	name = "科学视网膜投影器"
	desc = "一副配有扫描镜片和内置视网膜投影器的头戴式设备。它不提供任何眼部防护，但比护目镜更不显眼。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/clothing/glasses/hud/ar/projector/science
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL
