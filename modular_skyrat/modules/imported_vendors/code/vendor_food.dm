// Packaged whole meals and sides for the 'meals' tab of vendors

/* TRASH */

/obj/item/trash/empty_food_tray
	name = "空的塑料餐盘"
	desc = "冷凝水，再加上那些你只能祈祷是食物残渣的东西，让它有点难以重复使用。"
	icon = 'modular_skyrat/modules/imported_vendors/icons/imported_quick_foods.dmi'
	icon_state = "foodtray_empty"
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/trash/empty_side_pack
	name = "空的配菜包装纸"
	desc = "遗憾的是，这里面已经没有配菜能分散你对其他“食物”的注意力了。"
	icon = 'modular_skyrat/modules/imported_vendors/icons/imported_quick_foods.dmi'
	icon_state = "foodpack_generic_trash"
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/trash/empty_side_pack/nt
	icon_state = "foodpack_nt_trash"

/obj/item/trash/empty_side_pack/yangyu
	icon_state = "foodpack_yangyu_trash"

/obj/item/trash/empty_side_pack/moth
	icon_state = "foodpack_moth_trash"

/obj/item/trash/empty_side_pack/tizira
	icon_state = "foodpack_tizira_trash"

/* MEALS */

/*
*	NT Meals
*/

/obj/item/food/vendor_tray_meal
	name = "\improper NT 餐：牛排通心粉"
	desc = "一块浸在类似肉汁里的“索尔兹伯里肉饼”，旁边还配着一份通心粉与芝士的替代混合酱。"
	icon = 'modular_skyrat/modules/imported_vendors/icons/imported_quick_foods.dmi'
	icon_state = "foodtray_sad_steak"
	trash_type = /obj/item/trash/empty_food_tray
	food_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("肉？" = 2, "芝士？" = 2, "慵懒" = 1)
	foodtypes = MEAT | GRAIN | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	///Does this food have the steam effect on it when initialized
	var/hot_and_steamy = TRUE

/obj/item/food/vendor_tray_meal/Initialize(mapload)
	. = ..()
	if(hot_and_steamy)
		overlays += mutable_appearance('icons/effects/steam.dmi', "steam_triple", ABOVE_OBJ_LAYER)

/obj/item/food/vendor_tray_meal/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你翻看包装盒的背面……</i>")
	. += "\t[span_warning("警告：本产品在存在已知所有过敏原的工厂中包装。")]"
	. += "\t[span_warning("警告：内容物可能很烫。")]"
	. += "\t[span_info("每 200 克含：钠 8 克；脂肪 25 克，其中饱和脂肪 22 克；糖 2 克。")]"
	return .

/obj/item/food/vendor_tray_meal/burger
	name = "\improper NT 餐：芝士汉堡"
	desc = "一个卖相相当凄惨的汉堡，底层面包有点发潮，芝士是荧光笔般的黄色。"
	icon_state = "foodtray_burg"
	tastes = list("面包" = 2, "肉？" = 2, "芝士？" = 2, "慵懒" = 1)
	foodtypes = MEAT | GRAIN | DAIRY

/obj/item/food/vendor_tray_meal/chicken_sandwich
	name = "\improper NT 餐：香辣鸡肉三明治"
	desc = "一个卖相相当凄惨的鸡肉三明治，那块“肉”饼裹满了人工香料，已经变成了诡异的红色。"
	icon_state = "foodtray_chickie_sandwich"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/capsaicin = 10)
	tastes = list("面包" = 2, "鸡肉？" = 2, "铺天盖地的辣味" = 2, "慵懒" = 1)
	foodtypes = MEAT | GRAIN | DAIRY

/*
*	Yangyu Meals
*/

/obj/item/food/vendor_tray_meal/ramen
	name = "\improper 明科苏：家常面"
	desc = "一块顶级工厂生产的拉面面饼，汤里漂着少量复水蔬菜和香草。"
	icon_state = "foodtray_noodle"
	tastes = list("廉价面条" = 2, "慵懒" = 1)
	foodtypes = GRAIN | VEGETABLES

/obj/item/food/vendor_tray_meal/sushi
	name = "\improper 明科苏：鲜鲤鱼卷"
	desc = "两卷寿司，从外观来看，标签大概在骗你。"
	icon_state = "foodtray_gas_station_sushi"
	tastes = list("仿太空鲤鱼" = 2, "不新鲜的米饭" = 2, "慵懒" = 1)
	foodtypes = GRAIN | SEAFOOD

/obj/item/food/vendor_tray_meal/beef_rice
	name = "\improper 明科苏：牛肉炒饭"
	desc = "几片看似烤过的牛肉，配着分量极不相称的一大堆米饭。"
	icon_state = "foodtray_beef_n_rice"
	tastes = list("廉价牛肉" = 1, "米饭" = 3, "慵懒" = 1)
	foodtypes = GRAIN | MEAT

/*
*	Mothic Meals
*/

