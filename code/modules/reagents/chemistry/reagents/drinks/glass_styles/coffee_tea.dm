// Coffees and Teas

/datum/glass_style/drinking_glass/coffee
	required_drink_type = /datum/reagent/consumable/coffee
	name = "一杯咖啡"
	desc = "别把它弄掉了，否则滚烫的液体和玻璃碎片会飞得到处都是。"

/datum/glass_style/drinking_glass/tea
	required_drink_type = /datum/reagent/consumable/tea
	name = "一杯茶"
	desc = "用它来喝茶似乎不太对劲。"
	icon_state = "teaglass"

/datum/glass_style/drinking_glass/icecoffee
	required_drink_type = /datum/reagent/consumable/icecoffee
	name = "冰咖啡"
	desc = "一杯让你精神一振、焕然一新的饮品！"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "icedcoffeeglass"

/datum/glass_style/drinking_glass/hot_ice_coffee
	required_drink_type = /datum/reagent/consumable/hot_ice_coffee
	name = "热冰咖啡"
	desc = "一杯烈性饮品——这玩意儿可不便宜。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "hoticecoffee"

/datum/glass_style/drinking_glass/icetea
	required_drink_type = /datum/reagent/consumable/icetea
	name = "冰茶"
	desc = "全天然、富含抗氧化剂的味觉盛宴。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "icedteaglass"

/datum/glass_style/drinking_glass/soy_latte
	required_drink_type = /datum/reagent/consumable/soy_latte
	name = "豆奶拿铁"
	desc = "读书时来一杯，清爽又惬意。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "soy_latte"

/datum/glass_style/drinking_glass/cafe_latte
	required_drink_type = /datum/reagent/consumable/cafe_latte
	name = "咖啡拿铁"
	desc = "读书时来一杯，醇厚又清爽。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "cafe_latte"

/datum/glass_style/drinking_glass/pumpkin_latte
	required_drink_type = /datum/reagent/consumable/pumpkin_latte
	name = "南瓜拿铁"
	desc = "咖啡与南瓜汁的混合饮品。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "pumpkin_latte"

/datum/glass_style/has_foodtype/drinking_glass/hot_coco
	required_drink_type = /datum/reagent/consumable/hot_coco
	name = "一杯热可可"
	desc = "冬季最受欢迎的热饮，暖身又暖心。"
	drink_type = SUGAR | DAIRY

/datum/glass_style/drinking_glass/italian_coco
	required_drink_type = /datum/reagent/consumable/italian_coco
	name = "一杯意式可可"
	desc = "冬季经典的新潮演绎，专为取悦味蕾而生。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "italiancoco"

/datum/glass_style/drinking_glass/mushroom_tea
	required_drink_type = /datum/reagent/consumable/mushroom_tea
	name = "一杯蘑菇茶"
	desc = "作为饮品来说，鲜得有些奇怪。"
	icon_state = "mushroom_tea_glass"

/datum/glass_style/drinking_glass/t_letter
	required_drink_type = /datum/reagent/consumable/t_letter
	name = "一杯 T"
	desc = "第二十个字母。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "tletter"
