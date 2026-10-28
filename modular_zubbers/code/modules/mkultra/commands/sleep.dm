/datum/mkultra_command/sleep_command
	name = "睡眠"
	description = "让你的受害者睡上 60 秒。"
	feedback = "立刻睡着了！"
	trigger = "go to sleep|slumber|rest|take a nap"
	phase_requirement = 2
	cooldown = 4 MINUTES

/datum/mkultra_command/sleep_command/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/victim = owner
	if(HAS_TRAIT(victim, TRAIT_KNOCKEDOUT))
		to_chat(source, span_warning("[victim]已经睡熟了！"))
		return FALSE
	victim.SetSleeping(1 MINUTES)
	return TRUE
