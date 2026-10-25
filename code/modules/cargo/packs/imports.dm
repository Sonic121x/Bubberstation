/**
 * Imports category.
 * This is for crates not intended for goodies, but also not intended for departmental orders.
 * This allows us to have a few crates meant for deliberate purchase through cargo, and for cargo to have a few items
 * they explicitly control. It also holds all of the black market material and contraband material, including items
 * meant for purchase only through emagging the console.
 */

/datum/supply_pack/imports
	group = "Imports"
	crate_name = "应急板条箱"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/imports/foamforce
	name = "泡沫特勤板条箱"
	desc = "拿出大杀器：八把泡沫特勤霰弹枪！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/gun/ballistic/shotgun/toy = 8)
	crate_name = "泡沫特勤板条箱"
	crate_type = /obj/structure/closet/crate/freezer/donk
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/imports/foamforce/bonus
	name = "泡沫特勤手枪板条箱"
	desc = "嘘……嘿兄弟……还记得那些因为太酷而停产的老款泡沫特勤手枪吗？ \
		我这儿正好有两把，上面还刻着你的名字。我甚至给每把再送一个备用弹匣，怎么样？"
	order_flags = ORDER_CONTRABAND
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/toy = 2,
		/obj/item/ammo_box/magazine/toy/pistol = 2,
	)
	crate_name = "泡沫特勤板条箱"
	crate_type = /obj/structure/closet/crate/freezer/donk

/datum/supply_pack/imports/meatmeatmeatmeat // MEAT MEAT MEAT MEAT
	name = "肉 肉 肉 肉 肉"
	desc = "肉 肉 肉 肉 肉 肉"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/storage/backpack/meat)
	crate_name = "肉 肉 肉 肉 肉"
	crate_type = /obj/structure/closet/crate/necropolis
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/imports/duct_spider
	name = "管道蜘蛛板条箱"
	desc = "哇！直接从澳斯特拉利库斯星区送到你空间站的通风系统！"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/mob/living/basic/spider/maintenance)
	crate_name = "管道蜘蛛板条箱"
	crate_type = /obj/structure/closet/crate/critter
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

/datum/supply_pack/imports/duct_spider/dangerous
	name = "管道蜘蛛板条箱？"
	desc = "等等，这是对的箱子吗？上面有个苦脸，那是什么意思？"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/mob/living/basic/spider/giant/hunter)
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/imports/bamboo50
	name = "50 根竹插条"
	desc = "你根本不知道我们为了弄到这些竹子杀了多少只熊猫。"
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/stack/sheet/mineral/bamboo/fifty)
	crate_name = "竹插条板条箱"

/datum/supply_pack/imports/wind_turbine
	name = "风力涡轮机板条箱"
	desc = "内含一台便携式风力涡轮机，可为小型设备和电器充电。在边区被视为过时， \
		但对于那些认为绕站走路就是“创新工程”的军官来说再合适不过。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/portable_wind_turbine/loaded)
	crate_name = "风力涡轮机板条箱"

/datum/supply_pack/imports/bananium
	name = "单张香蕉矿"
	desc = "别让小丑知道他能订购这个。就这么点也要花一大笔钱。"
	cost = CARGO_CRATE_VALUE * 100
	contains = list(/obj/item/stack/sheet/mineral/bananium)
	crate_name = "香蕉矿板条箱"
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/imports/dumpstercorpse
	name = "一个……垃圾箱？"
	desc = "为什么它这么臭……"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/mob/living/carbon/human)
	crate_name = "腐臭垃圾箱"
	crate_type = /obj/structure/closet/crate/trashcart

/datum/supply_pack/imports/dumpstercorpse/generate(atom/A, datum/bank_account/paying_account, crate_override)
	. = ..()
	var/mob/living/carbon/human/corpse = locate() in .
	corpse.death()

/datum/supply_pack/imports/dumpsterloot
	name = "一个……垃圾箱"
	desc = "我不确定你为什么要费心买这个……还有它为什么这么贵？"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/effect/spawner/random/maintenance/dumpster,
		/obj/effect/spawner/random/trash/garbage = 5,
	)
	crate_name = "腐臭垃圾箱"
	crate_type = /obj/structure/closet/crate/trashcart
	test_ignored = TRUE

/datum/supply_pack/imports/shells
	name = "致命霰弹盒板条箱"
	desc = "内含三盒鹿弹霰弹。 \
		由于纳米传讯在顺旋狩猎与射击政策听证会期间 \
		未能取得独家生产权，这批进口货 \
		尽管“合法”，却被课以重税。希望这个价签值这个钱。"
	cost = CARGO_CRATE_VALUE * 10
	access = ACCESS_ARMORY
	access_view = ACCESS_ARMORY
	contains = list(
		/obj/item/storage/box/lethalshot = 3,
	)
	crate_name = "霰弹板条箱"
	crate_type = /obj/structure/closet/crate/secure/weapon

/datum/supply_pack/imports/error
	name = "NULL_ENTRY"
	desc = "(*!&@#好吧，特工，我们看到你在炫富了。行。拿去这个吧，祝你能把它拼装起来！#@*$"
	cost = CARGO_CRATE_VALUE * 100
	order_flags = ORDER_EMAG_ONLY
	contains = list(/obj/item/book/granter/crafting_recipe/regal_condor)

/datum/supply_pack/imports/mafia
	name = "黑手党入门包"
	desc = "这个板条箱里有你开展自己的族裔式敲诈勒索生意所需的一切。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list()
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/imports/mafia/fill(obj/structure/closet/crate/our_crate)
	for(var/items in 1 to 4)
		new /obj/effect/spawner/random/clothing/mafia_outfit(our_crate)
		new /obj/item/virgin_mary(our_crate)
		if(prob(30)) //Not all mafioso have mustaches, some people also find this item annoying.
			new /obj/item/clothing/mask/fakemoustache/italian(our_crate)
	if(prob(10)) //A little extra sugar every now and then to shake things up.
		new /obj/item/switchblade(our_crate)

/datum/supply_pack/imports/contraband
	name = "“违禁品”板条箱"
	desc = "嘘……兄弟……想要点违禁品吗？我能给你弄到海报、好烟、大麻，甚至一些 \
		赞助商品……你懂的，好东西。只要别让警察看见，行吗？"
	order_flags = ORDER_CONTRABAND
	cost = CARGO_CRATE_VALUE * 20
	contains = list(
		/obj/effect/spawner/random/contraband = 5,
	)
	crate_name = "板条箱"
	test_ignored = TRUE

/datum/supply_pack/imports/wt550
	name = "走私 WT-550 自动步枪板条箱"
	desc = "(*!&@#好消息，特工！我们搞不到顶级自动武器。但是，\
		通过把这只箱子走私过几个过时的海关检查站，我们弄到了次优选择！ \
		制式自动步枪。别担心，那些枪会把你熔化的传闻就只是传闻！ \
		这些东西好用得很！可能稍微有点脏。！#@*$"
	order_flags = ORDER_EMAG_ONLY
	cost = CARGO_CRATE_VALUE * 7
	contains = list(
		/obj/item/gun/ballistic/automatic/wt550 = 2,
		/obj/item/ammo_box/magazine/wt550m9 = 2,
	)
	crate_type = /obj/structure/closet/crate/secure/syndicate/gorlex/weapons/bustedlock

/datum/supply_pack/imports/wt550ammo
	name = "走私 WT-550 弹药板条箱"
	desc = "(*!&@#特工，你喜欢那把 WT-550 吗？那为什么不给自己配上更多弹药！！#@*$"
	order_flags = ORDER_EMAG_ONLY
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/ammo_box/magazine/wt550m9 = 2,
		/obj/item/ammo_box/magazine/wt550m9/wtap = 2,
		/obj/item/ammo_box/magazine/wt550m9/wtic = 2,
	)
	crate_name = "应急板条箱"
	crate_type = /obj/structure/closet/crate/secure/syndicate/gorlex/weapons/bustedlock

/datum/supply_pack/imports/shocktrooper
	name = "突击兵板条箱"
	desc = "(*!&@#想让敌人对死亡心生恐惧吗？这箱好东西能帮你实现。\
		内含一件护甲背心和头盔、一盒五枚 EMP 手榴弹、三枚烟雾弹、两枚胶子手榴弹和两枚破片手榴弹！#@*$"
	order_flags = ORDER_EMAG_ONLY
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/storage/box/emps,
		/obj/item/grenade/smokebomb = 3,
		/obj/item/grenade/gluon = 2,
		/obj/item/grenade/frag = 2,
		/obj/item/clothing/suit/armor/vest,
		/obj/item/clothing/head/helmet,
	)
	crate_type = /obj/structure/closet/crate/secure/syndicate/gorlex/weapons/bustedlock

/datum/supply_pack/imports/specialops
	name = "特种作战板条箱"
	desc = "(*!&@#条子在追你？也许这箱东西能帮你争取点时间！ \
		内含变色龙面具、腰带和连体服、幻影手榴弹和一张特工卡！还有一把刀！！#@*$"
	order_flags = ORDER_EMAG_ONLY
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/clothing/mask/chameleon,
		/obj/item/clothing/under/chameleon,
		/obj/item/storage/belt/chameleon,
		/obj/item/card/id/advanced/chameleon,
		/obj/item/switchblade,
		/obj/item/grenade/mirage = 5,
	)
	crate_type = /obj/structure/closet/crate/secure/syndicate/gorlex/weapons/bustedlock

