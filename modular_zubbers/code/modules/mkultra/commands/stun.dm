/datum/mkultra_command/stun
	name = "眩晕"
	description = "让你的受害者短暂失去行动能力。"
	feedback = "突然被震慑住了！"
	trigger = "hold on|stop|stun|halt|wait|stand still"
	phase_requirement = 2
	cooldown = 1 MINUTES

/datum/mkultra_command/stun/execute(datum/status_effect/mkultra/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return
	var/mob/living/victim = owner
	to_chat(victim, span_warning("[source]刚一下令停下，你的肌肉就僵住，双脚钉在原地！"))
	victim.Paralyze(10 SECONDS, TRUE)
