/datum/design/kiboko_mag
	name = "河马榴弹弹匣"
	desc = "一种适用于兼容榴弹发射器的标准弹匣。"
	build_type = PROTOLATHE | AWAY_LATHE
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/magazine/c980_grenade/starts_empty
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/kiboko_box_mag
	name = "河马榴弹弹鼓"
	desc = "一种适用于兼容榴弹发射器的大容量弹鼓。"
	build_type = PROTOLATHE | AWAY_LATHE
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

// 12 Gauge Shell.. Individually.
// Because People will kill me if they realised the scale of economic
/datum/design/s12c_fslug
	name = "易碎独头弹（破坏性）"
	desc = "一种用于摧毁气闸的 12 号独头弹。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1, /datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ammo_casing/shotgun/frangible
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

//12 Gauge Ammunition Boxes
//This shit is a mistake but we embraced it instead of removing it, They all will require plastic to make alongside the iron cost
//I hate it

/datum/design/advancedgaugeboxes
	name = "12 号高级鹿弹弹药盒（致命）"
	desc = "一种用于装填霰弹枪弹药的 12 号弹药盒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	transfered_materials = list(/obj/item/ammo_box/advanced/s12gauge/buckshot = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15))
	build_path = /obj/item/ammo_box/advanced/s12gauge/buckshot
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_slug
	name = "12 号高级独头弹弹药盒（致命）"
	desc = "一种用于装填霰弹枪弹药的 12 号弹药盒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	transfered_materials = list(/obj/item/ammo_box/advanced/s12gauge = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15))
	build_path = /obj/item/ammo_box/advanced/s12gauge
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_flech
	name = "12 号高级箭形弹弹药盒（致命）"
	desc = "一种用于装填霰弹枪弹药的 12 号弹药盒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 6, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	transfered_materials = list(/obj/item/ammo_box/advanced/s12gauge/flechette = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15))
	build_path = /obj/item/ammo_box/advanced/s12gauge/flechette
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_incinslug
	name = "12 号高级燃烧独头弹弹药盒（极度致命）"
	desc = "一种用于装填霰弹枪弹药的 12 号弹药盒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	transfered_materials = list(/obj/item/ammo_box/advanced/s12gauge/incendiary = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15))
	build_path = /obj/item/ammo_box/advanced/s12gauge/incendiary
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_beanbagslug
	name = "12 号高级布袋弹弹药盒（低致命）"
	desc = "一种用于装填霰弹枪弹药的 12 号弹药盒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	transfered_materials = list(/obj/item/ammo_box/advanced/s12gauge/bean = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15))
	build_path = /obj/item/ammo_box/advanced/s12gauge/bean
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_CARGO

/datum/design/advancedgaugeboxes_rubbershot
	name = "12 号高级橡胶弹弹药盒（低致命）"
	desc = "一种用于装填霰弹枪弹药的 12 号弹药盒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	transfered_materials = list(/obj/item/ammo_box/advanced/s12gauge/rubber = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15))
	build_path = /obj/item/ammo_box/advanced/s12gauge/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_CARGO

/datum/design/advancedgaugeboxes_db
	name = "12 号高级龙息弹弹药盒（极度致命）"
	desc = "一种用于装填霰弹枪弹药的 12 号弹药盒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,  /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 15 , /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	transfered_materials = list(/obj/item/ammo_box/advanced/s12gauge/dragonsbreath = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15))
	build_path = /obj/item/ammo_box/advanced/s12gauge/dragonsbreath
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_breaching
	name = "12 号高级易碎独头弹弹药盒（破坏性）"
	desc = "一种用于装填霰弹枪弹药的 12 号弹药盒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,  /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 35 , /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	transfered_materials = list(/obj/item/ammo_box/advanced/s12gauge/frangible = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15))
	build_path = /obj/item/ammo_box/advanced/s12gauge/frangible
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_laser
	name = "12 号高级散射激光弹弹药盒（致命）"
	desc = "一种用于装填霰弹枪弹药的 12 号弹药盒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 15, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 10)
	transfered_materials = list(/obj/item/ammo_box/advanced/s12gauge/laser = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15))
	build_path = /obj/item/ammo_box/advanced/s12gauge/laser
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_hunting
	name = "12 号高级狩猎独头弹弹药盒（低致命）"
	desc = "一种用于装填霰弹枪弹药的 12 号弹药盒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15)
	build_path = /obj/item/ammo_box/advanced/s12gauge/hunter
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_CARGO

