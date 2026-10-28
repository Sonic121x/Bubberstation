/obj/effect/spawner/random/vending/snackvend
	loot = list(
		/obj/machinery/vending/imported,
		/obj/machinery/vending/imported/yangyu,
		/obj/machinery/vending/imported/mothic,
		/obj/machinery/vending/imported/tiziran,
	)

/obj/effect/spawner/random/vending/colavend //These can serve both snacks AND drinks so its kinda both of them?
	loot = list(
		/obj/machinery/vending/imported,
		/obj/machinery/vending/imported/yangyu,
		/obj/machinery/vending/imported/mothic,
		/obj/machinery/vending/imported/tiziran,
	)

/datum/supply_pack/vending/imported/fill(obj/structure/closet/crate/target_crate)
	. = ..()
	for(var/obj/vendor_refill as anything in typesof(/obj/item/vending_refill/snack/imported))
		new vendor_refill(target_crate)

/obj/machinery/vending/imported
	name = "\improper 纳米传讯营养补给机"
	desc = "一台只供应最优质人类大学生食品的自动售货机。"
	icon = 'modular_skyrat/modules/imported_vendors/icons/imported_vendors.dmi'
	icon_state = "nt_food"
	panel_type = "panel15"
	light_mask = "nt_food-light-mask"
	light_color = LIGHT_COLOR_LIGHT_CYAN
	product_slogans = "注意，内装商品可能正在热卖！;快看看这些低廉的价格！;饿了？我也是——等等，不，你什么都没听见！"
	product_categories = list(
		list(
			"name" = "零食",
			"icon" = "cookie",
			"products" = list(
				/obj/item/food/peanuts/random = 6,
				/obj/item/food/cnds/random = 6,
				/obj/item/food/pistachios = 6,
				/obj/item/food/cornchips/random = 6,
				/obj/item/food/sosjerky = 6,
				/obj/item/reagent_containers/cup/soda_cans/cola = 6,
				/obj/item/reagent_containers/cup/soda_cans/lemon_lime = 6,
				/obj/item/reagent_containers/cup/soda_cans/starkist = 6,
				/obj/item/reagent_containers/cup/soda_cans/pwr_game = 6,
			),
		),
		list(
			"name" = "正餐",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/nt = 6,
				/obj/item/storage/box/foodpack/nt/burger = 6,
				/obj/item/storage/box/foodpack/nt/chicken_sammy = 6,
				/obj/item/food/vendor_tray_meal/side = 6,
				/obj/item/food/vendor_tray_meal/side/crackers_and_jam = 6,
				/obj/item/food/vendor_tray_meal/side/crackers_and_cheese = 6,
			),
		),
	)

	refill_canister = /obj/item/vending_refill/snack/imported
	default_price = PAYCHECK_CREW * 0.5
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES
	allow_custom = TRUE

/obj/item/vending_refill/snack/imported
	machine_name = "纳米传讯营养补给机"

/obj/machinery/vending/imported/yangyu
	name = "\improper 福多便当"
	desc = "一台售卖太阳系东部传统食品的售货机，质量存疑。"
	icon_state = "yangyu_food"
	light_mask = "yangyu_food-light-mask"
	light_color = LIGHT_COLOR_FLARE
	product_slogans = "来自本地太空的养殖太空鲤鱼，新鲜直达！;提供仿龙虾怪寿司可供选择！;以传统配方用心制作！"
	product_categories = list(
		list(
			"name" = "零食",
			"icon" = "cookie",
			"products" = list(
				/obj/item/reagent_containers/cup/glass/dry_ramen/prepared = 6,
				/obj/item/reagent_containers/cup/glass/dry_ramen/prepared/hell = 6,
				/obj/item/food/vendor_snacks/rice_crackers = 6,
				/obj/item/food/vendor_snacks/mochi_ice_cream = 6,
				/obj/item/food/vendor_snacks/mochi_ice_cream/matcha = 6,
				/obj/item/reagent_containers/cup/glass/waterbottle/tea = 6,
				/obj/item/reagent_containers/cup/glass/waterbottle/tea/astra = 6,
				/obj/item/reagent_containers/cup/glass/waterbottle/tea/strawberry = 6,
				/obj/item/reagent_containers/cup/glass/waterbottle/tea/nip = 6,
			),
		),
		list(
			"name" = "正餐",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/yangyu = 6,
				/obj/item/storage/box/foodpack/yangyu/sushi = 6,
				/obj/item/storage/box/foodpack/yangyu/beef_rice = 6,
				/obj/item/food/vendor_tray_meal/side/miso = 6,
				/obj/item/food/vendor_tray_meal/side/rice = 6,
				/obj/item/food/vendor_tray_meal/side/pickled_vegetables = 6,
			),
		),
	)

	refill_canister = /obj/item/vending_refill/snack/imported/yangyu
	initial_language_holder = /datum/language_holder/yangyu_vendor

/datum/language_holder/yangyu_vendor
	understood_languages = list(
		/datum/language/yangyu = list(LANGUAGE_ATOM),
		)
	spoken_languages = list(
		/datum/language/yangyu = list(LANGUAGE_ATOM),
		)

