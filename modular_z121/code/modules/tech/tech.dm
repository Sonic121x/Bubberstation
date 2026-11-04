/datum/techweb_node/ballistic
	display_name = "实弹武器"
	description = "对旧时代的武器开展逆向研究，为实弹武器爱好者献上一份礼物。"
	prerequisite_nodes = list(/datum/techweb_node/explosives)
	unlocked_designs = list(
	/datum/design/steyr,
	/datum/design/nikonov,
	/datum/design/ap5,
	/datum/design/ap5glock,
	/datum/design/steyrmag,
	/datum/design/nikonovmag,
	/datum/design/ap5mag,
	/datum/design/ap5glockmag,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 700)
	discount_experiments = list(/datum/experiment/ordnance/explosive/highyieldbomb = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/nuclear
	display_name = "核能武器"
	description = "我已成为死神。"
	prerequisite_nodes = list(/datum/techweb_node/explosives)
	unlocked_designs = list(
	/datum/design/boltacr,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 150)
	discount_experiments = list(/datum/experiment/ordnance/explosive/highyieldbomb = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/obj/item/weaponcrafting/gunkit/nikonov
	name = "AN-94原型突击步枪零件套件（致命）"
	desc = "用于组装高科技AN-94原型突击步枪的套件。"

/obj/item/weaponcrafting/gunkit/steyr
	name = "ACR原型步枪零件套件（致命）"
	desc = "用于组装发射镖弹的高科技ACR原型突击步枪的套件。"

/obj/item/weaponcrafting/gunkit/boltacr
	name = "Bolt-ACR核聚变步枪零件套件（致命）"
	desc = "用于组装高科技Bolt-ACR核聚变反应堆步枪的套件。"

/obj/item/weaponcrafting/gunkit/hksmg
	name = "新锐AP-5冲锋枪零件套件（致命）"
	desc = "用于组装高科技新锐AP-5冲锋枪的套件。"

/obj/item/weaponcrafting/gunkit/glock
	name = "格洛克18手枪零件套件（致命）"
	desc = "用于组装格洛克18手枪的套件。"

/datum/design/steyr
	name = "ACR原型步枪零件套件（致命）"
	desc = "用于组装发射镖弹的高科技ACR原型突击步枪的套件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcrafting/gunkit/steyr
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/nikonov
	name = "AN-94原型步枪零件套件（致命）"
	desc = "用于组装高科技AN-94原型突击步枪的套件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcrafting/gunkit/nikonov
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/boltacr
	name = "Bolt-ACR核聚变步枪零件套件（致命）"
	desc = "用于组装高科技Bolt-ACR核聚变反应堆步枪的套件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/weaponcrafting/gunkit/boltacr
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/ap5
	name = "新锐AP-5冲锋枪零件套件（致命）"
	desc = "用于组装高科技新锐AP-5冲锋枪的套件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcrafting/gunkit/hksmg
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/ap5glock
	name = "格洛克18手枪零件套件（致命）"
	desc = "用于组装格洛克18手枪的套件。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/weaponcrafting/gunkit/glock
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/steyrmag
	name = "24发弹匣（5.56x45mm环形底火SCF镖弹）（高致命性）"
	desc = "装填5.56x45mm环形底火SCF镖弹的弹匣，适用于ACR原型镖弹突击步枪。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/ammo_box/magazine/makeshift/steyr
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/nikonovmag
	name = "30发弹匣（5.45x39mm）（高致命性）"
	desc = "装填5.45x39mm弹药的弹匣，适用于AN-94突击步枪。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/ammo_box/magazine/makeshift/nikonov
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/ap5mag
	name = "40发弹鼓（5.7x28mm）（高致命性）"
	desc = "装填5.7x28mm弹药的弹鼓，适用于AP-5冲锋枪。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/ammo_box/magazine/makeshift/hksmg
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/ap5glockmag
	name = "17发弹匣（9mm）（高致命性）"
	desc = "装填9mm弹药的弹匣，适用于格洛克18手枪。"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/ammo_box/magazine/makeshift/glock
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
