/datum/customer_data
	///The types of food this robot likes in a assoc list of venue type | weighted list. does NOT include subtypes.
	var/list/orderable_objects = list()
	///The amount a robot pays for each food he likes in an assoc list type | payment
	var/list/order_prices = list()
	///Datum AI used for the robot. Should almost never be overwritten unless theyre subtypes of ai_controller/robot_customer
	var/datum/ai_controller/ai_controller_used = /datum/ai_controller/robot_customer
	///Patience of the AI, how long they will wait for their meal.
	var/total_patience = 600 SECONDS
	///Lines the robot says when it finds a seat
	var/list/found_seat_lines = list("我找到座位了")
	///Lines the robot says when it can't find a seat
	var/list/cant_find_seat_lines = list("我没找到座位")
	///Lines the robot says when leaving without food
	var/list/leave_mad_lines = list("没吃到饭就走了")
	///Lines the robot says when leaving with food
	var/list/leave_happy_lines = list("带着食物离开")
	///Lines the robot says when leaving waiting for food
	var/list/wait_for_food_lines = list("我还在等饭")
	///Line when pulled by a friendly venue owner
	var/friendly_pull_line = "我们要去哪儿？"
	///Line when harrased by someone for the first time
	var/first_warning_line = "别碰我！"
	///Line when harrased by someone for the second time
	var/second_warning_line = "这是最后一次警告！"
	///Line when harrased by someone for the last time
	var/self_defense_line = "Omae wa mo, shinderou."
	///Line sent when the customer is clicked on by someone with a 0 force item that's not the correct order
	var/wrong_item_line = "不，我不要那个。"

	///Clothing sets to pick from when dressing the robot.
	var/list/clothing_sets = list("amerifat_clothes")
	///List of prefixes for our robots name
	var/list/name_prefixes
	///Prefix file to uise
	var/prefix_file = "strings/names/american_prefix.txt"
	///Base icon for the customer
	var/base_icon = 'icons/mob/simple/tourists.dmi'
	///Base icon state for the customer
	var/base_icon_state = "amerifat"
	///Sound to use when this robot type speaks
	var/speech_sound = 'sound/mobs/non-humanoids/tourist/tourist_talk.ogg'

	/// Is this unique once per venue?
	var/is_unique = FALSE

/datum/customer_data/New()
	. = ..()
	name_prefixes = world.file2list(prefix_file)
	if(check_holidays(ICE_CREAM_DAY)) ///customers are more likely to order ice cream on this holiday
		var/list/orderable_restaurant = orderable_objects[VENUE_RESTAURANT]
		if(orderable_restaurant?[/datum/custom_order/icecream])
			orderable_restaurant[/datum/custom_order/icecream] *= 3

/// Can this customer be chosen for this venue?
/datum/customer_data/proc/can_use(datum/venue/venue, obj/machinery/restaurant_portal/portal)
	return TRUE

/datum/customer_data/proc/get_overlays(mob/living/basic/robot_customer/customer)
	return

/datum/customer_data/proc/get_underlays(mob/living/basic/robot_customer/customer)
	return

