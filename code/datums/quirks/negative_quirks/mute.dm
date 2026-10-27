/datum/quirk/mute
	name = "Mute"
	desc = "不知为何，你完全无法说话。"
	icon = FA_ICON_VOLUME_XMARK
	value = -4
	mob_trait = TRAIT_MUTE
	gain_text = span_danger("你发现自己无法说话了！")
	lose_text = span_notice("你感觉声带渐渐恢复了力量。")
	medical_record_text = "患者完全无法发声。"
	hardcore_value = 4
