///////////////////Computer Boards///////////////////////////////////

/datum/design/board
	abstract_type = /datum/design/board
	build_type = IMPRINTER | AWAY_IMPRINTER
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)

/datum/design/board/arcade_battle
	name = "战斗街机电路板"
	desc = "用于建造战斗街机。"
	build_path = /obj/item/circuitboard/computer/arcade/battle
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENTERTAINMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/orion_trail
	name = "猎户座之路街机电路板"
	desc = "用于建造猎户座之路街机。"
	build_path = /obj/item/circuitboard/computer/arcade/orion_trail
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENTERTAINMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/seccamera
	name = "安保摄像头电路板"
	desc = "用于建造安保摄像头控制台，以查看空间站的安保监控网络。"
	build_path = /obj/item/circuitboard/computer/security
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/rdcamera
	name = "科研监控电路板"
	desc = "用于建造科研摄像头控制台，以查看科研部门的监控网络。"
	build_path = /obj/item/circuitboard/computer/research
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/xenobiocamera
	name = "异种生物学控制台电路板"
	desc = "用于建造异种生物学摄像头控制台，以管理异种生物学的史莱姆研究。"
	build_path = /obj/item/circuitboard/computer/xenobiology
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/med_data
	name = "医疗记录电路板"
	desc = "用于建造医疗记录控制台，以查看船员的医疗数据。"
	build_path = /obj/item/circuitboard/computer/med_data
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/operating
	name = "手术计算机电路板"
	desc = "用于建造手术计算机控制台，以执行高级外科手术。"
	build_path = /obj/item/circuitboard/computer/operating
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/pandemic
	name = "泛流行病分析仪 2200 电路板"
	desc = "用于建造泛流行病分析仪 2200 控制台，以查看和改造病毒。"
	build_path = /obj/item/circuitboard/computer/pandemic
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/comconsole
	name = "通讯电路板"
	desc = "用于建造通讯控制台，主要负责中央指挥部与空间站之间的通讯。通常安装在舰桥。"
	build_path = /obj/item/circuitboard/computer/communications
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_COMMAND
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SECURITY //Honestly should have a bridge techfab for this sometime.

/datum/design/board/bankmachine
	name = "银行机电路板"
	desc = "用于建造银行机，可向空间站银行账户存入或提取资金。通常安装在金库。"
	build_path = /obj/item/circuitboard/computer/bankmachine
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_COMMAND
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/crewconsole
	name = "船员监控计算机电路板"
	desc = "用于建造船员监控计算机，以监测船员的生命体征。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/crew
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/secdata
	name = "安保记录控制台电路板"
	desc = "用于建造安保记录控制台，以管理和查看空间站的安保记录。"
	build_path = /obj/item/circuitboard/computer/secure_data
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/atmosalerts
	name = "大气警报电路板"
	desc = "用于建造大气警报控制台，报告空间站各处的危险大气状况。"
	build_path = /obj/item/circuitboard/computer/atmos_alert
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/atmos_control
	name = "大气监控电路板"
	desc = "用于建造大气监控台，提供空间站大气状况的详细信息。"
	build_path = /obj/item/circuitboard/computer/atmos_control
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/robocontrol
	name = "机器人控制台电路板"
	desc = "用于建造机器人控制台，可控制空间站的辅助机器人，并对半机械人提供有限的控制。"
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/circuitboard/computer/robotics
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/slot_machine
	name = "老虎机电路板"
	desc = "用于建造一台新的老虎机。"
	build_path = /obj/item/circuitboard/computer/slot_machine
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENTERTAINMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE


