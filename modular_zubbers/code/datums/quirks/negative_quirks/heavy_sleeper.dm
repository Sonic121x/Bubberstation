// re-adds heavy sleeper
/datum/quirk/heavy_sleeper
	name = "Heavy Sleeper"
	desc = "你睡得像块石头！每当你被催眠或击昏，都要多花一点时间才能醒来。"
	icon = FA_ICON_FACE_TIRED
	value = -2
	mob_trait = TRAIT_HEAVY_SLEEPER
	gain_text = span_danger("你感到困倦。")
	lose_text = span_notice("你又感到清醒了。")
	medical_record_text = "患者睡眠检查结果异常，难以唤醒。"
	hardcore_value = 2
	mail_goodies = list(
		/obj/item/clothing/glasses/blindfold,
		/obj/effect/spawner/random/bedsheet/any,
		/obj/item/clothing/under/misc/pj/red,
		/obj/item/clothing/head/costume/nightcap/red,
		/obj/item/clothing/under/misc/pj/blue,
		/obj/item/clothing/head/costume/nightcap/blue,
		/obj/item/pillow/random,
	)
