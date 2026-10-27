/datum/market_item/misc/voskhod_refit
	name = "旭日改装套件"
	desc = "一个免运费的多用途箱子，装着运输、收纳、医疗、安保等诸般零零碎碎的玩意，可用来把身上那套古旧的镀钢太空服改装成不那么古旧的模块化太空服。"
	item = /obj/item/crafting_conversion_kit/voskhod_refit
	price_min = CARGO_CRATE_VALUE * 4
	price_max = CARGO_CRATE_VALUE * 5.75
	stock_max = 3
	availability_prob = 25

/datum/market_item/misc/autodoc
	name = "CIN 自动医疗 MOD 模块"
	desc = "一件“合法”取得的自动医疗 MOD 模块，是从某批最新式 CIN 装备上拆下来的。这玩意会注射隐生物素来给你疗伤，但漏得一塌糊涂。"
	item = /obj/item/mod/module/auto_doc
	price_min = CARGO_CRATE_VALUE * 3
	price_max = CARGO_CRATE_VALUE * 4.5
	stock_max = 3
	availability_prob = 20
