/// Cost of the crate. DO NOT GO ANY LOWER THAN X1.4 the "CARGO_CRATE_VALUE" value if using regular crates, or infinite profit will be possible!

/*
*	LIVESTOCK
*/

/datum/supply_pack/critter/doublecrab
	name = "螃蟹板条箱"
	desc = "内含两只螃蟹。来点螃蟹吧！"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/mob/living/basic/crab,
		/mob/living/basic/crab,
	)
	crate_name = "看哪长官，免费螃蟹"

/datum/supply_pack/critter/mouse
	name = "老鼠板条箱"
	desc = "适合各个年龄段的蛇与蜥蜴。内含六只饲料鼠。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/mob/living/basic/mouse,
	)
	crate_name = "老鼠箱"

/datum/supply_pack/critter/mouse/generate(crate_override)
	. = ..()
	for(var/i in 1 to 5)
		new /mob/living/basic/mouse(.)

/datum/supply_pack/critter/chinchilla
	name = "龙猫板条箱"
	desc = "内含四只龙猫。不含浴沙。"
	cost = CARGO_CRATE_VALUE * 7
	contains = list(
		/mob/living/basic/pet/chinchilla,
	)
	crate_name = "龙猫箱"

/datum/supply_pack/critter/chinchilla/generate(crate_override)
	. = ..()
	for(var/i in 1 to 3)
		new /mob/living/basic/pet/chinchilla(.)


/datum/supply_pack/critter/fennec
	name = "耳廓狐板条箱"
	desc = "当你需要一个真正会听你说话的对象时。 \
		内含两只耳廓狐。 \
		警告：这并不代表耳廓狐真的会听你的话。"
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/mob/living/basic/pet/cat/fennec = 2)
	crate_name = "耳廓狐箱"

/datum/supply_pack/critter/pitbull/pimpy
	name = "纯种种犬比特犬板条箱"
	desc = "内含三只比特犬。经公牛山山顶认证为纯种种犬。"
	cost = CARGO_CRATE_VALUE * 9
	contains = list(
		/mob/living/basic/pet/dog/pitbull,
	)
	crate_name = "纯种种犬比特犬箱"

/datum/supply_pack/critter/pitbull/generate(crate_override)
	. = ..()
	for(var/i in 1 to 3)
		new /mob/living/basic/pet/dog/pitbull(.)

/datum/supply_pack/critter/redpanda
	name = "小熊猫板条箱"
	desc = "你的空间站需要多一点“哇”？更多红尾巴？订购这个吧。你永远逃不出你的悲伤。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/mob/living/basic/pet/fox/redpanda,
		/mob/living/basic/pet/fox/redpanda,
	)
	crate_name = "哇箱"

/*
*	MEDICAL
*/

/datum/supply_pack/medical/anesthetics
	name = "麻醉剂板条箱"
	desc = "内含以下各两件：吗啡瓶、注射器、呼吸面罩和麻醉气罐。需要医疗权限才能打开。"
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/reagent_containers/cup/bottle/morphine,
		/obj/item/reagent_containers/cup/bottle/morphine,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/syringe,
		/obj/item/clothing/mask/breath,
		/obj/item/clothing/mask/breath,
		/obj/item/tank/internals/anesthetic,
		/obj/item/tank/internals/anesthetic,
	)
	crate_name = "麻醉剂箱"

/datum/supply_pack/medical/bodybags
	name = "尸体袋"
	desc = "适合尸体躺满地的时候。内含 4 盒尸体袋。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(
		/obj/item/storage/box/bodybags,
		/obj/item/storage/box/bodybags,
		/obj/item/storage/box/bodybags,
		/obj/item/storage/box/bodybags,
	)
	crate_name = "尸体袋箱"

/datum/supply_pack/medical/firstaidmixed
	name = "混合医疗包"
	desc = "内含各类医疗包各一个，可应对各种受伤的船员。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/storage/medkit/toxin,
		/obj/item/storage/medkit/o2,
		/obj/item/storage/medkit/brute,
		/obj/item/storage/medkit/fire,
		/obj/item/storage/medkit/regular,
	)
	crate_name = "医疗包箱"

/datum/supply_pack/medical/medipens
	name = "肾上腺素注射笔"
	desc = "内含两盒肾上腺素注射笔。每盒七支。"
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(
		/obj/item/storage/box/medipens,
		/obj/item/storage/box/medipens,
	)
	crate_name = "注射笔箱"

/datum/supply_pack/medical/modsuit_medical
	name = "医疗 MOD 外骨骼板条箱"
	desc = "内含一套按医疗标准规格制造的 MOD 外骨骼。"
	cost = CARGO_CRATE_VALUE * 13
	access = ACCESS_MEDICAL
	contains = list(/obj/item/mod/control/pre_equipped/medical)
	crate_name = "医疗 MOD 外骨骼箱"
	crate_type = /obj/structure/closet/crate/secure //No medical varient with security locks.

/datum/supply_pack/medical/compact_defib
	name = "便携除颤器板条箱"
	desc = "内含一台便携除颤器。可像腰带一样佩戴。"
	cost = CARGO_CRATE_VALUE * 5
	access = ACCESS_MEDICAL
	contains = list(/obj/item/defibrillator/compact)
	crate_name = "便携除颤器箱"

/datum/supply_pack/medical/medigun
	name = "CWM-479 医疗枪"
	desc = "内含一把 VeyMedical 出品的 CWM-479 型医疗枪；不含电池。"
	cost = CARGO_CRATE_VALUE * 30
	access = ACCESS_MEDICAL
	contains = list(/obj/item/storage/briefcase/medicalgunset/standard)
	crate_name = "CWM-479 医疗枪箱"

/datum/supply_pack/medical/medicells
	name = "医疗电池替换板条箱"
	desc = "内含 I 级医疗枪电池。"
	cost = CARGO_CRATE_VALUE * 5
	access = ACCESS_MEDICAL
	contains = list(
		/obj/item/weaponcell/medical/tier_1/brute,
		/obj/item/weaponcell/medical/tier_1/burn,
		/obj/item/weaponcell/medical/tier_1/toxin,
	)
	crate_name = "医疗电池替换箱"

/*
*	SECURITY
*/

/datum/supply_pack/security/MODsuit_security
	name = "安保 MOD 外骨骼板条箱"
	desc = "内含一套加装装甲、按安保标准规格制造的 MOD 外骨骼。"
	cost = CARGO_CRATE_VALUE * 16
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/mod/control/pre_equipped/security)
	crate_name = "安保 MOD 外骨骼箱"

/datum/supply_pack/security/armor_skyrat
	name = "护甲板条箱"
	desc = "三件防护均衡、防护性尚可的护甲背心。"
	cost = CARGO_CRATE_VALUE * 2.5
	access_view = ACCESS_SECURITY
	contains = list(
		/obj/item/clothing/suit/armor/vest/alt,
		/obj/item/clothing/suit/armor/vest/alt,
		/obj/item/clothing/suit/armor/vest/alt,
	)
	crate_name = "护甲箱"

/datum/supply_pack/security/helmets_skyrat
	name = "头盔板条箱"
	desc = "内含三个标准配发头盔。"
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/clothing/head/helmet/sec = 3)
	crate_name = "头盔箱"

/datum/supply_pack/security/deployablebarricades
	name = "C.U.C.K.S 可部署路障"
	desc = "两箱可部署路障，满足你所有的筑防需求。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/storage/barricade,
		/obj/item/storage/barricade,
	)
	crate_name = "C.U.C.K.S 箱"

/*
*	ENGINEERING
*/

/datum/supply_pack/engineering/material_pouches
	name = "材料袋板条箱"
	desc = "内含三个材料袋。"
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(
		/obj/item/storage/pouch/material,
		/obj/item/storage/pouch/material,
		/obj/item/storage/pouch/material,
	)
	cost = CARGO_CRATE_VALUE * 15
	crate_name = "材料袋箱"

/datum/supply_pack/engineering/doublecap_tanks
	name = "双倍延长应急气罐板条箱"
	desc = "内含四个双倍延长容量的应急气罐。"
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(
		/obj/item/tank/internals/emergency_oxygen/double,
		/obj/item/tank/internals/emergency_oxygen/double,
		/obj/item/tank/internals/emergency_oxygen/double,
		/obj/item/tank/internals/emergency_oxygen/double,
	)
	cost = CARGO_CRATE_VALUE * 15
	crate_name = "双倍延长应急气罐箱"

