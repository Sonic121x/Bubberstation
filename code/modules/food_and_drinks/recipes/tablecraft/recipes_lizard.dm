/datum/crafting_recipe/food/tiziran_sausage
	name = "生提兹拉血肠"
	reqs = list(
		/obj/item/food/meat/rawcutlet = 1,
		/obj/item/food/meat/rawbacon = 1,
		/datum/reagent/blood = 5,
		/datum/reagent/consumable/salt = 2
	)
	result = /obj/item/food/raw_tiziran_sausage
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/headcheese
	name = "生头肉冻"
	reqs = list(
		/obj/item/food/meat/slab = 1,
		/datum/reagent/consumable/salt = 10,
		/datum/reagent/consumable/blackpepper = 5
	)
	result = /obj/item/food/raw_headcheese
	added_foodtypes = GORE
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/shredded_lungs
	name = "酥脆肺丝小炒"
	reqs = list(
		/obj/item/food/grown/carrotlike/carrot = 1,
		/obj/item/food/grown/chili = 1,
		/obj/item/food/grown/onion = 1,
		/obj/item/organ/lungs = 1,
		/obj/item/reagent_containers/cup/bowl = 1,
	)
	blacklist = list(
		/obj/item/organ/lungs/cybernetic,
	)
	result = /obj/item/food/shredded_lungs
	added_foodtypes = MEAT|GORE
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/tsatsikh
	name = "察齐赫"
	reqs = list(
		/obj/item/organ/heart = 1,
		/obj/item/organ/liver = 1,
		/obj/item/organ/lungs = 1,
		/obj/item/organ/stomach = 1,
		/datum/reagent/consumable/salt = 2,
		/datum/reagent/consumable/blackpepper = 2
	)
	result = /obj/item/food/tsatsikh
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/liver_pate
	name = "肝酱"
	reqs = list(
		/obj/item/organ/liver = 1,
		/obj/item/food/meat/rawcutlet = 1,
		/obj/item/food/grown/onion = 1
	)
	result = /obj/item/food/liver_pate
	removed_foodtypes = RAW
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/moonfish_caviar
	name = "月鱼鱼子酱"
	reqs = list(
		/obj/item/food/moonfish_eggs = 1,
		/datum/reagent/consumable/salt = 2
	)
	result = /obj/item/food/moonfish_caviar
	cuisine_category = CUISINE_LIZARD
	meal_category = MEAL_APPETIZER

/datum/crafting_recipe/food/lizard_escargot
	name = "沙漠蜗牛"
	reqs = list(
		/obj/item/food/canned/desert_snails = 1,
		/obj/item/food/grown/garlic = 1,
		/datum/reagent/consumable/lemonjuice = 3,
		/datum/reagent/consumable/blackpepper = 2,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 3,
		/obj/item/reagent_containers/cup/bowl = 1,
	)
	result = /obj/item/food/lizard_escargot
	removed_foodtypes = GORE
	cuisine_category = CUISINE_LIZARD
	meal_category = MEAL_APPETIZER

/datum/crafting_recipe/food/fried_blood_sausage
	name = "炸血肠"
	reqs = list(
		/obj/item/food/raw_tiziran_sausage = 1,
		/datum/reagent/consumable/korta_flour = 5,
		/datum/reagent/water = 5
	)
	result = /obj/item/food/fried_blood_sausage
	added_foodtypes = FRIED|NUTS
	removed_foodtypes = RAW
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/lizard_fries
	name = "豪华波姆斯-弗朗齐斯克薯条"
	reqs = list(
		/obj/item/food/fries = 1,
		/obj/item/food/meat/cutlet = 2,
		/datum/reagent/consumable/bbqsauce = 5,
	)
	result = /obj/item/food/lizard_fries
	cuisine_category = CUISINE_LIZARD
	meal_category = MEAL_APPETIZER

