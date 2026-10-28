////////////////////////////////////////
//////////////MISC Boards///////////////
////////////////////////////////////////
/datum/design/board/electrolyzer
	name = "电解器电路板"
	desc = "用于建造电解器，供大气部门处理特定种类的气体。"
	build_path = /obj/item/circuitboard/machine/electrolyzer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/smes
	name = "超导磁储能装置电路板"
	desc = "用于建造 SMES（超导磁储能装置），以储存电能。"
	build_path = /obj/item/circuitboard/machine/smes
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/power_connector
	name = "电力连接器电路板"
	desc = "用于建造便携式 SMES 电力连接器。将便携式 SMES 放入其中即可储存或供应电能。"
	build_path = /obj/item/circuitboard/machine/smes/connector
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/smesbank
	name = "便携式超导磁储能装置电路板"
	desc = "用于建造便携式 SMES，需要配合连接器使用。可在移动作业时储存或供应电能。"
	build_path = /obj/item/circuitboard/machine/smesbank
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/announcement_system
	name = "自动播报系统电路板"
	desc = "用于建造自动播报系统。负责向全站广播各种自动消息，\
	例如船员抵达通知。"
	build_path = /obj/item/circuitboard/machine/announcement_system
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/turbine_computer
	name = "涡轮控制台电路板"
	desc = "用于建造涡轮控制台，是运行燃气涡轮机的必需设备。"
	build_path = /obj/item/circuitboard/computer/turbine_computer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/emitter
	name = "发射器电路板"
	desc = "用于建造发射器，这种设备能发射高功率能量束。"
	build_path = /obj/item/circuitboard/machine/emitter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/mass_driver
	name = "质量投射器电路板"
	desc = "用于建造质量投射器，这种设备能将物体高速发射出去。"
	build_path = /obj/item/circuitboard/machine/mass_driver
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/turbine_compressor
	name = "涡轮进气压缩机电路板"
	desc = "用于建造涡轮进气压缩机，是燃气涡轮机的三个必需部件之一。\
		压缩机应面向热源，作为进气口。"
	build_path = /obj/item/circuitboard/machine/turbine_compressor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/turbine_rotor
	name = "涡轮核心转子电路板"
	desc = "用于建造涡轮核心转子，是燃气涡轮机的三个必需部件之一。\
		转子应置于压缩机与定子之间，以有效传递能量。"
	build_path = /obj/item/circuitboard/machine/turbine_rotor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/turbine_stator
	name = "涡轮定子电路板"
	desc = "用于建造涡轮定子，是燃气涡轮机的三个必需部件之一。\
		定子应置于转子后方，作为排气口。"
	build_path = /obj/item/circuitboard/machine/turbine_stator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/thermomachine
	name = "温控机电路板"
	desc = "用于建造温控机。可对相连的气体管网进行加热或冷却。"
	build_path = /obj/item/circuitboard/machine/thermomachine
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/space_heater
	name = "暖风机电路板"
	desc = "用于建造暖风机。可对周围区域进行加热或冷却，由电池供电。"
	build_path = /obj/item/circuitboard/machine/space_heater
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/teleport_station
	name = "传送站电路板"
	desc = "用于建造传送站，需要配合传送枢纽和传送机控制台使用。\
		通过蓝空间将人员传送至相连的枢纽或传送信标。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/teleporter_station
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/teleport_hub
	name = "传送枢纽电路板"
	desc = "用于建造传送枢纽，需要配合传送站和传送机控制台使用。\
		用于校准向外传送。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/teleporter_hub
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/quantumpad
	name = "量子传送平台电路板"
	desc = "用于建造量子传送平台，提供快速的点对点量子传送。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/quantumpad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/botpad
	name = "机器人发射平台电路板"
	desc = "用于建造机器人发射平台，将空间站机器人送往指定位置。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/botpad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/launchpad
	name = "蓝空间发射平台电路板"
	desc = "用于建造蓝空间发射平台，需要配合蓝空间发射平台控制台使用。\
		可通过蓝空间向指定位置传送，或从该处传回。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/launchpad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/launchpad_console
	name = "蓝空间发射平台控制台电路板"
	desc = "用于建造蓝空间发射平台控制台，是操作蓝空间发射平台的必需设备。\
		可精确设定蓝空间发射平台的目标位置。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/launchpad_console
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/modular_shield_gate
	name = "模块化护盾门电路板"
	desc = "用于建造模块化护盾门，是模块化护盾的组成部件。\
		护盾门可将生成的护盾沿单一方向投射至设定距离，而非向所有方向展开。\
		只能通过信号器或控制台操作。"
	build_path = /obj/item/circuitboard/machine/modular_shield_generator/gate
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
		)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_generator
	name = "模块化护盾发生器电路板"
	desc = "用于建造模块化护盾发生器，是模块化护盾的组成部件。\
		这是护盾网络的核心，其他部件必须与之相连才能运行。\
		可通过信号器、自带的控制面板或控制台操作。"
	build_path = /obj/item/circuitboard/machine/modular_shield_generator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_node
	name = "模块化护盾节点电路板"
	desc = "用于建造模块化护盾节点，是模块化护盾的组成部件。\
		这是纯结构部件，可用于向护盾网络添加更多部件。"
	build_path = /obj/item/circuitboard/machine/modular_shield_node
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_cable
	name = "模块化护盾电缆电路板"
	desc = "用于建造模块化护盾电缆，是模块化护盾的组成部件。\
		这是纯结构部件，用于连接护盾网络中的不同部件。"
	build_path = /obj/item/circuitboard/machine/modular_shield_cable
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_relay
	name = "模块化护盾中继器电路板"
	desc = "用于建造模块化护盾中继器，是模块化护盾的组成部件。\
		用于扩大模块化护盾的覆盖半径，每增加一个中继器都能进一步扩大护盾的覆盖范围。"
	build_path = /obj/item/circuitboard/machine/modular_shield_relay
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_charger
	name = "模块化护盾充能器电路板"
	desc = "用于建造模块化护盾充能器，是模块化护盾的组成部件。\
		用于提高护盾完整性的恢复速度，每增加一个充能器都能提高护盾的总体充能速率。"
	build_path = /obj/item/circuitboard/machine/modular_shield_charger
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_well
	name = "模块化护盾井电路板"
	desc = "用于建造模块化护盾井，是模块化护盾的组成部件。\
		用于提高护盾的总体完整性，每增加一个护盾井都能提高护盾的总体强度。"
	build_path = /obj/item/circuitboard/machine/modular_shield_well
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_console
	name = "模块化护盾控制台电路板"
	desc = "用于建造模块化护盾控制台，是模块化护盾的组成部件。\
		用于控制和管理护盾网络。"
	build_path = /obj/item/circuitboard/computer/modular_shield_console
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/teleconsole
	name = "传送机控制台电路板"
	desc = "用于建造传送机控制台，需要配合传送站和传送枢纽使用。\
		用于控制传送机。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/teleporter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/cryotube
	name = "低温治疗舱电路板"
	desc = "用于建造低温治疗舱，通常配合冷冻沙酮进行高级医疗治疗。"
	build_path = /obj/item/circuitboard/machine/cryo_tube
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/chem_dispenser
	name = "化学分配器电路板"
	desc = "用于建造化学分配器。"
	build_path = /obj/item/circuitboard/machine/chem_dispenser
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/chem_master
	name = "化学大师电路板"
	desc = "用于建造化学大师 3000，以生产药丸、贴片或其他化学制品。"
	build_path = /obj/item/circuitboard/machine/chem_master
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/chem_heater
	name = "化学加热器电路板"
	desc = "用于建造化学加热器。"
	build_path = /obj/item/circuitboard/machine/chem_heater
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/chem_mass_spec
	name = "高效液相色谱仪电路板"
	desc = "用于建造高效液相色谱仪。"
	build_path = /obj/item/circuitboard/machine/chem_mass_spec
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/smoke_machine
	name = "烟雾机电路板"
	desc = "用于建造烟雾机。"
	build_path = /obj/item/circuitboard/machine/smoke_machine
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/reagentgrinder
	name = "多功能研磨机电路板"
	desc = "用于建造多功能研磨机。"
	build_path = /obj/item/circuitboard/machine/reagentgrinder
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/hypnochair
	name = "强化审讯舱电路板"
	desc = "用于建造强化审讯舱，这种实验性设备可对其中的人员施加催眠。"
	build_path = /obj/item/circuitboard/machine/hypnochair
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/photobooth
	name = "照相亭电路板"
	desc = "用于建造照相亭。"
	build_path = /obj/item/circuitboard/machine/photobooth
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/security_photobooth
	name = "安保照相亭电路板"
	desc = "用于建造安保照相亭。"
	build_path = /obj/item/circuitboard/machine/photobooth/security
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/biogenerator
	name = "生物质生成器电路板"
	desc = "用于建造生物质生成器，将生物质转化为实用的材料和试剂。"
	build_path = /obj/item/circuitboard/machine/biogenerator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BOTANY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/hydroponics
	name = "水培槽电路板"
	desc = "用于建造水培槽。"
	build_path = /obj/item/circuitboard/machine/hydroponics
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BOTANY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/destructive_analyzer
	name = "破坏性分析仪电路板"
	desc = "用于建造破坏性分析仪，供研发部门分解物品以解锁新技术。"
	build_path = /obj/item/circuitboard/machine/destructive_analyzer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/experimentor
	name = "实验导师电路板"
	desc = "用于建造实验导师，这种大型机器用于鉴定奇异遗物并进行神秘实验。"
	build_path = /obj/item/circuitboard/machine/experimentor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/circuit_imprinter
	name = "电路印刷机电路板"
	desc = "用于建造电路印刷机。"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/circuit_imprinter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_FAB
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/circuit_imprinter/offstation
	name = "古老电路印刷机电路板"
	desc = "用于建造电路印刷机。"
	build_type = AWAY_IMPRINTER
	build_path = /obj/item/circuitboard/machine/circuit_imprinter/offstation
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_FAB
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/rdservercontrol
	name = "研发服务器控制台电路板"
	desc = "用于建造研发服务器控制台，以监控空间站研发服务器的状态。"
	build_path = /obj/item/circuitboard/computer/rdservercontrol
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/rdserver
	name = "研发服务器电路板"
	desc = "用于建造研发服务器。请注意，额外的研发服务器不会增加研究进度。"
	build_path = /obj/item/circuitboard/machine/rdserver
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/mechfab
	name = "外骨骼机甲制造机电路板"
	desc = "用于建造外骨骼机甲制造机。"
	build_path = /obj/item/circuitboard/machine/mechfab
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/cyborgrecharger
	name = "半机械人充电器电路板"
	desc = "用于建造半机械人充电器，也可为 MOD 服乃至以太人充电。"
	build_path = /obj/item/circuitboard/machine/cyborgrecharger
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/mech_recharger
	name = "机甲舱充电器电路板"
	desc = "用于建造机甲舱充电器。"
	build_path = /obj/item/circuitboard/machine/mech_recharger
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/dnascanner
	name = "DNA 扫描仪电路板"
	desc = "用于建造开展基因研究所需的 DNA 扫描仪，需要配套的 DNA 扫描仪控制台。"
	build_path = /obj/item/circuitboard/machine/dnascanner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_GENETICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/dnainfuser
	name = "DNA 注入器电路板"
	desc = "用于建造 DNA 注入器，将动物 DNA 与人类 DNA 混合以创造混种生物。"
	build_path = /obj/item/circuitboard/machine/dna_infuser
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_GENETICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/scan_console
	name = "DNA 控制台电路板"
	desc = "用于建造开展基因研究所需的 DNA 控制台，需要配套的 DNA 扫描仪。"
	build_path = /obj/item/circuitboard/computer/scan_consolenew
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_GENETICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/destructive_scanner
	name = "破坏性扫描仪电路板"
	desc = "用于建造实验性破坏性扫描仪，供研发部门分解物品以推进实验。"
	build_path = /obj/item/circuitboard/machine/destructive_scanner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/doppler_array
	name = "快子多普勒研究阵列电路板"
	desc = "用于建造快子多普勒研究阵列，记录其朝向上发生的爆炸强度。\
		通常安装在军械测试实验室内，朝向远处的试验场。"
	build_path = /obj/item/circuitboard/machine/doppler_array
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/anomaly_refinery
	name = "异常体精炼机电路板"
	desc = "用于建造异常体精炼机，使用原始异常核心和气罐转移阀生产精炼异常核心。"
	build_path = /obj/item/circuitboard/machine/anomaly_refinery
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/tank_compressor
	name = "气罐压缩机电路板"
	desc = "用于建造气罐压缩机，将输入的气体压入气罐以供科学实验使用。"
	build_path = /obj/item/circuitboard/machine/tank_compressor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/microwave
	name = "微波炉电路板"
	desc = "用于建造微波炉。"
	build_path = /obj/item/circuitboard/machine/microwave
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/microwave_engineering
	name = "无线微波炉电路板"
	desc = "用于建造由电池供电的微波炉。"
	build_path = /obj/item/circuitboard/machine/microwave/engineering
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/gibber
	name = "碎肉机电路板"
	desc = "用于建造碎肉机。"
	build_path = /obj/item/circuitboard/machine/gibber
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/smartfridge
	name = "智能冰箱电路板"
	desc = "用于建造智能冰箱。"
	build_path = /obj/item/circuitboard/machine/smartfridge
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/dehydrator
	name = "脱水机电路板"
	desc = "用于建造脱水机。"
	build_path = /obj/item/circuitboard/machine/dehydrator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/vatgrower
	name = "培育槽电路板"
	desc = "用于建造培育槽，供细胞学家培育新生物。"
	build_path = /obj/item/circuitboard/machine/vatgrower
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/monkey_recycler
	name = "猴子回收机电路板"
	desc = "用于建造猴子回收机，供异种生物学家将史莱姆进食后的“残余物”回收为新的猴子。"
	build_path = /obj/item/circuitboard/machine/monkey_recycler
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/seed_extractor
	name = "种子提取机电路板"
	desc = "用于建造种子提取机。投入植物即可提取种子，以便重新种植或储存。"
	build_path = /obj/item/circuitboard/machine/seed_extractor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BOTANY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/processor
	name = "食物/史莱姆处理机电路板"
	desc = "用于建造处理机。用螺丝刀调整电路板，可在食物处理模式（默认）与史莱姆处理模式之间切换。"
	build_path = /obj/item/circuitboard/machine/processor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/soda_dispenser
	name = "便携式汽水分配器电路板"
	desc = "用于建造汽水分配器。"
	build_path = /obj/item/circuitboard/machine/chem_dispenser/drinks
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BAR
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/beer_dispenser
	name = "便携式酒水分配器电路板"
	desc = "用于建造酒水分配器。"
	build_path = /obj/item/circuitboard/machine/chem_dispenser/drinks/beer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BAR
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/recycler
	name = "回收机电路板"
	desc = "用于建造回收机。能拆解几乎所有种类的物品，并吐出其原材料。"
	build_path = /obj/item/circuitboard/machine/recycler
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/scanner_gate
	name = "扫描门电路板"
	desc = "用于建造扫描门。分析从下方经过的生物，支持多种配置方式。"
	build_path = /obj/item/circuitboard/machine/scanner_gate
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/holopad
	name = "全息投影台电路板"
	desc = "用于建造全息投影台，可与其他全息投影台进行远程通话。用螺丝刀调整电路板可切换安保模式。"
	build_path = /obj/item/circuitboard/machine/holopad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/autolathe
	name = "自动车床电路板"
	desc = "用于建造自动车床，可打印多种通用实用物品。"
	build_path = /obj/item/circuitboard/machine/autolathe
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_FAB
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/recharger
	name = "武器充电器电路板"
	desc = "用于建造武器充电器，为放入其中的物品的电池充电。"
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/circuitboard/machine/recharger
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/vendor
	name = "自定义售货机电路板"
	desc = "用于建造售货机。用螺丝刀调整电路板可选择售货机类型。"
	build_path = /obj/item/circuitboard/machine/vendor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/ore_redemption
	name = "矿石兑换机电路板"
	desc = "用于建造矿石兑换机，将原矿冶炼为可用材料。"
	build_path = /obj/item/circuitboard/machine/ore_redemption
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/mining_equipment_vendor
	name = "矿业奖励售货机电路板"
	desc = "用于建造矿业奖励售货机，供矿工使用采矿积分兑换各种装备。"
	build_path = /obj/item/circuitboard/computer/order_console/mining
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/suit_storage_unit
	name = "服装储存单元"
	desc = "用于建造服装储存单元。除了存放和整理舱外活动服及相关装备，还能自动为服装电池充电。"
	build_path = /obj/item/circuitboard/machine/suit_storage_unit
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/tesla_coil
	name = "特斯拉线圈电路板"
	desc = "用于建造特斯拉线圈。收集并储存放电产生的能量，然后逐步输送至相连的电缆。"
	build_path = /obj/item/circuitboard/machine/tesla_coil
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/grounding_rod
	name = "接地棒电路板"
	desc = "用于建造接地棒，将放电安全地导入地面。"
	build_path = /obj/item/circuitboard/machine/grounding_rod
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/ntnet_relay
	name = "纳米传讯网中继器电路板"
	desc = "用于建造无线网络中继器，扩大纳米传讯网的通信范围。"
	build_path = /obj/item/circuitboard/machine/ntnet_relay
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/crossing_signal
	name = "道口信号机电路板"
	desc = "用于建造电车道口信号机，在电车接近时发出警告。需要轨道传感器。"
	build_path = /obj/item/circuitboard/machine/crossing_signal
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/guideway_sensor
	name = "轨道传感器电路板"
	desc = "用于建造电车接近传感器，检测驶来的电车并触发相应信号。"
	build_path = /obj/item/circuitboard/machine/guideway_sensor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/limbgrower
	name = "肢体培育机电路板"
	desc = "用于建造肢体培育机，培育用于替换的有机肢体。"
	build_path = /obj/item/circuitboard/machine/limbgrower
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/harvester
	name = "器官收割机电路板"
	desc = "用于建造器官收割机。"
	build_path = /obj/item/circuitboard/machine/harvester
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/deepfryer
	name = "油炸锅电路板"
	desc = "用于建造油炸锅。"
	build_path = /obj/item/circuitboard/machine/deep_fryer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/griddle
	name = "煎板电路板"
	desc = "用于建造煎板。"
	build_path = /obj/item/circuitboard/machine/griddle
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/oven
	name = "烤箱电路板"
	desc = "用于建造烤箱。"
	build_path = /obj/item/circuitboard/machine/oven
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/stove
	name = "炉灶电路板"
	desc = "用于建造炉灶。"
	build_path = /obj/item/circuitboard/machine/stove
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/range
	name = "组合炉电路板"
	desc = "用于建造组合炉，兼具烤箱和炉灶的功能。"
	build_path = /obj/item/circuitboard/machine/range
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/cell_charger
	name = "电池充电器电路板"
	desc = "用于建造电池充电器。"
	build_path = /obj/item/circuitboard/machine/cell_charger
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/dish_drive
	name = "餐具回收器电路板"
	desc = "用于建造餐具回收器，收集附近的空餐具。"
	build_path = /obj/item/circuitboard/machine/dish_drive
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/stacking_unit_console
	name = "堆叠机控制台电路板"
	desc = "用于建造堆叠机控制台，以控制堆叠机。"
	build_path = /obj/item/circuitboard/machine/stacking_unit_console
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/stacking_machine
	name = "堆叠机电路板"
	desc = "用于建造堆叠机，收集附近的材料并存入矿石筒仓。"
	build_path = /obj/item/circuitboard/machine/stacking_machine
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/ore_silo
	name = "矿石筒仓电路板"
	desc = "用于建造矿石筒仓，储存收集到的材料供全站使用。"
	build_path = /obj/item/circuitboard/machine/ore_silo
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/fat_sucker
	name = "脂肪提取器电路板"
	desc = "用于建造脂肪提取器，去除人体内多余的脂肪。"
	build_path = /obj/item/circuitboard/machine/fat_sucker
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/stasis
	name = "生命停滞单元电路板"
	desc = "用于建造生命停滞单元。"
	build_path = /obj/item/circuitboard/machine/stasis
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/medical_kiosk
	name = "医疗服务机电路板"
	desc = "用于建造医疗服务机。"
	build_path = /obj/item/circuitboard/machine/medical_kiosk
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/medipen_refiller
	name = "医疗笔补充机电路板"
	desc = "用于建造医疗笔补充机。"
	build_path = /obj/item/circuitboard/machine/medipen_refiller
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/plumbing_receiver
	name = "化学接收器电路板"
	desc = "用于建造化学接收器，连接化学管网并通过蓝空间远距离传送化学品。"
	build_path = /obj/item/circuitboard/machine/plumbing_receiver
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/sheetifier
	name = "板材大师2000电路板"
	desc = "用于建造板材大师2000，将特定物品转化为可用于建造的板材。"
	build_path = /obj/item/circuitboard/machine/sheetifier
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_FAB
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/restaurant_portal
	name = "餐厅传送门电路板"
	desc = "用于建造餐厅传送门，接送往返空间站的游客。"
	build_path = /obj/item/circuitboard/machine/restaurant_portal
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/bountypad
	name = "民用赏金平台电路板"
	desc = "用于建造民用赏金平台，以发送赏金任务所需物品。需要民用赏金平台控制台。"
	build_path = /obj/item/circuitboard/machine/bountypad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/skill_station
	name = "技能站电路板"
	desc = "用于建造技能站，以操作技能芯片。"
	build_path = /obj/item/circuitboard/machine/skill_station
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/fax
	name = "传真机电路板"
	desc = "用于建造传真机。"
	build_path = /obj/item/circuitboard/machine/fax
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO

//Hypertorus fusion reactor designs

/datum/design/board/HFR_core
	name = "HFR 核心电路板"
	desc = "用于建造超环面聚变反应堆的核心。"
	build_path = /obj/item/circuitboard/machine/HFR_core
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/HFR_fuel_input
	name = "HFR 燃料入口电路板"
	desc = "用于建造超环面聚变反应堆的燃料入口。"
	build_path = /obj/item/circuitboard/machine/HFR_fuel_input
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/HFR_waste_output
	name = "HFR 废料出口电路板"
	desc = "用于建造超环面聚变反应堆的废料出口。"
	build_path = /obj/item/circuitboard/machine/HFR_waste_output
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/HFR_moderator_input
	name = "HFR 慢化剂入口电路板"
	desc = "用于建造超环面聚变反应堆的慢化剂入口。"
	build_path = /obj/item/circuitboard/machine/HFR_moderator_input
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/HFR_corner
	name = "HFR 边角电路板"
	desc = "用于建造超环面聚变反应堆的边角部件。"
	build_path = /obj/item/circuitboard/machine/HFR_corner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/HFR_interface
	name = "HFR 操作界面电路板"
	desc = "用于建造超环面聚变反应堆的操作界面。"
	build_path = /obj/item/circuitboard/machine/HFR_interface
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/crystallizer
	name = "结晶器电路板"
	desc = "用于建造结晶器，供大气部门将气体凝结成固体。"
	build_path = /obj/item/circuitboard/machine/crystallizer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/exoscanner
	name = "扫描阵列电路板"
	desc = "用于建造扫描阵列，供探索无人机操作员扩大扫描范围。"
	build_path = /obj/item/circuitboard/machine/exoscanner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/exodrone_launcher
	name = "探索无人机发射器电路板"
	desc = "用于建造探索无人机发射器，供操作员部署探索无人机。"
	build_path = /obj/item/circuitboard/machine/exodrone_launcher
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/component_printer
	name = "元件打印机电路板"
	desc = "用于建造元件打印机，以打印电路元件。"
	build_path = /obj/item/circuitboard/machine/component_printer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/module_printer
	name = "模块复制机电路板"
	desc = "用于建造模块复制机，以复制电路。"
	build_path = /obj/item/circuitboard/machine/module_duplicator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/coffeemaker
	name = "咖啡机电路板"
	desc = "用于建造咖啡机。"
	build_path = /obj/item/circuitboard/machine/coffeemaker
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/navbeacon
	name = "机器人导航信标电路板"
	desc = "用于建造辅助机器人导航的信标。"
	build_path = /obj/item/circuitboard/machine/navbeacon
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/fishing_portal_generator
	name = "钓鱼传送门发生器电路板"
	desc = "用于建造钓鱼传送门发生器，以进行远程钓鱼。"
	build_path = /obj/item/circuitboard/machine/fishing_portal_generator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/brm
	name = "巨石回收矩阵电路板"
	desc = "用于建造巨石回收矩阵，将下方新开采的巨石直接传送到空间站进行加工。"
	materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/circuitboard/machine/brm
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/flatpacker
	name = "平装打包机电路板"
	desc = "用于建造平装打包机，大幅加快机器的组装和部署。"
	build_path = /obj/item/circuitboard/machine/flatpacker
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/scrubber
	name = "便携式空气洗涤器电路板"
	desc = "用于建造便携式空气洗涤器。"
	build_path = /obj/item/circuitboard/machine/scrubber
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/bluespace_scrubber
	name = "便携式蓝空间洗涤器电路板"
	desc = "用于便携式蓝空间洗涤器的电路板。"
	build_path = /obj/item/circuitboard/machine/bluespace_scrubber
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/gas_receiver
	name = "气体接收器电路板"
	desc = "用于气体接收器的电路板。"
	build_path = /obj/item/circuitboard/machine/gas_receiver
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/pump
	name = "便携式气泵电路板"
	desc = "用于建造便携式气泵。"
	build_path = /obj/item/circuitboard/machine/pump
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/pipe_scrubber
	name = "便携式管道洗涤器电路板"
	desc = "用于建造便携式管道洗涤器。"
	build_path = /obj/item/circuitboard/machine/pipe_scrubber
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/bookbinder
	name = "书籍装订机"
	desc = "用于建造书籍装订机。"
	build_path = /obj/item/circuitboard/machine/bookbinder
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/libraryscanner
	name = "书籍扫描仪"
	desc = "用于建造书籍扫描仪。"
	build_path = /obj/item/circuitboard/machine/libraryscanner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/big_manipulator
	name = "大型机械臂电路板"
	desc = "用于建造机械臂，可对各种物品进行多种不同操作。"
	build_path = /obj/item/circuitboard/machine/big_manipulator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/manulathe
	name = "制造车床电路板"
	desc = "用于建造制造车床，可按照特定配方自动生产物品。"
	build_path = /obj/item/circuitboard/machine/manulathe
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manucrafter
	name = "制造装配机电路板"
	desc = "用于建造制造装配机，可按照特定配方自动组装物品。"
	build_path = /obj/item/circuitboard/machine/manucrafter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manucrusher
	name = "制造粉碎机电路板"
	desc = "用于建造制造粉碎机，自动粉碎投入其中的物品，例如巨石。"
	build_path = /obj/item/circuitboard/machine/manucrusher
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manurouter
	name = "制造分流器电路板"
	desc = "用于建造制造分流器，适合配合传送带系统将一路输入分配至多个出口。"
	build_path = /obj/item/circuitboard/machine/manurouter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manusorter
	name = "制造分拣器电路板"
	desc = "用于建造制造分拣器，适合配合传送带系统将特定输入物品送往指定出口。"
	build_path = /obj/item/circuitboard/machine/manusorter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manuunloader
	name = "制造板条箱卸货机电路板"
	desc = "用于建造制造板条箱卸货机，接收板条箱或盒子并自动取出其中的物品。"
	build_path = /obj/item/circuitboard/machine/manuunloader
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manusmelter
	name = "制造冶炼炉电路板"
	desc = "用于建造制造冶炼炉，焚烧输入的材料并产出精炼材料。"
	build_path = /obj/item/circuitboard/machine/manusmelter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/mailsorter
	name = "邮件分拣机电路板"
	desc = "用于建造邮件分拣机，储存邮件并按部门或收件人自动分类。"
	build_path = /obj/item/circuitboard/machine/mailsorter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/propulsion_engine
	name = "推进引擎电路板"
	desc = "用于建造穿梭机推进引擎。"
	build_path = /obj/item/circuitboard/machine/engine/propulsion
	build_type = IMPRINTER
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/photopcopier
	name = "复印机电路板"
	desc = "用于建造复印机。"
	build_path = /obj/item/circuitboard/machine/photocopier
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/atmosshieldgen
	name = "大气护盾发生器电路板"
	desc = "用于建造大气护盾发生器，消耗电力来阻止空气通过。"
	build_path = /obj/item/circuitboard/machine/atmos_shield_gen
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/netpod
	name = "网络舱电路板"
	desc = "用于建造网络舱，比特潜行者进入其中即可访问虚拟域。"
	build_path = /obj/item/circuitboard/machine/netpod
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/byteforge
	name = "字节锻造机电路板"
	desc = "用于建造字节锻造机，合成比特潜行者获得的资源及其他奖励。"
	build_path = /obj/item/circuitboard/machine/byteforge
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/washing_machine
	name = "洗衣机电路板"
	desc = "用于建造洗衣机。"
	build_path = /obj/item/circuitboard/machine/washing_machine
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE
