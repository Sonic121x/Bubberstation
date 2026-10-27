/datum/supply_pack/misc/ouija_board
	name = "降神会入门套装"
	desc = "《废墟与太空龙》还不够你玩？觉得戳鲤鱼的乐趣里少了点神秘气息？\
		别担心，咚克公司通灵板来了，由我们与纳尔西众教派的精彩合作倾情呈现！\
		（心脏病患者请勿使用）"
	cost = CARGO_CRATE_VALUE * 9 // Donk Co sure loves their money, and a collab this fat? Wowee, they need to get PAID.
	access_view = ACCESS_CHAPEL_OFFICE
	crate_type = /obj/structure/closet/crate/wooden
	contains = list()
	crate_name = "降神会入门套装"


/datum/supply_pack/misc/ouija_board/fill(obj/structure/closet/crate/our_crate)
	new /obj/item/storage/fancy/candle_box(our_crate)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(our_crate)
	if(prob(85))
		new /obj/structure/spirit_board(our_crate)
	else
		new /obj/structure/spirit_board/weegee(our_crate)


/datum/supply_pack/engineering/constructionkit
	name = "建造工具套装箱"
	desc = "专为那些不想四处奔波的 DIY 项目准备。内含一套工具、一顶焊接头盔和各类材料。"
	contains = list(
		/obj/item/storage/belt/utility/full, // Yes, this is a filled toolbelt.
		/obj/item/clothing/head/utility/welding,
		/obj/item/stack/sheet/mineral/wood/fifty, // ~600 or x 3 Crate Cost from Wood Plank Crate
		/obj/item/stack/sheet/iron/fifty = 2, // ~400 or x 2 Crate Cost from Iron Sheet Crate
		/obj/item/stack/sheet/glass/fifty, // ~400 or x 2 Crate Cost from Glass Sheet Crate
		/obj/item/stack/sheet/cloth/ten = 5, // Curtains, Bedseets, Towels
		/obj/item/stack/sheet/rglass = 20, // ~60 Credits
		/obj/item/survivalcapsule/fan = 2, // ~200 from Imports
		/obj/item/construction/rtd, // RLD is 500, maybe this should be similar?
		/obj/item/storage/box/lights/mixed, // 200
		/obj/item/toy/crayon/spraycan = 3,
	)
	cost = 3000
	crate_name = "建造工具套装箱"

/datum/supply_pack/emergency/survivalsuit
	name = "生存型 MOD 箱"
	desc = "内含一套卡赫拉曼重工生产的生存型 MOD 外骨骼，适合临时急需一身廉价套装的时候。"
	contains = list(
		/obj/item/mod/control/pre_equipped/frontier_colonist
	)
	cost = CARGO_CRATE_VALUE * 6
	access = ACCESS_EVA
	crate_name = "EVA 服箱"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/emergency/voskhod
	name = "VOSKHOD 模块化战斗服箱"
	desc = "内含一套“全新”的 VOSKHOD 模块化外骨骼，由 CIN 旗帜下众多国家之一改装而成。"
	contains = list(
			/obj/item/mod/control/pre_equipped/voskhod
	)
	cost = CARGO_CRATE_VALUE * 24
	access = ACCESS_EVA
	crate_name = "战斗服箱"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/emergency/depowerarmor
	name = "无动力 VOSKHOD 装甲套装"
	desc = "我们进了一批 PSC 的“精品”装甲套装，这些家伙当年可风光多了。不过嘛，我们知道你们就好这口！"
	cost = CARGO_CRATE_VALUE * 12
	contains = list(
		/obj/item/clothing/head/helmet/space/voskhod,
		/obj/item/clothing/suit/space/voskhod,
	)
	access = ACCESS_EVA
	crate_name = "战斗服箱"
	crate_type = /obj/structure/closet/crate/secure

