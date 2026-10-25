//Lizard Foods, for lizards (and weird humans!)

//Meat Dishes

/obj/item/food/raw_tiziran_sausage
	name = "生提兹拉血肠"
	desc = "一根生的提兹拉血肠，可以直接放到晾晒架上腌渍。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "raw_lizard_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/blood = 3,
	)
	tastes = list("肉" = 1, "黑布丁" = 1)
	foodtypes = MEAT|RAW
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/raw_tiziran_sausage/make_dryable()
	AddElement(/datum/element/dryable, /obj/item/food/tiziran_sausage)

/obj/item/food/tiziran_sausage
	name = "\improper 提兹拉血肠"
	desc = "一种粗制的风干血肠，传统上由扎戈斯凯尔德周边农地的农户制作。口感类似旧地球的西班牙辣香肠。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("肉" = 1, "黑布丁" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_price = PAYCHECK_CREW
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/raw_headcheese
	name = "生头肉冻块"
	desc = "头肉冻是提兹拉的一种常见食物，传统做法是取动物的头，去掉内脏，煮到散烂，然后收集起来，沥去水分，大量加盐，压成块，再晾干熟成数月。成品坚硬的块状物味道类似奶酪。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "raw_lizard_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/salt = 5,
	)
	tastes = list("肉" = 1, "盐" = 1)
	foodtypes = MEAT|RAW|GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/raw_headcheese/make_dryable()
	AddElement(/datum/element/dryable, /obj/item/food/headcheese)

