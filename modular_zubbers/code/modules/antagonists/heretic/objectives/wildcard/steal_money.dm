/datum/objective/heretic_wildcard/steal_money
	name = "窃取钱财"
	finish_text = "资本家虽是离经叛道的神，却欣赏真正的创业者。你的钱包愈发充盈，心智也随之拓展。"
	knowledge_to_gain = list(/datum/heretic_knowledge/blood_to_money)
	knowledge_per_progress = 2
	max_progress = 1
	var/stolen = 0

/datum/objective/heretic_wildcard/steal_money/New(text)
	. = ..()

	target_amount = rand(1000, 1250)
	update_explanation_text()

/datum/objective/heretic_wildcard/steal_money/update_explanation_text()
	explanation_text = "利用仪式从船员那里窃取至少[target_amount]信用点。只有达到目标金额后才会获得知识点。"

/datum/objective/heretic_wildcard/steal_money/apply_to(datum/antagonist/heretic/our_heretic)
	. = ..()

	RegisterSignal(our_heretic, COMSIG_HERETIC_STOLE_MONEY, PROC_REF(on_theft))

/datum/objective/heretic_wildcard/steal_money/proc/on_theft(datum/antagonist/heretic/signal_source, mob/living/carbon/victim, amount)
	SIGNAL_HANDLER

	stolen += amount
	if (stolen >= target_amount)
		increment_progress(signal_source)
