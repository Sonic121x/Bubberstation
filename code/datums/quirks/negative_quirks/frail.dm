/datum/quirk/frail
	name = "Frail"
	desc = "你的皮肤像纸，骨头像玻璃！你比大多数人更容易受伤。"
	icon = FA_ICON_SKULL
	value = -6
	mob_trait = TRAIT_EASILY_WOUNDED
	gain_text = span_danger("你感觉脆弱不堪。")
	lose_text = span_notice("你又感觉结实了。")
	medical_record_text = "患者极易受伤。请务必谨慎处置，以免引发医疗事故诉讼。"
	hardcore_value = 4
	mail_goodies = list(/obj/effect/spawner/random/medical/minor_healing)