/datum/supply_pack/engineering/advanced_extinguisher
	name = "高级泡沫灭火器板条箱"
	desc = "内含以泡沫为灭火剂的高级灭火器。"
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(
		/obj/item/extinguisher/advanced,
		/obj/item/extinguisher/advanced,
		/obj/item/extinguisher/advanced,
	)
	cost = CARGO_CRATE_VALUE * 18
	crate_name = "高级灭火器箱"

/datum/supply_pack/engineering/modsuit_engineering
	name = "工程 MOD 外骨骼板条箱"
	desc = "内含一套按工程标准规格制造的 MOD 外骨骼。"
	access = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/mod/control/pre_equipped/engineering)
	cost = CARGO_CRATE_VALUE * 13
	crate_name = "工程 MOD 外骨骼箱"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/engineering/modsuit_atmospherics
	name = "大气 MOD 外骨骼板条箱"
	desc = "内含一套按大气标准规格制造的 MOD 外骨骼。"
	access = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/mod/control/pre_equipped/atmospheric)
	cost = CARGO_CRATE_VALUE * 16
	crate_name = "大气 MOD 外骨骼箱"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/engineering/engi_inducers
	name = "NT-150 工业感应充电器板条箱"
	desc = "作为 NT-75 EPI 的改进型号，NT-150 的充电速度提升一倍，并配有改进型电池。内含两台工程规格的感应充电器。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/obj/item/inducer,
		/obj/item/inducer,
	)
	crate_name = "工程感应充电器箱"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engineering/gas_miner
	name = "气体采集器投送信标板条箱"
	desc = "内含一个气体采集器投送信标，可订购一台气体采集器。"
	access = ACCESS_ATMOSPHERICS
	contains = list(/obj/item/summon_beacon/gas_miner)
	cost = CARGO_CRATE_VALUE * 50
	crate_name = "气体采集器投送信标箱"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/engineering/improved_rcd
	name = "改进型快速建造装置板条箱"
	desc = "内含 3 台升级版快速建造装置，拥有更出色的材料储量。每台还附赠框架与电路升级！"
	access = ACCESS_ENGINE_EQUIP
	cost = CARGO_CRATE_VALUE * 18
	contains = list(
		/obj/item/construction/rcd/improved,
		/obj/item/construction/rcd/improved,
		/obj/item/construction/rcd/improved,
	)
	crate_name = "改进型快速建造装置箱"
	crate_type = /obj/structure/closet/crate/secure/engineering

/*
*	MISC
*/

/datum/supply_pack/misc/speedbike //If you see this bought in game, its time to nerf a cargo exploit.
	name = "极速摩托"
	desc = "戴上墨镜，跨上坐垫，骑着这台涡轮豪华太空巡航极速摩托直奔太阳而去。"
	cost = 1000000 //Special case, we don't want to make this in terms of crates because having bikes be a million credits is the whole meme.
	contains = list(/obj/vehicle/ridden/speedbike)
	crate_name = "极速摩托箱"

/datum/supply_pack/misc/painting
	name = "高级美术用品"
	desc = "用这些高级美术用品激发你的艺术灵感。内含上色工具、画布用布料，以及两个可供创作的画架！"
	cost = CARGO_CRATE_VALUE * 2.2
	contains = list(
		/obj/structure/easel,
		/obj/structure/easel,
		/obj/item/toy/crayon/spraycan,
		/obj/item/toy/crayon/spraycan,
		/obj/item/storage/crayons,
		/obj/item/storage/crayons,
		/obj/item/toy/crayon/white,
		/obj/item/toy/crayon/white,
		/obj/item/toy/crayon/rainbow,
		/obj/item/toy/crayon/rainbow,
		/obj/item/stack/sheet/cloth/ten,
		/obj/item/stack/sheet/cloth/ten,
	)
	crate_name = "高级美术用品"

/datum/supply_pack/service/paintcan
	name = "自适应油漆罐"
	desc = "用这罐实验性变色油漆给万物添上一抹色彩！卖家提醒：若你因使用本产品而被愤怒的清洁工、安保人员或其他船员私刑，我们概不负责。"
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/paint/anycolor)

