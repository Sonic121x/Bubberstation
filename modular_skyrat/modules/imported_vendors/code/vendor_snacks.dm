// Snacks and drinks for the 'snacks' tab of vendors

/obj/item/food/vendor_snacks
	name = "\improper 世上最强劲零食"
	desc = "你最好祈祷自己不是罪人。（你本不该看到这个物品，请上报此问题）"
	icon = 'modular_skyrat/modules/imported_vendors/icons/imported_quick_foods.dmi'
	icon_state = "foodpack_generic"
	trash_type = /obj/item/trash/vendor_trash
	bite_consumption = 10
	food_reagents = list(/datum/reagent/consumable/nutriment = INFINITY)
	junkiness = 10
	custom_price = PAYCHECK_LOWER * INFINITY
	tastes = list("太阳无可匹敌的力量" = 10)
	foodtypes = JUNKFOOD | CLOTH | GORE | NUTS | FRIED | FRUIT //You don't want to know what's in the broken debug snacks
	w_class = WEIGHT_CLASS_SMALL

/obj/item/trash/vendor_trash
	name = "\improper 世上最孱弱零食"
	desc = "某种在过去算得上极品零食的东西的残渣。"
	icon = 'modular_skyrat/modules/imported_vendors/icons/imported_quick_foods.dmi'
	icon_state = "foodpack_generic_trash"
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)

/*
*	Yangyu Snacks
*/

/obj/item/reagent_containers/cup/glass/dry_ramen/prepared
	name = "杯装拉面"
	desc = "这份居然还自带水，太神奇了！"
	list_reagents = list(/datum/reagent/consumable/hot_ramen = 15, /datum/reagent/consumable/salt = 3)

/obj/item/reagent_containers/cup/glass/dry_ramen/prepared/hell
	name = "香辣杯装拉面"
	desc = "这份自带水，还附赠安检站都自愧不如的辣椒素！"
	list_reagents = list(/datum/reagent/consumable/hell_ramen = 15, /datum/reagent/consumable/salt = 3)

/obj/item/food/vendor_snacks/rice_crackers
	name = "米饼"
	desc = "尽管包装大部分是透明的，但在你吃下去之前，你永远无法真正知道这是什么口味。"
	icon_state = "rice_cracka"
	trash_type = /obj/item/trash/vendor_trash/rice_crackers
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/rice = 2)
	tastes = list("难以理解的口味" = 1, "米饼" = 2)
	foodtypes = JUNKFOOD | GRAIN
	custom_price = PAYCHECK_LOWER * 0.8

/obj/item/food/vendor_snacks/rice_crackers/make_leave_trash()
	AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/trash/vendor_trash/rice_crackers
	name = "空米饼袋"
	desc = "你终究还是没能弄清那究竟是什么口味，对吧？"
	icon_state = "rice_cracka_trash"

/obj/item/food/vendor_snacks/mochi_ice_cream
	name = "麻薯冰淇淋球 - 香草"
	desc = "一盒六个麻薯冰淇淋，也就是被麻薯包裹的香草冰淇淋。附有一根小塑料签供食用。"
	icon_state = "mochi_ice"
	trash_type = /obj/item/trash/vendor_trash/mochi_ice_cream
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/ice = 3)
	tastes = list("米糕" = 2, "香草" = 2)
	foodtypes = JUNKFOOD | DAIRY | GRAIN
	custom_price = PAYCHECK_LOWER

/obj/item/food/vendor_snacks/mochi_ice_cream/matcha
	name = "麻薯冰淇淋球 - 抹茶"
	desc = "一盒六个麻薯冰淇淋——更确切地说，是被麻薯包裹的抹茶冰淇淋。附有一根小塑料签供食用。"
	icon_state = "mochi_ice_green"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/tea = 2)
	tastes = list("米糕" = 1, "微苦抹茶" = 2)
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/food/vendor_snacks/mochi_ice_cream/matcha/examine_more(mob/user)
	. = ..()
	. += span_notice("容器上的一张小标签注明，这款冰淇淋仅使用在太阳系之外种植的烹饪级抹茶制作。")
	return .

