/obj/item/storage/box/foodpack
	name = "包装餐盒"
	desc = "一个普通的棕色纸食品包装，你不太确定它来自哪里。"
	icon = 'modular_skyrat/modules/imported_vendors/icons/imported_quick_foods.dmi'
	icon_state = "foodpack_generic_big"
	illustration = null
	custom_price = PAYCHECK_CREW * 1.8
	///What the main course of this package is
	var/main_course = /obj/item/trash/empty_food_tray
	///What the side of this package should be
	var/side_item = /obj/item/food/vendor_snacks
	///What kind of condiment pack should we give the package
	var/condiment_pack = /obj/item/reagent_containers/condiment/pack/ketchup

/obj/item/storage/box/foodpack/PopulateContents()
	. = ..()
	new main_course(src)
	new side_item(src)
	new condiment_pack(src)

/obj/item/storage/box/foodpack/nt
	name = "\improper NT 组合餐 - 索尔兹伯里肉饼"
	desc = "一个由反光金属箔制成的、相当寡淡的包装，印有蓝色图案，顶部印着“NT”字样。"
	icon_state = "foodpack_nt_big"
	main_course = /obj/item/food/vendor_tray_meal
	side_item = /obj/effect/spawner/random/vendor_meal_sides/nt
	condiment_pack = /obj/item/reagent_containers/condiment/pack/ketchup

/obj/item/storage/box/foodpack/nt/burger
	name = "\improper NT 组合餐 - 芝士汉堡"
	main_course = /obj/item/food/vendor_tray_meal/burger

/obj/item/storage/box/foodpack/nt/chicken_sammy
	name = "\improper NT 组合餐 - 香辣鸡肉三明治"
	main_course = /obj/item/food/vendor_tray_meal/chicken_sandwich

/obj/item/storage/box/foodpack/yangyu
	name = "\improper Atatakai shokuji - 家常面"
	desc = "一个装饰精美的红白塑料包装，上面印满了几乎无法理解的火星洋语文字。"
	icon_state = "foodpack_yangyu_big"
	main_course = /obj/item/food/vendor_tray_meal/ramen
	side_item = /obj/effect/spawner/random/vendor_meal_sides/yangyu
	condiment_pack = /obj/item/reagent_containers/condiment/pack/hotsauce

/obj/item/storage/box/foodpack/yangyu/sushi
	name = "\improper Atatakai shokuji - 鲤鱼寿司卷"
	main_course = /obj/item/food/vendor_tray_meal/sushi

/obj/item/storage/box/foodpack/yangyu/beef_rice
	name = "\improper Atatakai shokuji - 牛肉盖饭"
	main_course = /obj/item/food/vendor_tray_meal/beef_rice

/obj/item/storage/box/foodpack/moth
	name = "\improper M 型口粮 - 青酱披萨"
	desc = "一个纸板色的纸质包装，上面盖着游牧舰队的标志。"
	icon_state = "foodpack_moth_big"
	main_course = /obj/item/food/vendor_tray_meal/pesto_pizza
	side_item = /obj/effect/spawner/random/vendor_meal_sides/moth
	condiment_pack = /obj/item/reagent_containers/condiment/pack/astrotame

/obj/item/storage/box/foodpack/moth/baked_rice
	name = "\improper M 型口粮 - 焗饭配烤芝士"
	main_course = /obj/item/food/vendor_tray_meal/baked_rice

/obj/item/storage/box/foodpack/moth/fuel_jack
	name = "\improper M 型口粮 - 燃料工的盛宴"
	main_course = /obj/item/food/vendor_tray_meal/fueljack

/obj/item/storage/box/foodpack/tizira
	name = "\improper 提兹拉进口包 - 月鱼尼扎亚面"
	desc = "一个暗淡的金属箔包装，上面条状印着提兹拉国旗的配色，还盖有提兹拉出口办公室的合法来源印章。"
	icon_state = "foodpack_tizira_big"
	main_course = /obj/item/food/vendor_tray_meal/moonfish_nizaya
	side_item = /obj/effect/spawner/random/vendor_meal_sides/tizira
	condiment_pack = /obj/item/reagent_containers/condiment/pack/bbqsauce
	custom_price = PAYCHECK_CREW * 2 //Tiziran imports are a bit more expensive

/obj/item/storage/box/foodpack/tizira/examine_more(mob/user)
	. = ..()
	. += span_notice("<b>现在仔细一看，这个来源印章似乎是对真品的拙劣仿冒！</b>")
	return .

/obj/item/storage/box/foodpack/tizira/roll
	name = "\improper 提兹拉进口包 - 皇帝卷"
	main_course = /obj/item/food/vendor_tray_meal/emperor_roll

/obj/item/storage/box/foodpack/tizira/stir_fry
	name = "\improper 提兹拉进口包 - 炒蘑菇"
	main_course = /obj/item/food/vendor_tray_meal/mushroom_fry