/datum/customer_data/american
	found_seat_lines = list("我希望有个撑得住我体重的座位。", "我希望我能把枪带进来。", "我希望他们有超豪华三层肥汉堡。", "我就是爱这里的文化。")
	cant_find_seat_lines = list("站着好累……", "我有慢性背痛，快给我找个座位！", "要是不给我座位，我就不给小费。")
	leave_mad_lines = list("不给你小费。再见！", "至少在太空唐纳德，他们上菜很快！", "这家店太糟糕了！", "我要找你们经理！", "我一定会去 Yelp 上给差评。")
	leave_happy_lines = list("朋友，多给你一份小费。", "谢谢你的美食！", "糖尿病本来就是骗人的！")
	wait_for_food_lines = list("听着，伙计，我这边可等得很不耐烦了！", "我都等了老半天了……")
	friendly_pull_line = "你要带我去哪儿？希望不是医疗舱，我可没有保险。"
	first_warning_line = "别踩我！"
	second_warning_line = "最后一次机会，伙计！别踩我！"
	self_defense_line = "城堡准则已启动！"

	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/food/burger/plain = 25,
			/obj/item/food/burger/cheese = 15,
			/obj/item/food/burger/superbite = 1,
			/obj/item/food/butter/on_a_stick = 8,
			/obj/item/food/fries = 10,
			/obj/item/food/cheesyfries = 6,
			/obj/item/food/pie/applepie = 4,
			/obj/item/food/pie/pumpkinpie = 2,
			/obj/item/food/hotdog = 8,
			/obj/item/food/pizza/pineapple = 1,
			/obj/item/food/burger/baconburger = 10,
			/obj/item/food/pancakes = 4,
			/obj/item/food/eggsausage = 5,
			/datum/custom_order/icecream = 14,
			/obj/item/food/danish_hotdog = 3,
		),
		VENUE_BAR = list(
			/datum/reagent/consumable/ethanol/beer = 25,
			/datum/reagent/consumable/ethanol/b52 = 6,
			/datum/reagent/consumable/ethanol/manhattan = 3,
			/datum/reagent/consumable/ethanol/old_fashioned = 3,
			/datum/reagent/consumable/ethanol/sazerac = 2,
			/datum/reagent/consumable/ethanol/improved_whiskey = 1,
			/datum/reagent/consumable/ethanol/atomicbomb = 1,
		),
	)


/datum/customer_data/italian
	prefix_file = "strings/names/italian_prefix.txt"
	base_icon_state = "italian"
	clothing_sets = list("italian_pison", "italian_godfather")

	found_seat_lines = list("真是个坐着的好地方。", "我希望他们做得像我妈妈以前做的那样。")
	cant_find_seat_lines = list("我的妈呀！我只想要个座位！", "你为什么让我站在这儿？")
	leave_mad_lines = list("我好多年没见过这么不尊重人的了！", "多么糟糕的店啊！")
	leave_happy_lines = list("这就是爱呀！", "就像妈妈以前做的那样！")
	wait_for_food_lines = list("我好饿啊……")
	friendly_pull_line = "不，我饿了！我哪儿都不想去。"
	first_warning_line = "别碰我！"
	second_warning_line = "最后一次警告！别碰我的意面。"
	self_defense_line = "我要像妈妈揉她那美味肉丸一样揉你！"
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/food/spaghetti/pastatomato = 20,
			/obj/item/food/spaghetti/copypasta = 6,
			/obj/item/food/spaghetti/meatballspaghetti = 4,
			/obj/item/food/spaghetti/butternoodles = 4,
			/obj/item/food/pizza/vegetable = 2,
			/obj/item/food/pizza/mushroom = 2,
			/obj/item/food/pizza/meat = 2,
			/obj/item/food/pizza/margherita = 2,
			/obj/item/food/lasagna = 4,
			/obj/item/food/cannoli = 3,
			/obj/item/food/salad/risotto = 5,
			/obj/item/food/eggplantparm = 3,
			/obj/item/food/cornuto = 2,
			/datum/custom_order/icecream = 10,
			/obj/item/food/salad/greek_salad = 6,
		),
		VENUE_BAR = list(
			/datum/reagent/consumable/ethanol/fanciulli = 5,
			/datum/reagent/consumable/ethanol/branca_menta = 3,
			/datum/reagent/consumable/ethanol/beer = 5,
			/datum/reagent/consumable/lemonade = 8,
			/datum/reagent/consumable/ethanol/godfather = 5,
			/datum/reagent/consumable/ethanol/wine = 3,
			/datum/reagent/consumable/ethanol/grappa = 3,
			/datum/reagent/consumable/ethanol/amaretto = 5,
			/datum/reagent/consumable/ethanol/amaretto_sour = 3,
			/datum/reagent/consumable/cucumberlemonade = 2,
			/datum/reagent/consumable/ethanol/negroni = 2,
			/datum/reagent/consumable/ethanol/garibaldi = 2,
			/datum/reagent/consumable/ethanol/spritz = 5,
		),
	)


