////////////////////////////////////////////DONK POCKETS////////////////////////////////////////////

/obj/item/food/donkpocket
	name = "\improper 咚克口袋饼"
	desc = "老练叛徒的首选食物。"
	icon_state = "donkpocket"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("鲜味" = 2, "面团" = 2, "慵懒" = 1)
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

	/// What type of donk pocket we're warmed into via baking or microwaving.
	var/warm_type = /obj/item/food/donkpocket/warm
	/// Whether baking/microwaving it yields a positive result
	var/positive_result = TRUE
	/// The lower end for how long it takes to bake
	var/baking_time_short = 25 SECONDS
	/// The upper end for how long it takes to bake
	var/baking_time_long = 30 SECONDS
	/// The amount of omnizine added when it's cooked.
	var/omnizine_to_add = 6

/obj/item/food/donkpocket/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), positive_result, TRUE, list(/datum/reagent/medicine/omnizine = omnizine_to_add))

/obj/item/food/donkpocket/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, string_assoc_list(list(/datum/reagent/medicine/omnizine = omnizine_to_add)), bad_recipe = !positive_result)

/obj/item/food/donkpocket/warm
	name = "热咚克口袋饼"
	desc = "加热之后，它便成了老练叛徒的首选食物。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 6,
	)
	tastes = list("鲜味" = 2, "面团" = 2, "慵懒" = 1)
	foodtypes = GRAIN

	// Warmed donk pockets will burn if you leave them in the oven or microwave.
	warm_type = /obj/item/food/badrecipe
	positive_result = FALSE
	baking_time_short = 10 SECONDS
	baking_time_long = 15 SECONDS
	omnizine_to_add = 0

/obj/item/food/donkpocket/homemade
	foodtypes = MEAT|GRAIN
	tastes = list("肉" = 2, "面团" = 2, "舒适" = 1)
	warm_type = /obj/item/food/donkpocket/warm/homemade
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/warm/homemade
	foodtypes = MEAT|GRAIN
	tastes = list("肉" = 2, "面团" = 2, "舒适" = 1)
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/dank
	name = "\improper 大麻口袋饼"
	desc = "老练植物学家的首选食物。"
	icon_state = "dankpocket"
	food_reagents = list(
		/datum/reagent/toxin/lipolicide = 3,
		/datum/reagent/drug/space_drugs = 3,
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("大麻" = 2, "面团" = 2)
	foodtypes = GRAIN|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2
	warm_type = /obj/item/food/donkpocket/warm/dank
	omnizine_to_add = 2

/obj/item/food/donkpocket/warm/dank
	name = "热大麻口袋饼"
	desc = "老练植物学家的首选食物。"
	icon_state = "dankpocket"
	food_reagents = list(
		/datum/reagent/toxin/lipolicide = 3,
		/datum/reagent/drug/space_drugs = 3,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/medicine/omnizine = 2,
	)
	tastes = list("大麻" = 2, "面团" = 2)
	foodtypes = GRAIN|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/donkpocket/spicy
	name = "\improper 香辣口袋饼"
	desc = "经典零食，如今带上了热激活的辛辣风味。"
	icon_state = "donkpocketspicy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("鲜味" = 2, "面团" = 2, "香料" = 1)
	foodtypes = VEGETABLES|GRAIN
	warm_type = /obj/item/food/donkpocket/warm/spicy
	omnizine_to_add = 2

/obj/item/food/donkpocket/warm/spicy
	name = "热香辣口袋饼"
	desc = "经典零食，现在可能有点太辣了。"
	icon_state = "donkpocketspicy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/capsaicin = 5,
	)
	tastes = list("鲜味" = 2, "面团" = 2, "奇怪的香料" = 2)
	foodtypes = VEGETABLES|GRAIN

