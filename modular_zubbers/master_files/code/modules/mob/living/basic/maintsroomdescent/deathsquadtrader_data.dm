/datum/trader_data/deathsquadtrader

	///The item that marks the shopkeeper will sit on
	shop_spot_type =  /obj/structure/chair/office/tactical
	///The sign that will greet the customers
	sign_type = /obj/structure/trader_sign
	///Sound used when item sold/bought
	sell_sound = 'sound/effects/cashregister.ogg'
	///The currency name
	currency_name = "信用点"
	///The initial products that the trader offers
	/// one crew paycheck is 50 credits
	initial_products = list(
		/obj/item/assembly/signaler/anomaly/bioscrambler = list(PAYCHECK_CREW * 80, 1),
		/obj/item/assembly/signaler/anomaly/bluespace = list(PAYCHECK_CREW * 80, 1),
		/obj/item/assembly/signaler/anomaly/dimensional = list(PAYCHECK_CREW * 80, 1),
		/obj/item/assembly/signaler/anomaly/ectoplasm = list(PAYCHECK_CREW * 80, 1),
		/obj/item/assembly/signaler/anomaly/flux = list(PAYCHECK_CREW * 80, 1),
		/obj/item/assembly/signaler/anomaly/grav= list(PAYCHECK_CREW * 80, 1),
		/obj/item/assembly/signaler/anomaly/hallucination = list(PAYCHECK_CREW * 80, 1),
		/obj/item/assembly/signaler/anomaly/pyro = list(PAYCHECK_CREW * 80, 1),
		/obj/item/assembly/signaler/anomaly/vortex = list(PAYCHECK_CREW * 80, 1),
		/obj/item/reagent_containers/hypospray/medipen/survival/luxury = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/reagent_containers/hypospray/medipen/stimulants = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/reagent_containers/hypospray/medipen/salacid = list(PAYCHECK_CREW * 2, INFINITY),
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = list(PAYCHECK_CREW * 2, INFINITY),
		/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline = list(PAYCHECK_CREW * 8, INFINITY),
		/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked = list(PAYCHECK_CREW * 40, INFINITY),
		/obj/item/storage/medkit = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/storage/medkit/ancient = list(PAYCHECK_CREW * 15, INFINITY),
		/obj/item/storage/medkit/robotic_repair/preemo/stocked = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/storage/medkit/frontier/stocked = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/storage/medkit/brute = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/storage/medkit/combat_surgeon/stocked = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/anomaly_neutralizer = list(PAYCHECK_CREW * 2, INFINITY),
		/obj/item/gun/ballistic/automatic/wt550 = list(PAYCHECK_CREW * 80, INFINITY),
		/obj/item/storage/toolbox/ammobox/wt550m9 = list(PAYCHECK_CREW * 5, INFINITY),
		/obj/item/storage/toolbox/ammobox/wt550m9ap = list(PAYCHECK_CREW * 10, INFINITY),
	)
	///The initial products that the trader buys
	initial_wanteds = list(
		/obj/item/raw_anomaly_core/bioscrambler = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/bluespace = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/dimensional = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/ectoplasm = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/flux = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/grav = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/hallucination = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/pyro = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/random = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/raw_anomaly_core/vortex = list(PAYCHECK_CREW * 20, INFINITY, ""),
	)
	///The speech data of the trader
	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"你拿给我看的那些东西我一样都不想要。等你搞到些原始异常核心再来找我。",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"我会在这儿的——我被困在这儿了。",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"谢了，把它们派上点用场。",
		),
		INTERESTED_PHRASE = list(
			"嘿，你搞到了一些原始异常核心。把那些没用的东西交给我，我给你些信用点，成交？",
		),
		BUY_PHRASE = list(
			"好好用我的东西！",
		),
		NO_CASH_PHRASE = list(
			"瞧，兄弟，这些异常核心的价格确实很高，但我得这样才能赚到钱。",
		),
		NO_STOCK_PHRASE = list(
			"别人来过，把我精炼好的异常核心全买走了——下个周期再来吧。",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"这个周期我不想再买那些异常核心了，已经卖给我的量够我精炼好一阵子了。",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"这枪就是垃圾，把那把咚克软玩具拿到别处去。我自己不怎么用异常核心，但——价格是我定的。",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"你们是想让市场泛滥、搞出他妈的通货膨胀吗？我现在不能再买那个了。",
		),
		TRADER_LORE_PHRASE = list(
			"嘿，朋友，欢迎来到我的酒吧——请自便，吃点东西，做点手术，接受点治疗，诸如此类的好事。不过也记得至少给我们做点生意作为回报。",
			"我怎么到这儿来的？嗯，我和小队里的其他人一起进来，然后我们走散了，我迷了路——现在嘛，我似乎被束缚在这间酒吧里了。食物会补货，我好像也不会变老，所以我没什么好抱怨的。这已经算是纳米传讯能给我的最好的退休生活了，但如果你见到我小队的成员，比如普里斯汀，替我向他们问好——前提是我小队里还有人活着。",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"我今天不再买异常核心了，这个周期我已经收够了。",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"你已经把我手头的异常核心全买走了——下个周期再来。",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"过来啊，混蛋。",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"真是可惜。",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"欢迎来到我的异常核心商店，它呃——是这附近仅有的几家店之一，所以……",
		),
	)