/datum/crafting_recipe/food/brain_pate
	name = "眼球脑花酱"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/organ/eyes = 1,
		/obj/item/food/grown/onion = 1,
		/datum/reagent/consumable/salt = 3
	)
	result = /obj/item/food/brain_pate
	added_foodtypes = MEAT|GORE
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/crispy_headcheese
	name = "酥皮炸头肉冻"
	reqs = list(
		/obj/item/food/headcheese_slice = 1,
		/obj/item/food/breadslice/root = 1
	)
	result = /obj/item/food/crispy_headcheese
	cuisine_category = CUISINE_LIZARD
	meal_category = MEAL_APPETIZER

/datum/crafting_recipe/food/picoss_skewers
	name = "皮科斯肉串"
	reqs = list(
		/obj/item/food/fishmeat/armorfish = 2,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/chili = 1,
		/obj/item/stack/rods = 1,
		/datum/reagent/consumable/vinegar = 5
	)
	result = /obj/item/food/kebab/picoss_skewers
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/nectar_larvae
	name = "花蜜幼虫"
	reqs = list(
		/obj/item/food/canned/larvae = 1,
		/obj/item/food/grown/tomato = 1,
		/obj/item/food/grown/chili = 1,
		/datum/reagent/consumable/korta_nectar = 5
	)
	result = /obj/item/food/nectar_larvae
	cuisine_category = CUISINE_LIZARD
	meal_category = MEAL_APPETIZER

/datum/crafting_recipe/food/mushroomy_stirfry
	name = "菌菇小炒"
	reqs = list(
		/obj/item/food/steeped_mushrooms = 1,
		/obj/item/food/grown/mushroom/plumphelmet = 1,
		/obj/item/food/grown/mushroom/chanterelle = 1,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 5
	)
	result = /obj/item/food/mushroomy_stirfry
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_SALAD

/datum/crafting_recipe/food/moonfish_demiglace
	name = "月鱼浓汁"
	reqs = list(
		/obj/item/food/grilled_moonfish = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/food/grown/carrotlike/carrot = 1,
		/datum/reagent/consumable/korta_milk = 5,
		/datum/reagent/consumable/ethanol/wine = 5
	)
	result = /obj/item/food/moonfish_demiglace
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/lizard_surf_n_turf
	name = "扎戈斯克海陆大餐"
	reqs = list(
		/obj/item/food/grilled_moonfish = 1,
		/obj/item/food/kebab/picoss_skewers = 2,
		/obj/item/food/meat/steak = 1,
		/obj/item/food/bbqribs = 1
	)
	removed_foodtypes = SUGAR
	result = /obj/item/food/lizard_surf_n_turf
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/rootdough
	name = "根面粉团（无蛋）"
	reqs = list(
		/obj/item/food/grown/potato = 2,
		/datum/reagent/consumable/soymilk = 15,
		/datum/reagent/consumable/korta_flour = 5,
		/datum/reagent/water = 10
	)
	result = /obj/item/food/rootdough
	added_foodtypes = NUTS
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_BREAD
	crafting_flags = parent_type::crafting_flags & ~CRAFT_TRANSFERS_REAGENT_COMPONENTS // prevents water from reacting immediately, clearing the dish

/datum/crafting_recipe/food/rootdough/with_eggs
	name = "根面粉团（加蛋）"
	reqs = list(
		/obj/item/food/grown/potato = 2,
		/obj/item/food/egg = 1,
		/datum/reagent/consumable/korta_flour = 5,
		/datum/reagent/water = 10
	)
	result = /obj/item/food/rootdough/egg
	removed_foodtypes = RAW|EGG
	/**
	 * So, at some point, we've had some mean issues with crafting with empty containers.
	 * Bugs happen and we fix them all the time, so let's make sure stuff like this won't happen again.
	 * Let's make his recipe spawn a bunch of unneeded containers and something else as well.
	 * If this breaks the CI, then something is wrong with crafting.
	 */
	unit_test_spawn_extras = list(
		/obj/item/food/rootdough/egg = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/reagent_containers/condiment = 1,
		/obj/item/reagent_containers/cup/bottle = 2,
		/obj/item/reagent_containers/cup/beaker/slime = 1,
		/obj/item/reagent_containers/applicator/patch/synthflesh = 1,
	)
	crafting_flags = parent_type::crafting_flags & ~CRAFT_TRANSFERS_REAGENT_COMPONENTS // prevents water from reacting immediately, clearing the dish

