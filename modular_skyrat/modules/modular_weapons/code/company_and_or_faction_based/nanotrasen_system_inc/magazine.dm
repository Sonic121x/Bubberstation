//9mm Magazines
/obj/item/ammo_box/magazine/m9mm
	name = "手枪弹匣（9×25毫米）"
	multiple_sprites = AMMO_BOX_PER_BULLET
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/magazine.dmi'

/obj/item/ammo_box/magazine/m9mm
	custom_premium_price = 50

//Extended 9mm
/obj/item/ammo_box/magazine/m9mm/stendo
	name = "手枪弹匣（9×25毫米）"
	ammo_type = /obj/item/ammo_casing/c9mm
	base_icon_state = "g18"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	max_ammo = 33

/obj/item/ammo_box/magazine/m9mm/stendo/fire
	name = "手枪弹匣（9×25毫米燃烧弹）"
	ammo_type = /obj/item/ammo_casing/c9mm/fire
	base_icon_state = "g18_r"

/obj/item/ammo_box/magazine/m9mm/stendo/hp
	name = "手枪弹匣（9×25毫米空尖弹）"
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	base_icon_state = "g18_hp"

/obj/item/ammo_box/magazine/m9mm/stendo/ap
	name = "手枪弹匣（9×25毫米穿甲弹）"
	ammo_type = /obj/item/ammo_casing/c9mm/ap
	base_icon_state = "g18_ihdf"

//Shotgun Internal Tube

/obj/item/ammo_box/magazine/internal/shot/extended
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 10

/obj/item/ammo_box/magazine/internal/shot/somewhatextended
	name = "战斗霰弹枪内置弹仓"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	max_ammo = 8

/obj/item/ammo_box/magazine/internal/shot/less_lethal
	name = "less-lethal shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	max_ammo = 7

/obj/item/ammo_box/magazine/internal/shot/less_lethal/is_compatible_round(obj/item/ammo_casing/new_round)
	if(istype(new_round, /obj/item/ammo_casing/shotgun/beanbag) || istype(new_round, /obj/item/ammo_casing/shotgun/incapacitate) || istype(new_round, /obj/item/ammo_casing/shotgun/rubbershot))
		return TRUE
	return FALSE

//10mm Stuff