/datum/customer_data/french
	prefix_file = "strings/names/french_prefix.txt"
	base_icon_state = "french"
	clothing_sets = list("french_fit")
	found_seat_lines = list("Hon hon hon", "这不是埃菲尔铁塔，但也凑合了。", "啧，我看这也只能将就了。")
	cant_find_seat_lines = list("竟让我这样的人站着？你好大的胆子。", "多脏的大堂啊！")
	leave_mad_lines = list("Sacre bleu!", "Merde! 这地方比莱茵河还脏！")
	leave_happy_lines = list("Hon hon hon.", "还算用心。")
	wait_for_food_lines = list("Hon hon hon")
	friendly_pull_line = "你那脏手要碰我的衣服？呃，算了。"
	first_warning_line = "把手从我身上拿开！"
	second_warning_line = "别碰我，你这脏东西，最后一次警告！"
	self_defense_line = "我要像掰法棍一样掰断你！"
	speech_sound = 'sound/mobs/non-humanoids/tourist/tourist_talk_french.ogg'
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/food/baguette = 20,
			/obj/item/food/garlicbread = 5,
			/obj/item/food/omelette = 15,
			/datum/custom_order/icecream = 6,
			/datum/reagent/consumable/nutriment/soup/french_onion = 4,
			/obj/item/food/pie/berryclafoutis = 2,
		),
		VENUE_BAR = list(
			/datum/reagent/consumable/ethanol/champagne = 10,
			/datum/reagent/consumable/ethanol/cognac = 5,
			/datum/reagent/consumable/ethanol/mojito = 5,
			/datum/reagent/consumable/ethanol/sidecar = 5,
			/datum/reagent/consumable/ethanol/between_the_sheets = 4,
			/datum/reagent/consumable/ethanol/beer = 5,
			/datum/reagent/consumable/ethanol/wine = 5,
			/datum/reagent/consumable/ethanol/gin_garden = 2,
			/datum/reagent/consumable/ethanol/french_75 = 5,
			/datum/reagent/consumable/ethanol/herbal_liqueur = 2,
			/datum/reagent/consumable/ethanol/pousse_cafe = 1,
		),
	)

/datum/customer_data/french/get_overlays(mob/living/basic/robot_customer/customer)
	if(customer.ai_controller.blackboard[BB_CUSTOMER_LEAVING])
		return mutable_appearance(customer.icon, "french_flag", appearance_flags = RESET_COLOR|KEEP_APART)



/datum/customer_data/japanese
	prefix_file = "strings/names/japanese_prefix.txt"
	base_icon_state = "japanese"
	clothing_sets = list("japanese_animes")

	found_seat_lines = list("Konnichiwa!", "Arigato gozaimasuuu~", "我希望这里有俄式牛肉丝……")
	cant_find_seat_lines = list("前辈，我想赶快坐到樱花树下了！", "趁我的傲娇还没变成病娇，快给我个座位！", "这地方的座位比胶囊旅馆还少！", "没有座位？这位匠人也太冷淡了……")
	leave_mad_lines = list("我真不敢相信你居然这样！哇啊啊啊啊啊！！", "我、我才不是想要你的食物呢！笨、笨蛋……", "我本来还想给你小费的！")
	leave_happy_lines = list("哦，营养供给者！这是我人生中最幸福的一天。我爱你！", "我拿起一片薯片……然后吃掉它！", "Itadakimasuuu~", "Gochisousama desu!")
	wait_for_food_lines = list("还没有吃的？那也没办法吧。", "真期待终于能见到汉堡大人……", "快把我的食物给我，你这坏蛋！")
	friendly_pull_line = "哦、哦，你要带我去哪儿？"
	first_warning_line = "别碰我，你这变态！"
	second_warning_line = "你再碰我一次我就要变成超级赛亚人了！最后一次警告！"
	self_defense_line = "OMAE WA MO, SHINDEROU!"
	speech_sound = 'sound/mobs/non-humanoids/tourist/tourist_talk_japanese1.ogg'
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/datum/custom_order/icecream = 4,
			/datum/reagent/consumable/nutriment/soup/miso = 10,
			/datum/reagent/consumable/nutriment/soup/vegetable_soup = 4,
			/obj/item/food/beef_stroganoff = 2,
			/obj/item/food/breadslice/plain = 5,
			/obj/item/food/chawanmushi = 4,
			/obj/item/food/fish_poke = 5,
			/obj/item/food/muffin/berry = 2,
			/obj/item/food/sashimi = 4,
			/obj/item/food/tofu = 5,
		),
		VENUE_BAR = list(
			/datum/reagent/consumable/ethanol/sake = 8,
			/datum/reagent/consumable/cafe_latte = 6,
			/datum/reagent/consumable/ethanol/aloe = 6,
			/datum/reagent/consumable/chocolatepudding = 4,
			/datum/reagent/consumable/tea = 4,
			/datum/reagent/consumable/cherryshake = 1,
			/datum/reagent/consumable/ethanol/bastion_bourbon = 1,
		),
	)

