/obj/machinery/vending/vendcation
	name = "度假售货机"
	desc = "一台售货机，专为此刻真心不想上班的你准备。"
	icon = 'modular_zubbers/icons/maps/biodome/vending.dmi'
	icon_state = "vacation"
	icon_deny = "vacation-deny"
	panel_type = "panel15"
	product_slogans = "随时都是海岛时光！;把脚翘起来吧！;感受阳光！;别忘了防晒霜！"
	vend_reply = "放轻松！"
	products = list(
		/obj/item/clothing/under/shorts/red = 2,
		/obj/item/clothing/under/shorts/green = 2,
		/obj/item/clothing/under/shorts/blue = 2,
		/obj/item/clothing/under/shorts/black = 2,
		/obj/item/clothing/under/shorts/purple = 2,
		/obj/item/clothing/under/dress/sundress = 2,
		/obj/item/clothing/under/dress/tango = 2,
		/obj/item/clothing/suit/costume/hawaiian = 4,
		/obj/item/clothing/glasses/sunglasses/cheap = 4,
		/obj/item/clothing/shoes/sandal = 4,
		/obj/item/clothing/head/costume/scarecrow_hat = 2,
		/obj/item/toy/beach_ball/branded = 4,
	)
	refill_canister = /obj/item/vending_refill/vacation
	default_price = PAYCHECK_CREW * 0.7
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES
//	light_mask = "wardrobe-light-mask"
	light_color = LIGHT_COLOR_ELECTRIC_CYAN

/obj/item/vending_refill/vacation
	machine_name = "度假售货机"
	icon_state = "refill_clothes"
