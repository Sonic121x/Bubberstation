/datum/supply_pack/vending/sectech
	name = "维和装备补给箱"
	desc = "阿玛达因牌维和补给箱，装有装备售货机所需的补货物资。"
	crate_name = "维和装备补给箱"

/datum/supply_pack/vending/wardrobes/security
	name = "维和衣橱补给箱"
	desc = "这个箱子装有维和装备站、侦探衣橱和法律衣橱的补给。"

/datum/supply_pack/vending/wardrobes/command
	name = "指挥衣橱补给箱"
	desc = "这个箱子装有指挥装备站的补给。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/vending_refill/wardrobe/comm_wardrobe,
	)
	crate_name = "指挥衣橱补给箱"

