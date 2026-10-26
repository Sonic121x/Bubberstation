// .310 magazine for the Lanca rifle

/obj/item/ammo_box/magazine/lanca
	name = "\improper 骑枪步枪弹匣"
	desc = "骑枪步枪使用的标准尺寸弹匣，可容纳五发子弹。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "lanca_mag"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/strilka310
	caliber = CALIBER_STRILKA310
	max_ammo = 5

/obj/item/ammo_box/magazine/lanca/spawns_empty
	start_empty = TRUE

// Magazine for the Miecz submachinegun

/obj/item/ammo_box/magazine/miecz
	name = "\improper 利剑冲锋枪弹匣"
	desc = "利剑冲锋枪使用的标准尺寸弹匣，可容纳十八发子弹。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "miecz_mag"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c27_54cesarzowa
	caliber = CALIBER_CESARZOWA
	max_ammo = 20

/obj/item/ammo_box/magazine/miecz/spawns_empty
	start_empty = TRUE

// Plasma thrower 'magazine'

/obj/item/ammo_box/magazine/recharge/plasma_battery
	name = "等离子能源包"
	desc = "为等离子投射器供能的可拆卸电池。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	base_icon_state = "plasma_battery"
	icon_state = "plasma_battery"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = list(/obj/item/ammo_casing/energy/laser/plasma_glob)
	caliber = CALIBER_LASER
	max_ammo = 15
	var/overcharged = FALSE

/obj/item/ammo_box/magazine/recharge/plasma_battery/update_icon_state() // FUCK YOU /OBJ/ITEM/AMMO_BOX/MAGAZINE/RECHARGE
	. = ..()
	icon_state = base_icon_state

// Shotgun revolver's cylinder

/obj/item/ammo_box/magazine/internal/cylinder/rev12ga
	name = "\improper 12号口径左轮弹巢"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 4

// AMR magazine

/obj/item/ammo_box/magazine/wylom
	name = "反器材步枪弹匣（.60利箭）"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "wylom_mag"
	base_icon_state = "wylom_mag"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/p60strela
	max_ammo = 3
	caliber = CALIBER_60STRELA
	w_class = WEIGHT_CLASS_NORMAL
