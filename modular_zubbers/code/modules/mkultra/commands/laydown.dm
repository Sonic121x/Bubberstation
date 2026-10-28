/datum/mkultra_command/laydown
	name = "下跪 / 趴下"
	description = "让你的奴隶趴到地上。"
	feedback = "立刻趴到了地上。"
	trigger = "lay down|kneel|rest|on the floor"
	phase_requirement = 1
	erp_command = TRUE
	cooldown = 10 SECONDS

/datum/mkultra_command/laydown/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return
	var/datum/status_effect/mkultra/ultra = status
	var/mob/living/victim = owner
	to_chat(owner, span_userlove("[ultra.get_gender()]一声令下，你立刻伏倒在地！"))
	victim.toggle_resting()

