//Ingredients and Simple Dishes
/obj/item/food/kimchi
	name = "泡菜"
	desc = "火星风格的经典韩式料理：白菜丝配辣椒、昆布、柴鱼和混合香料。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("辣白菜" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/inferno_kimchi
	name = "地狱泡菜"
	desc = "当普通泡菜无法满足你对疯狂辣度的渴望时，地狱泡菜就来补上这一课。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "inferno_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 3,
	)
	tastes = list("超辣白菜" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/garlic_kimchi
	name = "蒜香泡菜"
	desc = "经典配方的新变化——泡菜和大蒜，终于完美和谐地结合在一起。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "garlic_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("辣白菜" = 1, "大蒜" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/surimi
	name = "鱼糜"
	desc = "一份未熟成的鱼肉糜。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "surimi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("鱼" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/surimi/make_dryable()
	AddElement(/datum/element/dryable, /obj/item/food/kamaboko)

/obj/item/food/kamaboko
	name = "蒲鉾"
	desc = "日式熟成鱼板，常用于点心和拉面。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kamaboko_sunrise"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("鱼" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kamaboko/Initialize(mapload)
	. = ..()
	var/design = pick("smiling", "spiral", "star", "sunrise")
	name = "[design == "smiling" ? "笑脸" : design == "spiral" ? "螺旋" : design == "star" ? "星星" : "日出"]蒲鉾"
	icon_state = "kamaboko_[design]"

/obj/item/food/kamaboko/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/kamaboko_slice, 4, 3 SECONDS, table_required = TRUE, screentip_verb = "切")

/obj/item/food/kamaboko_slice
	name = "蒲鉾片"
	desc = "一片鱼板。放在拉面里很不错。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kamaboko_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("鱼" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/sambal
	name = "参巴酱"
	desc = "来自印尼的香料酱，广泛用于东南亚各地的烹饪。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "sambal"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 2
	)
	tastes = list("辣椒辣味" = 1, "鲜味" = 1)
	foodtypes = VEGETABLES|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/katsu_fillet
	name = "炸排柳"
	desc = "裹上面包屑油炸的肉，可用于多种菜肴。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "katsu_fillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment = 2
	)
	tastes = list("肉" = 1, "面包屑" = 1)
	foodtypes = MEAT|FRIED|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/rice_dough
	name = "米面团"
	desc = "用等量米粉和面粉揉成的面团，风味独特。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "rice_dough"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6
	)
	tastes = list("米" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/rice_dough/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/bread/reispan, rand(30 SECONDS, 45 SECONDS), TRUE, TRUE)

/obj/item/food/rice_dough/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/spaghetti/rawnoodles, 6, 3 SECONDS, table_required = TRUE)

