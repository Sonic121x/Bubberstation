
/////////////////////////////////////////
/////////////////Tools///////////////////
/////////////////////////////////////////

/datum/design/fire_extinguisher_advanced
	name = "高级灭火器"
	id = "adv_fire_extinguisher"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/titanium =SMALL_MATERIAL_AMOUNT*5, /datum/material/gold =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/extinguisher/advanced/empty
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/handdrill
	name = "手持电钻"
	desc = "一把小型电动手持电钻，配有可互换的螺丝刀头与螺栓批头。"
	id = "handdrill"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT*1.75, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/titanium =SHEET_MATERIAL_AMOUNT*1.25)
	build_path = /obj/item/screwdriver/power
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/jawsoflife
	name = "救生钳"
	desc = "一套小巧紧凑的救生钳，配有可互换的撬动钳口与剪切钳口。"
	id = "jawsoflife" // added one more requirment since the Jaws of Life are a bit OP
	build_path = /obj/item/crowbar/power
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT*2.25, /datum/material/silver =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/titanium =SHEET_MATERIAL_AMOUNT*1.75)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
	autolathe_exportable = FALSE

/datum/design/exwelder
	name = "实验性焊接工具"
	desc = "一种能自行生成燃料的实验性焊接工具。"
	id = "exwelder"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/uranium =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/weldingtool/experimental
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rangedanalyzer
	name = "实验性远程气体分析仪"
	desc = "一种可在远距离工作的实验性气体分析仪。"
	id = "rangedanalyzer"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.2, /datum/material/gold =SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace=SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/analyzer/ranged
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ATMOSPHERICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/rpd
	name = "快速管道分配器（RPD）"
	id = "rpd_loaded"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT*37.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT*18.75)
	build_path = /obj/item/pipe_dispenser
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rcd_loaded
	name = "快速建造装置"
	desc = "一种能即时建造与拆除墙壁、气闸和地板的工具。"
	id = "rcd_loaded"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 30, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 15)
	transfered_materials = list(
		/obj/item/construction/rcd/loaded = /obj/item/construction/rcd::custom_materials, //The RCD has less materials than what's used, as some is converted to charge/matter
	)
	build_path = /obj/item/construction/rcd/loaded
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rtd_loaded
	name = "快速铺砖装置"
	desc = "一种能即时铺设与拆除地砖的工具。"
	id = "rtd_loaded"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 15, /datum/material/glass =SHEET_MATERIAL_AMOUNT*1.25)
	build_path = /obj/item/construction/rtd/loaded
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rcd_ammo
	name = "RCD 物质弹药筒"
	id = "rcd_ammo"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT * 6, /datum/material/glass= SHEET_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/rcd_ammo
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rcd_upgrade/frames
	name = "RCD 高级升级：框架"
	desc = "为 RCD 增加机器框架与电脑框架的设计图。"
	id = "rcd_upgrade_frames"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/titanium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/rcd_upgrade/frames
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rcd_upgrade/simple_circuits
	name = "RCD 高级升级：简易电路"
	desc = "为 RCD 增加制作简易电路的能力。"
	id = "rcd_upgrade_simple_circuits"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/titanium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/rcd_upgrade/simple_circuits
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rcd_upgrade/anti_interrupt
	name = "RCD 高级升级：防干扰"
	desc = "防止 RCD 的建造与拆除过程被打断。"
	id = "rcd_upgrade_anti_interrupt"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/rcd_upgrade/anti_interrupt
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rcd_upgrade/cooling
	name = "RCD 高级升级：强化冷却"
	desc = "让 RCD 能更快地连续执行多次操作。"
	id = "rcd_upgrade_cooling"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/rcd_upgrade/cooling
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rcd_upgrade/furnishing
	name = "RCD 高级升级：家具"
	desc = "为 RCD 增加布置家具的能力。"
	id = "rcd_upgrade_furnishing"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/titanium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/rcd_upgrade/furnishing
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rcd_upgrade/silo_link
	name = "RCD 高级升级：筒仓连接"
	desc = "升级 RCD，使其能从矿石筒仓提取材料。使用前必须先用多功能工具将 RCD 与筒仓连接。"
	id = "rcd_upgrade_silo_link"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/silver =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/titanium =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT*1.25)
	build_path = /obj/item/rcd_upgrade/silo_link
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rpd_upgrade/unwrench
	name = "RPD 高级升级：扳手模式"
	desc = "为 RPD 增加反向扳手模式。注意：由于预算削减，该模式被硬性绑定在摧毁模式控制按钮上。"
	id = "rpd_upgrade_unwrench"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT*1.25)
	build_path = /obj/item/rpd_upgrade/unwrench
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rld_mini
	name = "微型快速照明装置（MRLD）"
	desc = "一种可部署便携式与立式照明球及荧光棒的工具。"
	id = "rld_mini"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT*10, /datum/material/glass =SHEET_MATERIAL_AMOUNT*5, /datum/material/plastic =SHEET_MATERIAL_AMOUNT*4, /datum/material/gold =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/construction/rld/mini
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SERVICE