/datum/crafting_recipe/food/snail_nizaya
	name = "沙漠蜗牛尼扎亚面"
	reqs = list(
		/obj/item/food/canned/desert_snails = 1,
		/obj/item/food/spaghetti/nizaya = 1,
		/obj/item/food/grown/garlic = 1,
		/datum/reagent/consumable/ethanol/wine = 5
	)
	result = /obj/item/food/spaghetti/snail_nizaya
	removed_foodtypes = GORE
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_NOODLES

/datum/crafting_recipe/food/garlic_nizaya
	name = "蒜香尼扎亚面"
	reqs = list(
		/obj/item/food/spaghetti/nizaya = 1,
		/obj/item/food/grown/garlic = 1,
		/obj/item/food/grown/chili = 1,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 5
	)
	result = /obj/item/food/spaghetti/garlic_nizaya
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_NOODLES

/datum/crafting_recipe/food/demit_nizaya
	name = "德米特尼扎亚面"
	reqs = list(
		/obj/item/food/spaghetti/nizaya = 1,
		/obj/item/food/grown/carrotlike/carrot = 1,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/eggplant = 1,
		/datum/reagent/consumable/korta_milk = 5,
		/datum/reagent/consumable/korta_nectar = 5
	)
	result = /obj/item/food/spaghetti/demit_nizaya
	added_foodtypes = SUGAR
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_NOODLES

/datum/crafting_recipe/food/mushroom_nizaya
	name = "菌菇尼扎亚面"
	reqs = list(
		/obj/item/food/spaghetti/nizaya = 1,
		/obj/item/food/steeped_mushrooms = 1,
		/obj/item/food/grown/garlic = 1,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 5
	)
	result = /obj/item/food/spaghetti/mushroom_nizaya
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_NOODLES

/datum/crafting_recipe/food/rustic_flatbread
	name = "乡野烤饼"
	reqs = list(
		/obj/item/food/root_flatbread = 1,
		/obj/item/food/grown/garlic = 1,
		/datum/reagent/consumable/lemonjuice = 2,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 3
	)
	result = /obj/item/food/pizza/flatbread/rustic
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_BREAD

/datum/crafting_recipe/food/italic_flatbread
	name = "拉丁烤饼"
	reqs = list(
		/obj/item/food/root_flatbread = 1,
		/obj/item/food/grown/garlic = 1,
		/obj/item/food/grown/tomato = 1,
		/obj/item/food/meatball = 2,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 3
	)
	result = /obj/item/food/pizza/flatbread/italic
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_BREAD

/datum/crafting_recipe/food/imperial_flatbread
	name = "帝国烤饼"
	reqs = list(
		/obj/item/food/root_flatbread = 1,
		/obj/item/food/liver_pate = 1,
		/obj/item/food/sauerkraut = 1,
		/obj/item/food/headcheese = 1
	)
	result = /obj/item/food/pizza/flatbread/imperial
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_BREAD

/datum/crafting_recipe/food/rawmeat_flatbread
	name = "肉食者烤饼"
	reqs = list(
		/obj/item/food/root_flatbread = 1,
		/obj/item/food/meat/slab = 1
	)
	result = /obj/item/food/pizza/flatbread/rawmeat
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_BREAD

/datum/crafting_recipe/food/stinging_flatbread
	name = "刺麻烤饼"
	reqs = list(
		/obj/item/food/root_flatbread = 1,
		/obj/item/food/canned/larvae = 1,
		/obj/item/food/canned/jellyfish = 1
	)
	result = /obj/item/food/pizza/flatbread/stinging
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_BREAD

