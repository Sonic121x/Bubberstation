/datum/action/cooldown/bloodsucker/targeted/trespass
	name = "化雾穿行"
	desc = "化作迷雾，朝一个方向前进两格。适合越过门和路障。"
	button_icon_state = "power_tres"
	bloodsucker_check_flags = BP_CANT_USE_IN_TORPOR
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	bloodcost = 10
	cooldown_time = 8 SECONDS
	prefire_message = "选择目的地。"
	target_range = 2
	var/turf/target_turf // We need to decide where we're going based on where we clicked. It's not actually the tile we clicked.

/datum/action/cooldown/bloodsucker/targeted/trespass/get_power_explanation_extended()
	. = list()
	. += "点击[target_range]格范围内的位置即可传送。"
	. += "此能力可以穿过除墙壁外的所有障碍物。"
	. += "等级越高，使用时的声音越小，传送速度越快。"
	. += "传送需要[DisplayTimeText(GetTeleportDelay())]。"

/datum/action/cooldown/bloodsucker/targeted/trespass/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	if(HAS_TRAIT(user, TRAIT_NO_TRANSFORM) || !get_turf(user))
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/trespass/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	// Can't target my tile
	if(target_atom == get_turf(owner) || get_turf(target_atom) == get_turf(owner))
		return FALSE
	return TRUE // All we care about is destination. Anything you click is fine.

/datum/action/cooldown/bloodsucker/targeted/trespass/CheckCanTarget(atom/target_atom)
	// NOTE: Do NOT use ..()! We don't want to check distance or anything.

	// Get clicked tile
	var/final_turf = isturf(target_atom) ? target_atom : get_turf(target_atom)

	// Are either tiles WALLS?
	var/turf/from_turf = get_turf(owner)
	var/this_dir // = get_dir(from_turf, target_turf)
	for(var/i = 1 to 2)
		// Keep Prev Direction if we've reached final turf
		if(from_turf != final_turf)
			this_dir = get_dir(from_turf, final_turf) // Recalculate dir so we don't overshoot on a diagonal.
		from_turf = get_step(from_turf, this_dir)
		// ERROR! Wall!
		if(iswallturf(from_turf))
			var/wallwarning = (i == 1) ? "路径上" : "目的地"
			owner.balloon_alert(owner, "[wallwarning]有墙壁")
			return FALSE
	// Done
	target_turf = from_turf

	return TRUE

/datum/action/cooldown/bloodsucker/targeted/trespass/FireTargetedPower(atom/target, params)
	. = ..()

	// Find target turf, at or below Atom
	var/mob/living/carbon/user = owner
	var/turf/my_turf = get_turf(owner)

	user.visible_message(
		span_warning("[user]的身形消散成一团迷雾！"),
		span_notice("你消散成无形的迷雾。"),
	)
	// Effect Origin
	var/sound_strength = max(60, 70 - level_current * 10)
	playsound(get_turf(owner), 'sound/effects/magic/summon_karp.ogg', sound_strength, 1)
	do_smoke(3, FALSE, my_turf, smoke_type = /obj/effect/particle_effect/fluid/smoke/vampsmoke)

	var/mist_delay = GetTeleportDelay() // Level up and do this faster.

	// Freeze Me
	user.Stun(mist_delay, ignore_canstun = TRUE)
	user.density = FALSE
	var/invis_was = user.invisibility
	user.invisibility = INVISIBILITY_MAXIMUM

	// Wait...
	sleep(mist_delay / 2)
	// Move & Freeze
	if(isturf(target_turf))
		do_teleport(owner, target_turf, no_effects=TRUE, channel = TELEPORT_CHANNEL_QUANTUM) // in teleport.dm?
	user.Stun(mist_delay / 2, ignore_canstun = TRUE)

	// Wait...
	sleep(mist_delay / 2)
	// Un-Hide & Freeze
	user.dir = get_dir(my_turf, target_turf)
	user.Stun(mist_delay / 2, ignore_canstun = TRUE)
	user.density = 1
	user.invisibility = invis_was
	// Effect Destination
	playsound(get_turf(owner), 'sound/effects/magic/summon_karp.ogg', 60, 1)
	do_smoke(3, FALSE, target_turf, smoke_type = /obj/effect/particle_effect/fluid/smoke/vampsmoke)

/datum/action/cooldown/bloodsucker/targeted/trespass/proc/GetTeleportDelay()
	return max(5, 20 - level_current * 2.5)
