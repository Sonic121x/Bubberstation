/datum/supply_pack/security/armory/rocket_launcher
	name = "安保导弹发射器板条箱"
	desc = "内含一套供安保使用的“VARS”可变主动雷达导弹系统。"
	cost = CARGO_CRATE_VALUE * 50 //10000
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/ballistic/rocketlauncher/security = 1)
	crate_name = "安保导弹发射器板条箱"
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE //Shits and giggles.

/datum/supply_pack/security/armory/rocket_launcher_ammo
	name = "安保导弹发射器弹药板条箱"
	desc = "内含一箱 7 枚“VARS”高爆导弹，适用于“VARS”可变主动雷达导弹系统。"
	cost = CARGO_CRATE_VALUE * 7 //1400
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/security_missiles = 1)
	crate_name = "安保导弹发射器弹药板条箱"
