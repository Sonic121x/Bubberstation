/datum/mkultra_command/silence
	name = "施以沉默"
	description = "让你的目标陷入沉默。"
	feedback = "紧紧闭上了嘴！"
	trigger = "shh|silence|stop talking|shut up|be quiet|hush"
	cooldown = 60 SECONDS
	phase_requirement = 1

/datum/mkultra_command/silence/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/victim = owner
	if(status.phase == 3)
		ADD_TRAIT(victim, TRAIT_MUTE, "mkultra")
		to_chat(victim, span_warning("在这突如其来的要求下，你的嘴[status.lewd ? "顺从地" : ""]猛地闭上了。"))
	else
		victim.adjust_silence(20 SECONDS * status.phase)
		to_chat(victim, span_warning("[status.lewd ? status.get_gender() : source]命令沉默，你的嘴不由自主地闭上了。"))
	return TRUE

/datum/mkultra_command/silence/on_destroy(datum/status_effect/mkultra/status, mob/owner, mob/source)
	var/mob/living/victim = owner
	REMOVE_TRAIT(victim, TRAIT_MUTE, "mkultra")
	victim.set_silence(0)

/datum/mkultra_command/speak
	name = "允许说话"
	description = "让你的目标重新正常说话。"
	feedback = "被允许再次开口。"
	trigger = "talk|speak|talk to me|say something|speak"
	phase_requirement = 1

/datum/mkultra_command/speak/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/victim = owner
	REMOVE_TRAIT(victim, TRAIT_MUTE, "mkultra")
	victim.set_silence(0)
	to_chat(victim, span_notice("[status.lewd ? status.get_gender() : source]允许你再次开口。"))
	return TRUE