/obj/item/food/headcheese
	name = "头肉冻块"
	desc = "一块熟成的头肉冻。如果你是蜥蜴人，那真是美味。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/salt = 5,
	)
	tastes = list("奶酪" = 1, "盐" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/headcheese/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/headcheese_slice, 5, 3 SECONDS, table_required = TRUE, screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/headcheese_slice
	name = "头肉冻片"
	desc = "一片头肉冻，适合做三明治和点心。也适合熬过提兹拉的寒冬。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_cheese_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("奶酪" = 1, "盐" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT / 5)

/obj/item/food/shredded_lungs
	name = "酥脆肺丝炒"
	desc = "酥脆的肺丝，配蔬菜和辣酱。如果你喜欢肺，那真是美味。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lung_stirfry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("肉" = 1, "辣味" = 1, "蔬菜" = 1)
	foodtypes = MEAT | VEGETABLES | GORE
	trash_type = /obj/item/reagent_containers/cup/bowl
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/tsatsikh
	name = "察齐赫"
	desc = "一道提兹拉菜，用香料调味的碎内脏塞进胃里煮熟。对不习惯这种味道的人来说相当恶心。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "tsatsikh"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 10)
	tastes = list("各式碎内脏" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/liver_pate
	name = "肝酱"
	desc = "用肝、肉和少许配料制成的浓郁肉酱，增添额外风味。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "pate"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 5)
	tastes = list("肝" = 1)
	foodtypes = MEAT|VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/moonfish_eggs
	name = "月鱼籽"
	gender = PLURAL
	desc = "月鱼会产下大型半透明的蓝色鱼卵，在蜥蜴人料理中备受珍视。风味类似鱼子酱，但通常被形容为更深厚、更复杂。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_eggs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("鱼子酱" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/moonfish_eggs/Initialize(mapload)
	. = ..()
	//Moonfish can lay eggs inside aquariums (unaffected by breeding, so think of them as unfertilizard)
	RegisterSignal(src, COMSIG_AQUARIUM_CONTENT_GENERATE_APPEARANCE, PROC_REF(generate_aquarium_appearance))
	RegisterSignal(src, COMSIG_AQUARIUM_CONTENT_RANDOMIZE_POSITION, PROC_REF(randomize_aquarium_position))
	AddComponent(/datum/component/aquarium_content)
	RegisterSignal(src, COMSIG_MOVABLE_GET_AQUARIUM_BEAUTY, PROC_REF(get_aquarium_beauty))

/obj/item/food/moonfish_eggs/proc/generate_aquarium_appearance(datum/source, obj/effect/aquarium/visual)
	SIGNAL_HANDLER
	visual.icon = icon
	visual.icon_state = "moonfish_eggs_aquarium"
	visual.layer_mode = AQUARIUM_LAYER_MODE_BOTTOM

/obj/item/food/moonfish_eggs/proc/randomize_aquarium_position(datum/source, obj/structure/aquarium/current_aquarium, obj/effect/aquarium/visual)
	SIGNAL_HANDLER
	var/sprite_width = 5
	var/sprite_height = 4
	var/pw_min = visual.aquarium_zone_min_pw
	var/pw_max = visual.aquarium_zone_max_pw - sprite_width
	var/pz_min = visual.aquarium_zone_min_pz - sprite_height

	visual.pixel_w = rand(pw_min, pw_max)
	visual.pixel_z = pz_min + rand(-1, 1)

/obj/item/food/moonfish_eggs/proc/get_aquarium_beauty(datum/source, list/beauty_holder)
	SIGNAL_HANDLER
	beauty_holder += 100 //moonfish eggs are kinda eye candy

/obj/item/food/moonfish_caviar
	name = "月鱼籽酱"
	desc = "用月鱼籽制成的浓郁酱料。多数蜥蜴人一般只能这样吃到月鱼籽，在沿海料理中用得相当多。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_caviar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("鱼子酱" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/lizard_escargot
	name = "沙漠蜗牛科克莱阿斯"
	desc = "蜥蜴人与人类文化交融的又一个例子，这道沙漠蜗牛菜更接近罗马的科克莱阿斯，而非当代的法式焗蜗牛。这是沙漠城市里常见的街头小吃。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_escargot"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("蜗牛" = 1, "大蒜" = 1, "油" = 1)
	foodtypes = MEAT|VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/fried_blood_sausage
	name = "炸血肠"
	desc = "裹上面糊油炸的血肠。在扎戈斯凯尔德的街头常配薯条，作为快捷简单的小吃。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "fried_blood_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 1,
	)
	tastes = list("黑布丁" = 1, "面糊" = 1, "油" = 1)
	foodtypes = MEAT|NUTS|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

//Why does like, every language on the planet besides English call them pommes? Who knows, who cares- the lizards call them it too, because funny.
/obj/item/food/lizard_fries
	name = "豪华普姆斯-弗朗齐斯克"
	desc = "传入蜥蜴人社会的众多人类食物之一是炸薯条，在龙语中称为普姆斯-弗朗齐斯克。配上烤肉和酱汁，就是一顿丰盛的饭。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/bbqsauce = 2,
	)
	tastes = list("薯条" = 2, "烧烤酱" = 1, "烤肉" = 1)
	foodtypes = MEAT | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/brain_pate
	name = "眼球脑花酱"
	desc = "由切碎的水煮眼球和脑、炒洋葱与脂肪制成的浓稠粉色肉酱。蜥蜴人发誓说这很美味！"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "brain_pate"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/liquidgibs = 2,
	)
	tastes = list("脑" = 2)
	foodtypes = MEAT | VEGETABLES | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/crispy_headcheese
	name = "酥炸裹粉头肉冻"
	desc = "扎戈斯凯尔德街头的美味小吃，用根面包屑裹住头肉冻制成。常配薯条。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "crispy_headcheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("奶酪" = 1, "油" = 1)
	foodtypes = MEAT | VEGETABLES | NUTS | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT / 5)

