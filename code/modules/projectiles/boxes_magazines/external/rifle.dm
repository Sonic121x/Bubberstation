/obj/item/ammo_box/magazine/m223
	name = "顶装弹匣（.223）"
	desc = "一个顶装式 .223 弹匣，适用于 M-90gl 卡宾枪。"
	icon_state = ".223"
	ammo_band_icon = "+.223ab"
	ammo_type = /obj/item/ammo_casing/a223
	caliber = CALIBER_A223
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m223/phasic
	name = "顶装弹匣（.223 相位弹）"
	desc = parent_type::desc + "<br>装填相位弹，可完全无视护甲并穿透掩体，但无法穿透目标本身。"
	ammo_type = /obj/item/ammo_casing/a223/phasic

// .38 (Battle Rifle) //

/obj/item/ammo_box/magazine/m38
	name = "战斗步枪弹匣（.38）"
	desc = "一个用于 BR-38 战斗步枪的 .38 弹匣。"
	icon_state = "38mag"
	base_icon_state = "38mag"
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = /obj/item/ammo_casing/c38
	caliber = CALIBER_38
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2)
	max_ammo = 15
	ammo_band_icon = "+38mag_ammo_band"
	ammo_band_color = null

/obj/item/ammo_box/magazine/m38/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][ammo_count() ? "-ammo" : ""]"

/obj/item/ammo_box/magazine/m38/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m38/trac
	name = "战斗步枪弹匣（.38 追踪弹）"
	desc = parent_type::desc + " 追踪弹会在目标体内植入一枚追踪植入体，且完全非致命。"
	ammo_type = /obj/item/ammo_casing/c38/trac
	ammo_band_color = COLOR_AMMO_TRACK
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/ammo_box/magazine/m38/match
	name = "战斗步枪弹匣（.38 竞赛弹）"
	desc = parent_type::desc + " 这些弹药在极严格的公差内制造，很容易用它炫出花式射击。"
	ammo_type = /obj/item/ammo_casing/c38/match
	ammo_band_color = COLOR_AMMO_MATCH

/obj/item/ammo_box/magazine/m38/match/bouncy
	name = "战斗步枪弹匣（.38 橡胶弹）"
	desc = parent_type::desc + " 这些弹药弹性极强，且大体上非致命，非常适合用来炫技。"
	ammo_type = /obj/item/ammo_casing/c38/match/bouncy
	ammo_band_color = COLOR_AMMO_RUBBER
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/ammo_box/magazine/m38/true
	name = "战斗步枪弹匣（.38 必中弹）"
	desc = parent_type::desc + " 子弹会以惊人的精度弹向新的目标，并能击穿披甲目标。"
	ammo_type = /obj/item/ammo_casing/c38/match/true
	ammo_band_color = COLOR_AMMO_TRUESTRIKE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 0.75)

/obj/item/ammo_box/magazine/m38/dumdum
	name = "战斗步枪弹匣（.38 达姆弹）"
	desc = parent_type::desc + " 这些弹药命中后会扩张，足以撕碎目标并造成大量出血。对付护甲和远距离目标则非常乏力。"
	ammo_type = /obj/item/ammo_casing/c38/dumdum
	ammo_band_color = COLOR_AMMO_DUMDUM

/obj/item/ammo_box/magazine/m38/hotshot
	name = "战斗步枪弹匣（.38 炽热弹）"
	desc = parent_type::desc + " 炽热弹内装有燃烧装药。"
	ammo_type = /obj/item/ammo_casing/c38/hotshot
	ammo_band_color = COLOR_AMMO_HOTSHOT
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 0.75)

/obj/item/ammo_box/magazine/m38/iceblox
	name = "战斗步枪弹匣（.38 冰封弹）"
	desc = parent_type::desc + " 冰封弹内装有低温装药。"
	ammo_type = /obj/item/ammo_casing/c38/iceblox
	ammo_band_color = COLOR_AMMO_ICEBLOX
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 0.75)

/obj/item/ammo_box/magazine/m38/flare
	name = "战斗步枪弹匣（.38 照明弹）"
	desc = parent_type::desc + " 照明弹弹壳会朝目标发射一束集中的粒子束，把目标照亮给所有人看。"
	ammo_type = /obj/item/ammo_casing/c38/flare
	ammo_band_color = COLOR_AMMO_HELLFIRE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.75)
