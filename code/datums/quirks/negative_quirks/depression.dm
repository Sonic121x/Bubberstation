/datum/quirk/depression
	name = "Depression"
	desc = "你有时就是厌恶生活。"
	icon = FA_ICON_FROWN
	value = -3
	gain_text = span_danger("你开始感到抑郁。")
	lose_text = span_notice("你不再感到抑郁了。") //if only it were that easy!
	medical_record_text = "患者患有轻度情绪障碍，会出现急性抑郁发作。"
	medical_symptom_text = "持续感到悲伤、绝望和缺乏动力。"
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_MOODLET_BASED|QUIRK_PROCESSES|QUIRK_TRAUMALIKE
	hardcore_value = 2
	mail_goodies = list(/obj/item/storage/pill_bottle/happinesspsych)

/datum/quirk/depression/process(seconds_per_tick)
	// 0.416% is 15 successes / 3600 seconds. Calculated with 2 minute
	// mood runtime, so 50% average uptime across the hour.
	if(SPT_PROB(0.416, seconds_per_tick))
		quirk_holder.add_mood_event("depression", /datum/mood_event/depression)

/datum/quirk/depression/remove()
	quirk_holder.clear_mood_event("depression")
