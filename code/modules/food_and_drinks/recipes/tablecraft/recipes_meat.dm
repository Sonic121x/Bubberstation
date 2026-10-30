// see code/module/crafting/table.dm

////////////////////////////////////////////////KEBABS////////////////////////////////////////////////

/datum/crafting_recipe/food/humankebab
	name = "人肉烤肉串"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/meat/steak/plain/human = 2
	)
	result = /obj/item/food/kebab/human
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/kebab
	name = "烤肉串"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/meat/steak = 2
	)
	result = /obj/item/food/kebab/monkey
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/tofukebab
	name = "豆腐烤肉串"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/tofu = 2
	)
	result = /obj/item/food/kebab/tofu
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/tailkebab
	name = "蜥蜴尾烤肉串"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/organ/tail/lizard = 1
	)
	result = /obj/item/food/kebab/tail
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/fiestaskewer
	name = "节日烤串"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/grown/chili = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/corn = 1,
		/obj/item/food/grown/tomato = 1
	)
	result = /obj/item/food/kebab/fiesta
	dish_category = DISH_MEAT

////////////////////////////////////////////////MR SPIDER////////////////////////////////////////////////

/datum/crafting_recipe/food/spidereggsham
	name = "蜘蛛蛋火腿"
	reqs = list(
		/datum/reagent/consumable/salt = 1,
		/obj/item/food/spidereggs = 1,
		/obj/item/food/meat/cutlet/spider = 2
	)
	result = /obj/item/food/spidereggsham
	removed_foodtypes = TOXIC
	dish_category = DISH_MEAT

////////////////////////////////////////////////MISC RECIPE's////////////////////////////////////////////////

/datum/crafting_recipe/food/tempehstarter
	name = "天贝发酵剂"
	reqs = list(
		/obj/item/food/grown/soybeans = 5,
		/obj/item/seeds/plump = 1
	)
	result = /obj/item/food/tempehstarter
	added_foodtypes = GROSS
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/cornedbeef
	name = "腌牛肉"
	reqs = list(
		/datum/reagent/consumable/salt = 5,
		/obj/item/food/meat/steak = 1,
		/obj/item/food/grown/cabbage = 2
	)
	result = /obj/item/food/cornedbeef
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/bearsteak
	name = "熊肉菲力"
	reqs = list(
		/datum/reagent/consumable/ethanol/manly_dorf = 5,
		/obj/item/food/meat/steak/bear = 1,
	)
	tool_paths = list(/obj/item/lighter)
	result = /obj/item/food/bearsteak
	added_foodtypes = ALCOHOL
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/polar_bear_steak
	name = "极地熊吼菲力"
	reqs = list(
		/datum/reagent/consumable/ethanol/frosty_dorf = 3,
		/datum/reagent/consumable/ethanol/blue_blazer = 3,
		/obj/item/food/meat/steak/bear = 1,
	)
	result = /obj/item/food/polar_bear_steak
	added_foodtypes = ALCOHOL
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/stewedsoymeat
	name = "炖大豆肉"
	reqs = list(
		/obj/item/food/soydope = 2,
		/obj/item/food/grown/carrotlike/carrot = 1,
		/obj/item/food/grown/tomato = 1
	)
	result = /obj/item/food/stewedsoymeat
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/sausage
	name = "生香肠"
	reqs = list(
		/obj/item/food/raw_meatball = 1,
		/obj/item/food/meat/rawcutlet = 2
	)
	result = /obj/item/food/raw_sausage
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/nugget
	name = "鸡块"
	reqs = list(
		/obj/item/food/meat/cutlet = 1
	)
	result = /obj/item/food/nugget
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/rawkhinkali
	name = "生辛卡利饺"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/grown/garlic = 1,
		/obj/item/food/meatball = 1
	)
	result = /obj/item/food/rawkhinkali
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/meatbun
	name = "肉包"
	reqs = list(
		/datum/reagent/consumable/soysauce = 5,
		/obj/item/food/bun = 1,
		/obj/item/food/meatball = 1,
		/obj/item/food/grown/cabbage = 1
	)
	result = /obj/item/food/meatbun
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/pigblanket
	name = "毯中猪"
	reqs = list(
		/obj/item/food/bun = 1,
		/obj/item/food/butterslice = 1,
		/obj/item/food/meat/cutlet = 1
	)
	result = /obj/item/food/pigblanket
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/ratkebab
	name = "鼠肉串"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/deadmouse = 1
	)
	result = /obj/item/food/kebab/rat
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/doubleratkebab
	name = "双份鼠肉串"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/deadmouse = 2
	)
	result = /obj/item/food/kebab/rat/double
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/ricepork
	name = "猪肉盖饭"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/boiledrice = 1,
		/obj/item/food/meat/cutlet = 2
	)
	result = /obj/item/food/salad/ricepork
	removed_foodtypes = BREAKFAST
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/ribs
	name = "烧烤肋排"
	reqs = list(
		/datum/reagent/consumable/bbqsauce = 5,
		/obj/item/food/meat/steak = 2,
		/obj/item/stack/rods = 2
	)
	result = /obj/item/food/bbqribs
	added_foodtypes = SUGAR
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/drake_ribs
	name = "龙肋排"
	reqs = list(
		/datum/reagent/consumable/guidoferrun = 1,
		/datum/reagent/consumable/frostoil = 4,
		/datum/reagent/consumable/bbqsauce = 5,
		/obj/item/food/meat/steak/bear = 2,
		/obj/item/stack/sheet/animalhide/ashdrake = 1,
		/obj/item/stack/rods = 2
	)
	result = /obj/item/food/drake_ribs
	added_foodtypes = SUGAR
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/meatclown
	name = "肉小丑"
	reqs = list(
		/obj/item/food/meat/steak = 1,
		/obj/item/food/grown/banana = 1
	)
	result = /obj/item/food/meatclown
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/lasagna
	name = "千层面"
	reqs = list(
		/obj/item/food/meat/cutlet = 2,
		/obj/item/food/grown/tomato = 1,
		/obj/item/food/cheese/wedge = 2,
		/obj/item/food/spaghetti/raw = 1
	)
	result = /obj/item/food/lasagna
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/gumbo
	name = "黑眼豆秋葵汤"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/boiledrice = 1,
		/obj/item/food/grown/peas = 1,
		/obj/item/food/grown/chili = 1,
		/obj/item/food/meat/cutlet = 1
	)
	result = /obj/item/food/salad/gumbo
	removed_foodtypes = BREAKFAST
	dish_category = DISH_MEAT


