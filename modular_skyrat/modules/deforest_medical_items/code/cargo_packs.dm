/datum/supply_pack/medical/civil_defense
	name = "民防医疗包箱"
	crate_name = "民防医疗包箱"
	desc = "内含十套民防医疗包，即小包注射器，可在紧急情况下分发给公众。"
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 10 // 2000
	contains = list(
		/obj/item/storage/medkit/civil_defense/stocked = 10,
	)

/datum/supply_pack/medical/frontier_first_aid
	name = "边疆急救箱"
	crate_name = "边疆急救箱"
	desc = "内含边疆医疗包和战地外科医疗包各三套。"
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/storage/medkit/frontier/stocked = 3,
		/obj/item/storage/medkit/combat_surgeon/stocked = 3,
	)

/datum/supply_pack/medical/kit_technician
	name = "重型医疗包箱——技术员型"
	crate_name = "技术员医疗包箱"
	desc = "内含一套粉色医疗技术员医疗包。"
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 5.5
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked,
	)

/datum/supply_pack/medical/kit_surgical
	name = "重型医疗包箱——外科型"
	crate_name = "外科医疗包箱"
	desc = "内含一套灰色急救外科医疗包。"
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked,
	)

/datum/supply_pack/medical/kit_medical
	name = "重型医疗包箱——医疗型"
	crate_name = "医疗包箱"
	desc = "内含一套橙色挎包式医疗包。"
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked,
	)

/datum/supply_pack/medical/deforest_vendor_refill
	name = "德福雷斯特医疗售货机补货箱"
	crate_name = "\improper 德福雷斯特医疗售货机补货箱"
	desc = "内含一个用于德福雷斯特医疗售货机的补货罐。"
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/vending_refill/medical_deforest,
	)
