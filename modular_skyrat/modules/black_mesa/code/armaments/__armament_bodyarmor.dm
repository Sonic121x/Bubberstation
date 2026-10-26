
/datum/armament_entry/hecu/bodyarmor
	category = "护甲套装"
	category_item_limit = 4

/datum/armament_entry/hecu/bodyarmor/normal
	name = "基础护甲套装"
	description = "内含两件基础护甲，能为全身提供相当不错的防护。"
	item_type = /obj/item/storage/box/armor_set/normal
	max_purchase = 4
	cost = 6

/datum/armament_entry/hecu/bodyarmor/pcv
	name = "PCV 套装"
	description = "内含两件危险环境护甲。这套护甲能提供全面的强力防护，并带有轻度的再生效果。"
	item_type = /obj/item/storage/box/armor_set/pcv
	max_purchase = 4
	cost = 20

/obj/item/storage/box/armor_set
	name = "护甲盒"
	desc = "装满护甲的盒子。真了不起。"
	icon_state = "box"
	illustration = null

/obj/item/storage/box/armor_set/Initialize(mapload)
	. = ..()
	atom_storage.set_holdable(list(/obj/item/clothing/suit/armor,/obj/item/clothing/suit/space/hev_suit/pcv,/obj/item/clothing/head/helmet))
	atom_storage.max_slots = 2

/obj/item/storage/box/armor_set/normal
	name = "战斗护甲套装"
	desc = "装有抗损伤护甲背心与头盔的盒子。"

/obj/item/storage/box/armor_set/normal/PopulateContents()
	new /obj/item/clothing/suit/armor/vest/hecu(src)
	new /obj/item/clothing/head/helmet/hecu(src)

/obj/item/storage/box/armor_set/pcv
	name = "PCV Mk. II 装甲套装"
	desc = "装有 PCV Mark II 装甲背心与头盔的盒子。"

/obj/item/storage/box/armor_set/pcv/PopulateContents()
	new /obj/item/clothing/suit/space/hev_suit/pcv(src)
	new /obj/item/clothing/head/helmet/space/hev_suit/pcv(src)
