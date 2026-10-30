// HUDs

/datum/design/health_hud
	name = "生命扫描 HUD"
	desc = "一种平视显示器，可扫描视野内的人形生物并提供其健康状况的准确数据。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/clothing/glasses/hud/health
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/health_hud_night
	name = "夜视生命扫描 HUD"
	desc = "一种先进的医疗平视显示器，能让医生在完全黑暗中找到病人。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT*3.5,
	)
	build_path = /obj/item/clothing/glasses/hud/health/night
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/security_hud
	name = "安保 HUD"
	desc = "一种平视显示器，可扫描视野内的人形生物并提供其 ID 状态的准确数据。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/clothing/glasses/hud/security
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/security_hud_night
	name = "夜视安保 HUD"
	desc = "一种平视显示器，能在完全黑暗中提供 ID 数据和视野。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT*3.5,
	)
	build_path = /obj/item/clothing/glasses/hud/security/night
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/diagnostic_hud
	name = "诊断 HUD"
	desc = "一种用于分析并判定机械装置故障的 HUD。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/clothing/glasses/hud/diagnostic
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/diagnostic_hud_night
	name = "夜视诊断 HUD"
	desc = "诊断 HUD 的升级版本，专为断电时仍能运作而设计。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma =SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/clothing/glasses/hud/diagnostic/night
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

// Misc

/datum/design/welding_goggles
	name = "焊接护目镜"
	desc = "保护眼睛免受强光闪烁伤害；经疯狂科学家协会认证。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/clothing/glasses/welding
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/welding_mask
	name = "焊接面具"
	desc = "内置焊接护目镜和面罩的防毒面具。看起来像个骷髅，显然是书呆子设计的。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	transfered_materials = list(
		/obj/item/clothing/mask/gas/welding = /obj/item/clothing/mask/gas/welding::custom_materials,
		/obj/item/gas_filter = /obj/item/gas_filter::custom_materials,
	)
	build_path = /obj/item/clothing/mask/gas/welding
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/bright_helmet
	name = "工作场所专用消防员头盔"
	desc = "通过把最先进的照明技术应用于消防头盔，并采用符合工业标准的光化学硬化工艺，这顶安全帽能保护你免受严苛的工作场所危害。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*2,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic =SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/clothing/head/utility/hardhat/red/upgraded
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/mauna_mug
	name = "毛纳马克杯"
	desc = "这只超棒的马克杯能让你的咖啡永不冷却！"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	transfered_materials = list(
		/obj/item/reagent_containers/cup/maunamug = /obj/item/reagent_containers/cup/maunamug::custom_materials,
		/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell::custom_materials,
	)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	build_path = /obj/item/reagent_containers/cup/maunamug
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/rolling_table
	name = "带轮桌子"
	desc = "我们把几只轮子用胶带粘在桌子底下。这他妈就是科学，明白吗？"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2)
	build_path = /obj/structure/table/rolling
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/portaseeder
	name = "便携式种子提取器"
	desc = "专为四处奔波的有为植物学家打造。效率不如固定型号，每株植物只能产出一颗种子。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT*4)
	build_path = /obj/item/storage/bag/plants/portaseeder
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_TOOLS_BOTANY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/clown_firing_pin
	name = "搞笑击针"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 3, /datum/material/bananium =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/firing_pin/clown
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/water_balloon
	name = "水气球"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/toy/waterballoon
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/mesons
	name = "光学介子扫描仪"
	desc = "供工程与采矿人员使用，可透过墙壁看到基础结构与地形布局，不受光照条件影响。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/clothing/glasses/meson
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/engine_goggles
	name = "工程扫描眼镜"
	desc = "工程师使用的眼镜。介子扫描模式可让你隔着墙壁看到基础结构与地形布局，不受光照条件影响。T 射线扫描模式则让你看到地板下的物体，如电缆和管道。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/clothing/glasses/meson/engine
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/tray_goggles
	name = "光学 T 射线扫描仪"
	desc = "供工程人员使用，可看到地板下的物体，如电缆和管道。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/clothing/glasses/meson/engine/tray
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ATMOSPHERICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/atmos_thermal
	name = "大气热成像眼镜"
	desc = "供大气技术员用来测定空气的温度。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/clothing/glasses/meson/engine/atmos_imaging
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ATMOSPHERICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/nvgmesons
	name = "夜视介子扫描仪"
	desc = "装有额外传感器的原型介子扫描仪，可放大可见光谱并将其叠加到超高清显示屏上。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/plasma = SMALL_MATERIAL_AMOUNT*3.5,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/clothing/glasses/meson/night
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/design/night_vision_goggles
	name = "夜视护目镜"
	desc = "让你能毫无阻碍地看穿黑暗的护目镜。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/plasma = SMALL_MATERIAL_AMOUNT*3.5,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/clothing/glasses/night
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY

