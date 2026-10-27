/obj/machinery/vending/toyliberationstation
	name = "\improper 辛迪加咚克软玩具售货机"
	desc = "一台获准面向 8 岁及以上人群销售玩具的售货机。要是你能找对线，就能解锁成人模式！"
	icon_state = "syndi"
	panel_type = "panel18"
	product_slogans = "今天就来买你最爱的酷玩具！;今天就去挑衅一名合法猎人！;廉价优质的玩具武器！;送给人事主管，换取全区域通行权！;送给安保主管，换取永久监禁区！"
	product_ads = "用玩具感受强劲！;今天就来释放你内心的童真！;玩具武器不杀人，但合法猎人会！;有了玩具武器，谁还需要责任心？;让你的下一次谋杀变得有趣！"
	vend_reply = "欢迎再来！"
	products = list(
		/obj/item/card/emagfake = 4,
		/obj/item/hot_potato/harmless/toy = 4,
		/obj/item/toy/sword = 12,
		/obj/item/dualsaber/toy = 12,
		/obj/item/toy/foamblade = 12,
		/obj/item/gun/ballistic/automatic/pistol/toy/riot = 8,
		/obj/item/gun/ballistic/automatic/toy/riot = 8,
		/obj/item/gun/ballistic/shotgun/toy/riot = 8,
		/obj/item/ammo_box/foambox = 20,
	)
	contraband = list(
		/obj/item/toy/balloon/syndicate = 1,
		/obj/item/gun/ballistic/shotgun/toy/crossbow/riot = 8,
		/obj/item/storage/belt/sheath/katana/toy = 12,
	)
	premium = list(
		/obj/item/toy/cards/deck/syndicate = 12,
		/obj/item/storage/box/fakesyndiesuit = 4,
		/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot = 4,
		/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted/riot = 4,
		/obj/item/ammo_box/foambox/riot = 20,
	)
	armor_type = /datum/armor/vending_toyliberationstation
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/donksoft
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES
	light_mask = "donksoft-light-mask"
	allow_custom = FALSE

/datum/armor/vending_toyliberationstation
	melee = 100
	bullet = 100
	laser = 100
	energy = 100
	fire = 100
	acid = 50
