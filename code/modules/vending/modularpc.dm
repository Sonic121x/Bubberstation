/obj/machinery/vending/modularpc
	name = "\improper 豪华硅晶精选"
	desc = "组装你自己的定制电脑所需的全部零件。"
	icon_state = "modularpc"
	icon_deny = "modularpc-deny"
	panel_type = "panel21"
	light_mask = "modular-light-mask"
	product_ads = "来拿你的玩家装备！;满足你一切太空挖矿需求的最佳显卡！;最强悍的散热！;太空中最精美的 RGB 灯效！"
	vend_reply = "尽情开玩吧！"
	products = list(
		/obj/item/disk/computer = 8,
		/obj/item/modular_computer/laptop = 4,
		/obj/item/modular_computer/pda = 4,
	)
	premium = list(
		/obj/item/pai_card = 2,
	)
	refill_canister = /obj/item/vending_refill/modularpc
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_SCI

/obj/item/vending_refill/modularpc
	machine_name = "豪华硅晶精选"
	icon_state = "refill_engi"
