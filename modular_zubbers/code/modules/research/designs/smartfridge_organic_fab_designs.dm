// Designs for the SmartFridge Organic Fabricator
// A gigantic variety of food and drink items, more expensive than a biogen (twice as, usually), and all artificial. Yummy slop!

// Ingredients

/datum/design/biogen/smartfridge_fabricator_milk
	name = "合成牛奶"
	id = "smartfridge_fabricator_milk"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/milk
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_soymilk
	name = "合成豆奶"
	id = "smartfridge_fabricator_soymilk"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/soymilk
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_kortamilk
	name = "合成科塔奶"
	id = "smartfridge_fabricator_kortamilk"
	materials = list(/datum/material/biomass = 2.4)
	make_reagent = /datum/reagent/consumable/korta_milk
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_ethanol
	name = "合成乙醇"
	id = "smartfridge_fabricator_ethanol"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/ethanol
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_cream
	name = "合成奶油"
	id = "smartfridge_fabricator_cream"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/cream
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_enzyme
	name = "合成酶"
	id = "smartfridge_fabricator_enzyme"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/enzyme
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_flour
	name = "合成面粉"
	id = "smartfridge_fabricator_flour"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/flour
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_kflour
	name = "合成科塔面粉"
	id = "smartfridge_fabricator_kflour"
	materials = list(/datum/material/biomass = 2.4)
	make_reagent = /datum/reagent/consumable/korta_flour
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_cornstarch
	name = "合成玉米淀粉"
	id = "smartfridge_fabricator_cornstarch"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/corn_starch
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_rice
	name = "合成大米"
	id = "smartfridge_fabricator_rice"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/rice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_sugar
	name = "合成糖"
	id = "smartfridge_fabricator_sugar"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/sugar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_cookingoil
	name = "合成食用油"
	id = "smartfridge_fabricator_cooking_oil"
	materials = list(/datum/material/biomass = 2)
	make_reagent = /datum/reagent/consumable/nutriment/fat/oil
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_oliveoil
	name = "合成橄榄油"
	id = "smartfridge_fabricator_olive_oil"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/nutriment/fat/oil/olive
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_vinegar
	name = "合成醋"
	id = "smartfridge_fabricator_vinegar"
	materials = list(/datum/material/biomass = 2)
	make_reagent = /datum/reagent/consumable/vinegar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_egg
	name = "蛋"
	id = "smartfridge_fabricator_egg"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/egg
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_chicken
	name = "合成鸡肉"
	id = "smartfridge_fabricator_chicken"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/chicken
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_meatslab
	name = "合成肉"
	id = "smartfridge_fabricator_meatslab"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/meatproduct
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_patty
	name = "合成肉饼"
	id = "smartfridge_fabricator_patty"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/raw_patty
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_bacon
	name = "合成培根"
	id = "smartfridge_fabricator_bacon"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/meat/rawbacon
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_sausage
	name = "合成香肠"
	id = "smartfridge_fabricator_sausage"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/raw_sausage
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_fillet
	name = "合成鱼片"
	id = "smartfridge_fabricator_fillet"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/fishmeat
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_butter
	name = "一条黄油"
	id = "smartfridge_fabricator_butter"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/butter
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_cheese
	name = "奶酪楔"
	id = "smartfridge_fabricator_cheese"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/cheese/wedge
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_cheese_firm
	name = "硬质奶酪片"
	id = "smartfridge_fabricator_firm_cheese"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/cheese/firm_cheese_slice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_seaweed_sheet
	name = "海苔片"
	id = "smartfridge_fabricator_seaweedsheet"
	materials = list(/datum/material/biomass = 6)
	build_path = /obj/item/food/seaweedsheet
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

// Condiments

/datum/design/biogen/smartfridge_fabricator_black_pepper
	name = "合成黑胡椒"
	id = "smartfridge_fabricator_black_pepper"
	materials = list(/datum/material/biomass = 0.8)
	make_reagent = /datum/reagent/consumable/blackpepper
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_salt
	name = "合成盐"
	id = "smartfridge_fabricator_salt"
	materials = list(/datum/material/biomass = 0.4)
	make_reagent = /datum/reagent/consumable/salt
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_honey
	name = "合成蜂蜜"
	id = "smartfridge_fabricator_honey"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/honey
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_soysauce
	name = "合成酱油"
	id = "smartfridge_fabricator_soysauce"
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/consumable/soysauce
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_teriyaki
	name = "合成照烧酱"
	id = "smartfridge_fabricator_teriyaki"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/nutriment/soup/teriyaki
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_ketchup
	name = "合成番茄酱"
	id = "smartfridge_fabricator_ketchup"
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/consumable/ketchup
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_mayonnaise
	name = "合成蛋黄酱"
	id = "smartfridge_fabricator_mayonnaise"
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/consumable/mayonnaise
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_bbqsauce
	name = "合成烧烤酱"
	id = "smartfridge_fabricator_bbqsauce"
	materials = list(/datum/material/biomass = 2)
	make_reagent = /datum/reagent/consumable/bbqsauce
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_hotsauce
	name = "合成辣酱"
	id = "smartfridge_fabricator_hotsauce"
	materials = list(/datum/material/biomass = 2)
	make_reagent = /datum/reagent/consumable/capsaicin
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_coldsauce
	name = "合成冷酱"
	id = "smartfridge_fabricator_coldsauce"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/frostoil
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

