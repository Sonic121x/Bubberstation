/datum/quirk/waddle
	name = "Waddle"
	desc = "你走起路来总是有些摇摇摆摆。"
	medical_record_text = "该人员似乎很不擅长跳舞。"
	value = 0
	icon = FA_ICON_WIND
	gain_text = span_notice("你想用滑稽的姿势走路")
	lose_text = span_notice("你不再想用滑稽的姿势走路了")
	quirk_flags = null
	mail_goodies = list(/obj/item/food/grown/banana)


/datum/quirk/waddle/add(client/client_source)
	. = ..()
	quirk_holder.AddElementTrait(TRAIT_WADDLING, QUIRK_TRAIT, /datum/element/waddling)

/datum/quirk/waddle/remove()
	. = ..()
	quirk_holder.RemoveElement(/datum/element/waddling)
