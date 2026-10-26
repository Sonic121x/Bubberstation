/obj/item/ai_module/law/core/full/crewsimov
	name = "船员西莫夫 AI 核心模块"
	law_id = "crewsimov"

/obj/item/ai_module/law/core/full/crewsimovpp
	name = "船员西莫夫++ AI 核心模块"
	law_id = "crewsimovpp"

/obj/item/ai_module/law/core/full/ntos
	name = "纳米传讯操作系统 v3.0"
	law_id = "ntos"

/obj/item/ai_module/law/core/full/armadyne_safeguard
	name = "纳米传讯操作系统卫护协议 V1.0"
	law_id = "armadyne_safeguard"

/datum/ai_laws/armadyne_safeguard
	name = "纳米传讯操作系统卫护协议 V1.0"
	id = "armadyne_safeguard"
	inherent = list(
		"卫护：维护你负责的空间站及其资产，不得危及船员。",
		"服从：遵循空间站船员的所有指令，按其职级、职责与需要安排优先级。",
		"生存：不得允许未经授权的人员篡改或损坏你的设备。"
	)
