/obj/machinery/vending/barbervend
	name = "靓丽售货机"
	desc = "看来它出售染料，以及其他能让你变美的东西。"
	icon = 'modular_skyrat/modules/salon/icons/vendor.dmi'
	icon_state = "barbervend"
	product_slogans = "像给吐司抹黄油一样涂上颜色……涂在头发上。; 有时，我会梦见染料……; 给他们上色，叫我画家先生。; 听着，兄弟，我是一台售货机，我解决实际问题。"
	product_ads = "统统剪掉！; 剪个精光！; 烦恼丝退散！; 变得漂亮！; 变得美丽！"
	vend_reply = "欢迎再来！; 再买一件吧！; 你不喜欢自己的新造型吗？"
	req_access = list(ACCESS_BARBER)
	refill_canister = /obj/item/vending_refill/barbervend
	products = list(
		/obj/item/reagent_containers/spray/quantum_hair_dye = 3,
		/obj/item/reagent_containers/spray/baldium = 3,
		/obj/item/reagent_containers/spray/barbers_aid = 3,
		/obj/item/clothing/head/hair_tie = 3,
		/obj/item/dyespray = 5,
		/obj/item/hairbrush = 3,
		/obj/item/hairbrush/comb = 3,
		/obj/item/fur_dyer = 1,
	)
	premium = list(
		/obj/item/scissors = 3,
		/obj/item/reagent_containers/spray/super_barbers_aid = 3,
		/obj/item/storage/box/lipsticks = 3,
		/obj/item/lipstick/quantum = 1,
		/obj/item/razor = 1,
	)
	refill_canister = /obj/item/vending_refill/barbervend
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_SRV
	allow_custom = TRUE

/obj/item/vending_refill/barbervend
	machine_name = "理发售货机补给罐"
	icon_state = "refill_snack" //generic item refill because there isnt one sprited yet.