/datum/design/geneshears
	name = "植物基因剪"
	desc = "一把高科技、高保真的植物剪，能从植物中切取基因性状。"
	id = "gene_shears"
	build_path = /obj/item/geneshears
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*2, /datum/material/uranium=HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver=SMALL_MATERIAL_AMOUNT*5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plumbing_rcd_service
	name = "服务管道建造器"
	id = "plumbing_rcd_service"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT*37.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT*18.75, /datum/material/plastic =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/construction/plumbing/service
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_PLUMBING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/biopsy_tool
	name = "活检工具"
	id = "biopsy_tool"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT*2, /datum/material/glass =SHEET_MATERIAL_AMOUNT*1.5)
	build_path = /obj/item/biopsy_tool
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_XENOBIOLOGY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/////////////////////////////////////////
//////////////Alien Tools////////////////
/////////////////////////////////////////

/datum/design/alienwrench
	name = "外星扳手"
	desc = "通过绑架者技术获得的高级扳手。"
	id = "alien_wrench"
	build_path = /obj/item/wrench/abductor
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium =SHEET_MATERIAL_AMOUNT, /datum/material/diamond =SHEET_MATERIAL_AMOUNT)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/alienwirecutters
	name = "外星剪线钳"
	desc = "通过绑架者技术获得的高级剪线钳。"
	id = "alien_wirecutters"
	build_path = /obj/item/wirecutters/abductor
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium =SHEET_MATERIAL_AMOUNT, /datum/material/diamond =SHEET_MATERIAL_AMOUNT)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/alienscrewdriver
	name = "外星螺丝刀"
	desc = "通过绑架者技术获得的高级螺丝刀。"
	id = "alien_screwdriver"
	build_path = /obj/item/screwdriver/abductor
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium =SHEET_MATERIAL_AMOUNT, /datum/material/diamond =SHEET_MATERIAL_AMOUNT)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/aliencrowbar
	name = "外星撬棍"
	desc = "通过绑架者技术获得的高级撬棍。"
	id = "alien_crowbar"
	build_path = /obj/item/crowbar/abductor
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium =SHEET_MATERIAL_AMOUNT, /datum/material/diamond =SHEET_MATERIAL_AMOUNT)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/alienwelder
	name = "外星焊接工具"
	desc = "通过绑架者技术获得的高级焊接工具。"
	id = "alien_welder"
	build_path = /obj/item/weldingtool/abductor
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plasma =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/titanium =SHEET_MATERIAL_AMOUNT, /datum/material/diamond =SHEET_MATERIAL_AMOUNT)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/alienmultitool
	name = "外星多功能工具"
	desc = "通过绑架者技术获得的高级多功能工具。"
	id = "alien_multitool"
	build_path = /obj/item/multitool/abductor
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plasma =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/titanium =SHEET_MATERIAL_AMOUNT, /datum/material/diamond =SHEET_MATERIAL_AMOUNT)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/////////////////////////////////////////
/////////Alien Surgical Tools////////////
/////////////////////////////////////////

/datum/design/alienscalpel
	name = "外星手术刀"
	desc = "通过绑架者技术获得的高级手术刀。"
	id = "alien_scalpel"
	build_path = /obj/item/scalpel/alien
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/alienhemostat
	name = "外星止血钳"
	desc = "通过绑架者技术获得的高级止血钳。"
	id = "alien_hemostat"
	build_path = /obj/item/hemostat/alien
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/alienretractor
	name = "外星牵开器"
	desc = "通过绑架者技术获得的高级牵开器。"
	id = "alien_retractor"
	build_path = /obj/item/retractor/alien
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/aliensaw
	name = "外星圆锯"
	desc = "通过绑架者技术获得的高级手术锯。"
	id = "alien_saw"
	build_path = /obj/item/circular_saw/alien
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT*5, /datum/material/silver =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/aliendrill
	name = "外星钻"
	desc = "通过绑架者技术获得的高级钻头。"
	id = "alien_drill"
	build_path = /obj/item/surgicaldrill/alien
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT*5, /datum/material/silver =SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/aliencautery
	name = "外星烧灼器"
	desc = "通过绑架者技术获得的高级烧灼器。"
	id = "alien_cautery"
	build_path = /obj/item/cautery/alien
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/wirebrush
	name = "钢丝刷"
	desc = "一种用于清除墙壁锈迹的工具。"
	id = "wirebrush"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_TOOLS)
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/wirebrush
	category = list(RND_CATEGORY_TOOLS)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)

/datum/design/bolter_wrench
	name = "闩锁扳手"
	desc = "一种无论供电状态如何都能拧开气闸螺栓的扳手。"
	id = "bolter_wrench"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/wrench/bolter
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/shuttle_blueprints
	name = "穿梭机蓝图"
	desc = "适合建造穿梭机的蓝图。"
	id = "shuttle_blueprints"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/shuttle_blueprints
	category = list(RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/shuttle_remote
	name = "穿梭机遥控器"
	desc = "一种遥控器，与导航控制台连接后可派遣穿梭机或尝试使其对接。"
	id = "shuttle_remote"
	build_type = PROTOLATHE
	build_path = /obj/item/shuttle_remote
	materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING
