/datum/quirk/gifted
	name = "Gifted"
	desc = "你天生多了几分幸运或聪慧，或是两者兼具。你能比别人多做一点。"
	icon = FA_ICON_DOVE
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN
	value = -6
	mob_trait = TRAIT_GIFTED
	gain_text = span_danger("你感觉自己更加灵活了些。")
	lose_text = span_notice("你感觉自己没那么灵活了。")
	medical_record_text = "患者时常有异乎寻常的好运。"
	hardcore_value = 0
