/////////////////////////////////////////
/////////////////Weapons/////////////////
/////////////////////////////////////////

/datum/design/c38/sec
	build_type = PROTOLATHE | AWAY_LATHE
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_trac
	name = "快速装弹器（.38 追踪弹）（低致命性）"
	desc = "用于快速为左轮手枪装弹。追踪弹会在目标体内植入一枚追踪植入体。该植入体的信号与传送器不兼容。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/ammo_box/speedloader/c38/trac
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_hotshot
	name = "快速装弹器（.38 炽热弹）（极高致命性）"
	desc = "用于快速为左轮手枪装弹。炽热弹内装有燃烧装药。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/ammo_box/speedloader/c38/hotshot
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_iceblox
	name = "快速装弹器（.38 冰封弹）（致命/对蜥蜴人极高致命性）"
	desc = "用于快速为左轮手枪装弹。冰封弹内装有低温装药。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/ammo_box/speedloader/c38/iceblox
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_rubber
	name = "快速装弹器（.38 橡胶弹）（低致命性）"
	desc = "用于快速为左轮手枪装弹。橡胶子弹弹性十足，属于低致命弹药。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/ammo_box/speedloader/c38/match/bouncy
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_true
	name = "快速装弹器（.38 必中弹）（致命）"
	desc = "用于快速为左轮手枪装弹。子弹会以惊人的精度弹向新的目标，并能击穿披甲目标。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/ammo_box/speedloader/c38/true
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_flare
	name = "快速装弹器（.38 照明弹）（极高致命性）"
	desc = "用于快速为左轮手枪装弹。照明弹弹壳会朝目标发射一束集中的粒子束，把目标照亮给所有人看。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/ammo_box/speedloader/c38/flare
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_mag
	name = "战斗步枪弹匣（.38）（致命）"
	desc = "专为快速战术换弹 NT BR-38 战斗步枪而设计。.38 口径武器的威力天生较低，但在警察部队、私人安保公司以及无法获得能量型非致命武器的组织中仍相当流行。\
		相对较低的穿透力有助于避免对空间站与穿梭机的船体造成潜在损伤，\
		因此在这些场合反而很有用。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/ammo_box/magazine/m38
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_trac_mag
	name = "战斗步枪弹匣（.38 追踪弹）（低致命性）"
	desc = "专为快速战术换弹 NT BR-38 战斗步枪而设计。追踪弹会在目标体内植入一枚追踪植入体。该植入体的信号与传送器不兼容。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/ammo_box/magazine/m38/trac
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_hotshot_mag
	name = "战斗步枪弹匣（.38 炽热弹）（极高致命性）"
	desc = "专为快速战术换弹 NT BR-38 战斗步枪而设计。炽热弹内装有燃烧装药。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/ammo_box/magazine/m38/hotshot
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_iceblox_mag
	name = "战斗步枪弹匣（.38 冰封弹）（致命/对蜥蜴人极高致命性）"
	desc = "专为快速战术换弹 NT BR-38 战斗步枪而设计。冰封弹内装有低温装药。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/ammo_box/magazine/m38/iceblox
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_rubber_mag
	name = "战斗步枪弹匣（.38 橡胶弹）（低致命性）"
	desc = "专为快速战术换弹 NT BR-38 战斗步枪而设计。橡胶子弹弹性十足，属于低致命弹药。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/ammo_box/magazine/m38/match/bouncy
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_true_mag
	name = "战斗步枪弹匣（.38 必中弹）（致命）"
	desc = "专为快速战术换弹 NT BR-38 战斗步枪而设计。子弹会以惊人的精度弹向新的目标，并能击穿披甲目标。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/ammo_box/magazine/m38/true
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_flare_mag
	name = "战斗步枪弹匣（.38 照明弹）（极高致命性）"
	desc = "专为快速战术换弹 NT BR-38 战斗步枪而设计。照明弹弹壳会朝目标发射一束集中的粒子束，把目标照亮给所有人看。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT * 1.5,

	)
	build_path = /obj/item/ammo_box/magazine/m38/flare
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_flare_mag
	name = "战斗步枪弹匣（.38 照明弹）（极高致命性）"
	desc = "专为快速战术换弹 NT BR-38 战斗步枪而设计。照明弹弹壳会朝目标发射一束集中的粒子束，把目标照亮给所有人看。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT * 1.5,

	)
	build_path = /obj/item/ammo_box/magazine/m38/flare
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/rubbershot/sec
	desc = "橡胶霰弹。发射一片弹丸。橡胶子弹弹性十足，属于低致命弹药。"
	build_type = PROTOLATHE | AWAY_LATHE
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/beanbag_slug/sec
	desc = "豆袋独头霰弹。发射一枚独头弹（豆袋）。低致命性。"
	build_type = PROTOLATHE | AWAY_LATHE
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/shotgun_dart/sec
	desc = "飞镖霰弹。发射一枚弹丸（飞镖）。可装填化学物质，\
		命中目标时将其注入。否则威力极弱。"
	build_type = PROTOLATHE | AWAY_LATHE
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/incendiary_slug/sec
	desc = "飞镖霰弹。发射一枚独头弹。命中时点燃目标，\
		并在飞行途中留下一道火焰。对使用者极不友好，但很有效。"
	build_type = PROTOLATHE | AWAY_LATHE
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/* BUBBER EDIT REMOVAL BEGIN
/datum/design/mag_autorifle
	name = "WT-550 Autorifle Magazine (4.6x30mm) (Lethal)"
	desc = "A 20 round magazine for the out of date WT-550 Autorifle."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/ammo_box/magazine/wt550m9
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/mag_autorifle/ap_mag
	name = "WT-550 Autorifle Armour Piercing Magazine (4.6x30mm AP) (Lethal)"
	desc = "A 20 round armour piercing magazine for the out of date WT-550 Autorifle."
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 6)
	build_path = /obj/item/ammo_box/magazine/wt550m9/wtap
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/mag_autorifle/ic_mag
	name = "WT-550 Autorifle Incendiary Magazine (4.6x30mm IC) (Lethal/Highly Destructive)"
	desc = "A 20 round armour piercing magazine for the out of date WT-550 Autorifle."
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 6, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ammo_box/magazine/wt550m9/wtic
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
*/// BUBBER EDIT REMOVAL END

