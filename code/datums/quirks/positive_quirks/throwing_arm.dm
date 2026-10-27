/datum/quirk/throwingarm
	name = "Throwing Arm"
	desc = "你的双臂十分有力！你扔出的东西总比别人飞得更远，而且从不失手。"
	icon = FA_ICON_BASEBALL
	value = 7
	mob_trait = TRAIT_THROWINGARM
	gain_text = span_notice("你的双臂充满力量！")
	lose_text = span_danger("你的双臂有点酸痛。")
	medical_record_text = "患者精通投球。"
	mail_goodies = list(/obj/item/toy/beach_ball/baseball, /obj/item/toy/basketball, /obj/item/toy/dodgeball)
