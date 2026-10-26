/datum/quirk/equipping/nerve_staple
	name = "Nerve Stapled"
	desc = "你无法伤害他人。这不是你的本意，而是钉入眼睛的装置强迫你如此。"
	value = -10 // pacifism = -8, losing eye slots = -2
	gain_text = span_danger("你突然无法抬手伤害他人！")
	lose_text = span_notice("你觉得自己又能自卫了。")
	medical_record_text = "患者装有神经钉，无法伤害他人。"
	icon = FA_ICON_FACE_ANGRY
	forced_items = list(/obj/item/clothing/glasses/nerve_staple = list(ITEM_SLOT_EYES))
	/// The nerve staple attached to the quirk
	var/obj/item/clothing/glasses/nerve_staple/staple

/datum/quirk/equipping/nerve_staple/on_equip_item(obj/item/equipped, successful)
	if (!istype(equipped, /obj/item/clothing/glasses/nerve_staple))
		return
	staple = equipped

/datum/quirk/equipping/nerve_staple/remove()
	. = ..()
	if (!staple || staple != quirk_holder.get_item_by_slot(ITEM_SLOT_EYES))
		return
	to_chat(quirk_holder, span_warning("神经钉突然从你脸上脱落，随后[istype(quirk_holder.loc, /turf/open/floor) ? "在地板上" : ""]熔化了！"))
	qdel(staple)
