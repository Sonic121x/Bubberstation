//this category is very little but I think that it has great potential to grow
////////////////////////////////////////////SALAD////////////////////////////////////////////
/obj/item/food/salad
	icon = 'icons/obj/food/soupsalad.dmi'
	abstract_type = /obj/item/food/salad
	trash_type = /obj/item/reagent_containers/cup/bowl
	bite_consumption = 3
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("菜叶" = 1)
	foodtypes = VEGETABLES
	eatverbs = list("大口吞食", "小口咬", "啃食", "狼吞虎咽", "大声咀嚼") //who the fuck gnaws and devours on a salad
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/salad/aesirsalad
	name = "\improper 神族沙拉"
	desc = "大概太不可思议了，凡人无法完全消受。"
	icon_state = "aesirsalad"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 12)
	tastes = list("菜叶" = 1)
	foodtypes = VEGETABLES | FRUIT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/herbsalad
	name = "香草沙拉"
	desc = "上面放着苹果的美味沙拉。"
	icon_state = "herbsalad"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("菜叶" = 1, "苹果" = 1)
	foodtypes = VEGETABLES | FRUIT
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/salad/validsalad
	name = "合法沙拉"
	desc = "只是一份加了肉丸和炸土豆片的香草沙拉。没有任何可疑之处。"
	icon_state = "validsalad"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/protein = 5, /datum/reagent/consumable/doctor_delight = 8, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("菜叶" = 1, "土豆" = 1, "肉" = 1, "合法" = 1)
	foodtypes = VEGETABLES | MEAT | FRIED
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/fruit
	name = "水果沙拉"
	desc = "标准的水果沙拉。"
	icon_state = "fruitsalad"
	food_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("水果" = 1)
	foodtypes = FRUIT|ORANGES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/jungle
	name = "丛林沙拉"
	desc = "一碗异域水果。"
	icon_state = "junglesalad"
	food_reagents = list(/datum/reagent/consumable/nutriment = 11, /datum/reagent/consumable/banana = 5, /datum/reagent/consumable/nutriment/vitamin = 7)
	tastes = list("水果" = 1, "丛林" = 1)
	foodtypes = FRUIT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/citrusdelight
	name = "柑橘盛宴"
	desc = "柑橘超载！"
	icon_state = "citrusdelight"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("酸味" = 1, "菜叶" = 1)
	foodtypes = FRUIT | ORANGES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/uncooked_rice
	name = "生米"
	desc = "一坨生米。"
	icon_state = "uncooked_rice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("米" = 1)
	foodtypes = GRAIN | RAW
	foodtypes_added_when_cooked = BREAKFAST

/obj/item/food/uncooked_rice/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/boiledrice, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/uncooked_rice/make_microwaveable()
	AddElement(/datum/element/microwavable, /obj/item/food/boiledrice)

/obj/item/food/boiledrice
	name = "白米饭"
	desc = "一杯热气腾腾的白米饭。单吃有点寡淡，但能成为美味佳肴的基础……"
	icon_state = "cooked_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("米" = 1)
	foodtypes = GRAIN | BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/salad/ricepudding
	name = "米布丁"
	desc = "人人都爱米布丁！"
	icon_state = "ricepudding"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("米" = 1, "甜味" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	venue_value = FOOD_PRICE_NORMAL

/obj/item/food/salad/ricepork
	name = "猪肉盖饭"
	desc = "嗯，看起来像猪肉……"
	icon_state = "riceporkbowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("米" = 1, "肉" = 1)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/salad/risotto
	name = "意式烩饭"
	desc = "意大利人精通所有碳水化合物的证明。"
	icon_state = "risotto"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("米" = 1, "奶酪" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/eggbowl
	name = "鸡蛋盖饭"
	desc = "一碗米饭配一个煎蛋。"
	icon_state = "eggbowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("米" = 1, "蛋" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|EGG
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/salad/edensalad
	name = "\improper 伊甸沙拉"
	desc = "充满尚未开发潜力的沙拉。"
	icon_state = "edensalad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("极致的苦味" = 3, "希望" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/gumbo
	name = "黑眼豆秋葵浓汤"
	desc = "一道香辣咸鲜的肉与米饭料理。"
	icon_state = "gumbo"
	food_reagents = list(
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment = 5,
	)
	tastes = list("逐渐升温的辣味" = 2, "咸香肉与蔬菜" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/reagent_containers/cup/bowl
	name = "碗"
	desc = "一个简单的碗，用来装汤和沙拉。"
	icon = 'icons/obj/food/soupsalad.dmi'
	icon_state = "bowl"
	base_icon_state = "bowl"
	initial_reagent_flags = OPENCONTAINER | DUNKABLE
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT*5)
	w_class = WEIGHT_CLASS_NORMAL
	custom_price = PAYCHECK_CREW * 0.6
	fill_icon_thresholds = list(0)
	fill_icon_state = "fullbowl"
	fill_icon = 'icons/obj/food/soupsalad.dmi'

	volume = SOUP_SERVING_SIZE + 5
	gulp_size = 3

	loop_drink = TRUE

/obj/item/reagent_containers/cup/bowl/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_REAGENT_EXAMINE, PROC_REF(reagent_special_examine))
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/salad/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 6)
	AddComponent( \
		/datum/component/takes_reagent_appearance, \
		on_icon_changed = CALLBACK(src, PROC_REF(on_cup_change)), \
		on_icon_reset = CALLBACK(src, PROC_REF(on_cup_reset)), \
		base_container_type = /obj/item/reagent_containers/cup/bowl, \
	)

