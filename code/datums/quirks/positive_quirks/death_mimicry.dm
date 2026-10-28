/datum/quirk/death_mimicry
	name = "Death Mimicry"
	desc = "你精通装死的技巧。做出临终喘息会让你陷入昏迷，并在短时间内让检查你的人误以为你已经伤重不治。"
	icon = FA_ICON_GHOST
	value = 16
	gain_text = span_notice("你知道如何演出令人信服的死亡场面。")
	lose_text = span_danger("你失去了戏剧性装死的本领。")
	medical_record_text = "患者经常假装心脏骤停来逃避斗殴。"
	mail_goodies = list(/obj/item/bodybag)
