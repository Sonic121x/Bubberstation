/obj/machinery/vending/sovietsoda
	name = "\improper BODA"
	desc = "一台老式的甜味汽水售货机。"
	icon_state = "sovietsoda"
	panel_type = "panel8"
	light_mask = "soviet-light-mask"
	product_ads = "为了沙皇与祖国。;你今天完成营养配额了吗？;非常好！;我们是很朴素的人，我们就吃这些。;有人就有问题。没有人就没有问题。"
	products = list(
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/soda = 30,
	)
	contraband = list(
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/cola = 20,
	)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/sovietsoda
	default_price = 1
	extra_price = PAYCHECK_CREW //One credit for every state of FREEDOM
	payment_department = NO_FREEBIES
	light_color = COLOR_PALE_ORANGE
	initial_language_holder = /datum/language_holder/panslavic //bubber edit; spinwarder to panslavic

/obj/item/vending_refill/sovietsoda
	machine_name = "BODA"
	icon_state = "refill_cola"