/datum/customer_data/japanese/get_overlays(mob/living/basic/robot_customer/customer)
	//leaving and eaten
	if(type == /datum/customer_data/japanese && customer.ai_controller.blackboard[BB_CUSTOMER_LEAVING] && customer.ai_controller.blackboard[BB_CUSTOMER_EATING])
		return mutable_appearance('icons/effects/effects.dmi', "love_hearts", appearance_flags = RESET_COLOR|KEEP_APART)

/datum/customer_data/japanese/salaryman
	clothing_sets = list("japanese_salary")

	found_seat_lines = list("不知道这里会不会也有巨大怪兽来袭……", "Hajimemashite.", "Konbanwa.", "传送带在哪儿……")
	cant_find_seat_lines = list("拜托，给我个座位。我只想要个座位。", "我这边有时间安排。我的座位在哪儿？", "……我明白这地方为什么生意不好了。他们连座位都不给你安排。")
	leave_mad_lines = list("这地方简直丢人，我要告诉我的同事们。", "真是浪费我的时间。", "希望你别为自己这里的经营感到自豪。")
	leave_happy_lines = list("谢谢你的招待。", "Otsukaresama deshita.", "还有工作要办。")
	wait_for_food_lines = list("呼……呼……", "Dame da ne~", "Dame yo dame na no yo~")
	friendly_pull_line = "我们这是要出差吗？"
	first_warning_line = "喂，只有我的雇主才能那样折腾我。"
	second_warning_line = "别烦我，我正想集中精神。最后一次警告！"
	self_defense_line = "我也不想变成这样。"
	speech_sound = 'sound/mobs/non-humanoids/tourist/tourist_talk_japanese2.ogg'
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/datum/reagent/consumable/nutriment/soup/miso = 6,
			/datum/reagent/consumable/nutriment/soup/vegetable_soup = 4,
			/obj/item/food/beef_stroganoff = 2,
			/obj/item/food/chawanmushi = 4,
			/obj/item/food/meat_poke = 4,
			/obj/item/food/meatbun = 4,
			/obj/item/food/sashimi = 4,
			/obj/item/food/tofu = 5,
		),
		VENUE_BAR = list(
			/datum/reagent/consumable/ethanol/beer = 14,
			/datum/reagent/consumable/ethanol/sake = 9,
			/datum/reagent/consumable/cafe_latte = 3,
			/datum/reagent/consumable/coffee = 3,
			/datum/reagent/consumable/soy_latte = 3,
			/datum/reagent/consumable/ethanol/atomicbomb = 1,
		),
	)

