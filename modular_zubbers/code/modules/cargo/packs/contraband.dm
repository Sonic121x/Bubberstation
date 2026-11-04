/datum/supply_pack/misc/americacrate
	name = "自由箱"
	desc = "自由。自由。自由。自由可不是白来的。买我们的旗，向旗祈祷，膜拜旗。打扮成国父的样子，跪倒在那面创造了一切的旗帜的祭坛前。枪械另售。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/sign/flag/usa,
		/obj/item/sign/flag/usa,
		/obj/item/food/burger/superbite,
		/obj/item/bedsheet/patriot,
		/obj/item/bedsheet/patriot/double,
		/obj/item/food/burger/cheese,
		/obj/item/food/burger/superbite,
		/obj/item/clothing/under/costume/griffin,
		/obj/item/clothing/head/costume/griffin,
	)
	crate_name = "爱国箱"
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/imports/lizardgoodscrate
	name = "蜥蜴商品箱"
	desc = "限量版蜥蜴商品箱！内含随机搭配的各种你最爱的蜥蜴相关物品，还有那件人人眼馋的“weh 手雷”。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/effect/spawner/random/lizard_crate = 8
	)
	crate_name = "蜥蜴商品箱"
	order_flags = ORDER_CONTRABAND

