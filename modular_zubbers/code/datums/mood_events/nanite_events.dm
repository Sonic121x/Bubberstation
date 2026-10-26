/datum/mood_event/nanite_happiness
	description = "<span class='nicegreen robot'>+++++++快乐增强+++++++</span>\n"
	mood_change = 7

/datum/mood_event/nanite_happiness/add_effects(message)
	description = "<span class='nicegreen robot'>+++++++[message]+++++++</span>\n"

/datum/mood_event/nanite_sadness
	description = "<span class='warning robot'>+++++++快乐抑制+++++++</span>\n"
	mood_change = -7

/datum/mood_event/nanite_sadness/add_effects(message)
	description = "<span class='warning robot'>+++++++[message]+++++++</span>\n"
