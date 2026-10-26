/// Handpicked list of various pizzas and "pizzas" to make sure it's both 'safe' (human-edible) and doesn't spawn the base type like the bomb pizza can.
#define EDIBLE_PIZZA_LIST list( \
	/obj/item/food/pizza/margherita, \
	/obj/item/food/pizza/meat, \
	/obj/item/food/pizza/mushroom, \
	/obj/item/food/pizza/vegetable, \
	/obj/item/food/pizza/donkpocket, \
	/obj/item/food/pizza/dank, \
	/obj/item/food/pizza/sassysage, \
	/obj/item/food/pizza/pineapple, \
	/obj/item/food/pizza/mothic_margherita, \
	/obj/item/food/pizza/mothic_firecracker, \
	/obj/item/food/pizza/mothic_five_cheese, \
	/obj/item/food/pizza/mothic_white_pie, \
	/obj/item/food/pizza/mothic_pesto, \
	/obj/item/food/pizza/mothic_garlic, \
	/obj/item/food/pizza/flatbread/rustic, \
	/obj/item/food/pizza/flatbread/italic, \
	/obj/item/food/pizza/flatbread/zmorgast, \
	/obj/item/food/pizza/flatbread/fish, \
	/obj/item/food/pizza/flatbread/mushroom, \
	/obj/item/food/pizza/flatbread/nutty, \
)

/obj/item/food/mre_course
	name = "未定义的即食口粮餐"
	desc = "你不该看到的东西。不过它能吃。"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/courses.dmi'
	icon_state = "main_course"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("蜡笔粉" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/mre_course/main
	name = "即食口粮主餐"
	desc = "古代军用口粮中为地面部队设计的主餐。这一份什么也没有。"
	tastes = list("草莓" = 1, "香草" = 1, "巧克力" = 1)

/obj/item/food/mre_course/main/beans
	name = "即食口粮主餐——猪肉炖豆"
	desc = "古代军用口粮中为地面部队设计的主餐。这一份是浇着番茄酱的猪肉炖豆。"
	tastes = list("豆子" = 1, "猪肉" = 1, "番茄酱" = 1)
	foodtypes = MEAT | VEGETABLES

/obj/item/food/mre_course/main/macaroni
	name = "即食口粮主餐——通心粉与奶酪"
	desc = "古代军用口粮中为地面部队设计的主餐。这一份是先煮好的通心粉，上面浇着联邦储备奶酪。"
	tastes = list("冷通心粉" = 1, "淡而无味的奶酪" = 1)
	foodtypes = DAIRY | GRAIN

/obj/item/food/mre_course/main/rice
	name = "即食口粮主餐——米饭与牛肉"
	desc = "古代军用口粮中为地面部队设计的主餐。这一份是浇着肉汁的牛肉米饭。"
	tastes = list("紧实的米饭" = 1, "牛肉碎" = 1, "肉汁" = 1)
	foodtypes = GRAIN | MEAT

/obj/item/food/mre_course/side
	name = "即食口粮配菜"
	desc = "古代军用口粮中为地面部队设计的配菜。这一份什么也没有。"
	icon_state = "side_dish"

/obj/item/food/mre_course/side/bread
	name = "即食口粮配菜——玉米面包"
	desc = "古代军用口粮中为地面部队设计的配菜。这一份是玉米面包。"
	tastes = list("玉米面包" = 1)
	foodtypes = GRAIN

/obj/item/food/mre_course/side/pie
	name = "即食口粮配菜——肉馅饼"
	desc = "古代军用口粮中为地面部队设计的配菜。这一份是肉馅饼。"
	tastes = list("馅饼皮" = 1, "碎肉" = 1, "德克萨斯" = 1)
	foodtypes = MEAT | GRAIN

/obj/item/food/mre_course/side/chicken
	name = "即食口粮配菜——糖醋鸡肉"
	desc = "古代军用口粮中为地面部队设计的配菜。这一份是某种说不清来历、长得像鸡肉的肉，裹着一层廉价的红褐色酱汁。"
	tastes = list("鸡肉碎" = 1, "糖醋酱" = 1, "盐" = 1)
	foodtypes = MEAT | FRIED

/obj/item/food/mre_course/dessert
	name = "即食口粮甜点"
	desc = "古代军用口粮中为地面部队设计的甜点。这一份什么也没有。"
	icon_state = "dessert"

/obj/item/food/mre_course/dessert/cookie
	name = "即食口粮甜点——曲奇饼干"
	desc = "古代军用口粮中为地面部队设计的甜点。这一份是一大块干巴巴的曲奇饼干。"
	tastes = list("干燥" = 1, "硬曲奇" = 1, "巧克力碎" = 1)
	foodtypes = GRAIN | SUGAR

/obj/item/food/mre_course/dessert/cake
	name = "即食口粮甜点——苹果派"
	desc = "古代军用口粮中为地面部队设计的甜点。这一份是一坨不成形的苹果派。"
	tastes = list("苹果" = 1, "湿润的蛋糕" = 1, "糖" = 1)
	foodtypes = GRAIN | SUGAR | FRUIT

/obj/item/food/mre_course/dessert/chocolate
	name = "即食口粮甜点——黑巧克力"
	desc = "古代军用口粮中为地面部队设计的甜点。这一份是一板黑巧克力。"
	tastes = list("香草" = 1, "人造巧克力" = 1, "化学物质" = 1)
	foodtypes = JUNKFOOD | SUGAR

/obj/item/storage/box/hecu_rations
	name = "即食口粮"
	desc = "一盒装着几份口粮和一些口香糖，好让饿着肚子的吃蜡笔的家伙撑下去。"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/mre_hecu.dmi'
	icon_state = "mre_package"
	illustration = null

/obj/item/storage/box/hecu_rations/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 5

/obj/item/storage/box/hecu_rations/PopulateContents()
	var/main_course = pick(/obj/item/food/mre_course/main/beans, /obj/item/food/mre_course/main/macaroni, /obj/item/food/mre_course/main/rice)
	var/side_dish = pick(/obj/item/food/mre_course/side/bread, /obj/item/food/mre_course/side/pie, /obj/item/food/mre_course/side/chicken)
	var/dessert = pick(/obj/item/food/mre_course/dessert/cookie, /obj/item/food/mre_course/dessert/cake, /obj/item/food/mre_course/dessert/chocolate)
	new main_course(src)
	new side_dish(src)
	new dessert(src)
	new /obj/item/storage/box/gum(src)
	new /obj/item/food/spacers_sidekick(src)

/obj/item/pizzabox/random
	boxtag = "兰迪的惊喜"
	boxtag_set = TRUE

/obj/item/pizzabox/random/Initialize(mapload)
	. = ..()
	if(!pizza)
		var/random_pizza = pick(EDIBLE_PIZZA_LIST)
		pizza = new random_pizza(src)

#undef EDIBLE_PIZZA_LIST