/datum/customer_data/moth
	prefix_file = "strings/names/moth_prefix.txt"
	base_icon_state = "mothbot"
	found_seat_lines = list("把你的帽子给我！", "蛾？", "这真是个……有意思的地方。")
	cant_find_seat_lines = list("要是找不到座位，我就扑棱扑棱赶紧飞走！", "我这儿正忙着扑腾呢！")
	leave_mad_lines = list("我要告诉我所有的蛾子朋友，千万别来这儿！", "零星差评，比我那次吃樟脑丸还糟！","就算永久关门，对这地方来说都算便宜它了。")
	leave_happy_lines = list("我本想拿帽子给你当小费，可我把它吃了！", "希望那不是收藏品！", "那是我吃过最棒的东西，比原驼肉还好吃！")
	wait_for_food_lines = list("在这儿弄点吃的有多难？你自己身上都穿着食物呢！", "我毛茸茸的机械肚子在咕咕叫！", "我不喜欢等！")
	friendly_pull_line = "蛾夫？"
	first_warning_line = "走开，我这儿正忙着弄点帽子！"
	second_warning_line = "最后一次警告！我要毁了你！"
	self_defense_line = "扑翅攻击！"

	speech_sound = 'sound/mobs/non-humanoids/tourist/tourist_talk_moth.ogg'

	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/datum/custom_order/moth_clothing = 1,
		),
	)

	clothing_sets = list("mothbot_clothes")
	is_unique = TRUE

	/// The wings chosen for the moth customers.
	var/list/wings_chosen

// The whole gag is taking off your hat and giving it to the customer.
// If it takes any more effort, it loses a bit of the comedy.
// Therefore, only show up if it's reasonable for that gag to happen.
/datum/customer_data/moth/can_use(datum/venue/venue, obj/machinery/restaurant_portal/portal)
	var/mob/living/carbon/human/buffet = portal.turned_on_portal?.resolve()
	if (!istype(buffet))
		return FALSE
	if(QDELETED(buffet.head) && QDELETED(buffet.gloves) && QDELETED(buffet.shoes))
		return FALSE
	return TRUE

/datum/customer_data/moth/proc/get_wings(mob/living/basic/robot_customer/customer)
	var/customer_ref = WEAKREF(customer)
	if (!LAZYACCESS(wings_chosen, customer_ref))
		var/picked_wings = pick(SSaccessories.sprite_accessories[FEATURE_WINGS]) // BUBBER EDIT CHANGE - Original: var/picked_wings = pick(SSaccessories.feature_list[FEATURE_MOTH_WINGS])
		LAZYSET(wings_chosen, customer_ref, SSaccessories.sprite_accessories[FEATURE_WINGS][picked_wings]) // BUBBER EDIT CHANGE - Original: LAZYSET(wings_chosen, customer_ref, SSaccessories.feature_list[FEATURE_MOTH_WINGS][picked_wings])
	return wings_chosen[customer_ref]

/datum/customer_data/moth/get_underlays(mob/living/basic/robot_customer/customer)
	var/list/underlays = list()

	var/datum/sprite_accessory/moth_wings/wings = get_wings(customer)
	underlays += mutable_appearance(icon = 'icons/mob/human/species/moth/moth_wings.dmi', icon_state = "m_moth_wings_[wings.icon_state]_BEHIND", appearance_flags = RESET_COLOR|KEEP_APART)
	return underlays

/datum/customer_data/moth/get_overlays(mob/living/basic/robot_customer/customer)
	var/list/overlays = list()

	var/datum/sprite_accessory/moth_wings/wings = get_wings(customer)
	overlays += mutable_appearance(icon = 'icons/mob/human/species/moth/moth_wings.dmi', icon_state = "m_moth_wings_[wings.icon_state]_FRONT", appearance_flags = RESET_COLOR|KEEP_APART)
	overlays += mutable_appearance(icon = customer.icon, icon_state = "mothbot_jetpack", appearance_flags = RESET_COLOR|KEEP_APART)
	return overlays

