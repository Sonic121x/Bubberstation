/datum/uplink_item/badass/syndimaid
	name = "辛迪加女仆装"
	desc = "一个明摆着的玩笑。一套标准的辛迪加女仆装，外加笨重的装甲。加装的装甲让你无法再穿任何外套"
	item = /obj/item/storage/box/syndimaid
	cost = 8 // Same as the redsuit mod. It's worse than it in almost every way but that's by design
	cant_discount = TRUE
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/obj/item/storage/box/syndimaid
	name = "一盒包装整齐的待洗衣物"

/obj/item/storage/box/syndimaid/PopulateContents()
	. = ..()
	new /obj/item/clothing/under/syndicate/skyrat/maid/armored(src)
	new /obj/item/clothing/head/costume/maid_headband/syndicate/armored(src)
	new /obj/item/clothing/gloves/combat/maid/armored(src)
	new /obj/item/clothing/shoes/jackboots/heel/tactical(src)