/datum/design/m9mm_mag
	name = "9x25mm Mk2 手枪弹匣（致命）"
	desc = "一种使用 9x25mm Mk2 弹药的标准手枪弹匣。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15)
	build_path = /obj/item/ammo_box/magazine/m9mm
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/m9mm_sec
	name = "弹匣（9x25mm 墨菲）（致命）"
	desc = "专为 9mm“墨菲”制式手枪的插拔装填而设计。更强的弹簧意味着更快的装填——那位把弹匣扔得砸碎窗户的警官也因此升职，\
		而正是这一扔启发了研发团队进一步改进弹匣弹出速度。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 3,
	)
	transfered_materials = list(/obj/item/ammo_box/magazine/security = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15))
	build_path = /obj/item/ammo_box/magazine/security
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/m9mm_sec_rocket
	name = "弹匣（9x25mm 墨菲 RE）（致命）"
	desc = "一种装有额外配重与气动护垫的不稳定弹匣，抛出后能迅速加速——最好是朝着嫌犯飞去。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 5,
	)
	transfered_materials = list(/obj/item/ammo_box/magazine/security/rocket = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15))
	build_path = /obj/item/ammo_box/magazine/security/rocket
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/m45_mag
	name = ".45 手枪弹匣（致命）"
	desc = "一种使用 .45 弹药的标准手枪弹匣。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15)
	build_path = /obj/item/ammo_box/magazine/m45
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/ntusp_conversion
	name = "NT-HCS 改装套件"
	desc = "一种标准改装套件，用于将 NT-HCS 弹匣改装得更致命或更不致命。"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/ntusp_conversion_kit
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/ntusp_powerpack
	name = "NT22-HCS 能量包"
	desc = "NT22-HCS“执法者”用的小型可充电能量包。最多可合成十二发能让目标疲惫的 .22HL 弹药。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 0.75,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 0.25,
	)
	transfered_materials = list(/obj/item/ammo_box/magazine/recharge/ntusp = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT))
	build_path = /obj/item/ammo_box/magazine/recharge/ntusp
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/ntmp5_powerpack
	name = "NT22-HCS-MP 能量包"
	desc = "NT22-HCS-MP“枪骑兵”用可充电能量包。最多可合成二十发能让目标疲惫的 .22HL 弹药。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 0.75,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 0.25,
	)
	inherit_materials = DESIGN_DONT_INHERIT_MATS
	build_path = /obj/item/ammo_box/magazine/recharge/ntmp5
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/m9mm_sec_speedloader
	name = "快速装弹器（9x25mm 墨菲）（致命）"
	desc = "用于快速为五发装 9mm 左轮手枪装弹。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/ammo_box/speedloader/security
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550kit_burst
	name = "WT-550 点射改装零件套件"
	desc = "一个用于将 WT-550 改装为点射模式的套件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcrafting/gunkit/wt550_burst
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550kit_long
	name = "WT-550 远程作战零件套件"
	desc = "一个用于让 WT-550 在远距离更有效的改装套件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/weaponcrafting/gunkit/wt550_long
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo_compressed
	name = "WT-550 弹匣（4.6x30mm 压缩弹）（致命）"
	desc = "WT-550 自动步枪的弹匣。装有大量低威力弹药。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 3,
	)
	transfered_materials = list(/obj/item/ammo_box/magazine/wt550m9/compressed = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2))
	build_path = /obj/item/ammo_box/magazine/wt550m9/compressed
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/simple_battle_rifle
	name = "NT-38 战斗步枪简化套件"
	desc = "一个用于简化 NT-38 战斗步枪的套件，使其复杂度大幅降低。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/weaponcrafting/gunkit/simple_battle_rifle
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/juggernaut_suit_parts
	name = "高级安保防护服装甲板"
	desc = "一套昂贵、密度极高的装甲板。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 40,
		/datum/material/titanium =SHEET_MATERIAL_AMOUNT * 40,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 40,
	)
	build_path = /obj/item/weaponcrafting/juggernaut_suit
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c32_speedloader
	name = "快速装弹器（.32）（致命）"
	desc = "用于快速为六发装 .32 左轮手枪装弹。"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*3)
	build_path = /obj/item/ammo_box/speedloader/c38/c32
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo
	name = "WT-550 弹匣（4.6x30mm 标准弹）（致命）"
	desc = "WT-550 自动步枪的弹匣。装有致命的标准弹药。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	transfered_materials = list(/obj/item/ammo_box/magazine/wt550m9 = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2))
	build_path = /obj/item/ammo_box/magazine/wt550m9
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo_ap
	name = "WT-550 弹匣（4.6x30mm 穿甲弹）（致命）"
	desc = "WT-550 自动步枪的弹匣。装有致命的穿甲弹药。纳米传讯希望你别在加压空间站里使用它们。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	transfered_materials = list(/obj/item/ammo_box/magazine/wt550m9/wtap = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.6))
	build_path = /obj/item/ammo_box/magazine/wt550m9/wtap
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo_incendiary
	name = "WT-550 弹匣（4.6x30mm 燃烧弹）（极度致命）"
	desc = "WT-550 自动步枪的弹匣。装有极度致命的燃烧弹药。使用前请查阅当地法律，确认是否构成战争罪。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2, /datum/material/silver = SHEET_MATERIAL_AMOUNT , /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	transfered_materials = list(/obj/item/ammo_box/magazine/wt550m9/wtic = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT))
	build_path = /obj/item/ammo_box/magazine/wt550m9/wtic
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_donk
	name = "12 号高级咚克尖刺弹弹药盒（致命）"
	desc = "一种用于装填霰弹枪弹药的 12 号弹药盒。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 35)
	build_path = /obj/item/ammo_box/advanced/s12gauge/donk
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
