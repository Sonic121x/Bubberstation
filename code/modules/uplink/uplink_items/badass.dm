/datum/uplink_category/badassery
	name = "（毫无用处的）耍帅"
	weight = 0

/datum/uplink_item/badass
	category = /datum/uplink_category/badassery
	surplus = 0

/datum/uplink_item/badass/balloon
	name = "辛迪加气球"
	desc = "用来证明你就是老大：一只印着辛迪加标志的毫无用处的红气球。 \
			能炸掉最深层的伪装。"
	item = /obj/item/toy/balloon/syndicate
	cost = 20
	lock_other_purchases = TRUE
	cant_discount = TRUE
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/badass/balloon/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	. = ..()

	if(!.)
		return

	notify_ghosts(
		"[user.real_name] 买了一只超拽的辛迪加气球！",
		source = .,
		header = "他们到底在想什么？",
	)

/datum/uplink_item/badass/syndiecards
	name = "辛迪加扑克牌"
	desc = "一副特制的太空级扑克牌，边缘为单分子结构并经过金属加固， \
			因此比普通扑克牌稍微结实一些。 \
			你也可以用它们打牌，或者把它们留在受害者身上。"
	item = /obj/item/toy/cards/deck/syndicate
	cost = 1
	surplus = 40
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/badass/syndiecigs
	name = "辛迪加香烟"
	desc = "味道浓烈，烟雾浓厚，注入了全能嗪。"
	item = /obj/item/storage/fancy/cigarettes/cigpack_syndicate
	cost = 2
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/badass/syndiecash
	name = "装满现金的辛迪加公文包"
	desc = "一个装有 5000 太空信用点的安全公文包。适合用来贿赂人员，或以便宜的价格购买商品 \
			与服务。这只公文包拿起来也稍重一些；它被造得在需要说服客户时 \
			能多那么一点分量。"
	item = /obj/item/storage/briefcase/secure/syndie
	cost = 3
	restricted = TRUE
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/badass/costumes/clown
	name = "小丑服装"
	desc = "没有什么比拿着全自动武器的小丑更可怕的了。"
	item = /obj/item/storage/backpack/duffelbag/clown/syndie

/datum/uplink_item/badass/costumes/tactical_naptime
	name = "安眠睡衣套装"
	desc = "即使是士兵也需要好好睡一觉。内含血红色睡衣、一条小毯子、一杯热可可和一位毛茸茸的朋友。"
	item = /obj/item/storage/box/syndie_kit/sleepytime
	limited_stock = 1
	cant_discount = TRUE

/datum/uplink_item/badass/costumes/obvious_chameleon
	name = "损坏的变色龙套件"
	desc = "一套搭载变色龙技术的物品，能让你伪装成空间站上几乎任何东西，甚至更多！ \
			请注意，本套件并未通过质检。"
	item = /obj/item/storage/box/syndie_kit/chameleon/broken

/datum/uplink_item/badass/costumes/centcom_official
	name = "中央指挥部官员服装"
	desc = "请船员“检查”他们的核弹认证磁盘和武器系统，等他们拒绝时，掏出一把全自动步枪把舰长打成筛子。 \
			无线电耳机不含加密密钥。不含枪械。"
	item = /obj/item/storage/box/syndie_kit/centcom_costume

/datum/uplink_item/badass/stickers
	name = "辛迪加贴纸包"
	desc = "内含 8 张随机贴纸，精心设计成可疑物品的样子，也许能骗过船员，也许不能。"
	item = /obj/item/storage/box/stickers/syndie_kit
	cost = 1

/datum/uplink_item/badass/demotivational_posters
	name = "辛迪加反励志海报包"
	desc = "内含多款反励志海报，可把工作效率降到最低，并让职场冷漠达到极致。"
	item = /obj/item/storage/box/syndie_kit/poster_box
	cost = 1

/datum/uplink_item/badass/syndie_spraycan
	name = "辛迪加喷漆罐"
	desc = "一罐时髦的辛迪加喷漆罐。 \
		内含的特殊溶液足以喷出一个超大号煽动性符号，让空间站员工陷入滑倒的痛苦。"
	item = /obj/item/traitor_spraycan
	cost = 1

/datum/uplink_item/badass/pinpointer
	name = "盈余定位仪"
	desc = "提供一台盈余定位仪，这是旧型号的存货，那些型号被一款云端 SaaS 版 PDA 应用取代后便遭淘汰。"
	item = /obj/item/pinpointer/nuke/syndicate
	cost = 2

/datum/uplink_item/badass/dangerous_horse
	name = "盒装辛迪加小马"
	desc = "这个箱子装着通往美好生活所需的一切。小马，给小马喝的智能药水，给小马吃的苹果。看在上帝的份上，别做苹果派！"
	item = /obj/item/storage/box/syndicate/horse_box
	cost = 10
