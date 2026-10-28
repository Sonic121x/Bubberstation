/obj/item/reagent_containers/cup/soda_cans
	/// Trash type that gets created upon crushing the can
	/// This is a Bubber feature
	/// Done by edits in the TG proc definitions for the type
	var/trash_type = /obj/item/trash/can

/obj/item/reagent_containers/cup/soda_cans/bubber
	icon = 'modular_zubbers/icons/obj/drinks/soda.dmi'
	icon_state = null
	trash_type = /obj/item/trash/can/bubber

/obj/item/trash/can/bubber
	icon = 'modular_zubbers/icons/obj/janitor.dmi'
	icon_state = "tangorine_soda"

/obj/item/reagent_containers/cup/soda_cans/bubber/blood_tea
	name = "血红蛋白冰茶"
	desc = "有点像那位有钱的高尔夫球手喝的东西，不过这罐里是真的血！"
	icon_state = "blood_tea"
	list_reagents = list(/datum/reagent/consumable/icetea/blood_tea = 25, /datum/reagent/consumable/ethanol/bloodshot = 5)

/obj/item/reagent_containers/cup/soda_cans/bubber/tangorine_soda
	name = "坦橘汽水"
	desc = "橘子汁与气泡融合而成的清爽饮品。罐身上印着一只鲜橙与翠绿配色的特沙利吉祥物。"
	icon_state = "tangorine_soda"
	drink_type = SUGAR | FRUIT
	list_reagents = list(/datum/reagent/consumable/orangejuice = 20, /datum/reagent/consumable/sodawater = 10)

/obj/item/reagent_containers/cup/soda_cans/bubber/lubricola
	name = "润滑可乐"
	desc = "为你疲惫的齿轮准备的最佳润滑剂。"
	icon_state = "lubricola"
	list_reagents = list(/datum/reagent/fuel/oil = 30)
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/reagent_containers/cup/soda_cans/bubber/welding_fizz
	name = "焊接汽水"
	desc = "能量比简易爆炸装置还多！现已充入碳酸。警告：含有毒且易燃的燃料。"
	icon_state = "welding_fizz"
	list_reagents = list(/datum/reagent/fuel = 25, /datum/reagent/carbondioxide = 5)
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/reagent_containers/cup/soda_cans/bubber/synthanolcan
	name = "傻锥合成醇"
	desc = "一罐重新编译过的合成醇。"
	icon_state = "synthanolcan"
	list_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 30)
	custom_price = PAYCHECK_CREW

/obj/item/reagent_containers/cup/soda_cans/bubber/wine_voltaic
	name = "罐装伏打黄葡萄酒"
	desc = "一罐带电的葡萄酒，能为以太人充能，可以安全饮用。"
	icon_state = "wine_voltaic"
	list_reagents = list(/datum/reagent/consumable/ethanol/wine_voltaic = 30)

/obj/item/reagent_containers/cup/soda_cans/bubber/kortara
	name = "科塔拉"
	desc = "一罐由科塔种子酿制的科塔拉酒，带有独特的胡椒辛香。"
	icon_state = "kortara"
	list_reagents = list(/datum/reagent/consumable/ethanol/kortara = 30)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/soda_cans/bubber/lemonade
	name = "\improper 工厂舰 1023：柠檬水"
	desc = "一罐柠檬水，献给喜欢它的人，以及别无选择的人。"
	icon_state = "lemonade"
	list_reagents = list(/datum/reagent/consumable/lemonade = 30)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/soda_cans/bubber/lemonade/examine_more(mob/user)
	. = ..()
	. += span_notice("罐身标记表明，它产自大游牧舰队的<i>工厂舰 1023</i>。")
	return .

/obj/item/reagent_containers/cup/soda_cans/bubber/navy_rum
	name = "\improper 工厂舰 1506：海军朗姆酒"
	desc = "一罐由游牧舰队分遣队酿造并出口的海军朗姆酒，至少罐子上是这么写的。"
	icon_state = "navy_rum"
	list_reagents = list(/datum/reagent/consumable/ethanol/navy_rum = 30)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/soda_cans/bubber/navy_rum/examine_more(mob/user)
	. = ..()
	. += span_notice("罐身标记表明，它产自大游牧舰队的<i>工厂舰 1506</i>。")
	return .

/obj/item/reagent_containers/cup/soda_cans/bubber/soda_water_moth
	name = "\improper 工厂舰 1023：苏打水"
	desc = "一罐苏打水。不如调杯朗姆苏打？仔细想想，还是算了。"
	icon_state = "soda_water"
	list_reagents = list(/datum/reagent/consumable/sodawater = 30)
	drink_type = SUGAR

/obj/item/reagent_containers/cup/soda_cans/bubber/soda_water_moth/examine_more(mob/user)
	. = ..()
	. += span_notice("罐身标记表明，它产自大游牧舰队的<i>工厂舰 1023</i>。")
	return .

/obj/item/reagent_containers/cup/soda_cans/bubber/ginger_beer
	name = "\improper 工厂舰 1023：姜汁啤酒"
	desc = "一罐姜汁啤酒，别被名字里的“啤酒”骗了，它完全不含酒精。"
	icon_state = "gingie_beer"
	list_reagents = list(/datum/reagent/consumable/sol_dry = 30)
	drink_type = SUGAR

/obj/item/reagent_containers/cup/soda_cans/bubber/ginger_beer/examine_more(mob/user)
	. = ..()
	. += span_notice("罐身标记表明，它产自大游牧舰队的<i>工厂舰 1023</i>。")
	return .
