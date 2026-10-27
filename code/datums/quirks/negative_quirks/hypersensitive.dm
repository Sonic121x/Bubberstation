/datum/quirk/hypersensitive
	name = "Hypersensitive"
	desc = "无论好坏，任何事对你情绪的影响似乎都超乎寻常。"
	icon = FA_ICON_FLUSHED
	value = -2
	gain_text = span_danger("你似乎对什么事都反应过度。")
	lose_text = span_notice("你似乎不再对什么事都反应过度了。")
	medical_record_text = "患者表现出高度的情绪波动。"
	medical_symptom_text = "对外界刺激的情绪反应增强，\
		导致社交场合中的敏感度与反应性大幅提高。"
	hardcore_value = 3
	mail_goodies = list(/obj/effect/spawner/random/entertainment/plushie_delux)
	quirk_flags = QUIRK_TRAUMALIKE

/datum/quirk/hypersensitive/add(client/client_source)
	if (quirk_holder.mob_mood)
		quirk_holder.mob_mood.mood_modifier += 0.5

/datum/quirk/hypersensitive/remove()
	if (quirk_holder.mob_mood)
		quirk_holder.mob_mood.mood_modifier -= 0.5