/datum/crafting_recipe/food/zmorgast_flatbread
	name = "兹莫加斯特烤饼"
	reqs = list(
		/obj/item/food/root_flatbread = 1,
		/obj/item/food/grown/cucumber = 2,
		/obj/item/food/egg = 1,
		/obj/item/organ/liver = 1
	)
	result = /obj/item/food/pizza/flatbread/zmorgast
	removed_foodtypes = RAW
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_BREAD

/datum/crafting_recipe/food/fish_flatbread
	name = "烧烤鱼烤饼"
	reqs = list(
		/obj/item/food/root_flatbread = 1,
		/obj/item/food/fishmeat = 2,
		/datum/reagent/consumable/bbqsauce = 5
	)
	result = /obj/item/food/pizza/flatbread/fish
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_BREAD

/datum/crafting_recipe/food/mushroom_flatbread
	name = "菌菇番茄烤饼"
	reqs = list(
		/obj/item/food/root_flatbread = 1,
		/obj/item/food/grown/tomato = 1,
		/obj/item/food/grown/mushroom = 3,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 3
	)
	result = /obj/item/food/pizza/flatbread/mushroom
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_BREAD
	unit_test_spawn_extras = list(/obj/item/food/grown/mushroom/chanterelle = 3) //generic mushrooms

/datum/crafting_recipe/food/nutty_flatbread
	name = "坚果酱烤饼"
	reqs = list(
		/obj/item/food/root_flatbread = 1,
		/datum/reagent/consumable/korta_flour = 5,
		/datum/reagent/consumable/korta_milk = 5
	)
	result = /obj/item/food/pizza/flatbread/nutty
	removed_foodtypes = VEGETABLES //This is so nuts
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_BREAD

/datum/crafting_recipe/food/emperor_roll
	name = "皇帝卷"
	reqs = list(
		/obj/item/food/rootroll = 1,
		/obj/item/food/liver_pate = 1,
		/obj/item/food/headcheese_slice = 2,
		/obj/item/food/moonfish_caviar = 1
	)
	result = /obj/item/food/emperor_roll
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/honey_sweetroll
	name = "蜂蜜甜卷"
	reqs = list(
		/obj/item/food/rootroll = 1,
		/obj/item/food/grown/berries = 1,
		/obj/item/food/grown/banana = 1,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/food/honey_roll
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_PASTRY

/datum/crafting_recipe/food/black_eggs
	name = "黑炒蛋"
	reqs = list(
		/obj/item/food/egg = 2,
		/datum/reagent/blood = 5,
		/datum/reagent/consumable/vinegar = 2
	)
	result = /obj/item/food/black_eggs
	added_foodtypes = GORE|BREAKFAST
	removed_foodtypes = RAW
	cuisine_category = CUISINE_LIZARD
	meal_category = MEAL_APPETIZER

/datum/crafting_recipe/food/patzikula
	name = "帕齐库拉"
	reqs = list(
		/obj/item/food/grown/tomato = 2,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/chili = 1,
		/obj/item/food/egg = 2
	)
	result = /obj/item/food/patzikula
	removed_foodtypes = RAW
	added_foodtypes = BREAKFAST
	cuisine_category = CUISINE_LIZARD
	meal_category = MEAL_APPETIZER

/datum/crafting_recipe/food/korta_brittle
	name = "科塔坚果脆片"
	reqs = list(
		/obj/item/food/grown/korta_nut = 2,
		/datum/reagent/consumable/korta_nectar = 5,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/nutriment/fat/oil = 3,
		/datum/reagent/consumable/salt = 2
	)
	result = /obj/item/food/cake/korta_brittle
	added_foodtypes = SUGAR
	cuisine_category = CUISINE_LIZARD
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/korta_ice
	name = "科塔冰"
	reqs = list(
		/obj/item/reagent_containers/cup/glass/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/korta_nectar = 5,
		/obj/item/food/grown/berries = 1
	)
	result = /obj/item/food/snowcones/korta_ice
	added_foodtypes = SUGAR|NUTS
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_FROZEN

/datum/crafting_recipe/food/candied_mushrooms
	name = "糖渍蘑菇"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/steeped_mushrooms = 1,
		/datum/reagent/consumable/caramel = 5,
		/datum/reagent/consumable/salt = 1
	)
	result = /obj/item/food/kebab/candied_mushrooms
	added_foodtypes = SUGAR
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_CANDY
	meal_category = MEAL_DESSERT

