/datum/mood_event/tucked_in
	description = "帮人掖好被子道声晚安，让我心情好多了！"
	mood_change = 3
	timeout = 2 MINUTES

/datum/mood_event/tucked_in/add_effects(mob/tuckee)
	if(!tuckee)
		return
	description = "帮 [tuckee.name] 掖好被子道声晚安，让我心情好多了！"
