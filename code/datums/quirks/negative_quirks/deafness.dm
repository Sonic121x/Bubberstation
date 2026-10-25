/datum/quirk/item_quirk/deafness
	name = "Deaf"
	desc = "你患有无法治愈的失聪。"
	icon = FA_ICON_DEAF
	value = -8
	mob_trait = TRAIT_DEAF
	gain_text = span_danger("你什么也听不见。")
	lose_text = span_notice("你又能听见声音了！")
	medical_record_text = "患者的耳蜗神经受到无法治愈的损伤。"
	hardcore_value = 12
	mail_goodies = list(/obj/item/clothing/mask/whistle)

/datum/quirk/item_quirk/deafness/add_unique(client/client_source)
	give_item_to_holder(/obj/item/clothing/accessory/deaf_pin, list(LOCATION_BACKPACK, LOCATION_HANDS))