/datum/design/magboots
	name = "磁力靴"
	desc = "磁性靴子，常用于舱外活动，以确保使用者安全地附着在载具上。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*2,
		/datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT*1.25,
	)
	build_path = /obj/item/clothing/shoes/magboots
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/forcefield_projector
	name = "力场投影仪"
	desc = "一种可投射临时力场以封闭某一区域的装置。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/forcefield_projector
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/sci_goggles
	name = "科研护目镜"
	desc = "装有便携式分析仪的护目镜，能判定物品或机器组件的研究价值。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/clothing/glasses/science
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/nv_sci_goggles
	name = "夜视科研护目镜"
	desc = "让佩戴者能在黑暗中视物，并一眼辨别化合物的护目镜。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/plasma = SMALL_MATERIAL_AMOUNT*3.5,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/clothing/glasses/science/night
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/roastingstick
	name = "高级烤棒"
	desc = "一根用于在异域烤箱中烤香肠的烤棒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT*2.5,
	)
	build_path = /obj/item/melee/roastingstick
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/locator
	name = "蓝空间定位器"
	desc = "用于追踪便携式传送信标以及带有追踪植入体的目标。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/silver =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/locator
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/quantum_keycard
	name = "量子钥匙卡"
	desc = "用于连接量子传送平台。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/silver =SMALL_MATERIAL_AMOUNT*5, /datum/material/bluespace =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/quantum_keycard
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/botpad_remote
	name = "机器人平台控制器"
	desc = "让你可以控制已连接的机器人发射平台。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/iron =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/botpad_remote
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/anomaly_neutralizer
	name = "异常体中和器"
	desc = "一种先进工具，能瞬间中和异常体，专为捕捉引擎产生的短暂异象而设计。\
		也能稳定异端或巫师造成的现实裂隙。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/gold =SHEET_MATERIAL_AMOUNT, /datum/material/plasma =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/uranium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/anomaly_neutralizer
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/donksoft_refill
	name = "咚克软玩具售货机补充包"
	desc = "咚克软玩具售货机的补充罐。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*12.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT*10,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/vending_refill/donksoft
	category = list(
		RND_CATEGORY_STOCK_PARTS + RND_SUBCATEGORY_STOCK_PARTS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SERVICE

/datum/design/oxygen_tank
	name = "氧气罐"
	desc = "一只空的氧气罐。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/tank/internals/oxygen/empty
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/plasma_tank
	name = "等离子气罐"
	desc = "一只空的氧气罐。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/tank/internals/plasma/empty
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/id
	name = "身份识别卡"
	desc = "用于证明身份及确定空间站各处通行权限的卡片，内置数字显示屏和先进微芯片。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/card/id/advanced
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/eng_gloves
	name = "工匠手套"
	desc = "设计过度复杂的工程手套，内置调校好的自动化建造子程序，穿戴时能加快建造速度。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT, /datum/material/silver=HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/clothing/gloves/tinkerer
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/lavarods
	name = "耐熔岩铁棍"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plasma=SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium=SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/rods/lava
	category = list(
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MATERIALS
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/plasticducky
	name = "塑料小黄鸭"
	desc = "纳米传讯经典的平价浴用橡皮鸭设计。无需华夫公司的高级橡胶，今天就买塑料小黄鸭！"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/bikehorn/rubberducky/plasticducky
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/pneumatic_seal
	name = "气动气闸密封器"
	desc = "用于封闭气闸的重型支架。对于没有足够技巧把它挪开的人来说，这东西相当管用。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*10, /datum/material/plasma = SHEET_MATERIAL_AMOUNT*5)
	build_path = /obj/item/door_seal
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_SCIENCE

// Janitor Designs

/datum/design/advmop
	name = "高级拖把"
	desc = "升级版拖把，内部容量很大，可储存水或其他清洁化学品。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT*2.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/mop/advanced
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/normtrash
	name = "垃圾袋"
	desc = "这是装垃圾的袋子，你把垃圾装进去。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/storage/bag/trash
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/blutrash
	name = "次元垃圾袋"
	desc = "一只具有蓝空间特性的高级垃圾袋，能装下海量垃圾。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT*2.5, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/storage/bag/trash/bluespace
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/light_replacer
	name = "灯具更换器"
	desc = "一种自动更换灯具的装置。可用完好的灯泡补充。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/lightreplacer
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/light_replacer_blue
	name = "蓝空间灯具更换器"
	desc = "一种可远距离自动更换灯具的装置。可用完好的灯泡补充。"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT*1.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace =SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/lightreplacer/blue
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/buffer_upgrade
	name = "地板抛光机升级"
	desc = "一种可安装到机动清洁车上的地板抛光机。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/janicart_upgrade/buffer
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_JANITOR
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/vacuum_upgrade
	name = "吸尘器升级"
	desc = "一种可安装到机动清洁车上的吸尘器。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/janicart_upgrade/vacuum
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_JANITOR
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/paint_remover
	name = "除漆剂"
	desc = "能清除地板上的污渍，除此之外就没什么用了。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/paint/paint_remover
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/spraybottle
	name = "喷瓶"
	desc = "一个喷瓶，瓶盖可以旋开。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/reagent_containers/spray
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/beartrap
	name = "捕熊夹"
	desc = "用来捕捉太空熊以及其他有腿生物的陷阱。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/restraints/legcuffs/beartrap
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE


// Hydroponics

/datum/design/adv_watering_can
	name = "高级洒水壶"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT*2.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY_ADVANCED
	)
	build_path = /obj/item/reagent_containers/cup/watering_can/advanced
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

// Holobarriers

/datum/design/holosign
	name = "全息标志投影器"
	desc = "一种用于投射各种警示标志的全息投影器。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/holosign_creator
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/holobarrier_jani
	name = "保洁全息屏障投影器"
	desc = "一种用于投射硬光湿地警示屏障的全息投影器。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/holosign_creator/janibarrier
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/holosignsec
	name = "安保全息屏障投影器"
	desc = "一种可生成全息安保屏障的全息投影器。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/holosign_creator/security
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/holosignengi
	name = "工程全息屏障投影器"
	desc = "一种可生成全息工程屏障的全息投影器。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/holosign_creator/engineering
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/holosignatmos
	name = "ATMOS 全息风扇投影器"
	desc = "一种可生成全息屏障的全息投影器，这些屏障能阻止大气状态发生变化。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/holosign_creator/atmos
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ATMOSPHERICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/holobarrier_med
	name = "PENLITE 全息屏障投影器"
	desc = "PENLITE 全息屏障，一种能拦下携带恶性疾病者的装置。"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/holosign_creator/medical
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/silver =SMALL_MATERIAL_AMOUNT) //a hint of silver since it can troll 2 antags (bad viros and sentient disease)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

