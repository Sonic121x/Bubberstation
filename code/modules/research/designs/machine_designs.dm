////////////////////////////////////////
//////////////MISC Boards///////////////
////////////////////////////////////////
/datum/design/board/electrolyzer
	name = "电解器电路板"
	desc = "用于电解器的电路板。"
	id = "electrolyzer"
	build_path = /obj/item/circuitboard/machine/electrolyzer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/smes
	name = "超导磁储能装置电路板"
	desc = "用于超导磁储能装置的电路板。"
	id = "smes"
	build_path = /obj/item/circuitboard/machine/smes
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/power_connector
	name = "电力连接器电路板"
	desc = "用于便携式超导磁储能装置电力连接器的电路板。"
	id = "power_connector"
	build_path = /obj/item/circuitboard/machine/smes/connector
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/smesbank
	name = "便携式超导磁储能装置电路板"
	desc = "用于便携式超导磁储能装置的电路板，需要连接器才能使用。"
	id = "portable_smes"
	build_path = /obj/item/circuitboard/machine/smesbank
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/announcement_system
	name = "自动播报系统电路板"
	desc = "用于自动播报系统的电路板。"
	id = "automated_announcement"
	build_path = /obj/item/circuitboard/machine/announcement_system
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/turbine_computer
	name = "涡轮电力控制台电路板"
	desc = "用于涡轮电力控制台的电路板。"
	id = "power_turbine_console"
	build_path = /obj/item/circuitboard/computer/turbine_computer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/emitter
	name = "发射器电路板"
	desc = "用于发射器的电路板。"
	id = "emitter"
	build_path = /obj/item/circuitboard/machine/emitter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/mass_driver
	name = "质量投射器电路板"
	desc = "用于质量投射器的电路板。"
	id = "mass_driver"
	build_path = /obj/item/circuitboard/machine/mass_driver
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/turbine_compressor
	name = "涡轮进气压缩机电路板"
	desc = "用于涡轮进气压缩机的电路板。"
	id = "turbine_compressor"
	build_path = /obj/item/circuitboard/machine/turbine_compressor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/turbine_rotor
	name = "涡轮核心转子电路板"
	desc = "用于涡轮核心转子的电路板。"
	id = "turbine_rotor"
	build_path = /obj/item/circuitboard/machine/turbine_rotor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/turbine_stator
	name = "涡轮排气口电路板"
	desc = "用于涡轮排气口的电路板。"
	id = "turbine_stator"
	build_path = /obj/item/circuitboard/machine/turbine_stator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/thermomachine
	name = "温控机电路板"
	desc = "用于温控机的电路板。"
	id = "thermomachine"
	build_path = /obj/item/circuitboard/machine/thermomachine
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/space_heater
	name = "暖风机电路板"
	desc = "用于暖风机的电路板。"
	id = "space_heater"
	build_path = /obj/item/circuitboard/machine/space_heater
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/teleport_station
	name = "传送站电路板"
	desc = "用于传送站的电路板。"
	id = "tele_station"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/teleporter_station
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/teleport_hub
	name = "传送枢纽电路板"
	desc = "用于传送枢纽的电路板。"
	id = "tele_hub"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/teleporter_hub
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/quantumpad
	name = "量子传送平台电路板"
	desc = "用于量子传送平台的电路板。"
	id = "quantumpad"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/quantumpad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/botpad
	name = "机器人发射平台电路板"
	desc = "用于机器人发射平台的电路板。"
	id = "botpad"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/botpad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/launchpad
	name = "蓝空间发射平台电路板"
	desc = "用于蓝空间发射平台的电路板。"
	id = "launchpad"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/launchpad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/launchpad_console
	name = "发射平台控制台电路板"
	desc = "用于蓝空间发射平台控制台的电路板。"
	id = "launchpad_console"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/launchpad_console
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/modular_shield_gate
	name = "模块化护盾门电路板"
	desc = "用于模块化护盾门的电路板。"
	id = "modular_shield_gate"
	build_path = /obj/item/circuitboard/machine/modular_shield_generator/gate
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
		)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_generator
	name = "模块化护盾发生器电路板"
	desc = "用于模块化护盾发生器的电路板。"
	id = "modular_shield_generator"
	build_path = /obj/item/circuitboard/machine/modular_shield_generator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_node
	name = "模块化护盾节点电路板"
	desc = "用于模块化护盾节点的电路板。"
	id = "modular_shield_node"
	build_path = /obj/item/circuitboard/machine/modular_shield_node
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_cable
	name = "模块化护盾电缆电路板"
	desc = "用于模块化护盾电缆的电路板。"
	id = "modular_shield_cable"
	build_path = /obj/item/circuitboard/machine/modular_shield_cable
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_relay
	name = "模块化护盾中继器电路板"
	desc = "用于模块化护盾中继器的电路板。"
	id = "modular_shield_relay"
	build_path = /obj/item/circuitboard/machine/modular_shield_relay
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_charger
	name = "模块化护盾充能器电路板"
	desc = "用于模块化护盾充能器的电路板。"
	id = "modular_shield_charger"
	build_path = /obj/item/circuitboard/machine/modular_shield_charger
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_well
	name = "模块化护盾井电路板"
	desc = "用于模块化护盾井的电路板。"
	id = "modular_shield_well"
	build_path = /obj/item/circuitboard/machine/modular_shield_well
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/modular_shield_console
	name = "模块化护盾控制台电路板"
	desc = "用于模块化护盾控制台的电路板。"
	id = "modular_shield_console"
	build_path = /obj/item/circuitboard/computer/modular_shield_console
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/teleconsole
	name = "传送机控制台电路板"
	desc = "可用于建造传送机控制台的电路板。"
	id = "teleconsole"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/teleporter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/cryotube
	name = "低温治疗舱电路板"
	desc = "用于低温治疗舱的电路板。"
	id = "cryotube"
	build_path = /obj/item/circuitboard/machine/cryo_tube
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/chem_dispenser
	name = "化学分配器电路板"
	desc = "用于化学分配器的电路板。"
	id = "chem_dispenser"
	build_path = /obj/item/circuitboard/machine/chem_dispenser
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/chem_master
	name = "化学大师电路板"
	desc = "用于化学大师 3000 的电路板。"
	id = "chem_master"
	build_path = /obj/item/circuitboard/machine/chem_master
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/chem_heater
	name = "化学加热器电路板"
	desc = "用于化学加热器的电路板。"
	id = "chem_heater"
	build_path = /obj/item/circuitboard/machine/chem_heater
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/chem_mass_spec
	name = "高效液相色谱仪电路板"
	desc = "用于高效液相色谱仪的电路板。"
	id = "chem_mass_spec"
	build_path = /obj/item/circuitboard/machine/chem_mass_spec
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/smoke_machine
	name = "烟雾机电路板"
	desc = "用于烟雾机的电路板。"
	id = "smoke_machine"
	build_path = /obj/item/circuitboard/machine/smoke_machine
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/reagentgrinder
	name = "多功能研磨机电路板"
	desc = "用于多功能研磨机的电路板。"
	id = "reagentgrinder"
	build_path = /obj/item/circuitboard/machine/reagentgrinder
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/hypnochair
	name = "强化审讯舱电路板"
	desc = "可用于建造强化审讯舱的电路板。"
	id = "hypnochair"
	build_path = /obj/item/circuitboard/machine/hypnochair
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/photobooth
	name = "照相亭电路板"
	desc = "用于照相亭的电路板。"
	id = "photobooth"
	build_path = /obj/item/circuitboard/machine/photobooth
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/security_photobooth
	name = "安保照相亭电路板"
	desc = "用于安保照相亭的电路板。"
	id = "security_photobooth"
	build_path = /obj/item/circuitboard/machine/photobooth/security
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/biogenerator
	name = "生物质生成器电路板"
	desc = "用于生物质生成器的电路板。"
	id = "biogenerator"
	build_path = /obj/item/circuitboard/machine/biogenerator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BOTANY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/hydroponics
	name = "水培槽电路板"
	desc = "用于水培槽的电路板。"
	id = "hydro_tray"
	build_path = /obj/item/circuitboard/machine/hydroponics
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BOTANY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/destructive_analyzer
	name = "破坏性分析仪电路板"
	desc = "用于破坏性分析仪的电路板。"
	id = "destructive_analyzer"
	build_path = /obj/item/circuitboard/machine/destructive_analyzer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/experimentor
	name = "实验导师电路板"
	desc = "用于实验导师的电路板。"
	id = "experimentor"
	build_path = /obj/item/circuitboard/machine/experimentor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/circuit_imprinter
	name = "电路印刷机电路板"
	desc = "用于电路印刷机的电路板。"
	id = "circuit_imprinter"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/circuit_imprinter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_FAB
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/circuit_imprinter/offstation
	name = "古老电路印刷机电路板"
	desc = "用于古老电路印刷机的电路板。"
	id = "circuit_imprinter_offstation"
	build_type = AWAY_IMPRINTER
	build_path = /obj/item/circuitboard/machine/circuit_imprinter/offstation
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_FAB
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/rdservercontrol
	name = "研发服务器控制台电路板"
	desc = "用于研发服务器控制台的电路板。"
	id = "rdservercontrol"
	build_path = /obj/item/circuitboard/computer/rdservercontrol
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/rdserver
	name = "研发服务器电路板"
	desc = "用于研发服务器的电路板。"
	id = "rdserver"
	build_path = /obj/item/circuitboard/machine/rdserver
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/mechfab
	name = "外骨骼机甲制造机电路板"
	desc = "用于外骨骼机甲制造机的电路板。"
	id = "mechfab"
	build_path = /obj/item/circuitboard/machine/mechfab
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/cyborgrecharger
	name = "半机械人充电器电路板"
	desc = "用于半机械人充电器的电路板。"
	id = "cyborgrecharger"
	build_path = /obj/item/circuitboard/machine/cyborgrecharger
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/mech_recharger
	name = "机甲舱充电器电路板"
	desc = "用于机甲舱充电器的电路板。"
	id = "mech_recharger"
	build_path = /obj/item/circuitboard/machine/mech_recharger
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/dnascanner
	name = "DNA 扫描仪电路板"
	desc = "用于 DNA 扫描仪的电路板。"
	id = "dnascanner"
	build_path = /obj/item/circuitboard/machine/dnascanner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_GENETICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/dnainfuser
	name = "DNA 注入器电路板"
	desc = "用于 DNA 注入器的电路板。"
	id = "dnainfuser"
	build_path = /obj/item/circuitboard/machine/dna_infuser
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_GENETICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/scan_console
	name = "DNA 控制台电路板"
	desc = "可用于建造新 DNA 控制台的电路板。"
	id = "scan_console"
	build_path = /obj/item/circuitboard/computer/scan_consolenew
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_GENETICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/destructive_scanner
	name = "破坏性扫描仪电路板"
	desc = "用于实验性破坏扫描仪的电路板。"
	id = "destructive_scanner"
	build_path = /obj/item/circuitboard/machine/destructive_scanner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/doppler_array
	name = "快子多普勒研究阵列电路板"
	desc = "用于快子多普勒研究阵列的电路板。"
	id = "doppler_array"
	build_path = /obj/item/circuitboard/machine/doppler_array
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/anomaly_refinery
	name = "异常体精炼机电路板"
	desc = "用于异常体精炼机的电路板。"
	id = "anomaly_refinery"
	build_path = /obj/item/circuitboard/machine/anomaly_refinery
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/tank_compressor
	name = "气罐压缩机电路板"
	desc = "用于气罐压缩机的电路板。"
	id = "tank_compressor"
	build_path = /obj/item/circuitboard/machine/tank_compressor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/microwave
	name = "微波炉电路板"
	desc = "用于微波炉的电路板。"
	id = "microwave"
	build_path = /obj/item/circuitboard/machine/microwave
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/microwave_engineering
	name = "无线微波炉电路板"
	desc = "用于电池供能微波炉的电路板。"
	id = "microwave_engineering"
	build_path = /obj/item/circuitboard/machine/microwave/engineering
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/gibber
	name = "碎肉机电路板"
	desc = "用于碎肉机的电路板。"
	id = "gibber"
	build_path = /obj/item/circuitboard/machine/gibber
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/smartfridge
	name = "智能冰箱电路板"
	desc = "用于智能冰箱的电路板。"
	id = "smartfridge"
	build_path = /obj/item/circuitboard/machine/smartfridge
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/dehydrator
	name = "脱水机电路板"
	desc = "用于脱水机的电路板。"
	id = "dehydrator"
	build_path = /obj/item/circuitboard/machine/dehydrator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/vatgrower
	name = "培育槽电路板"
	desc = "用于培育槽的电路板。"
	id = "vatgrower"
	build_path = /obj/item/circuitboard/machine/vatgrower
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/monkey_recycler
	name = "猴子回收机电路板"
	desc = "用于猴子回收机的电路板。"
	id = "monkey_recycler"
	build_path = /obj/item/circuitboard/machine/monkey_recycler
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/seed_extractor
	name = "种子提取机电路板"
	desc = "用于种子提取机的电路板。"
	id = "seed_extractor"
	build_path = /obj/item/circuitboard/machine/seed_extractor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BOTANY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/processor
	name = "食物/史莱姆处理机电路板"
	desc = "用于处理机的电路板。用螺丝刀拧动电路板可在食物（默认）与史莱姆处理之间切换。"
	id = "processor"
	build_path = /obj/item/circuitboard/machine/processor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/soda_dispenser
	name = "便携式汽水分配器电路板"
	desc = "用于便携式汽水分配器的电路板。"
	id = "soda_dispenser"
	build_path = /obj/item/circuitboard/machine/chem_dispenser/drinks
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BAR
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/beer_dispenser
	name = "便携式酒水分配器电路板"
	desc = "用于便携式酒水分配器的电路板。"
	id = "beer_dispenser"
	build_path = /obj/item/circuitboard/machine/chem_dispenser/drinks/beer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BAR
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/recycler
	name = "回收机电路板"
	desc = "用于回收机的电路板。"
	id = "recycler"
	build_path = /obj/item/circuitboard/machine/recycler
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/scanner_gate
	name = "扫描门电路板"
	desc = "用于扫描门的电路板。"
	id = "scanner_gate"
	build_path = /obj/item/circuitboard/machine/scanner_gate
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/holopad
	name = "AI 全息投影台电路板"
	desc = "用于全息投影台的电路板。"
	id = "holopad"
	build_path = /obj/item/circuitboard/machine/holopad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/autolathe
	name = "自动车床电路板"
	desc = "用于自动车床的电路板。"
	id = "autolathe"
	build_path = /obj/item/circuitboard/machine/autolathe
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_FAB
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/recharger
	name = "武器充电器电路板"
	desc = "用于武器充电器的电路板。"
	id = "recharger"
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/circuitboard/machine/recharger
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SECURITY

/datum/design/board/vendor
	name = "自定义售货机电路板"
	desc = "用于自定义售货机的电路板。"
	id = "vendor"
	build_path = /obj/item/circuitboard/machine/vendor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/ore_redemption
	name = "矿石兑换机电路板"
	desc = "用于矿石兑换机的电路板。"
	id = "ore_redemption"
	build_path = /obj/item/circuitboard/machine/ore_redemption
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/mining_equipment_vendor
	name = "矿业售货控制台电路板"
	desc = "用于矿业售货控制台的电路板。"
	id = "mining_equipment_vendor"
	build_path = /obj/item/circuitboard/computer/order_console/mining
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/suit_storage_unit
	name = "服装储存单元电路板"
	desc = "用于服装储存单元的电路板。"
	id = "suit_storage_unit"
	build_path = /obj/item/circuitboard/machine/suit_storage_unit
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/tesla_coil
	name = "特斯拉线圈电路板"
	desc = "用于特斯拉线圈的电路板。"
	id = "tesla_coil"
	build_path = /obj/item/circuitboard/machine/tesla_coil
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/grounding_rod
	name = "接地棒电路板"
	desc = "用于接地棒的电路板。"
	id = "grounding_rod"
	build_path = /obj/item/circuitboard/machine/grounding_rod
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/ntnet_relay
	name = "纳米传讯网中继器电路板"
	desc = "用于无线网络中继器的电路板。"
	id = "ntnet_relay"
	build_path = /obj/item/circuitboard/machine/ntnet_relay
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/crossing_signal
	name = "道口信号机电路板"
	desc = "用于电车道口信号机的电路板。"
	id = "crossing_signal"
	build_path = /obj/item/circuitboard/machine/crossing_signal
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/guideway_sensor
	name = "轨道传感器电路板"
	desc = "用于电车接近传感器的电路板。"
	id = "guideway_sensor"
	build_path = /obj/item/circuitboard/machine/guideway_sensor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/limbgrower
	name = "肢体培育机电路板"
	desc = "用于肢体培育机的电路板。"
	id = "limbgrower"
	build_path = /obj/item/circuitboard/machine/limbgrower
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/harvester
	name = "器官收割机电路板"
	desc = "用于器官收割机的电路板。"
	id = "harvester"
	build_path = /obj/item/circuitboard/machine/harvester
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/deepfryer
	name = "油炸锅电路板"
	desc = "用于油炸锅的电路板。"
	id = "deepfryer"
	build_path = /obj/item/circuitboard/machine/deep_fryer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/griddle
	name = "煎板电路板"
	desc = "用于煎板的电路板。"
	id = "griddle"
	build_path = /obj/item/circuitboard/machine/griddle
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/oven
	name = "烤箱电路板"
	desc = "用于烤箱的电路板。"
	id = "oven"
	build_path = /obj/item/circuitboard/machine/oven
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/stove
	name = "炉灶电路板"
	desc = "用于炉灶的电路板。"
	id = "stove"
	build_path = /obj/item/circuitboard/machine/stove
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/range
	name = "组合炉电路板"
	desc = "用于组合炉的电路板，它同时是烤箱和炉灶。"
	id = "range"
	build_path = /obj/item/circuitboard/machine/range
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/cell_charger
	name = "电池充电器电路板"
	desc = "用于电池充电器的电路板。"
	id = "cell_charger"
	build_path = /obj/item/circuitboard/machine/cell_charger
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/dish_drive
	name = "餐具回收器电路板"
	desc = "用于餐具回收器的电路板。"
	id = "dish_drive"
	build_path = /obj/item/circuitboard/machine/dish_drive
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/stacking_unit_console
	name = "堆叠机控制台电路板"
	desc = "用于堆叠机控制台的电路板。"
	id = "stack_console"
	build_path = /obj/item/circuitboard/machine/stacking_unit_console
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/stacking_machine
	name = "堆叠机电路板"
	desc = "用于堆叠机的电路板。"
	id = "stack_machine"
	build_path = /obj/item/circuitboard/machine/stacking_machine
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/ore_silo
	name = "矿石筒仓电路板"
	desc = "用于矿石筒仓的电路板。"
	id = "ore_silo"
	build_path = /obj/item/circuitboard/machine/ore_silo
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/fat_sucker
	name = "脂肪提取器电路板"
	desc = "用于脂肪提取器的电路板。"
	id = "fat_sucker"
	build_path = /obj/item/circuitboard/machine/fat_sucker
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/stasis
	name = "生命停滞单元电路板"
	desc = "用于生命停滞单元的电路板。"
	id = "stasis"
	build_path = /obj/item/circuitboard/machine/stasis
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/medical_kiosk
	name = "医疗服务机电路板"
	desc = "用于医疗服务机的电路板。"
	id = "medical_kiosk"
	build_path = /obj/item/circuitboard/machine/medical_kiosk
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/medipen_refiller
	name = "医疗笔补充机电路板"
	desc = "用于医疗笔补充机的电路板。"
	id = "medipen_refiller"
	build_path = /obj/item/circuitboard/machine/medipen_refiller
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/plumbing_receiver
	name = "化学接收器电路板"
	desc = "用于化学接收器的电路板。"
	id = "plumbing_receiver"
	build_path = /obj/item/circuitboard/machine/plumbing_receiver
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/sheetifier
	name = "板材大师 2000 电路板"
	desc = "用于板材大师 2000 的电路板。"
	id = "sheetifier"
	build_path = /obj/item/circuitboard/machine/sheetifier
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_FAB
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/restaurant_portal
	name = "餐厅传送门电路板"
	desc = "用于餐厅传送门的电路板。"
	id = "restaurant_portal"
	build_path = /obj/item/circuitboard/machine/restaurant_portal
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/bountypad
	name = "民用赏金平台电路板"
	desc = "用于民用赏金平台的电路板。"
	id = "bounty_pad"
	build_path = /obj/item/circuitboard/machine/bountypad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/skill_station
	name = "技能站电路板"
	desc = "用于技能站的电路板。"
	id = "skill_station"
	build_path = /obj/item/circuitboard/machine/skill_station
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/fax
	name = "传真机电路板"
	desc = "用于传真机的电路板。"
	id = "fax"
	build_path = /obj/item/circuitboard/machine/fax
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO

//Hypertorus fusion reactor designs

/datum/design/board/HFR_core
	name = "HFR 核心电路板"
	desc = "用于 HFR 核心的电路板。"
	id = "HFR_core"
	build_path = /obj/item/circuitboard/machine/HFR_core
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/HFR_fuel_input
	name = "HFR 燃料入口电路板"
	desc = "用于 HFR 燃料入口的电路板。"
	id = "HFR_fuel_input"
	build_path = /obj/item/circuitboard/machine/HFR_fuel_input
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/HFR_waste_output
	name = "HFR 废料出口电路板"
	desc = "用于 HFR 废料出口的电路板。"
	id = "HFR_waste_output"
	build_path = /obj/item/circuitboard/machine/HFR_waste_output
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/HFR_moderator_input
	name = "HFR 慢化剂入口电路板"
	desc = "用于 HFR 慢化剂入口的电路板。"
	id = "HFR_moderator_input"
	build_path = /obj/item/circuitboard/machine/HFR_moderator_input
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/HFR_corner
	name = "HFR 边角电路板"
	desc = "用于 HFR 边角的电路板。"
	id = "HFR_corner"
	build_path = /obj/item/circuitboard/machine/HFR_corner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/HFR_interface
	name = "HFR 操作界面电路板"
	desc = "用于 HFR 操作界面的电路板。"
	id = "HFR_interface"
	build_path = /obj/item/circuitboard/machine/HFR_interface
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/crystallizer
	name = "结晶器电路板"
	desc = "用于结晶器的电路板。"
	id = "crystallizer"
	build_path = /obj/item/circuitboard/machine/crystallizer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/exoscanner
	name = "外域扫描仪电路板"
	desc = "用于外域扫描仪的电路板。"
	id = "exoscanner"
	build_path = /obj/item/circuitboard/machine/exoscanner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/exodrone_launcher
	name = "探索无人机发射器电路板"
	desc = "用于探索无人机发射器的电路板。"
	id = "exodrone_launcher"
	build_path = /obj/item/circuitboard/machine/exodrone_launcher
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/component_printer
	name = "元件打印机电路板"
	desc = "用于元件打印机的电路板。"
	id = "component_printer"
	build_path = /obj/item/circuitboard/machine/component_printer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/module_printer
	name = "模块复制机电路板"
	desc = "用于模块复制机的电路板。"
	id = "module_duplicator"
	build_path = /obj/item/circuitboard/machine/module_duplicator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/coffeemaker
	name = "咖啡机电路板"
	desc = "用于咖啡机的电路板。"
	id = "coffeemaker"
	build_path = /obj/item/circuitboard/machine/coffeemaker
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/navbeacon
	name = "机器人导航信标电路板"
	desc = "用于辅助机器人导航的信标的电路板。"
	id = "botnavbeacon"
	build_path = /obj/item/circuitboard/machine/navbeacon
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/fishing_portal_generator
	name = "钓鱼传送门发生器电路板"
	desc = "用于钓鱼传送门发生器的电路板。"
	id = "fishing_portal_generator"
	build_path = /obj/item/circuitboard/machine/fishing_portal_generator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/brm
	name = "巨石回收矩阵电路板"
	id = "brm"
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
	desc = "用于平装打包机的电路板。"
	id = "flatpacker"
	build_path = /obj/item/circuitboard/machine/flatpacker
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/scrubber
	name = "便携式空气洗涤器电路板"
	desc = "用于便携式空气洗涤器的电路板。"
	id = "scrubber"
	build_path = /obj/item/circuitboard/machine/scrubber
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/pump
	name = "便携式气泵电路板"
	desc = "用于便携式气泵的电路板。"
	id = "pump"
	build_path = /obj/item/circuitboard/machine/pump
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/pipe_scrubber
	name = "便携式管道洗涤器电路板"
	desc = "用于便携式管道洗涤器的电路板。"
	id = "pipe_scrubber"
	build_path = /obj/item/circuitboard/machine/pipe_scrubber
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/bookbinder
	name = "书籍装订机电路板"
	desc = "用于书籍装订机的电路板。"
	id = "bookbinder"
	build_path = /obj/item/circuitboard/machine/bookbinder
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/libraryscanner
	name = "书籍扫描仪电路板"
	desc = "用于书籍扫描仪的电路板。"
	id = "libraryscanner"
	build_path = /obj/item/circuitboard/machine/libraryscanner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/big_manipulator
	name = "大型机械臂电路板"
	desc = "用于大型机械臂的电路板。"
	id = "big_manipulator"
	build_path = /obj/item/circuitboard/machine/big_manipulator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/manulathe
	name = "制造车床电路板"
	desc = "用于本机的电路板。"
	id = "manulathe"
	build_path = /obj/item/circuitboard/machine/manulathe
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manucrafter
	name = "制造装配机电路板"
	desc = "用于本机的电路板。"
	id = "manucrafter"
	build_path = /obj/item/circuitboard/machine/manucrafter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manucrusher
	name = "制造粉碎机电路板"
	desc = "用于本机的电路板。"
	id = "manucrusher"
	build_path = /obj/item/circuitboard/machine/manucrusher
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manurouter
	name = "制造分流器电路板"
	desc = "用于本机的电路板。"
	id = "manurouter"
	build_path = /obj/item/circuitboard/machine/manurouter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manusorter
	name = "传送带分拣器电路板"
	desc = "用于本机的电路板。"
	id = "manusorter"
	build_path = /obj/item/circuitboard/machine/manusorter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manuunloader
	name = "制造板条箱卸货机电路板"
	desc = "用于本机的电路板。"
	id = "manuunloader"
	build_path = /obj/item/circuitboard/machine/manuunloader
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/manusmelter
	name = "制造冶炼炉电路板"
	desc = "用于本机的电路板。"
	id = "manusmelter"
	build_path = /obj/item/circuitboard/machine/manusmelter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/mailsorter
	name = "邮件分拣机电路板"
	desc = "用于邮件分拣装置的电路板。"
	id = "mailsorter"
	build_path = /obj/item/circuitboard/machine/mailsorter
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/propulsion_engine
	name = "推进引擎电路板"
	desc = "用于推进引擎的电路板。"
	id = "propulsion_engine"
	build_path = /obj/item/circuitboard/machine/engine/propulsion
	build_type = IMPRINTER
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/photopcopier
	name = "复印机电路板"
	desc = "用于复印机的电路板。"
	id = "photocopier"
	build_path = /obj/item/circuitboard/machine/photocopier
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/atmosshieldgen
	name = "大气护盾发生器电路板"
	desc = "用于大气护盾发生器的电路板。"
	id = "atmosshieldgen"
	build_path = /obj/item/circuitboard/machine/atmos_shield_gen
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ATMOS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/netpod
	name = "网络舱电路板"
	desc = "用于网络舱的电路板。"
	id = "netpod"
	build_path = /obj/item/circuitboard/machine/netpod
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/byteforge
	name = "字节锻造机电路板"
	desc = "可用于建造字节锻造机的电路板。"
	id = "byteforge"
	build_path = /obj/item/circuitboard/machine/byteforge
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/washing_machine
	name = "洗衣机电路板"
	desc = "用于建造洗衣机的电路板。"
	id = "washing_machine"
	build_path = /obj/item/circuitboard/machine/washing_machine
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE
