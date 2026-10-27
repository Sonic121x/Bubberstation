/datum/action/cooldown/mob_cooldown/meteors
	name = "陨石雨"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"
	desc = "让陨石如雨般落在你的周围。"
	cooldown_time = 3 SECONDS

/datum/action/cooldown/mob_cooldown/meteors/Activate(atom/target_atom)
	disable_cooldown_actions()
	create_meteors(target_atom)
	StartCooldown()
	enable_cooldown_actions()
	return TRUE

/datum/action/cooldown/mob_cooldown/meteors/proc/create_meteors(atom/target)
	if(!target)
		return
	target.visible_message(span_boldwarning("烈焰从天而降！"))
	var/turf/targetturf = get_turf(target)
	for(var/turf/turf as anything in RANGE_TURFS(9,targetturf))
		if(prob(11))
			new /obj/effect/temp_visual/target(turf)