/obj/item/food/donkpocket/spicy/homemade
	tastes = list("肉" = 2, "面团" = 2, "香料" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN
	warm_type = /obj/item/food/donkpocket/warm/spicy/homemade
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/warm/spicy/homemade
	tastes = list("肉" = 2, "面团" = 2, "奇怪的香料" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/teriyaki
	name = "\improper 照烧口袋饼"
	desc = "东亚风味的经典空间站零食。"
	icon_state = "donkpocketteriyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/soysauce = 2,
	)
	tastes = list("鲜味" = 2, "面团" = 2, "酱油" = 2)
	foodtypes = GRAIN
	warm_type = /obj/item/food/donkpocket/warm/teriyaki
	omnizine_to_add = 2

/obj/item/food/donkpocket/warm/teriyaki
	name = "热照烧口袋饼"
	desc = "东亚风味的经典空间站零食，如今热气腾腾。"
	icon_state = "donkpocketteriyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/soysauce = 2,
	)
	tastes = list("鲜味" = 2, "面团" = 2, "酱油" = 2)
	foodtypes = GRAIN

/obj/item/food/donkpocket/teriyaki/homemade
	tastes = list("肉" = 2, "面团" = 2, "酱油" = 2)
	foodtypes = MEAT|GRAIN
	warm_type = /obj/item/food/donkpocket/warm/teriyaki/homemade
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/warm/teriyaki/homemade
	tastes = list("肉" = 2, "面团" = 2, "酱油" = 2)
	foodtypes = MEAT|GRAIN
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/pizza
	name = "\improper 披萨口袋饼"
	desc = "美味、满是奶酪，而且出人意料地管饱。"
	icon_state = "donkpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/tomatojuice = 2,
	)
	tastes = list("番茄" = 2, "面团" = 2, "奶酪"= 2)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	warm_type = /obj/item/food/donkpocket/warm/pizza
	omnizine_to_add = 2

/obj/item/food/donkpocket/warm/pizza
	name = "热披萨口袋饼"
	desc = "美味、满是奶酪，热的时候更好吃。"
	icon_state = "donkpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/tomatojuice = 2,
	)
	tastes = list("番茄" = 2, "面团" = 2, "融化的奶酪"= 2)
	foodtypes = VEGETABLES|GRAIN|DAIRY

/obj/item/food/donkpocket/honk
	name = "\improper 洪克口袋饼"
	desc = "这款获奖的咚克口袋饼赢得了小丑和人类的心。"
	icon_state = "donkpocketbanana"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/banana = 4,
	)
	tastes = list("香蕉" = 2, "面团" = 2, "儿童抗生素" = 1)
	foodtypes = GRAIN|FRUIT|SUGAR
	warm_type = /obj/item/food/donkpocket/warm/honk
	crafting_complexity = FOOD_COMPLEXITY_3
	var/static/list/honk_added_reagents = list(
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/laughter = 6,
	)
	custom_materials = null

/obj/item/food/donkpocket/honk/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), positive_result, TRUE, honk_added_reagents)

/obj/item/food/donkpocket/honk/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, honk_added_reagents, positive_result)

/obj/item/food/donkpocket/warm/honk
	name = "热洪克口袋饼"
	desc = "这款获奖的咚克口袋饼，现在热乎乎、香喷喷。"
	icon_state = "donkpocketbanana"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/banana = 4,
		/datum/reagent/consumable/laughter = 6,
	)
	tastes = list("香蕉" = 2, "面团" = 2, "儿童抗生素" = 1)
	foodtypes = GRAIN|FRUIT|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = null

/obj/item/food/donkpocket/berry
	name = "\improper 浆果口袋饼"
	desc = "一款甜得毫不留情的咚克口袋饼，最初是为“甜点风暴行动”而制。"
	icon_state = "donkpocketberry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/berryjuice = 3,
	)
	tastes = list("面团" = 2, "果酱" = 2)
	foodtypes = GRAIN|FRUIT|SUGAR
	warm_type = /obj/item/food/donkpocket/warm/berry
	custom_materials = null
	omnizine_to_add = 2

/obj/item/food/donkpocket/warm/berry
	name = "热浆果口袋饼"
	desc = "一款甜得毫不留情的咚克口袋饼，现在热乎又美味。"
	icon_state = "donkpocketberry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/berryjuice = 3,
	)
	tastes = list("面团" = 2, "温热的果酱" = 2)
	foodtypes = GRAIN|FRUIT|SUGAR
	custom_materials = null