/datum/supply_pack/misc/coloredsheets
	name = "床单板条箱"
	desc = "用这箱床单给你的夜生活添点色彩！共含九条不同颜色的床单。"
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(
		/obj/item/bedsheet/blue,
		/obj/item/bedsheet/green,
		/obj/item/bedsheet/orange,
		/obj/item/bedsheet/purple,
		/obj/item/bedsheet/red,
		/obj/item/bedsheet/yellow,
		/obj/item/bedsheet/brown,
		/obj/item/bedsheet/black,
		/obj/item/bedsheet/rainbow,
	)
	crate_name = "彩色床单箱"

/datum/supply_pack/misc/candles
	name = "蜡烛板条箱"
	desc = "用这些多余的蜡烛和蜡笔安排一顿浪漫晚餐，或举办一场降神会。"
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/storage/fancy/candle_box,
		/obj/item/storage/fancy/candle_box,
		/obj/item/storage/box/matches,
	)
	crate_name = "蜡烛箱"

/datum/supply_pack/misc/vanguard_surplus
	name = "远征军剩余物资"
	desc = "内含来自现已解散的先锋远征军的各类剩余装备。"
	cost = CARGO_CRATE_VALUE * 19
	contains = list(
		/obj/item/storage/box/expeditionary_survival,
		/obj/item/melee/tomahawk,
		/obj/item/storage/backpack/duffelbag/expeditionary_corps,
		/obj/item/clothing/gloves/color/black/expeditionary_corps,
		/obj/item/clothing/head/helmet/expeditionary_corps,
		/obj/item/clothing/suit/armor/vest/expeditionary_corps,
		/obj/item/storage/belt/military/expeditionary_corps,
		/obj/item/clothing/under/rank/expeditionary_corps,
		/obj/item/clothing/shoes/combat/expeditionary_corps,
		/obj/item/modular_computer/pda/expeditionary_corps,
		/obj/item/knife/combat/marksman,
	)
	/// How many of the contains to put in the crate
	var/num_contained = 3

/datum/supply_pack/misc/vanguard_surplus/fill(obj/structure/closet/crate/filled_crate)
	var/list/contain_copy = contains.Copy()
	for(var/i in 1 to num_contained)
		var/item = pick_n_take(contain_copy)
		new item(filled_crate)

/datum/supply_pack/misc/gravity_harness
	name = "重力悬挂背带"
	desc = "一种背挂式悬吊背带，由电池供电，由深空部落设计，可抵消或增强重力。 \
		虽然它只是斯克雷尔人所用个人重力引擎的廉价仿制品，但这一件加装了绑带和一个基础储存模块。"
	cost = CARGO_CRATE_VALUE * 6 // 1200 credits
	contains = list(/obj/item/gravity_harness)

/*
*	FOOD
*/

/datum/supply_pack/organic/combomeal
	name = "汉堡套餐板条箱"
	desc = "在油腻铁板餐厅，我们非常重视顾客，重视到愿意专门为你配送。内含两份套餐，每份包括一个汉堡、一份薯条和一包鸡块！"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/food/burger/cheese,
		/obj/item/food/burger/cheese,
		/obj/item/food/fries,
		/obj/item/food/fries,
		/obj/item/storage/fancy/nugget_box,
		/obj/item/storage/fancy/nugget_box,
	)
	crate_name = "汉堡与鸡块套餐"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/organic/fiestatortilla
	name = "嘉年华板条箱"
	desc = "用这份嘉年华主题食材给厨房添点辣味！内含 8 份玉米饼类食物和一些辣酱。"
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(
		/obj/item/food/taco,
		/obj/item/food/taco,
		/obj/item/food/taco/plain,
		/obj/item/food/taco/plain,
		/obj/item/food/enchiladas,
		/obj/item/food/enchiladas,
		/obj/item/food/carneburrito,
		/obj/item/food/cheesyburrito,
		/obj/item/reagent_containers/cup/bottle/capsaicin,
	)
	crate_name = "嘉年华箱"

