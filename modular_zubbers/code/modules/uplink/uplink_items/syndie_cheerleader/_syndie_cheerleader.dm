// Syndicate Cheerleader Outfit - Traitor Uplink Entry

/datum/uplink_item/badass/syndie_cheerleader
	name = "辛迪加啦啦队服装"
	desc = "赛博太阳工业以支持特工的身心健康为荣。 \
		研究表明，只要有个人在你身后撑腰，合同完成率就能提高 12%。"
	item = /obj/item/storage/box/syndie_cheerleader
	cost = 6
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/obj/item/storage/box/syndie_cheerleader
	name = "可疑的红盒子"
	desc = "一只流线型的坚固箱子。侧面不知为何印着赛博太阳的标志。"
	icon_state = "syndiebox"

/obj/item/storage/box/syndie_cheerleader/PopulateContents()
	. = ..()
	new /obj/item/clothing/under/syndicate/ba_cheerleader(src)
	new /obj/item/clothing/gloves/ba_cheerleader/syndicate(src)
	new /obj/item/clothing/shoes/sneakers/ba_cheerleader/syndicate(src)
