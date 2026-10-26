/datum/objective/heretic_wildcard/curse
	name = "诅咒船员"
	finish_text = "珍馐盛宴如今得以如期继续。异信者的鲜血是难得的美味——双唇咂响，牙齿撕碎，舌头翻卷。你发现自己也有些垂涎……"
	knowledge_to_gain = list(/datum/heretic_knowledge/codex_morbus)
	knowledge_per_progress = 0.25

/datum/objective/heretic_wildcard/curse/New(text)
	. = ..()

	max_progress = rand(4, 5)
	update_explanation_text()

/datum/objective/heretic_wildcard/curse/update_explanation_text()
	explanation_text = "诅咒至少[max_progress]名船员。"

/datum/objective/heretic_wildcard/curse/apply_to(datum/antagonist/heretic/our_heretic)
	. = ..()

	RegisterSignal(our_heretic, COMSIG_HERETIC_CURSED_TARGET, PROC_REF(on_cursed))

/datum/objective/heretic_wildcard/curse/proc/on_cursed(datum/antagonist/heretic/signal_source, mob/living/carbon/target)
	SIGNAL_HANDLER

	increment_progress(signal_source, target)
