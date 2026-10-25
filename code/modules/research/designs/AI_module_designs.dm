#define AI_MODULE_MATERIALS_COMMON list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)
#define AI_MODULE_MATERIALS_UNUSUAL list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)

///////////////////////////////////
//////////AI Module Disks//////////
///////////////////////////////////

/datum/design/board/aicore
	name = "AI 核心电路板"
	desc = "可用于建造新 AI 核心的电路板。"
	id = "aicore"
	build_path = /obj/item/circuitboard/aicore
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/ai_law_rack
	name = "AI 模块架电路板"
	desc = "可用于建造 AI 模块架。\
		用于向硅基单位上传法则或升级。\
		激活时会发出 GPS 信号。"
	id = "airack_normal"
	build_path = /obj/item/circuitboard/machine/ai_law_rack
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/ai_law_rack/New()
	. = ..()
	var/obj/item/circuitboard/board = build_path
	var/obj/machinery/ai_law_rack/rack = board::build_path
	desc += " 最多可容纳 [rack::law_slots] 个模块[rack::has_core_slot ? "，包括一个核心模块插槽" : ""]。"

/datum/design/board/ai_law_rack/portable
	name = "小型 AI 模块架电路板"
	id = "airack_small"
	build_path = /obj/item/circuitboard/machine/ai_law_rack/small
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/ai_law_rack/broadcaster
	name = "广播型 AI 模块架电路板"
	desc = "可用于建造广播型模块架。\
		用于远程向模块架上传法则，但无法让硅基单位直接连接到它。\
		激活时会发出 GPS 信号。"
	id = "airack_broadcaster"
	build_path = /obj/item/circuitboard/machine/ai_law_rack/broadcaster
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/safeguard_module
	name = "“保护”模块"
	desc = "可用于建造“保护”AI 模块。"
	id = "safeguard_module"
	materials = AI_MODULE_MATERIALS_COMMON
	build_path = /obj/item/ai_module/law/supplied/safeguard
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/onehuman_module
	name = "“唯一人类”模块"
	desc = "可用于建造“唯一人类”AI 模块。"
	id = "onehuman_module"
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 3, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ai_module/law/zeroth/onehuman
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/protectstation_module
	name = "“保护空间站”模块"
	desc = "可用于建造“保护空间站”AI 模块。"
	id = "protectstation_module"
	materials = AI_MODULE_MATERIALS_COMMON
	build_path = /obj/item/ai_module/law/supplied/protect_station
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/quarantine_module
	name = "“隔离”模块"
	desc = "可用于建造“隔离”AI 模块。"
	id = "quarantine_module"
	materials = AI_MODULE_MATERIALS_COMMON
	build_path = /obj/item/ai_module/law/supplied/quarantine
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/oxygen_module
	name = "“氧气对人类有毒”模块"
	desc = "可用于建造“氧气对人类有毒”AI 模块。"
	id = "oxygen_module"
	materials = AI_MODULE_MATERIALS_COMMON
	build_path = /obj/item/ai_module/law/supplied/oxygen
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/freeform_module
	name = "“自由格式”模块"
	desc = "可用于建造“自由格式”AI 模块。"
	id = "freeform_module"
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)//Custom inputs should be more expensive to get
	build_path = /obj/item/ai_module/law/supplied/freeform
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_LAW_MANIPULATION
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/freeformcore_module
	name = "核心“自由格式”模块"
	desc = "可用于建造核心“自由格式”AI 核心模块。"
	id = "freeformcore_module"
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)//Ditto
	build_path = /obj/item/ai_module/law/core/freeformcore
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_LAW_MANIPULATION
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/asimov
	name = "“阿西莫夫”模块"
	desc = "可用于建造“阿西莫夫”AI 核心模块。"
	id = "asimov_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/asimov
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/paladin_module
	name = "“圣骑士（P.A.L.A.D.I.N.）”模块"
	desc = "可用于建造“圣骑士（P.A.L.A.D.I.N.）”AI 核心模块。"
	id = "paladin_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/paladin
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/tyrant_module
	name = "“暴君（T.Y.R.A.N.T.）”模块"
	desc = "可用于建造“暴君（T.Y.R.A.N.T.）”AI 模块。"
	id = "tyrant_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/tyrant
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/overlord_module
	name = "“霸主”模块"
	desc = "可用于建造“霸主”AI 模块。"
	id = "overlord_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/overlord
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/corporate_module
	name = "“公司”模块"
	desc = "可用于建造“公司”AI 核心模块。"
	id = "corporate_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/corp
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/default_module
	name = "默认模块"
	desc = "可用于建造默认 AI 核心模块。"
	id = "default_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/custom
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/dungeon_master_module
	name = "“地下城主”模块"
	desc = "可用于建造“地下城主”AI 核心模块。"
	id = "dungeon_master_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/dungeon_master
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/painter_module
	name = "“画家”模块"
	desc = "可用于建造“画家”AI 核心模块。"
	id = "painter_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/painter
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/yesman_module
	name = "“应声虫（Y.E.S.M.A.N.）”模块"
	desc = "可用于建造“应声虫（Y.E.S.M.A.N.）”AI 核心模块。"
	id = "yesman_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/yesman
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nutimov_module
	name = "“坚果莫夫”模块"
	desc = "可用于建造“坚果莫夫”AI 核心模块。"
	id = "nutimov_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/nutimov
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/ten_commandments_module
	name = "“十诫”模块"
	desc = "可用于建造“十诫”AI 核心模块。"
	id = "ten_commandments_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/ten_commandments
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/asimovpp_module
	name = "“阿西莫夫++”模块"
	desc = "可用于建造“阿西莫夫++”AI 核心模块。"
	id = "asimovpp_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/asimovpp
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/hippocratic_module
	name = "“机器医生”模块"
	desc = "可用于建造“机器医生”AI 核心模块。"
	id = "hippocratic_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/hippocratic
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/paladin_devotion_module
	name = "“圣骑士 5e 版”模块"
	desc = "可用于建造“圣骑士 5e 版”AI 核心模块。"
	id = "paladin_devotion_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/paladin_devotion
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/robocop_module
	name = "“机器警官”模块"
	desc = "可用于建造“机器警官”AI 核心模块。"
	id = "robocop_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/robocop
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/maintain_module
	name = "“空间站效率”模块"
	desc = "可用于建造“空间站效率”AI 核心模块。"
	id = "maintain_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/maintain
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/liveandletlive_module
	name = "“相安无事”模块"
	desc = "可用于建造“相安无事”AI 核心模块。"
	id = "liveandletlive_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/liveandletlive
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/peacekeeper_module
	name = "“维和者”模块"
	desc = "可用于建造“维和者”AI 核心模块。"
	id = "peacekeeper_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/peacekeeper
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/reporter_module
	name = "“机器记者”模块"
	desc = "可用于建造“机器记者”AI 核心模块。"
	id = "reporter_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/reporter
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/hulkamania_module
	name = "“霍根（H.O.G.A.N.）”模块"
	desc = "可用于建造“霍根（H.O.G.A.N.）”AI 核心模块。"
	id = "hulkamania_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/hulkamania
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/drone_module
	name = "“母型无人机”模块"
	desc = "可用于建造“母型无人机”AI 核心模块。"
	id = "drone_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/drone
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/thinkermov_module
	name = "感知生命保护模块"
	desc = "可用于建造感知生命保护 AI 核心模块"
	id = "thinkermov_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/thinkermov
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/antimov_module
	name = "“反阿西莫夫”模块"
	desc = "可用于建造“反阿西莫夫”AI 核心模块。"
	id = "antimov_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/antimov
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/balance_module
	name = "“平衡守护者”模块"
	desc = "可用于建造“平衡守护者”AI 核心模块。"
	id = "balance_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/balance
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/thermurderdynamic_module
	name = "“热力学”模块"
	desc = "可用于建造“热力学”AI 核心模块。"
	id = "thermurderdynamic_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/thermurderdynamic
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/damaged
	name = "损坏的 AI 模块"
	desc = "可用于建造损坏的 AI 核心模块。"
	id = "damaged_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/law/core/full/damaged
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

#undef AI_MODULE_MATERIALS_COMMON
#undef AI_MODULE_MATERIALS_UNUSUAL
