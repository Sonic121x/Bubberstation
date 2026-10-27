/obj/machinery/vending/boozeomat
	name = "\improper 酒水自动售货机"
	desc = "一项技术奇迹，据说能在你开口的瞬间为你调出你想喝的那一杯。"
	icon_state = "boozeomat"
	icon_deny = "boozeomat-deny"
	panel_type = "panel22"

	product_categories = list(
		list(
			"name" = "含酒精",
			"icon" = "wine-bottle",
			"products" = list(
				/obj/item/reagent_containers/cup/glass/bottle/curacao = 5,
				/obj/item/reagent_containers/cup/glass/bottle/coconut_rum = 5,
				/obj/item/reagent_containers/cup/glass/bottle/applejack = 5,
				/obj/item/reagent_containers/cup/glass/bottle/tequila = 5,
				/obj/item/reagent_containers/cup/glass/bottle/aperitivo = 5,
				/obj/item/reagent_containers/cup/glass/bottle/rum = 5,
				/obj/item/reagent_containers/cup/glass/bottle/cognac = 5,
				/obj/item/reagent_containers/cup/glass/bottle/maraschino = 5,
				/obj/item/reagent_containers/cup/glass/bottle/wine = 5,
				/obj/item/reagent_containers/cup/glass/bottle/absinthe = 5,
				/obj/item/reagent_containers/cup/glass/bottle/vermouth = 5,
				/obj/item/reagent_containers/cup/glass/bottle/gin = 5,
				/obj/item/reagent_containers/cup/glass/bottle/hcider = 5,
				/obj/item/reagent_containers/cup/glass/bottle/amaretto = 5,
				/obj/item/reagent_containers/cup/glass/bottle/ale = 6,
				/obj/item/reagent_containers/cup/glass/bottle/yuyake = 5,
				/obj/item/reagent_containers/cup/glass/bottle/grappa = 5,
				/obj/item/reagent_containers/cup/glass/bottle/navy_rum = 5,
				/obj/item/reagent_containers/cup/glass/bottle/maltliquor = 6,
				/obj/item/reagent_containers/cup/glass/bottle/kahlua = 5,
				/obj/item/reagent_containers/cup/glass/bottle/sake = 5,
				/obj/item/reagent_containers/cup/glass/bottle/shochu = 5,
				/obj/item/reagent_containers/cup/glass/bottle/beer = 6,
				/obj/item/reagent_containers/cup/glass/bottle/vodka = 5,
				/obj/item/reagent_containers/cup/glass/bottle/whiskey = 5,
				/obj/item/reagent_containers/cup/glass/bottle/wine_voltaic = 5,
				/obj/item/reagent_containers/cup/soda_cans/beer = 10,
				/obj/item/reagent_containers/cup/soda_cans/beer/rice = 10,
			),
		),

		list(
			"name" = "无酒精",
			"icon" = "bottle-water",
			"products" = list(
				/obj/item/reagent_containers/cup/glass/ice = 10,
				/obj/item/reagent_containers/cup/glass/waterbottle = 8,
				/obj/item/reagent_containers/cup/glass/waterbottle/large = 4,
				/obj/item/reagent_containers/cup/glass/bottle/juice/lemonjuice = 4,
				/obj/item/reagent_containers/cup/glass/bottle/juice/limejuice = 4,
				/obj/item/reagent_containers/cup/glass/bottle/juice/orangejuice = 4,
				/obj/item/reagent_containers/cup/glass/bottle/juice/cream = 4,
				/obj/item/reagent_containers/cup/glass/bottle/juice/tomatojuice = 4,
				/obj/item/reagent_containers/cup/glass/bottle/grenadine = 4,
				/obj/item/reagent_containers/cup/glass/bottle/juice/menthol = 4,
				/obj/item/reagent_containers/cup/glass/bottle/hakka_mate = 5,
				/obj/item/reagent_containers/cup/soda_cans/sodawater = 15,
				/obj/item/reagent_containers/cup/soda_cans/sol_dry = 8,
				/obj/item/reagent_containers/cup/soda_cans/cola = 8,
				/obj/item/reagent_containers/cup/soda_cans/tonic = 8,
				/obj/item/reagent_containers/cup/soda_cans/melon_soda = 5,
			),
		),

		list(
			"name" = "玻璃器皿",
			"icon" = "wine-glass",
			"products" = list(
				/obj/item/reagent_containers/cup/glass/drinkingglass = 30,
				/obj/item/reagent_containers/cup/glass/drinkingglass/shotglass = 12,
				/obj/item/reagent_containers/cup/glass/flask = 3,
				/obj/item/reagent_containers/cup/glass/bottle = 15,
				/obj/item/reagent_containers/cup/glass/bottle/small = 15,
			),
		),
	)

	contraband = list(
		/obj/item/reagent_containers/cup/glass/bottle/herbal_liqueur = 2,
		/obj/item/reagent_containers/cup/glass/mug/tea = 12,
		/obj/item/reagent_containers/cup/glass/bottle/fernet = 5,
	)
	premium = list(
		/obj/item/reagent_containers/cup/glass/bottle/bitters = 5,
		/obj/item/reagent_containers/cup/glass/bottle/herbal_liqueur = 2,
		/obj/item/reagent_containers/cup/bottle/ethanol = 4,
		/obj/item/reagent_containers/cup/glass/bottle/champagne = 5,
		/obj/item/reagent_containers/cup/glass/bottle/trappist = 5,
	)

	product_slogans = "希望没人来问我要那该死的茶……;酒精是人类的朋友。你会抛弃朋友吗？;很高兴为您服务！;这站上就没人渴吗？"
	product_ads = "喝光它！;酒对你有好处！;酒精是人类最好的朋友。;很高兴为您服务！;来杯冰爽的啤酒如何？;没什么比酒更治愈！;抿一口！;来一杯！;来瓶啤酒！;啤酒对你有好处！;只有最上等的酒！;自 2053 年以来品质最好的酒！;获奖葡萄酒！;酒精拉满！;男人爱啤酒。;为进步干杯！"
	refill_canister = /obj/item/vending_refill/boozeomat
	default_price = PAYCHECK_CREW * 0.9
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_SRV
	light_mask = "boozeomat-light-mask"

/obj/machinery/vending/boozeomat/syndicate
	age_restrictions = FALSE
	initial_language_holder = /datum/language_holder/syndicate
	allow_custom = FALSE

/obj/item/vending_refill/boozeomat
	machine_name = "酒水自动售货机"
	icon_state = "refill_booze"