/obj/item/food/vendor_tray_meal/pesto_pizza
	name = "\improper 主菜 - M 型：青酱披萨"
	desc = "一块长方形披萨，本该是番茄酱的位置上铺着颜色鲜绿得可疑的青酱。"
	icon_state = "foodtray_pesto_pizza"
	tastes = list("番茄？" = 2, "芝士？" = 2, "香草" = 1, "慵懒" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES

/obj/item/food/vendor_tray_meal/baked_rice
	name = "\improper 主菜 - M 型：焗饭配烤芝士"
	desc = "一些卖相欠佳的舰队风味米饭，配着一大块烤得焦硬的芝士。"
	icon_state = "foodtray_rice_n_grilled_cheese"
	tastes = list("米饭" = 2, "胡椒" = 2, "焦芝士" = 2, "慵懒" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES

/obj/item/food/vendor_tray_meal/fueljack
	name = "\improper 主菜 - M 型：燃料工套餐"
	desc = "一块扁平的燃料工午餐饼，配料似乎缺了惯有的多样性。"
	icon_state = "foodtray_fuel_jacks_meal"
	tastes = list("土豆" = 2, "卷心菜" = 2, "芝士？" = 2, "慵懒" = 1)
	foodtypes = DAIRY | VEGETABLES

/*
*	Tiziran Meals
*/

/obj/item/food/vendor_tray_meal/moonfish_nizaya
	name = "\improper 提兹拉进口：月鱼配尼扎亚面"
	desc = "一块看起来几乎像人造的月鱼肉，配着等量的尼扎亚面。"
	icon_state = "foodtray_moonfish_nizaya"
	tastes = list("鱼？" = 2, "廉价面条" = 2, "慵懒" = 1)
	foodtypes = VEGETABLES | NUTS | SEAFOOD

/obj/item/food/vendor_tray_meal/emperor_roll
	name = "\improper 提兹拉进口：皇帝卷"
	desc = "一个卖相相当凄惨的皇帝卷——如果你还能这么叫它的话；看来鱼子酱并不在预算之内。"
	icon_state = "foodtray_emperor_roll"
	tastes = list("面包" = 2, "芝士？" = 2, "肝脏？" = 2, "慵懒" = 1)
	foodtypes = VEGETABLES | NUTS | MEAT | GORE

/obj/item/food/vendor_tray_meal/mushroom_fry
	name = "\improper 提兹拉进口：炒蘑菇"
	desc = "几种大概率是因为品质太差、没法做成正经食物的蘑菇混在一起，稍微炒过之后就被倒进塑料盒里。"
	icon_state = "foodtray_shroom_fry"
	tastes = list("蘑菇" = 4, "变得富有" = 1, "慵懒" = 1)
	foodtypes = VEGETABLES

/* SIDES */

/obj/effect/spawner/random/vendor_meal_sides
	name = "随机配菜生成器"
	desc = "希望我能拿到一份真正配得上我这顿饭的配菜。"
	icon_state = "loot"

/*
*	NT Sides
*/

/obj/effect/spawner/random/vendor_meal_sides/nt
	name = "随机 NT 配菜生成器"

/obj/effect/spawner/random/vendor_meal_sides/nt/Initialize(mapload)
	loot = list(
		/obj/item/food/vendor_tray_meal/side,
		/obj/item/food/vendor_tray_meal/side/crackers_and_jam,
		/obj/item/food/vendor_tray_meal/side/crackers_and_cheese,
	)
	. = ..()

/obj/item/food/vendor_tray_meal/side
	name = "\improper NT 配菜：扁面包配花生酱"
	desc = "一小叠硬邦邦的扁面包，每片配一小抹花生酱。"
	icon_state = "foodpack_nt"
	trash_type = /obj/item/trash/empty_side_pack/nt
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("硬面包" = 2, "花生酱" = 2)
	foodtypes = GRAIN
	hot_and_steamy = FALSE
	custom_price = PAYCHECK_LOWER * 2.5

/obj/item/food/vendor_tray_meal/side/crackers_and_jam
	name = "\improper NT 配菜：扁面包配浆果果酱"
	desc = "一小叠硬邦邦的扁面包，每片配一小抹说不上是什么浆果的果酱。"
	tastes = list("硬面包" = 2, "浆果" = 2)
	foodtypes = GRAIN | FRUIT

/obj/item/food/vendor_tray_meal/side/crackers_and_cheese
	name = "\improper NT 配菜：扁面包配芝士酱"
	desc = "一小叠硬邦邦的扁面包，每片配一小抹芝士。"
	tastes = list("硬面包" = 2, "芝士" = 2)
	foodtypes = GRAIN | DAIRY

/*
*	Yangyu Sides
*/

/obj/effect/spawner/random/vendor_meal_sides/yangyu
	name = "随机火星洋语配菜生成器"

/obj/effect/spawner/random/vendor_meal_sides/yangyu/Initialize(mapload)
	loot = list(
		/obj/item/food/vendor_tray_meal/side/miso,
		/obj/item/food/vendor_tray_meal/side/rice,
		/obj/item/food/vendor_tray_meal/side/pickled_vegetables,
	)
	. = ..()

/obj/item/food/vendor_tray_meal/side/miso
	name = "\improper 福赛：味噌汤"
	desc = "这真的就是一个装满味噌汤的塑料袋，若从非指定的一侧撕开，汤可能会洒出来。"
	icon_state = "foodpack_yangyu"
	trash_type = /obj/item/trash/empty_side_pack/yangyu
	tastes = list("味噌" = 2)
	foodtypes = VEGETABLES

/obj/item/food/vendor_tray_meal/side/rice
	name = "\improper 福赛：白米饭"
	desc = "一整袋白米饭，以防你的主食没能让你吃饱。"
	icon_state = "foodpack_yangyu"
	trash_type = /obj/item/trash/empty_side_pack/yangyu
	tastes = list("陈米饭" = 2)
	foodtypes = GRAIN

/obj/item/food/vendor_tray_meal/side/pickled_vegetables
	name = "\improper 福赛：腌菜"
	desc = "里面装着几样用类似醋的溶液腌制的蔬菜。"
	icon_state = "foodpack_yangyu"
	trash_type = /obj/item/trash/empty_side_pack/yangyu
	tastes = list("醋" = 4)
	foodtypes = VEGETABLES

/*
*	Mothic Sides
*/

/obj/effect/spawner/random/vendor_meal_sides/moth
	name = "随机蛾族配菜生成器"

/obj/effect/spawner/random/vendor_meal_sides/moth/Initialize(mapload)
	loot = list(
		/obj/item/food/vendor_tray_meal/side/moffin,
		/obj/item/food/vendor_tray_meal/side/cornbread,
		/obj/item/food/vendor_tray_meal/side/roasted_seeds,
	)
	. = ..()

/obj/item/food/vendor_tray_meal/side/moffin
	name = "\improper 配菜 - M 型：蛾松饼"
	desc = "把一个本来好好的蛾松饼压扁成更接近薄饼的形态后的产物。"
	icon_state = "foodpack_moth"
	trash_type = /obj/item/trash/empty_side_pack/moth
	tastes = list("布料？" = 2, "糖" = 2)
	foodtypes = CLOTH | GRAIN | SUGAR

/obj/item/food/vendor_tray_meal/side/cornbread
	name = "\improper 配菜 - M 型：玉米面包"
	desc = "一块压扁的甜玉米面包，配黄油更佳。"
	icon_state = "foodpack_moth"
	trash_type = /obj/item/trash/empty_side_pack/moth
	tastes = list("玉米面包" = 2, "甜味" = 2)
	foodtypes = GRAIN | SUGAR

/obj/item/food/vendor_tray_meal/side/roasted_seeds
	name = "\improper 配菜 - M 型：烤种子"
	desc = "一整包各式烤箱烘烤的种子。"
	icon_state = "foodpack_moth"
	trash_type = /obj/item/trash/empty_side_pack/moth
	tastes = list("种子" = 2, "焦糊" = 2)
	foodtypes = NUTS

/*
*	Tiziran Sides
*/

/obj/effect/spawner/random/vendor_meal_sides/tizira
	name = "随机提兹拉配菜生成器"

/obj/effect/spawner/random/vendor_meal_sides/tizira/Initialize(mapload)
	loot = list(
		/obj/item/food/vendor_tray_meal/side/root_crackers,
		/obj/item/food/vendor_tray_meal/side/korta_brittle,
		/obj/item/food/vendor_tray_meal/side/crispy_headcheese,
	)
	. = ..()

/obj/item/food/vendor_tray_meal/side/root_crackers
	name = "\improper 提兹拉进口：根面包饼干配肉酱"
	desc = "一小叠根面包饼干，每片配一小抹肉酱。"
	icon_state = "foodpack_tizira"
	trash_type = /obj/item/trash/empty_side_pack/tizira
	tastes = list("硬根面包" = 2, "肉酱" = 2)
	foodtypes = VEGETABLES | NUTS | MEAT

/obj/item/food/vendor_tray_meal/side/korta_brittle
	name = "\improper 提兹拉进口：科塔脆糖"
	desc = "一份切得方方正正的无糖科塔脆糖。"
	icon_state = "foodpack_tizira"
	trash_type = /obj/item/trash/empty_side_pack/tizira
	tastes = list("胡椒般的辛辣" = 2)
	foodtypes = NUTS

/obj/item/food/vendor_tray_meal/side/crispy_headcheese
	name = "\improper 提兹拉进口：酥炸裹粉头肉冻"
	desc = "一块裹了面包糠、看起来经过加工的头肉冻。"
	icon_state = "foodpack_tizira"
	trash_type = /obj/item/trash/empty_side_pack/tizira
	tastes = list("芝士" = 1, "油" = 1)
	foodtypes = MEAT | VEGETABLES | NUTS | GORE
