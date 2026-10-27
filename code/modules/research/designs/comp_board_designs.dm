///////////////////Computer Boards///////////////////////////////////

/datum/design/board
	name = "空条目电路板"
	desc = "我保证它不会给你辛迪加的好东西！"
	build_type = IMPRINTER | AWAY_IMPRINTER
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)

/datum/design/board/arcade_battle
	name = "对战街机电路板"
	desc = "可用于建造新街机的电路板。"
	id = "arcade_battle"
	build_path = /obj/item/circuitboard/computer/arcade/battle
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENTERTAINMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/orion_trail
	name = "《猎户座之路》街机电路板"
	desc = "可用于建造新《猎户座之路》街机的电路板。"
	id = "arcade_orion"
	build_path = /obj/item/circuitboard/computer/arcade/orion_trail
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENTERTAINMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/seccamera
	name = "安保摄像头电路板"
	desc = "可用于建造安保摄像头电脑的电路板。"
	id = "seccamera"
	build_path = /obj/item/circuitboard/computer/security
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/rdcamera
	name = "研究监控电路板"
	desc = "可用于建造研究摄像头电脑的电路板。"
	id = "rdcamera"
	build_path = /obj/item/circuitboard/computer/research
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/xenobiocamera
	name = "异种生物学控制台电路板"
	desc = "可用于建造异种生物学摄像头电脑的电路板。"
	id = "xenobioconsole"
	build_path = /obj/item/circuitboard/computer/xenobiology
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/med_data
	name = "医疗记录电路板"
	desc = "可用于建造医疗记录控制台的电路板。"
	id = "med_data"
	build_path = /obj/item/circuitboard/computer/med_data
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/operating
	name = "手术电脑电路板"
	desc = "可用于建造手术电脑控制台的电路板。"
	id = "operating"
	build_path = /obj/item/circuitboard/computer/operating
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/pandemic
	name = "泛流行病分析仪 2200 电路板"
	desc = "可用于建造泛流行病分析仪 2200 控制台的电路板。"
	id = "pandemic"
	build_path = /obj/item/circuitboard/computer/pandemic
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/comconsole
	name = "通讯电路板"
	desc = "可用于建造通讯控制台的电路板。"
	id = "comconsole"
	build_path = /obj/item/circuitboard/computer/communications
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_COMMAND
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SECURITY //Honestly should have a bridge techfab for this sometime.

/datum/design/board/bankmachine
	name = "银行机电路板"
	desc = "可用于建造银行机的电路板。"
	id = "bankmachine"
	build_path = /obj/item/circuitboard/computer/bankmachine
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_COMMAND
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/crewconsole
	name = "船员监控电脑电路板"
	desc = "可用于建造船员监控电脑的电路板。"
	id = "crewconsole"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/crew
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/secdata
	name = "安保记录控制台电路板"
	desc = "可用于建造安保记录控制台的电路板。"
	id = "secdata"
	build_path = /obj/item/circuitboard/computer/secure_data
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/atmosalerts
	name = "大气警报电路板"
	desc = "可用于建造大气警报控制台的电路板。"
	id = "atmosalerts"
	build_path = /obj/item/circuitboard/computer/atmos_alert
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/atmos_control
	name = "大气监控电路板"
	desc = "可用于建造大气监控器的电路板。"
	id = "atmos_control"
	build_path = /obj/item/circuitboard/computer/atmos_control
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/robocontrol
	name = "机器人控制台电路板"
	desc = "可用于建造机器人控制台的电路板。"
	id = "robocontrol"
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/circuitboard/computer/robotics
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/slot_machine
	name = "老虎机电路板"
	desc = "可用于建造新老虎机的电路板。"
	id = "slotmachine"
	build_path = /obj/item/circuitboard/computer/slot_machine
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENTERTAINMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE


/datum/design/board/powermonitor
	name = "电力监控电路板"
	desc = "可用于建造新电力监控器的电路板。"
	id = "powermonitor"
	build_path = /obj/item/circuitboard/computer/powermonitor
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/solarcontrol
	name = "太阳能控制电路板"
	desc = "可用于建造太阳能控制台的电路板。"
	id = "solarcontrol"
	build_path = /obj/item/circuitboard/computer/solar_control
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/prisonmanage
	name = "囚犯管理控制台电路板"
	desc = "可用于建造囚犯管理控制台的电路板。"
	id = "prisonmanage"
	build_path = /obj/item/circuitboard/computer/prisoner
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/mechacontrol
	name = "外骨骼控制台电路板"
	desc = "可用于建造外骨骼控制台的电路板。"
	id = "mechacontrol"
	build_path = /obj/item/circuitboard/computer/mecha_control
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/mechapower
	name = "机甲舱电力控制台电路板"
	desc = "可用于建造机甲舱电力控制台的电路板。"
	id = "mechapower"
	build_path = /obj/item/circuitboard/computer/mech_bay_power_console
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/rdconsole
	name = "研发控制台电路板"
	desc = "可用于建造新研发控制台的电路板。"
	id = "rdconsole"
	build_path = /obj/item/circuitboard/computer/rdconsole
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/cargo
	name = "补给控制台电路板"
	desc = "可用于建造补给控制台的电路板。"
	id = "cargo"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/cargo
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/cargorequest
	name = "补给申请控制台电路板"
	desc = "可用于建造补给申请控制台的电路板。"
	id = "cargorequest"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/cargo/request
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/mining
	name = "前哨状态显示电路板"
	desc = "可用于建造前哨状态显示控制台的电路板。"
	id = "mining"
	build_path = /obj/item/circuitboard/computer/mining
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/comm_monitor
	name = "电信监控控制台电路板"
	desc = "可用于建造电信监控器的电路板。"
	id = "comm_monitor"
	build_path = /obj/item/circuitboard/computer/comm_monitor
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/comm_server
	name = "电信服务器监控控制台电路板"
	desc = "可用于建造电信服务器浏览与监控器的电路板。"
	id = "comm_server"
	build_path = /obj/item/circuitboard/computer/comm_server
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/message_monitor
	name = "消息监控控制台电路板"
	desc = "可用于建造消息监控控制台的电路板。"
	id = "message_monitor"
	build_path = /obj/item/circuitboard/computer/message_monitor
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/aifixer
	name = "AI 完整性修复器电路板"
	desc = "可用于建造 AI 完整性修复器的电路板。"
	id = "aifixer"
	build_path = /obj/item/circuitboard/computer/aifixer
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/libraryconsole
	name = "图书馆控制台电路板"
	desc = "可用于建造新图书馆控制台的电路板。"
	id = "libraryconsole"
	build_path = /obj/item/circuitboard/computer/libraryconsole
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENTERTAINMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/apc_control
	name = "电力流向控制台电路板"
	desc = "可用于建造新电力流向控制台的电路板。"
	id = "apc_control"
	build_path = /obj/item/circuitboard/computer/apc_control
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/advanced_camera
	name = "高级摄像头控制台电路板"
	desc = "可用于建造高级摄像头控制台的电路板。"
	id = "advanced_camera"
	build_path = /obj/item/circuitboard/computer/advanced_camera
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/bountypad_control
	name = "民用赏金平台控制电路板"
	desc = "可用于建造新民用赏金平台控制台的电路板。"
	id = "bounty_pad_control"
	build_path = /obj/item/circuitboard/computer/bountypad
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/exoscanner_console
	name = "扫描阵列控制台电路板"
	desc = "可用于建造新扫描阵列控制台的电路板。"
	id = "exoscanner_console"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/exoscanner_console
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/exodrone_console
	name = "探测无人机控制台电路板"
	desc = "可用于建造新探测无人机控制台的电路板。"
	id = "exodrone_console"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/exodrone_console
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/accounting_console
	name = "账户查询控制台电路板"
	desc = "可用于建造查看站内船员财富状况的控制台的电路板。"
	id = "account_console"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/accounting
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_COMMAND
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY //Honestly should have a bridge techfab for this sometime.

/datum/design/board/shuttle
	build_type = IMPRINTER
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/shuttle/flight_control
	name = "电脑设计（穿梭机飞行控制）"
	desc = "可用于建造操控穿梭机飞行的控制台的电路板。"
	id = "shuttle_control"
	build_path = /obj/item/circuitboard/computer/shuttle/flight_control

/datum/design/board/shuttle/shuttle_docker
	name = "电脑设计（穿梭机导航电脑）"
	desc = "可用于建造设定自定义飞行目标位置的控制台的电路板。"
	id = "shuttle_docker"
	build_path = /obj/item/circuitboard/computer/shuttle/docker

/datum/design/board/quantum_console
	name = "量子控制台电路板"
	desc = "可用于建造量子控制台的电路板。"
	id = "quantum_console"
	build_path = /obj/item/circuitboard/computer/quantum_console
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