/obj/item/food/kebab/picoss_skewers
	name = "皮科斯串"
	desc = "提兹拉流行的街头小吃，把醋腌甲鱼串在签子上，配洋葱和辣椒。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "picoss_skewer"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/vinegar = 1,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("鱼" = 1, "酸味" = 1, "洋葱" = 1, "辣味" = 1)
	foodtypes = VEGETABLES|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/nectar_larvae
	name = "花蜜幼虫"
	desc = "酥脆的小幼虫，裹在用科塔花蜜调制的甜辣酱里。虫子味十足！"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "nectar_larvae"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/korta_nectar = 3,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("肉" = 1, "甜味" = 1, "辣味" = 1)
	foodtypes = MEAT|VEGETABLES|BUGS|GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/mushroomy_stirfry
	name = "蘑菇炒菜"
	desc = "各式蘑菇的杂烩，专为满足你的饕餮之欲。妙极了！"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "mushroomy_stirfry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("美味蘑菇" = 1, "绝妙蘑菇" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Fish Dishes
/obj/item/food/grilled_moonfish
	name = "烤月鱼"
	desc = "一块烤月鱼。传统上配扇贝形根茎和葡萄酒酱汁食用。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "grilled_moonfish"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("鱼" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/moonfish_demiglace
	name = "月鱼半釉汁"
	desc = "一块煎得恰到好处的月鱼，铺在土豆和胡萝卜上，淋上葡萄酒半釉汁。简直妙不可言。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_demiglace"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 2,
	)
	tastes = list("鱼" = 2, "土豆" = 1, "胡萝卜" = 1)
	foodtypes = VEGETABLES|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/lizard_surf_n_turf
	name = "\improper 扎戈斯海陆大餐拼盘"
	desc = "一大盘提兹拉最上等的肉与海鲜，通常是海滩上一群人分食。当然，没人阻止你一个人吃完……胖子。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "surf_n_turf"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("海鲜" = 1, "牛排" = 1)
	foodtypes = MEAT | SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_BULKY
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 3)

//Spaghetti Dishes

/obj/item/food/spaghetti/nizaya
	name = "尼扎亚面"
	desc = "一种用根茎和坚果制成的面食，原产于提兹拉沿海地区。质地和外观类似意式土豆团子。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("意式土豆团子" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/nizaya/egg
	foodtypes = parent_type::foodtypes | MEAT

