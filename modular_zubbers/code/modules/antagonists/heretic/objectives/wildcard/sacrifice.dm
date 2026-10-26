/datum/objective/heretic_wildcard/sacrifice
	name = "献祭船员"
	finish_text = "染血之斧流淌着你受害者的鲜血。祂向你微笑——你感到心智正在拓展……"
	knowledge_to_gain = list(/datum/heretic_knowledge/hunt_and_sacrifice, /datum/heretic_knowledge/reroll_targets)
	max_progress = 2
	//knowledge_per_progress = 2 // handled in the sac ritual

/datum/objective/heretic_wildcard/sacrifice/New(text)
	. = ..()

	update_explanation_text()

/datum/objective/heretic_wildcard/sacrifice/update_explanation_text()
	explanation_text = "献祭至少[max_progress]名船员。"
