/obj/item/food/hemophage
	name = "血腥食物"
	desc = "如果你看到这个，说明出了很严重的问题，有机会的话请上报。"
	icon = 'modular_skyrat/master_files/icons/obj/food/hemophage_food.dmi'
	foodtypes = GORE | BLOODY

/obj/item/food/hemophage/blood_rice_pearl
	name = "血战珍珠"
	desc = "有趣的手抓小食。一小团一小团的糯米，混着少许猪肉末和葱花，再浸透并裹上新鲜血液，呈现出绯红色泽。建议趁热享用！"
	icon_state = "blood_rice_pearl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/blood = 10,
	)
	tastes = list("米饭" = 3, "血" = 5)
	foodtypes = GRAIN | GORE | BLOODY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/hemophage/blood_rice_pearl/raw
	name = "生血米"
	desc = "一团浸透鲜血的生米。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "uncooked_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/blood = 10,
	)
	tastes = list("生米" = 3, "血" = 5)
	color = "#810000"
	foodtypes = GRAIN | GORE | BLOODY | RAW
	crafting_complexity = FOOD_COMPLEXITY_0

/obj/item/food/hemophage/blood_rice_pearl/raw/make_microwaveable()
	AddElement(/datum/element/microwavable, /obj/item/food/hemophage/blood_rice_pearl)

/obj/item/food/hemophage/blood_noodles
	name = "水煮血面"
	desc = "一盘简单的血浸面条，多加点配料大概会更好吃。"
	icon = 'icons/obj/food/spaghetti.dmi'
	icon_state = "spaghettiboiled"
	color = "#810000"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/blood = 20,
	)
	tastes = list("血" = 5, "意面" = 1)
	foodtypes = GRAIN | GORE | BLOODY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/hemophage/blood_noodles/raw
	name = "生血面"
	desc = "彻底浸透血液的面条。生吃听起来并不诱人。其实煮熟了吃也一样。"
	color = "#ad0000"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/blood = 15, // You should really be cooking those if you want the full amount of blood out of them
	)
	tastes = list("血" = 5, "生意面" = 1)
	foodtypes = GRAIN | GORE | BLOODY | RAW
	crafting_complexity = FOOD_COMPLEXITY_0

/obj/item/food/hemophage/blood_noodles/raw/make_microwaveable()
	AddElement(/datum/element/microwavable, /obj/item/food/hemophage/blood_noodles)

/obj/item/food/hemophage/blood_noodles/boat_noodles
	name = "船面"
	desc = "这道菜通常用猪肉和牛肉的浓烈组合制成；这个无肉版本的主角是血豆腐和卷曲面条，经过调味并浸在新鲜血液中，直至变成绯红色。散发着浓重的铁腥味。"
	icon_state = "meatballspaghetti"
	color = "#d10000"
	max_volume = 70
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/blood = 50,
	)
	tastes = list("血" = 5, "凝固的血" = 3, "意面" = 1)
	foodtypes = GRAIN | GORE | BLOODY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/hemophage/blood_curd
	name = "血豆腐"
	desc = "又称“血凝块”或“血布丁”，这道洋语小吃看起来是用凝固后煮熟的血液制成。口感柔软顺滑，略带嚼劲，富含核黄素。"
	icon_state = "blood_curd"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/blood = 15,
	)
	tastes = list("凝固的血" = 1)
	foodtypes = GORE | BLOODY | RAW
	crafting_complexity = FOOD_COMPLEXITY_0

/obj/item/food/hemophage/blood_cake
	name = "猪血粿"
	desc = "又称“猪血糕”或“黑糕”，是血布丁的一种变体，通常在夜市作为街头小吃出售。由蒸熟的血液和糯米制成，外层裹上花生粉和香菜，还可以配些蘸酱食用。这道菜里的血量似乎被大幅提高，品尝时能感到那股再熟悉不过的铁腥味。"
	icon_state = "blood_cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/peanut_butter = 5,
		/datum/reagent/blood = 25,
	)
	tastes = list("血" = 5, "脆米" = 2, "花生酱" = 2)
	foodtypes = GRAIN | GORE | BLOODY | SUGAR | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/soup/hemophage/blood_soup
	name = "迪努关血汤"
	desc = "一种咸香炖菜，通常用内脏或现炖肉制成。这个版本改用血豆腐，还加入了由新鲜血液和醋熬成的浓郁辛香深色肉汁。另外还加了辣椒和大蒜，以提升汤汁的鲜香风味。"
	icon = 'modular_skyrat/master_files/icons/obj/food/hemophage_food.dmi'
	icon_state = "blood_soup"
	max_volume = 90
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/blood = 60,
	)
	tastes = list("血" = 5, "凝固的血" = 2, "辣椒" = 3, "醋" = 1, "大蒜" = 1)
	foodtypes = GORE | BLOODY | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4
