///Used to contain the traders initial wares, and speech
/datum/trader_data

	///The item that marks the shopkeeper will sit on
	var/shop_spot_type =  /obj/structure/chair/plastic
	///The sign that will greet the customers
	var/sign_type = /obj/structure/trader_sign
	///Sound used when item sold/bought
	var/sell_sound = 'sound/effects/cashregister.ogg'
	///The currency name
	var/currency_name = MONEY_NAME
	///The initial products that the trader offers
	var/list/initial_products = list(
		/obj/item/food/burger/ghost = list(PAYCHECK_CREW * 4, INFINITY),
	)
	///The initial products that the trader buys
	var/list/initial_wanteds = list(
		/obj/item/ectoplasm = list(PAYCHECK_CREW * 2, INFINITY, ""),
	)
	///The speech data of the trader
	var/list/say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"抱歉，你给我看的东西我都不感兴趣。拿点更好的来，我们再谈。",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"真可惜，如果你改主意了告诉我。",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"很高兴与你做交易。",
		),
		INTERESTED_PHRASE = list(
			"嘿，你有件东西让我很感兴趣，我想买下它，我会付你现金，成交吗？",
		),
		BUY_PHRASE = list(
			"很高兴与你做交易。",
		),
		NO_CASH_PHRASE = list(
			"抱歉，冒险者，我可不能赊账！等你再……嗯……有钱一点再来吧！",
		),
		NO_STOCK_PHRASE = list(
			"抱歉，冒险者，那件商品目前没有现货。",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"那件东西我暂时不想收，改天再来看看吧。",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"仔细一看，这东西似乎一文不值，我不收。",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"这种东西我暂时已经收够了。",
		),
		TRADER_LORE_PHRASE = list(
			"你好！我是测试商人。",
			"哦哦哦哦哦哦～！",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"我目前什么都不收。",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"我目前什么都不卖。",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"小偷！",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"这个折扣，我称之为“死亡”。",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"欢迎光临我的商店，朋友！",
		),
	)

/**
 * Depending on the passed parameter/override, returns a randomly picked string out of a list
 *
 * Do note when overriding this argument, you will need to ensure pick(the list) doesn't get supplied with a list of zero length
 * Arguments:
 * * say_text - (String) a define that matches the key of a entry in say_phrases
 */
/datum/trader_data/proc/return_trader_phrase(say_text)
	if(!length(say_phrases[say_text]))
		return
	return pick(say_phrases[say_text])

/datum/trader_data/mr_bones
	shop_spot_type = /obj/structure/chair/wood/wings
	sign_type = /obj/structure/trader_sign/mrbones
	sell_sound = 'sound/mobs/non-humanoids/hiss/hiss2.ogg'

	initial_products = list(
		/obj/item/clothing/head/helmet/skull = list(PAYCHECK_CREW * 3, INFINITY),
		/obj/item/clothing/mask/bandana/skull/black = list(PAYCHECK_CREW, INFINITY),
		/obj/item/food/cookie/sugar/spookyskull = list(PAYCHECK_CREW * 0.2, INFINITY),
		/obj/item/instrument/trombone/spectral = list(PAYCHECK_CREW * 200, INFINITY),
		/obj/item/shovel/serrated = list(PAYCHECK_CREW * 3, INFINITY),
	)

	initial_wanteds = list(
		/obj/item/reagent_containers/condiment/milk = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/stack/sheet/bone = list(PAYCHECK_CREW * 8.4, INFINITY, "，每片骨头"),
	)

	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"抱歉，你给我看的东西我都不感兴趣。拿点更好的来，我们再谈。",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"真可惜，如果你改主意了告诉我。",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"很高兴与你做交易。",
		),
		INTERESTED_PHRASE = list(
			"嘿，你有件东西让我很感兴趣，我想买下它，我会付你现金，成交吗？",
		),
		BUY_PHRASE = list(
			"祝您胃口大开！",
		),
		NO_CASH_PHRASE = list(
			"抱歉，冒险者，我可不能赊账！等你再……嗯……有钱一点再来吧！",
		),
		NO_STOCK_PHRASE = list(
			"抱歉，冒险者，那件商品目前没有现货。",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"那件东西我暂时不想收，改天再来看看吧。",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"仔细一看，这东西似乎一文不值，我不收。",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"这种东西我暂时已经收够了。",
		),
		TRADER_LORE_PHRASE = list(
			"你好，我是骨头先生！",
			"这趟旅程永无止境！",
			"我真想喝一盒清爽的牛奶！",
			"我愿意为骨头出大价钱！做周边商品总得有材料，对吧？",
			"外面天气真好。鸟儿在歌唱，花儿在绽放……在这样的日子里，像你这样的孩子……就该来买我的货！",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"我目前什么都不收。",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"我目前什么都不卖。",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"你的旅程到此为止了！",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"骨头先生从不失手！",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"我的疯狂之旅开张了！",
		),
	)
