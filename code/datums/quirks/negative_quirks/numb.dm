/datum/quirk/numb
	name = "Numb"
	desc = "你完全感觉不到疼痛。"
	icon = FA_ICON_STAR_OF_LIFE
	value = -4
	gain_text = "你感觉身体变得麻木。"
	lose_text = "麻木感消退了。"
	medical_record_text = "患者存在先天性感觉减退，对疼痛刺激不敏感。"
	medical_symptom_text = "无法感知疼痛，可能导致意外自伤及对有害刺激反应迟缓。"
	hardcore_value = 4
	quirk_flags = QUIRK_TRAUMALIKE

/datum/quirk/numb/add(client/client_source)
	quirk_holder.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)
	quirk_holder.add_traits(list(TRAIT_ANALGESIA, TRAIT_NO_DAMAGE_OVERLAY), QUIRK_TRAIT)

/datum/quirk/numb/remove(client/client_source)
	quirk_holder.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)
	quirk_holder.remove_traits(list(TRAIT_ANALGESIA, TRAIT_NO_DAMAGE_OVERLAY), QUIRK_TRAIT)
