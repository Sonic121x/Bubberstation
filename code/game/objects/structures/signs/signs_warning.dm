//warning signs


///////DANGEROUS THINGS

/obj/structure/sign/warning
	name = "\improper 警告标志"
	sign_change_name = "Warning"
	desc = "一个警告标志。"
	icon_state = "securearea"
	is_editable = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning, 32)
MAPPING_DIAGONAL_HELPERS(/obj/structure/sign/warning, 32)

/obj/structure/sign/warning/secure_area
	name = "\improper 安保区域标志"
	sign_change_name = "Warning - Secure Area"
	desc = "一个写着“安保区域”的警告标志。"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/secure_area, 32)
MAPPING_DIAGONAL_HELPERS(/obj/structure/sign/warning/secure_area, 32)

/obj/structure/sign/warning/docking
	name = "\improper 保持畅通：停靠区标志"
	sign_change_name = "Warning - Docking Area"
	desc = "一个写着“远离停靠区”的警告标志。"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/docking, 32)

/obj/structure/sign/warning/biohazard
	name = "\improper 生物危害标志"
	sign_change_name = "Warning - Biohazard"
	desc = "一个写着“生物危害”的警告标志。"
	icon_state = "bio"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/biohazard, 32)

/obj/structure/sign/warning/electric_shock
	name = "\improper 高压电标志"
	sign_change_name = "Warning - High Voltage"
	desc = "一个写着“高压电”的警告标志。"
	icon_state = "shock"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/electric_shock, 32)

/obj/structure/sign/warning/vacuum
	name = "\improper 前方硬真空标志"
	sign_change_name = "Warning - Hard Vacuum"
	desc = "一个写着“前方硬真空”的警告标志。"
	icon_state = "space"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/vacuum, 32)

/obj/structure/sign/warning/vacuum/external
	name = "\improper 外部气闸标志"
	sign_change_name = "Warning - External Airlock"
	desc = "一个写着“外部气闸”的警告标志。"
	layer = MOB_LAYER

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/vacuum/external, 32)

/obj/structure/sign/warning/deathsposal
	name = "\improper 垃圾处理：通往太空标志"
	sign_change_name = "Warning - Disposals: Leads to Space"
	desc = "一个写着“垃圾处理：通往太空”的警告标志。"
	icon_state = "deathsposal"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/deathsposal, 32)

/obj/structure/sign/warning/bodysposal
	name = "\improper 垃圾处理：通往停尸房标志"
	sign_change_name = "Warning - Disposals: Leads to Morgue"
	desc = "一个写着“垃圾处理：通往停尸房”的警告标志。"
	icon_state = "bodysposal"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/bodysposal, 32)

/obj/structure/sign/warning/fire
	name = "\improper 危险：火灾标志"
	sign_change_name = "Warning - Fire Hazard"
	desc = "一个写着“危险：火灾”的警告标志。"
	icon_state = "fire"
	resistance_flags = FIRE_PROOF

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/fire, 32)

/obj/structure/sign/warning/no_smoking
	name = "\improper 禁止吸烟标志"
	sign_change_name = "Warning - No Smoking"
	desc = "一个写着“禁止吸烟”的警告标志。"
	icon_state = "nosmoking2"
	resistance_flags = FLAMMABLE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/no_smoking, 32)

/obj/structure/sign/warning/no_smoking/circle
	name = "\improper 禁止吸烟标志"
	sign_change_name = "Warning - No Smoking Alt"
	desc = "一个写着“禁止吸烟”的警告标志。"
	icon_state = "nosmoking"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/no_smoking/circle, 32)

/obj/structure/sign/warning/yes_smoking/circle
	name = "\improper 允许吸烟标志"
	sign_change_name = "Warning - Yes Smoking"
	desc = "一个写着“允许吸烟”的警告标志。"
	icon_state = "yessmoking"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/yes_smoking/circle, 32)

/obj/structure/sign/warning/radiation
	name = "\improper 有害辐射标志"
	sign_change_name = "Warning - Radiation"
	desc = "一个警告标志，提醒观看者存在潜在的辐射危害。"
	icon_state = "radiation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/radiation, 32)