/datum/supply_pack/organic/fakemeat
	name = "肉类板条箱“合成”"
	desc = "肉这么快就吃完了？用这台装满无残酷化学合成肉的冷冻箱让蜥蜴人们满意吧！内含 12 块肉制品和 4 块*鲤鱼*肉。"
	cost = CARGO_CRATE_VALUE * 2.25
	contains = list(
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/fishmeat/carp/imitation,
		/obj/item/food/fishmeat/carp/imitation,
		/obj/item/food/fishmeat/carp/imitation,
		/obj/item/food/fishmeat/carp/imitation,
	)
	crate_name = "肉箱"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/mixedboxes
	name = "混合食材盒"
	desc = "订购这些惊喜食材盒，让灵感把你淹没！共四盒，装满各式各样的产品！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(
		/obj/item/storage/box/ingredients/wildcard,
		/obj/item/storage/box/ingredients/wildcard,
		/obj/item/storage/box/ingredients/wildcard,
		/obj/item/storage/box/ingredients/wildcard,
	)
	crate_name = "随机食材箱"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/fcsurplus
	name = "精致料理精选超值包"
	desc = "吃腻了厨师的糊糊？有长翅膀又难伺候的船员？还是你只想沉溺于奶酪凝块那种罪恶的美味？我们工会里最出色的师傅为你打造了这个包，内含多种优质油、醋和格外稀有的食材。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/jellyfish,
		/obj/item/food/canned/desert_snails,
		/obj/item/food/canned/larvae,
		/obj/item/food/moonfish_eggs,
	)
	crate_name = "精致料理精选包"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/qualityoilbulk
	name = "优质食用油整箱装"
	desc = "普通食用油不够用？厨师觉得好笑，把好油全倒进油锅了？别担心，我们为你准备了整箱十（10）瓶最优质的油，调和得在冷食配方中风味绝佳，且烹调时不易发苦。"
	cost = CARGO_CRATE_VALUE * 9
	contains = list(
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
	)
	crate_name = "优质食用油整箱装"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/vinegarbulk
	name = "食醋整箱装"
	desc = "蛾族料理之夜？有翅膀的朋友们靠港了？我们会让你马上开火做饭。本箱十（10）瓶食醋由数种醇厚葡萄酒精制而成，酸度恰到好处，最适合调制完美的沙拉汁与酱料。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
	)
	crate_name = "食醋整箱装"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/bulkcanmoff
	name = "蛾族罐头整箱装"
	desc = "想试试做青酱和酱汁？没法自己种也没法自己装罐？没关系，不用担心，这里有五（5）罐番茄和松子，帮你照顾好长翅膀的朋友。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/pine_nuts,
	)
	crate_name = "蛾族罐头整箱装"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/bulkcanliz
	name = "蜥蜴人佳品整箱装"
	desc = "口味有点刁钻？你的鳞片朋友想要点不是油炸神秘肉的东西？只差一次订购就能完美讨好对方。内含三（3）罐我们最优质来源的水母、蜗牛和蜂幼虫罐头，另外还有三（3）包无残酷月鱼鱼子，也许能赢得他们的心。"
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(
		/obj/item/food/canned/jellyfish,
		/obj/item/food/canned/jellyfish,
		/obj/item/food/canned/jellyfish,
		/obj/item/food/canned/desert_snails,
		/obj/item/food/canned/desert_snails,
		/obj/item/food/canned/desert_snails,
		/obj/item/food/moonfish_eggs,
		/obj/item/food/moonfish_eggs,
		/obj/item/food/moonfish_eggs,
		/obj/item/food/canned/larvae,
		/obj/item/food/canned/larvae,
		/obj/item/food/canned/larvae,
	)
	crate_name = "蜥蜴人整箱装"
	crate_type = /obj/structure/closet/crate/freezer

/*
*	Service
*/

/datum/supply_pack/service/buildabar
	name = "自建酒吧板条箱"
	desc = "想开设自己的小小避风港？用这套便捷套装抢先起步。内含酒吧设备电路板、一些部件和基础调酒用品。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/storage/box/drinkingglasses = 3,
		/obj/item/stack/sheet/iron = 25,
		/obj/item/stack/sheet/glass = 4,
		/obj/item/stock_parts/power_store/cell/high = 2,
		/obj/item/reagent_containers/cup/beaker = 2,
		/obj/item/storage/part_replacer/cargo,
		/obj/item/stack/cable_coil,
		/obj/item/book/manual/wiki/barman_recipes,
		/obj/item/reagent_containers/cup/glass/shaker,
		/obj/item/circuitboard/machine/chem_dispenser/drinks/beer,
		/obj/item/circuitboard/machine/chem_dispenser/drinks,
		/obj/item/circuitboard/machine/chem_master/condi,
		/obj/item/circuitboard/machine/dish_drive,
		/obj/item/circuitboard/machine/vendor,
		/obj/item/vending_refill/boozeomat,
		/obj/item/screwdriver,
		/obj/item/wrench,
	)
	crate_name = "自建酒吧箱"