/obj/item/food/spaghetti/snail_nizaya
	name = "沙漠蜗牛尼扎亚"
	desc = "来自提兹拉瓦林吉亚葡萄园地区的高级面食。传统上只用最上等的提兹拉葡萄酒……但急起来，人类的劣酒也行。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "snail_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("蜗牛" = 1, "葡萄酒" = 1, "意式土豆团子" = 1)
	foodtypes = VEGETABLES | MEAT | NUTS
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/garlic_nizaya
	name = "蒜油尼扎亚"
	desc = "蜥蜴人对意大利面食蒜油意面的改良版，用尼扎亚面制作。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "garlic_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("大蒜" = 1, "油" = 1, "意式土豆团子" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spaghetti/demit_nizaya
	name = "德米特尼扎亚"
	desc = "用科塔奶和花蜜制成的甜奶油尼扎亚面。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "demit_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/korta_nectar = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("胡椒甜味" = 1, "蔬菜" = 1, "意式土豆团子" = 1)
	foodtypes = VEGETABLES|NUTS|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/mushroom_nizaya
	name = "蘑菇尼扎亚"
	desc = "用塞拉卡蘑菇和优质油制成的尼扎亚面。坚果风味鲜明。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "mushroom_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("鲜味" = 1, "坚果香" = 1, "意式土豆团子" = 1)
	foodtypes = VEGETABLES|NUTS
	crafting_complexity = FOOD_COMPLEXITY_4

//Dough Dishes

/obj/item/food/rootdough
	name = "根面团"
	desc = "用坚果和块茎制成的根茎面团。广泛用于提兹拉的各种料理。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootdough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("土豆" = 1, "泥土辛香" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1
	var/bread_type = /obj/item/food/bread/root
	var/flat_type = /obj/item/food/flatrootdough

/obj/item/food/rootdough/make_bakeable()
	AddComponent(/datum/component/bakeable, bread_type, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/rootdough/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, flat_type, 1, 3 SECONDS, table_required = TRUE, screentip_verb = "压平", sound_to_play = SFX_ROLLING_PIN_ROLLING)

/obj/item/food/rootdough/egg
	desc = "用坚果、块茎和鸡蛋制成的根茎面团。广泛用于提兹拉的各种料理。"
	foodtypes = parent_type::foodtypes | MEAT
	bread_type = /obj/item/food/bread/root/egg
	flat_type = /obj/item/food/flatrootdough/egg

/obj/item/food/flatrootdough
	name = "扁平根面团"
	desc = "压扁的根面团，可以用来做扁面包，或切成小块。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "flat_rootdough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("土豆" = 1, "泥土辛香" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1
	var/process_type = /obj/item/food/rootdoughslice
	var/grill_type = /obj/item/food/root_flatbread

/obj/item/food/flatrootdough/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, process_type, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/flatrootdough/make_grillable()
	AddComponent(/datum/component/grillable, grill_type, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/flatrootdough/egg
	foodtypes = parent_type::foodtypes | MEAT
	process_type = /obj/item/food/rootdoughslice/egg
	grill_type = /obj/item/food/root_flatbread/egg

/obj/item/food/rootdoughslice
	name = "根面团球"
	desc = "一颗根面团球。做面食或面包卷都合适。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootdough_slice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("土豆" = 1, "泥土辛香" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1
	var/process_type = /obj/item/food/spaghetti/nizaya
	var/bake_type = /obj/item/food/rootroll

/obj/item/food/rootdoughslice/egg
	foodtypes = parent_type::foodtypes | MEAT

/obj/item/food/rootdoughslice/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/spaghetti/nizaya, 1, 3 SECONDS, table_required = TRUE, screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/rootdoughslice/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/rootroll, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/rootdoughslice/egg
	process_type = /obj/item/food/spaghetti/nizaya/egg
	bake_type = /obj/item/food/rootroll/egg

/obj/item/food/root_flatbread
	name = "根扁面包"
	desc = "朴素的原味烤根扁面包。可以铺上各种蜥蜴人爱吃的食材。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "root_flatbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("面包" = 1, "泥土辛香" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/root_flatbread/egg
	foodtypes = parent_type::foodtypes | MEAT

/obj/item/food/rootroll
	name = "根面包卷"
	desc = "紧实有嚼劲的面包卷，用根茎制成。配一碗汤很不错。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootroll"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("面包卷" = 1) // the roll tastes of roll.
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/rootroll/egg
	foodtypes = parent_type::foodtypes | MEAT

//Bread Dishes

/obj/item/food/bread/root
	name = "根面包"
	desc = "蜥蜴人的面包替代品，用土豆、山药等块茎混合磨碎的坚果和种子制成。明显比普通面包更紧实。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_bread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("面包" = 8, "坚果" = 2)
	foodtypes = VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/breadslice/root

/obj/item/food/bread/root/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/bread/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 8)

/obj/item/food/bread/root/egg
	foodtypes = parent_type::foodtypes | MEAT
	slice_type = /obj/item/food/breadslice/root/egg

/obj/item/food/breadslice/root
	name = "根面包片"
	desc = "一片紧实有嚼劲的根面包。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_breadslice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("面包" = 8, "坚果" = 2)
	foodtypes = VEGETABLES | NUTS
	venue_value = FOOD_PRICE_TRASH

/obj/item/food/breadslice/root/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/breadslice/root/egg
	foodtypes = parent_type::foodtypes | MEAT

//Pizza Dishes
/obj/item/food/pizza/flatbread
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = null
	abstract_type = /obj/item/food/pizza/flatbread
	slice_type = null

/obj/item/food/pizza/flatbread/rustic
	name = "乡村薄饼"
	desc = "一道简单的提兹拉乡村菜，常作为肉或鱼料理的配菜。铺上香草和油。"
	icon_state = "rustic_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/vitamin = 15,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("面包" = 1, "香草" = 1, "油" = 1, "大蒜" = 1)
	foodtypes = VEGETABLES | NUTS
	boxtag = "提兹拉薄饼"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/flatbread/italic
	name = "\improper 意式薄饼"
	desc = "人类食物传入提兹拉推动了蜥蜴人料理的进步——意式薄饼如今是该星球外卖店菜单上的常见品。"
	icon_state = "italic_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)
	tastes = list("面包" = 1, "香草" = 1, "油" = 1, "大蒜" = 1, "番茄" = 1, "肉" = 1)
	foodtypes = VEGETABLES | NUTS | MEAT
	boxtag = "意式薄饼"
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/pizza/flatbread/imperial
	name = "\improper 帝国薄饼"
	desc = "铺上肉酱、腌菜和头肉冻丁的薄饼。除了蜥蜴人，几乎迎合不了任何人的口味。"
	icon_state = "imperial_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("面包" = 1, "香草" = 1, "油" = 1, "大蒜" = 1, "番茄" = 1, "肉" = 1)
	foodtypes = VEGETABLES | MEAT | NUTS | GORE
	boxtag = "帝国胜利薄饼"
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 4)

/obj/item/food/pizza/flatbread/rawmeat
	name = "肉食者薄饼"
	desc = "说也奇怪，这道提兹拉菜其实深受一些注重健康的人类喜爱。"
	icon_state = "rawmeat_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 10,
	)
	tastes = list("面包" = 1, "肉" = 1)
	foodtypes = MEAT|VEGETABLES|RAW|NUTS
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/pizza/flatbread/stinging
	name = "\improper 刺蛰薄饼"
	desc = "水母与蜂幼虫的电力组合带来让你意犹未尽的风味享受！"
	icon_state = "stinging_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 20,
		/datum/reagent/consumable/honey = 2,
	)
	tastes = list("面包" = 1, "甜味" = 1, "刺麻" = 1, "黏液" = 1)
	foodtypes = MEAT|VEGETABLES|NUTS|SEAFOOD|BUGS|GORE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/flatbread/zmorgast  // Name is based off of the Swedish dish Smörgåstårta
	name = "\improper 兹莫加斯特薄饼"
	desc = "提兹拉人对瑞典三明治蛋糕的再创作，兹莫加斯特是家庭聚会上的常见菜。"
	icon_state = "zmorgast_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 16,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("面包" = 1, "肝" = 1, "家常味" = 1)
	foodtypes = VEGETABLES | NUTS | MEAT | EGG
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/flatbread/fish
	name = "\improper 烧烤鱼薄饼"
	desc = "超物质脱层、小丑行动、外面太冷，看在提兹拉的份上我就是想烧烤！"
	icon_state = "fish_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/bbqsauce = 2,
	)
	tastes = list("面包" = 1, "鱼" = 1)
	foodtypes = VEGETABLES|NUTS|SEAFOOD
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizza/flatbread/mushroom
	name = "蘑菇番茄薄饼"
	desc = "意式薄饼的简单替代品，适合你已经在别处吃肉吃撑了的时候。"
	icon_state = "mushroom_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 18,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes =  list("面包" = 1, "蘑菇" = 1, "番茄" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizza/flatbread/nutty
	name = "坚果酱薄饼"
	desc = "现代烹饪的进步让人能在这款薄饼上享受双份科塔坚果的美味，既做饼底又做配料。"
	icon_state = "nutty_flatbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes =  list("面包" = 1, "坚果" = 2)
	foodtypes = NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