/obj/item/reagent_containers/cup/bowl/on_cup_change(datum/glass_style/style)
	. = ..()
	fill_icon_thresholds = null

/obj/item/reagent_containers/cup/bowl/on_cup_reset()
	. = ..()
	fill_icon_thresholds ||= list(0)

/**
 * Override standard reagent examine
 * so that anyone examining a bowl of soup sees the soup but nothing else (unless they have sci goggles)
 */
/obj/item/reagent_containers/cup/bowl/proc/reagent_special_examine(datum/source, mob/user, list/examine_list, can_see_insides = FALSE)
	SIGNAL_HANDLER

	if(can_see_insides || reagents.total_volume <= 0)
		return

	var/unknown_volume = 0
	var/list/soups_found = list()
	for(var/datum/reagent/current_reagent as anything in reagents.reagent_list)
		if(istype(current_reagent, /datum/reagent/consumable/nutriment/soup))
			soups_found += "&bull; [round(current_reagent.volume, 0.01)] 单位 [current_reagent.name]"
		else
			unknown_volume += current_reagent.volume

	if(!length(soups_found))
		// There was no soup in the pot, do normal examine
		return

	examine_list += "里面可以看到："
	examine_list += soups_found
	if(unknown_volume > 0)
		examine_list += "&bull; [round(unknown_volume, 0.01)] 单位未知试剂"

	return STOP_GENERIC_REAGENT_EXAMINE

// empty salad for custom salads
/obj/item/food/salad/empty
	name = "沙拉"
	foodtypes = NONE
	tastes = list()
	icon_state = "bowl"
	desc = "一份美味的自定义沙拉。"

/obj/item/food/salad/kale_salad
	name = "羽衣甘蓝沙拉"
	desc = "淋上油的健康羽衣甘蓝沙拉，最适合温暖的夏季。"
	icon_state = "kale_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/nutriment = 12,
	)
	tastes = list("健康绿叶菜" = 2, "橄榄油调味汁" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/greek_salad
	name = "希腊沙拉"
	desc = "一道广受欢迎的沙拉，由番茄、洋葱、菲达奶酪和橄榄制成，全部淋上橄榄油。不过总觉得少了点什么……"
	icon_state = "greek_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 13,
		/datum/reagent/consumable/nutriment = 14,
	)
	tastes = list("健康绿叶菜" = 2, "橄榄油调味汁" = 1, "菲达奶酪" = 1)
	foodtypes = VEGETABLES|FRUIT|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/salad/caesar_salad
	name = "凯撒沙拉"
	desc = "一道简单却风味十足的沙拉，由洋葱、生菜、面包丁和奶酪丝拌油制成。还附一片皮塔饼！"
	icon_state = "caesar_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/nutriment = 12,
	)
	tastes = list("健康绿叶菜" = 2, "橄榄油调味汁" = 2, "菲达奶酪" = 2, "皮塔饼" = 1)
	foodtypes = VEGETABLES | DAIRY | GRAIN
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/salad/spring_salad
	name = "春日沙拉"
	desc = "一道简单的沙拉，由胡萝卜、生菜和豌豆淋上油、撒上一撮盐制成。"
	icon_state = "spring_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/nutriment = 12,
	)
	tastes = list("爽脆绿叶菜" = 2, "橄榄油调味汁" = 2, "盐" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/potato_salad
	name = "土豆沙拉"
	desc = "水煮土豆拌上水煮蛋、洋葱和蛋黄酱的料理。每个有自尊的烧烤派对的标配。"
	icon_state = "potato_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("奶油土豆" = 2, "蛋" = 2, "蛋黄酱" = 1, "洋葱" = 1)
	foodtypes = MEAT|VEGETABLES|EGG
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/spinach_fruit_salad
	name = "菠菜水果沙拉"
	desc = "一份色彩鲜亮的水果沙拉，由菠菜、浆果和菠萝块淋上油制成。真好吃！"
	icon_state = "spinach_fruit_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/nutriment = 12,
	)
	tastes = list("菠菜" = 2, "浆果" = 2, "菠萝" = 2, "调味汁" = 1)
	foodtypes = VEGETABLES|FRUIT|PINEAPPLE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/antipasto_salad
	name = "意式开胃沙拉"
	desc = "传统的意大利沙拉，由萨拉米香肠、马苏里拉奶酪、橄榄和番茄制成。常作为第一道菜上桌。"
	icon_state = "antipasto_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("生菜" = 2, "萨拉米香肠" = 2, "马苏里拉奶酪" = 2, "番茄" = 2, "调味汁" = 1)
	foodtypes = MEAT|VEGETABLES|FRUIT|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
