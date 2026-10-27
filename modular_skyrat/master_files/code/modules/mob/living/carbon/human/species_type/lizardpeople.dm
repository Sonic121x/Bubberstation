/*
Lizard subspecies: ASHWALKERS
*/

/datum/species/lizard/ashwalker/
	language_prefs_whitelist = list(/datum/language/ashtongue, /datum/language/sylvan, /datum/language/xenocommon, /datum/language/draconic)

/datum/species/lizard/ashwalker/create_pref_language_perk()
	var/list/to_add = list()
	// Holding these variables so we can grab the exact names for our perk.
	var/datum/language/common_language = /datum/language/ashtongue

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "comment",
		SPECIES_PERK_NAME = "母语者",
		SPECIES_PERK_DESC = "灰行者只能讲 [initial(common_language.name)]。\
			灰行者学会其他语言的情况很罕见，但并非不可能。"
	))

	return to_add