/obj/item/food/spaghetti/rawnoodles
	name = "鲜面条"
	desc = "现做的米粉面。记住，没有什么秘密配方。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_noodles"

	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("米" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/boilednoodles
	name = "熟面条"
	desc = "现点现煮。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "cooked_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("米" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spaghetti/ramen_dry
	name = "干太空拉面"
	desc = "压缩脱水面条。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_ramen"

	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("拉面" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/ramen_beef
	name = "牛肉太空拉面"
	desc = "热气腾腾的弹牙面条，浸在浓郁的人造牛肉汤里。既令人安心，又隐约带点化学味。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "cooked_ramen"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("拉面" = 1, "牛肉" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/reispan
	name = "米面包"
	desc = "虽然米制面包的概念在亚洲已流传数百年，但如今我们熟知的米面包最常与火星联系在一起——那里耕地有限，逼人发挥巧思。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "reispan"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15
	)
	tastes = list("面包" = 10)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_TRASH
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/reispan/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/breadslice/reispan, 5, 3 SECONDS, table_required = TRUE)

/obj/item/food/breadslice/reispan
	name = "米面包片"
	desc = "一片米面包，用来做火星风格的三明治。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "reispan_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

// Fried Rice

/obj/item/food/salad/hurricane_rice
	name = "旋风炒饭"
	desc = "灵感来自印尼炒饭，这道够味的米食直接来自火星普罗斯佩克特的夜市。它因独特的烹饪手法得名：翻炒时米饭被高高抛起，主要是因为这样在食客眼里看起来很帅。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "hurricane_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("米" = 1, "肉" = 1, "菠萝" = 1, "蔬菜" = 1)
	foodtypes = MEAT | GRAIN | PINEAPPLE | FRUIT | VEGETABLES | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/bowled/hua_mulan_congee
	name = "\improper 花木兰粥"
	desc = "没人说得清为什么这碗带鸡蛋和培根的笑脸米粥要以一位中国神话人物命名—— \
		它一直就叫这个名字，就是这样。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "hua_mulan_congee"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("培根" = 1, "蛋" = 1)
	foodtypes = MEAT|GRAIN|FRIED|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/ikareis
	name = "伊卡雷斯"
	desc = "一道辣味米食，用鱿鱼墨、彩椒、洋葱、香肠和香味浓郁的辣椒制成。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ikareis"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 4
	)
	tastes = list("米" = 1, "鱿鱼墨" = 1, "蔬菜" = 1, "香肠" = 1, "辣椒辣味" = 1)
	foodtypes = MEAT | GRAIN | SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/hawaiian_fried_rice
	name = "\improper 夏威夷炒饭"
	desc = "夏威夷炒饭并非传统夏威夷菜，而是把各种夏威夷食材拼凑起来——包括切丁的恰普肉，以及颇具争议的菠萝。纯粹主义者对炒饭里该不该放菠萝意见分裂。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "hawaiian_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("米" = 1, "猪肉" = 1, "菠萝" = 1, "酱油" = 1, "蔬菜" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/ketchup_fried_rice
	name = "番茄酱炒饭"
	desc = "经典日式家常菜，用香肠、蔬菜、伍斯特酱、米饭——哦，当然还有番茄酱——做成。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ketchup_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/ketchup = 2,
	)
	tastes = list("米" = 1, "香肠" = 1, "番茄酱" = 1, "蔬菜" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/mediterranean_fried_rice
	name = "地中海炒饭"
	desc = "对炒饭配方的一种奇特演绎：香草、奶酪、橄榄，当然还有肉丸。有点像意式烩饭和炒饭的混血。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "mediterranean_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("米" = 1, "奶酪" = 1, "肉丸" = 1, "橄榄" = 1, "香草" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | DAIRY | FRUIT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/egg_fried_rice
	name = "蛋炒饭"
	desc = "炒饭里最简单的做法：米、蛋、酱油。简单、优雅，且无限可定制。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "egg_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("米" = 1, "蛋" = 1, "酱油" = 1)
	foodtypes = MEAT | GRAIN | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/salad/egg_fried_rice/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/salad/bibimbap
	name = "韩式拌饭"
	desc = "一道韩式料理，米饭配上各种浇头，盛在滚烫的石锅里。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "bibimbap"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("米" = 1, "辣白菜" = 1, "辣椒辣味" = 1, "蛋" = 1, "肉" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/bibimbap/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

// Noodles
/obj/item/food/salad/bulgogi_noodles
	name = "烤肉面"
	desc = "韩式烤肉配面条！用苦椒酱调味，辣味更足。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "bulgogi_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("烤肉" = 1, "面条" = 1, "辣椒辣味" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | FRUIT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/yakisoba_katsu
	name = "炸排炒面"
	desc = "裹面包屑油炸的肉铺在炒面上。美味，虽然不太寻常。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "yakisoba_katsu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("炒面" = 1, "肉" = 1, "面包屑" = 1, "蔬菜" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/martian_fried_noodles
	name = "\improper 火星炒面"
	desc = "来自红色星球的炒面。火星料理融合了许多文化，这些面条也不例外——里面有马来、泰式、中式、韩式和日式料理的元素。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "martian_fried_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("面条" = 1, "肉" = 1, "坚果" = 1, "洋葱" = 1, "蛋" = 1)
	foodtypes = GRAIN | NUTS | MEAT | VEGETABLES | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/simple_fried_noodles
	name = "简单炒面"
	desc = "一道简单却美味的炒面，正适合有创意的厨师随便做成自己想做的炒面。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "simple_fried_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 6,
	)
	tastes = list("面条" = 1, "酱油" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/salad/simple_fried_noodles/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

// Curry
/obj/item/food/salad/setagaya_curry //let me explain...
	name = "\improper 世田谷咖喱"
	desc = "因世田谷一家咖啡馆而闻名，这款咖喱繁复的配方后来成为人类疆域内各咖啡馆老板严守的秘密。据说这味道能滋养食客的灵魂，不管那是什么意思。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "setagaya_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/medicine/omnizine = 5,
	)
	tastes = list("大师级咖喱" = 1, "米" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRUIT|SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5 //Extensive and secretly guarded. Was previously 2 and I thought it was pathetic.
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

// Burgers and Sandwiches
/obj/item/food/burger/big_blue
	name = "\improper 大蓝汉堡"
	desc = "正宗且最棒的大蓝汉堡，直接来自火星最受欢迎的汉堡店。跟上浪潮吧，兄弟！"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "big_blue_burger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("面包胚" = 1, "汉堡" = 2, "照烧洋葱" = 1, "奶酪" = 1, "培根" = 1, "菠萝" = 1)
	foodtypes = MEAT | GRAIN | DAIRY | VEGETABLES | FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //It's THE big blue, Baby!
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/burger/chappy
	name = "\improper 恰皮肉饼"
	desc = "最初诞生于大蓝汉堡厨房里的一夜饮酒，恰皮肉饼后来成了大蓝菜单和全银河夏威夷（至少是仿夏威夷）料理的常客。考虑到大卡胡纳多数门店都在火星运营，这道菜在那里受欢迎也就不奇怪了。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chappy_patty"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("面包胚" = 1, "炸猪肉" = 2, "蛋" = 1, "奶酪" = 1, "番茄酱" = 1)
	foodtypes =  MEAT|GRAIN|DAIRY|FRIED|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/king_katsu_sandwich
	name = "\improper 炸排王三明治"
	desc = "一大个三明治，夹着酥脆的炸排、培根、泡菜沙拉和生菜，全都放在米面包上。真真正正面包夹肉之王。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "king_katsu_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("肉" = 1, "培根" = 1, "泡菜" = 1, "沙拉" = 1, "米面包" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/marte_cubano_sandwich
	name = "\improper 火星古巴诺三明治"
	desc = "来自火星的融合食物，火星古巴诺以经典古巴三明治为基础，但按现有食材和口味变化做了调整。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "marte_cubano_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("培根" = 1, "腌黄瓜" = 1, "奶酪" = 1, "米面包" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/little_shiro_sandwich
	name = "\improper 小希罗三明治"
	desc = "经典火星三明治，以首位出身火星的地球政府总统命名。里面有煎蛋、烤肉牛肉、泡菜沙拉，还铺了厚厚一层马苏里拉奶酪。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "marte_cubano_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("蛋" = 1, "肉" = 1, "泡菜" = 1, "马苏里拉" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY|FRIED|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/croque_martienne
	name = "火星克洛克"
	desc = "火星最典型的早餐三明治。鸡蛋、五花肉、菠萝、奶酪。简单。经典。新大阪每家咖啡馆都有。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "croque_martienne"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("蛋" = 1, "吐司" = 1, "猪肉" = 1, "菠萝" = 1, "奶酪" = 1)
	foodtypes = MEAT|GRAIN|FRUIT|DAIRY|FRIED|PINEAPPLE|BREAKFAST|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/prospect_sunrise
	name = "\improper 普罗斯佩克特日出"
	desc = "火星第二典型的早餐三明治。煎蛋卷、培根、腌黄瓜和奶酪最美丽的组合。普罗斯佩克特每家咖啡馆都有。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "prospect_sunrise"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("蛋" = 1, "吐司" = 1, "培根" = 1, "腌黄瓜" = 1, "奶酪" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | GRAIN | BREAKFAST | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

// Snacks
/obj/item/food/takoyaki
	name = "章鱼烧"
	desc = "经典的日本街头小吃，章鱼烧（或称章鱼丸）用章鱼和洋葱裹在油炸面糊里，淋上咸香酱汁。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "takoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("章鱼" = 1, "面糊" = 1, "洋葱" = 1, "伍斯特酱" = 1)
	foodtypes = SEAFOOD | GRAIN | FRIED | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/takoyaki/russian
	name = "俄式章鱼烧"
	desc = "对经典菜式的危险改编，却是逃避警察追捕的完美掩护。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "russian_takoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("章鱼" = 1, "面糊" = 1, "洋葱" = 1, "辣椒辣味" = 1)
	foodtypes = SEAFOOD | GRAIN | FRIED | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/takoyaki/taco
	name = "塔可烧"
	desc = "直接来自火星最有创意的街头小吃摊，这就是塔可烧——把章鱼换成塔可肉和玉米，把伍斯特酱换成克索奶酪。¡Tan sabroso！"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "tacoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("塔可肉" = 1, "面糊" = 1, "玉米" = 1, "奶酪" = 1)
	foodtypes = MEAT|GRAIN|FRIED|VEGETABLES|DAIRY|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Batter AND Cargo ingredients.
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/okonomiyaki
	name = "大阪烧"
	desc = "关西经典，大阪烧是一种咸味煎饼，里面夹着……好吧，随便你想夹什么——不过卷心菜、长芋和出汁几乎必不可少，同名的御好烧酱也是。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "okonomiyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("面糊" = 1, "卷心菜" = 1, "洋葱" = 1, "伍斯特酱" = 1)
	foodtypes = GRAIN|FRIED|VEGETABLES|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Cargo stuff and batter.

//hey, the name literally means "grilled how you like it", it'd be crazy to not make it customisable
/obj/item/food/okonomiyaki/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/brat_kimchi
	name = "香肠泡菜"
	desc = "炒泡菜拌糖，上面放一根德式小香肠。火星居酒屋里的人气菜。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "brat_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/sugar = 2,
	)
	tastes = list("辣白菜" = 1, "香肠" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/tonkatsuwurst
	name = "炸排香肠"
	desc = "德国与日本料理的文化融合，炸排香肠把咖喱香肠和炸排酱调和成既熟悉又新颖的东西。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "tonkatsuwurst"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/worcestershire = 2,
	)
	tastes = list("香肠" = 1, "辣酱" = 1, "薯条" = 1)
	foodtypes = MEAT|VEGETABLES|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Cargo ingredients and a few steps.
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/kebab/ti_hoeh_koe
	name = "猪血粿串"
	desc = "猪血混米油炸，撒上花生和香菜。这味道……确实需要慢慢培养，但它在普罗斯佩克特的夜市很受欢迎，由台湾移民带来。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ti_hoeh_koe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/peanut_butter = 1,
	)
	tastes = list("血" = 1, "坚果" = 1, "香草" = 1)
	foodtypes = MEAT|FRIED|NUTS|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kitzushi
	name = "狐寿司"
	desc = "稻荷寿司的一种变体，在火星的狐族（以及更广泛的兽人群体）中很受欢迎，狐寿司在豆皮口袋里加入了辣味奶酪和辣椒混合物，风味更足。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kitzushi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("米" = 1, "豆腐" = 1, "辣味奶酪" = 1)
	foodtypes = GRAIN | FRIED | VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/epok_epok
	name = "马来咖喱角"
	desc = "来自马来西亚的油炸糕点小吃，经由新加坡传入火星人的饮食。里面塞满咖喱鸡肉和土豆，还有一片水煮蛋，是红色星球上受欢迎的街头小吃。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "epok_epok"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("咖喱" = 1, "蛋" = 1, "酥皮" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES | FRIED | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/roti_john
	name = "罗提约翰"
	desc = "经典马来西亚小吃，罗提约翰是把面包浸在肉、蛋和洋葱的混合物里煎成，成品介于法式吐司和煎蛋卷之间。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "roti_john"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 10,
	)
	tastes = list("面包" = 1, "蛋" = 1, "肉" = 1, "洋葱" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|BREAKFAST|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/izakaya_fries
	name = "居酒屋薯条"
	desc = "新大阪连续两个世纪最受欢迎的薯条——全靠红湾酱、拌饭料和蛋黄酱的联姻。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "izakaya_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("薯条" = 1, "火星" = 1)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3 //Extra complexity due to cargo ingredient.

/obj/item/food/kurry_ok_subsando
	name = "咖喱潜艇堡"
	desc = "南非兔肉面包遇上火星人的巧思，就成了咖喱潜艇堡，薯条和咖喱炸排完美和谐。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kurry_ok_subsando"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("面包" = 1, "辣薯条" = 1, "蛋黄酱" = 1, "咖喱" = 1, "肉" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/loco_moco
	name = "洛可摩可"
	desc = "来自夏威夷的一道简单经典。管饱、美味又便宜。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "loco_moco"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("米" = 1, "汉堡" = 1, "肉汁" = 1, "蛋" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/wild_duck_fries
	name = "野鸭薯条"
	desc = "薯条配鸭丝、番茄酱、蛋黄酱和红湾酱。火星经典的街头小吃，虽然人们最常把它和快鸭克联系在一起——火星最受欢迎（也是唯一）的鸭子主题快餐连锁。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "wild_duck_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("薯条" = 1, "鸭肉" = 1, "番茄酱" = 1, "蛋黄酱" = 1, "辣味调料" = 1)
	foodtypes = MEAT | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Requires a complex 3 as an ingredient.
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/little_hawaii_hotdog
	name = "\improper 小夏威夷热狗"
	desc = "来自檀香山大道友善的摊贩，小夏威夷热狗——既热带又催肥，一次满足两样！"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "little_hawaii_hotdog"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("香肠" = 1, "菠萝" = 1, "洋葱" = 1, "照烧" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRUIT|PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_price = PAYCHECK_CREW * 1.2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salt_chilli_fries
	name = "盐辣薯条"
	desc = "这道菜朴素的名称并没有讲出它美味的全部故事——盐和辣椒确实是重头，但洋葱、姜和蒜才是真正的风味英雄。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "salt_chilli_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("薯条" = 1, "大蒜" = 1, "姜" = 1, "麻感" = 1, "盐" = 1)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/grilled_octopus
	name = "烤章鱼足"
	desc = "一道简单的海鲜菜，凡是吃章鱼的地方都常见。火星人喜欢配红湾酱吃。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "grilled_octopus"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/char = 2)
	tastes = list("章鱼" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/steak_croquette
	name = "牛排可乐饼"
	desc = "伙计，把牛排块塞进可乐饼里。这肯定是乡下做法。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "steak_croquette"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("牛排" = 1, "土豆" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/chapsilog
	name = "恰普西洛格"
	desc = "传统菲律宾风格的西洛格，由蒜香炒饭、一个煎蛋和几片恰普肉组成。简单却管饱的早餐。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chapsilog"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("火腿" = 1, "蒜香米饭" = 1, "蛋" = 1)
	foodtypes = MEAT|GRAIN|FRIED|BREAKFAST|VEGETABLES|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/chap_hash
	name = "恰普土豆煎"
	desc = "把恰普肉、洋葱、彩椒和土豆混在一起会得到什么？当然是恰普土豆煎！再加点红湾酱，就有一顿美味的早餐了。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chap_hash"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment = 3,
	)
	tastes = list("火腿" = 1, "洋葱" = 1, "彩椒" = 1, "土豆" = 1)
	foodtypes = MEAT | VEGETABLES | BREAKFAST | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/agedashi_tofu
	name = "扬出豆腐"
	desc = "酥炸豆腐，泡在鲜美的出汁里。居酒屋常备。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "agedashi_tofu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("鲜味出汁" = 1, "豆腐" = 1)
	foodtypes = SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

// Curries and Stews
/obj/item/food/salad/po_kok_gai
	name = "葡国鸡"
	desc = "又称 galinha à portuguesa，这道澳门经典源于葡萄牙殖民统治，但本身并非葡萄牙菜。它由鸡肉配“葡国酱”制成，那是一种温和的椰子咖喱。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "po_kok_gai"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("鸡肉" = 1, "椰子" = 1, "咖喱" = 1)
	foodtypes = MEAT|GRAIN|FRUIT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/huoxing_tofu
	name = "\improper 火星豆腐"
	desc = "麻婆豆腐的改编版，在火星的美食圣地普罗斯佩克特声名大噪。要是你眯起眼睛看，它甚至有点像火星。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "huoxing_tofu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/capsaicin = 2
	)
	tastes = list("肉" = 1, "辣椒辣味" = 1, "豆腐" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/feizhou_ji
	name = "非洲鸡"
	desc = "被视为葡式辣酱鸡的澳门变体，非洲鸡（如果你想说通用语）是 TID 的常见菜，后来也因澳门移民涌入而在火星流行。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "feizhou_ji"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("鸡肉" = 1, "辣椒辣味" = 1, "醋" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/galinha_de_cabidela
	name = "鸡血饭"
	desc = "原本是一道葡萄牙菜，鸡血饭在葡萄牙传统上用鸡肉，在澳门则用鸭肉——最终因为欧洲的影响，鸡肉版本在火星胜出。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "galinha_de_cabidela"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 12,
	)
	tastes = list("鸡肉" = 1, "铁味" = 1, "醋" = 1, "米" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/katsu_curry
	name = "炸排咖喱"
	desc = "裹面包屑油炸的肉，淋上咖喱酱，铺在米饭上。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "katsu_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("咖喱" = 1, "肉" = 1, "面包屑" = 1, "米" = 1)
	foodtypes = MEAT|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/beef_bowl
	name = "牛肉饭"
	desc = "炖牛肉、洋葱和出汁的美味组合，盖在米饭上。常见浇头包括腌姜、辣椒粉和煎蛋。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "beef_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("牛肉" = 25, "洋葱" = 25, "辣椒辣味" = 15, "米" = 34, "灵魂" = 1) //I pour my soul into this bowl
	foodtypes = MEAT|VEGETABLES|GRAIN|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/salt_chilli_bowl
	name = "盐辣章鱼盖饭"
	desc = "灵感来自日式丼饭传统，这道辣味天丼变体是一场风靡火星全国的风味盛宴。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "salt_chilli_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("海鲜" = 1, "米" = 1, "大蒜" = 1, "姜" = 1, "麻感" = 1, "盐" = 1)
	foodtypes = VEGETABLES|GRAIN|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //A few Cargo ingredients

/obj/item/food/salad/kansai_bowl
	name = "\improper 关西盖饭"
	desc = "又称木叶丼，这款丼饭是关西地区的典型做法，由蒲鉾鱼板、鸡蛋和洋葱盖在米饭上组成。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kansai_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("海鲜" = 1, "米" = 1, "蛋" = 1, "洋葱" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|SEAFOOD|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/eigamudo_curry //curry is meant to be really spicy or kinda mild, this just stinks!
	name = "\improper 艾加穆多咖喱"
	desc = "一道用杂乱食材做成、令人费解的咖喱。大概在某处某个人觉得好吃——但祝你能找到那个人。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "eigamudo_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutraslop = 8,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/toxin/slimejelly = 4,
	)
	tastes = list("沙砾感" = 1, "黏液" = 1, "软骨" = 1, "米" = 1, "神秘食物 X" = 1)
	foodtypes = VEGETABLES|GRAIN|FRUIT|SEAFOOD|GROSS|TOXIC
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

// Entrees
/obj/item/food/cilbir
	name = "奇尔比尔"
	desc = "鸡蛋铺在咸香酸奶上，淋上辣油。原本是土耳其菜，随德裔土耳其移民来到火星，此后成了早餐常客。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "cilbir"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("酸奶" = 1, "大蒜" = 1, "柠檬" = 1, "蛋" = 1, "辣椒辣味" = 1)
	foodtypes = MEAT|VEGETABLES|DAIRY|FRIED|BREAKFAST|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/peking_duck_crepes
	name = "\improper 北京烤鸭香橙可丽饼"
	desc = "这道菜取北京与巴黎料理之长，做成一餐酸甜咸香的佳肴。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "peking_duck_crepes"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/orangejuice = 4,
	)
	tastes = list("肉" = 1, "可丽饼" = 1, "橙" = 1)
	foodtypes = MEAT|GRAIN|FRUIT|SUGAR|ORANGES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

// Desserts
/obj/item/food/cake/spekkoek
	name = "普通千层糕"
	desc = "千层糕由荷兰和印尼移民带到火星，是红色星球上常见的节日蛋糕，常作为传统印尼饭桌的一部分。在深空中用普通仙草调味是出于无奈，因为离地球这么远，香兰叶很难得。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "spekkoek"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/nutriment/vitamin = 15
	)
	tastes = list("冬日香料" = 2, "普通仙草" = 2, "蛋糕" = 5)
	foodtypes = VEGETABLES|GRAIN|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/spekkoek/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/cakeslice/spekkoek, 5, 3 SECONDS, table_required = TRUE)

/obj/item/food/cakeslice/spekkoek
	name = "普通千层糕片"
	desc = "一片普通千层糕。如果你是火星人，这大概会让你想起家乡。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "spekkoek_slice"
	tastes = list("冬日香料" = 2, "普通仙草" = 2, "蛋糕" = 5)
	foodtypes = VEGETABLES|GRAIN|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/pineapple_foster
	name = "菠萝福斯特"
	desc = "经典甜点的火星改良版，菠萝福斯特是一款热乎乎的甜蜜点心，只带来轻度到中度的火灾风险。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pineapple_foster"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 4,
		/datum/reagent/consumable/pineapplejuice = 2,
		/datum/reagent/consumable/milk = 4
	)
	tastes = list("菠萝" = 1, "香草" = 1, "焦糖" = 1, "冰淇淋" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR|PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pastel_de_nata
	name = "葡式蛋挞"
	desc = "葡式蛋挞最初由葡萄牙修士创制，随葡萄牙殖民帝国传遍世界——包括澳门，再从那里随来自香港和澳门 TID 的移民来到火星。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pastel_de_nata"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("卡仕达" = 1, "香草" = 1, "甜酥皮" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/boh_loh_yah
	name = "菠萝包"
	desc = "这道香港点心被令人困惑地称作“菠萝包”，实际并不含菠萝——它是外皮像曲奇、内里夹黄油的甜面包。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "boh_loh_yah"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("曲奇" = 1, "黄油" = 1)
	foodtypes = DAIRY | GRAIN | PINEAPPLE //it's funny
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/banana_fritter
	name = "炸香蕉"
	desc = "东南亚海洋地区随处可见的甜点小吃，炸香蕉有很多名字，但做法都相似——香蕉裹面糊油炸。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "banana_fritter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("香蕉" = 1, "面糊" = 1)
	foodtypes = GRAIN|FRUIT|FRIED|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3 //Fried goodness, oil scawy.

/obj/item/food/pineapple_fritter
	name = "炸菠萝"
	desc = "和它的表亲炸香蕉一样，炸菠萝也是很受欢迎的小吃，只是被菠萝那著名的“要么爱要么恨”的风味拖了后腿。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pineapple_fritter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("菠萝" = 1, "面糊" = 1)
	foodtypes = GRAIN|FRUIT|FRIED|PINEAPPLE|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kebab/kasei_dango
	name = "火星团子"
	desc = "日式团子，用石榴糖浆和橙子调味，成品看起来像火星、吃起来像甜点，一串三颗。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kasei_dango"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/orangejuice = 3,
		/datum/reagent/consumable/grenadine = 3
	)
	tastes = list("石榴" = 1, "橙" = 1)
	foodtypes = FRUIT | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

// Frozen
/obj/item/food/pb_ice_cream_mochi
	name = "花生酱冰淇淋麻糬"
	desc = "普罗斯佩克特阿拉伯街夜市的经典甜点，花生酱冰淇淋麻糬以花生酱味冰淇淋为主要馅料，并按台湾传统裹上碎花生。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pb_ice_cream_mochi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/peanut_butter = 4,
		/datum/reagent/consumable/milk = 2,
	)
	tastes = list("花生酱" = 1, "麻糬" = 1)
	foodtypes = NUTS | GRAIN | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/popsicle/pineapple_pop
	name = "冰菠萝棒"
	desc = "很少有文化像火星人那样热爱菠萝，这款甜点就是证明——冻菠萝串在棍上，再蘸一点黑巧克力。"
	overlay_state = "pineapple_pop"
	food_reagents = list(
		/datum/reagent/consumable/pineapplejuice = 4,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("冰菠萝" = 1, "巧克力" = 1)
	foodtypes = SUGAR|FRUIT|PINEAPPLE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/popsicle/sea_salt
	name = "海盐冰淇淋棒"
	desc = "这根天蓝色的冰淇淋棒只用最上等的进口海盐调味。咸的……不，是甜的！"
	overlay_state = "sea_salt_pop"
	food_reagents = list(
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("盐" = 1, "甜味" = 1)
	foodtypes = SUGAR | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

// topsicles, also known as tofu popsicles
/obj/item/food/popsicle/topsicle
	name = "浆果豆腐冰棒"
	desc = "用豆腐和浆果汁搅匀冻成的冰品。据说是熊的最爱，但这说不通……"
	overlay_state = "topsicle_berry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/berryjuice = 4
	)
	tastes = list("浆果" = 1, "豆腐" = 1)
	foodtypes = FRUIT|SUGAR|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/popsicle/topsicle/banana
	name = "香蕉豆腐冰棒"
	desc = "用豆腐和香蕉汁搅匀冻成的冰品。日本乡村夏天很受欢迎。"
	overlay_state = "topsicle_banana"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/banana = 4
	)
	tastes = list("香蕉" = 1, "豆腐" = 1)

/obj/item/food/popsicle/topsicle/pineapple
	name = "菠萝豆腐冰棒"
	desc = "用豆腐和菠萝汁搅匀冻成的冰品。电视上见过的那种。"
	overlay_state = "topsicle_pineapple"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/pineapplejuice = 4
	)
	foodtypes = FRUIT|SUGAR|VEGETABLES|PINEAPPLE
	tastes = list("菠萝" = 1, "豆腐" = 1)

// Ballpark Food
/obj/item/food/plasma_dog_supreme
	name = "\improper 等离子热狗至尊"
	desc = "赛博太阳公园的招牌小吃，新大阪啄木鸟队的主场：球场热狗配参巴酱、出汁烤洋葱和菠萝青柠莎莎酱。你知道的，就是火星人爱吃的那种大胆风味。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "plasma_dog_supreme"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 6
	)
	tastes = list("香肠" = 1, "酸菜酱" = 1, "洋葱" = 1, "果味莎莎酱" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRUIT|PINEAPPLE|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Uses Sambal
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)
	custom_price = PAYCHECK_CREW * 2

