
// see code/module/crafting/table.dm

////////////////////////////////////////////////CAKE////////////////////////////////////////////////

/datum/crafting_recipe/food/carrotcake
	name = "胡萝卜蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/carrotlike/carrot = 2
	)
	result = /obj/item/food/cake/carrot
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/cheesecake
	name = "芝士蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/cheese/wedge = 2
	)
	result = /obj/item/food/cake/cheese
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/applecake
	name = "苹果蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/apple = 2
	)
	result = /obj/item/food/cake/apple
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/orangecake
	name = "橙子蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/citrus/orange = 2
	)
	result = /obj/item/food/cake/orange
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/limecake
	name = "青柠蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/citrus/lime = 2
	)
	result = /obj/item/food/cake/lime
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/lemoncake
	name = "柠檬蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/citrus/lemon = 2
	)
	result = /obj/item/food/cake/lemon
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/chocolatecake
	name = "巧克力蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/chocolatebar = 2
	)
	result = /obj/item/food/cake/chocolate
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/birthdaycake
	name = "生日蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/flashlight/flare/candle = 1,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/caramel = 2
	)
	result = /obj/item/food/cake/birthday
	added_foodtypes = JUNKFOOD
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/energycake
	name = "能量蛋糕"
	reqs = list(
		/obj/item/food/cake/birthday = 1,
		/obj/item/melee/energy/sword = 1,
	)
	blacklist = list(/obj/item/food/cake/birthday/energy)
	result = /obj/item/food/cake/birthday/energy
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/braincake
	name = "大脑蛋糕"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/food/cake/plain = 1
	)
	result = /obj/item/food/cake/brain
	added_foodtypes = MEAT | GORE
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/slimecake
	name = "史莱姆蛋糕"
	reqs = list(
		/obj/item/slime_extract = 1,
		/obj/item/food/cake/plain = 1
	)
	result = /obj/item/food/cake/slimecake
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/pumpkinspicecake
	name = "南瓜香料蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/pumpkin = 2
	)
	result = /obj/item/food/cake/pumpkinspice
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/holycake
	name = "天使蛋糕"
	reqs = list(
		/datum/reagent/water/holywater = 15,
		/obj/item/food/cake/plain = 1
	)
	result = /obj/item/food/cake/holy_cake
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/poundcake
	name = "磅蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 4
	)
	result = /obj/item/food/cake/pound_cake
	added_foodtypes = JUNKFOOD
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/hardwarecake
	name = "硬件蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/circuitboard = 2,
		/datum/reagent/toxin/acid = 5
	)
	result = /obj/item/food/cake/hardware_cake
	added_foodtypes = GROSS
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT
	unit_test_spawn_extras = list(/obj/item/circuitboard/machine/vendor = 2) //cannot spawn the abstract circuit board

/datum/crafting_recipe/food/berry_chocolate_cake
	name = "草莓巧克力蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/chocolatebar = 2,
		/obj/item/food/grown/berries = 5
	)
	result = /obj/item/food/cake/berry_chocolate_cake
	removed_foodtypes = JUNKFOOD
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/pavlovacream
	name = "奶油帕夫洛娃"
	reqs = list(
		/datum/reagent/consumable/eggwhite = 12,
		/datum/reagent/consumable/sugar = 15,
		/datum/reagent/consumable/whipped_cream = 10,
		/obj/item/food/grown/berries = 5
	)
	result = /obj/item/food/cake/pavlova
	added_foodtypes = SUGAR|DAIRY
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/pavlovakorta
	name = "科塔奶油帕夫洛娃"
	reqs = list(
		/datum/reagent/consumable/eggwhite = 12,
		/datum/reagent/consumable/sugar = 15,
		/datum/reagent/consumable/korta_milk = 10,
		/obj/item/food/grown/berries = 5
	)
	result = /obj/item/food/cake/pavlova/nuts
	added_foodtypes = SUGAR|NUTS
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/berry_vanilla_cake
	name = "黑莓草莓香草蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/berries = 5
	)
	result = /obj/item/food/cake/berry_vanilla_cake
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/clowncake
	name = "小丑蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/sundae = 2,
		/obj/item/food/grown/banana = 5
	)
	result = /obj/item/food/cake/clown_cake
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/food/vanillacake
	name = "香草蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/vanillapod = 2
	)
	result = /obj/item/food/cake/vanilla_cake
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/food/trumpetcake
	name = "太空人蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/flower/trumpet = 2,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/berryjuice = 5
	)
	result = /obj/item/food/cake/trumpet
	added_foodtypes = FRUIT
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT


/datum/crafting_recipe/food/cak
	name = "活体猫蛋糕混合体"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/organ/heart = 1,
		/obj/item/food/cake/birthday = 1,
		/obj/item/food/meat/slab = 3,
		/datum/reagent/blood = 30,
		/datum/reagent/consumable/sprinkles = 5,
		/datum/reagent/teslium = 1 //To shock the whole thing into life
	)
	parts = list(
		/obj/item/organ/brain,
		/obj/item/organ/heart
	)
	result = /mob/living/basic/pet/cat/cak
	dish_category = DISH_CAKE
	meal_category = MEAL_UNCATEGORIZED


/datum/crafting_recipe/food/fruitcake
	name = "英式水果蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/no_raisin = 1,
		/obj/item/food/grown/cherries = 1,
		/datum/reagent/consumable/ethanol/rum = 5
	)
	result = /obj/item/food/cake/fruit
	removed_foodtypes = JUNKFOOD
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/plumcake
	name = "李子蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/plum = 2
	)
	result = /obj/item/food/cake/plum
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/weddingcake
	name = "婚礼蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 4,
		/datum/reagent/consumable/sugar = 120,
	)
	result = /obj/item/food/cake/wedding
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/pineapple_cream_cake
	name = "菠萝奶油蛋糕"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/pineapple = 1,
		/datum/reagent/consumable/cream = 20,
	)
	result = /obj/item/food/cake/pineapple_cream_cake
	dish_category = DISH_CAKE
	meal_category = MEAL_DESSERT
