/obj/item/ammo_box/magazine/m7mm
	name = "盒式弹匣（7mm）"
	desc = "一个相当大的 7mm 盒式弹匣，适用于 L6 SAW。"
	icon_state = "a7mm"
	ammo_band_icon = "+a7mmab"
	ammo_type = /obj/item/ammo_casing/m7mm
	caliber = CALIBER_A7MM
	max_ammo = 50

/obj/item/ammo_box/magazine/m7mm/hollow
	name = "盒式弹匣（7mm 空尖弹）"
	MAGAZINE_TYPE_HOLLOWPOINT
	ammo_type = /obj/item/ammo_casing/m7mm/hollow

/obj/item/ammo_box/magazine/m7mm/ap
	name = "盒式弹匣（7mm 穿甲弹）"
	MAGAZINE_TYPE_ARMORPIERCE
	ammo_type = /obj/item/ammo_casing/m7mm/ap

/obj/item/ammo_box/magazine/m7mm/incen
	name = "盒式弹匣（7mm 燃烧弹）"
	MAGAZINE_TYPE_INCENDIARY
	ammo_type = /obj/item/ammo_casing/m7mm/incen

/obj/item/ammo_box/magazine/m7mm/match
	name = "盒式弹匣（7mm 竞赛弹）"
	ammo_band_color = COLOR_AMMO_MATCH
	desc = parent_type::desc + "<br>装填竞赛级弹药，其设计让子弹以极其潇洒、但可能对使用者不太友好的方式在墙壁间跳弹。"
	ammo_type = /obj/item/ammo_casing/m7mm/match

/obj/item/ammo_box/magazine/m7mm/bouncy
	name = "盒式弹匣（7mm 橡胶弹）"
	ammo_band_color = COLOR_AMMO_MATCH // this doesn't seem attainable in game (probably a good thing) so i guess it can get away with a color reuse
	desc = parent_type::desc + "<br>装填致命橡胶弹，伤害较低，但会以极不负责、对使用者不友好的方式从任何东西上弹开。"
	ammo_type = /obj/item/ammo_casing/m7mm/bouncy

/obj/item/ammo_box/magazine/m7mm/bouncy/hicap
	name = "高容量盒式弹匣（7mm 橡胶弹）"
	desc = "一个容量大得令人不安的 7mm 盒式弹匣，适用于 L6 SAW。<br>\
	装填致命橡胶弹，伤害较低，但会以极不负责、对使用者不友好的方式从任何东西上弹开。"
	max_ammo = 150

/obj/item/ammo_box/magazine/m7mm/update_icon_state()
	. = ..()
	icon_state = "a7mm-[min(round(ammo_count(), 10), 50)]" //Min is used to prevent high capacity magazines from attempting to get sprites with larger capacities
