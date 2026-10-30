/obj/machinery/vending/donksofttoyvendor
	name = "\improper 咚克软玩具售货机"
	desc = "获准面向 8 岁及以上人群销售玩具的售货机。"
	icon_state = "nt-donk"
	panel_type = "panel18"
	product_slogans = "今天就来买你最爱的酷玩具！;今天就去挑衅一名合法猎人！;廉价优质的玩具武器！;送给人事主管，换取全区域通行权！;送给安保主管，换取永久监禁区！"
	product_ads = "用玩具感受强劲！;今天就来释放你内心的童真！;玩具武器不杀人，但合法猎人会！;有了玩具武器，谁还需要责任心？;让你的下一次谋杀变得有趣！"
	vend_reply = "欢迎再来！"
	light_mask = "donksoft-light-mask"
	product_categories = list(
		list(
			"name" = "玩具",
			"icon" = "gifts",
			"products" = list(
				/obj/item/card/emagfake = 4,
				/obj/item/hot_potato/harmless/toy = 4,
				/obj/item/toy/sword = 12,
				/obj/item/toy/foamblade = 12,
				/obj/item/gun/ballistic/automatic/pistol/toy = 8,
				/obj/item/gun/ballistic/automatic/toy = 8,
				/obj/item/gun/ballistic/shotgun/toy = 8,
				/obj/item/ammo_box/foambox/mini = 20,
			)
		),
		list(
			"name" = "枕头武器",
			"icon" = "bed",
			"products" = list(
				/obj/item/shield/mattress = 10,
				/obj/item/spear/pillow = 10,
				/obj/item/spear/pillow = 10,
				/obj/item/pillow/clown = 10,
				/obj/item/pillow/mime = 10,
			)

		)
	)

	contraband = list(
		/obj/item/toy/balloon/syndicate = 1,
		/obj/item/gun/ballistic/shotgun/toy/crossbow = 8,
		/obj/item/storage/belt/sheath/katana/toy = 12,
		/obj/item/ammo_box/foambox/riot/mini = 20,
	)
	premium = list(
		/obj/item/dualsaber/toy = 4,
		/obj/item/storage/box/fakesyndiesuit = 4,
		/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted = 4,
		/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted = 4,
	)
	refill_canister = /obj/item/vending_refill/donksoft
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES

/obj/item/vending_refill/donksoft
	machine_name = "咚克软玩具售货机"
	icon_state = "refill_donksoft"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5)
