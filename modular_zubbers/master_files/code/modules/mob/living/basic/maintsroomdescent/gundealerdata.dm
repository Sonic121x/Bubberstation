/datum/trader_data/gundealer

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
		/obj/item/gun/ballistic/automatic/sol_rifle/machinegun = list(PAYCHECK_CREW * 1200, INFINITY),
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = list(PAYCHECK_CREW * 60, INFINITY),
		/obj/item/gun/ballistic/automatic/lanca = list(PAYCHECK_CREW * 500, INFINITY),
		/obj/item/ammo_box/magazine/lanca = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/gun/ballistic/automatic/m90/unrestricted = list(PAYCHECK_CREW * 5000, INFINITY),
		/obj/item/ammo_box/magazine/m223 = list(PAYCHECK_CREW * 12, INFINITY),
		/obj/item/gun/ballistic/automatic/napad = list(PAYCHECK_CREW * 400, INFINITY),
		/obj/item/ammo_box/magazine/napad = list(PAYCHECK_CREW * 2, INFINITY),
		/obj/item/gun/ballistic/automatic/pistol/aps = list(PAYCHECK_CREW * 200, INFINITY),
		/obj/item/ammo_box/magazine/m9mm_aps = list(PAYCHECK_CREW * 50, INFINITY),
		/obj/item/gun/ballistic/automatic/pistol/deagle/gold = list(PAYCHECK_CREW * 400, INFINITY),
		/obj/item/ammo_box/magazine/m50 = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/gun/ballistic/automatic/sol_smg = list(PAYCHECK_CREW * 200, INFINITY),
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/gun/ballistic/rifle/boltaction/prime = list(PAYCHECK_CREW * 300, INFINITY),
		/obj/item/storage/toolbox/ammobox/strilka310 = list(PAYCHECK_CREW * 50, INFINITY),
		/obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted = list(PAYCHECK_CREW * 1000, INFINITY),
		/obj/item/ammo_box/a40mm = list(PAYCHECK_CREW * 1000, INFINITY),
		/obj/item/gun/ballistic/shotgun/doublebarrel = list(PAYCHECK_CREW * 40, INFINITY),
		/obj/item/ammo_box/magazine/smgm45 = list(PAYCHECK_CREW * 10, INFINITY),
		/obj/item/gun/ballistic/revolver/golden = list(PAYCHECK_CREW * 800, INFINITY),
		/obj/item/ammo_box/speedloader/c357 = list(PAYCHECK_CREW * 800, INFINITY),

	)
	///The initial products that the trader buys
	initial_wanteds = list(
		/obj/item/gun/energy/laser = list(PAYCHECK_CREW * 5, INFINITY, ""),
		/obj/item/gun/energy/laser/carbine = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/laser/hellgun = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/gun/energy/laser/musket/prime = list(PAYCHECK_CREW * 20, INFINITY, ""),
		/obj/item/gun/energy/laser/thermal/inferno = list(PAYCHECK_CREW * 4, INFINITY, ""),
		/obj/item/gun/energy/laser/thermal/cryo = list(PAYCHECK_CREW * 6, INFINITY, ""),
		/obj/item/gun/energy/lasercannon = list(PAYCHECK_CREW * 40, INFINITY, ""),
		/obj/item/gun/energy/modular_laser_rifle = list(PAYCHECK_CREW * 25, INFINITY, ""),
		/obj/item/gun/energy/modular_laser_rifle/carbine = list(PAYCHECK_CREW * 30, INFINITY, ""),
		/obj/item/gun/energy/laser/captain = list(PAYCHECK_CREW * 200, INFINITY, ""),
		/obj/item/gun/energy/laser/musket = list(PAYCHECK_CREW * 1, INFINITY, ""),
		/obj/item/gun/energy/cell_loaded/medigun/cmo = list(PAYCHECK_CREW * 100, INFINITY, ""),
		/obj/item/gun/energy/e_gun = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/alien = list(PAYCHECK_CREW * 7500, INFINITY, ""),
		/obj/item/gun/energy/disabler = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/disabler/smg = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/disabler/smoothbore/prime = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/dueling = list(PAYCHECK_CREW * 100, INFINITY, ""),
		/obj/item/gun/energy/e_gun/dragnet = list(PAYCHECK_CREW * 100, INFINITY, ""),
		/obj/item/gun/energy/e_gun/hos = list(PAYCHECK_CREW * 200, INFINITY, ""),
		/obj/item/gun/energy/e_gun/nuclear = list(PAYCHECK_CREW * 100, INFINITY, ""),
		/obj/item/gun/energy/e_gun/stun = list(PAYCHECK_CREW * 500, INFINITY, ""),
		/obj/item/gun/energy/event_horizon = list(PAYCHECK_CREW * 5000, INFINITY, ""),
		/obj/item/gun/energy/gravity_gun = list(PAYCHECK_CREW * 25, INFINITY, ""),
		/obj/item/gun/energy/ionrifle = list(PAYCHECK_CREW * 5, INFINITY, ""),
		/obj/item/gun/energy/ionrifle/carbine = list(PAYCHECK_CREW * 1, INFINITY, ""),
		/obj/item/gun/energy/pulse = list(PAYCHECK_CREW * 5000, INFINITY, ""),
		/obj/item/gun/energy/pulse/prize = list(PAYCHECK_CREW * 5000, INFINITY, ""),
		/obj/item/gun/energy/pulse/carbine = list(PAYCHECK_CREW * 2500, INFINITY, ""),
		/obj/item/gun/energy/pulse/pistol = list(PAYCHECK_CREW * 1000, INFINITY, ""),
		/obj/item/gun/energy/pulse/pistol/m1911 = list(PAYCHECK_CREW * 2500, INFINITY, ""),
		/obj/item/gun/energy/recharge/ebow/large = list(PAYCHECK_CREW * 10, INFINITY, ""),
		/obj/item/gun/energy/recharge/kinetic_accelerator = list(PAYCHECK_CREW * 50, INFINITY, ""),
		/obj/item/gun/energy/shrink_ray = list(PAYCHECK_CREW * 7500, INFINITY, ""),
		/obj/item/gun/energy/temperature/security = list(PAYCHECK_CREW * 200, INFINITY, ""),
		/obj/item/gun/energy/tesla_cannon = list(PAYCHECK_CREW * 25, INFINITY, ""),
		/obj/item/gun/energy/wormhole_projector/core_inserted = list(PAYCHECK_CREW * 200, INFINITY, ""),
		/obj/item/gun/energy/xray = list(PAYCHECK_CREW * 20, INFINITY, ""),
	)
	///The speech data of the trader
	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"你拿给我看的那些装备我一样都不喜欢。等你有了我想要的东西再来。",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"我会在这儿的。",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"谢了，我会好好把它转手出去的。",
		),
		INTERESTED_PHRASE = list(
			"嘿，你有把枪让我挺感兴趣。我想买下它，会给你些信用点。",
		),
		BUY_PHRASE = list(
			"好好用这些家伙什，它们的序列号都已经擦干净了。",
		),
		NO_CASH_PHRASE = list(
			"瞧，老兄——我知道这些价格高得离谱，但信用点兑真钱的汇率是一百比一。我定这些价只是为了保持盈利。",
		),
		NO_STOCK_PHRASE = list(
			"之前有人来过，把那把枪买走了。换个周期再来——等这里一切重置、我也补完货之后。",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"我现在不想买那把枪，伙计。换个周期再来。",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"这枪就是垃圾，把那把他妈的咚克软玩具拿到别处去。我自己不怎么开枪，但——我知道主星系里枪的价格，那玩意儿根本值不了几个钱。",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"你们是想让市场泛滥、搞出通货膨胀吗？我现在不能再买那个了。",
		),
		TRADER_LORE_PHRASE = list(
			"嘿，朋友——你居然走到了这里——也不知怎么走的。据我所见，那架梯子有好多好多好多的入口，但你离开时会走你进来的同一条路。我每个周期都来这儿做买卖，靠这个赚得盆满钵满。不过这里的低稳定性有时会侵蚀我的理智。",
			"我怎么到这儿来的？嗯——我知道有那么一堵墙，看起来永远都不对劲。穿过那堵墙就能把我带到这里，我爬了那架梯子几次，看到了另一边的景象。之后我决定不该是我离开这个房间去外面闯荡的时候，但这个地方让我辞掉了那份没前途的工作，改行卖武器。",
			"传单？什么传单，我从不发传单，你一定是搞错了，那张东西看起来不像是我写的，但——没错，我确实卖实弹枪、收购能量枪，我——随便吧。那肯定只是巧合，但知道自己有竞争对手可真让人不爽。",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"我今天不再买别的东西了，要是我经手太多武器，条子就会起疑——嗯，那些我他妈的没打点过的家伙会起疑，那才是真正的麻烦。",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"今天我已经把带来的东西全透过帷幕卖光了，伙计，我每个周期只能来回两趟，一进一出，所以等这里的一切重置之后，下个周期再来多买点。",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"该直接从源头拿货了。",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"这才叫免费的收获！",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"欢迎光临我的工具店，我卖应付各种情况的工具——不过你看起来是从空间站来的，呃。你可得付，很多很多信用点，嘿嘿。抱歉，信用点兑美元的汇率是一百比一。",
		),
	)

