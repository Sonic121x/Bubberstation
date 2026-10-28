/datum/design/nanite_disk
	name = "纳米机器人程序磁盘"
	desc = "用于储存纳米机器人程序。"
	id = "nanite_disk"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 300, /datum/material/glass = 100)
	build_path = /obj/item/disk/nanite_program
	category = list("Electronics")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nanite_chamber_control
	name = "电脑设计（纳米机器人舱控制台）"
	desc = "可用于建造新的纳米机器人舱控制台的电路板。"
	id = "nanite_chamber_control"
	build_path = /obj/item/circuitboard/computer/nanite_chamber_control
	category = list("Computer Boards")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nanite_cloud_control
	name = "电脑设计（纳米机器人云控制台）"
	desc = "可用于建造新的纳米机器人云控制台的电路板。"
	id = "nanite_cloud_control"
	build_path = /obj/item/circuitboard/computer/nanite_cloud_controller
	category = list("Computer Boards")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nanite_chamber
	name = "机器设计（纳米机器人舱电路板）"
	desc = "纳米机器人舱的电路板。"
	id = "nanite_chamber"
	build_path = /obj/item/circuitboard/machine/nanite_chamber
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/public_nanite_chamber
	name = "机器设计（公共纳米机器人舱电路板）"
	desc = "公共纳米机器人舱的电路板。"
	id = "public_nanite_chamber"
	build_path = /obj/item/circuitboard/machine/public_nanite_chamber
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nanite_programmer
	name = "机器设计（纳米机器人编程器电路板）"
	desc = "纳米机器人编程器的电路板。"
	id = "nanite_programmer"
	build_path = /obj/item/circuitboard/machine/nanite_programmer
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nanite_program_hub
	name = "机器设计（纳米机器人程序中枢电路板）"
	desc = "纳米机器人程序中枢的电路板。"
	id = "nanite_program_hub"
	build_path = /obj/item/circuitboard/machine/nanite_program_hub
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

///////////////////////////////////
//////////Nanite Devices///////////
///////////////////////////////////
/datum/design/nanite_remote
	name = "纳米机器人遥控器"
	desc = "可用于制造纳米机器人遥控器。"
	id = "nanite_remote"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = 500, /datum/material/iron = 500)
	build_path = /obj/item/nanite_remote
	category = list("Electronics")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/nanite_comm_remote
	name = "纳米机器人通讯遥控器"
	desc = "可用于制造纳米机器人通讯遥控器。"
	id = "nanite_comm_remote"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = 500, /datum/material/iron = 500)
	build_path = /obj/item/nanite_remote/comm
	category = list("Electronics")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/nanite_scanner
	name = "纳米机器人扫描仪"
	desc = "可用于制造纳米机器人扫描仪。"
	id = "nanite_scanner"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = 500, /datum/material/iron = 500)
	build_path = /obj/item/nanite_scanner
	category = list("Electronics")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

