/////////////////////////
////// Mecha Parts //////
/////////////////////////

/obj/item/mecha_parts
	name = "机甲部件"
	icon = 'icons/mob/rideables/mech_construct.dmi'
	icon_state = "blank"
	abstract_type = /obj/item/mecha_parts
	w_class = WEIGHT_CLASS_GIGANTIC
	obj_flags = CONDUCTS_ELECTRICITY
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP

/obj/item/mecha_parts/proc/try_attach_part(mob/user, obj/vehicle/sealed/mecha/M, attach_right = FALSE) //For attaching parts to a finished mech
	if(!user.transferItemToLoc(src, M))
		to_chat(user, span_warning("[src] 粘在你手上，你无法把它放进 [M]！"))
		return ITEM_INTERACT_BLOCKING
	user.visible_message(span_notice("[user] 将 [src] 安装到 [M] 上。"), span_notice("你将 [src] 安装到 [M] 上。"))
	return ITEM_INTERACT_SUCCESS

/obj/item/mecha_parts/part/try_attach_part(mob/user, obj/vehicle/sealed/mecha/M, attach_right = FALSE)
	return ITEM_INTERACT_SUCCESS

/obj/item/mecha_parts/chassis
	name = "机甲底盘"
	icon_state = "backbone"
	interaction_flags_item = NONE //Don't pick us up!!
	var/construct_type

/obj/item/mecha_parts/chassis/Initialize(mapload)
	. = ..()
	if(construct_type)
		AddComponent(construct_type)

/////////// Ripley

/obj/item/mecha_parts/chassis/ripley
	name = "\improper 雷普利底盘"
	construct_type = /datum/component/construction/unordered/mecha_chassis/ripley
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)

/obj/item/mecha_parts/part/ripley_torso
	name = "\improper 雷普利躯干"
	desc = "雷普利 APLU 的躯干部件。内含动力单元、处理核心与生命维持系统。"
	icon_state = "ripley_harness"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3.75)

/obj/item/mecha_parts/part/ripley_left_arm
	name = "\improper 雷普利左臂"
	desc = "雷普利 APLU 的左臂。数据与电源接口兼容大多数机甲工具。"
	icon_state = "ripley_l_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5)

/obj/item/mecha_parts/part/ripley_right_arm
	name = "\improper 雷普利右臂"
	desc = "雷普利 APLU 的右臂。数据与电源接口兼容大多数机甲工具。"
	icon_state = "ripley_r_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5)

/obj/item/mecha_parts/part/ripley_left_leg
	name = "\improper 雷普利左腿"
	desc = "雷普利 APLU 的左腿。内含较为复杂的伺服驱动与平衡维持系统。"
	icon_state = "ripley_l_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5)

/obj/item/mecha_parts/part/ripley_right_leg
	name = "\improper 雷普利右腿"
	desc = "雷普利 APLU 的右腿。内含较为复杂的伺服驱动与平衡维持系统。"
	icon_state = "ripley_r_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5)

///////// Odysseus

/obj/item/mecha_parts/chassis/odysseus
	name = "\improper 奥德修斯底盘"
	construct_type = /datum/component/construction/unordered/mecha_chassis/odysseus
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)

/obj/item/mecha_parts/part/odysseus_head
	name = "\improper 奥德修斯头部"
	desc = "奥德修斯的头部。内含集成医疗 HUD 扫描仪。"
	icon_state = "odysseus_head"
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 3)

/obj/item/mecha_parts/part/odysseus_torso
	name = "\improper 奥德修斯躯干"
	desc="奥德修斯的躯干部件。内含动力单元、处理核心与生命维持系统，以及用于安装睡眠舱的连接口。"
	icon_state = "odysseus_torso"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6)

/obj/item/mecha_parts/part/odysseus_left_arm
	name = "\improper 奥德修斯左臂"
	desc = "奥德修斯的左臂。数据与电源接口兼容专业医疗设备。"
	icon_state = "odysseus_l_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3)

/obj/item/mecha_parts/part/odysseus_right_arm
	name = "\improper 奥德修斯右臂"
	desc = "奥德修斯的右臂。数据与电源接口兼容专业医疗设备。"
	icon_state = "odysseus_r_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3)

/obj/item/mecha_parts/part/odysseus_left_leg
	name = "\improper 奥德修斯左腿"
	desc = "奥德修斯的左腿。内含复杂的伺服驱动与平衡维持系统，为危重病人保持稳定。"
	icon_state = "odysseus_l_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.5)

