/obj/item/ammo_casing/strilka310/phasic
	can_be_printed = FALSE

/obj/item/ammo_casing/stingballer
	name = "蜂刺弹丸"
	desc = "一颗小型金属滚珠。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "stingball"
	caliber = CALIBER_STINGBALL
	projectile_type = /obj/projectile/bullet/pellet/stingball

/obj/item/ammo_casing/stingballer/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)