// Armour

/datum/design/reactive_armour
	name = "反应装甲外壳"
	desc = "一件实验性装甲，可利用植入的异常核心来保护使用者。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT*4,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT*2.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	build_path = /obj/item/reactive_armor_shell
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/knight_armour
	name = "骑士护甲"
	desc = "皇家骑士最钟爱的服装。任何友善之人都能对它进行修饰。"
	build_type = AUTOLATHE
	materials = list(/datum/material_requirement/armor_material = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/clothing/suit/armor/riot/knight/greyscale
	category = list(RND_CATEGORY_IMPORTED)

/datum/design/knight_helmet
	name = "骑士头盔"
	desc = "皇家骑士最钟爱的帽子。把它倒过来看，其实是个水桶。"
	build_type = AUTOLATHE
	materials = list(/datum/material_requirement/armor_material = SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/clothing/head/helmet/knight/greyscale
	category = list(RND_CATEGORY_IMPORTED)

// Security

/datum/design/seclite
	name = "安保手电筒"
	desc = "安保人员使用的坚固手电筒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT*2.5)
	build_path = /obj/item/flashlight/seclite
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/pepperspray
	name = "胡椒喷雾"
	desc = "由 UhangInc 制造，用于快速致盲并放倒对手。打印出的胡椒喷雾不含试剂。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/reagent_containers/spray/pepper/empty
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/bola_energy
	name = "能量流星锤"
	desc = "一种特制的硬光流星锤，用于缠住逃跑的罪犯，协助实施逮捕。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/silver =SMALL_MATERIAL_AMOUNT*5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/restraints/legcuffs/bola/energy
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/zipties
	name = "扎带"
	desc = "塑料制的一次性扎带，可用来短暂束缚他人，但使用后即毁。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT*2.5)
	build_path = /obj/item/restraints/handcuffs/cable/zipties
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/evidencebag
	name = "证物袋"
	desc = "一个空的证物袋。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/evidencebag
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY


/datum/design/dragnet_beacon
	name = "DRAGnet 信标"
	desc = "一个可作为 DRAGnet 捕获弹传送落点的信标。记得先与你的 DRAGnet 同步！"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/dragnet_beacon
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/inspector
	name = "N 光谱扫描仪"
	desc = "中央指挥部配发的检查设备。启动后会按纳米传讯规程执行检查，随后打印一份关于空间站维护状况的加密报告。绝对不会让你得癌症。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/uranium =SHEET_MATERIAL_AMOUNT)
	transfered_materials = list(
		/obj/item/inspector = /obj/item/inspector::custom_materials,
		/obj/item/stock_parts/power_store/cell/crap = /obj/item/stock_parts/power_store/cell/crap::custom_materials,
	)
	build_path = /obj/item/inspector
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/sec_pen
	name = "安保笔"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/pen/red/security
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/plumbing_rcd
	name = "管道建造器"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*38, /datum/material/glass = SHEET_MATERIAL_AMOUNT*18, /datum/material/plastic =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/construction/plumbing
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_PLUMBING
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/gas_filter
	name = "大气气体过滤器"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/gas_filter
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS_EQUIPMENT
	)
	departmental_flags = ALL

/datum/design/plasmaman_gas_filter
	name = "等离子人大气气体过滤器"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/gas_filter/plasmaman
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS_EQUIPMENT
	)
	departmental_flags = ALL

