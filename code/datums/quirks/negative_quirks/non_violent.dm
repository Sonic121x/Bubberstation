/datum/quirk/nonviolent
	name = "Pacifist"
	desc = "暴力的念头令你作呕，甚至让你无法伤害任何人。"
	icon = FA_ICON_PEACE
	value = -8
	mob_trait = TRAIT_PACIFISM
	gain_text = span_danger("暴力的念头令你感到厌恶！")
	lose_text = span_notice("你觉得自己又能出手自卫了。")
	medical_record_text = "患者极度爱好和平，无法让自己对他人造成身体伤害。"
	hardcore_value = 6
	mail_goodies = list(/obj/effect/spawner/random/decoration/flower, /obj/effect/spawner/random/contraband/cannabis) // flower power