/datum/design/pin_testing
	name = "靶场击针"
	desc = "这种安全击针只允许在靶场附近开火。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/firing_pin/test_range
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_FIRING_PINS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/pin_mindshield
	name = "心智护盾击针"
	desc = "这种安保击针只授权植入了心智护盾的用户使用该武器。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/silver = SMALL_MATERIAL_AMOUNT * 6, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 6, /datum/material/uranium =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/firing_pin/implant/mindshield
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_FIRING_PINS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/pin_explorer
	name = "内陆击针"
	desc = "这种击针只在你不在站内时才能开火，没毛病，伙计！"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/firing_pin/explorer
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_FIRING_PINS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/stunrevolver
	name = "特斯拉炮零件套件（致命）"
	desc = "一套用于制造高科技炮的套件，它以旋转弹巢发射可重复使用的内置电击弹。这些电击弹可用常规充电器充电。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcrafting/gunkit/tesla
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/nuclear_gun
	name = "高级能量枪零件套件（致命/非致命）"
	desc = "一套用于制造配备实验性微型反应堆的能量枪的套件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/uranium =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/weaponcrafting/gunkit/nuclear
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/tele_shield
	name = "伸缩盾"
	desc = "一面由轻质材料制成的先进防暴盾，可折叠以便收纳。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/silver =SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/shield/riot/tele
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_MELEE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/ballistic_shield
	name = "防弹盾"
	desc = "一面专为阻挡弹丸而设计的重盾，对近战防御较弱。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/titanium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/shield/ballistic
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_MELEE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/beamrifle
	name = "事件视界反存在光束步枪零件套件（末日装置）"
	desc = "一套用于制造能在存在层面上终结敌人的武器的套件。你到底为什么能造出这东西？"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/diamond =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 4, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2.25, /datum/material/gold =SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/weaponcrafting/gunkit/beam_rifle
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/rapidsyringe
	name = "速射注射枪"
	desc = "一把能连续发射大量注射器的枪。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/gun/syringe/rapidsyringe
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL //uwu