// Tape

/datum/design/super_sticky_tape
	name = "超黏胶带"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/stack/medical/wrap/sticky_tape/super
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/pointy_tape
	name = "尖刺胶带"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plastic =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/medical/wrap/sticky_tape/pointy
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/super_pointy_tape
	name = "超尖刺胶带"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plastic =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/medical/wrap/sticky_tape/pointy/super
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

// Tackle Gloves

/datum/design/tackle_dolphin
	name = "海豚手套"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT*2.5)
	build_path = /obj/item/clothing/gloves/tackler/dolphin
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/tackle_rocket
	name = "火箭手套"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/clothing/gloves/tackler/rocket
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

// Restaurant Equipment

/datum/design/holosign/restaurant
	name = "餐厅座位指示器生成器"
	desc = "一种可为餐厅标示座位区域的全息投影器。"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/holosign_creator/robot_seat/restaurant
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/holosign/bar
	name = "酒吧座位指示器生成器"
	desc = "一种可为酒吧标示座位区域的全息投影器。"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/holosign_creator/robot_seat/bar
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/oven_tray
	name = "烤箱托盘"
	desc = "总得往里塞点什么！"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/plate/oven_tray
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

// Fishing Equipment

/datum/design/fishing_rod_tech
	name = "高级钓鱼竿"
	desc = "内置发电机的钓鱼竿，可无限供应鱼饵。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/fishing_rod/tech
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/fishing_gloves
	name = "运动钓鱼手套"
	desc = "一副不用钓竿就能钓鱼、还能顺带锻炼运动能力的手套。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/clothing/gloves/fishing
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/stabilized_hook
	name = "陀螺稳定鱼钩"
	desc = "一种高级鱼钩，让使用者在收线时能更牢固地控制上钩的鱼。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/fishing_hook/stabilized
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/auto_reel
	name = "钓线自动收线器"
	desc = "一种高级钓线卷轮，可用来加快钓鱼速度，或随手把其他物品拽向自己。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/fishing_line/auto_reel
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/bluespace_reel
	name = "蓝空间钓线"
	desc = "一种高级钓线卷轮，可触及远处的钓点，还能做到普通钓线做不到的其他事。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/fishing_line/bluespace
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/fish_analyzer
	name = "鱼类分析仪"
	desc = "一种用于监测鱼类状态与特质的分析仪。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5)
	build_path = /obj/item/fish_analyzer
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/bluespace_fish_case
	name = "蓝空间鱼盒"
	desc = "一种改进型鱼盒，能在紧凑的小空间里让大鱼保持停滞。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/storage/fish_case/bluespace
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/bluespace_fish_tank
	name = "蓝空间鱼缸套件"
	desc = "用于升级鱼缸容量所需的组件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/aquarium_upgrade/bluespace_tank
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/fish_genegun
	name = "鱼类基因枪"
	desc = "一种用于向鱼类注入或从鱼类提取特质的装置。也适用于大多数水生类生物。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 4, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/fish_genegun
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

