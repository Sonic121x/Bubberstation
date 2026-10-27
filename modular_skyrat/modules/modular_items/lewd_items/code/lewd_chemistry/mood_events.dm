///To notify, but not harm the player in terms of mood. Used for camphor, pentacamphor, succubus milk, and incubus draft.
/datum/mood_event/minor_overdose
	timeout = 5 MINUTES

/datum/mood_event/minor_overdose/add_effects(drug_name)
	description = "<span class='warning'>我想我 [drug_name] 摄入得有点过量了……</span>\n"
