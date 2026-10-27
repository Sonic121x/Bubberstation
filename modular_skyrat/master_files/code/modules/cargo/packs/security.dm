//OVERRIDES

/datum/supply_pack/security/ammo

/datum/supply_pack/security/armory/ballistic
	name = "维和者战斗霰弹枪板条箱"
	contains = list(/obj/item/gun/ballistic/shotgun/automatic/combat = 3,
					/obj/item/storage/pouch/ammo = 3,
					/obj/item/storage/belt/bandolier = 3)

//The price seems silly but do understand that ballistic should  be as restricted as possible
//We should prioritise the availability and viability of energy weapon first and foremost


/datum/supply_pack/goody/energy_single
	name = "能量枪单件装"
	desc = "内含一把能量枪，既能发射非致命光束，也能发射致命光束。"
	cost = PAYCHECK_COMMAND * 6
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/e_gun)

/datum/supply_pack/goody/laser_single
	name = "激光枪单件装"
	desc = "内含一把激光枪，纳米传讯各地安保部门赖以吃饭的致命主力装备。"
	cost = PAYCHECK_COMMAND * 3
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/laser)

/datum/supply_pack/security/armory/ionrifle
	name = "离子卡宾枪板条箱"
	cost = CARGO_CRATE_VALUE * 18 //Same as the energy gun crate
	desc = "内含两把离子卡宾枪，专为对付上蹿下跳的太空混混、机甲和不知天高地厚的硅基生命而生。"
	contains = list(/obj/item/gun/energy/ionrifle/carbine = 2)
	crate_name = "离子卡宾枪板条箱"
