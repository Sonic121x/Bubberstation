/obj/item/food/snacks/store/bread/haggis
	name = "哈吉斯"
	desc = "一种含有内脏的咸味布丁。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "haggis"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 50,
		/datum/reagent/consumable/nutriment/vitamin = 25
	)
	foodtypes = MEAT | GRAIN
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/snacks/store/bread/haggis/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/snacks/breadslice/haggis, 5, 30, screentip_verb = "切片")

/obj/item/food/snacks/breadslice/haggis
	name = "哈吉斯块"
	desc = "一块美味的哈吉斯。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "haggis_chunk"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5
	)
	foodtypes = MEAT | GRAIN
	crafting_complexity = FOOD_COMPLEXITY_4


/obj/item/food/snacks/neep_tatty_haggis
	name = "哈吉斯配芜菁与土豆 "
	desc = "喂，老兄！没有芜菁，甜菜倒给了双份！坑人！！！"
	icon_state = "neep_tatty_haggis"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/iron = 10
	)
	foodtypes = GRAIN | VEGETABLES | MEAT
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_sausage/battered
	name = "生裹糊香肠"
	desc = "一根裹着厚厚啤酒面糊的生香肠。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "batteredsausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/ethanol/beerbatter = 5
	)
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_sausage/battered/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/sausage/battered, rand(60 SECONDS, 75 SECONDS), TRUE)

/obj/item/food/sausage/battered
	name = "裹糊香肠"
	desc = "一根裹着厚厚啤酒面糊的香肠，最好配上一份用报纸包着的薯条。不过这玩意纯是胆固醇，苏格兰人照吃。他们中没几个活到 60 岁。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "grilled_batteredsausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/fat/oil = 2
	)
	foodtypes = MEAT | BREAKFAST | FRIED
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/shortbread
	name = "黄油酥饼"
	desc = "一块长方形的烤面粉。据说能在跨年夜控制太阳。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "shortbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 6
	)
	tastes = list("甜面团" = 1)
	foodtypes = GRAIN | JUNKFOOD | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2
