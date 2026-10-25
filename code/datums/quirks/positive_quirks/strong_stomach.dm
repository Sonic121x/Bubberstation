/datum/quirk/strong_stomach
	name = "Strong Stomach"
	desc = "吃掉在地上的食物不会让你生病，呕吐对你的影响也更小。"
	icon = FA_ICON_FACE_GRIN_BEAM_SWEAT
	value = 4
	mob_trait = TRAIT_STRONG_STOMACH
	gain_text = span_notice("你觉得自己什么都吃得下！")
	lose_text = span_danger("看着地上的食物，你有点反胃。")
	medical_record_text = "患者的免疫系统强于常人……至少在抵御食物中毒方面如此。"
	mail_goodies = list(
		/obj/item/reagent_containers/applicator/pill/ondansetron,
	)