/datum/crafting_recipe/food/sauerkraut
	name = "酸菜"
	reqs = list(
		/obj/item/food/grown/cabbage = 2,
		/datum/reagent/consumable/salt = 10
	)
	result = /obj/item/food/sauerkraut
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_CONDIMENT
	meal_category = MEAL_COMPONENT

/datum/crafting_recipe/food/lizard_dumplings
	name = "提兹拉饺子"
	reqs = list(
		/obj/item/food/grown/potato = 1,
		/datum/reagent/consumable/korta_flour = 5
	)
	result = /obj/item/food/lizard_dumplings
	added_foodtypes = NUTS
	cuisine_category = CUISINE_LIZARD
	meal_category = MEAL_COMPONENT

/datum/crafting_recipe/food/steeped_mushrooms
	name = "浸渍蘑菇"
	reqs = list(
		/obj/item/food/grown/ash_flora/seraka = 1,
		/datum/reagent/lye = 5
	)
	result = /obj/item/food/steeped_mushrooms
	cuisine_category = CUISINE_LIZARD
	meal_category = MEAL_COMPONENT

/datum/crafting_recipe/food/rootbreadpbj
	name = "花生酱果酱根面包三明治"
	reqs = list(
		/obj/item/food/breadslice/root = 2,
		/datum/reagent/consumable/peanut_butter = 5,
		/datum/reagent/consumable/cherryjelly = 5
	)
	result = /obj/item/food/rootbread_peanut_butter_jelly
	added_foodtypes = FRUIT
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_SANDWICH

/datum/crafting_recipe/food/rootbreadpbb
	name = "花生酱香蕉根面包三明治"
	reqs = list(
		/obj/item/food/breadslice/root = 2,
		/datum/reagent/consumable/peanut_butter = 5,
		/obj/item/food/grown/banana = 1
	)
	result = /obj/item/food/rootbread_peanut_butter_banana
	added_foodtypes = FRUIT
	cuisine_category = CUISINE_LIZARD
	dish_category = DISH_SANDWICH
// Soups

/datum/crafting_recipe/food/reaction/soup/atrakor_dumplings
	reaction = /datum/chemical_reaction/food/soup/atrakor_dumplings
	cuisine_category = CUISINE_LIZARD

/datum/crafting_recipe/food/reaction/soup/meatball_noodles
	reaction = /datum/chemical_reaction/food/soup/meatball_noodles
	cuisine_category = CUISINE_LIZARD

/datum/crafting_recipe/food/reaction/soup/black_broth
	reaction = /datum/chemical_reaction/food/soup/black_broth
	cuisine_category = CUISINE_LIZARD

/datum/crafting_recipe/food/reaction/soup/jellyfish_stew
	reaction = /datum/chemical_reaction/food/soup/jellyfish_stew
	cuisine_category = CUISINE_LIZARD

/datum/crafting_recipe/food/reaction/soup/jellyfish_stew_two
	reaction = /datum/chemical_reaction/food/soup/jellyfish_stew_two
	cuisine_category = CUISINE_LIZARD

/datum/crafting_recipe/food/reaction/soup/rootbread_soup
	reaction = /datum/chemical_reaction/food/soup/rootbread_soup
	cuisine_category = CUISINE_LIZARD
