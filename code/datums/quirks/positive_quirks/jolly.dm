/datum/quirk/jolly
	name = "Jolly"
	desc = "你有时会无缘无故地感到快乐。"
	icon = FA_ICON_GRIN
	value = 4
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_PROCESSES|QUIRK_TRAUMALIKE
	medical_record_text = "患者始终情绪愉快，与所处环境不相符。说实话，有点过头了。"
	medical_symptom_text = "持续感到快乐、情绪高涨，可能导致不切实际的乐观和冒险行为。"
	mail_goodies = list(/obj/item/clothing/mask/joy)

/datum/quirk/jolly/process(seconds_per_tick)
	// 0.416% is 15 successes / 3600 seconds. Calculated with 2 minute
	// mood runtime, so 50% average uptime across the hour.
	if(SPT_PROB(0.416, seconds_per_tick))
		quirk_holder.add_mood_event("jolly", /datum/mood_event/jolly)

/datum/quirk/jolly/remove()
	quirk_holder.clear_mood_event("jolly")