/datum/design/temp_gun
	name = "温控枪零件套件（低致命性/对蜥蜴人极其致命）"
	desc = "一把能射出温度子弹——差不多算是——来改变温度的枪。"//Change it if you want
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/weaponcrafting/gunkit/temperature
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/flora_gun
	name = "植物体细胞射线枪"
	desc = "一种释放受控辐射、诱导植物细胞突变的工具。对其他有机生命无害。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/uranium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/gun/energy/floragun
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/large_grenade
	name = "大型手榴弹外壳"
	desc = "一种作用范围更大、可使用更大容器的化学手榴弹。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/grenade/chem_grenade/large
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/pyro_grenade
	name = "高温手榴弹外壳"
	desc = "一种能自行点燃其内容物的高级化学手榴弹。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/plasma =SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/grenade/chem_grenade/pyro
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cryo_grenade
	name = "低温手榴弹外壳"
	desc = "一种引爆后会迅速冷却内容物的高级化学手榴弹。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/grenade/chem_grenade/cryo
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/adv_grenade
	name = "高级分次释放手榴弹外壳"
	desc = "一种可多次引爆的高级化学手榴弹，最好搭配重复点火器使用。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/grenade/chem_grenade/adv_release
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/xray
	name = "X 射线激光枪零件套件（致命）"
	desc = "其实没有听起来那么可怕。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/gold =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2, /datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/titanium =SHEET_MATERIAL_AMOUNT, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/weaponcrafting/gunkit/xray
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/ioncarbine
	name = "离子卡宾枪零件套件（非致命/高破坏力/对硅基生命极其致命）"
	desc = "《如何拆解半机械人：枪械版》。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/uranium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/weaponcrafting/gunkit/ion
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wormhole_projector
	name = "蓝空间虫洞投射器"
	desc = "一种发射高密度量子耦合蓝空间光束的投射器。需要蓝空间异常核心才能运作。"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver =SHEET_MATERIAL_AMOUNT, /datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/diamond =SHEET_MATERIAL_AMOUNT, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/gun/energy/wormhole_projector
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/lasershell
	name = "散射激光霰弹（致命）"
	desc = "一种高科技霰弹，弹壳内装有内置电容器与激光聚焦晶体。\
		可用常规弹道霰弹枪发射，膛线磨损极小，也会让多数目标糊满\
		狰狞的烧伤。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/ammo_casing/shotgun/scatterlaser
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/flechette
	name = "飞镖霰弹（致命）"
	desc = "一种装满小型金属飞镖的霰弹壳。能在血肉与凯夫拉上扎出许多小孔，适合把某人的内脏\
		变成外脏。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/ammo_casing/shotgun/flechette
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/techshell
	name = "未装填科技霰弹"
	desc = "一种高科技霰弹，可加工成更高级的霰弹以产生独特效果。\
		单独一枚则毫无作用。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/ammo_casing/shotgun/techshell
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/flechette
	name = "飞镖霰弹（致命）"
	desc = "一种装满小型金属飞镖的霰弹壳。能在血肉与凯夫拉上扎出许多小孔，适合把某人的内脏\
		变成外脏。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/ammo_casing/shotgun/flechette
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/donkflechette
	name = "咚克公司“咚克尖刺”飞镖霰弹（致命）"
	desc = "一种装满小型塑料飞镖的霰弹壳。没错，塑料。你真觉得塑料有那么吓人吗？被这玩意打中\
		确实会疼，但真的会造成多少伤害呢？你自己判断吧，老兄，我不是你妈。我只是台电脑。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/ammo_casing/shotgun/flechette/donk
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/tear_gas_40mm
	name = "40mm 催泪瓦斯榴弹（低致命性）"
	desc = "想平息一场暴乱，或者收拾掉那些开着破旧太空房车到处跑的太空嬉皮士？我们有专门的手榴弹给你！"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/ammo_casing/a40mm/tear_gas
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)

/datum/design/rubber_40mm
	name = "40mm 橡胶弹（低致命性）"
	desc = "今天就以高速把橡胶弹丸射进助理的脑袋里吧！"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/ammo_casing/a40mm/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)

/datum/design/suppressor
	name = "消音器"
	desc = "一种逆向工程得到的消音器，可安装在大多数带螺纹枪管的小型枪械上。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/silver =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/suppressor
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_PARTS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/gravitygun
	name = "单点引力操纵器"
	desc = "一种多模式装置，可发射单点蓝空间引力束，造成局部引力扭曲。需要引力异常核心才能运作。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 4, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 4, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 6, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/diamond =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/gun/energy/gravity_gun
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/largecrossbow
	name = "能量弩零件套件（低致命性/违禁品）"
	desc = "一套逆向工程原型动能加速器、将其改造成能量弩的套件，深受辛迪加渗透小队和鲤鱼猎人的青睐。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/weaponcrafting/gunkit/ebow
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/cleric_mace
	name = "教士钉锤"
	desc = "一把适合教士使用的钉锤。对付板甲很好用，但过于笨重，别的事就难办了。"
	build_type = AUTOLATHE
	materials = list(/datum/material_slot/weapon_head = SHEET_MATERIAL_AMOUNT * 4.5, /datum/material_slot/handle = SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/melee/cleric_mace
	category = list(RND_CATEGORY_IMPORTED)

/datum/design/liberator_gun
	name = "解放者"
	desc = "一把便宜得离谱的 3D 打印枪。只能装一发子弹，还以偶尔把使用者炸死而臭名昭著。"
	build_type = AUTOLATHE
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/gun/ballistic/automatic/pistol/doohickey
	category = list(RND_CATEGORY_IMPORTED)

/datum/design/stun_boomerang
	name = "OZtek 回旋镖"
	desc = "利用逆流引力动力学，在飞行途中将自身的引力翻转向投掷者。也能像电击棍一样使用。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5, /datum/material/gold =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/melee/baton/security/boomerang
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/photon_cannon
	name = "光子炮零件套件（非致命）"
	desc = "一套逆向工程光子炮的套件。光子炮能生成一颗转瞬即逝的微型太阳，严格来说确实照亮了房间，实际上却把里面所有人都晃瞎了。需要磁通异常核心才能完成。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcrafting/gunkit/photon
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
