/mob/living/carbon/human/proc/adjust_pleasure(pleas = 0)
	if(CONFIG_GET(flag/disable_erp_preferences)) // 自定义修改：强制屏蔽成人机制并保留服饰用途
		return
	#ifndef TESTING
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return
	#endif

	pleasure = clamp(pleasure + pleas, AROUSAL_MINIMUM, AROUSAL_LIMIT)

	if(pleasure >= AROUSAL_AUTO_CLIMAX_THRESHOLD) // lets cum
		climax(manual = FALSE)
