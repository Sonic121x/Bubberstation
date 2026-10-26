/obj/structure/closet/secure_closet/interdynefob/prisoner_locker
	name = "囚犯物品储物柜"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/interdynefob/brig_officer_locker
	icon_door = "sec"
	icon_state = "sec"
	name = "禁闭室军官装备储物柜"
	req_access = list("syndicate_leader")

/obj/item/clothing/suit/toggle/jacket/sec/old/syndicate
	name = "禁闭室军官夹克"

/obj/item/clothing/accessory/armband/syndicate
	name = "禁闭室军官臂章"
	desc ="一条臂章，由前进基地的特工佩戴，以显示其所属部门。"

/obj/item/storage/bag/garment/brig_officer
	name = "禁闭室军官的衣物袋"
	desc = "用于存放备用衣物和鞋子的袋子。这个是禁闭室军官的。"

/obj/item/storage/bag/garment/brig_officer/PopulateContents()
	new /obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate(src)
	new /obj/item/clothing/head/beret/sec/syndicate(src)
	new /obj/item/clothing/accessory/armband(src)
	new /obj/item/clothing/mask/gas/syndicate(src)
	new /obj/item/clothing/suit/toggle/jacket/sec/old/syndicate(src)
	new /obj/item/clothing/mask/gas/sechailer/syndicate(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/redsec(src)

/obj/structure/closet/secure_closet/interdynefob/brig_officer_locker/PopulateContents()
	..()

	new /obj/item/storage/belt/security/full(src)
	new /obj/item/storage/bag/garment/brig_officer(src)
	new /obj/item/radio/headset/syndicateciv/staff(src)

/obj/structure/closet/secure_closet/interdynefob/brig_officer_locker/populate_contents_immediate()
	. = ..()

	new /obj/item/gun/energy/e_gun(src)

/obj/structure/closet/secure_closet/interdynefob/armory_gear_locker
	anchored = 1
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_door = "riot"
	icon_state = "riot"
	name = "军械库装备储物柜"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/interdynefob/armory_gear_locker/PopulateContents()
	..()

	new /obj/item/storage/belt/holster/nukie(src)
	new /obj/item/storage/belt/holster/nukie(src)
	new /obj/item/storage/belt/holster/nukie(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/clothing/head/helmet(src)
	new /obj/item/clothing/head/helmet(src)
	new /obj/item/clothing/head/helmet(src)

/obj/structure/closet/secure_closet/interdynefob/munitions_locker
	anchored = 1;
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_door = "riot"
	icon_state = "riot"
	name = "军械库弹药储物柜"

/obj/structure/closet/secure_closet/interdynefob/munitions_locker/PopulateContents()
	..()

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/c35sol_pistol = 6,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = 2,
		/obj/item/ammo_box/c35sol = 2,
		/obj/item/ammo_box/magazine/wt550m9 = 2,
		/obj/item/ammo_box/magazine/wt550m9/wtap = 2,
		/obj/item/ammo_box/advanced/s12gauge = 2,
		/obj/item/ammo_box/advanced/s12gauge/rubber = 2,
	),src)