/datum/supply_pack/service/janitor/janpimp
	name = "清洁巡逻车"
	desc = "小丑偷了你的车？助手把它锁在宿舍里？订购一台新的，继续有格调地打扫吧！"
	cost = CARGO_CRATE_VALUE * 4
	access = ACCESS_JANITOR
	contains = list(
		/obj/vehicle/ridden/janicart,
		/obj/item/key/janitor,
	)
	crate_name = "清洁车箱"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/service/janitor/janpimpkey
	name = "巡逻车钥匙"
	desc = "清洁巡逻车的备用钥匙。"
	cost = CARGO_CRATE_VALUE * 1.5
	access = ACCESS_JANITOR
	contains = list(/obj/item/key/janitor)
	crate_name = "钥匙箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/service/janitor/janpremium
	name = "清洁工用品（高级）"
	desc = "当污渍大到拖把无能为力时使用。内含数枚清洁手榴弹、几瓶备用氨水、两块肥皂，以及一枚 MCE（巨型清洁炸药）。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/obj/item/soap/nanotrasen,
		/obj/item/soap/nanotrasen,
		/obj/item/grenade/clusterbuster/cleaner,
		/obj/item/grenade/chem_grenade/cleaner,
		/obj/item/grenade/chem_grenade/cleaner,
		/obj/item/grenade/chem_grenade/cleaner,
		/obj/item/reagent_containers/cup/bottle/ammonia,
		/obj/item/reagent_containers/cup/bottle/ammonia,
		/obj/item/reagent_containers/cup/bottle/ammonia,
	)
	crate_name = "高级清洁用品箱"

/datum/supply_pack/service/lamplight
	name = "灯具板条箱"
	desc = "遇到电压不稳？全站熄灯？用这套四盏台灯加手电筒照亮一切吧。"
	cost = CARGO_CRATE_VALUE * 1.75
	contains = list(
		/obj/item/flashlight/lamp,
		/obj/item/flashlight/lamp,
		/obj/item/flashlight/lamp/green,
		/obj/item/flashlight/lamp/green,
		/obj/item/flashlight,
		/obj/item/flashlight,
		/obj/item/flashlight,
		/obj/item/flashlight,
	)
	crate_name = "灯具箱"

/datum/supply_pack/service/medieval
	name = "正宗文艺复兴集市板条箱"
	desc = "内含两套正宗盔甲、若干剑，以及给躲在后面的胆小鬼准备的两把弓和胸甲。"
	cost = CARGO_CRATE_VALUE * 30
	order_flags = ORDER_CONTRABAND
	contains = list(
		/obj/item/clothing/suit/armor/riot/knight/larp/red,
		/obj/item/clothing/gloves/plate/larp/red,
		/obj/item/clothing/head/helmet/knight/red,
		/obj/item/clothing/shoes/plate/larp/red,
		/obj/item/claymore/weak/weaker,
		/obj/item/clothing/shoes/plate/larp/blue,
		/obj/item/clothing/suit/armor/riot/knight/larp/blue,
		/obj/item/clothing/gloves/plate/larp/blue,
		/obj/item/clothing/head/helmet/knight/blue,
		/obj/item/claymore/weak/weaker,
		/obj/item/clothing/suit/armor/vest/cuirass/larp,
		/obj/item/clothing/suit/armor/vest/cuirass/larp,
		/obj/item/gun/ballistic/bow/longbow,
		/obj/item/gun/ballistic/bow/longbow,
		/obj/item/storage/bag/quiver/full,
		/obj/item/storage/bag/quiver/full,
		/obj/item/clothing/head/helmet/knight/red,
		/obj/item/clothing/head/helmet/knight/blue,
		/obj/item/food/bread/plain,
	)
	crate_name = "复古箱"

