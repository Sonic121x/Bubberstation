/datum/mkultra_command/antiresist
	name = "反抗抑制"
	description = "让你的受害者短时间内无法反抗"
	feedback = "停止了反抗。"
	trigger = "stop resisting|give up|give in|stop being difficult|unable to resist"
	cooldown = 60 SECONDS
	phase_requirement = 3
	erp_command = FALSE
	var/resist = FALSE

/datum/mkultra_command/antiresist/on_destroy(datum/status_effect/status, mob/owner, mob/source)
	UnregisterSignal(owner, COMSIG_LIVING_RESIST)

/datum/mkultra_command/antiresist/execute(datum/status_effect/status, mob/owner, mob/source, message)
	. = ..()
	if(!.)
		return FALSE
	processing = TRUE
	RegisterSignal(owner, COMSIG_LIVING_RESIST, PROC_REF(resist_command_block))
	return TRUE

/datum/mkultra_command/antiresist/tick(datum/status_effect/mkultra/status, mob/owner, mob/source)
	. = ..()
	if(!COOLDOWN_FINISHED(src, ultra_cooldown))
		resist = TRUE
		return TRUE
	processing = FALSE
	UnregisterSignal(owner, COMSIG_LIVING_RESIST)
	return FALSE

/datum/mkultra_command/antiresist/proc/resist_command_block(mob/living/owner)
	SIGNAL_HANDLER
	if(resist)
		to_chat(owner, span_warning("最近的命令萦绕在脑海中，你发现自己无法反抗。"))
		return COMPONENT_BLOCK_RESIST

