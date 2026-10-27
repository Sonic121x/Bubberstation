
// see code/module/crafting/table.dm

////////////////////////////////////////////////DONUTS////////////////////////////////////////////////

/datum/crafting_recipe/food/donut
	time = 1.5 SECONDS
	name = "甜甜圈"
	reqs = list(
		/datum/reagent/consumable/sugar = 1,
		/obj/item/food/pastrybase = 1
	)
	result = /obj/item/food/donut/plain
	added_foodtypes = JUNKFOOD|SUGAR|BREAKFAST|FRIED
	removed_foodtypes = RAW
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/donut/chaos
	name = "混沌甜甜圈"
	reqs = list(
		/datum/reagent/consumable/frostoil = 5,
		/datum/reagent/consumable/capsaicin = 5,
		/obj/item/food/pastrybase = 1
	)
	added_foodtypes = JUNKFOOD|BREAKFAST|FRIED
	result = /obj/item/food/donut/chaos

/datum/crafting_recipe/food/donut/meat
	time = 1.5 SECONDS
	name = "肉甜甜圈"
	reqs = list(
		/obj/item/food/meat/rawcutlet = 1,
		/obj/item/food/pastrybase = 1
	)
	added_foodtypes = JUNKFOOD|BREAKFAST|FRIED|GORE
	result = /obj/item/food/donut/meat

/datum/crafting_recipe/food/donut/jelly
	name = "果酱甜甜圈"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 5,
		/obj/item/food/pastrybase = 1
	)
	added_foodtypes = parent_type::added_foodtypes|FRUIT
	result = /obj/item/food/donut/jelly/plain

/datum/crafting_recipe/food/donut/slimejelly
	name = "史莱姆果冻甜甜圈"
	reqs = list(
		/datum/reagent/toxin/slimejelly = 5,
		/obj/item/food/pastrybase = 1
	)
	added_foodtypes = parent_type::added_foodtypes|TOXIC
	result = /obj/item/food/donut/jelly/slimejelly/plain


/datum/crafting_recipe/food/donut/berry
	name = "莓果甜甜圈"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 3,
		/obj/item/food/donut/plain = 1
	)
	added_foodtypes = parent_type::added_foodtypes|FRUIT
	result = /obj/item/food/donut/berry

/datum/crafting_recipe/food/donut/trumpet
	name = "太空人甜甜圈"
	reqs = list(
		/datum/reagent/medicine/polypyr = 3,
		/obj/item/food/donut/plain = 1
	)

	result = /obj/item/food/donut/trumpet

/datum/crafting_recipe/food/donut/apple
	name = "苹果甜甜圈"
	reqs = list(
		/datum/reagent/consumable/applejuice = 3,
		/obj/item/food/donut/plain = 1
	)
	added_foodtypes = parent_type::added_foodtypes|FRUIT
	result = /obj/item/food/donut/apple

/datum/crafting_recipe/food/donut/caramel
	name = "焦糖甜甜圈"
	reqs = list(
		/datum/reagent/consumable/caramel = 3,
		/obj/item/food/donut/plain = 1
	)
	result = /obj/item/food/donut/caramel

/datum/crafting_recipe/food/donut/choco
	name = "巧克力甜甜圈"
	reqs = list(
		/obj/item/food/chocolatebar = 1,
		/obj/item/food/donut/plain = 1
	)
	result = /obj/item/food/donut/choco

/datum/crafting_recipe/food/donut/blumpkin
	name = "蓝瓜甜甜圈"
	reqs = list(
		/datum/reagent/consumable/blumpkinjuice = 3,
		/obj/item/food/donut/plain = 1
	)
	added_foodtypes = VEGETABLES
	result = /obj/item/food/donut/blumpkin

/datum/crafting_recipe/food/donut/bungo
	name = "邦戈甜甜圈"
	reqs = list(
		/datum/reagent/consumable/bungojuice = 3,
		/obj/item/food/donut/plain = 1
	)
	result = /obj/item/food/donut/bungo

/datum/crafting_recipe/food/donut/matcha
	name = "抹茶甜甜圈"
	reqs = list(
		/datum/reagent/toxin/teapowder = 3,
		/obj/item/food/donut/plain = 1
	)
	result = /obj/item/food/donut/matcha

/datum/crafting_recipe/food/donut/laugh
	name = "香豌豆甜甜圈"
	reqs = list(
		/datum/reagent/consumable/laughsyrup = 3,
		/obj/item/food/donut/plain = 1
	)
	result = /obj/item/food/donut/laugh

////////////////////////////////////////////////////JELLY DONUTS///////////////////////////////////////////////////////

