/datum/quirk/item_quirk/immunodeficiency
	name = "Immunodeficiency"
	desc = "无论是慢性病还是遗传因素所致，你的身体都成了各种细菌、病毒和寄生虫全天候包吃包住的旅馆。即使服用处方免疫增强药物，你的抵抗力仍不如大多数人。"
	icon = FA_ICON_MASK_FACE
	value = -10
	mob_trait = TRAIT_IMMUNODEFICIENCY
	gain_text = span_danger("光是想到生病，你就觉得发起烧来。")
	lose_text = span_notice("你的免疫系统奇迹般地恢复了功能。")
	medical_record_text = "患者患有慢性免疫缺陷。"
	mail_goodies = list(
		/obj/item/reagent_containers/syringe/antiviral,
		/obj/item/healthanalyzer/simple/disease
	)

/datum/quirk/item_quirk/immunodeficiency/add_unique(client/client_source)
	give_item_to_holder(
		/obj/item/clothing/mask/surgical,
		list(
			LOCATION_MASK,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		)
	)
	give_item_to_holder(
		/obj/item/storage/pill_bottle/immunodeficiency,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		)
	)
