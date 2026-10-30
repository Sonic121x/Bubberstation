/datum/supply_pack/service
	group = "Service"

/datum/supply_pack/service/cargo_supples
	name = "货运用品箱"
	desc = "把没焊死的东西都卖光了？这箱补给能让你立刻复工：\
		内有印章、出口扫描仪、目的地标签器、手持贴标机\
		和一些包裹包装纸。"
	cost = CARGO_CRATE_VALUE * 1.75
	contains = list(/obj/item/stamp/granted,
					/obj/item/stamp/denied,
					/obj/item/universal_scanner,
					/obj/item/dest_tagger,
					/obj/item/hand_labeler,
					/obj/item/stack/package_wrap,
				)
	crate_name = "货运用品箱"

/datum/supply_pack/service/noslipfloor
	name = "高摩擦地砖"
	desc = "三十块工业级防滑地砖，让滑倒成为过去式！"
	cost = CARGO_CRATE_VALUE * 4
	access_view = ACCESS_JANITOR
	contains = list(/obj/item/stack/tile/noslip/thirty)
	crate_name = "高摩擦地砖箱"

/datum/supply_pack/service/janitor
	name = "清洁用品箱"
	desc = "用纳米传讯清洁必需品™ 击退污垢与油渍！\
		内含三个水桶、警示牌和清洁手榴弹。另有一把拖把、\
		扫帚、喷雾清洁剂、抹布和垃圾袋。"
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_JANITOR
	contains = list(/obj/item/reagent_containers/cup/bucket = 3,
					/obj/item/mop,
					/obj/item/pushbroom,
					/obj/item/clothing/suit/caution = 3,
					/obj/item/storage/bag/trash,
					/obj/item/reagent_containers/spray/cleaner,
					/obj/item/rag,
					/obj/item/grenade/chem_grenade/cleaner = 3,
				)
	crate_name = "清洁用品箱"

/datum/supply_pack/service/janitor/janicart
	name = "清洁推车与橡胶靴箱"
	desc = "任何成功清洁工的基石。只要你有脚，这双\
		橡胶靴就能让它们牢牢钉在地面上。另含一辆清洁推车。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/structure/mop_bucket/janitorialcart,
					/obj/item/clothing/shoes/galoshes,
				)
	crate_name = "清洁推车箱"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/service/janitor/janitank
	name = "清洁工背包箱"
	desc = "用这款大容量清洁工背包对污垢与油渍降下神罚。\
		内含 500 单位净化空间站的清洁剂。"
	cost = CARGO_CRATE_VALUE * 2
	access = ACCESS_JANITOR
	contains = list(/obj/item/watertank/janitor)
	crate_name = "清洁工背包箱"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/service/mule
	name = "MULE 机器人箱"
	desc = "粉头发的货运主管不干活？今天就用这个不知疲倦的劳工替换她！\
		内含一台 MULE 机器人。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/mob/living/basic/bot/mulebot)
	crate_name = "\improper MULE 机器人箱"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/service/party
	name = "派对装备"
	desc = "用纳米传讯派对必需品™ 在空间站上庆祝生与死！\
		内含七支彩色荧光棒、六罐啤酒、六罐汽水、两瓶艾尔啤酒，以及一瓶培恩龙舌兰、\
		一瓶金箔力娇酒和一个摇酒壶！"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/storage/box/drinkingglasses,
					/obj/item/reagent_containers/cup/glass/shaker,
					/obj/item/reagent_containers/cup/glass/bottle/patron,
					/obj/item/reagent_containers/cup/glass/bottle/goldschlager,
					/obj/item/reagent_containers/cup/glass/bottle/ale = 2,
					/obj/item/storage/cans/sixbeer,
					/obj/item/storage/cans/sixsoda,
					/obj/item/flashlight/glowstick,
					/obj/item/flashlight/glowstick/red,
					/obj/item/flashlight/glowstick/blue,
					/obj/item/flashlight/glowstick/cyan,
					/obj/item/flashlight/glowstick/orange,
					/obj/item/flashlight/glowstick/yellow,
					/obj/item/flashlight/glowstick/pink,
				)
	crate_name = "派对装备箱"

