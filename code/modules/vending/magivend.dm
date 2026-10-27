/obj/machinery/vending/magivend
	name = "\improper 魔法售货机"
	desc = "一台魔法售货机。"
	icon_state = "MagiVend"
	panel_type = "panel10"
	product_slogans = "用魔法售货机，以正确的方式施法！;做你自己的霍迪尼！就用魔法售货机！"
	vend_reply = "祝你度过一个迷人的夜晚！"
	product_ads = "FJKLFJSD;AJKFLBJAKL;1234 一群疯子 哈哈！;>MFW;杀了那些混蛋！;拿到那该死的磁盘;洪克！;EI NATH;摧毁空间站！;自古以来就有管理员阴谋！;扭曲时空的硬件！"
	products = list(
		/obj/item/clothing/head/wizard = 1,
		/obj/item/clothing/suit/wizrobe = 1,
		/obj/item/clothing/head/wizard/red = 1,
		/obj/item/clothing/suit/wizrobe/red = 1,
		/obj/item/clothing/head/wizard/yellow = 1,
		/obj/item/clothing/suit/wizrobe/yellow = 1,
		/obj/item/clothing/head/wizard/black = 1,
		/obj/item/clothing/suit/wizrobe/black = 1,
		/obj/item/clothing/shoes/sandal/magic = 1,
		/obj/item/staff = 2,
	)
	contraband = list(/obj/item/reagent_containers/cup/bottle/wizarditis = 1) //No one can get to the machine to hack it anyways; for the lulz - Microwave
	armor_type = /datum/armor/vending_magivend
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/magivend
	default_price = 0 //Just in case, since its primary use is storage.
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_SRV
	light_mask = "magivend-light-mask"

/datum/armor/vending_magivend
	melee = 100
	bullet = 100
	laser = 100
	energy = 100
	fire = 100
	acid = 50

/obj/item/vending_refill/magivend
	machine_name = "魔法售货机"
	icon_state = "refill_magivend"
