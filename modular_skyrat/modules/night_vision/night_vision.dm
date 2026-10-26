/datum/quirk/night_vision
	name = "Night Vision"
	desc = "在完全黑暗中，你比大多数人看得稍微清楚一些。"
	icon = FA_ICON_MOON
	value = 4
	mob_trait = TRAIT_NIGHT_VISION
	gain_text = span_notice("阴影似乎没那么黑了。")
	lose_text = span_danger("一切似乎都暗了一些。")
	medical_record_text = "患者双眼对黑暗的适应能力高于平均水平。"
	mail_goodies = list(
		/obj/item/flashlight/flashdark,
		/obj/item/food/grown/mushroom/glowshroom/shadowshroom,
		/obj/item/skillchip/light_remover,
	)

/datum/quirk/night_vision/add(client/client_source)
	refresh_quirk_holder_eyes()

/datum/quirk/night_vision/remove()
	refresh_quirk_holder_eyes()

/datum/quirk/night_vision/proc/refresh_quirk_holder_eyes()
	var/mob/living/carbon/human/human_quirk_holder = quirk_holder
	var/obj/item/organ/eyes/eyes = human_quirk_holder.get_organ_by_type(/obj/item/organ/eyes)
	if(!eyes)
		return
	// We've either added or removed TRAIT_NIGHT_VISION before calling this proc. Just refresh the eyes.
	eyes.refresh()
