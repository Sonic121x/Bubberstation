/obj/item/reagent_containers/condiment/flour/small_ration
	name = "小袋面粉"
	desc = "按航海配给标准分装的面粉，恰好能烤一条像样的面包，为一天补充能量。"
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	list_reagents = list(/datum/reagent/consumable/flour = 15)

/obj/item/reagent_containers/condiment/rice/small_ration
	name = "小袋大米"
	desc = "按航海配给标准分装的大米，恰好能做出宇宙中最寒酸的一份米饭。"
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	list_reagents = list(/datum/reagent/consumable/rice = 10)

/obj/item/reagent_containers/condiment/sugar/small_ration
	name = "小袋糖"
	desc = "按航海配给标准分装的糖，恰好能让这一天甜上那么一丁点。"
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	list_reagents = list(/datum/reagent/consumable/sugar = 10)

/obj/item/reagent_containers/condiment/small_ration_korta_flour
	name = "小袋科塔粉"
	desc = "按航海配给标准分装的科塔粉，恰好能烤一条像样的面包，为一天补充能量。"
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	icon_state = "flour_korta"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/korta_flour = 10)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/soymilk/small_ration
	name = "小盒豆奶"
	desc = "豆奶，洁白又营养的好东西！这盒比普通包装小得多，恰好够做一些根茎面团。"
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	list_reagents = list(/datum/reagent/consumable/soymilk = 15)

/obj/item/reagent_containers/condiment/milk/small_ration
	name = "小盒牛奶"
	desc = "牛奶，洁白又营养的好东西！这盒比普通包装小得多，恰好够做一些奶酪。"
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	list_reagents = list(/datum/reagent/consumable/milk = 15)

/obj/item/reagent_containers/condiment/dashi_concentrate/small_ration
	name = "小份出汁"
	desc = "小容器装的浓缩出汁，恰好够调一些用于烹饪的高汤！"
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	list_reagents = list(/datum/reagent/consumable/dashi_concentrate = 5)

/obj/item/reagent_containers/cup/glass/bottle/small/tiny
	name = "迷你玻璃瓶"
	volume = 10

/obj/item/reagent_containers/cup/glass/bottle/small/tiny/Initialize(mapload, vol)
	. = ..()
	transform = transform.Scale(0.75, 0.75)

/obj/item/reagent_containers/cup/glass/bottle/small/tiny/lime_juice
	name = "迷你青柠汁瓶"
	desc = "按航海配给标准分装的一小瓶青柠汁，足够在漫长航程中预防坏血病。"
	list_reagents = list(/datum/reagent/consumable/limejuice = 10)

/obj/item/reagent_containers/cup/glass/bottle/small/tiny/vinegar
	name = "迷你醋瓶"
	desc = "按航海配给标准分装的一小瓶醋，足够用来……好吧，我们也不太确定，但法律规定必须发给你，所以……"
	list_reagents = list(/datum/reagent/consumable/vinegar = 10)

/obj/item/reagent_containers/cup/glass/bottle/small/tiny/coffee
	name = "迷你咖啡粉瓶"
	desc = "按航海配给标准分装的一小瓶咖啡粉，足够冲一份早晨的咖啡。"
	list_reagents = list(/datum/reagent/toxin/coffeepowder = 10)

/obj/item/reagent_containers/cup/glass/bottle/small/tiny/tea
	name = "迷你茶粉瓶"
	desc = "按航海配给标准分装的一小瓶茶粉，足够冲一份早茶。"
	list_reagents = list(/datum/reagent/toxin/teapowder = 10)

/obj/item/reagent_containers/cup/glass/bottle/small/tiny/honey
	name = "迷你蜂蜜瓶"
	desc = "按航海配给标准分装的一小瓶蜂蜜，一丁点蜂蜜为你的一天添一丁点甜。"
	list_reagents = list(/datum/reagent/consumable/honey = 5)

/obj/item/reagent_containers/cup/glass/bottle/small/tiny/caramel
	name = "迷你焦糖瓶"
	desc = "按航海配给标准分装的一小瓶焦糖。过去发的是一种叫“糖蜜”的东西，\
		也就是精炼糖留下的黏稠残渣。如今政府足够富裕，直接改发焦糖了。"
	list_reagents = list(/datum/reagent/consumable/caramel = 10)
