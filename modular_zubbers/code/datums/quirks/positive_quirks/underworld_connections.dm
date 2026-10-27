/datum/quirk/item_quirk/underworld_connections
	name = "Underworld Connections"
	desc = "你与犯罪地下世界及黑市建立了联系。你携带着一台黑市上行终端。"
	value = 2
	medical_record_text = "已知该人员藏有黑市上行终端……"
	icon = FA_ICON_UPLOAD

/datum/quirk/item_quirk/underworld_connections/add_unique(client/client_source)
	give_item_to_holder(/obj/item/market_uplink/blackmarket, list(LOCATION_BACKPACK, LOCATION_HANDS))
