/datum/quirk/featherweight
	name = "Featherweight"
	desc = "你的身体比别人轻。别人很容易揪住你的后颈或衣领把你提起来。"
	value = 1
	icon = FA_ICON_FEATHER
	medical_record_text = "该人员体重低于常人，相对容易被抱起。"
	gain_text = "你感觉身体更轻了！"
	lose_text = "你感觉身体稍微沉实了些。"
	quirk_flags = QUIRK_HUMAN_ONLY
	mob_trait = TRAIT_CAN_BE_PICKED_UP
	mail_goodies = list(/obj/item/food/lollipop)