/obj/item/trash/vendor_trash/mochi_ice_cream
	name = "空麻薯冰淇淋托盘"
	desc = "不知为何，随附的那根小塑料签已经不见了。"
	icon_state = "mochi_ice_trash"

/obj/item/reagent_containers/cup/glass/waterbottle/tea
	name = "一瓶茶"
	desc = "一瓶以方便的塑料瓶装茶。"
	icon = 'modular_skyrat/modules/imported_vendors/icons/imported_quick_foods.dmi'
	icon_state = "tea_bottle"
	list_reagents = list(/datum/reagent/consumable/tea = 40)
	cap_icon_state = "bottle_cap_tea"
	flip_chance = 5 //I fucking dare you
	custom_price = PAYCHECK_LOWER * 1.2
	fill_icon_state = null

/obj/item/reagent_containers/cup/glass/waterbottle/tea/astra
	name = "一瓶星茶"
	desc = "一瓶星茶，以其茶叶冲泡后特有的奇异风味而闻名。"
	icon_state = "tea_bottle_blue"
	list_reagents = list(
		/datum/reagent/consumable/tea = 25,
		/datum/reagent/medicine/salglu_solution = 10, // I know this looks strange but this is what tea astra grinds into, tea in the year 25whatever baby
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	custom_price = PAYCHECK_LOWER * 2

/obj/item/reagent_containers/cup/glass/waterbottle/tea/strawberry
	name = "一瓶草莓茶"
	desc = "一瓶草莓味茶；不含任何真正的草莓。"
	icon_state = "tea_bottle_pink"
	list_reagents = list(/datum/reagent/consumable/pinktea = 40)
	custom_price = PAYCHECK_LOWER * 2

/obj/item/reagent_containers/cup/glass/waterbottle/tea/nip
	name = "一瓶猫薄荷茶"
	desc = "一瓶猫薄荷茶，出于安全考虑，SFDA 要求其浓度不得高于 50%。"
	icon_state = "tea_bottle_pink"
	list_reagents = list(
		/datum/reagent/consumable/catnip_tea = 20,
		/datum/reagent/consumable/pinkmilk = 20, // I can't believe they would cut my catnip
	)
	custom_price = PAYCHECK_LOWER * 2.5

/*
*	Mothic Snacks
*/

/obj/item/food/vendor_snacks/mothmallow
	name = "蛾棉花糖"
	desc = "一个真空密封袋，里面装着一只压得相当扁的蛾棉花糖，快来人救救他！"
	icon_state = "mothmallow"
	trash_type = /obj/item/trash/vendor_trash/mothmallow
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 4)
	tastes = list("香草" = 1, "棉花" = 1, "巧克力" = 1)
	foodtypes = VEGETABLES | SUGAR
	custom_price = PAYCHECK_LOWER

/obj/item/food/vendor_snacks/mothmallow/make_leave_trash()
	AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/trash/vendor_trash/mothmallow
	name = "空蛾棉花糖袋"
	desc = "他终于自由了。"
	icon_state = "mothmallow_trash"

/obj/item/food/vendor_snacks/moth_bag
	name = "引擎饲料"
	desc = "一个真空密封袋，里面装着一小份色彩缤纷的引擎饲料。"
	icon_state = "fodder"
	trash_type = /obj/item/trash/vendor_trash/moth_bag
	food_reagents = list(/datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/salt = 2)
	tastes = list("种子" = 1, "坚果" = 1, "巧克力" = 1, "盐" = 1, "爆米花" = 1, "土豆" = 1)
	foodtypes = GRAIN | NUTS | VEGETABLES | SUGAR
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/food/vendor_snacks/moth_bag/fuel_jack
	name = "燃料工的零食"
	desc = "一个真空密封袋，里面装着比平常更小块的燃料工午餐砖，于是降格成了燃料工的零食。"
	icon_state = "fuel_jack_snack"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 1)
	tastes = list("卷心菜" = 1, "土豆" = 1, "洋葱" = 1, "辣椒" = 1, "芝士" = 1)
	foodtypes = DAIRY | VEGETABLES
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/food/vendor_snacks/moth_bag/cheesecake
	name = "巧克力芝士蛋糕块"
	desc = "一个真空密封袋，里面装着一小块蛾族风味的芝士蛋糕，这一块外面裹着巧克力。"
	icon_state = "choco_cheese_cake"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/sugar = 4)
	tastes = list("芝士蛋糕" = 1, "巧克力" = 1)
	foodtypes = SUGAR | FRIED | DAIRY | GRAIN
	custom_price = PAYCHECK_LOWER * 1.4

