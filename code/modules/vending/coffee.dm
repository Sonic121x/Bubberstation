/obj/machinery/vending/coffee
	name = "\improper 太阳之选热饮"
	desc = "一台供应热饮的售货机。"
	product_ads = "来一杯吧！;喝光它！;对你有好处！;想来杯热咖啡吗？;为了咖啡我什么都肯干！;银河系最好的咖啡豆。;只为你奉上最上等的冲泡。;嗯～什么也比不上一杯咖啡。;我喜欢咖啡，你呢？;咖啡让你更有效率！;尝尝茶吧。;希望你喜欢最好的！;试试我们的新巧克力！;管理员阴谋"
	icon_state = "coffee"
	icon_vend = "coffee-vend"
	panel_type = "panel9"
	products = list(
		/obj/item/reagent_containers/cup/glass/coffee = 6,
		/obj/item/reagent_containers/cup/glass/mug/tea = 6,
		/obj/item/reagent_containers/cup/glass/mug/coco = 3,
	)
	contraband = list(
		/obj/item/reagent_containers/cup/glass/ice = 12,
	)
	refill_canister = /obj/item/vending_refill/coffee
	default_price = PAYCHECK_LOWER
	extra_price = PAYCHECK_CREW
	payment_department = ACCOUNT_SRV
	light_mask = "coffee-light-mask"
	light_color = COLOR_DARK_MODERATE_ORANGE

/obj/item/vending_refill/coffee
	machine_name = "太阳之选热饮"
	icon_state = "refill_joe"
