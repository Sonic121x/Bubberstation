/datum/language/uncommon
	name = "Terran Uncommon"
	desc = "地球异通用语是为抗议融合派颠覆其传统通用语而发展出来的，最常在其名字的来源地——地球上使用。\
		作为英语、普通话与印地语的混合语，它与其通用语对应语言相似却有着决定性的区别：它不受任何外星影响。"
	key = "!"
	flags = LANGUAGE_TONGUELESS_SPEECH
	space_chance = 20
	sentence_chance = 0
	between_word_sentence_chance = 10
	between_word_space_chance = 75
	additional_syllable_low = 0
	additional_syllable_high = 0
	syllables = list(
		"ba", "be", "bo", "ca", "ce", "co", "da", "de", "do",
		"fa", "fe", "fo", "ga", "ge", "go", "ha", "he", "ho",
		"ja", "je", "jo", "ka", "ke", "ko", "la", "le", "lo",
		"ma", "me", "mo", "na", "ne", "no", "ra", "re", "ro",
		"sa", "se", "so", "ta", "te", "to", "va", "ve", "vo",
		"xa", "xe", "xo", "ya", "ye", "yo", "za", "ze", "zo"
	)
	icon_state = "galuncom"
	default_priority = 90

	mutual_understanding = list(
		/datum/language/common = 20,
		/datum/language/beachbum = 20,
	)