/obj/item/food/frickles
	name = "炸酸黄瓜"
	desc = "香辣炸酸黄瓜条？这么大胆的组合肯定只可能来自一个地方——火星球场？好吧，其实也不是，但这在那里确实很受欢迎。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "frickles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("炸酸黄瓜" = 1)
	foodtypes = VEGETABLES|GRAIN|FRIED|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3 //batter and cargo stuff.

/obj/item/food/raw_ballpark_pretzel
	name = "生椒盐卷饼"
	desc = "一个扭结的面团，等着进烤箱，或者该上煎锅？"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_ballpark_pretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("面包" = 1, "盐" = 1)
	foodtypes = GRAIN | RAW
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_ballpark_pretzel/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/ballpark_pretzel, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/raw_ballpark_pretzel/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/ballpark_pretzel, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/ballpark_pretzel
	name = "球场椒盐卷饼"
	desc = "一款经典的德国面包，被美国帝国主义之手改造成比赛日小吃，又随着日本移民的脚步被带到红色星球。真是多元文化。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ballpark_pretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("面包" = 1, "盐" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kebab/raw_ballpark_tsukune
	name = "生鸡肉丸"
	desc = "串在签子上的生鸡肉丸，等着下锅煎成美味。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_ballpark_tsukune"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment = 2,
	)
	tastes = list("生鸡肉" = 7, "沙门氏菌" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/kebab/raw_ballpark_tsukune/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/kebab/ballpark_tsukune, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/kebab/ballpark_tsukune
	name = "球场鸡肉丸"
	desc = "串在签子上的鸡肉丸，裹着甜咸的照烧酱。火星球场的常见景象。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ballpark_tsukune"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("鸡肉" = 1, "鲜味酱" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

// Ethereal-suitable cross-culture food
/*	Ethereals are, as part of the uplifting process, considered as citizens of the Terran Federation.
	For this reason, a lot of ethereals have chosen to move throughout human space, settling on various planets to a mixed reception.
	Mars is no exception to this rule, where the ethereal population has been more welcomed than most, due to Mars' more cosmopolitan past.
	Here, the ethereals have developed a distinct culture, neither that of their homeland nor that of Mars, and with that a distinct cuisine.
*/

// Pickled Voltvine
/obj/item/food/pickled_voltvine
	name = "腌电藤"
	desc = "来自芽星的传统菜（当地称为 hinu'sashuruhk），腌电藤在火星的腌菜大师手中获得了新身份，与腌姜和泡菜一同跻身神圣腌菜万神殿（至少要先适当放电）。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pickled_voltvine"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("酸萝卜" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2 //If it comes straight from cargo, should be worth paying for.

// 24-Volt Energy
/obj/item/food/volt_fish
	name = "24 伏特鱼"
	desc = "有人可能会质疑 24 伏特鱼。毕竟，用宝蓝色的超酸能量饮料炖出来的鱼看起来很糟。而且确实味道也很糟。那火星的以太人为什么喜欢它呢？" //beats the hell out of me
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "volt_fish"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("鱼" = 1, "酸梨" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

// Sprout Bowl
/obj/item/food/salad/sprout_bowl
	name = "\improper 芽星盖饭"
	desc = "以太人家乡星球命名的这款米食盖饭取法丼饭传统，却拒绝典型的丼饭浇头，改用刺身级鱼生和腌电藤。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "sprout_bowl"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity = 8,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("鱼" = 1, "酸萝卜" = 1, "米" = 1)
	foodtypes = SEAFOOD | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