/obj/item/mecha_parts/part/odysseus_right_leg
	name = "\improper 奥德修斯右腿"
	desc = "奥德修斯的右腿。内含复杂的伺服驱动与平衡维持系统，为危重病人保持稳定。"
	icon_state = "odysseus_r_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.5)

///////// Gygax

/obj/item/mecha_parts/chassis/gygax
	name = "\improper 吉盖克斯底盘"
	construct_type = /datum/component/construction/unordered/mecha_chassis/gygax
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)

/obj/item/mecha_parts/part/gygax_torso
	name = "\improper 吉盖克斯躯干"
	desc = "吉盖克斯的躯干部件。内含动力单元、处理核心与生命维持系统。"
	icon_state = "gygax_harness"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/silver = SHEET_MATERIAL_AMOUNT)

/obj/item/mecha_parts/part/gygax_head
	name = "\improper 吉盖克斯头部"
	desc = "吉盖克斯的头部。装设先进的监视与瞄准传感器。"
	icon_state = "gygax_head"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/silver = SHEET_MATERIAL_AMOUNT)

/obj/item/mecha_parts/part/gygax_left_arm
	name = "\improper 吉盖克斯左臂"
	desc = "吉盖克斯的左臂。数据与电源接口兼容大多数机甲工具与武器。"
	icon_state = "gygax_l_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/mecha_parts/part/gygax_right_arm
	name = "\improper 吉盖克斯右臂"
	desc = "吉盖克斯的右臂。数据与电源接口兼容大多数机甲工具与武器。"
	icon_state = "gygax_r_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/mecha_parts/part/gygax_left_leg
	name = "\improper 吉盖克斯左腿"
	desc = "吉盖克斯的左腿。采用先进的伺服机构与致动器，可实现更快的速度。"
	icon_state = "gygax_l_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/mecha_parts/part/gygax_right_leg
	name = "\improper 吉盖克斯右腿"
	desc = "吉盖克斯的右腿。采用先进的伺服机构与致动器，可实现更快的速度。"
	icon_state = "gygax_r_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/mecha_parts/part/gygax_armor
	gender = PLURAL
	name = "\improper 吉盖克斯装甲板"
	desc = "一套为吉盖克斯设计的装甲板。轻量化结构可有效弹开来袭伤害。"
	icon_state = "gygax_armor"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5)


//////////// Durand

/obj/item/mecha_parts/chassis/durand
	name = "\improper 杜兰德底盘"
	construct_type = /datum/component/construction/unordered/mecha_chassis/durand
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12.5)

/obj/item/mecha_parts/part/durand_torso
	name = "\improper 杜兰德躯干"
	desc = "杜兰德的躯干部件。在坚固的防护框架内装有动力单元、处理核心与生命维持系统。"
	icon_state = "durand_harness"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/mecha_parts/part/durand_head
	name = "\improper 杜兰德头部"
	desc = "杜兰德的头部。装设先进的监视与瞄准传感器。"
	icon_state = "durand_head"
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT)

/obj/item/mecha_parts/part/durand_left_arm
	name = "\improper 杜兰德左臂"
	desc = "杜兰德的左臂。数据与电源接口兼容大多数机甲工具与武器。出拳也格外凶猛。"
	icon_state = "durand_l_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/mecha_parts/part/durand_right_arm
	name = "\improper 杜兰德右臂"
	desc = "杜兰德的右臂。数据与电源接口兼容大多数机甲工具与武器。出拳也格外凶猛。"
	icon_state = "durand_r_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/mecha_parts/part/durand_left_leg
	name = "\improper 杜兰德左腿"
	desc = "杜兰德的左腿。结构格外坚固，以支撑杜兰德沉重的重量与防御需求。"
	icon_state = "durand_l_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/mecha_parts/part/durand_right_leg
	name = "\improper 杜兰德右腿"
	desc = "杜兰德的右腿。结构格外坚固，以支撑杜兰德沉重的重量与防御需求。"
	icon_state = "durand_r_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/mecha_parts/part/durand_armor
	gender = PLURAL
	name = "\improper 杜兰德装甲板"
	desc = "一套杜兰德专用装甲板。厚重的结构足以抵抗极大的钝击力量。"
	icon_state = "durand_armor"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 30, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 12.5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 10)

////////// Clarke

/obj/item/mecha_parts/chassis/clarke
	name = "\improper 克拉克底盘"
	construct_type = /datum/component/construction/unordered/mecha_chassis/clarke
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)

/obj/item/mecha_parts/part/clarke_torso
	name = "\improper 克拉克躯干"
	desc = "克拉克的躯干部件。内含动力单元、处理核心与生命维持系统。"
	icon_state = "clarke_harness"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3.75)

