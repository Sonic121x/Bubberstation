/obj/machinery/vending/donksnack
	name = "\improper 咚克公司售货机"
	desc = "由咚克公司提供的零食售货机。"
	product_slogans = "微波炉一转就能吃！;咚克口袋饼的原创老家！"
	product_ads = "正宗原版！;来给它加个带劲的咚克吧！;最好的！;老练叛徒的首选食物！;全能嗪含量提升 12%！;不吃咚克就得死！;银河系最受欢迎的微波零食！*;试试我们全新的咚克即食餐！"
	icon_state = "snackdonk"
	panel_type = "panel18"
	light_mask = "donksoft-light-mask"
	products = list(
		/obj/item/food/donkpocket = 6,
		/obj/item/food/donkpocket/berry = 6,
		/obj/item/food/donkpocket/honk = 6,
		/obj/item/food/donkpocket/pizza = 6,
		/obj/item/food/donkpocket/spicy = 6,
		/obj/item/food/donkpocket/teriyaki = 6,
		/obj/item/food/tatortot = 12,
	)
	contraband = list(
		/obj/item/food/waffles = 2,
		/obj/item/food/donkpocket/dank = 2,
		/obj/item/food/donkpocket/gondola = 1,
	)
	premium = list(
		/obj/item/storage/box/donkpockets = 3,
		/obj/item/storage/box/donkpockets/donkpocketberry = 3,
		/obj/item/storage/box/donkpockets/donkpockethonk = 3,
		/obj/item/storage/box/donkpockets/donkpocketpizza = 3,
		/obj/item/storage/box/donkpockets/donkpocketspicy = 3,
		/obj/item/storage/box/donkpockets/donkpocketteriyaki = 3,
		/obj/item/storage/belt/military/snack = 2,
		/obj/item/mod/module/microwave_beam = 1,
	)
	initial_language_holder = /datum/language_holder/syndicate
	refill_canister = /obj/item/vending_refill/donksnackvendor
	default_price = PAYCHECK_CREW * 1.4
	extra_price = PAYCHECK_CREW * 5
	payment_department = NO_FREEBIES

/obj/item/vending_refill/donksnackvendor
	machine_name = "咚克公司零食售货机"
	icon_state = "refill_donksnack"