/datum/supply_pack/service/carpet
	name = "高级地毯箱"
	desc = "铁地砖让你心烦？这些超柔软地毯\
		能装点任何房间。内含普通地毯与黑色地毯各 100 块。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/stack/tile/carpet/fifty = 2,
					/obj/item/stack/tile/carpet/black/fifty = 2)
	crate_name = "高级地毯箱"
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/datum/supply_pack/service/carpet_exotic
	name = "异域地毯箱"
	desc = "直接来自太空俄罗斯的异域地毯，满足你一切装修需求。\
		内含 8 种不同花色地砖各 100 块。"
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/item/stack/tile/carpet/blue/fifty = 2,
					/obj/item/stack/tile/carpet/cyan/fifty = 2,
					/obj/item/stack/tile/carpet/green/fifty = 2,
					/obj/item/stack/tile/carpet/orange/fifty = 2,
					/obj/item/stack/tile/carpet/purple/fifty = 2,
					/obj/item/stack/tile/carpet/red/fifty = 2,
					/obj/item/stack/tile/carpet/royalblue/fifty = 2,
					/obj/item/stack/tile/carpet/royalblack/fifty = 2,
				)
	crate_name = "异域地毯箱"
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/datum/supply_pack/service/carpet_neon
	name = "简约霓虹地毯箱"
	desc = "简约橡胶地垫，带磷光镶边。内含 13 种颜色各 120 块。\
		限量发行。"
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/stack/tile/carpet/neon/simple/white/sixty = 2,
					/obj/item/stack/tile/carpet/neon/simple/black/sixty = 2,
					/obj/item/stack/tile/carpet/neon/simple/red/sixty = 2,
					/obj/item/stack/tile/carpet/neon/simple/orange/sixty = 2,
					/obj/item/stack/tile/carpet/neon/simple/yellow/sixty =2,
					/obj/item/stack/tile/carpet/neon/simple/lime/sixty = 2,
					/obj/item/stack/tile/carpet/neon/simple/green/sixty = 2,
					/obj/item/stack/tile/carpet/neon/simple/teal/sixty = 2,
					/obj/item/stack/tile/carpet/neon/simple/cyan/sixty = 2,
					/obj/item/stack/tile/carpet/neon/simple/blue/sixty = 2,
					/obj/item/stack/tile/carpet/neon/simple/purple/sixty = 2,
					/obj/item/stack/tile/carpet/neon/simple/violet/sixty = 2,
					/obj/item/stack/tile/carpet/neon/simple/pink/sixty = 2,
				)
	crate_name = "霓虹地毯箱"
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/datum/supply_pack/service/lightbulbs
	name = "替换灯具"
	desc = "愿以太之光照耀这座空间站！或者，至少，\
		四十二根灯管和二十一个灯泡的光可以。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/storage/box/lights/mixed = 3)
	crate_name = "替换灯具"

/datum/supply_pack/service/minerkit
	name = "矿工入门套装"
	desc = "矿工都死得太快了？助理想体验站外生活？\
		无论如何，这套装备都是把普通船员变成产矿、\
		屠怪机器的最佳途径。内含介子护目镜、十字镐、高级采矿扫描仪、\
		货运耳机、矿石袋、防毒面具、探索者套装和矿工 ID 升级。"
	cost = CARGO_CRATE_VALUE * 4
	access = ACCESS_QM
	access_view = ACCESS_MINING_STATION
	contains = list(/obj/item/storage/backpack/duffelbag/mining_conscript)
	crate_name = "矿工入门套装"
	crate_type = /obj/structure/closet/crate/secure/cargo/mining

/datum/supply_pack/service/survivalknives
	name = "生存刀箱"
	desc = "内含三把开刃生存刀。每把都保证能稳妥地\
		插进任何纳米传讯标准靴中。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/knife/combat/survival = 3)
	crate_name = "生存刀箱"
	crate_type = /obj/structure/closet/crate/cargo/mining

/datum/supply_pack/service/wedding
	name = "婚礼箱"
	desc = "举办婚礼所需的一切！现在你只缺一位主婚人了。\
		内含婚纱、燕尾服、腰封、婚礼头纱、三束花，\
		以及一瓶香槟。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/clothing/under/dress/wedding_dress,
					/obj/item/clothing/under/suit/tuxedo,
					/obj/item/storage/belt/fannypack/cummerbund,
					/obj/item/clothing/head/costume/weddingveil,
					/obj/item/bouquet,
					/obj/item/bouquet/sunflower,
					/obj/item/bouquet/poppy,
					/obj/item/reagent_containers/cup/glass/bottle/champagne,
				)
	crate_name = "婚礼箱"

/// Box of 7 grey IDs.
/datum/supply_pack/service/greyidbox
	name = "灰色 ID 卡多联包箱"
	desc = "一个方便的箱子，内含一盒七张廉价 ID 卡，尺寸恰好能放进钱包。\
		卡片的颜色应有尽有——只要是你想得到的灰色。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/storage/box/ids)
	crate_name = "基础 ID 卡箱"

/// Single silver ID.
/datum/supply_pack/service/silverid
	name = "银色 ID 卡箱"
	desc = "是不是忘了招任何部门主管？用这张高价值 ID 卡\
		自行招募吧，它能保存高级权限，尺寸还能放进钱包。"
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/obj/item/card/id/advanced/silver)
	crate_name = "银色 ID 卡箱"

