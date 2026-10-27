/datum/language/schechi
	name = "Schechi"
	desc = "特沙利结构十分松散的克里奥尔语，包含数百种差异大得几乎可以各自独立成语言的方言。\
	谢奇语起源于西里赛，随着特沙利向外迁徙，成为不同群落之间普遍认可的交流方式。"
	key = "F"
	space_chance = 40
	syllables = list(
		"i", "ii", "si", "aci", "hi", "ni", "li", "schi", "tari",
		"e", "she", "re", "me", "ne",  "te", "se", "le", "ai",
		"a", "ra", "ca", "scha", "tara", "sa", "la", "na", "ce",
		"re", "se", "shi", "ti", "le", "la", "lu", "tu", "shu",
	)
	icon = 'modular_skyrat/master_files/icons/misc/language.dmi'
	icon_state = "schechi"
	default_priority = 90

/datum/language/schechi/get_random_name(
	gender = NEUTER,
	name_count = default_name_count,
	syllable_min = default_name_syllable_min,
	syllable_max = default_name_syllable_max,
	force_use_syllables = FALSE,
)
	if(force_use_syllables)
		return ..()

	var/newname = ""
	for(var/i in 1 to rand(2, 3))
		newname += pick(list("chi", "chu", "ka", "ki", "kyo", "ko", "la", "li", "mi", "ni", "nu", "nyu", "se", "ri", "ro", "ru", "ryu", "sa", "si", "syo"))
	return capitalize(newname)
