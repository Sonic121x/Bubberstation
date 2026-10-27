/datum/quirk/item_quirk/mime_fan
	name = "Mime Fan"
	desc = "你喜欢默剧演员的表演，佩戴默剧徽章会让你心情变好。"
	icon = FA_ICON_THUMBTACK
	value = 2
	mob_trait = TRAIT_MIME_FAN
	gain_text = span_notice("你是默剧演员的忠实粉丝。")
	lose_text = span_danger("默剧演员似乎没那么棒了。")
	medical_record_text = "患者自述是默剧演员的忠实粉丝。"
	mail_goodies = list(
		/obj/item/toy/crayon/mime,
		/obj/item/clothing/mask/gas/mime,
		/obj/item/storage/backpack/mime,
		/obj/item/clothing/under/rank/civilian/mime,
		/obj/item/reagent_containers/cup/glass/bottle/bottleofnothing,
		/obj/item/stamp/mime,
		/obj/item/storage/box/survival/hug/black,
		/obj/item/bedsheet/mime,
		/obj/item/clothing/shoes/sneakers/mime,
		/obj/item/toy/figure/mime,
		/obj/item/toy/crayon/spraycan/mimecan,
	)

/datum/quirk/item_quirk/mime_fan/add_unique(client/client_source)
	give_item_to_holder(/obj/item/clothing/accessory/mime_fan_pin, list(LOCATION_BACKPACK, LOCATION_HANDS))