/datum/crafting_recipe/food/fried_chicken
	name = "炸鸡"
	reqs = list(
		/obj/item/food/meat/slab/chicken = 1,
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/corn_starch = 5,
	)
	result = /obj/item/food/fried_chicken
	removed_foodtypes = RAW
	added_foodtypes = FRIED
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/beef_stroganoff
	name = "斯特罗加诺夫牛肉"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/milk = 5,
		/datum/reagent/consumable/salt = 2,
		/datum/reagent/consumable/blackpepper = 2,
		/obj/item/food/grown/mushroom = 2,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/tomato = 1,
		/obj/item/food/meat/steak = 1,
		/obj/item/reagent_containers/cup/bowl = 1,
	)
	result = /obj/item/food/beef_stroganoff
	added_foodtypes = DAIRY
	dish_category = DISH_MEAT
	unit_test_spawn_extras = list(/obj/item/food/grown/mushroom/chanterelle = 2) //generic mushrooms

/datum/crafting_recipe/food/beef_wellington
	name = "惠灵顿牛肉"
	reqs = list(
		/obj/item/food/meat/steak = 1,
		/obj/item/food/grown/mushroom = 1,
		/obj/item/food/grown/garlic = 1,
		/obj/item/food/meat/bacon = 1,
		/obj/item/food/flatdough = 1,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/salt = 2,
		/datum/reagent/consumable/blackpepper = 2
	)
	result = /obj/item/food/beef_wellington
	removed_foodtypes = BREAKFAST
	dish_category = DISH_MEAT
	unit_test_spawn_extras = list(/obj/item/food/grown/mushroom/chanterelle = 1) //generic mushrooms

/datum/crafting_recipe/food/korta_wellington
	name = "科尔塔惠灵顿"
	reqs = list(
		/obj/item/food/meat/steak = 1,
		/obj/item/food/grown/mushroom = 1,
		/obj/item/food/grown/garlic = 1,
		/obj/item/food/meat/bacon = 1,
		/obj/item/food/flatrootdough = 1,
		/datum/reagent/consumable/korta_milk = 5,
		/datum/reagent/consumable/salt = 2,
		/datum/reagent/consumable/blackpepper = 2
	)
	result = /obj/item/food/korta_wellington
	removed_foodtypes = BREAKFAST
	dish_category = DISH_MEAT
	unit_test_spawn_extras = list(/obj/item/food/grown/mushroom/chanterelle = 1) //generic mushrooms