/datum/supply_pack/service/emptycrate
	name = "空板条箱"
	desc = "一个空板条箱，满足你一切收纳需求。"
	cost = CARGO_CRATE_VALUE * 1.4 //Net Zero Profit.
	contains = list()
	crate_name = "板条箱"

/datum/supply_pack/service/randomized/donkpockets
	name = "咚克口袋饼混合箱"
	desc = "收录咚克公司最受欢迎的糕点阵容！内含 \
		随机搭配的咚克口袋饼盒。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/storage/box/donkpockets/donkpocketspicy,
					/obj/item/storage/box/donkpockets/donkpocketteriyaki,
					/obj/item/storage/box/donkpockets/donkpocketpizza,
					/obj/item/storage/box/donkpockets/donkpocketberry,
					/obj/item/storage/box/donkpockets/donkpockethonk,
				)
	crate_name = "咚克口袋饼箱"
	crate_type = /obj/structure/closet/crate/freezer/food

/datum/supply_pack/service/randomized/donkpockets/fill(obj/container)
	for(var/i in 1 to 3)
		var/item = pick(contains)
		new item(container)

/datum/supply_pack/service/randomized/ready_donk
	name = "咚克即食餐混合箱"
	desc = "收录咚克公司最受粉丝欢迎的微波餐阵容！内含 \
		随机搭配的咚克即食餐产品。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/food/ready_donk,
					/obj/item/food/ready_donk/mac_n_cheese,
					/obj/item/food/ready_donk/donkhiladas,
					/obj/item/food/ready_donk/nachos_grandes,
					/obj/item/food/ready_donk/donkrange_chicken,
					/obj/item/food/ready_donk/salisbury_steak,
					/obj/item/food/ready_donk/country_chicken,
				)
	crate_name = "\improper 咚克即食餐箱"
	crate_type = /obj/structure/closet/crate/freezer/donk
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/datum/supply_pack/service/randomized/ready_donk/fill(obj/container)
	for(var/i in 1 to 3)
		var/item = pick(contains)
		new item(container)

/datum/supply_pack/service/coffeekit
	name = "咖啡设备箱"
	desc = "用来开设你自己温馨咖啡店的整套装备，但出于某种原因不含咖啡机。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/storage/box/coffeepack/robusta,
		/obj/item/storage/box/coffeepack,
		/obj/item/reagent_containers/cup/coffeepot,
		/obj/item/storage/fancy/coffee_condi_display,
		/obj/item/reagent_containers/cup/glass/bottle/juice/cream,
		/obj/item/reagent_containers/condiment/milk,
		/obj/item/reagent_containers/condiment/soymilk,
		/obj/item/reagent_containers/condiment/sugar,
		/obj/item/reagent_containers/cup/bottle/syrup_bottle/caramel, //one extra syrup as a treat
	)
	crate_name = "咖啡设备箱"
	crate_type = /obj/structure/closet/crate/robust
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/datum/supply_pack/service/coffeemaker
	name = "印普瑞莎咖啡机箱"
	desc = "一台组装好的印普瑞莎型号咖啡机。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/machinery/coffeemaker/impressa)
	crate_name = "咖啡机箱"
	crate_type = /obj/structure/closet/crate/large
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/// Spare bar sign wallmount
/datum/supply_pack/service/bar_sign
	name = "酒吧招牌替换套件"
	desc = "一块替换用酒吧招牌，完美吸引顾客光顾你的酒吧、酒馆、旅店、夜总会，甚至咖啡馆！"
	cost = CARGO_CRATE_VALUE * 14
	contains = list(/obj/item/wallframe/barsign/all_access)
	crate_name = "酒吧招牌箱"
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/service/bowmaking
	name = "制箭与制弓入门套装"
	desc = "一本相当过时的《削出个名堂：现代太空人的制箭指南》，外加一些实用材料。\
		想入门制弓，或让自己的实演角色扮演更锋利一点，选它准没错。书中还附有 \
		小提琴制作说明。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/book/granter/crafting_recipe/fletching = 1,
		/obj/item/stack/sheet/mineral/wood = 10,
		/obj/item/stack/sheet/cloth = 10,
	)
	crate_name = "制弓入门套装箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/service/mousetraps
	name = "灭虫灵捕鼠夹"
	desc = "三盒便捷的小型弹簧夹，用来捕捉恼人的鼠类。请置于儿童接触不到的地方！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/storage/box/mousetraps = 3)
	crate_name = "捕鼠夹箱"

/datum/supply_pack/service/boombox
	name = "MC 入门套装与手提音响"
	desc = "一台顶级的纳米音乐牌手提音响。\
		可播放专用音乐磁带，供你甚至同事们欣赏。附赠一盒试听磁带。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/boombox = 1,
		/obj/item/music_tape = 1,
	)
	crate_name = "手提音响箱"
