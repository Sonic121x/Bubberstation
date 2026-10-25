/datum/quirk/pushover
	name = "Pushover"
	desc = "你的第一反应总是任人摆布。挣脱抓握对你来说明显更加困难。"
	icon = FA_ICON_HANDSHAKE
	value = -8
	mob_trait = TRAIT_GRABWEAKNESS
	gain_text = span_danger("你觉得自己很好欺负。")
	lose_text = span_notice("你想为自己挺身而出了。")
	medical_record_text = "患者性格明显缺乏主见，容易受到操纵。"
	hardcore_value = 4
	mail_goodies = list(/obj/item/clothing/gloves/cargo_gauntlet)
