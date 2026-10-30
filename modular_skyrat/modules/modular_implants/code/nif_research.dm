/datum/design/nifsoft_remover
	name = "洛普兰“牧马人”NIF 切割器"
	desc = "一种小型装置，可让使用者从 NIF 用户身上移除 NIFSoft。"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/nifsoft_remover
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SECURITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/nifsoft_money_sense
	name = "自动估价 NIFSoft"
	desc = "一张包含自动估价 NIFSoft 的 NIFSoft 数据磁盘。"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/disk/nifsoft_uploader/money_sense
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_CARGO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/soulcatcher_device
	name = "唤魂型 RSD"
	desc = "一种 RSD 仪器，可让使用者将意识从躯体中抽出并以虚拟形式储存。"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/handheld_soulcatcher
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mini_soulcatcher
	name = "骚灵型 RSD"
	desc = "灵魂捕手的微型版本，可附着在各种物体上。"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/attachable_soulcatcher
	materials = list(
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_MISC,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/nifsoft_hud
	abstract_type = /datum/design/nifsoft_hud
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	category = list(
		RND_CATEGORY_EQUIPMENT,
	)

/datum/design/nifsoft_hud/medical
	name = "医疗 HUD NIFSoft"
	desc = "一张包含医疗 HUD NIFSoft 的 NIFSoft 数据磁盘。"
	build_path = /obj/item/disk/nifsoft_uploader/med_hud
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/nifsoft_hud/security
	name = "安保 HUD NIFSoft"
	desc = "一张包含安保 HUD NIFSoft 的 NIFSoft 数据磁盘。"
	build_path = /obj/item/disk/nifsoft_uploader/sec_hud
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/nifsoft_hud/cargo
	name = "许可 HUD NIFSoft"
	desc = "一张包含许可 HUD NIFSoft 的 NIFSoft 数据磁盘。"
	build_path = /obj/item/disk/nifsoft_uploader/permit_hud
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/nifsoft_hud/diagnostic
	name = "诊断 HUD NIFSoft"
	desc = "一张包含诊断 HUD NIFSoft 的 NIFSoft 数据磁盘。"
	build_path = /obj/item/disk/nifsoft_uploader/diag_hud
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/nifsoft_hud/science
	name = "科学 HUD NIFSoft"
	desc = "一张包含科学 HUD NIFSoft 的 NIFSoft 数据磁盘。"
	build_path = /obj/item/disk/nifsoft_uploader/sci_hud
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/nifsoft_hud/meson
	name = "介子 HUD NIFSoft"
	desc = "一张包含介子 HUD NIFSoft 的 NIFSoft 数据磁盘。"
	build_path = /obj/item/disk/nifsoft_uploader/meson_hud
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/nif_hud_kit
	name = "NIF HUD 改装套件"
	desc = "一套改装套件，可将部分眼镜改造为显示 NIF 的 HUD。"
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SECURITY
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	category = list(
		RND_CATEGORY_EQUIPMENT,
	)
	build_path = /obj/item/nif_hud_adapter

