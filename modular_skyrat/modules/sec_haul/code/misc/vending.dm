/obj/machinery/vending/security
	name = "\improper 阿玛达因维和装备售货机"
	desc = "阿玛达因制造的维和装备售货机。"
	product_ads = "敲开资本家的脑壳！;给他们迎头痛击！;别忘了——伤害是好事！;你的武器就在这里。;手铐！;不许动，混蛋！;兄弟，别电我！;兄弟，电他们。;何不来个甜甜圈？"
	icon = 'modular_skyrat/modules/sec_haul/icons/vending/vending.dmi'
	products = list(
		/obj/item/restraints/handcuffs = 18,
		/obj/item/restraints/handcuffs/cable/zipties = 22,
		/obj/item/grenade/flashbang = 16,
		/obj/item/assembly/flash/handheld = 18,
		/obj/item/food/donut/plain = 12,
		/obj/item/storage/box/evidence = 16,
		/obj/item/flashlight/seclite = 16,
		/obj/item/restraints/legcuffs/bola/energy = 20,
		/obj/item/clothing/gloves/tackler/security = 5,
		/obj/item/ammo_box/advanced/s12gauge/bean = 2,
	)
	contraband = list(
		/obj/item/clothing/glasses/sunglasses = 2,
		/obj/item/storage/fancy/donut_box = 2,
	)
	premium = list(
		/obj/item/storage/belt/security/webbing = 5,
		/obj/item/coin/antagtoken = 1,
		/obj/item/clothing/head/helmet/blueshirt = 3,
		/obj/item/clothing/suit/armor/vest/blueshirt = 3,
		/obj/item/grenade/stingbang = 5,
		/obj/item/watertank/pepperspray = 2,
		/obj/item/storage/belt/holster/energy = 4,
		/obj/item/storage/box/holobadge = 1,
		/obj/item/ammo_box/magazine/security = 12,
		/obj/item/ammo_box/magazine/pepperball = 12,
		/obj/item/ammo_box/advanced/s12gauge/frangible = 2,
	)

/obj/item/vending_refill/security
	machine_name = "阿玛达因维和装备售货机"


/obj/machinery/vending/wardrobe/sec_wardrobe
	name = "\improper 维和装备站"
	desc = "供应洛普兰“维和者”安保套装的售货机，内有标准制服和通用装备。"
	icon = 'modular_skyrat/modules/sec_haul/icons/vending/vending.dmi'
	light_mask = "sec-light-mask"
	icon_state = "peace"
	product_ads = "时髦地痛揍罪犯！;污渍一洗就掉！;你有权追求时尚！;现在，你终于可以成为梦寐以求的时尚警察了！"
	vend_reply = "祝你好运，维和员！"
	products = list(/obj/item/clothing/suit/hooded/wintercoat/security = 5,
					/obj/item/clothing/suit/toggle/jacket/sec = 5,
					/obj/item/clothing/neck/security_cape = 5,
					/obj/item/clothing/neck/security_cape/armplate = 5,
					/obj/item/storage/backpack/security = 5,
					/obj/item/storage/backpack/satchel/sec = 5,
					/obj/item/storage/backpack/duffelbag/sec = 5,
					/obj/item/storage/backpack/duffelbag/sec = 5,
					/obj/item/clothing/under/rank/security/officer = 10,
					/obj/item/clothing/under/rank/security/officer/skirt = 10,
					/obj/item/clothing/under/rank/security/peacekeeper/skirt = 10,
					/obj/item/clothing/under/rank/security/peacekeeper/miniskirt = 10,
					/obj/item/clothing/under/rank/security/peacekeeper/jumpsuit = 10,
					/obj/item/clothing/under/rank/security/skyrat/utility = 3,
					/obj/item/clothing/shoes/jackboots/sec = 10,
					/obj/item/clothing/head/beret/sec = 5,
					/obj/item/clothing/head/costume/ushanka/sec = 10,
					/obj/item/clothing/gloves/color/black/security = 10,
					/obj/item/clothing/head/helmet/sec/futuristic = 5,
					)
	premium = list( /obj/item/clothing/under/rank/security/officer/formal = 3,
					/obj/item/clothing/suit/jacket/officer/blue = 3,
					/obj/item/clothing/head/beret/sec/navyofficer = 3)
	payment_department = ACCOUNT_SEC
	light_color = COLOR_MODERATE_BLUE

/obj/item/vending_refill/wardrobe/sec_wardrobe
	machine_name = "维和装备站"

//List for the old one, for when its mapped in; curates it nicely, adds /redsec to the items, and also prevents some conflicts with the above vendor
/obj/machinery/vending/wardrobe/sec_wardrobe/red
	name = "\improper 安保衣橱"
	desc = "出售安保及相关服装的售货机！"
	product_ads = "时髦地痛揍罪犯！;红色让血迹无处可寻！;你有权追求时尚！;现在，你终于可以成为梦寐以求的时尚警察了！"
	vend_reply = "感谢使用安保衣橱！"
	icon = 'icons/obj/machines/vending.dmi'
	icon_state = "secdrobe"
	products = list(/obj/item/clothing/suit/hooded/wintercoat/security/redsec = 3,
					/obj/item/storage/backpack/security = 3,
					/obj/item/storage/backpack/satchel/sec = 3,
					/obj/item/storage/backpack/duffelbag/sec = 3,
					/obj/item/storage/backpack/messenger/sec = 3,
					/obj/item/clothing/under/rank/security/officer/redsec = 3,
					/obj/item/clothing/shoes/jackboots = 3,
					/obj/item/clothing/head/beret/sec = 3,
					/obj/item/clothing/head/soft/sec = 3,
					/obj/item/clothing/mask/bandana/red = 3,
					/obj/item/clothing/gloves/color/black = 3,
					/obj/item/clothing/under/rank/security/officer/skirt = 3,
					/obj/item/clothing/under/rank/security/skyrat/utility/redsec = 3,
					/obj/item/clothing/suit/toggle/jacket/sec/old = 3,
					)
	premium = list( /obj/item/clothing/under/rank/security/officer/formal = 5,
					/obj/item/clothing/suit/jacket/officer/tan = 5,
					/obj/item/clothing/head/beret/sec/navyofficer = 5)
