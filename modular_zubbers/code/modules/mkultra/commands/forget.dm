/datum/mkultra_command/forget
	name = "遗忘"
	description = "关闭 MKUltra，并让受害者忘记自己身中此术。用 *snap3 重新启用"
	feedback = "突然睡去，忘记了你施加的影响。"
	trigger = "forget everything|awake and forget"
	phase_requirement = 3

/datum/mkultra_command/forget/execute(datum/status_effect/mkultra/status, mob/living/owner, mob/source, message)
	. = ..()
	if(!. || status.dormant)
		return FALSE
	status.dormant = TRUE
	owner.clear_alert(status.id)
	to_chat(owner, span_boldwarning("你变回了先前的自己，完全不记得[status.enchanter]曾奴役过你。"))
	owner.AdjustSleeping(10 SECONDS)
	status.RegisterSignal(status.enchanter, COMSIG_MOB_EMOTE, TYPE_PROC_REF(/datum/status_effect/mkultra, snapping))
	return TRUE

/datum/status_effect/mkultra/proc/snapping(atom/source, datum/emote/emote_args) // For the forget command
	SIGNAL_HANDLER

	if(!enchanter)
		return
	if(get_dist(owner, enchanter) >= DEFAULT_VIEW_RANGE)
		return
	if(owner.stat == DEAD || !owner.client || owner.IsSleeping())
		return
	if(emote_args.key == "snap3")
		to_chat(owner, span_warning("一股来自[lewd ? get_gender() : enchanter]的掌控感冲刷过你的脑海，他们重新激活了你。"))
		to_chat(enchanter, span_notice("你打了三个响指，激活了[owner]！"))
		dormant = FALSE
		owner.throw_alert(id, alert_type)
		UnregisterSignal(enchanter, COMSIG_MOB_EMOTE)
