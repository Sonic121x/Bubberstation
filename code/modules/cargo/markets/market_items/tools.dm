/datum/market_item/tool
	category = "Tools"
	abstract_path = /datum/market_item/tool

/datum/market_item/tool/blackmarket_telepad
	name = "黑市 LTSRBT"
	desc = "需要一种更快更好的方式，把非法货物运进运出 \
		空间站吗？别担心，远近程蓝空间收发器随时效劳。 \
		内含一块 LTSRBT 电路板。不含蓝空间晶体与安塞波。"
	item = /obj/item/circuitboard/machine/ltsrbt
	stock_min = 2
	stock_max = 4
	price_min = CARGO_CRATE_VALUE * 2.5
	price_max = CARGO_CRATE_VALUE * 3.25
	availability_prob = 100

/datum/market_item/tool/caravan_wrench
	name = "实验型扳手"
	desc = "你一直想要的那种超快又趁手的扳手！"
	item = /obj/item/wrench/caravan
	stock = 1

	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 4
	availability_prob = 20

/datum/market_item/tool/caravan_wirecutters
	name = "实验型剪线钳"
	desc = "你一直想要的那种超快又趁手的剪线钳！"
	item = /obj/item/wirecutters/caravan
	stock = 1

	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 4
	availability_prob = 20

/datum/market_item/tool/caravan_screwdriver
	name = "实验型螺丝刀"
	desc = "你一直想要的那种超快又趁手的螺丝刀！"
	item = /obj/item/screwdriver/caravan
	stock = 1

	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 4
	availability_prob = 20

/datum/market_item/tool/caravan_crowbar
	name = "实验型撬棍"
	desc = "你一直想要的那种超快又趁手的撬棍！"
	item = /obj/item/crowbar/red/caravan
	stock = 1

	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 4
	availability_prob = 20

/datum/market_item/tool/binoculars
	name = "双筒望远镜"
	desc = "用这件趁手的工具，让你的视野提升 150%！"
	item = /obj/item/binoculars
	stock = 1

	price_min = CARGO_CRATE_VALUE * 1.75
	price_max = CARGO_CRATE_VALUE * 4
	availability_prob = 30

/datum/market_item/tool/riot_shield
	name = "防暴盾牌"
	desc = "保护你自己，免受本地警察局突如其来的暴乱波及！"
	item = /obj/item/shield/riot

	price_min = CARGO_CRATE_VALUE * 2.25
	price_max = CARGO_CRATE_VALUE * 3.25
	stock_max = 2
	availability_prob = 50

/datum/market_item/tool/thermite_bottle
	name = "铝热剂瓶"
	desc = "50u 铝热剂，助你快速开辟通道或顺利脱身！"
	item = /obj/item/reagent_containers/cup/bottle/thermite

	price_min = CARGO_CRATE_VALUE * 0.75
	price_max = CARGO_CRATE_VALUE
	stock_max = 3
	availability_prob = 30

/datum/market_item/tool/program_disk
	name = "盗版数据盘"
	desc = "一张内含独家限量模块化程序的数据盘。从法律上讲，我们不允许告诉你我们是怎么弄到它们的。"
	item = /obj/item/disk/computer/black_market
	price_min = CARGO_CRATE_VALUE * 0.75
	price_max = CARGO_CRATE_VALUE * 2
	stock_max = 3
	availability_prob = 40
