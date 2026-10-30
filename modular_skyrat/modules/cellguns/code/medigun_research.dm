#define RND_SUBCATEGORY_WEAPONS_MEDICALAMMO "/医疗弹药"
#define RND_MEDICALAMMO_UTILITY "（功能）"

//Upgrade Kit//
/datum/design/medigun_speedkit
	name = "VeyMedical CWM-479 升级套件"
	desc = "为 VeyMedical CWM-479 提供更高容量内部电池和更快充电速率的升级套件。"
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
	materials = list(
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	build_path = /obj/item/custom_kit/medigun_fastcharge

/datum/design/medicell
	abstract_type = /datum/design/medicell
	name = "基础医疗电池设计"
	desc = "嘿，你不该看到这个。真的……完全不该。"
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_MEDICALAMMO,
	)

//Tier 2 Medicells//

/datum/design/medicell/brute2
	name = "钝击 II 医疗电池"
	desc = "为电池装填型医疗枪提供改良的钝击伤害治疗功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/tier_2/brute

/datum/design/medicell/burn2
	name = "灼伤 II 医疗电池"
	desc = "为电池装填型医疗枪提供改良的灼伤伤害治疗功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/tier_2/burn

/datum/design/medicell/toxin2
	name = "毒素 II 医疗电池"
	desc = "为电池装填型医疗枪提供改良的毒素伤害治疗功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/tier_2/toxin

/datum/design/medicell/oxy2
	name = "氧气 II 医疗电池"
	desc = "为电池装填型医疗枪提供改良的缺氧治疗功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/tier_2/oxygen

//Tier 3 Medicells//

/datum/design/medicell/brute3
	name = "钝击 III 医疗电池"
	desc = "为电池装填型医疗枪提供高级的钝击伤害治疗功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/tier_3/brute

/datum/design/medicell/burn3
	name = "灼伤 III 医疗电池"
	desc = "为电池装填型医疗枪提供高级的灼伤伤害治疗功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/tier_3/burn

/datum/design/medicell/toxin3
	name = "毒素 III 医疗电池"
	desc = "为电池装填型医疗枪提供高级的毒素伤害治疗功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/tier_3/toxin

/datum/design/medicell/oxy3
	name = "氧气 III 医疗电池"
	desc = "为电池装填型医疗枪提供高级的缺氧治疗功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/tier_3/oxygen

//Utility Medicells

/datum/design/medicell/utility
	abstract_type = /datum/design/medicell/utility
	name = "功能型医疗电池"
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_MEDICALAMMO + RND_MEDICALAMMO_UTILITY,
	)

/datum/design/medicell/utility/clot
	name = "凝血医疗电池"
	desc = "为电池装填型医疗枪提供基于弹丸的凝血功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/weaponcell/medical/utility/clotting

/datum/design/medicell/utility/temp
	name = "体温调节医疗电池"
	desc = "为电池装填型医疗枪提供基于弹丸的体温调节功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/weaponcell/medical/utility/temperature

/datum/design/medicell/utility/gown
	name = "硬光病号服医疗电池"
	desc = "为电池装填型医疗枪提供基于弹丸的硬光病号服投放功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/weaponcell/medical/utility/hardlight_gown

/datum/design/medicell/utility/bed
	name = "硬光担架床医疗电池"
	desc = "为电池装填型医疗枪提供基于弹丸的硬光担架床投放功能。最好用于已经躺平的患者。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/utility/bed

/datum/design/medicell/utility/salve
	name = "空药膏医疗电池"
	desc = "一块不完整的医疗电池，需要一片芦荟叶才能完全实现其通过弹丸嵌入提供持续治疗的功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/custom_kit/empty_cell

/datum/design/medicell/utility/body
	name = "空遗体传送医疗电池"
	desc = "一块不完整的医疗电池，需要一份蓝空间史莱姆提取物才能提供基于弹丸的尸体回收功能。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/custom_kit/empty_cell/body_teleporter

/datum/design/medicell/utility/relocation
	name = "强制转移医疗电池"
	desc = "为电池装填型医疗枪提供基于弹丸的围观者转移功能，通过本征态操控将他们丢进医疗部大厅。仅在医疗部内由获得授权者射击时生效。"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/utility/relocation

#undef RND_SUBCATEGORY_WEAPONS_MEDICALAMMO
#undef RND_MEDICALAMMO_UTILITY