/datum/supply_pack/imports/russian
	name = "俄式剩余军装备板条箱"
	desc = "你好 <;~在此插入合适的问候语：‘同志’|‘帝国主义败类’|‘信誉良好空间站的货运主管’~;>， \
		我们有黑市能提供的最现代化的俄式军事装备，当然，要合适的价格。 \
		无锁，最优价。"
	order_flags = ORDER_CONTRABAND
	cost = CARGO_CRATE_VALUE * 12
	contains = list(
		/obj/item/food/rationpack,
		/obj/item/ammo_box/speedloader/strilka310,
		/obj/item/ammo_box/speedloader/strilka310/surplus,
		/obj/effect/spawner/random/armory/strilka,
		/obj/item/gun_maintenance_supplies,
		/obj/item/clothing/suit/armor/vest/russian,
		/obj/item/clothing/head/helmet/rus_helmet,
		/obj/item/clothing/shoes/russian,
		/obj/item/clothing/gloves/tackler/combat,
		/obj/item/clothing/under/syndicate/rus_army,
		/obj/item/clothing/under/costume/soviet,
		/obj/item/clothing/mask/russian_balaclava,
		/obj/item/clothing/head/helmet/rus_ushanka,
		/obj/item/clothing/suit/armor/vest/russian_coat,
		/obj/item/storage/toolbox/guncase/soviet = 2,
	)
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/imports/russian/fill(obj/structure/closet/crate/our_crate)
	for(var/items in 1 to 10)
		var/item = pick(contains)
		new item(our_crate)

/datum/supply_pack/imports/moistnuggets
	name = "翻新萨赫诺精准步枪板条箱"
	desc = "你好，特工同志。你需要枪？你讨厌我们平时卖给空间站的垃圾？ \
		那我们就有最适合你的武器！给好朋友的特别价！ \
		我们没有足够的备用弹药，所以打光时你得去捡 \
		死掉同志的武器。"
	order_flags = ORDER_EMAG_ONLY
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/gun/ballistic/rifle/boltaction = 6)

/datum/supply_pack/imports/vehicle
	name = "飞车党套件" //TUNNEL SNAKES OWN THIS TOWN
	desc = "隧道蛇拥有这座城。内含一辆无品牌全地形车，以及一套 \
		完整的帮派服装——包括黑手套、吓人的骷髅头巾，还有一件超帅的皮大衣！"
	cost = CARGO_CRATE_VALUE * 4
	order_flags = ORDER_CONTRABAND
	contains = list(
		/obj/vehicle/ridden/atv,
		/obj/item/key/atv,
		/obj/item/clothing/suit/jacket/leather/biker,
		/obj/item/clothing/gloves/color/black,
		/obj/item/clothing/head/soft,
		/obj/item/clothing/mask/bandana/skull/black,
	)//so you can properly #cargoniabikergang
	crate_name = "飞车党套件"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/imports/abandoned
	name = "废弃板条箱"
	desc = "……等等，这东西怎么到这儿来的？"
	cost = CARGO_CRATE_VALUE * 50
	contains = list()
	crate_type = /obj/structure/closet/crate/secure/loot
	crate_name = "废弃板条箱"
	order_flags = ORDER_CONTRABAND | ORDER_DANGEROUS //these are literally bombs so....
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/imports/shambler_evil
	name = "蹒跚者果汁邪异能量！板条箱"
	desc = "~J'I'CE!~"
	cost = CARGO_CRATE_VALUE * 50
	contains = list(/obj/item/reagent_containers/cup/soda_cans/shamblers/eldritch = 1)
	crate_name = "非法蹒跚者果汁板条箱"
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/imports/hide
	name = "兽皮板条箱"
	desc = "不想费劲去屠杀一堆无辜生物？拿去，这些兽皮给你！ \
		只是别问它们是从哪来的……"
	cost = CARGO_CRATE_VALUE * 30
	contains = list(/obj/effect/spawner/random/animalhide = 5)
	crate_name = "兽皮板条箱"
	test_ignored = TRUE

/datum/supply_pack/imports/dreadnog
	name = "恐怖蛋奶酒纸盒板条箱"
	desc = "我有蛋奶酒，而我必须加苏打。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/reagent_containers/cup/glass/bottle/juice/dreadnog = 3)
	crate_name = "恐怖蛋奶酒板条箱"

/* BUBBER EDIT - Removal Start
/datum/supply_pack/imports/giant_wrench_parts
	name = "Big Slappy parts"
	desc = "Illegal Big Slappy parts. The fastest and statistically most dangerous wrench."
	cost = CARGO_CRATE_VALUE * 22
	order_flags = ORDER_CONTRABAND
	contains = list(/obj/item/weaponcrafting/giant_wrench)
	crate_name = "unknown parts crate"
Removal End */