/datum/crafting_recipe/food/donut/jelly/berry
	name = "莓果果酱甜甜圈"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 3,
		/obj/item/food/donut/jelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/berry

/datum/crafting_recipe/food/donut/jelly/trumpet
	name = "太空人果酱甜甜圈"
	reqs = list(
		/datum/reagent/medicine/polypyr = 3,
		/obj/item/food/donut/jelly/plain = 1
	)

	result = /obj/item/food/donut/jelly/trumpet

/datum/crafting_recipe/food/donut/jelly/apple
	name = "苹果果酱甜甜圈"
	reqs = list(
		/datum/reagent/consumable/applejuice = 3,
		/obj/item/food/donut/jelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/apple

/datum/crafting_recipe/food/donut/jelly/caramel
	name = "焦糖果酱甜甜圈"
	reqs = list(
		/datum/reagent/consumable/caramel = 3,
		/obj/item/food/donut/jelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/caramel

/datum/crafting_recipe/food/donut/jelly/choco
	name = "巧克力果酱甜甜圈"
	reqs = list(
		/obj/item/food/chocolatebar = 1,
		/obj/item/food/donut/jelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/choco

/datum/crafting_recipe/food/donut/jelly/blumpkin
	name = "蓝瓜果酱甜甜圈"
	reqs = list(
		/datum/reagent/consumable/blumpkinjuice = 3,
		/obj/item/food/donut/jelly/plain = 1
	)
	added_foodtypes = parent_type::added_foodtypes|VEGETABLES
	result = /obj/item/food/donut/jelly/blumpkin

/datum/crafting_recipe/food/donut/jelly/bungo
	name = "邦戈果酱甜甜圈"
	reqs = list(
		/datum/reagent/consumable/bungojuice = 3,
		/obj/item/food/donut/jelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/bungo

/datum/crafting_recipe/food/donut/jelly/matcha
	name = "抹茶果酱甜甜圈"
	reqs = list(
		/datum/reagent/toxin/teapowder = 3,
		/obj/item/food/donut/jelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/matcha

/datum/crafting_recipe/food/donut/jelly/laugh
	name = "香豌豆果酱甜甜圈"
	reqs = list(
		/datum/reagent/consumable/laughsyrup = 3,
		/obj/item/food/donut/jelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/laugh

////////////////////////////////////////////////////SLIME  DONUTS///////////////////////////////////////////////////////

/datum/crafting_recipe/food/donut/slimejelly/berry
	name = "莓果史莱姆甜甜圈"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 3,
		/obj/item/food/donut/jelly/slimejelly/plain = 1
	)
	added_foodtypes = parent_type::added_foodtypes|FRUIT
	result = /obj/item/food/donut/jelly/slimejelly/berry

/datum/crafting_recipe/food/donut/slimejelly/trumpet
	name = "太空人史莱姆甜甜圈"
	reqs = list(
		/datum/reagent/medicine/polypyr = 3,
		/obj/item/food/donut/jelly/slimejelly/plain = 1
	)

	result = /obj/item/food/donut/jelly/slimejelly/trumpet

/datum/crafting_recipe/food/donut/slimejelly/apple
	name = "苹果史莱姆甜甜圈"
	reqs = list(
		/datum/reagent/consumable/applejuice = 3,
		/obj/item/food/donut/jelly/slimejelly/plain = 1
	)
	added_foodtypes = parent_type::added_foodtypes|FRUIT
	result = /obj/item/food/donut/jelly/slimejelly/apple

/datum/crafting_recipe/food/donut/slimejelly/caramel
	name = "焦糖史莱姆甜甜圈"
	reqs = list(
		/datum/reagent/consumable/caramel = 3,
		/obj/item/food/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/slimejelly/caramel

/datum/crafting_recipe/food/donut/slimejelly/choco
	name = "巧克力史莱姆甜甜圈"
	reqs = list(
		/obj/item/food/chocolatebar = 1,
		/obj/item/food/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/slimejelly/choco

/datum/crafting_recipe/food/donut/slimejelly/blumpkin
	name = "蓝瓜史莱姆甜甜圈"
	reqs = list(
		/datum/reagent/consumable/blumpkinjuice = 3,
		/obj/item/food/donut/jelly/slimejelly/plain = 1
	)
	added_foodtypes = parent_type::added_foodtypes|VEGETABLES
	result = /obj/item/food/donut/jelly/slimejelly/blumpkin

/datum/crafting_recipe/food/donut/slimejelly/bungo
	name = "邦戈史莱姆甜甜圈"
	reqs = list(
		/datum/reagent/consumable/bungojuice = 3,
		/obj/item/food/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/slimejelly/bungo

/datum/crafting_recipe/food/donut/slimejelly/matcha
	name = "抹茶史莱姆甜甜圈"
	reqs = list(
		/datum/reagent/toxin/teapowder = 3,
		/obj/item/food/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/slimejelly/matcha

/datum/crafting_recipe/food/donut/slimejelly/laugh
	name = "香豌豆史莱姆甜甜圈"
	reqs = list(
		/datum/reagent/consumable/laughsyrup = 3,
		/obj/item/food/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/food/donut/jelly/slimejelly/laugh

////////////////////////////////////////////////WAFFLES////////////////////////////////////////////////

/datum/crafting_recipe/food/waffles
	time = 1.5 SECONDS
	name = "华夫饼"
	reqs = list(
		/obj/item/food/pastrybase = 2
	)
	result = /obj/item/food/waffles
	added_foodtypes = BREAKFAST
	dish_category = DISH_BREAD


/datum/crafting_recipe/food/soylenviridians
	name = "素肉青"
	reqs = list(
		/obj/item/food/pastrybase = 2,
		/obj/item/food/grown/soybeans = 1
	)
	result = /obj/item/food/soylenviridians // they look like waffles
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/soylentgreen
	name = "素肉绿"
	reqs = list(
		/obj/item/food/pastrybase = 2,
		/obj/item/food/meat/slab/human = 2
	)
	result = /obj/item/food/soylentgreen
	removed_foodtypes = GORE|RAW
	dish_category = DISH_PASTRY // they look like waffles


/datum/crafting_recipe/food/rofflewaffles
	name = "罗福华夫饼"
	reqs = list(
		/datum/reagent/drug/mushroomhallucinogen = 5,
		/obj/item/food/pastrybase = 2
	)
	result = /obj/item/food/rofflewaffles
	added_foodtypes = VEGETABLES|BREAKFAST
	dish_category = DISH_BREAD

////////////////////////////////////////////////DONKPOCCKETS////////////////////////////////////////////////

/datum/crafting_recipe/food/donkpocket
	time = 1.5 SECONDS
	name = "咚克口袋"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/meatball = 1
	)
	result = /obj/item/food/donkpocket/homemade
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/dankpocket
	time = 1.5 SECONDS
	name = "大麻口袋"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/grown/cannabis = 1
	)
	result = /obj/item/food/donkpocket/dank
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/donkpocket/spicy
	time = 1.5 SECONDS
	name = "辣味口袋"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/meatball = 1,
		/obj/item/food/grown/chili = 1
	)
	result = /obj/item/food/donkpocket/spicy/homemade
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/donkpocket/teriyaki
	time = 1.5 SECONDS
	name = "照烧口袋"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/meatball = 1,
		/datum/reagent/consumable/soysauce = 3
	)
	result = /obj/item/food/donkpocket/teriyaki/homemade
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/donkpocket/pizza
	time = 1.5 SECONDS
	name = "披萨口袋"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/cheese/wedge = 1,
		/obj/item/food/grown/tomato = 1
	)
	result = /obj/item/food/donkpocket/pizza
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/donkpocket/honk
	time = 1.5 SECONDS
	name = "HONK 口袋"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/grown/banana = 1,
		/datum/reagent/consumable/sugar = 3
	)
	result = /obj/item/food/donkpocket/honk
	added_foodtypes = FRUIT|SUGAR
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/donkpocket/berry
	time = 1.5 SECONDS
	name = "莓果口袋"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/grown/berries = 1
	)
	result = /obj/item/food/donkpocket/berry
	added_foodtypes = FRUIT|SUGAR
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/donkpocket/gondola
	time = 1.5 SECONDS
	name = "贡多拉口袋"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/meatball = 1,
		/datum/reagent/gondola_mutation_toxin = 5
	)
	result = /obj/item/food/donkpocket/gondola
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/donkpocket/deluxe
	time = 1.5 SECONDS
	name = "豪华咚克口袋"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/meatball = 1,
		/obj/item/food/meat/bacon = 1,
		/obj/item/food/onion_slice/red = 1
	)
	result = /obj/item/food/donkpocket/deluxe
	dish_category = DISH_PASTRY
	removed_foodtypes = BREAKFAST
	crafting_flags = parent_type::crafting_flags | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/food/donkpocket/deluxe/nocarb
	time = 1.5 SECONDS
	name = "豪华肉口袋"
	reqs = list(
		/obj/item/organ/heart = 1,
		/obj/item/food/meatball = 1,
		/obj/item/food/meat/slab = 1,
		/obj/item/food/grown/herbs = 1
	)
	result = /obj/item/food/donkpocket/deluxe/nocarb
	removed_foodtypes = VEGETABLES //The herbs are only to enhance the flavor
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/donkpocket/deluxe/vegan
	time = 1.5 SECONDS
	name = "豪华咚克卷"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/boiledrice = 1,
		/obj/item/food/grown/bell_pepper = 1,
		/obj/item/food/tofu = 2,
	)
	result = /obj/item/food/donkpocket/deluxe/vegan
	removed_foodtypes = BREAKFAST
	dish_category = DISH_PASTRY

////////////////////////////////////////////////MUFFINS////////////////////////////////////////////////

/datum/crafting_recipe/food/muffin
	time = 1.5 SECONDS
	name = "玛芬"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/food/pastrybase = 1
	)
	added_foodtypes = BREAKFAST|SUGAR|DAIRY
	result = /obj/item/food/muffin
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/berrymuffin
	name = "莓果玛芬"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/berries = 1
	)
	result = /obj/item/food/muffin/berry
	added_foodtypes = BREAKFAST|SUGAR|FRUIT|DAIRY
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/booberrymuffin
	name = "幽灵莓玛芬"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/berries = 1,
		/obj/item/ectoplasm = 1
	)
	result = /obj/item/food/muffin/booberry
	added_foodtypes = BREAKFAST|SUGAR|DAIRY
	dish_category = DISH_PASTRY

////////////////////////////////////////////OTHER////////////////////////////////////////////


/datum/crafting_recipe/food/khachapuri
	name = "哈恰普里"
	reqs = list(
		/datum/reagent/consumable/eggyolk = 2,
		/datum/reagent/consumable/eggwhite = 4,
		/obj/item/food/cheese/wedge = 1,
		/obj/item/food/bread/plain = 1
	)
	result = /obj/item/food/khachapuri
	added_foodtypes = MEAT
	dish_category = DISH_BREAD

