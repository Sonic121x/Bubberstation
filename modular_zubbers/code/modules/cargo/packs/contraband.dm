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

/datum/supply_pack/imports/antimatcrate
	name = "破阵反器材步枪箱"
	desc = "有个棘手的目标非死不可？那把离子枪搞不定开着机甲的坏蛋？买这个，就能拿到一把破阵步枪，附两个备用弹匣。"
	cost = 7500
	contains = list(
		/obj/item/gun/ballistic/automatic/wylom,
		/obj/item/ammo_box/magazine/wylom,
		/obj/item/ammo_box/magazine/wylom,
	)
	crate_name = "反器材步枪箱"
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/imports/riflecrate
	name = "骑枪战斗步枪箱"
	desc = "嫌标准型萨赫诺不够可靠、火力不够猛？别往别处看了，就是这帮狠家伙。它们采用更现代的半自动结构，肯定能让任何招惹你的人后悔。别在意那点手续费……"
	cost = 2500
	contains = list(
		/obj/item/gun/ballistic/automatic/lanca,
		/obj/item/ammo_box/magazine/lanca,
		/obj/item/ammo_box/magazine/lanca,
	)
	crate_name = "战斗步枪箱"
	order_flags = ORDER_CONTRABAND
