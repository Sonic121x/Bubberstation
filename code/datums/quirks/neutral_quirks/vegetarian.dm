/datum/quirk/vegetarian
	name = "Vegetarian"
	desc = "吃肉的想法令你在道德与生理上都感到反感。"
	icon = FA_ICON_CARROT
	value = 0
	gain_text = span_notice("吃肉的想法令你反感。")
	lose_text = span_notice("你觉得吃肉也没那么糟。")
	medical_record_text = "患者表示自己坚持素食。"
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/salad)
	mob_trait = TRAIT_VEGETARIAN
