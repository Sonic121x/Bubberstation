/datum/quirk/illiterate
	name = "Illiterate"
	desc = "你辍学后没学会读写。这会影响阅读、书写，以及使用电脑和其他电子设备。"
	icon = FA_ICON_GRADUATION_CAP
	value = -8
	mob_trait = TRAIT_ILLITERATE
	medical_record_text = "患者不识字。"
	hardcore_value = 8
	mail_goodies = list(/obj/item/pai_card) // can read things for you
