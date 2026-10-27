/datum/quirk/clumsy
	name = "Clumsy"
	desc = "你笨手笨脚、傻里傻气，是个讨人喜欢的笨蛋！希望你没打算用双手做任何哪怕只需要一点点灵巧的事情。"
	icon = FA_ICON_FACE_DIZZY
	value = -8
	mob_trait = TRAIT_CLUMSY
	gain_text = span_danger("你感觉智商一路下沉，仿佛大脑融化成了液体。")
	lose_text = span_notice("你感觉智商至少恢复到平均水平了。")
	medical_record_text = "患者在精细运动方面存在严重困难，且缺乏批判性思考能力。"
	medical_symptom_text = "协调能力差、频繁发生意外，同时在解决问题与作出决策方面存在困难。"
	quirk_flags = QUIRK_TRAUMALIKE
