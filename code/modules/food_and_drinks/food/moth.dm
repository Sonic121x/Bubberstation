//Moth Foods, the three C's: cheese, coleslaw, and cotton
//A large emphasis has been put on sharing and multiple portion dishes
//Additionally, where a mothic name is given, a short breakdown of what exactly it means is provided, for the curious on the internal workings of mothic: it's very onomatopoeic, and makes heavy use of combined words and accents

//Base ingredients and miscellany, generally not served on their own
/obj/item/food/herby_cheese
	name = "香草奶酪"
	desc = "作为蛾类料理的主食，奶酪常被加入各种风味以丰富饮食。\
		香草便是其中一种添加物，尤其受人喜爱。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "herby_cheese"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 6)
	tastes = list("cheese" = 1, "herbs" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/grilled_cheese
	name = "烤奶酪"
	desc = "正如阿尔顿勋爵（愿他的名受颂扬）所规定的，世界上 99.997% 的烤奶酪食谱都在彻头彻尾地撒谎：\
		奶酪从未被烤过，那只是个夹着熔化奶酪的煎三明治。而这一份，才是名副其实的烤奶酪，连烤痕都一应俱全。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "grilled_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("cheese" = 1, "char" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/mothic_salad
	name = "蛾类沙拉"
	desc = "卷心菜、红洋葱和番茄制成的基础沙拉。可作为无数种沙拉的完美基底。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothic_salad"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("salad" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/toasted_seeds
	name = "烤种子"
	desc = "虽然远谈不上管饱，烤种子却是蛾类中很受欢迎的零食。\
		可以加入盐、糖，甚至一些更异域的风味来增添几分活力。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "toasted_seeds"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("seeds" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/engine_fodder
	name = "轮机口粮"
	desc = "蛾类舰队工程师的常见零食，由种子、坚果、巧克力、爆米花和薯片制成——\
		热量密集，方便在需要额外能量时随手补充。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "engine_fodder"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("seeds" = 1, "nuts" = 1, "chocolate" = 1, "salt" = 1, "popcorn" = 1, "potato" = 1)
	foodtypes = JUNKFOOD|GRAIN|FRIED|NUTS|VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/mothic_pizza_dough
	name = "蛾式披萨面团"
	desc = "一种筋道、含麸质的玉米面与面粉面团，专为承载奶酪和酱汁而做。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothic_pizza_dough"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("raw flour" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

//Entrees: categorising food that is 90% cheese and salad is not easy
/obj/item/food/squeaking_stir_fry
	name = "skeklitmischtpoppl" //skeklit = squeaking, mischt = stir, poppl = fry
	desc = "一道用奶酪凝块和豆腐（以及别的东西）制成的蛾类经典菜。\
		直译其名意为“吱吱炒”，之所以得名，是因为其中的蛋白质会发出独特的吱吱声。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "squeaking_stir_fry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("cheese" = 1, "tofu" = 1, "veggies" = 1)
	foodtypes = DAIRY|VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/sweet_chili_cabbage_wrap
	name = "甜辣卷心菜卷"
	desc = "烤奶酪和沙拉裹在卷心菜叶中，淋上美味的甜辣酱。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "sweet_chili_cabbage_wrap"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("cheese" = 1, "salad" = 1, "sweet chili" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/loaded_curds
	name = "ozlsettitæloskekllön ede pommes" //ozlsettit = overflowing (ozl = over, sett = flow, it = ing), ælo = cheese, skekllön = curds (skeklit = squeaking, llön = pieces/bits), ede = and, pommes = fries (hey, France!)
	desc = "还有什么比奶酪凝块更好？油炸奶酪凝块！还有什么比油炸奶酪凝块更好？\
		上面浇上辣酱（以及更多奶酪）的油炸奶酪凝块！还有比这更好的吗？把它放在薯条上！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "loaded_curds"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("cheese" = 1, "oil" = 1, "chili" = 1, "fries" = 1)
	foodtypes = VEGETABLES|DAIRY|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/baked_cheese
	name = "烤奶酪轮"
	desc = "一轮烤奶酪，融化香浓，美味可口。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "baked_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/nutriment = 5,
	)
	tastes = list("cheese" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/baked_cheese_platter
	name = "stanntkraktælo" //stannt = oven, krakt = baked, ælo = cheese
	desc = "一轮烤奶酪：蛾类最爱的分享美食。通常搭配酥脆的面包片蘸着吃，\
		因为唯一比好奶酪更好的，就是放在面包上的好奶酪。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "baked_cheese_platter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("cheese" = 1, "bread" = 1)
	foodtypes = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Baked Green Lasagna at the Whistlestop Cafe
/obj/item/food/raw_green_lasagne
	name = "生青酱烤千层面"
	desc = "用青酱和香草白酱制成的上等千层面，随时可以入炉烘烤。适合多人分食。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_green_lasagne"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY|NUTS|RAW
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_green_lasagne/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/green_lasagne, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/green_lasagne
	name = "青酱烤千层面"
	desc = "用青酱和香草白酱制成的上等千层面。适合多人分食。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "green_lasagne"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 24,
		/datum/reagent/consumable/nutriment/vitamin = 18,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY|NUTS
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/green_lasagne/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/green_lasagne_slice, 6, 3 SECONDS, table_required = TRUE,  screentip_verb = "Slice", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/green_lasagne_slice
	name = "青酱烤千层面切片"
	desc = "一片香草青酱千层面。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "green_lasagne_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY|NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_baked_rice
	name = "大米烤盘"
	desc = "一大盘分层土豆，上面铺着米饭和蔬菜高汤，随时可烤成美味的分享餐。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_baked_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtypes = VEGETABLES | GRAIN | RAW
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_baked_rice/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/big_baked_rice, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/big_baked_rice
	name = "大份焗饭"
	desc = "焗饭是蛾类的最爱，可填入各种蔬菜馅料，做成一道可供分享的美味。\
		烹饪容器底部也常铺上土豆，形成一层风味十足的锅巴，食客们常为此争抢。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "big_baked_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 18,
		/datum/reagent/consumable/nutriment/vitamin = 42,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/big_baked_rice/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/lil_baked_rice, 6, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/lil_baked_rice
	name = "小份焗饭"
	desc = "一份焗饭，作为配菜恰到好处，甚至可当作正餐。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "lil_baked_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/oven_baked_corn
	name = "烤箱烤玉米"
	desc = "一根玉米棒，在烤箱的炙热中烤至起泡发黑。\
		在舰队上，它因能快速为菜肴增添风味和饱腹感而备受喜爱。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "oven_baked_corn"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "char" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/buttered_baked_corn
	name = "黄油烤玉米"
	desc = "还有什么比烤玉米更好？加了黄油的烤玉米！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "buttered_baked_corn"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "char" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fiesta_corn_skillet
	name = "节日玉米煎锅"
	desc = "甜、辣、多汁，还有各种各样的玉米味。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fiesta_corn_skillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "chili" = 1, "char" = 1)
	foodtypes = VEGETABLES|JUNKFOOD|DAIRY|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/raw_ratatouille
	name = "生普罗旺斯炖菜" //rawtatouille?
	desc = "切片蔬菜配烤椒酱。虽是平民食物，却十分美味。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_ratatouille"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("veggies" = 1, "roasted peppers" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_ratatouille/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/ratatouille, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/ratatouille
	name = "普罗旺斯炖菜"
	desc = "这道菜能完美地拯救你的餐厅，免遭恶毒美食评论家的毒手。如果你帽子里还藏着一只老鼠，那就更棒了。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "ratatouille"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("veggies" = 1, "roasted peppers" = 1, "char" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/mozzarella_sticks
	name = "马苏里拉奶酪棒"
	desc = "一根根马苏里拉奶酪，裹上面包屑油炸而成。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mozzarella_sticks"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("creamy cheese" = 1, "breading" = 1, "oil" = 1)
	foodtypes = GRAIN|DAIRY|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/raw_stuffed_peppers
	name = "生 voltölpaprik" //voltöl = stuffed (vol = full, töl = push), paprik (from German paprika) = bell pepper
	desc = "切去顶部的甜椒，内里塞满香草奶酪洋葱馅。大概不该生吃。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_stuffed_pepper"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("creamy cheese" = 1, "herbs" = 1, "onion" = 1, "bell pepper" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_stuffed_peppers/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/stuffed_peppers, rand(10 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/stuffed_peppers
	name = "voltölpaprik"
	desc = "一颗柔软却依然爽脆的甜椒，内里是美妙融化的奶酪。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "stuffed_pepper"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("creamy cheese" = 1, "herbs" = 1, "onion" = 1, "bell pepper" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/fueljacks_lunch
	name = "\improper 燃料工的午餐"
	desc = "一道用油炸蔬菜制成的菜，在燃料工中很受欢迎——他们是勇敢的蛾类，驾驶燃料采集船维持舰队运转。\
		由于燃料需求不断，而星象适合采集的时间窗口（字面意义上）又十分有限，\
		他们常会带上打包饭菜以省去往返食堂的工夫，并用刚装满的燃料罐加热。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fueljacks_lunch"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("cabbage" = 1, "potato" = 1, "onion" = 1, "chili" = 1, "cheese" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/mac_balls
	name = "macheronirölen"
	desc = "通心粉奶酪球裹上玉米面糊油炸，配番茄酱食用。\
		这是银河系广受欢迎的零食，尤其在蛾类舰队上——那里的人习惯用 Ready-Donk 作基底。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mac_balls"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 10,
	)
	tastes = list("pasta" = 1, "cornbread" = 1, "cheese" = 1)
	foodtypes = DAIRY | VEGETABLES | FRIED | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/sustenance_bar
	name = "舰队盈余 PSB"
	desc = "PSB，即预包装营养棒，是一种密度高、营养丰富的食品，旨在粮食短缺时期\
		让民众撑过难关。它由大豆和豌豆蛋白制成，若合理分配，每根可维持 3 天。虽然保质期很长，\
		但终究会变质——于是被舰队作为盈余出售。这一根，如同大多数人工调味的蛾类食品一样，是混合香草味的。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "sustenance_bar"
	trash_type = /obj/item/trash/fleet_ration
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("herbs" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/sustenance_bar/neapolitan
	name = "舰队盈余 PSB——那不勒斯风味"
	desc = "PSB，即预包装营养棒，是一种密度高、营养丰富的食品，旨在粮食短缺时期\
		让民众撑过难关。它由大豆和豌豆蛋白制成，若合理分配，每根可维持 3 天。虽然保质期很长，\
		但终究会变质——于是被舰队作为盈余出售。这一根是那不勒斯风味的——草莓、香草和巧克力。"
	tastes = list("strawberry" = 1, "vanilla" = 1, "chocolate" = 1)

/obj/item/food/sustenance_bar/cheese
	name = "舰队盈余 PSB——三重奶酪风味"
	desc = "PSB，即预包装营养棒，是一种密度高、营养丰富的食品，旨在粮食短缺时期\
		让民众撑过难关。它由大豆和豌豆蛋白制成，若合理分配，每根可维持 3 天。虽然保质期很长，\
		但终究会变质——于是被舰队作为盈余出售。这一根是三重奶酪风味的——帕玛森、马苏里拉和切达。"
	tastes = list("parmesan" = 1, "mozzarella" = 1, "cheddar" = 1)

/obj/item/food/sustenance_bar/mint
	name = "舰队盈余 PSB——薄荷巧克力碎风味"
	desc = "PSB，即预包装营养棒，是一种密度高、营养丰富的食品，旨在粮食短缺时期\
		让民众撑过难关。它由大豆和豌豆蛋白制成，若合理分配，每根可维持 3 天。虽然保质期很长，\
		但终究会变质——于是被舰队作为盈余出售。这一根是薄荷巧克力碎风味的——薄荷、\
		黑巧克力，还有薯片，足见蛾类根本不知道薄荷巧克力碎是什么。"
	tastes = list("peppermint" = 1, "potato chips(?)" = 1, "dark chocolate" = 1)

/obj/item/food/sustenance_bar/wonka
	name = "舰队盈余 PSB——三道式晚餐"
	desc = "PSB，即预包装营养棒，是一种密度高、营养丰富的食品，旨在粮食短缺时期\
		让民众撑过难关。它由大豆和豌豆蛋白制成，若合理分配，每根可维持 3 天。虽然保质期很长，\
		但终究会变质——于是被舰队作为盈余出售。这一根分为三种风味，\
		组成一顿典型的餐食——番茄汤、烤南瓜和蓝莓派。" //Thankfully not made by Willy Wonka
	tastes = list("tomato soup" = 1, "roast pumpkin" = 1, "blueberry pie" = 1)

/obj/item/food/bowled/fried_eggplant_polenta
	name = "炸茄子配玉米糊"
	desc = "铺满奶酪的玉米糊，配几片炸茄子和一些番茄酱。Lække！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fried_eggplant_polenta"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 10,
	)
	tastes = list("cornmeal" = 1, "cheese" = 1, "eggplant" = 1, "tomato sauce" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

//Salads: the bread and butter of mothic cuisine
/obj/item/food/caprese_salad
	name = "卡普里沙拉"
	desc = "虽然卡普里沙拉绝非蛾类的原创，但它已成为舰队上的一道人气菜，\
		因为它制作简单却十分美味。蛾类称之为 zaileskenknusksolt：\
		用银河通用语说，就是“双色沙拉”。" //zail = two, esken = colour/tone, knuskolt = salad
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "caprese_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("mozzarella" = 1, "tomato" = 1, "balsamic" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/fleet_salad
	name = "lörtonknusksolt" //lörton = fleet, knusksolt = salad (knusk = crisp, solt = bowl)
	desc = "Lörtonknusksolt，用银河通用语说就是“舰队沙拉”，常见于舰队上的小吃吧和食堂。\
		其中的烤奶酪让它格外管饱，而面包丁则带来酥脆的口感。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fleet_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 12,
	)
	tastes = list("cheese" = 1, "salad" = 1, "bread" = 1)
	foodtypes = DAIRY | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/salad/cotton_salad
	name = "flöfrölenknusksolt"
	desc = "一份加入棉花和基础沙拉酱的沙拉。想必要么是蛾类在场，要么是南方又起义了。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "cotton_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 14,
	)
	tastes = list("cheese" = 1, "salad" = 1, "bread" = 1)
	foodtypes = VEGETABLES | CLOTH
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/salad/moth_kachumbari
	name = "\improper Kæniatknusksolt" //Kæniat = Kenyan, knusksolt = salad
	desc = "卡琼巴里原本是肯尼亚食谱，是又一道被蛾类采纳的人类跨文化人气菜肴——\
		不过有些食材不得不做了替换。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "moth_kachumbari"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 18,
	)
	tastes = list("onion" = 1, "tomato" = 1, "corn" = 1, "chili" = 1, "cilantro" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Pizza
/obj/item/food/raw_mothic_margherita
	name = "生蛾式玛格丽特披萨"
	desc = "又一道被蛾类采纳的人类经典，蛾式披萨的特点是使用新鲜食材，\
		尤其是新鲜马苏里拉，以及用高筋面粉揉出含麸质的面团。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_margherita_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "tomato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_margherita/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_margherita, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_margherita
	name = "蛾式玛格丽特披萨"
	desc = "蛾式披萨的一大特点是按重量出售——单块切片可用零花钱购买，而一张餐券则能买下整张饼。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "margherita_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_margherita
	boxtag = "莫弗奇风味玛格丽特"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_margherita
	name = "蛾式玛格丽特披萨切片"
	desc = "一片蛾式玛格丽特披萨，最朴素的一种披萨。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "margherita_slice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_firecracker
	name = "生蛾式爆竹披萨"
	desc = "爆竹披萨是更爱冒险的蛾类的最爱，辣辣辣！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_firecracker_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/bbqsauce = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("dough" = 1, "chili" = 1, "corn" = 1, "cheese" = 1, "bbq sauce" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_firecracker/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_firecracker, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_firecracker
	name = "蛾式爆竹披萨"
	desc = "他们管这叫“火辣披萨派”可不是开玩笑。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "firecracker_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/bbqsauce = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("crust" = 1, "chili" = 1, "corn" = 1, "cheese" = 1, "bbq sauce" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_firecracker
	boxtag = "维苏威爆竹"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_firecracker
	name = "蛾式爆竹披萨切片"
	desc = "一片辣味十足、相当不错的东西。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "firecracker_slice"
	tastes = list("crust" = 1, "chili" = 1, "corn" = 1, "cheese" = 1, "bbq sauce" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_five_cheese
	name = "生蛾式五重奶酪披萨"
	desc = "几个世纪以来，学者们一直在问：多少奶酪才算奶酪过量？"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_five_cheese_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_five_cheese/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_five_cheese, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_five_cheese
	name = "蛾式五重奶酪披萨"
	desc = "老鼠、大鼠和英国发明家的最爱。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "five_cheese_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_five_cheese
	boxtag = "奶酪爆炸"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_five_cheese
	name = "蛾式五重奶酪披萨切片"
	desc = "这是银河系奶酪最多的一片！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "five_cheese_slice"
	tastes = list("crust" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_white_pie
	name = "生蛾式白派披萨"
	desc = "为讨厌番茄的人制作的披萨。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_white_pie_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "cheese" = 1, "herbs" = 1, "garlic" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_white_pie/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_white_pie, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_white_pie
	name = "蛾式白派披萨"
	desc = "你说 to-may-to，我说 to-mah-to，而我们这张披萨上两种都没放。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "white_pie_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "cheese" = 1, "herbs" = 1, "garlic" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_white_pie
	boxtag = "白面包"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_white_pie
	name = "蛾式白派披萨切片"
	desc = "奶酪香、蒜香、香草香，美味！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "white_pie_slice"
	tastes = list("crust" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_pesto
	name = "生蛾式青酱披萨"
	desc = "青酱是蛾类中很受欢迎的披萨配料，很可能因为它完美体现了他们最爱的风味：奶酪、香草和蔬菜。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_pesto_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "pesto" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | NUTS | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_pesto/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_pesto, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_pesto
	name = "蛾式青酱披萨"
	desc = "绿得像花园里的草。虽说蛾类飞船上的花园并不多。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "pesto_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "pesto" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | NUTS
	slice_type = /obj/item/food/pizzaslice/mothic_pesto
	boxtag = "速速青酱"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_pesto
	name = "蛾式青酱披萨切片"
	desc = "一片速速青酱披萨。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "pesto_slice"
	tastes = list("crust" = 1, "pesto" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | NUTS
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_garlic
	name = "生蛾式蒜香披萨面包"
	desc = "啊，大蒜。一种普世喜爱的食材——也许除了吸血鬼。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_garlic_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "garlic" = 1, "butter" = 1)
	foodtypes = GRAIN|VEGETABLES|RAW|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/raw_mothic_garlic/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_garlic, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_garlic
	name = "蛾式蒜香披萨面包"
	desc = "银河系最好的食物，毫无疑问。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "garlic_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "garlic" = 1, "butter" = 1)
	foodtypes = GRAIN|VEGETABLES|DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_garlic
	boxtag = "莫弗奇风味蒜香面包"
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizzaslice/mothic_garlic
	name = "蛾式蒜香披萨面包切片"
	desc = "蛾类所知的最佳组合：油香、蒜香和酥脆。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "garlic_slice"
	tastes = list("dough" = 1, "garlic" = 1, "butter" = 1)
	foodtypes = GRAIN|VEGETABLES|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4

//Bread
/obj/item/food/bread/corn
	name = "玉米面包"
	desc = "地道的乡村风味、策马奔腾、左轮连射、活见鬼的“耶哈”玉米面包。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "cornbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 18)
	tastes = list("cornbread" = 10)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	slice_type = /obj/item/food/breadslice/corn
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/breadslice/corn
	name = "玉米面包切片"
	desc = "一块酥脆的牛仔风格玉米面包。心满意足地吃吧。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "cornbread_slice"
	foodtypes = GRAIN
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	crafting_complexity = FOOD_COMPLEXITY_2

//Sweets
/obj/item/food/moth_cheese_cakes
	name = "\improper ælorölen" //ælo = cheese, rölen = balls
	desc = "Ælorölen（奶酪球）是传统的蛾类甜点，用软奶酪、糖粉和面粉滚成球状，裹上面糊后油炸。通常配巧克力酱或蜂蜜食用，有时两者都配！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "moth_cheese_cakes"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/sugar = 12,
	)
	tastes = list("cheesecake" = 1, "chocolate" = 1, "honey" = 1)
	foodtypes = SUGAR | FRIED | DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cake/mothmallow
	name = "蛾棉花糖托盘"
	desc = "轻盈蓬松的纯素棉花糖，带有香草和朗姆酒风味，上面覆盖着柔软的巧克力。蛾类称之为 höllflöfstarkken：云朵方块。" //höllflöf = cloud (höll = wind, flöf = cotton), starkken = squares
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothmallow_tray"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/sugar = 20,
	)
	tastes = list("vanilla" = 1, "clouds" = 1, "chocolate" = 1)
	foodtypes = VEGETABLES | SUGAR
	slice_type = /obj/item/food/cakeslice/mothmallow
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cakeslice/mothmallow
	name = "蛾棉花糖"
	desc = "蓬松的小小快乐云朵——颜色奇特得像蛾类。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothmallow_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("vanilla" = 1, "clouds" = 1, "chocolate" = 1)
	foodtypes = VEGETABLES | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

//misc food
/obj/item/food/bubblegum/wake_up
	name = "提神口香糖"
	desc = "一条橡胶般的口香糖，上面压印着蛾族游牧舰队的徽记。"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 13,
		/datum/reagent/drug/methamphetamine = 2,
	)
	tastes = list("herbs" = 1)
	color = "#567D46"

/obj/item/food/spacers_sidekick
	name = "\improper 太空人伙伴薄荷糖"
	desc = "太空人伙伴：有朋友相伴，呼吸更顺畅！"
	icon_state = "spacers_sidekick"
	trash_type = /obj/item/trash/spacers_sidekick
	food_reagents = list(
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/menthol = 1,
		/datum/reagent/medicine/salbutamol = 1,
	)
	tastes = list("strong mint" = 1)
	junkiness = 15
	foodtypes = JUNKFOOD
	w_class = WEIGHT_CLASS_SMALL
