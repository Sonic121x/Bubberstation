/datum/quirk/monochromatic
	name = "Monochromacy"
	desc = "你患有全色盲，眼中的世界几乎只有黑白。"
	icon = FA_ICON_ADJUST
	value = 0
	medical_record_text = "患者几乎完全无法辨色。"
	mail_goodies = list( // Noir detective wannabe
		/obj/item/clothing/suit/toggle/jacket/det_trench/noir,
		/obj/item/clothing/suit/jacket/det_suit/noir,
		/obj/item/clothing/head/fedora/beige,
		/obj/item/clothing/head/fedora/white,
	)

/datum/quirk/monochromatic/add(client/client_source)
	quirk_holder.add_client_colour(/datum/client_colour/monochrome, QUIRK_TRAIT)

/datum/quirk/monochromatic/post_add()
	if(is_detective_job(quirk_holder.mind.assigned_role))
		to_chat(quirk_holder, span_bolddanger("嗯，这座空间站上的事情从来没有黑白分明的，只有深浅不一的灰……"))
		quirk_holder.playsound_local(quirk_holder, 'sound/ambience/security/ambidet1.ogg', 50, FALSE)

/datum/quirk/monochromatic/remove()
	quirk_holder.remove_client_colour(QUIRK_TRAIT)
