/datum/market_item/misc
	category = "Miscellaneous"
	abstract_path = /datum/market_item/misc

/datum/market_item/misc/clear_pda
	name = "透明 PDA"
	desc = "用这款限量版透明 PDA 展现你的风格。"
	item = /obj/item/modular_computer/pda/clear

	price_min = CARGO_CRATE_VALUE * 1.25
	price_max = CARGO_CRATE_VALUE *3
	stock_max = 2
	availability_prob = 50

/datum/market_item/misc/jade_lantern
	name = "玉灯笼"
	desc = "在一个标着“危险：放射性”的箱子里找到的。大概安全。"
	item = /obj/item/flashlight/lantern/jade

	price_min = CARGO_CRATE_VALUE * 0.75
	price_max = CARGO_CRATE_VALUE * 2.5
	stock_max = 2
	availability_prob = 45

/datum/market_item/misc/cap_gun
	name = "火药玩具枪"
	desc = "用这把无害的枪捉弄你的朋友吧！保证无害。"
	item = /obj/item/toy/gun

	price_min = CARGO_CRATE_VALUE * 0.25
	price_max = CARGO_CRATE_VALUE
	stock_max = 6
	availability_prob = 80

/datum/market_item/misc/shoulder_holster
	name = "肩挂枪套"
	desc = "呀哈，硬汉朋友们！这个枪套是你实现梦想的第一步——成为侦探，并被允许开真枪！"
	item = /obj/item/storage/belt/holster

	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 4
	stock_max = 8
	availability_prob = 60

/datum/market_item/misc/donk_recycler
	name = "MOD 防暴泡沫弹回收模块"
	desc = "如果你喜欢玩具枪、讨厌打扫，又恰好有一套 MOD 外骨骼，那这个模块必不可少。"
	item = /obj/item/mod/module/recycler/donk
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 4.5
	stock_max = 2
	availability_prob = 30

/datum/market_item/misc/atrocinator
	name = "MOD 反重力模块"
	desc = "我们在一处维修通道里发现了这个模块，它被塞在几个警示锥和危险标志后面，没有任何标签。它大概安全。"
	item = /obj/item/mod/module/atrocinator
	price_min = CARGO_CRATE_VALUE * 4
	price_max = CARGO_CRATE_VALUE * 7
	stock_max = 1
	availability_prob = 22

/datum/market_item/misc/tanner
	name = "MOD 晒黑模块"
	desc = "想在上班时还能享受沙滩？有了这个时髦的晒黑模块就行！"
	item = /obj/item/mod/module/tanner
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 3
	stock_max = 2
	availability_prob = 30

/datum/market_item/misc/hat_stabilizer
	name = "MOD 帽子固定模块"
	desc = "有了这个模块，就不必为了实用而牺牲风格！不含帽子。"
	item = /obj/item/mod/module/hat_stabilizer
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 3
	stock_max = 2
	availability_prob = 35

/datum/market_item/misc/shove_blocker
	name = "MOD 壁垒模块"
	desc = "你根本想不到上一个班次我们把这模块从那套该死的卫护型 MOD 外骨骼上拆下来费了多大劲。"
	item = /obj/item/mod/module/shove_blocker
	price_min = CARGO_CRATE_VALUE * 4
	price_max = CARGO_CRATE_VALUE * 5.75
	stock_max = 1
	availability_prob = 25

/datum/market_item/misc/holywater
	name = "圣水壶"
	desc = "卢提乌斯神父自家品牌的即用型圣水。"
	item = /obj/item/reagent_containers/cup/glass/bottle/holywater

	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 3
	stock_max = 3
	availability_prob = 40

/datum/market_item/misc/holywater/spawn_item(loc, datum/market_purchase/purchase)
	if (prob(6.66))
		item = /obj/item/reagent_containers/cup/beaker/unholywater
	else
		item = initial(item)
	return ..()

/datum/market_item/misc/strange_seed
	name = "奇异种子"
	desc = "一种异域品种的种子，长出来的可能是荧光菇，也可能是酸液。"
	item = /obj/item/seeds/random

	price_min = CARGO_CRATE_VALUE * 1.6
	price_max = CARGO_CRATE_VALUE * 1.8
	stock_min = 2
	stock_max = 5
	availability_prob = 50

/datum/market_item/misc/smugglers_satchel
	name = "走私者背包"
	desc = "这款易于藏匿的背包，对任何想让某些东西不被看见、不被想起的人来说都是趁手的工具。里面的东西无法被违禁品扫描仪检测到。"
	item = /obj/item/storage/backpack/satchel/flat/empty

	price_min = CARGO_CRATE_VALUE * 3.75
	price_max = CARGO_CRATE_VALUE * 5
	stock_max = 2
	availability_prob = 30

/datum/market_item/misc/roulette
	name = "轮盘信标"
	desc = "无论你走到哪里，都能开一家自己的地下赌场。一次性使用。概不退款。"
	item = /obj/item/roulette_wheel_beacon
	price_min = CARGO_CRATE_VALUE * 1
	price_max = CARGO_CRATE_VALUE * 2.5
	stock_max = 3
	availability_prob = 50

