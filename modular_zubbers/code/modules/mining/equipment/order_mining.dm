//CLOTHING

/obj/item/suit_voucher
	name = "套装兑换券"
	desc = "用于兑换一套新套装的凭证。对着采矿设备售货机使用。"
	icon = 'icons/obj/mining.dmi'
	icon_state = "mining_voucher"
	w_class = WEIGHT_CLASS_TINY

/obj/item/storage/backpack/duffelbag/mining_bunny
	name = "兔兔套件"
	desc = "以兔子为主题的采矿服装套件——毕竟它们确实住在洞穴里……"
	icon_state = "satchel_carrot"
	inhand_icon_state = null

/obj/item/storage/backpack/duffelbag/mining_bunny/PopulateContents()
	new /obj/item/clothing/head/playbunnyears/miner(src)
	new /obj/item/clothing/neck/tie/bunnytie/miner(src)
	new /obj/item/clothing/suit/jacket/tailcoat/miner(src)
	new /obj/item/clothing/under/rank/cargo/miner/bunnysuit(src)
	new /obj/item/clothing/shoes/workboots/mining/heeled(src)

/datum/orderable_item/mining/bunny
	purchase_path = /obj/item/storage/backpack/duffelbag/mining_bunny
	desc = "以兔子为主题的采矿服装套件——毕竟它们确实住在洞穴里……"
	cost_per_order = 500

/datum/orderable_item/mining/bombercoat
	purchase_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/mining
	desc = "一件采矿飞行夹克。在熔岩地带大概不太顶用，但配上它、一杯热可可和一点雪？舒适最大化从未如此廉价！"
	cost_per_order = 100

//EXTRAS

//Adding the ability for miners to purchase a status readout module.
/datum/orderable_item/mining/status_readout
	purchase_path = /obj/item/mod/module/status_readout
	name = "状态读数模块"
	desc = "一种 MOD 模块化外骨骼模块，可远距离广播套装传感器。装在 MOD 里很实用，因为它能盖住凯拉尔袖口！"
	cost_per_order = 450

/datum/orderable_item/mining/offstation_deathrattle
	purchase_path = /obj/item/storage/box/offstation_deathrattle
	name = "站外临终警报套件"
	desc = "要去远离空间站舒适区的地方冒险？不确定自己能完整回来？卡赫拉曼重工与纳米传讯联合推出站外临终警报植入体！这枚连接你生命体征的小芯片会在你早逝时自动发出求救信号。它只在空间站区域之外有效。若因坠入深坑或跳进熔岩、等离子湖而死亡，保修即告失效。"
	cost_per_order = 675


/// PODS
/obj/item/survivalcapsule/plap
	name = "PLAP 胶囊"
	desc = "一枚辛迪加红黑配色的蓝空间胶囊，上面印着 PLAP 字样。"
	template_id = "shelter_plap"
	icon_state = "scapsule"
	icon = 'modular_zubbers/icons/obj/equipment/mining.dmi'