/datum/crafting_recipe/food/full_roast
	name = "烤鸡大餐"
	reqs = list(
		/obj/item/food/meat/steak/chicken = 2,
		/obj/item/food/roastparsnip = 1,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/peas = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/food/grown/cabbage = 1,
		/obj/item/food/grown/herbs = 1,
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/gravy = 15,
		/datum/reagent/consumable/salt = 2,
		/datum/reagent/consumable/blackpepper = 2
	)
	result = /obj/item/food/roast_dinner
	added_foodtypes = GRAIN
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/full_roast_lizzy
	name = "无谷物烤鸡大餐"
	reqs = list(
		/obj/item/food/meat/steak/chicken = 2,
		/obj/item/food/roastparsnip = 1,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/peas = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/food/grown/cabbage = 1,
		/obj/item/food/grown/herbs = 1,
		/datum/reagent/consumable/korta_flour = 25,
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/blood = 5,
		/datum/reagent/consumable/salt = 2,
		/datum/reagent/consumable/blackpepper = 2
	)
	result = /obj/item/food/roast_dinner_lizzy
	added_foodtypes = NUTS
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/full_roast_tofu
	name = "无肉烤制大餐"
	reqs = list(
		/obj/item/food/tofu = 6,
		/obj/item/food/roastparsnip = 1,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/peas = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/food/grown/cabbage = 1,
		/obj/item/food/grown/herbs = 1,
		/datum/reagent/consumable/flour = 15,
		/datum/reagent/consumable/soymilk = 15,
		/datum/reagent/consumable/salt = 2,
		/datum/reagent/consumable/blackpepper = 2
	)
	result = /obj/item/food/roast_dinner_tofu
	added_foodtypes = GRAIN
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/full_english
	name = "全套英式早餐"
	reqs = list(
		/obj/item/food/sausage = 1,
		/obj/item/food/friedegg = 2,
		/obj/item/food/meat/bacon = 1,
		/obj/item/food/grown/mushroom = 1,
		/obj/item/food/grown/tomato = 1,
		/obj/item/food/canned/beans = 1,
		/obj/item/food/butteredtoast = 1
	)
	result = /obj/item/food/full_english
	dish_category = DISH_MEAT
	unit_test_spawn_extras = list(/obj/item/food/grown/mushroom/chanterelle = 1) //generic mushrooms

/datum/crafting_recipe/food/envirochow
	name = "环境口粮"
	reqs = list(
		/obj/item/food/meat/slab/corgi = 2,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	result = /obj/item/food/canned/envirochow
	removed_foodtypes = RAW|GORE
	added_foodtypes = GROSS
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/meatloaf
	name = "肉饼"
	reqs = list(
		/obj/item/food/meat/slab = 2,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/garlic = 1,
		/datum/reagent/consumable/ketchup = 10,
	)
	result = /obj/item/food/raw_meatloaf
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/sweet_and_sour_meatballs
	name = "糖醋肉丸"
	reqs = list(
		/obj/item/food/meatball = 3,
		/obj/item/food/pineappleslice = 1,
		/obj/item/food/grown/bell_pepper = 1,
		/datum/reagent/consumable/sugar = 5,
	)
	result = /obj/item/food/sweet_and_sour_meatballs
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/pineapple_skewer
	name = "菠萝烤串"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/pineappleslice = 2,
		/obj/item/food/meat/cutlet = 2,
	)
	result = /obj/item/food/kebab/pineapple_skewer
	dish_category = DISH_MEAT
	meal_category = MEAL_APPETIZER

/datum/crafting_recipe/food/wendigo_feast
	name = "温迪戈盛宴"
	reqs = list(
		/obj/item/food/drake_ribs = 1,
		/obj/item/food/polar_bear_steak = 1,
		/obj/item/wendigo_skull = 1,
		/obj/item/stack/sheet/sinew/wolf = 2,
		/obj/item/food/grown/ash_flora/vahrezjia = 1,
		/obj/item/food/grown/ash_flora/podsneyzka = 1,
	)
	result = /obj/item/food/wendigo_feast
	removed_foodtypes = ALCOHOL
	dish_category = DISH_MEAT
