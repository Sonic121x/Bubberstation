/obj/item/food/tortilla
	name = "玉米饼"
	desc = "所有墨西哥卷饼的基础。"
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "tortilla"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("玉米饼" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/tortilla/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/hard_taco_shell, rand(15 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/burrito
	name = "墨西哥卷饼"
	desc = "玉米饼包起来的美味。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "burrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("玉米饼" = 2, "豆子" = 3)
	foodtypes = VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cheesyburrito
	name = "奶酪墨西哥卷饼"
	desc = "里面塞满奶酪的墨西哥卷饼。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "cheesyburrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("玉米饼" = 2, "豆子" = 3, "奶酪" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/carneburrito
	name = "烤牛肉墨西哥卷饼"
	desc = "肉食爱好者最棒的墨西哥卷饼。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "carneburrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("玉米饼" = 2, "肉" = 4)
	foodtypes = VEGETABLES|GRAIN|MEAT
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/fuegoburrito
	name = "烈焰等离子墨西哥卷饼"
	desc = "一个超级辣的墨西哥卷饼。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "fuegoburrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("玉米饼" = 2, "豆子" = 3, "辣椒" = 1)
	foodtypes = VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_LEGENDARY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/nachos
	name = "玉米片"
	desc = "来自太空墨西哥的玉米片。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "nachos"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("玉米片" = 1)
	foodtypes = GRAIN | FRIED
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/cheesynachos
	name = "奶酪玉米片"
	desc = "玉米片与融化奶酪的美味组合。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "cheesynachos"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("玉米片" = 2, "奶酪" = 1)
	foodtypes = GRAIN | FRIED | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cubannachos
	name = "古巴玉米片"
	desc = "这玉米片辣得有点危险。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "cubannachos"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/capsaicin = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("玉米片" = 2, "辣椒" = 1)
	foodtypes = VEGETABLES|FRIED|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/taco
	name = "经典塔可"
	desc = "传统的塔可，配肉、奶酪和生菜。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "taco"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("塔可" = 4, "肉" = 2, "奶酪" = 2, "生菜" = 1)
	foodtypes = MEAT | DAIRY | GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/taco/plain
	name = "原味塔可"
	desc = "传统的塔可，配肉和奶酪，没有那些兔子吃的草。"
	icon_state = "taco_plain"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("塔可" = 4, "肉" = 2, "奶酪" = 2)
	foodtypes = MEAT | DAIRY | GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/taco/fish
	name = "鱼肉塔可"
	desc = "配鱼肉、奶酪和卷心菜的塔可。"
	icon_state = "fishtaco"
	tastes = list("塔可" = 4, "鱼" = 2, "奶酪" = 2, "卷心菜" = 1)
	foodtypes = SEAFOOD | DAIRY | GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = null

/obj/item/food/enchiladas
	name = "墨西哥辣酱卷"
	desc = "墨西哥万岁！"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "enchiladas"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/capsaicin = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("辣椒" = 1, "肉" = 3, "奶酪" = 1, "酸奶油" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/stuffedlegion
	name = "酿军团"
	desc = "一个受诅咒人类的头骨，里面塞满了歌利亚肉。上面还有用番茄酱和辣酱做成的装饰性熔岩池。"
	icon_state = "stuffed_legion"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("死亡" = 2, "岩石" = 1, "肉" = 1, "辣椒" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_LEGENDARY
	crafting_complexity = FOOD_COMPLEXITY_5
	crafted_food_buff = /datum/status_effect/food/trait/ashstorm_immune
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/chipsandsalsa
	name = "玉米片配莎莎酱"
	desc = "一些玉米片配一杯风味浓郁的莎莎酱。极易上瘾！"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "chipsandsalsa"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("辣椒" = 1, "莎莎酱" = 3, "玉米片" = 1, "洋葱" = 1)
	foodtypes = VEGETABLES|FRIED|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/classic_chimichanga
	name = "经典奇米卷饼"
	desc = "油炸的墨西哥卷饼，里面塞满了大量肉和奶酪。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "classic_chimichanga"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("油炸玉米饼" = 1, "肉" = 3, "奶酪" = 1, "洋葱" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | DAIRY | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/vegetarian_chimichanga
	name = "素食奇米卷饼"
	desc = "油炸的墨西哥卷饼，里面塞满了大量烤蔬菜，献给不吃肉的人。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "vegetarian_chimichanga"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("油炸玉米饼" = 1, "卷心菜" = 3, "洋葱" = 1, "辣椒" = 1)
	foodtypes = GRAIN | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/hard_taco_shell
	name = "硬塔可壳"
	desc = "一片硬塔可壳，正等着被填满食材。对它使用一种食材即可开始制作自定义塔可！"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "hard_taco_shell"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("硬玉米饼" = 1)
	foodtypes = GRAIN | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/hard_taco_shell/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/hard_taco_shell/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 6)

// empty taco shell for custom tacos
/obj/item/food/hard_taco_shell/empty
	name = "硬壳塔可"
	foodtypes = NONE
	tastes = list()
	icon_state = "hard_taco_shell"
	desc = "一个自定义的硬壳塔可。"
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/classic_hard_shell_taco
	name = "经典硬壳塔可"
	desc = "以经典方式制作的硬壳塔可，全银河最令人满足的脆响。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "classic_hard_shell_taco"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("脆塔可壳" = 1, "卷心菜" = 3, "番茄" = 1, "碎肉" = 1, "奶酪" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/plain_hard_shell_taco
	name = "原味硬壳塔可"
	desc = "只夹肉的硬壳塔可，献给挑食的人和每个人心中的小孩。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "plain_hard_shell_taco"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("脆塔可壳" = 1, "碎肉" = 1)
	foodtypes = MEAT|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/refried_beans
	name = "炸豆泥"
	desc = "一碗热气腾腾的美味炸豆泥，墨西哥菜中的常见主食。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "refried_beans"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	trash_type = /obj/item/reagent_containers/cup/bowl
	tastes = list("豆泥" = 1, "洋葱" = 3,)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spanish_rice
	name = "西班牙米饭"
	desc = "一碗美味的西班牙米饭，用番茄酱烹制，因此呈现橙色。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "spanish_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	trash_type = /obj/item/reagent_containers/cup/bowl
	tastes = list("香辣米饭" = 1, "番茄酱" = 3,)
	foodtypes = VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pineapple_salsa
	name = "菠萝莎莎酱"
	desc = "一种不太液体的莎莎酱，由菠萝、番茄、洋葱和辣椒制成。风味对比令人愉悦。"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "pineapple_salsa"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("菠萝" = 4, "番茄" = 3, "洋葱" = 2, "辣椒" = 2)
	foodtypes = VEGETABLES | FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