/datum/supply_pack/organic/lavalandsamples
	name = "行星植物样本"
	desc = "一箱采自熔岩地表的样本。需要水培权限才能打开。"
	cost = CARGO_CRATE_VALUE * 36 // unfortunately these sell for a lot and we can't have an infinite money exploit
	access_view = ACCESS_HYDROPONICS
	contains = list(
		/obj/item/seeds/lavaland/polypore,
		/obj/item/seeds/lavaland/porcini,
		/obj/item/seeds/lavaland/inocybe,
		/obj/item/seeds/lavaland/ember,
		/obj/item/seeds/lavaland/seraka,
		/obj/item/seeds/lavaland/fireblossom,
		/obj/item/seeds/lavaland/cactus,
	)
	crate_name = "行星种子箱"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/service/MODsuit_cargo
	name = "货运装卸型 MOD 外骨骼板条箱"
	desc = "内含一套四臂 MOD 外骨骼，按货运标准规格制造。"
	cost = CARGO_CRATE_VALUE * 13
	access_view = ACCESS_CARGO
	contains = list(/obj/item/mod/control/pre_equipped/loader)
	crate_name = "货运 MOD 外骨骼箱"

/datum/supply_pack/service/snowmobile
	name = "雪地摩托套装"
	desc = "被困在苦寒荒野？需要快速移动？购买一台翻新雪地摩托，附赠 10 微秒免费保修！"
	cost = CARGO_CRATE_VALUE * 7.5
	contains = list(
		/obj/vehicle/ridden/atv/snowmobile = 1,
		/obj/item/key/atv = 1,
		/obj/item/clothing/mask/gas/explorer = 1,
	)
	crate_name = "雪地摩托套装"
	crate_type = /obj/structure/closet/crate/large

/*
*	MATERIALS AND SHEETS
*/

/datum/supply_pack/materials/rawlumber
	name = "20 根塔盖菇原木"
	desc = "用这些绝妙的塔盖菇木料办一场野炊，或在海边点起一堆有格调的篝火！"
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(/obj/item/grown/log)
	crate_name = "原木箱"

/datum/supply_pack/materials/rawlumber/generate(crate_override)
	. = ..()
	for(var/i in 1 to 19)
		new /obj/item/grown/log(.)

/datum/supply_pack/imports/cin_surplus
	name = "独立国家联盟军事剩余物资板条箱"
	desc = "一批来自独立国家联盟军事库存的剩余装备。很可能包含老旧过时的装备——剩余物资本就如此。"
	order_flags = ORDER_CONTRABAND
	cost = CARGO_CRATE_VALUE * 9
	contains = list(
		/obj/item/storage/box/colonial_rations = 1,
		/obj/item/storage/toolbox/ammobox/strilka310 = 1,
		/obj/item/storage/toolbox/ammobox/strilka310/surplus = 1,
		/obj/item/gun_maintenance_supplies = 1,
		/obj/item/storage/toolbox/guncase/soviet/sakhno = 2,
		/obj/item/ammo_box/speedloader/strilka310 = 1,
		/obj/item/clothing/suit/armor/vest/cin_surplus_vest = 1,
		/obj/item/clothing/head/helmet/cin_surplus_helmet/random_color = 1,
		/obj/item/storage/backpack/industrial/cin_surplus/random_color = 1,
		/obj/item/storage/belt/military/cin_surplus/random_color = 1,
		/obj/item/clothing/gloves/tackler/combat = 1,
		/obj/item/clothing/under/syndicate/rus_army/cin_surplus/random_color = 1,
		/obj/item/clothing/shoes/jackboots = 1,
		/obj/item/clothing/mask/gas/hecu2 = 1,
		/obj/item/clothing/mask/balaclavaadjust = 1,
	)

/datum/supply_pack/imports/cin_surplus/fill(obj/structure/closet/crate/we_are_filling_this_crate)
	for(var/i in 1 to 10)
		var/item = pick_weight(contains)
		new item(we_are_filling_this_crate)

/*
* VENDING RESTOCKS
*/

/datum/supply_pack/vending/dorms
	name = "LustWish 用品箱"
	desc = "此箱内含 LustWish 自动售货机的一次补充装。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/vending_refill/lustwish)

/datum/supply_pack/vending/barber
	name = "Fab-O-Vend 用品箱"
	desc = "内含 Fab-O-Vend 的一次补货，非常适合那些对自己的造型犹豫不决的人。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/vending_refill/barbervend)
