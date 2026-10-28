
/datum/supply_pack/imports/hoshi
	name = "星辰模块化卡宾枪箱"
	desc = "本箱内含一把授权生产的星辰模块化卡宾枪，它是地球军械库最新添置的装备之一。"
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/gun/energy/modular_laser_rifle/carbine,
	)
	access_view = ACCESS_WEAPONS

/datum/supply_pack/imports/jezail
	name = "古董杰撒伊步枪单笔订单"
	desc = "本箱内含一把咚克复刻枪械系列中的步枪，全部采用复刻者选定的 .310 口径。由咚克与萨赫诺联手，为眼光独到的古董收藏家打造。"
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/gun/ballistic/rifle/boltaction/donkrifle/empty)
	access_view = ACCESS_WEAPONS
	crate_type = /obj/structure/closet/crate/secure/plasma
	crate_name = "古董步枪箱"

/datum/supply_pack/imports/hunter_rifle
	name = "古董猎枪单笔订单"
	desc = "本箱内含一把咚克复刻枪械系列中的步枪，全部采用复刻者选定的 .310 口径。由咚克与萨赫诺联手，为眼光独到的古董收藏家打造。这一把看起来有点……不对劲。"
	cost = CARGO_CRATE_VALUE * 14
	contains = list(/obj/item/gun/ballistic/rifle/boltaction/lionhunterlarp)
	access_view = ACCESS_WEAPONS
	crate_type = /obj/structure/closet/crate/secure/plasma
	crate_name = "古董步枪箱"

/datum/supply_pack/imports/prime_rifle
	name = "现代化栓动步枪单笔订单"
	desc = "本箱内含一把咚克复刻枪械系列中的步枪，全部采用复刻者选定的 .310 口径。由咚克与萨赫诺联手，为眼光独到的古董收藏家打造。"
	cost = CARGO_CRATE_VALUE * 17
	contains = list(/obj/item/gun/ballistic/rifle/boltaction/prime)
	access_view = ACCESS_WEAPONS
	crate_type = /obj/structure/closet/crate/secure/plasma
	crate_name = "古董步枪箱"

/datum/supply_pack/imports/bolt_action
	name = "栓动步枪单笔订单"
	desc = "本箱内含一把咚克复刻枪械系列中的步枪，全部采用复刻者选定的 .310 口径。由咚克与萨赫诺联手，为眼光独到的古董收藏家打造。"
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/gun/ballistic/rifle/boltaction)
	access_view = ACCESS_WEAPONS
	crate_type = /obj/structure/closet/crate/secure/plasma
	crate_name = "古董步枪箱"
