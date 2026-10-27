/obj/item/food/piru_dough
	name = "皮鲁面团"
	desc = "一种用皮鲁面粉和穆利汁制成的粗糙而富有弹性的面团，呈醒目的紫色，是大多数特沙利菜肴的基础。烤制或烘焙时会显著膨胀。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "piru_dough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("薄荷味面团" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/piru_dough/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, /obj/item/food/flat_piru_dough, 1, 3 SECONDS, table_required = TRUE, screentip_verb = "压平")

/obj/item/food/piru_dough/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/piru_loaf, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/piru_dough/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/piru_loaf, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/piru_loaf
	name = "皮鲁面包"
	desc = "一条松软的皮鲁面包，呈醒目的深紫色，已经可以切片了。它出奇地有弹性，闻起来有股薄荷味。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "piru_loaf"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("薄荷味面包" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/piru_loaf/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/breadslice/piru, 4, 3 SECONDS, table_required = TRUE, screentip_verb = "切片")

/obj/item/food/breadslice/piru
	name = "皮鲁面包片"
	desc = "一片富有弹性的皮鲁面包。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "piru_bread_slice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("薄荷味面包" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/flat_piru_dough
	name = "压平皮鲁面团"
	desc = "压平的皮鲁面团，可以在平底锅上煎熟，也可以切成面条。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "flat_piru_dough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("薄荷味面团" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/flat_piru_dough/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/piru_pasta, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切片")

/obj/item/food/flat_piru_dough/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/grilled_piru_flatbread, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/flat_piru_dough/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/grilled_piru_flatbread, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/grilled_piru_flatbread
	name = "烤皮鲁扁面包"
	desc = "酥脆的烤皮鲁扁面包。不再那么有弹性了，但闻起来绝对香极了。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "grilled_piru_flatbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("薄荷味扁面包" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/piru_pasta
	name = "皮鲁意面"
	desc = "粗切的皮鲁面团块，做成了有嚼劲的意面。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "piru_pasta"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("薄荷味意面" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/baked_kiri
	name = "烤基里果"
	desc = "在烤箱里烤过的基里果，里面的果冻焦糖化，变成类似果冻甜甜圈的酥脆点心。小心别上瘾。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "baked_kiri"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/kiri_jelly = 6
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("酥脆甜味" = 1, "焦糖果冻" = 1)
	foodtypes = FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/baked_muli
	name = "烤穆利荚"
	desc = "在烤箱里烤过的穆利荚，里面的薄荷汁浓缩，外皮变软，让这种蔬菜有了水煮蛋般的质地。既美味又健康！"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "baked_muli"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/muli_juice = 4
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("清爽薄荷味" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spiced_jerky
	name = "香料肉干"
	desc = "一段用纳卡提香料调味并脱水的肉，是美味又有嚼劲的零食。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "spiced_jerky"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 6
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("有嚼劲的香辣肉干" = 1)
	foodtypes = MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/sirisai_wrap
	name = "西里赛卷饼"
	desc = "用纳卡提香料调味的肉和卷心菜，紧紧裹在压平的皮鲁面包里。简单、清淡、美味。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "sirisai_wrap"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("熟卷心菜" = 1, "香料肉" = 1, "薄荷味皮鲁面包" = 1)
	foodtypes = MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/sweet_piru_noodles
	name = "香甜皮鲁面"
	desc = "把皮鲁意面与切碎的基里果、穆利荚和胡萝卜拌在碗里。看起来很奇怪，还有点黏糊糊的，但味道无可否认。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "sweet_piru_noodles"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/kiri_jelly = 4,
		/datum/reagent/consumable/muli_juice = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("薄荷味皮鲁面" = 1, "薄荷味穆利汁" = 1, "甜基里果冻" = 1, "烤胡萝卜" = 1)
	foodtypes = VEGETABLES | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/kiri_curry
	name = "基里咖喱"
	desc = "香料肉与切细的皮鲁意面、碎辣椒混合，再淋上皮鲁果冻酱，辣与甜的完美平衡。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "kiri_curry"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/kiri_jelly = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("重香料肉" = 1, "加糖薄荷皮鲁面" = 1, "清爽辣椒" = 1)
	foodtypes = VEGETABLES | FRUIT | SUGAR | MEAT
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/sirisai_flatbread
	name = "西里赛烤饼"
	desc = "皮鲁扁面包烤至酥脆，上面铺着肉、切碎的穆利荚和番茄酱。看起来像披萨，但紫得多、蓝得多。可以切片！"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "sirisai_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 24,
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/consumable/muli_juice = 12,
		/datum/reagent/consumable/nutriment/vitamin = 16
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("酥脆薄荷扁面包" = 1, "薄荷味穆利荚" = 1, "番茄酱" = 1, "酸辣香料" = 1, "烤肉" = 1)
	foodtypes = VEGETABLES | MEAT
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 3)

/obj/item/food/sirisai_flatbread/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/sirisai_flatbread_slice, 4, 3 SECONDS, table_required = TRUE, screentip_verb = "切片")

/obj/item/food/sirisai_flatbread_slice
	name = "西里赛烤饼切片"
	desc = "一片烤至酥脆的皮鲁扁面包，上面铺着肉、切碎的穆利荚和番茄酱。看起来像一片披萨，但紫得多、蓝得多。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "sirisai_flatbread_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/muli_juice = 3,
		/datum/reagent/consumable/nutriment/vitamin = 4
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("酥脆薄荷扁面包" = 1, "薄荷味穆利荚" = 1, "番茄酱" = 1, "酸辣香料" = 1, "烤肉" = 1)
	foodtypes = VEGETABLES | MEAT
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 0.75)

/obj/item/food/bluefeather_crisp
	name = "蓝羽脆饼"
	desc = "一种用压平晾干的皮鲁面包制成的香料脆饼。名字来源于搭配穆利蘸酱食用时经常在羽毛上留下的蓝色污渍。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "bluefeather_crisp"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("有嚼劲的脆饼" = 1, "清爽香料" = 1, "宜人的薄荷味" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bluefeather_crisps_and_dip
	name = "蓝羽脆饼配蘸酱"
	desc = "蓝羽脆饼，现在配上了用穆利汁和番茄制成的蘸酱。名字来源于滴到羽毛上时经常留下的蓝色污渍。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "bluefeather_crisps_and_dip"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/muli_juice = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("有嚼劲的脆饼" = 1, "酸爽蘸酱" = 1, "宜人的薄荷味" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/stewed_muli
	name = "炖穆利"
	desc = "一道简单的炖菜，把肉、胡萝卜和卷心菜都用穆利汁炖熟。适合成长中的特沙利。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "stewed_muli"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/muli_juice = 6
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("丰盛香料肉" = 1, "烤胡萝卜" = 1, "烤卷心菜" = 1, "薄荷味肉汤" = 1)
	foodtypes = VEGETABLES | MEAT
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/stuffed_muli_pod
	name = "酿穆利荚"
	desc = "一只煮熟的穆利荚，里面塞满肉、碎基里果和辣椒。有嚼劲、甜辣俱全！"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "stuffed_muli_pod"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/muli_juice = 4
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("香料肉" = 1, "薄荷味穆利荚" = 1, "超甜基里果" = 1, "辣椒" = 1)
	foodtypes = VEGETABLES | FRUIT | MEAT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/caramel_jelly_toast
	name = "焦糖果冻吐司"
	desc = "一片烤过的皮鲁面包，涂上厚厚一层焦糖和甜美的基里果冻。这到底算早餐还是甜点？"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "caramel_jelly_toast"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("薄荷味皮鲁面包" = 1, "甜焦糖" = 1, "超甜基里果冻" = 1)
	foodtypes = VEGETABLES | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/kiri_jellypuff
	name = "基里果冻酥"
	desc = "一片皮鲁面包膨发后卷成厚圆盘，内馅是基里果冻与奶油，表面撒着皮鲁面粉。只吃一个绝对不够。"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "kiri_jellypuff"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/kiri_jelly = 4
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("膨松薄荷皮鲁面包" = 1, "浓郁奶油" = 1, "超甜基里果冻" = 1)
	foodtypes = VEGETABLES | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4