/datum/customer_data/mexican
	base_icon_state = "mexican"
	prefix_file = "strings/names/mexican_prefix.txt"
	speech_sound = 'sound/mobs/non-humanoids/tourist/tourist_talk_mexican.ogg'
	clothing_sets = list("mexican_poncho")
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/food/taco/plain = 25,
			/obj/item/food/taco = 15,
			/obj/item/food/burrito = 15,
			/obj/item/food/fuegoburrito = 1,
			/obj/item/food/cheesyburrito = 4,
			/obj/item/food/nachos = 10,
			/obj/item/food/cheesynachos = 6,
			/obj/item/food/pie/dulcedebatata = 2,
			/obj/item/food/cubannachos = 3,
			/obj/item/food/stuffedlegion = 1,
			/datum/custom_order/icecream = 2,
		),
		VENUE_BAR = list(
			/datum/reagent/consumable/ethanol/whiskey = 6,
			/datum/reagent/consumable/ethanol/tequila = 20,
			/datum/reagent/consumable/ethanol/tequila_sunrise = 1,
			/datum/reagent/consumable/ethanol/beer = 15,
			/datum/reagent/consumable/ethanol/patron = 5,
			/datum/reagent/consumable/ethanol/brave_bull = 5,
			/datum/reagent/consumable/ethanol/margarita = 8,
		),
	)

	found_seat_lines = list("¿Como te va, 13 号空间站？", "谁准备好开派对啦！", "啊，muchas gracias。", "啊……闻起来像我奶奶做的菜！")
	cant_find_seat_lines = list("¿En Serio？说真的，没有座位？", "Andele！我要张桌子看足球赛！", "Ay Caramba……")
	leave_mad_lines = list("Aye dios mio，我走了。", "Esto es ridículo！我走了！", "我在塔可钟见过更好的厨艺！", "我以为这是餐厅，pero es porquería！")
	leave_happy_lines = list("Amigo，era delicio。谢谢！", "Yo tuve el mono，朋友你呢？正中下怀。", "辣度刚刚好！")
	wait_for_food_lines = list("Ay ay ay，怎么这么久……", "准备好了吗，amigo？")
	friendly_pull_line = "Amigo，我们要去哪儿？"
	first_warning_line = "Amigo！别那样碰我。"
	second_warning_line = "Compadre，够了！最后一次警告！"
	self_defense_line = "是时候让你见识见识我是什么样的机器人了，嗯？"

/datum/customer_data/british
	base_icon_state = "british"
	prefix_file = "strings/names/british_prefix.txt"
	speech_sound = 'sound/mobs/non-humanoids/tourist/tourist_talk_british.ogg'

	friendly_pull_line = "我可不喜欢被人这样拉来拉去。"
	first_warning_line = "我们至高无上的君主女王陛下谕令并命令所有聚集之人立即解散。"
	second_warning_line = "并和平返回各自居所或合法事务，违者将依乔治王元年为防骚乱与聚众暴动所定法令之罚则处置。不会再有警告。"
	self_defense_line = "天佑女王。"

	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/datum/custom_order/icecream = 8,
			/datum/reagent/consumable/nutriment/soup/indian_curry = 3,
			/datum/reagent/consumable/nutriment/soup/stew = 10,
			/obj/item/food/beef_wellington_slice = 2,
			/obj/item/food/benedict = 5,
			/obj/item/food/fishandchips = 10,
			/obj/item/food/full_english = 2,
			/obj/item/food/sandwich/grilled_cheese = 5,
			/obj/item/food/pie/meatpie = 5,
			/obj/item/food/salad/ricepudding = 5,
		),
		VENUE_BAR = list(
			/datum/reagent/consumable/ethanol/ale = 10,
			/datum/reagent/consumable/ethanol/beer = 10,
			/datum/reagent/consumable/ethanol/gin = 5,
			/datum/reagent/consumable/ethanol/hcider = 10,
			/datum/reagent/consumable/ethanol/alliescocktail = 5,
			/datum/reagent/consumable/ethanol/martini = 5,
			/datum/reagent/consumable/ethanol/gintonic = 5,
			/datum/reagent/consumable/tea = 10,
			/datum/reagent/consumable/ethanol/hot_toddy = 5,
		),
	)