/obj/machinery/vending/imported/yangyu/examine_more(mob/user)
	. = ..()
	. += span_notice("似乎有人在售货机侧面用记号笔写了<i>“别信那寿司！”</i>。")
	return .

/obj/item/vending_refill/snack/imported/yangyu
	machine_name = "福多便当"

/obj/machinery/vending/imported/mothic
	name = "\improper 游牧舰队口粮券兑换机"
	desc = "游牧舰队自有的口粮售货机之一；尽管机身刻着这个名字，它已被改装为接受信用点支付。"
	icon_state = "moth_food"
	light_mask = "moth_food-light-mask"
	light_color = LIGHT_COLOR_HALOGEN
	product_slogans = "支持舰队，从今日节约口粮开始！;部分商品已减量降价！;尽你的一份力，让舰队继续航行！"
	product_categories = list(
		list(
			"name" = "零食",
			"icon" = "cookie",
			"products" = list(
				/obj/item/food/vendor_snacks/mothmallow = 6,
				/obj/item/food/vendor_snacks/moth_bag = 6,
				/obj/item/food/vendor_snacks/moth_bag/fuel_jack = 6,
				/obj/item/food/vendor_snacks/moth_bag/cheesecake = 6,
				/obj/item/food/vendor_snacks/moth_bag/cheesecake/honey = 6,
				/obj/item/reagent_containers/cup/soda_cans/bubber/lemonade = 6,
				/obj/item/reagent_containers/cup/soda_cans/bubber/navy_rum = 6,
				/obj/item/reagent_containers/cup/soda_cans/bubber/soda_water_moth = 6,
				/obj/item/reagent_containers/cup/soda_cans/bubber/ginger_beer = 6,
			),
		),
		list(
			"name" = "正餐",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/moth = 6,
				/obj/item/storage/box/foodpack/moth/baked_rice = 6,
				/obj/item/storage/box/foodpack/moth/fuel_jack = 6,
				/obj/item/food/vendor_tray_meal/side/moffin = 6,
				/obj/item/food/vendor_tray_meal/side/cornbread = 6,
				/obj/item/food/vendor_tray_meal/side/roasted_seeds = 6,
				/obj/item/reagent_containers/condiment/moth_milk = 6,
			),
		),
	)

	refill_canister = /obj/item/vending_refill/snack/imported/mothic
	initial_language_holder = /datum/language_holder/moffic_vendor

/datum/language_holder/moffic_vendor
	understood_languages = list(
		/datum/language/moffic = list(LANGUAGE_ATOM),
		)
	spoken_languages = list(
		/datum/language/moffic = list(LANGUAGE_ATOM),
		)

/obj/item/vending_refill/snack/imported/mothic
	machine_name = "游牧舰队口粮券兑换机"

/obj/machinery/vending/imported/tiziran
	name = "\improper 提兹拉进口美食"
	desc = "一台自动售货机，供应一系列很可能全是提兹拉热门品牌仿冒品的精美商品。"
	icon_state = "tizira_food"
	light_mask = "tizira_food-light-mask"
	light_color = LIGHT_COLOR_FIRE
	product_slogans = "我们保证，是首都直运的正品进口货！;稀有的海水渔获精选！;所有肉类套餐均附赠月鱼酱汁！"
	product_categories = list(
		list(
			"name" = "零食",
			"icon" = "cookie",
			"products" = list(
				/obj/item/food/chips/shrimp = 6,
				/obj/item/food/vendor_snacks/lizard_bag = 6,
				/obj/item/food/vendor_snacks/lizard_bag/moon_jerky = 6,
				/obj/item/food/vendor_snacks/lizard_box = 6,
				/obj/item/food/vendor_snacks/lizard_box/sweet_roll = 6,
				/obj/item/reagent_containers/cup/glass/bottle/mushi_kombucha = 6,
				/obj/item/reagent_containers/cup/glass/waterbottle/tea/mushroom = 6,
				/obj/item/reagent_containers/cup/soda_cans/bubber/kortara = 6,
			),
		),
		list(
			"name" = "正餐",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/tizira = 6,
				/obj/item/storage/box/foodpack/tizira/roll = 6,
				/obj/item/storage/box/foodpack/tizira/stir_fry = 6,
				/obj/item/food/vendor_tray_meal/side/root_crackers = 6,
				/obj/item/food/vendor_tray_meal/side/korta_brittle = 6,
				/obj/item/food/vendor_tray_meal/side/crispy_headcheese = 6,
			),
		),
	)

	refill_canister = /obj/item/vending_refill/snack/imported/tiziran
	initial_language_holder = /datum/language_holder/draconic_vendor

/datum/language_holder/draconic_vendor
	understood_languages = list(
		/datum/language/draconic = list(LANGUAGE_ATOM),
		)
	spoken_languages = list(
		/datum/language/draconic = list(LANGUAGE_ATOM),
		)

/obj/item/vending_refill/snack/imported/tiziran
	machine_name = "提兹拉进口美食"