//Sandwiches/Toast Dishes
/obj/item/food/emperor_roll
	name = "皇帝卷"
	desc = "提兹拉流行的三明治，以皇室家族之名命名。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "emperor_roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("面包" = 1, "奶酪" = 1, "肝" = 1, "鱼子酱" = 1)
	foodtypes = VEGETABLES | NUTS | MEAT | GORE | SEAFOOD
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2.25)

/obj/item/food/honey_roll
	name = "蜂蜜甜卷"
	desc = "加了糖、夹着水果片的根面包卷，是提兹拉季节性甜点。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "honey_roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/honey = 2,
	)
	tastes = list("面包" = 1, "蜂蜜" = 1, "水果" = 1)
	foodtypes = VEGETABLES | NUTS | FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

//Egg Dishes
/obj/item/food/black_eggs
	name = "黑炒蛋"
	desc = "提兹拉乡村的一道乡土菜。用蛋、血和采集的绿叶菜制成。传统上配根面包和辣酱食用。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "black_eggs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("蛋" = 1, "绿叶菜" = 1, "血" = 1)
	foodtypes = MEAT | BREAKFAST | GORE | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/patzikula
	name = "帕齐库拉"
	desc = "浓郁香辣的番茄酱铺上鸡蛋烘烤而成。美味。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "patzikula"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("蛋" = 1, "番茄" = 1, "辣味" = 1)
	foodtypes = VEGETABLES | MEAT | BREAKFAST | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Cakes/Sweets

