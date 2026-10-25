/datum/quirk/item_quirk/tagger
	name = "Tagger"
	desc = "你是一位经验丰富的艺术家。你的涂鸦会令旁人赞叹，而且你只需一半时间作画，绘画用品的可用次数也翻倍。"
	icon = FA_ICON_SPRAY_CAN
	value = 4
	mob_trait = TRAIT_TAGGER
	gain_text = span_notice("你知道如何高效又迅速地在墙上涂鸦。")
	lose_text = span_danger("你忘记了如何正确地在墙上涂鸦。")
	medical_record_text = "患者近期曾因疑似吸入油漆蒸气而就诊。"
	mail_goodies = list(
		/obj/item/toy/crayon/spraycan,
		/obj/item/canvas/nineteen_nineteen,
		/obj/item/canvas/twentythree_nineteen,
		/obj/item/canvas/twentythree_twentythree
	)

/datum/quirk_constant_data/tagger
	associated_typepath = /datum/quirk/item_quirk/tagger
	customization_options = list(/datum/preference/color/paint_color)

/datum/quirk/item_quirk/tagger/add_unique(client/client_source)
	var/obj/item/toy/crayon/spraycan/can = new
	can.set_painting_tool_color(client_source?.prefs.read_preference(/datum/preference/color/paint_color))
	give_item_to_holder(can, list(LOCATION_BACKPACK, LOCATION_HANDS))
