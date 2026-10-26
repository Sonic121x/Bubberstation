/obj/machinery/vending/dinnerware
	name = "\improper 塑钢主厨餐具售货机"
	desc = "厨房与餐厅设备售货机。"
	product_ads = "嗯，食物材料！;食物以及食物配件。;来拿你的盘子！;你喜欢叉子吗？;我喜欢叉子。;哇，餐具。;你其实并不需要这些……"
	icon_state = "dinnerware"
	panel_type = "panel4"
	product_categories = list(
		list(
			"name" = "厨房用具",
			"icon" = FA_ICON_KITCHEN_SET,
			"products" = list(
				/obj/item/storage/bag/tray = 8,
				/obj/item/reagent_containers/cup/soup_pot = 3,
				/obj/item/kitchen/spoon/soup_ladle = 3,
				/obj/item/clothing/suit/apron/chef = 2,
				/obj/item/kitchen/rollingpin = 2,
				/obj/item/kitchen/tongs = 2,
				/obj/item/knife/kitchen = 2,
			),
		),
		list(
			"name" = "进餐用具",
			"icon" = FA_ICON_UTENSILS,
			"products" = list(
				/obj/item/kitchen/fork = 6,
				/obj/item/kitchen/spoon = 10,
			),
		),
		list(
			"name" = "餐具",
			"icon" = FA_ICON_PLATE_WHEAT,
			"products" = list(
				/obj/item/plate/small = 5,
				/obj/item/plate = 10,
				/obj/item/plate/large = 5,
				/obj/item/reagent_containers/cup/bowl = 30,
				/obj/item/reagent_containers/cup/glass/drinkingglass = 8,
			),
		),
		list(
			"name" = "调味品",
			"icon" = FA_ICON_BOTTLE_DROPLET,
			"products" = list(
				/obj/item/reagent_containers/condiment/pack/ketchup = 5,
				/obj/item/reagent_containers/condiment/pack/hotsauce = 5,
				/obj/item/reagent_containers/condiment/pack/astrotame = 5,
				/obj/item/reagent_containers/condiment/saltshaker = 5,
				/obj/item/reagent_containers/condiment/peppermill = 5,
			),
		),
		list(
			"name" = "食谱",
			"icon" = FA_ICON_BOOK_OPEN_READER,
			"products" = list(
				/obj/item/book/granter/crafting_recipe/cooking_sweets_101 = 2,
			),
		),
	)

	premium = list(
		/obj/item/skillchip/chefs_kiss = 2
	)
	contraband = list(
		/obj/item/kitchen/rollingpin/illegal = 2,
		/obj/item/knife/butcher = 2,
	)
	refill_canister = /obj/item/vending_refill/dinnerware
	default_price = PAYCHECK_CREW * 0.8
	extra_price = PAYCHECK_CREW * 2.4
	payment_department = ACCOUNT_SRV
	light_mask = "dinnerware-light-mask"

/obj/item/vending_refill/dinnerware
	machine_name = "塑钢主厨餐具售货机"
	icon_state = "refill_smoke"