/datum/crafting_recipe/food/sugarcookie
	time = 1.5 SECONDS
	name = "糖霜饼干"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/food/pastrybase = 1
	)
	result = /obj/item/food/cookie/sugar
	added_foodtypes = JUNKFOOD|SUGAR
	dish_category = DISH_COOKIE

/datum/crafting_recipe/food/spookyskull
	time = 1.5 SECONDS
	name = "骷髅饼干"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/milk = 5
	)
	result = /obj/item/food/cookie/sugar/spookyskull
	added_foodtypes = JUNKFOOD|SUGAR
	dish_category = DISH_COOKIE

/datum/crafting_recipe/food/spookycoffin
	time = 1.5 SECONDS
	name = "棺材饼干"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/coffee = 5
	)
	result = /obj/item/food/cookie/sugar/spookycoffin
	added_foodtypes = JUNKFOOD|SUGAR
	dish_category = DISH_COOKIE

/datum/crafting_recipe/food/fortunecookie
	time = 1.5 SECONDS
	name = "幸运饼干"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/paper = 1
	)
	parts = list(
		/obj/item/paper = 1
	)
	result = /obj/item/food/fortunecookie
	added_foodtypes = SUGAR
	dish_category = DISH_COOKIE
	requirements_mats_blacklist = list(/obj/item/paper)

/datum/crafting_recipe/food/poppypretzel
	time = 1.5 SECONDS
	name = "罂粟椒盐卷饼"
	reqs = list(
		/obj/item/seeds/poppy = 1,
		/obj/item/food/pastrybase = 1
	)
	result = /obj/item/food/poppypretzel
	added_foodtypes = SUGAR
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/plumphelmetbiscuit
	time = 1.5 SECONDS
	name = "肥盔菇饼干"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/mushroom/plumphelmet = 1
	)
	result = /obj/item/food/plumphelmetbiscuit
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/cracker
	time = 1.5 SECONDS
	name = "苏打饼干"
	reqs = list(
		/datum/reagent/consumable/salt = 1,
		/obj/item/food/doughslice = 1,
	)
	result = /obj/item/food/cracker
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/chococornet
	name = "巧克力可颂筒"
	reqs = list(
		/datum/reagent/consumable/salt = 1,
		/obj/item/food/pastrybase = 1,
		/obj/item/food/chocolatebar = 1
	)
	result = /obj/item/food/chococornet
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/oatmealcookie
	name = "燕麦饼干"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/oat = 1
	)
	result = /obj/item/food/cookie/oatmeal
	dish_category = DISH_COOKIE