/obj/structure/sign/warning/radiation/rad_area
	name = "\improper 放射性区域标志"
	sign_change_name = "Warning - Radioactive Area"
	desc = "一个写着“放射性区域”的警告标志。"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/radiation/rad_area, 32)

/obj/structure/sign/warning/xeno_mining
	name = "\improper 危险外星生物标志"
	sign_change_name = "Warning - Xenos"
	desc = "一个标志，警告过往旅客附近存在敌对的外星生物。"
	icon = 'icons/obj/signs.dmi'
	icon_state = "xeno_warning"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/xeno_mining, 32)

/obj/structure/sign/warning/engine_safety
	name = "\improper 工程安全标志"
	sign_change_name = "Warning - Engineering Safety Protocols"
	desc = "一个标志，详细列出了现场作业时的各项安全规程，以确保班次安全。"
	icon_state = "safety"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/engine_safety, 32)

/obj/structure/sign/warning/explosives
	name = "\improper 高爆炸药标志"
	sign_change_name = "Warning - Explosives"
	desc = "一个写着“高爆炸药”的警告标志。"
	icon_state = "explosives"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/explosives, 32)

/obj/structure/sign/warning/explosives/alt
	name = "\improper 高爆炸药标志"
	sign_change_name = "Warning - Explosives Alt"
	desc = "一个写着“高爆炸药”的警告标志。"
	icon_state = "explosives2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/explosives/alt, 32)

/obj/structure/sign/warning/test_chamber
	name = "\improper 测试区域标志"
	sign_change_name = "Warning - Testing Area"
	desc = "一个标志，警告附近区域有高功率测试设备。"
	icon_state = "testchamber"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/test_chamber, 32)

/obj/structure/sign/warning/firing_range
	name = "\improper 靶场标志"
	sign_change_name = "Warning - Firing Range"
	desc = "一个标志，提醒你待在射击线后方，并佩戴护耳用具。"
	icon_state = "firingrange"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/firing_range, 32)

/obj/structure/sign/warning/cold_temp
	name = "\improper 极冷空气标志"
	sign_change_name = "Warning - Temp: Cold"
	desc = "一个标志，警告附近空气极度寒冷。"
	icon_state = "cold"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/cold_temp, 32)

/obj/structure/sign/warning/hot_temp
	name = "\improper 过热空气标志"
	sign_change_name = "Warning - Temp: Hot"
	desc = "一个标志，警告附近空气极度灼热。"
	icon_state = "heat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/hot_temp, 32)

/obj/structure/sign/warning/gas_mask
	name = "\improper 空气污染标志"
	sign_change_name = "Warning - Contaminated Air"
	desc = "一个标志，警告空气中有危险的颗粒物或气体，并要求你佩戴内置呼吸装备。"
	icon_state = "gasmask"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/gas_mask, 32)

/obj/structure/sign/warning/chem_diamond
	name = "\improper 活性化学品标志"
	sign_change_name = "Warning - Hazardous Chemicals sign"
	desc = "一个标志，警告附近有潜在反应性的化学品，可能是爆炸性、易燃性或腐蚀性的。"
	icon_state = "chemdiamond"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/chem_diamond, 32)

/obj/structure/sign/warning/doors
	name = "\improper 防爆门标志"
	sign_change_name = "Warning - Blast Doors"
	desc = "一个标志，表示此处有门。门到处都是！"
	icon_state = "doors"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/doors, 32)

////MISC LOCATIONS

/obj/structure/sign/warning/pods
	name = "\improper 逃生舱标志"
	sign_change_name = "Location - Escape Pods"
	desc = "一个写着“逃生舱”的警告标志。"
	icon_state = "pods"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/pods, 32)

/obj/structure/sign/warning/rad_shelter
	name = "\improper 辐射风暴避难所标志"
	sign_change_name = "Location - Radstorm Shelter"
	desc = "一个写着“辐射风暴避难所”的警告标志。"
	icon_state = "radshelter"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/rad_shelter, 32)