/datum/customer_data/british/gent
	clothing_sets = list("british_gentleman")

	found_seat_lines = list("啊，多么好的店。", "该尝尝伟大的英国菜了，真是他妈的激动人心！", "太好了，现在看菜单……", "统治吧不列颠，不列颠统治海洋……")
	cant_find_seat_lines = list("真正的英国人从不站着，除非在排队！", "老天啊，伙计，一个空座位都看不到！", "我是站在巨人的肩膀上，不是站在餐厅里！")
	leave_mad_lines = list("先生，我祝您日安。日安！", "这地方比战时的法国还丢人！", "我就知道该去那家该死的炸鱼薯条店！", "再想想，我们还是别去 13 号空间站了。那地方太蠢了。")
	leave_happy_lines = list("真是太他妈好吃了！", "以上帝、女王与国家的名义，这真是太好了！", "自英属印度时期以来我就没这么舒坦过！太好了！")
	wait_for_food_lines = list("这他妈也太久了……", "打扰一下，先生，我能问问我的订单到哪一步了吗？")

/datum/customer_data/british/bobby
	clothing_sets = list("british_bobby")

	found_seat_lines = list("希望这是家正派体面的店。", "我想老巡区可以等上一会儿。", "以上帝、女王与国家的名义，我饿坏了。", "先生，你们有什么英国名菜吗？")
	cant_find_seat_lines = list("我在巡区站得够久了！", "你是想让我坐在头盔上吗？请给我个座位！", "我看起来像伦敦塔卫兵吗？我需要座位！")
	leave_mad_lines = list("看来警局今天不会付账了。", "要是无礼算犯罪，你现在就被抓了！", "你比普通黑帮好不到哪去，你这可恶的恶棍！", "像你这样的人就该恢复流放，让内陆去收拾你。")
	leave_happy_lines = list("哎呀，正是我需要的。", "我得回去巡区了。多谢你的饭菜！", "先生，我向您脱帽致意。")
	wait_for_food_lines = list("天哪，我处理文书都比这快……", "先生，我的订单有消息吗？")

///MALFUNCTIONING - only shows up once per venue, very rare
/datum/customer_data/malfunction
	base_icon_state = "defect"
	prefix_file = "strings/names/malf_prefix.txt"
	speech_sound = 'sound/effects/clang.ogg'
	clothing_sets = list("defect_wires", "defect_bad_takes")
	is_unique = TRUE
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/toy/crayon/red = 1,
			/obj/item/toy/crayon/orange = 1,
			/obj/item/toy/crayon/yellow = 1,
			/obj/item/toy/crayon/green = 1,
			/obj/item/toy/crayon/blue = 1,
			/obj/item/toy/crayon/purple = 1,
			/obj/item/food/canned/peaches/maint = 6,
		),
		VENUE_BAR = list(
			/datum/reagent/consumable/failed_reaction = 1,
			/datum/reagent/spraytan = 1,
			/datum/reagent/reaction_agent/basic_buffer = 1,
			/datum/reagent/reaction_agent/acidic_buffer = 1,
		),
	)

	found_seat_lines = list("customer_pawn.say(pick(customer_data.found_seat_lines))", "我在 hub 上看到过你这个星区。这片土地的法律是什么？", "这里的移动速度有点低……")
	cant_find_seat_lines = list("别对我的 AI 做压力测试，小子！我的工程师考虑了正好零个边界情况！", "我分不清我找不到座位是因为我坏了还是因为你坏了。", "也许我该在 7 格之外找找座位……")
	leave_mad_lines = list("Runtime in robot_customer_controller.dm, line 28: undefined type path /datum/ai_behavior/leave_venue.", "要是你们还有伤害意图，我早就打你了！", "我要把这事告诉众神。")
	leave_happy_lines = list("不！我不想被下游合并！求你了！这里太好了！救命！！")
	wait_for_food_lines = list("待办：写一些等餐台词", "要是我有个脑子就好了……", "request_for_food.dmb - 0 errors, 12 warnings", "话说回来，我该怎么吃东西？")
	friendly_pull_line = "Chelp."
	first_warning_line = "你在我来的地方会很吃得开。但你最好停手。"
	second_warning_line = "Breaking-you-so-bad-you'll-reminisce-the-days-before-I-made-you-crooked.exe：正在启动……"
	self_defense_line = "我被设计来做两件事：点餐，以及打断你身上每一根骨头。"
