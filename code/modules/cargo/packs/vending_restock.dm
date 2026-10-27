/datum/supply_pack/vending
	group = "Vending Restocks"

/datum/supply_pack/vending/bartending
	name = "酒水自动机与咖啡供应板条箱"
	desc = "把酒和咖啡自动售货机的补充装都拿来。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/vending_refill/boozeomat,
					/obj/item/vending_refill/coffee,
				)
	crate_name = "调酒供应板条箱"

/datum/supply_pack/vending/cigarette
	name = "香烟供应板条箱"
	desc = "别信那些报道——今天就抽起来！内含一份 \
		香烟自动售货机补充装。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/vending_refill/cigarette)
	crate_name = "香烟供应板条箱"
	crate_type = /obj/structure/closet/crate/robust

/datum/supply_pack/vending/science/cytopro
	name = "细胞学售货机供应板条箱"
	desc = "满足你所有的培养槽培育需求！内含一份 CytoPro 机器补充装。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/vending_refill/cytopro)
	crate_name = "CytoPro 供应板条箱"

/datum/supply_pack/vending/dinnerware
	name = "餐具供应板条箱"
	desc = "给厨师更多刀具。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/vending_refill/dinnerware)
	crate_name = "餐具供应板条箱"

/datum/supply_pack/vending/science/modularpc
	name = "豪华硅质精选补充包"
	desc = "电脑是什么？内含一台豪华硅质精选补充装置。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/vending_refill/modularpc)
	crate_name = "电脑供应板条箱"

/datum/supply_pack/vending/engivend
	name = "工程售货机供应板条箱"
	desc = "工程师们的金属泡沫手榴弹用完了？这个应该能帮上忙。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/vending_refill/engivend)
	crate_name = "工程供应板条箱"

/datum/supply_pack/vending/games
	name = "游戏供应板条箱"
	desc = "用这份游戏售货机补充装尽情开玩吧。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/vending_refill/games)
	crate_name = "游戏供应板条箱"
	crate_type = /obj/structure/closet/crate

/datum/supply_pack/vending/hydro_refills
	name = "水培售货机补充装"
	desc = "当小丑把香蕉种子全拿走的时候。 \
		内含一份 NutriMax 补充装和一份 MegaSeed Servitor 补充装。"
	cost = CARGO_CRATE_VALUE * 4
	crate_type = /obj/structure/closet/crate
	contains = list(/obj/item/vending_refill/hydroseeds,
					/obj/item/vending_refill/hydronutrients,
				)
	crate_name = "水培供应板条箱"

/datum/supply_pack/vending/imported
	name = "进口售货机"
	desc = "在银河系其他地区颇有名气的售货机。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/vending_refill/sustenance,
					/obj/item/vending_refill/robotics,
					/obj/item/vending_refill/sovietsoda,
					/obj/item/vending_refill/engineering,
				)
	crate_name = "未标注的供应板条箱"

/datum/supply_pack/vending/medical
	name = "医疗售货机板条箱"
	desc = "内含一份 NanoMed Plus 补充装、一份 NanoDrug Plus 补充装， \
		以及一份壁挂式 NanoMed 补充装。"
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(/obj/item/vending_refill/medical,
					/obj/item/vending_refill/drugs,
					/obj/item/vending_refill/wallmed,
				)
	crate_name = "医疗售货机板条箱"

/datum/supply_pack/vending/ptech
	name = "PTech 供应板条箱"
	desc = "一半船员的手持终端在爆炸中报销后，墨盒不够用了？ \
		这个或许能解决。"
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/vending_refill/cart)
	crate_name = "\improper PTech 供应板条箱"

/datum/supply_pack/vending/sectech
	name = "SecTech 供应板条箱"
	desc = "保罗警官把甜甜圈全买光了？那就用这个板条箱 \
		给安保售货机补货吧。"
	cost = CARGO_CRATE_VALUE * 3
	access = ACCESS_SECURITY
	contains = list(/obj/item/vending_refill/security)
	crate_name = "\improper SecTech 供应板条箱"
	crate_type = /obj/structure/closet/crate/secure/gear

/datum/supply_pack/vending/snack
	name = "零食供应板条箱"
	desc = "一份能带来满口蛀牙的“美味”售货机补充装！ \
		牙医推荐排行榜第一名！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/vending_refill/snack)
	crate_name = "零食供应板条箱"
	crate_type = /obj/structure/closet/crate/robust

