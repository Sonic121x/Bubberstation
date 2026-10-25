/datum/quirk/freerunning
	name = "Freerunning"
	desc = "你身手敏捷！你能更快地爬上桌子，从较低处跌落也不会受伤。"
	icon = FA_ICON_RUNNING
	value = 8
	mob_trait = TRAIT_FREERUNNING
	gain_text = span_notice("你感觉脚步轻快！")
	lose_text = span_danger("你又觉得自己笨手笨脚了。")
	medical_record_text = "患者在心肺功能测试中成绩优异。"
	mail_goodies = list(/obj/item/melee/skateboard, /obj/item/clothing/shoes/wheelys/rollerskates)
