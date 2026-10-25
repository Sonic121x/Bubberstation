/datum/language/drone
	name = "Drone"
	desc = "一种高度编码的损管协调数据流，并为帽子设有特殊标记。"
	spans = list(SPAN_ROBOT)
	key = "d"
	flags = LANGUAGE_NO_STUTTER
	syllables = list(".", "|")
	// ...|..||.||||.|.||.|.|.|||.|||
	space_chance = 0
	sentence_chance = 0
	between_word_sentence_chance = 0
	between_word_space_chance = 0
	additional_syllable_low = 0
	additional_syllable_high = 0
	default_priority = 20

	icon_state = "drone"
	always_use_default_namelist = TRUE // Nonsense language