// Food/Drinks

/datum/design/biogen/smartfridge_fabricator_bun
	name = "小圆面包"
	id = "smartfridge_fabricator_bun"
	materials = list(/datum/material/biomass = 30)
	build_path = /obj/item/food/bun
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_rroll
	name = "根面包卷"
	id = "smartfridge_fabricator_rroll"
	materials = list(/datum/material/biomass = 60)
	build_path = /obj/item/food/rootroll
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_donut
	name = "甜甜圈"
	id = "smartfridge_fabricator_donut"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/donut/plain
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_jellydonut
	name = "果冻甜甜圈"
	id = "smartfridge_fabricator_jellydonut"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/donut/jelly/plain
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_cannedtomatoes
	name = "罐装圣马扎诺番茄"
	id = "smartfridge_fabricator_cannedtomatoes"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/tomatoes
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_cannedbeans
	name = "一罐豆子"
	id = "smartfridge_fabricator_cannedbeans"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/beans
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_cannedpeaches
	name = "罐装桃子"
	id = "smartfridge_fabricator_cannedpeaches"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/peaches
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_cannedtuna
	name = "金枪鱼罐头"
	id = "smartfridge_fabricator_cannedtuna"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/tuna
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_chap
	name = "一罐 CHAP"
	id = "smartfridge_fabricator_chap"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/food/canned/chap
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_cornuto
	name = "科尔努托"
	id = "smartfridge_fabricator_cornuto"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/cornuto
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_icecreamsandwich
	name = "冰淇淋三明治"
	id = "smartfridge_fabricator_icecreamsandwich"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/icecreamsandwich
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_yoghurt
	name = "酸奶"
	id = "smartfridge_fabricator_yoghurt"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/yoghurt
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_berryblast
	name = "浆果爆裂冰沙"
	id = "smartfridge_fabricator_berryblast"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/berry_blast
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_strawberrybanana
	name = "草莓香蕉冰沙"
	id = "smartfridge_fabricator_strawberrybanana"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/strawberry_banana
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_vanilladream
	name = "香草之梦冰沙"
	id = "smartfridge_fabricator_vanilladream"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/vanilla_dream
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_funkymonkey
	name = "怪趣猴子冰沙"
	id = "smartfridge_fabricator_funkymonkey"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/funky_monkey
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

// Luxuries

/datum/design/biogen/smartfridge_fabricator_gum
	name = "泡泡糖袋"
	id = "smartfridge_fabricator_gum"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage/box/gum
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_gum_wakeup
	name = "活力 12 小时药用口香糖袋"
	id = "smartfridge_fabricator_gum_wakeup"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage/box/gum/wake_up
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_energy_bar
	name = "高功率能量棒"
	id = "smartfridge_fabricator_energy_bar"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/energybar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_ciggies
	name = "提神柔顺香烟包"
	id = "smartfridge_fabricator_ciggies"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/storage/fancy/cigarettes/cigpack_uplift
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_engine_fodder
	name = "引擎饲料"
	id = "smartfridge_fabricator_engine_fodder"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/vendor_snacks/moth_bag
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_fueljak_snack
	name = "燃料工的零食"
	id = "smartfridge_fabricator_fueljak_snack"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/vendor_snacks/moth_bag/fuel_jack
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_ricecracker
	name = "米饼"
	id = "smartfridge_fabricator_ricecracker"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/vendor_snacks/rice_crackers
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_candy
	name = "糖果"
	id = "smartfridge_fabricator_candy"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/candy
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_stickorandom
	name = "Sticko 饼干"
	id = "smartfridge_fabricator_stickorandom"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/sticko/random
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_chocolatebar
	name = "巧克力棒"
	id = "smartfridge_fabricator_chocolatebar"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/chocolatebar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_chips
	name = "薯片"
	id = "smartfridge_fabricator_chips"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/chips
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_shrimpchips
	name = "虾片"
	id = "smartfridge_fabricator_shrimpchips"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/chips/shrimp
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_cornchipsrandom
	name = "Boritos 玉米片"
	id = "smartfridge_fabricator_cornchipsrandom"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/cornchips/random
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)
