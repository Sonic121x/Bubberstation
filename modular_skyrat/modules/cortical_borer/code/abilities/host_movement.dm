//to either get inside, or out, of a host
/datum/action/cooldown/mob_cooldown/borer/choosing_host
	name = "寄宿/脱离宿主"
	cooldown_time = 10 SECONDS
	button_icon_state = "host"

/datum/action/cooldown/mob_cooldown/borer/choosing_host/Activate(atom/target)
	if(!owner.Adjacent(target))
		owner.balloon_alert(owner, "太远了")
		return FALSE
	if(!ishuman(target))
		owner.balloon_alert(owner, "不是人类")
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	cortical_owner.face_atom(target)
	if(!cortical_owner.try_enter_host(target))
		return FALSE
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/borer/choosing_host/pre_intercept_trigger(trigger_flags, atom/target)
	// Check if we already have a human_host
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.human_host)
		return TRUE
	if(cortical_owner.try_leave_host())
		StartCooldown()
	return FALSE
