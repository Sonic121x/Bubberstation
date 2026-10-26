/obj/machinery/vending/security
	name = "\improper 安保科技"
	desc = "安保装备售货机。"
	product_ads = "敲碎共产主义的脑袋！;狠狠揍他们一顿！;别忘了——伤害是好事！;你的武器就在这里。;手铐！;不许动，人渣！;兄弟，别电我！;兄弟，电他们。;来点甜甜圈如何？"
	icon_state = "sec"
	icon_deny = "sec-deny"
	panel_type = "panel6"
	light_mask = "sec-light-mask"
	products = list(
		/obj/item/restraints/handcuffs = 8,
		/obj/item/restraints/handcuffs/cable/zipties = 10,
		/obj/item/grenade/flashbang = 4,
		/obj/item/assembly/flash/handheld = 5,
		/obj/item/food/donut/plain = 12,
		/obj/item/storage/box/evidence = 6,
		/obj/item/flashlight/seclite = 4,
		/obj/item/restraints/legcuffs/bola/energy = 7,
		/obj/item/clothing/gloves/tackler = 5,
		/obj/item/holosign_creator/security = 2,
		/obj/item/gun_maintenance_supplies = 2,
	)
	contraband = list(
		/obj/item/clothing/glasses/sunglasses = 2,
		/obj/item/storage/fancy/donut_box = 2,
	)
	premium = list(
		/obj/item/storage/belt/security/webbing = 5,
		/obj/item/coin/antagtoken = 1,
		/obj/item/clothing/head/helmet/blueshirt = 1,
		/obj/item/clothing/gloves/color/black/security/blu = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt = 1,
		/obj/item/grenade/stingbang = 1,
		/obj/item/watertank/pepperspray = 2,
		/obj/item/storage/belt/holster/energy = 4,
	)
	refill_canister = /obj/item/vending_refill/security
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND * 1.5
	payment_department = ACCOUNT_SEC

/obj/machinery/vending/security/pre_throw(obj/item/thrown_item)
	if(isgrenade(thrown_item))
		var/obj/item/grenade/thrown_grenade = thrown_item
		thrown_grenade.arm_grenade()
	else if(istype(thrown_item, /obj/item/flashlight))
		var/obj/item/flashlight/thrown_flashlight = thrown_item
		thrown_flashlight.set_light_on(TRUE)
		thrown_flashlight.update_brightness()

/obj/item/vending_refill/security
	machine_name = "安保科技"
	icon_state = "refill_sec"