/datum/supply_pack/imports/materials_market
	name = "银河材料市场板条箱"
	desc = "一块用于建造你自己的材料市场、供持证市场交易员使用的电路板。警告：亏损不在保险范围内。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/circuitboard/machine/materials_market = 1,
		/obj/item/stack/sheet/iron = 5,
		/obj/item/stack/cable_coil/five = 2,
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stock_parts/card_reader = 1
	)
	crate_name = "材料市场板条箱"
	crate_type = /obj/structure/closet/crate/cargo

/datum/supply_pack/imports/floortilecamo
	name = "地砖迷彩制服"
	desc = "嘿，想给谁一个惊喜吗？当间谍？偷东西？那你运气不错，来认识我们最新的 \
		地砖“纳米渣滓”风格迷彩作训服。这是最顶尖的 \
		特工所穿的终极间谍制服。以我们最新的迷彩科技布料 \
		提供最佳灵活性。非常适合 \
		危险的走廊间谍行动。祝您使用愉快！"
	order_flags = ORDER_CONTRABAND
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/obj/item/clothing/under/syndicate/floortilecamo = 3,
		/obj/item/clothing/mask/floortilebalaclava = 3,
		/obj/item/clothing/gloves/combat/floortile = 3,
		/obj/item/clothing/shoes/jackboots/floortile = 3,
		/obj/item/storage/backpack/floortile = 3
	)
	crate_name = "地砖迷彩板条箱"
	crate_type = /obj/structure/closet/crate/secure/weapon

/**
 * The Long To Short Range Bluespace Teleporter, used to deliver (black) market purchases more effiiently
 * It can also be used to restock it, if you hit it with enough credits.
 */
/datum/supply_pack/imports/blackmarket_telepad
	name = "黑市 LTSRBT"
	desc = "需要更快更好的方法把你的非法货物运进运出 \
		空间站？别怕，远近程蓝空间收发器（简称 LTSRBT） \
		来帮忙了。内含一块 LTSRBT 电路、两颗蓝空间水晶和一个安塞波。"
	cost = CARGO_CRATE_VALUE * 10
	order_flags = ORDER_CONTRABAND
	contains = list(
		/obj/item/circuitboard/machine/ltsrbt,
		/obj/item/stack/ore/bluespace_crystal/artificial = 2,
		/obj/item/stock_parts/subspace/ansible,
	)

/datum/supply_pack/imports/fan_upgrade
	name = "货运穿梭机升级：空气更新"
	desc = "你或你的同事是不是有个坏习惯，总把货运穿梭机的卷帘门敞向寒冷、寒冷的太空真空？\
		有了这项便捷的工程改装，你的穿梭机将配备几片便利的塑料门帘，并附赠空气补充订阅。"
	cost = CARGO_CRATE_VALUE * 40 // HELLA expensive.
	order_flags = ORDER_NOT_DEPARTMENTAL
	access_view = ACCESS_CARGO
	storage_override = /obj/item/folder
	contains = list(
		/obj/item/paper/fluff/certificate,
	)

/datum/supply_pack/imports/fan_upgrade/generate(atom/A, datum/bank_account/paying_account, crate_override)
	if(SSshuttle.renew_cargo_air)
		return ..()

	for(var/obj/spawnpoint as anything in GLOB.cargo_shuttle_flaps_landmarks)
		new /obj/structure/plasticflaps(spawnpoint.loc)
		SSshuttle.renew_cargo_air = TRUE
		order_flags = ORDER_INVISIBLE
	return ..()

/obj/item/paper/fluff/certificate
	name = "穿梭机升级证书"
	color = COLOR_LIGHT_ORANGE
	desc = "一封来自纳米传讯机械师协会的便条，详细说明你的新穿梭机升级。"
	default_raw_text = "嘿老板。那些门帘我们给你装好了，真没什么难的。你会在防爆门上或出口处找到它们， \
		就看机械师先够到哪个了。它们都调好了，不用再动，所以别乱碰。除此之外，要是有哪里看起来不对， \
		你告诉我们。"

/datum/supply_pack/imports/jet_boots
	name = "喷射靴"
	desc = "如今，光是弄到一艘私人巡洋舰就已经够难了，更别说你自己的超空间隧道。\
		为什么不潇洒出行？全新 nuVoid 喷射靴登场。流线型米白表面。自推进微型离子推进器。\
		真正的碳燃料微型喷流，带来旧时代的质感。别只是抵达，要潇洒地抵达。无需融资，也不提供融资。"
	order_flags = ORDER_NOT_DEPARTMENTAL
	access_view = ACCESS_CARGO
	cost = CARGO_CRATE_VALUE * 200 // One pair of these boots are really gosh darn expensive.
	contains = list(/obj/item/clothing/shoes/bhop/rocket/jet)
	crate_name = "nuVoid 喷射靴板条箱"
	crate_type = /obj/structure/closet/crate/goldcrate
