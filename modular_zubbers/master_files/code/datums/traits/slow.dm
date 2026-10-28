/datum/quirk/overweight
	name = "Overweight"
	desc = "你的体重超过同体型的普通人。因饮食发胖仍然会让你困扰。"
	gain_text = span_notice("你的身体感到沉重。")
	lose_text = span_notice("你突然觉得轻了不少！")
	value = -4
	icon = FA_ICON_BOWL_RICE
	medical_record_text = "患者体重高于平均水平。"
	mob_trait = null

/datum/quirk/obese
	name = "Obese"
	desc = "你的体重远超同体型的普通人，而且无论如何都始终肥胖。因饮食发胖不再困扰你。"
	gain_text = span_notice("你的身体感到<b>极其</b>沉重。")
	lose_text = span_notice("你突然觉得轻了非常多！")
	value = -6
	icon = FA_ICON_HAMBURGER
	medical_record_text = "101% 的医学教科书都认为患者肥胖，误差范围为 1%。"
	mob_trait = TRAIT_FAT
