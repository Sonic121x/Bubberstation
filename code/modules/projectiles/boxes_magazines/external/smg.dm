/obj/item/ammo_box/magazine/wt550m9
	name = "\improper WT-550 弹匣（4.6x30mm）"
	desc = "一个顶装式 4.6x30mm 弹匣，专为 WT-550 自动步枪设计。"
	icon_state = "46x30mmt-20"
	base_icon_state = "46x30mmt"
	ammo_band_icon = "+46x30mmab"
	ammo_band_color = null
	ammo_type = /obj/item/ammo_casing/c46x30mm
	caliber = CALIBER_46X30MM
	max_ammo = 20
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/ammo_box/magazine/wt550m9/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 4)]"

/obj/item/ammo_box/magazine/wt550m9/wtap
	name = "\improper WT-550 弹匣（4.6x30mm 穿甲弹）"
	MAGAZINE_TYPE_ARMORPIERCE
	ammo_type = /obj/item/ammo_casing/c46x30mm/ap
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.6)

/obj/item/ammo_box/magazine/wt550m9/wtic
	name = "\improper WT-550 弹匣（4.6x30mm 燃烧弹）"
	MAGAZINE_TYPE_INCENDIARY
	ammo_type = /obj/item/ammo_casing/c46x30mm/inc
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/ammo_box/magazine/smartgun
	name = "阿比耶尔弹匣（.160 智能弹）"
	desc = "一个大容量 .160 智能弹匣，适用于阿比耶尔智能冲锋枪。"
	icon_state = "smartgun"
	base_icon_state = "smartgun"
	ammo_type = /obj/item/ammo_casing/c160smart
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE
	caliber = CALIBER_160SMART
	max_ammo = 50

/obj/item/ammo_box/magazine/uzim9mm
	name = "\improper 乌兹弹匣（9mm）"
	desc = "一个加长型 9mm 弹匣，适用于乌兹冲锋枪。"
	icon_state = "uzi9mm-32"
	base_icon_state = "uzi9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 32

/obj/item/ammo_box/magazine/uzim9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 4)]"

/obj/item/ammo_box/magazine/smgm9mm
	name = "\improper 冲锋枪弹匣（9mm）"
	desc = "一个造型利落的 9mm 弹匣，适用于纳米传讯军刀冲锋枪。"
	icon_state = "smg9mm"
	base_icon_state = "smg9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 21

/obj/item/ammo_box/magazine/smgm9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[LAZYLEN(stored_ammo) ? "full" : "empty"]"

/obj/item/ammo_box/magazine/smgm9mm/ap
	name = "冲锋枪弹匣（9mm 穿甲弹）"
	MAGAZINE_TYPE_ARMORPIERCE
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/magazine/smgm9mm/fire
	name = "冲锋枪弹匣（9mm 燃烧弹）"
	MAGAZINE_TYPE_INCENDIARY
	ammo_type = /obj/item/ammo_casing/c9mm/fire

/obj/item/ammo_box/magazine/smgm45
	name = "冲锋枪弹匣（.45）"
	desc = "一个加长型 .45 弹匣，适用于 C-20r 冲锋枪。"
	icon_state = "c20r45"
	base_icon_state = "c20r45"
	ammo_band_icon = "+c20rab"
	ammo_band_color = null
	ammo_type = /obj/item/ammo_casing/c45
	caliber = CALIBER_45
	max_ammo = 24

/obj/item/ammo_box/magazine/smgm45/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 2)]"

/obj/item/ammo_box/magazine/smgm45/ap
	name = "冲锋枪弹匣（.45 穿甲弹）"
	MAGAZINE_TYPE_ARMORPIERCE
	ammo_type = /obj/item/ammo_casing/c45/ap

/obj/item/ammo_box/magazine/smgm45/hp
	name = "冲锋枪弹匣（.45 空尖弹）"
	MAGAZINE_TYPE_HOLLOWPOINT
	ammo_type = /obj/item/ammo_casing/c45/hp

/obj/item/ammo_box/magazine/smgm45/incen
	name = "冲锋枪弹匣（.45 燃烧弹）"
	MAGAZINE_TYPE_INCENDIARY
	ammo_type = /obj/item/ammo_casing/c45/inc

/obj/item/ammo_box/magazine/tommygunm45
	name = "弹鼓（.45）"
	icon_state = "drum45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = CALIBER_45
	max_ammo = 50