/obj/item/food/donkpocket/gondola
	name = "\improper 贡多拉口袋饼"
	desc = "至少可以说，在配方里使用真正的贡多拉肉颇具争议。" //Only a monster would craft this.
	icon_state = "donkpocketgondola"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/gondola_mutation_toxin = 5,
	)
	tastes = list("肉" = 2, "面团" = 2, "内心平静" = 1)
	foodtypes = GRAIN|MEAT

	warm_type = /obj/item/food/donkpocket/warm/gondola
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
	var/static/list/gondola_added_reagents = list(
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/gondola_mutation_toxin = 5,
	)

/obj/item/food/donkpocket/gondola/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), positive_result, TRUE, gondola_added_reagents)

/obj/item/food/donkpocket/gondola/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, gondola_added_reagents, positive_result)

/obj/item/food/donkpocket/warm/gondola
	name = "热贡多拉口袋饼"
	desc = "至少可以说，在配方里使用真正的贡多拉肉颇具争议。"
	icon_state = "donkpocketgondola"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/gondola_mutation_toxin = 10,
	)
	tastes = list("肉" = 2, "面团" = 2, "内心平静" = 1)
	foodtypes = GRAIN|MEAT
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/deluxe
	name = "\improper 咚克口袋饼豪华版"
	desc = "咚克公司的最新产品。其配方是严守的秘密。"
	icon_state = "donkpocketdeluxe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/medicine/omnizine = 2,
	)
	tastes = list("优质肉" = 2, "面团" = 2, "生猛的高级感" = 1)
	foodtypes = GRAIN|MEAT|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

	warm_type = /obj/item/food/donkpocket/warm/deluxe
	var/static/list/deluxe_added_reagents = list(
		/datum/reagent/medicine/omnizine = 8,
	)
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/donkpocket/deluxe/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), positive_result, TRUE, deluxe_added_reagents)

/obj/item/food/donkpocket/deluxe/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, deluxe_added_reagents, positive_result)

/obj/item/food/donkpocket/warm/deluxe
	name = "热咚克口袋饼豪华版"
	desc = "咚克公司的最新产品。外皮酥脆温热，烤得恰到好处。天哪，这咚克饼看着真不错。"
	icon_state = "donkpocketdeluxe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/medicine/omnizine = 10,
	)
	tastes = list("优质肉" = 2, "面团" = 2, "高级感" = 1)
	foodtypes = GRAIN|MEAT|VEGETABLES|FRIED
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/donkpocket/deluxe/nocarb
	name = "\improper 肉口袋饼"
	desc = "肉食派叛徒的首选食物。"
	icon_state = "donkpocketdeluxenocarb"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/medicine/omnizine = 2,
	)
	tastes = list("生肉" = 2, "更多肉" = 2, "无碳水" = 1)
	foodtypes = MEAT|RAW
	crafting_complexity = FOOD_COMPLEXITY_4
	warm_type = /obj/item/food/donkpocket/warm/deluxe/nocarb
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 4)

/obj/item/food/donkpocket/warm/deluxe/nocarb
	name = "热肉口袋饼"
	desc = "肉食派叛徒首选的温热食物。"
	icon_state = "donkpocketdeluxenocarb"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/medicine/omnizine = 10,
	)
	tastes = list("肉" = 2, "更多肉" = 2, "无碳水" = 1)
	foodtypes = MEAT
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 4)

/obj/item/food/donkpocket/deluxe/vegan
	name = "\improper 咚克卷"
	desc = "经典空间站零食，现在加了米饭！经动物解放阵线认证为纯素且无动物伤害。"
	icon_state = "donkpocketdeluxevegan"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/medicine/omnizine = 2,
	)
	tastes = list("米饼" = 2, "面团" = 2, "胡椒冲劲" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4
	warm_type = /obj/item/food/donkpocket/warm/deluxe/vegan
	custom_materials = null

/obj/item/food/donkpocket/warm/deluxe/vegan
	name = "热咚克卷"
	desc = "经典空间站零食，现在加了米饭！炸得恰到好处。"
	icon_state = "donkpocketdeluxevegan"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/medicine/omnizine = 10,
	)
	tastes = list("米饼" = 2, "炸面团" = 2, "胡椒冲劲" = 1)
	foodtypes = GRAIN | VEGETABLES | FRIED
	custom_materials = null