/datum/design/board/powermonitor
	name = "电力监控电路板"
	desc = "用于建造电力监控台，提供与其连接的所有区域电力控制器和超导磁储能单元的实时信息。\
		与大多数控制台不同，它需要实体电缆连接。"
	build_path = /obj/item/circuitboard/computer/powermonitor
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/solarcontrol
	name = "太阳能控制电路板"
	desc = "用于建造太阳能控制台，追踪与其连接的所有太阳能电池的状态。\
		与大多数控制台不同，它需要实体电缆连接。"
	build_path = /obj/item/circuitboard/computer/solar_control
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/prisonmanage
	name = "囚犯管理控制台电路板"
	desc = "用于建造囚犯管理控制台，可监控所有装有植入体的囚犯。"
	build_path = /obj/item/circuitboard/computer/prisoner
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/mechacontrol
	name = "机甲控制台电路板"
	desc = "用于建造机甲控制台，可监控安装了追踪信标的机甲。"
	build_path = /obj/item/circuitboard/computer/mecha_control
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/mechapower
	name = "机甲舱电力控制台电路板"
	desc = "用于建造机甲舱电力控制台，与机甲充电器配套使用，当然就是为了给机甲充电。"
	build_path = /obj/item/circuitboard/computer/mech_bay_power_console
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/rdconsole
	name = "研发控制台电路板"
	desc = "用于建造研发控制台，为空间站研究新技术。\
		默认处于锁定状态，需要科研权限才能解锁。"
	build_path = /obj/item/circuitboard/computer/rdconsole
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/cargo
	name = "补给控制台电路板"
	desc = "用于建造补给控制台，可批准补给申请、直接购买物品，并调度补给穿梭机往返于空间站和中央指挥部。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/cargo
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/cargorequest
	name = "补给申请控制台电路板"
	desc = "用于建造补给申请控制台。它是补给控制台电路板的“仅申请”版本，无法直接购买物品或操作穿梭机。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/cargo/request
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/mining
	name = "前哨站状态显示电路板"
	desc = "用于建造前哨站状态显示控制台，以查看采矿前哨站的监控网络。"
	build_path = /obj/item/circuitboard/computer/mining
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/comm_monitor
	name = "电信监控控制台电路板"
	desc = "用于建造电信监控台，以报告电信网络的状态。"
	build_path = /obj/item/circuitboard/computer/comm_monitor
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/comm_server
	name = "电信服务器监控台电路板"
	desc = "用于建造电信服务器监控台，记录并存储通过电信网络发送的所有通讯信息。"
	build_path = /obj/item/circuitboard/computer/comm_server
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/message_monitor
	name = "消息监控控制台电路板"
	desc = "用于建造消息监控控制台，记录并存储通过 PDA 或请求控制台发送的所有消息。"
	build_path = /obj/item/circuitboard/computer/message_monitor
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/aifixer
	name = "AI 完整性恢复器电路板"
	desc = "用于建造 AI 完整性恢复器，以修复损坏的 AI 单元。"
	build_path = /obj/item/circuitboard/computer/aifixer
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/libraryconsole
	name = "图书馆控制台电路板"
	desc = "用于建造图书馆控制台，以访问空间站的图书馆数据库。"
	build_path = /obj/item/circuitboard/computer/libraryconsole
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENTERTAINMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/apc_control
	name = "区域电力控制器控制电路板"
	desc = "用于建造电力流控制台，可远程访问并控制空间站的所有区域电力控制器。\
		需要总工程师权限才能操作。"
	build_path = /obj/item/circuitboard/computer/apc_control
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/advanced_camera
	name = "高级摄像头控制台电路板"
	desc = "用于建造高级摄像头控制台，提供更强的监控能力。"
	build_path = /obj/item/circuitboard/computer/advanced_camera
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/bountypad_control
	name = "民用赏金平台控制电路板"
	desc = "用于建造民用赏金平台控制台，让船员管理和追踪自己的货运赏金任务。需要配套的民用赏金平台。"
	build_path = /obj/item/circuitboard/computer/bountypad
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/exoscanner_console
	name = "扫描阵列控制台电路板"
	desc = "用于建造扫描阵列控制台，供探索无人机操作员管理扫描阵列，发现可供探索的新地点。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/exoscanner_console
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/exodrone_console
	name = "探索无人机控制台电路板"
	desc = "用于建造探索无人机控制台，供操作员操控探索无人机。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/exodrone_console
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/accounting_console
	name = "账户查询控制台电路板"
	desc = "用于建造账户查询控制台，可快速审查船员的财务记录并管理薪资。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/accounting
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_COMMAND
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY //Honestly should have a bridge techfab for this sometime.

/datum/design/board/shuttle
	abstract_type = /datum/design/board/shuttle
	build_type = IMPRINTER
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/shuttle/flight_control
	name = "穿梭机飞行控制电路板"
	desc = "用于建造穿梭机飞行控制台。"
	build_path = /obj/item/circuitboard/computer/shuttle/flight_control

/datum/design/board/shuttle/shuttle_docker
	name = "穿梭机导航计算机电路板"
	desc = "用于建造可指定自定义飞行目的地的控制台。"
	build_path = /obj/item/circuitboard/computer/shuttle/docker

/datum/design/board/quantum_console
	name = "量子控制台电路板"
	desc = "用于建造量子控制台，供比特潜行者管理量子服务器。"
	build_path = /obj/item/circuitboard/computer/quantum_console
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