/obj/item/mecha_parts/part/clarke_head
	name = "\improper 克拉克头部"
	desc = "克拉克的头部。内含集成诊断 HUD 扫描仪。"
	icon_state = "clarke_head"
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 3)

/obj/item/mecha_parts/part/clarke_left_arm
	name = "\improper 克拉克左臂"
	desc = "克拉克的左臂。数据与电源接口兼容大多数机甲工具。"
	icon_state = "clarke_l_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5)

/obj/item/mecha_parts/part/clarke_right_arm
	name = "\improper 克拉克右臂"
	desc = "克拉克的右臂。数据与电源接口兼容大多数机甲工具。"
	icon_state = "clarke_r_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5)

////////// HONK

/obj/item/mecha_parts/chassis/honker
	name = "\improper H.O.N.K 底盘"
	construct_type = /datum/component/construction/unordered/mecha_chassis/honker
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)

/obj/item/mecha_parts/part/honker_torso
	name = "\improper H.O.N.K 躯干"
	desc = "H.O.N.K 的躯干部件。内含窃笑单元、香蕉矿核心与洪克维持系统。"
	icon_state = "honker_harness"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/bananium = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/mecha_parts/part/honker_head
	name = "\improper H.O.N.K 头部"
	desc = "H.O.N.K 的头部。似乎缺少面板。"
	icon_state = "honker_head"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/bananium = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/mecha_parts/part/honker_left_arm
	name = "\improper H.O.N.K 左臂"
	desc = "H.O.N.K 的左臂。独特的接口可接受小丑科学家设计的古怪武器。"
	icon_state = "honker_l_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/bananium = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/mecha_parts/part/honker_right_arm
	name = "\improper H.O.N.K 右臂"
	desc = "H.O.N.K 的右臂。独特的接口可接受小丑科学家设计的古怪武器。"
	icon_state = "honker_r_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/bananium = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/mecha_parts/part/honker_left_leg
	name = "\improper H.O.N.K 左腿"
	desc = "H.O.N.K 的左腿。脚部看起来刚好能完全容纳一只小丑鞋。"
	icon_state = "honker_l_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/bananium = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/mecha_parts/part/honker_right_leg
	name = "\improper H.O.N.K 右腿"
	desc = "H.O.N.K 的右腿。脚部看起来刚好能完全容纳一只小丑鞋。"
	icon_state = "honker_r_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/bananium = SHEET_MATERIAL_AMOUNT * 2.5)


////////// Phazon

/obj/item/mecha_parts/chassis/phazon
	name = "\improper 相位行者底盘"
	construct_type = /datum/component/construction/unordered/mecha_chassis/phazon
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)

/obj/item/mecha_parts/part/phazon_torso
	name="\improper 相位行者躯干"
	desc="相位行者的躯干部件。中央设有插槽，用于安装为机甲独特相位驱动供能的灵质核心。"
	icon_state = "phazon_harness"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 17.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/mecha_parts/part/phazon_head
	name="\improper 相位行者头部"
	desc="相位行者的头部。其传感器经过精心校准，即使机甲处于相位状态也能提供视野与数据。"
	icon_state = "phazon_head"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/mecha_parts/part/phazon_left_arm
	name="\improper 相位行者左臂"
	desc="相位行者的左臂。装甲板下装有若干微型工具阵列，可根据实际情况调整。"
	icon_state = "phazon_l_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/mecha_parts/part/phazon_right_arm
	name="\improper 相位行者右臂"
	desc="相位行者的右臂。装甲板下装有若干微型工具阵列，可根据实际情况调整。"
	icon_state = "phazon_r_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/mecha_parts/part/phazon_left_leg
	name="\improper 相位行者左腿"
	desc="相位行者的左腿。内含独特的相位驱动器，启动后可使机甲穿过固体物质。"
	icon_state = "phazon_l_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/mecha_parts/part/phazon_right_leg
	name="\improper 相位行者右腿"
	desc="相位行者的右腿。内含独特的相位驱动器，启动后可使机甲穿过固体物质。"
	icon_state = "phazon_r_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/mecha_parts/part/phazon_armor
	name="相位行者装甲"
	desc="相位行者装甲板。以等离子体分层，保护驾驶员免受相位压力的影响，并具有不寻常的特性。"
	icon_state = "phazon_armor"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 10)

// Savannah-Ivanov

/obj/item/mecha_parts/chassis/savannah_ivanov
	name = "\improper 萨凡纳-伊万诺夫底盘"
	construct_type = /datum/component/construction/unordered/mecha_chassis/savannah_ivanov
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12.5)

