//The broken fluff model
/obj/item/broken_missile/security
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	icon_state = "rocket_broken"

//The ammo itself
/obj/item/ammo_casing/security_missile
	name = "\improper “VARS”高爆导弹"
	desc = "一枚 69mm 高爆导弹，内置雷达技术。朝人发射后就忘了吧，因为如果你不小心用这玩意打中了一个闲逛的助手，最好还是忘掉发生了什么。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	icon_state = "rocket"
	base_icon_state = "rocket"

	caliber = CALIBER_69MM
	projectile_type = /obj/projectile/bullet/security_missile
	newtonian_force = 2

	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_casing/security_missile/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/security_missile/update_icon_state()
	. = ..()
	icon_state = base_icon_state

//Storage for the ammo. Not an ammo box subtype because we don't want security easy getting restocks.
/obj/item/storage/box/security_missiles
	name = "\improper “VARS”高爆导弹箱"
	desc = "一个光滑坚固的箱子，用于存放导弹。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	icon_state = "rocket_box"
	illustration = null

/obj/item/storage/box/security_missiles/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/security_missile(src)
