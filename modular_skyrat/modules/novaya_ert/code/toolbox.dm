/obj/item/storage/toolbox/ammobox
	desc = "里面装着几个弹夹。"
	icon_state = "ammobox"
	inhand_icon_state = "ammobox"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	has_latches = FALSE
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'

/obj/item/storage/toolbox/ammobox/full
	var/ammo_type = null ///Type of mags/casings/clips we spawn in.
	var/amount = 0 ///Amount of mags/casings/clips we spawn in.

/obj/item/storage/toolbox/ammobox/full/PopulateContents()
	if(!isnull(ammo_type))
		for(var/i in 1 to amount)
			new ammo_type(src)

/obj/item/storage/toolbox/ammobox/full/mosin
	name = "弹药箱（萨赫诺）"
	ammo_type = /obj/item/ammo_box/speedloader/strilka310
	amount = 7

/obj/item/storage/toolbox/ammobox/full/krinkov
	name = "弹药箱（克林科夫）"
	desc = "里面装着几个弹匣。"
	ammo_type = /obj/item/ammo_box/magazine/lanca
	amount = 7

/obj/item/storage/toolbox/ammobox/full/nri_smg
	name = "弹药箱（QLP/04）"
	ammo_type = /obj/item/ammo_box/magazine/miecz
	amount = 7

/obj/item/storage/toolbox/ammobox/full/l6_saw
	name = "弹药箱（L6班用机枪）"
	desc = "里面装着几个弹匣。"
	ammo_type = /obj/item/ammo_box/magazine/m7mm
	amount = 7

/obj/item/storage/toolbox/ammobox/full/aps
	name = "弹药箱（绍博-伊万内克/APS）"
	desc = "里面装着几个弹匣。"
	ammo_type = /obj/item/ammo_box/magazine/m9mm_aps
	amount = 7