/datum/market_item/misc/jawed_hook
	name = "带颚鱼钩"
	desc = "要是你抓鱼总抓不利索，就用这玩意儿。记得在来不及之前先收竿，因为这东西扎起鱼来就像阿肯色牙签一样疼。"
	item = /obj/item/fishing_hook/jaws
	price_min = CARGO_CRATE_VALUE * 0.75
	price_max = CARGO_CRATE_VALUE * 2
	stock_max = 3
	availability_prob = 70

/datum/market_item/misc/v8_engine
	name = "正品 V8 发动机（保存完好）"
	desc = "嘿，机修工们，准备好发动引擎了吗？想在走廊里狂飙、在星际环路上来个漂亮的急转弯吗？那你需要这台经典发动机。"
	item = /obj/item/v8_engine
	price_min = CARGO_CRATE_VALUE * 4
	price_max = CARGO_CRATE_VALUE * 6
	stock_max = 1
	availability_prob = 15

/datum/market_item/misc/fishing_capsule
	name = "钓鱼点胶囊"
	//IUU stands for Illegal Unreported and Unregulated fishing. Ironic.
	desc = "一颗改造过的采矿胶囊，连接着若干专属钓鱼点。经星际 IUU 捕鱼协会认证。"
	price_min = CARGO_CRATE_VALUE * 1.125
	price_max = CARGO_CRATE_VALUE * 2.125
	item = /obj/item/survivalcapsule/fishing
	stock_min = 1
	stock_max = 4
	availability_prob = 80

/datum/market_item/misc/fish
	name = "鱼"
	desc = "鱼！新鲜的鱼！可以切、可以磨，想的话还能养在水族箱里！快在我村子里下一场打架爆发前买一些！"
	price_min = PAYCHECK_CREW * 0.5
	price_max = PAYCHECK_CREW * 1.2
	item = /obj/item/storage/fish_case/blackmarket
	stock_min = 3
	stock_max = 8
	availability_prob = 90

/datum/market_item/misc/girlypop
	name = "少女风海报"
	desc = "一堆可爱又讨喜的海报。女孩力量！"
	price_min = PAYCHECK_CREW * 2
	price_max = PAYCHECK_CREW * 5
	item = /obj/item/poster/contraband/heart // gives it the rolled poster icon in the menu
	stock_min = 1
	stock_max = 3
	availability_prob = 90

/datum/market_item/misc/girlypop/spawn_item(loc, datum/market_purchase/purchase)
	. = ..()
	var/obj/structure/closet/crate/glitter/C = new(loc)
	for (var/type in list(
		/obj/item/poster/contraband/dream,
		/obj/item/poster/contraband/beekind,
		/obj/item/poster/contraband/heart,
		/obj/item/poster/contraband/dolphin,
		/obj/item/poster/contraband/principles,
		/obj/item/poster/contraband/trigger,
		/obj/item/poster/contraband/barbaro,
		/obj/item/poster/contraband/seabiscuit,
		/obj/item/poster/contraband/pharlap,
		/obj/item/poster/contraband/waradmiral,
		/obj/item/poster/contraband/silver,
		/obj/item/poster/contraband/jovial,
		/obj/item/poster/contraband/bojack,
	))
		new type(C)
	return C

/datum/market_item/misc/self_surgery_skillchip
	name = /obj/item/skillchip/self_surgery::name
	desc = "天哪，保险公司恨死这东西了。那帮该死的肥猫最受不了人们自己治病—— \
	他们宁愿你去找他们的医生，而那些医生被他们说服，收取普通人根本付不起的敲诈性价格，就为了让你 \
	去签他们的套餐。大多数人最后好几年什么都白付，只为了在真正需要的时候，能有机会负担得起 \
	治疗。\n\n 呃，我刚才说到哪了……哦对。这个技能芯片能让你自己给自己开刀。 \
	对任何不能依靠别人的人来说，这都是必备之物。"
	item = /obj/item/skillchip/self_surgery
	price_min = CARGO_CRATE_VALUE * 5
	price_max = CARGO_CRATE_VALUE * 10
	stock_max = 1
	availability_prob = 15

/datum/market_item/misc/self_surgery_skillchip/buy(obj/item/market_uplink/uplink, mob/buyer, shipping_method, legal_status)
	. = ..()
	if(.)
		availability_prob *= 0.5

/datum/market_item/misc/tricktrickcigarettes
	name = "戏法戏法香烟"
	desc = "装满闪光粉的香烟。用来恶作剧很有意思！"
	item = /obj/item/storage/fancy/cigarettes/flash_powder
	price_min = PAYCHECK_CREW
	price_max = PAYCHECK_CREW * 3
	stock_max = 3
	availability_prob = 25

/datum/market_item/misc/nutrient_pump
	name = "营养泵植入体 加强加强加强版"
	desc = "我们把这东西调到了最大档，还又往上加了一点。保证让你随时都吃得饱饱的。"
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 3
	item = /obj/item/organ/cyberimp/chest/nutriment/black_market
	stock_max = 2
	availability_prob = 60

/datum/market_item/misc/hexacrete
	name = "一桶六合混凝土"
	desc = "需要火速建一处黑站？别折腾了，用这桶 200u 的六合混凝土吧！"
	item = /obj/item/reagent_containers/cup/jerrycan/hexacrete

	price_min = CARGO_CRATE_VALUE * 3
	price_max = CARGO_CRATE_VALUE * 5
	stock_min = 2
	stock_max = 5
	availability_prob = 100
