/datum/quirk/light_step
	name = "Light Step"
	desc = "你步履轻盈；脚步声以及踩到尖锐物品时的声音更小，疼痛也更轻。此外，踩到血迹不会弄脏你的手和衣服。"
	icon = FA_ICON_SHOE_PRINTS
	value = 4
	mob_trait = TRAIT_LIGHT_STEP
	gain_text = span_notice("你的步伐更轻盈了。")
	lose_text = span_danger("你开始像野蛮人一样重重地踏步。")
	medical_record_text = "患者身手灵巧，具备出色的潜行能力。"
	mail_goodies = list(/obj/item/clothing/shoes/sandal)
