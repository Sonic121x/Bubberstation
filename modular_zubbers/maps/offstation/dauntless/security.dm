/obj/structure/closet/secure_closet/dauntless/munitions_locker
	anchored = 1;
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_door = "riot"
	icon_state = "riot"
	name = "军械库弹药储物柜"

/obj/structure/closet/secure_closet/dauntless/munitions_locker/PopulateContents()
	..()

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/m9mm = 6,
		/obj/item/ammo_box/magazine/m9mm/fire = 2,
		/obj/item/ammo_box/advanced/s12gauge/buckshot = 1,
		/obj/item/ammo_box/advanced/s12gauge = 2,
		/obj/item/ammo_box/advanced/s12gauge/rubber = 2,
		/obj/item/ammo_box/magazine/sniper_rounds/soporific = 2,
	), src)
