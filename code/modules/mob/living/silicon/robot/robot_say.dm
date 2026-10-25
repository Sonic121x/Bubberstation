/mob/living/silicon/robot/try_speak(message, ignore_spam = FALSE, forced = null, filterproof = FALSE)
	// Cyborgs cannot speak if silent borg is on.
	// Unless forced is set, as that's probably stating laws or something.
	if(!forced && CONFIG_GET(flag/silent_borg))
		to_chat(src, span_danger("半机械人的说话功能目前已被服务器配置禁用。"))
		return FALSE

	return ..()