/obj/item/mecha_parts/part/savannah_ivanov_torso
	name="\improper 萨凡纳-伊万诺夫躯干"
	desc="萨凡纳-伊万诺夫的躯干部件。它缺了一大块空间……"
	icon_state = "savannah_ivanov_harness"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/mecha_parts/part/savannah_ivanov_head
	name="\improper 萨凡纳-伊万诺夫头部"
	desc="萨凡纳-伊万诺夫的头部。其传感器经过调整，以支持优雅的着陆。"
	icon_state = "savannah_ivanov_head"
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT)

/obj/item/mecha_parts/part/savannah_ivanov_left_arm
	name="\improper 萨凡纳-伊万诺夫左臂"
	desc="萨凡纳-伊万诺夫的左臂。腕部内置隐藏式火箭制造装置。"
	icon_state = "savannah_ivanov_l_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/mecha_parts/part/savannah_ivanov_right_arm
	name="\improper 萨凡纳-伊万诺夫右臂"
	desc="萨凡纳-伊万诺夫的左臂。腕部内置隐藏式火箭制造装置。"
	icon_state = "savannah_ivanov_r_arm"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/mecha_parts/part/savannah_ivanov_left_leg
	name="\improper 萨凡纳-伊万诺夫左腿"
	desc="萨凡纳-伊万诺夫的左腿。在生产设计中，它们本要搭载两名以上乘员，因此加入了跳跃功能，以免浪费潜力。"
	icon_state = "savannah_ivanov_l_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/mecha_parts/part/savannah_ivanov_right_leg
	name="\improper 萨凡纳-伊万诺夫右腿"
	desc="萨凡纳-伊万诺夫的左腿。在生产设计中，它们本要搭载两名以上乘员，因此加入了跳跃功能，以免浪费潜力。"
	icon_state = "savannah_ivanov_r_leg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/mecha_parts/part/savannah_ivanov_armor
	name="萨凡纳-伊万诺夫装甲"
	desc="萨凡纳-伊万诺夫装甲板。其形状独特并经过强化，以承受双驾驶员、夸张的跳跃与导弹带来的压力。"
	icon_state = "savannah_ivanov_armor"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 30, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 12.5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 10)

///////// Circuitboards

/obj/item/circuitboard/mecha
	name = "机甲电路板"
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "std_mod"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 5
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 3
	throw_range = 7

/obj/item/circuitboard/mecha/ripley/peripherals
	name = "雷普利外围控制模块（机甲电路板）"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/ripley/main
	name = "雷普利中央控制模块（机甲电路板）"
	icon_state = "mainboard"


/obj/item/circuitboard/mecha/gygax/peripherals
	name = "吉盖克斯外围控制模块（机甲电路板）"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/gygax/targeting
	name = "吉盖克斯武器控制与瞄准模块（机甲电路板）"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/gygax/main
	name = "吉盖克斯中央控制模块（机甲电路板）"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/durand/peripherals
	name = "杜兰德外围控制模块（机甲电路板）"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/durand/targeting
	name = "杜兰德武器控制与瞄准模块（机甲电路板）"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/durand/main
	name = "杜兰德中央控制模块（机甲电路板）"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/honker/peripherals
	name = "H.O.N.K 外围控制模块（机甲电路板）"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/honker/targeting
	name = "H.O.N.K 武器控制与瞄准模块（机甲电路板）"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/honker/main
	name = "H.O.N.K 中央控制模块（机甲电路板）"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/odysseus/peripherals
	name = "奥德修斯外围控制模块（机甲电路板）"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/odysseus/main
	name = "奥德修斯中央控制模块（机甲电路板）"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/phazon/peripherals
	name = "相位行者外围控制模块（机甲电路板）"
	icon_state = "mcontroller"
	custom_materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT)

/obj/item/circuitboard/mecha/phazon/targeting
	name = "相位行者武器控制与瞄准模块（机甲电路板）"
	icon_state = "mcontroller"
	custom_materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT)

/obj/item/circuitboard/mecha/phazon/main
	name = "相位行者中央控制模块（机甲电路板）"
	custom_materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT)

/obj/item/circuitboard/mecha/clarke/peripherals
	name = "克拉克外围控制模块（机甲电路板）"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/clarke/main
	name = "克拉克中央控制模块（机甲电路板）"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/savannah_ivanov/peripherals
	name = "萨凡纳外围控制模块（机甲电路板）"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/savannah_ivanov/targeting
	name = "伊万诺夫武器控制与瞄准模块（机甲电路板）"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/savannah_ivanov/main
	name = "萨凡纳-伊万诺夫组合控制锁模块（机甲电路板）"
	icon_state = "mainboard"
