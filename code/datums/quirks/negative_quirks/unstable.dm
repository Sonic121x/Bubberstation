/datum/quirk/unstable
	name = "Unstable"
	desc = "由于过去的创伤，你损失的理智无法恢复。务必小心管理自己的情绪！"
	icon = FA_ICON_ANGRY
	value = -10
	mob_trait = TRAIT_UNSTABLE
	gain_text = span_danger("你现在心事重重。")
	lose_text = span_notice("你的内心终于平静了。")
	medical_record_text = "患者心理状态脆弱，无法从创伤事件中恢复。"
	medical_symptom_text = "情绪严重不稳定，且无法从心理压力中恢复。"
	hardcore_value = 9
	mail_goodies = list(/obj/effect/spawner/random/entertainment/plushie)
	quirk_flags = QUIRK_TRAUMALIKE