// Coffeemaker Stuff

/datum/design/coffeepot
	name = "咖啡壶"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/plastic =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/reagent_containers/cup/coffeepot
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/coffeepot_bluespace
	name = "蓝空间咖啡壶"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic =SMALL_MATERIAL_AMOUNT*5, /datum/material/bluespace =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/reagent_containers/cup/coffeepot/bluespace
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/coffee_cartridge
	name = "空白咖啡粉盒"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/blank_coffee_cartridge
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/syrup_bottle
	name = "糖浆瓶"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/reagent_containers/cup/bottle/syrup_bottle
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/radio_navigation_beacon
	name = "紧凑型无线电导航巨型信标"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/folded_navigation_gigabeacon
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/shuttle_rods
	name = "穿梭机框架铁棍"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium = SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/rods/shuttle
	category = list(
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MATERIALS
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

// Experimental designs

/datum/design/polymorph_belt
	name = "变形场反转器"
	desc = "这台设备可以扫描并储存其他生命形态的 DNA，并用它来变形其佩戴者。需要一枚生物扰乱异常核心才能运作。"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/polymorph_belt
	materials = list(
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/perceptomatrix
	name = "感知矩阵头盔"
	desc = "这顶头盔利用幻觉能量保护其主人免受感知异常的影响。需要一枚致幻异常核心才能运作。"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/clothing/head/helmet/perceptomatrix
	materials = list(
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

// Anomaly locked item

/datum/design/space_furnace
	name = "太空炉"
	desc = "一座沉重的炉子，可临时形成一个能留住可呼吸空气的气泡。需要一枚热碎屑异常核心才能运作。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT*2.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	build_path = /obj/item/flashlight/lamp/space_bubble
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/anomalous_fishing_hook
	name = "异常拟饵钩"
	desc = "一种带有异常核心插槽的鱼钩。根据插入的核心不同，它能对钓竿或钓到的鱼产生各种效果。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 0.2)
	build_path = /obj/item/fishing_hook/anomaly
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/producepad
	name = "农产品传送平台"
	desc = "这种轻便装置可作为农产品传送机的信标，将新收获的食物传送到此处。"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/producepad
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_SECURITY
