/obj/structure/closet/secure_closet/interdynefob/mining_locker
	icon_door = "mining"
	icon_state = "mining"
	name = "采矿装备储物柜"

/obj/item/clothing/accessory/armband/cargo/syndicate
	name = "采矿军官臂章"
	desc = "一条臂章，由前进基地的特工佩戴，以显示其所属部门。"

/obj/structure/closet/secure_closet/interdynefob/mining_locker/PopulateContents()
	..()

	new /obj/item/storage/bag/ore(src)
	new /obj/item/mining_scanner(src)
	new /obj/item/storage/belt/mining/alt(src)
	new /obj/item/clothing/under/syndicate/skyrat/overalls(src)
	new /obj/item/storage/backpack/satchel/explorer(src)
	new /obj/item/storage/backpack/explorer(src)
	new /obj/item/storage/backpack/messenger/explorer(src)
	new /obj/item/clothing/accessory/armband/cargo/syndicate(src)

/obj/structure/closet/secure_closet/interdynefob/mining_locker/populate_contents_immediate()
	. = ..()

	new /obj/item/gun/energy/recharge/kinetic_accelerator(src)
