/obj/machinery/vending/halloween_chocolate
	name = "\improper 强韧巧克力"
	desc = "一台由罗巴斯特实业有限责任公司提供的巧克力售货机。内容物一旦被食用，保修立即失效。"
	icon = 'modular_zubbers/icons/obj/machines/halloween_chocolate_vendor.dmi'
	icon_state = "halloween"
	panel_type = "panel"
	product_slogans = "强韧巧克力：比砸在头上的工具箱还强韧！"
	product_ads = "美味！;希望你正饿着！;已售出超过 4 块巧克力！;饿了？为什么不来块巧克力？;请用点零食吧！;吃吧！;太空里最好的巧克力。"
	products = list(
		/obj/item/food/candy/coconut_joy = 8,
		/obj/item/food/candy/laughter_bar = 8,
		/obj/item/food/candy/kit_catgirl_metaclique_bar = 8,
		/obj/item/food/candy/twink_bar = 8,
		/obj/item/food/candy/elon_musk_bar = 8,
		/obj/item/food/candy/malf_way = 8
	)
	contraband = list(
		/obj/item/food/candy/hurr_bar = 2,
		/obj/item/food/candy/laughter_bar/slaughter = 2
	)
	premium = list(
		/obj/item/food/candy/hundred_credit_bar = 2,
		/obj/item/food/candy/triggerfinger = 2
	)
	refill_canister = /obj/item/vending_refill/halloween_chocolate
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_SRV
	light_mask = "halloween-light-mask"
	light_color = COLOR_LIGHT_ORANGE

/obj/item/vending_refill/halloween_chocolate
	machine_name = "强韧巧克力"
	icon_state = "refill_games"

/datum/supply_pack/vending/halloween_chocolate
	name = "强韧巧克力补给箱"
	desc = "被工具箱砸过，可那口烦人的牙还在？ \
		今天就拿一箱糖果机补充装，把那几颗白牙彻底解决掉！"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/vending_refill/halloween_chocolate)
	crate_name = "强韧巧克力补给箱"
