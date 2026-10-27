/datum/market_item/consumable
	category = "Consumables"
	abstract_path = /datum/market_item/consumable

/datum/market_item/consumable/clown_tears
	name = "一瓶小丑之泪"
	desc = "由哭泣博金斯的悲剧厨房直供，保证新鲜。"
	item = /obj/item/reagent_containers/cup/bottle/clownstears
	stock = 1

	price_min = CARGO_CRATE_VALUE * 2.6
	price_max = CARGO_CRATE_VALUE * 3
	availability_prob = 10

/datum/market_item/consumable/donk_pocket_box
	name = "一盒咚克口袋饼"
	desc = "一个包装严实的盒子，里面装着每位太空旅人最爱的零食。"
	item = /obj/item/storage/box/donkpockets

	stock_min = 2
	stock_max = 5
	price_min = CARGO_CRATE_VALUE * 1.375
	price_max = CARGO_CRATE_VALUE * 1.825
	availability_prob = 80

/datum/market_item/consumable/donk_pocket_box/spawn_item(loc)
	var/static/list/choices
	if(isnull(choices))
		choices = list()
		for(var/boxtype in typesof(/obj/item/storage/box/donkpockets))
			choices[boxtype] = 3
		choices[/obj/item/storage/box/donkpockets/donkpocketgondola] = 1
	item = pick_weight(choices)
	return ..()

/datum/market_item/consumable/suspicious_pills
	name = "一瓶可疑药片"
	desc = "随机混装的豪华药物鸡尾酒，保证让你笑逐颜开！"
	item = /obj/item/storage/pill_bottle

	stock_min = 2
	stock_max = 3
	price_min = CARGO_CRATE_VALUE * 0.625
	price_max = CARGO_CRATE_VALUE * 1.25
	availability_prob = 50

/datum/market_item/consumable/suspicious_pills/spawn_item(loc)
	item = pick(list(/obj/item/storage/pill_bottle/zoom,
		/obj/item/storage/pill_bottle/happy,
		/obj/item/storage/pill_bottle/lsd,
		/obj/item/storage/pill_bottle/aranesp,
		/obj/item/storage/pill_bottle/stimulant,
		/obj/item/storage/pill_bottle/maintenance_pill,
	))
	return ..()

/datum/market_item/consumable/floor_pill
	name = "奇怪的药片"
	desc = "维修隧道的俄罗斯轮盘赌。"
	item = /obj/item/reagent_containers/applicator/pill/maintenance

	stock_min = 5
	stock_max = 35
	price_min = CARGO_CRATE_VALUE * 0.05
	price_max = CARGO_CRATE_VALUE * 0.3
	availability_prob = 50

/datum/market_item/consumable/pumpup
	name = "维修区振奋剂"
	desc = "用这个便携装置抵抗任何警棍眩晕！"
	item = /obj/item/reagent_containers/hypospray/medipen/pumpup

	stock_max = 3
	price_min = CARGO_CRATE_VALUE * 0.25
	price_max = CARGO_CRATE_VALUE * 0.75
	availability_prob = 90

/datum/market_item/consumable/methshipment
	name = "甲基苯丙胺批发货"
	desc = "毒贩级进货量！可别吸自己的货。或者吸吧，反正你已经买了。"
	item = /obj/item/storage/box/methdealer

	stock_min = 1
	stock_max = 3
	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE * 1.5
	availability_prob = 25

/datum/market_item/consumable/opiumshipment
	name = "鸦片批发货"
	desc = "你的同事压力大？我们有成批的恶习供你选择。"
	item = /obj/item/storage/box/opiumdealer

	stock_min = 1
	stock_max = 3
	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE * 1.2
	availability_prob = 35

/datum/market_item/consumable/kronkshipment
	name = "克隆卡因批发货"
	desc = "警告！安保可能真的会在意这一批！"
	item = /obj/item/storage/box/kronkdealer

	stock_min = 1
	stock_max = 3
	price_min = CARGO_CRATE_VALUE * 1
	price_max = CARGO_CRATE_VALUE * 2
	availability_prob = 15

/datum/market_item/consumable/methaphetamine
	name = "冰毒"
	desc = "一大块石头，专供你只想嗨一下的时候。"
	item = /obj/item/food/drug/meth_crystal

	stock_min = 1
	stock_max = 5
	price_min = CARGO_CRATE_VALUE * 0.4
	price_max = CARGO_CRATE_VALUE * 0.5
	availability_prob = 35

/datum/market_item/consumable/heroin
	name = "海洛因"
	desc = "追逐那条龙。"
	item = /obj/item/food/drug/opium

	stock_min = 1
	stock_max = 5
	price_min = CARGO_CRATE_VALUE * 0.35
	price_max = CARGO_CRATE_VALUE * 0.5
	availability_prob = 45

/datum/market_item/consumable/kronkaine
	name = "克隆卡因"
	desc = "一颗 8⁸ 球，这东西几乎从不上架！"
	item = /obj/item/food/drug/moon_rock

	stock_min = 1
	stock_max = 2
	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE * 1
	availability_prob = 15
