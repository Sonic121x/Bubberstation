/datum/quirk/no_taste
	name = "Ageusia"
	desc = "你尝不出任何味道！有毒食物仍然会让你中毒。"
	icon = FA_ICON_MEH_BLANK
	value = 0
	mob_trait = TRAIT_AGEUSIA
	gain_text = span_notice("你尝不出任何味道了！")
	lose_text = span_notice("你又能尝出味道了！")
	medical_record_text = "患者患有味觉缺失症，无法感知食物或试剂的味道。"
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/condiment) // but can you taste the salt? CAN YOU?!