/datum/crafting_recipe/food/raisincookie
	name = "葡萄干饼干"
	reqs = list(
		/obj/item/food/no_raisin = 1,
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/oat = 1
	)
	result = /obj/item/food/cookie/raisin
	removed_foodtypes = JUNKFOOD
	dish_category = DISH_COOKIE

/datum/crafting_recipe/food/cherrycupcake
	name = "樱桃杯子蛋糕"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/cherries = 1
	)
	result = /obj/item/food/cherrycupcake
	added_foodtypes = SUGAR
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/bluecherrycupcake
	name = "蓝樱桃杯子蛋糕"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/bluecherries = 1
	)
	result = /obj/item/food/cherrycupcake/blue
	added_foodtypes = SUGAR
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/jupitercupcake
	name = "木星杯子蛋糕"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/mushroom/jupitercup = 1,
		/datum/reagent/consumable/caramel = 3,
	)
	result = /obj/item/food/jupitercupcake
	added_foodtypes = SUGAR
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/honeybun
	name = "蜂蜜面包卷"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/food/honeybun
	added_foodtypes = SUGAR
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/cannoli
	name = "卡诺里卷"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/datum/reagent/consumable/milk = 1,
		/datum/reagent/consumable/sugar = 3
	)
	result = /obj/item/food/cannoli
	added_foodtypes = SUGAR
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/peanut_butter_cookie
	name = "花生酱饼干"
	reqs = list(
		/datum/reagent/consumable/peanut_butter = 5,
		/obj/item/food/pastrybase = 1
	)
	result = /obj/item/food/cookie/peanut_butter
	added_foodtypes = JUNKFOOD|NUTS
	dish_category = DISH_COOKIE

/datum/crafting_recipe/food/raw_brownie_batter
	name = "生布朗尼面糊"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/food/egg = 2,
		/datum/reagent/consumable/coco = 5,
		/obj/item/food/butterslice = 1
	)
	result = /obj/item/food/raw_brownie_batter
	added_foodtypes = GRAIN|JUNKFOOD|SUGAR
	removed_foodtypes = MEAT|RAW|EGG
	meal_category = MEAL_COMPONENT

/datum/crafting_recipe/food/peanut_butter_brownie_batter
	name = "生花生酱布朗尼面糊"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/food/egg = 2,
		/datum/reagent/consumable/coco = 5,
		/datum/reagent/consumable/peanut_butter = 5,
		/obj/item/food/butterslice = 1
	)
	result = /obj/item/food/peanut_butter_brownie_batter
	added_foodtypes = GRAIN|JUNKFOOD|SUGAR|NUTS
	removed_foodtypes = MEAT|RAW|EGG
	meal_category = MEAL_COMPONENT

/datum/crafting_recipe/food/crunchy_peanut_butter_tart
	name = "脆花生酱挞"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/datum/reagent/consumable/peanut_butter = 5,
		/obj/item/food/grown/peanut = 1,
		/datum/reagent/consumable/cream = 5,
	)
	result = /obj/item/food/crunchy_peanut_butter_tart
	added_foodtypes = JUNKFOOD|SUGAR
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/chocolate_chip_cookie
	name = "巧克力豆饼干"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/chocolatebar = 1,
	)
	result = /obj/item/food/cookie/chocolate_chip_cookie
	removed_foodtypes = JUNKFOOD
	dish_category = DISH_COOKIE

/datum/crafting_recipe/food/snickerdoodle
	name = "肉桂糖饼干"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/datum/reagent/consumable/vanilla = 5,
	)
	result = /obj/item/food/cookie/snickerdoodle
	added_foodtypes = SUGAR
	dish_category = DISH_COOKIE

/datum/crafting_recipe/food/thumbprint_cookie
	name = "指印果酱饼干"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/datum/reagent/consumable/cherryjelly = 5,
	)
	result = /obj/item/food/cookie/thumbprint_cookie
	added_foodtypes = FRUIT|SUGAR
	dish_category = DISH_COOKIE

/datum/crafting_recipe/food/macaron
	name = "马卡龙"
	reqs = list(
		/datum/reagent/consumable/eggwhite = 2,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/flour = 5,
	)
	result = /obj/item/food/cookie/macaron
	dish_category = DISH_COOKIE

/datum/crafting_recipe/food/apple_fritter
	name = "炸苹果"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/appleslice = 1,
	)
	result = /obj/item/food/apple_fritter
	added_foodtypes = GRAIN|FRUIT|FRIED|BREAKFAST
	dish_category = DISH_PASTRY
	meal_category = MEAL_BREAKFAST
