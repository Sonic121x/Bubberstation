///A special hotdog vending machine found in the cafeteria at the museum away mission, or during the hotdog holiday.
/obj/machinery/vending/hotdog
	name = "\improper 热狗售卖机"
	desc = "一台过时的热狗售货机，价格还停留在二十多年前的水平。"
	icon_state = "hotdog-vendor"
	icon_deny = "hotdog-vendor-deny"
	panel_type = "panel17"
	product_slogans = "肉感空前！;味精含量提升 20%！;热狗！;现在适合提兹拉人食用！"
	product_ads = "你最好也是唯一的自动热狗机！;自 2469 年起为你奉上最上等的面包！;共有 12 种不同口味！"
	vend_reply = "祝你用餐愉快！"
	light_mask = "hotdog-vendor-light-mask"
	default_price = PAYCHECK_LOWER
	product_categories = list(
		list(
			"name" = "热狗",
			"icon" = "hotdog",
			"products" = list(
				/obj/item/food/hotdog = 8,
				/obj/item/food/pigblanket = 4,
				/obj/item/food/danish_hotdog = 4,
				/obj/item/food/little_hawaii_hotdog = 4,
				/obj/item/food/butterdog = 4,
				/obj/item/food/plasma_dog_supreme = 2,
			),
		),
		list(
			name = "香肠",
			"icon" = FA_ICON_BACON,
			"products" = list(
				/obj/item/food/sausage = 8,
				/obj/item/food/tiziran_sausage = 4,
				/obj/item/food/fried_blood_sausage = 4,
			),
		),
		list(
			"name" = "酱料",
			"icon" = FA_ICON_BOWL_FOOD,
			"products" = list(
				/obj/item/reagent_containers/condiment/pack/ketchup = 4,
				/obj/item/reagent_containers/condiment/pack/hotsauce = 4,
				/obj/item/reagent_containers/condiment/pack/bbqsauce = 4,
				/obj/item/reagent_containers/condiment/pack/soysauce = 4,
				/obj/item/reagent_containers/condiment/pack/mayonnaise = 4,
			),
		),
	)
	refill_canister = /obj/item/vending_refill/hotdog

/obj/item/vending_refill/hotdog
	machine_name = "\improper 热狗售卖机"
	icon_state = "refill_snack"

/// Cute little thing that sets it apart from the other food vending mahicnes. I mean, you don't find this every day.
/obj/machinery/vending/hotdog/on_dispense(obj/item/vended_item, dispense_returned = FALSE)
	// Only apply to newly dispensed items
	if(dispense_returned)
		return
	if(istype(vended_item, /obj/item/food))
		ADD_TRAIT(vended_item, TRAIT_HANDMADE, VENDING_MACHINE_TRAIT)
