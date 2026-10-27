/datum/mood_event/it_was_on_the_mouse
	description = "嘿嘿，\"鼠我请客\"。真是个好双关。"
	mood_change = 1
	timeout = 2 MINUTES
	event_flags = MOOD_EVENT_WHIMSY

/datum/mood_event/gondola_serenity
	description = "此刻你或许有很多心事。但一种满足感正涌上心头，仿佛宇宙在呼唤你，只需安坐一旁，静静观察……"
	mood_change = 10
	special_screen_obj = "mood_gondola"

/datum/mood_event/fish_waterless
	mood_change = -3
	description = "干燥的感觉真糟糕。我就像一条离开水的鱼。"

/datum/mood_event/fish_water
	mood_change = 1
	description = "咕噜咕噜！"
