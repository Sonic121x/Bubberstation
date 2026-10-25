/datum/language/codespeak
	name = "Codespeak"
	desc = "辛迪加特工可用一串暗语传递复杂信息，而在窃听者听来不过是随机的概念和饮料名。"
	key = "t"
	default_priority = 0
	flags = LANGUAGE_TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	icon_state = "codespeak"
	always_use_default_namelist = TRUE // No syllables anyways

/datum/language/codespeak/scramble_sentence(input, list/mutual_languages)
	var/sentence = read_word_cache(input)
	if(sentence)
		return sentence

	sentence = ""
	var/list/words = list()
	while(length_char(sentence) < length_char(input))
		words += generate_code_phrase(return_list=TRUE)
		sentence = jointext(words, ", ")

	sentence = capitalize(sentence)

	sentence += find_last_punctuation(input)

	write_word_cache(input, sentence)

	return sentence
