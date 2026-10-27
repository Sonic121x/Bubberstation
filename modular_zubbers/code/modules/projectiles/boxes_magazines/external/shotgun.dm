/obj/item/ammo_box/magazine/beandog
	name = "霰弹枪弹鼓（12g 豆袋弹）"
	desc = "定制霰弹弹鼓，仅适用于“豆犬”霰弹枪。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "m12gbb"
	base_icon_state = "m12gbb"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	caliber = CALIBER_SHOTGUN
	max_ammo = 8
	casing_phrasing = "霰弹"

/obj/item/ammo_box/magazine/beandog/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[CEILING(ammo_count(FALSE)/8, 1)*8]"