/datum/supply_pack/vending/cola
	name = "软饮料供应板条箱"
	desc = "被工具箱敲了一顿，可那口烦人的牙还在？ \
		用这份汽水机补充装，今天就把那排白牙解决掉！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/vending_refill/cola)
	crate_name = "软饮料供应板条箱"

/datum/supply_pack/vending/vendomat
	name = "零件超市与 YouTool 供应板条箱"
	desc = "为你的简易爆炸装置测试场提供更多工具。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/vending_refill/assist,
					/obj/item/vending_refill/youtool,
				)
	crate_name = "\improper 零件超市与 YouTool 供应板条箱"

/datum/supply_pack/vending/clothesmate
	name = "ClothesMate 供应板条箱"
	desc = "牛仔靴用完了？买这个板条箱。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/vending_refill/clothing)
	crate_name = "\improper ClothesMate 供应板条箱"


/// Clothing Vending Restocks

/datum/supply_pack/vending/wardrobes/autodrobe
	name = "自动衣橱供应板条箱"
	desc = "自动衣橱里缺你最爱的那条裙子？ \
		今天就用这份自动衣橱补充装解决。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/vending_refill/autodrobe)
	crate_name = "自动衣橱供应板条箱"

/datum/supply_pack/vending/wardrobes/cargo
	name = "货运衣柜供应板条箱"
	desc = "此板条箱内含一份货运衣柜补充装。"
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(/obj/item/vending_refill/wardrobe/cargo_wardrobe)
	crate_name = "货运部门供应板条箱"

/datum/supply_pack/vending/wardrobes/engineering
	name = "工程衣柜供应板条箱"
	desc = "此板条箱内含工程衣柜与大气衣柜的补充装。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/vending_refill/wardrobe/engi_wardrobe,
					/obj/item/vending_refill/wardrobe/atmos_wardrobe,
				)
	crate_name = "工程部门衣柜供应板条箱"

/datum/supply_pack/vending/wardrobes/general
	name = "通用衣柜供应板条箱"
	desc = "此板条箱内含馆长衣柜、酒吧衣柜、 \
		厨师衣柜与牧师衣柜的补充装。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/vending_refill/wardrobe/curator_wardrobe,
					/obj/item/vending_refill/wardrobe/bar_wardrobe,
					/obj/item/vending_refill/wardrobe/chef_wardrobe,
					/obj/item/vending_refill/wardrobe/chap_wardrobe,
				)
	crate_name = "通用衣柜售货机补充装"

/datum/supply_pack/vending/wardrobes/hydroponics
	name = "水培衣柜供应板条箱"
	desc = "此板条箱内含一份水培衣柜补充装。"
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(/obj/item/vending_refill/wardrobe/hydro_wardrobe)
	crate_name = "水培衣柜供应板条箱"

/datum/supply_pack/vending/wardrobes/janitor
	name = "清洁衣柜供应板条箱"
	desc = "此板条箱内含一份清洁衣柜补充装。"
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(/obj/item/vending_refill/wardrobe/jani_wardrobe)
	crate_name = "清洁衣柜供应板条箱"

/datum/supply_pack/vending/wardrobes/medical
	name = "医疗衣柜供应板条箱"
	desc = "此板条箱内含医疗衣柜、 \
		化学衣柜、病毒衣柜与验尸衣柜的补充装。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/vending_refill/wardrobe/medi_wardrobe,
					/obj/item/vending_refill/wardrobe/chem_wardrobe,
					/obj/item/vending_refill/wardrobe/viro_wardrobe,
					/obj/item/vending_refill/wardrobe/coroner_wardrobe,
				)
	crate_name = "医疗部门衣柜供应板条箱"

/datum/supply_pack/vending/wardrobes/science
	name = "科研衣柜供应板条箱"
	desc = "此板条箱内含科研衣柜、 \
		基因衣柜与机器人衣柜的补充装。"
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(/obj/item/vending_refill/wardrobe/robo_wardrobe,
					/obj/item/vending_refill/wardrobe/gene_wardrobe,
					/obj/item/vending_refill/wardrobe/science_wardrobe,
				)
	crate_name = "科研部门衣柜供应板条箱"

/datum/supply_pack/vending/wardrobes/security
	name = "安保衣柜供应板条箱"
	desc = "此板条箱内含安保衣柜、 \
		侦查衣柜与执法衣柜的补充装。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/vending_refill/wardrobe/sec_wardrobe,
					/obj/item/vending_refill/wardrobe/det_wardrobe,
					/obj/item/vending_refill/wardrobe/law_wardrobe,
				)
	crate_name = "安保部门供应板条箱"