/obj/item/paper/crumpled/plap
	name = "你的 PLAP（便携式高级监听哨）使用指南"
	default_raw_text = {"<h1><table bgcolor="darkred" width="100%"><th><font color="#ffffff" size=4 face="OCR A Std, monospace"><div align="center">♦♦♦♦♦♦♦♦◹§◺♦♦♦♦♦♦♦♦</font></div></th></table></h1><hr /><font face="Veranda" size=3>欢迎使用属于你自己的“便携式”监听哨！既然你已经拆开了套件，那就开始了解它的运作方式吧！<br><br>本套件包含：<br>* 最先进的防护窗，帮你隔绝肮脏的外界！<br>* 一个能让最厉害的黑客男孩都哭出来的计算机舱！<br>* 一台涂着流线型辛迪加红的传真机。<br>* 一个文件柜！没什么特别的，就是个文件柜。<br><br>监听你的敌人！搅乱他们的通讯！找个可爱姑娘跟踪！有了“便携式”监听哨，一切皆有可能！<br><hr />PLP 附带的传真机已接入索斯兰网络。空间站上的任何传真机都看不到它，但它仍能向它们发送传真。好好利用这一点。</font><hr /><center><font size=3>❘❙❚❘❙❚|<span style="color:black;font-family:'Sitka Small Semibold';">沉默之中自有荣光。</span>|❚❙❘❚❙❘</center><hr><div align="center"><font size=1>警告。便携式监听哨放置后无法移动。依赖周边区域的电力。不含通讯特工。需要具备运行通讯阵列的基础知识。请勿吞食从计算机键盘上掉落的小零件。</div></font><hr><h1><table bgcolor="darkred" width="100%"><th><font color="#ffffff" size=4 face="OCR A Std, monospace"><div align="center">♦♦♦♦♦♦♦♦◹§◺♦♦♦♦♦♦♦♦</font></div></th></table></h1>"}

/obj/item/survivalcapsule/sauna
	name = "桑拿与热水浴缸庇护所"
	desc = "一枚蓝空间胶囊，可展开豪华桑拿房与热水浴缸"
	template_id = "shelter_s"

/datum/orderable_item/mining/capsule_sauna
	purchase_path = /obj/item/survivalcapsule/sauna
	cost_per_order = 7000

/obj/item/survivalcapsule/medical
	name = "医疗创伤舱"
	desc = "一枚蓝空间胶囊，可展开相当有效的医疗治疗舱！"
	template_id = "shelter_delta"

/obj/item/survivalcapsule/chemistry
	name = "化学精炼舱"
	desc = "一枚蓝空间胶囊，可展开功能齐全的化学精炼区，适合采集那些有用的间歇泉。"
	template_id = "shelter_echo"

/datum/supply_pack/medical/medpod
	name = "医疗创伤舱"
	crate_name = "医疗舱板条箱"
	desc = "一枚蓝空间胶囊，可展开相当有效的医疗治疗舱！"
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 20
	contains = list(
		/obj/item/survivalcapsule/medical,
	)

/datum/supply_pack/medical/chempod
	name = "化学精炼舱"
	crate_name = "化学舱板条箱"
	desc = "一枚蓝空间胶囊，可展开功能齐全的化学精炼区，适合采集那些有用的间歇泉。"
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/survivalcapsule/chemistry,
	)

/*****************************Botany Pods - Home is where the green is...********************************/
/obj/item/survivalcapsule/botany
	name = "植物控制舱"
	desc = "一枚蓝空间舱，内含植物学设备。"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_botany"
	used = FALSE

/datum/map_template/shelter/botany
	name = "植物控制"
	shelter_id = "shelter_botany"
	description = "一座封闭且可互相连通的植物舱。"
	mappath = "_maps/bubber/pods/shelter_botany.dmm"

/datum/map_template/shelter/botany/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/trays
	name = "植物种植槽舱"
	desc = "一枚蓝空间舱，内含植物学设备。"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_trays"
	used = FALSE

/datum/map_template/shelter/trays
	name = "植物种植槽"
	shelter_id = "shelter_trays"
	description = "一座封闭且可互相连通的植物舱。"
	mappath = "_maps/bubber/pods/shelter_trays.dmm"

/datum/map_template/shelter/trays/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/*********************************************Odd Pods**************************************************/

/obj/item/survivalcapsule/fan
	name = "气闸风扇舱"
	desc = "一枚蓝空间舱，内含可展开的风扇，用于维持气压。"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_fan"
	used = FALSE

/datum/map_template/shelter/fan
	name = "气闸风扇部署器"
	shelter_id = "shelter_fan"
	description = "一座封闭且可互相连通的舱体。"
	mappath = "_maps/bubber/pods/shelter_fan.dmm"

