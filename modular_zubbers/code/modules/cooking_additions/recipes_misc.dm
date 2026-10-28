/datum/crafting_recipe/food/redbayseasoning
	name = "红湾调味料"
	reqs = list(
		/obj/item/food/grown/peppercorn = 1,
		/obj/item/food/grown/bell_pepper = 1,
		/obj/item/food/grown/herbs = 1,
		/obj/item/food/grown/garlic = 1,
		/datum/reagent/consumable/salt = 5,
		/obj/item/reagent_containers/condiment = 1,
	)
	result = /obj/item/reagent_containers/condiment/red_bay
	dish_category = DISH_CONDIMENT

/datum/crafting_recipe/food/curry_powder
	name = "咖喱粉"
	reqs = list(
		/obj/item/food/grown/peppercorn = 1,
		/obj/item/food/grown/nakati = 1,
		/obj/item/food/grown/herbs = 1,
		/datum/reagent/consumable/salt = 5,
		/obj/item/reagent_containers/condiment = 1,
	)
	result = /obj/item/reagent_containers/condiment/curry_powder
	dish_category = DISH_CONDIMENT

/datum/crafting_recipe/food/worcestershire
	name = "伍斯特酱"
	reqs = list(
		/obj/item/food/fishmeat = 1,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/garlic = 1,
		/datum/reagent/consumable/vinegar = 15,
		/datum/reagent/consumable/salt = 5,
		/obj/item/reagent_containers/condiment = 1,
	)
	result = /obj/item/reagent_containers/condiment/worcestershire
	dish_category = DISH_CONDIMENT

/datum/crafting_recipe/food/dashiconcentrate
	name = "浓缩日式高汤"
	reqs = list(
		/obj/item/food/fishmeat = 1,
		/obj/item/food/seaweedsheet = 1,
		/datum/reagent/water/salt = 15,
		/obj/item/reagent_containers/condiment = 1,
	)
	result = /obj/item/reagent_containers/condiment/dashi_concentrate
	dish_category = DISH_CONDIMENT

/datum/crafting_recipe/food/chapmix
	name = "CHAP 肉酱"
	reqs = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/food/grown/herbs = 1,
		/datum/reagent/consumable/blackpepper = 5,
		/datum/reagent/consumable/salt = 15,
	)
	result = /obj/item/food/meat/chapmix
	meal_category = MEAL_COMPONENT

/obj/item/food/meat/chapmix
	name = "CHAP 肉酱"
	desc = "一团调味肉糜，等待加工。"
	icon_state = "raw_meatloaf"
	foodtypes = MEAT | VEGETABLES | RAW

/obj/item/food/canned/chap/processed
	foodtypes = MEAT | VEGETABLES | RAW

/obj/item/food/cnds/processed
	foodtypes = JUNKFOOD | SUGAR

/// Healthy foods that the food processor pops out. Mostly to get the food_processor unit test all happy.
/obj/item/food/peanuts/healthy
	name = "有机花生"
	foodtypes = NUTS

/obj/item/food/chips/healthy
	name = "有机薯片"
	desc = "这款薯片适合在你想要说服自己正在吃健康替代品的时候享用。"
	foodtypes = FRIED | VEGETABLES

/datum/food_processor_process/chap
	input = /obj/item/food/meat/chapmix
	output = /obj/item/food/canned/chap/processed

/datum/food_processor_process/chocolate
	input = /obj/item/food/chocolatebar
	output = /obj/item/food/cnds/processed

/datum/food_processor_process/peanut
	input = /obj/item/food/grown/peanut
	output = /obj/item/food/peanuts/healthy

/datum/food_processor_process/chips
	input = /obj/item/food/tatortot
	output = /obj/item/food/chips/healthy

/datum/food_processor_process/tinnedtomatoes
	input = /obj/item/food/grown/tomato
	output = /obj/item/food/canned/tomatoes

/datum/food_processor_process/pinenuts
	input = /obj/item/food/grown/korta_nut
	output = /obj/item/food/canned/pine_nuts

/datum/food_processor_process/larvae
	input = /obj/item/trash/bee
	output = /obj/item/food/canned/larvae

/datum/crafting_recipe/food/snailmix
	name = "蜗牛肉酱"
	reqs = list(
		/obj/item/food/meat/slab/bugmeat = 1,
		/obj/item/food/grown/herbs = 1,
		/datum/reagent/consumable/blackpepper = 5,
		/datum/reagent/consumable/salt = 15,
	)
	result = /obj/item/food/meat/snailmix
	meal_category = MEAL_COMPONENT

/obj/item/food/meat/snailmix
	name = "蜗牛肉酱"
	desc = "一团调味肉糜，等待加工……切勿与什锦果仁混装搞混！"
	icon_state = "raw_meatloaf"
	foodtypes = MEAT | VEGETABLES | RAW | BUGS

/obj/item/food/canned/desert_snails/processed
	foodtypes = MEAT | VEGETABLES | RAW | BUGS

/datum/food_processor_process/desertsnails
	input = /obj/item/food/meat/snailmix
	output = /obj/item/food/canned/desert_snails/processed
	food_multiplier = 2 //Giving a 2x multiplier as bug meat is slightly rarer to come across once you've killed all the snails.

/datum/crafting_recipe/food/mac_balls_fresh
	name = "马切罗尼罗伦（通心粉球）新鲜装"
	reqs = list(
		/obj/item/food/spaghetti/mac_n_cheese = 1,
		/obj/item/food/tomato_sauce = 1,
		/datum/reagent/consumable/cornmeal_batter = 5
	)
	result = /obj/item/food/mac_balls
	removed_foodtypes = JUNKFOOD
	added_foodtypes = FRIED
	meal_category = MEAL_APPETIZER