/obj/item/food/cake/korta_brittle
	name = "科塔果脆糖板"
	desc = "一大块科塔坚果脆糖。甜得简直该算犯罪！"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_brittle"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 20,
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/korta_nectar = 15,
	)
	tastes = list("胡椒辣味" = 1, "甜味" = 1)
	foodtypes = NUTS | SUGAR
	slice_type = /obj/item/food/cakeslice/korta_brittle
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/korta_brittle
	name = "科塔果脆糖片"
	desc = "一小片科塔坚果脆糖。糖尿病患者最大的敌人。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_brittle_slice"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/korta_nectar = 3,
	)
	tastes = list("胡椒辣味" = 1, "甜味" = 1)
	foodtypes = NUTS | SUGAR

/obj/item/food/snowcones/korta_ice
	name = "科塔冰"
	desc = "刨冰、科塔花蜜和浆果。消暑的甜蜜享受！"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_ice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/ice = 4,
		/datum/reagent/consumable/berryjuice = 6,
	)
	tastes = list("胡椒甜味" = 1, "浆果" = 1)
	foodtypes = NUTS | SUGAR | FRUIT

/obj/item/food/kebab/candied_mushrooms
	name = "蜜饯蘑菇"
	desc = "提兹拉一道略显奇特的菜，把塞拉卡蘑菇裹上焦糖串在签子上。带有明显的“甜咸”风味。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "candied_mushrooms"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/caramel = 4,
	)
	tastes = list("鲜味" = 1, "甜味" = 1)
	foodtypes = SUGAR | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

