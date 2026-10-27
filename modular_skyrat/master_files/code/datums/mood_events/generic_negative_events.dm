// Species trait debuffs
/datum/mood_event/dry_skin
	description = "我的皮肤干得难受……"
	mood_change = -2

// When you get bit by a peculiar plushie
/datum/mood_event/plush_bite
	description = span_warning("它咬我！！好痛！")
	mood_change = -3
	timeout = 2 MINUTES
