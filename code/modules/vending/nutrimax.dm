/obj/machinery/vending/hydronutrients
	name = "\improper 营养至尊"
	desc = "植物营养剂售货机。"
	product_slogans = "不必再用天然方式施肥了，你是不是很高兴？;臭味减少 50%！;植物也是人啊！"
	product_ads = "我们喜欢植物！;你不来一点吗？;史上最绿的拇指。;我们喜欢大块头的植物。;松软的土壤……"
	icon_state = "nutri"
	icon_deny = "nutri-deny"
	panel_type = "panel2"
	light_mask = "nutri-light-mask"
	products = list(
		/obj/item/cultivator = 3,
		/obj/item/plant_analyzer = 4,
		/obj/item/reagent_containers/cup/jerrycan/eznutriment = 6,
		/obj/item/reagent_containers/cup/jerrycan/left4zed = 4,
		/obj/item/reagent_containers/cup/jerrycan/robustharvest = 3,
		/obj/item/reagent_containers/spray/pestspray = 20,
		/obj/item/reagent_containers/syringe = 5,
		/obj/item/secateurs = 3,
		/obj/item/shovel/spade = 3,
		/obj/item/storage/bag/plants = 5,
	)

	premium = list(
		/obj/item/soil_sack = 8,
		/obj/item/soil_sack/vermaculite = 3,
		/obj/item/soil_sack/gel = 3,
	)

	contraband = list(
		/obj/item/reagent_containers/cup/bottle/ammonia = 10,
		/obj/item/reagent_containers/cup/bottle/diethylamine = 5,
		/obj/item/reagent_containers/cup/bottle/saltpetre = 5,
	)
	refill_canister = /obj/item/vending_refill/hydronutrients
	default_price = PAYCHECK_CREW * 0.8
	extra_price = PAYCHECK_COMMAND * 0.8
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/hydronutrients
	machine_name = "营养至尊"
	icon_state = "refill_plant"