//Misc Dishes
/obj/item/food/sauerkraut
	name = "酸菜"
	desc = "腌制卷心菜，因德国人而闻名，后来在蜥蜴人料理中变得常见，当地称之为藻尔克拉特。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "sauerkraut"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("卷心菜" = 1, "酸味" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/lizard_dumplings
	name = "\improper 提兹拉团子"
	desc = "捣碎的根茎蔬菜混合科塔面粉煮成的大颗圆团子，略带辣味。常放在汤里吃。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_dumplings"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("土豆" = 1, "泥土辛香" = 1)
	foodtypes = VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/steeped_mushrooms
	name = "浸泡塞拉卡蘑菇"
	desc = "把塞拉卡蘑菇泡在碱性水中以去除提取物，从而完全安全可食。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "steeped_mushrooms"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("鲜味" = 1, "坚果香" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/canned/jellyfish
	name = "罐头炮手水母"
	desc = "一罐盐水浸泡的炮手水母。含有温和的致幻剂，烹饪会将其破坏。"
	icon_state = "jellyfish"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/toxin/mindbreaker = 2,
		/datum/reagent/consumable/salt = 1,
	)
	trash_type = /obj/item/trash/can/food/jellyfish
	tastes = list("黏液" = 1, "灼烧感" = 1, "盐" = 1)
	foodtypes = SEAFOOD | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/canned/desert_snails
	name = "罐头沙漠蜗牛"
	desc = "提兹拉沙漠的巨型蜗牛，盐水装罐。带壳。除非你是蜥蜴人，否则最好别生吃。"
	icon_state = "snails"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/salt = 2,
	)
	trash_type = /obj/item/trash/can/food/desert_snails
	tastes = list("蜗牛" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/canned/larvae
	name = "罐头蜜蜂幼虫"
	desc = "一罐泡在蜂蜜里的蜜蜂幼虫。对某些人来说大概很开胃。"
	icon_state = "larvae"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/honey = 2,
	)
	trash_type = /obj/item/trash/can/food/larvae
	tastes = list("甜虫" = 1)
	foodtypes = MEAT | GORE | BUGS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/rootbread_peanut_butter_jelly
	name = "花生酱果酱根三明治"
	desc = "经典的花生酱果酱根三明治，就像取代你妈妈的那个复制人以前做的那样。"
	icon_state = "peanutbutter-jelly"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("花生酱" = 1, "果酱" = 1, "根面包" = 2)
	foodtypes = FRUIT|VEGETABLES|NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/rootbread_peanut_butter_banana
	name = "花生酱香蕉根三明治"
	desc = "夹着香蕉片的花生酱根三明治，高蛋白的好点心。"
	icon_state = "peanutbutter-banana"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("花生酱" = 1, "香蕉" = 1, "根面包" = 2)
	foodtypes = FRUIT|VEGETABLES|NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/burger/plain/korta
	name = "原味根汉堡"
	desc = "简单的肉饼夹在根面团面包胚里。"
	icon_state = "kortaburger"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = MEAT|VEGETABLES|NUTS
	crafting_complexity = FOOD_COMPLEXITY_3 //Gotta make the dough, +1
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/rat/korta
	name = "老鼠根汉堡"
	desc = "基本就是你想的那样……只是换成了根面团面包胚。"
	icon_state = "ratburger"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("死老鼠" = 4, "面包胚" = 2)
	foodtypes = NUTS | MEAT | GORE | VEGETABLES | RAW
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/burger/rootguffin
	name = "根麦芬"
	desc = "便宜油腻、适合蜥蜴人的班尼迪克蛋仿制品。"
	icon_state = "rootguffin"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/eggyolk = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("玛芬" = 2, "培根" = 3)
	foodtypes = NUTS | MEAT | BREAKFAST | VEGETABLES | FRIED | EGG
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/rootrib
	name = "根肋堡"
	desc = "一种行踪难寻的肋形汉堡，全银河供应有限。如今已能满足亚人类的需求。"
	icon_state = "rootrib"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/bbqsauce = 1,
	)
	tastes = list("面包胚" = 2, "猪肉饼" = 4)
	foodtypes = NUTS | MEAT | VEGETABLES | SUGAR
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/rootchicken
	name = "鸡肉根三明治"
	desc = "美味的鸡肉三明治，夹在松软的根面包卷里。"
	icon_state = "rootchicken"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/mayonnaise = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("面包胚" = 2, "鸡肉" = 4, "神的契约" = 1)
	foodtypes = NUTS | MEAT | VEGETABLES
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/rootfish
	name = "鱼肉根三明治"
	desc = "轻裹面糊的鱼肉，夹在根面包卷里。"
	icon_state = "rootfish"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("面包胚" = 4, "鱼" = 4)
	foodtypes = VEGETABLES | NUTS | SEAFOOD
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/burger/sloppyroot
	name = "邋遢莫伊"
	desc = "碎肉混合洋葱和烧烤酱，邋遢地堆在根面包卷上。美味，但保证会弄脏手。"
	icon_state = "sloppyroot"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("多汁肉" = 4, "烧烤酱" = 3, "洋葱" = 2, "面包胚" = 2)
	foodtypes = NUTS | MEAT | VEGETABLES
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)