/datum/map_template/shelter/fan/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/o2
	name = "氧气采集舱"
	desc = "一枚蓝空间舱，内含小型泵站，用于采集可呼吸的氧气。"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_o2"
	used = FALSE

/datum/map_template/shelter/o2
	name = "氧气采集器部署器"
	shelter_id = "shelter_o2"
	description = "一座封闭的氧气采集舱，供行星地表使用。"
	mappath = "_maps/bubber/pods/shelter_o2.dmm"

/datum/map_template/shelter/o2/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/kitchen
	name = "可展开厨房舱"
	desc = "一枚蓝空间舱，内含一间厨房。"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_kitchen"
	used = FALSE

/datum/map_template/shelter/kitchen
	name = "厨房部署器"
	shelter_id = "shelter_kitchen"
	description = "一座封闭的厨房。"
	mappath = "_maps/bubber/pods/shelter_kitchen.dmm"

/datum/map_template/shelter/kitchen/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/cabin
	name = "可展开舒适舱"
	desc = "一枚蓝空间舱，内含一间木屋。"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_cabin"
	used = FALSE

/datum/map_template/shelter/cabin
	name = "舒适木屋部署器"
	shelter_id = "shelter_cabin"
	description = "一座封闭的舒适木屋。"
	mappath = "_maps/bubber/pods/shelter_cabin.dmm"

/datum/map_template/shelter/cabin/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/threebythree
	name = "可展开小型空舱"
	desc = "一枚蓝空间舱，内含一间 3x3 的空舱。"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_threebythree"
	used = FALSE

/datum/map_template/shelter/threebythree
	name = "小型舱部署器"
	shelter_id = "shelter_threebythree"
	description = "一座封闭的小型舱。"
	mappath = "_maps/bubber/pods/shelter_3x3.dmm"

/datum/map_template/shelter/threebythree/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/obj/item/survivalcapsule/sixbysix
	name = "可展开大型空舱"
	desc = "一枚蓝空间舱，内含一间 6x6 的空舱。"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_sixbysix"
	used = FALSE

/datum/map_template/shelter/sixbysix
	name = "大型舱部署器"
	shelter_id = "shelter_sixbysix"
	description = "一座封闭的大型舱。"
	mappath = "_maps/bubber/pods/shelter_6x6.dmm"

/datum/map_template/shelter/sixbysix/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)


/************************* MED-SCI Pods***************************/

/***xenoarcheology***/
/obj/item/survivalcapsule/xenoarchpod
	name = "可展开异星考古舱"
	desc = "一枚蓝空间舱，内含一间 3x3 的异星考古舱。"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_xenoarch"
	used = FALSE

/datum/map_template/shelter/xenoarch
	name = "异星考古舱部署器"
	shelter_id = "shelter_xenoarch"
	description = "一座封闭的小型异星考古舱。"
	mappath = "_maps/bubber/pods/shelterxenoarch.dmm"

/datum/map_template/shelter/xenoarch/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/supply_pack/science/xenoarchpod
	name = "异星考古舱"
	desc = "一枚蓝空间舱，内含一间 3x3 的异星考古舱。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/survivalcapsule/xenoarchpod)
	crate_type = /obj/structure/closet/crate/nakamura

/***triage***/

/obj/item/survivalcapsule/triage
	name = "可展开分诊舱"
	desc = "一枚蓝空间舱，内含一间 3x3 的紧急分诊区。"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "shelter_triage"
	used = FALSE

/datum/map_template/shelter/triage
	name = "分诊舱部署器"
	shelter_id = "shelter_triage"
	description = "一座封闭的小型分诊舱。"
	mappath = "_maps/bubber/pods/shelter_triage.dmm"

/datum/map_template/shelter/triage/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/supply_pack/medical/triagepod
	name = "分诊舱"
	desc = "一枚蓝空间舱，内含一间 3x3 的分诊套间。"
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/survivalcapsule/triage)