/obj/item/food/vendor_snacks/moth_bag/cheesecake/honey
	name = "蜂蜜芝士蛋糕块"
	desc = "一个真空密封袋，里面装着一小块蛾族风味的芝士蛋糕，这一块外面裹着蜂蜜。"
	icon_state = "honey_cheese_cake"
	tastes = list("芝士蛋糕" = 1, "蜂蜜" = 1)
	foodtypes = SUGAR | FRIED | DAIRY | GRAIN

/obj/item/trash/vendor_trash/moth_bag
	name = "空蛾族零食袋"
	desc = "透明塑料让你一眼看出，这袋里已经没有给你那些长翅膀的朋友的美味了。"
	icon_state = "moth_bag_trash"

/*
*	Tiziran Snacks
*/

/obj/item/food/vendor_snacks/lizard_bag
	name = "蜜饯蘑菇"
	desc = "蜥蜴帝国的一种奇特小吃，把蘑菇蘸上焦糖；可惜的是，它似乎在焦糖完全凝固之前就被装袋了。"
	icon_state = "candied_shroom"
	trash_type = /obj/item/trash/vendor_trash/lizard_bag
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/caramel = 2)
	tastes = list("鲜香" = 1, "甜味" = 1)
	foodtypes = SUGAR | VEGETABLES
	custom_price = PAYCHECK_LOWER * 1.4 //Tiziran imports are a bit more expensive overall

/obj/item/food/vendor_snacks/lizard_bag/make_leave_trash()
	AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/food/vendor_snacks/lizard_bag/moon_jerky
	name = "月鱼肉干"
	desc = "一种鱼干，至于用的是不是月鱼，你只能祈祷了。它似乎还带着淡淡的烧烤味。"
	icon_state = "moon_jerky"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/bbqsauce = 2)
	tastes = list("鱼" = 1, "烟熏酱" = 1)
	foodtypes = MEAT
	custom_price = PAYCHECK_LOWER * 1.6

/obj/item/trash/vendor_trash/lizard_bag
	name = "空提兹拉零食袋"
	desc = "花了那么多钱进口提兹拉零食，就为了落到这步田地？"
	icon_state = "tizira_bag_trash"

/obj/item/food/vendor_snacks/lizard_box
	name = "提兹拉团子"
	desc = "一份三个的提兹拉风味团子，实际上里面什么馅都没有。"
	icon_state = "dumpling"
	trash_type = /obj/item/trash/vendor_trash/lizard_box
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	tastes = list("土豆" = 1, "泥土般的辛辣" = 1)
	foodtypes = VEGETABLES | NUTS
	custom_price = PAYCHECK_LOWER * 1.6

/obj/item/food/vendor_snacks/lizard_box/sweet_roll
	name = "蜂蜜甜卷"
	desc = "千万别让守卫发现有人偷了你最后一个。"
	icon_state = "sweet_roll"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/honey = 2)
	tastes = list("面包" = 1, "蜂蜜" = 1, "水果" = 1)
	foodtypes = VEGETABLES | NUTS | FRUIT
	custom_price = PAYCHECK_LOWER *1.8

/obj/item/trash/vendor_trash/lizard_box
	name = "空提兹拉零食盒"
	desc = "提兹拉，自 2530 年起一直在为太空塑料危机添砖加瓦。"
	icon_state = "tizira_box_trash"

/obj/item/reagent_containers/cup/glass/waterbottle/tea/mushroom
	name = "一瓶蘑菇茶"
	desc = "一瓶略带苦味的蘑菇茶，提兹拉帝国的最爱。"
	icon_state = "tea_bottle_grey"
	list_reagents = list(/datum/reagent/consumable/mushroom_tea = 40)
	custom_price = PAYCHECK_LOWER * 2


