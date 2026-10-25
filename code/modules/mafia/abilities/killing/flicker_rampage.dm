/**
 * Flicker/Rampage
 *
 * During the night, turns the lights off in a player's house.
 * If they visit someone with the lights off again, they will kill all players they previously visited.
 */
/datum/mafia_ability/flicker_rampage
	name = "闪烁／狂暴"
	ability_action = "尝试袭击或使房间变暗"
	action_priority = COMSIG_MAFIA_NIGHT_KILL_PHASE

	///List of all players in the dark, which we can rampage.
	var/list/datum/mafia_role/darkened_players = list()

/datum/mafia_ability/flicker_rampage/New(datum/mafia_role/host_role)
	. = ..()
	RegisterSignal(host_role, COMSIG_MAFIA_ON_KILL, PROC_REF(flickering_immunity))

/datum/mafia_ability/flicker_rampage/perform_action_target(datum/mafia_controller/game, datum/mafia_role/day_target)
	. = ..()
	if(!.)
		return FALSE

	if(!(target_role in darkened_players))
		target_role.send_message_to_player(span_userdanger("灯光开始闪烁并变暗。你身处险境。"))
		darkened_players += target_role
	else
		for(var/datum/mafia_role/dead_players as anything in darkened_players)
			dead_players.send_message_to_player(span_userdanger("一个阴暗的身影从黑暗中浮现！"))
			dead_players.kill(game, host_role, FALSE)
			darkened_players -= dead_players
	return TRUE

/datum/mafia_ability/flicker_rampage/proc/flickering_immunity(datum/source,datum/mafia_controller/game,datum/mafia_role/attacker,lynch)
	SIGNAL_HANDLER
	if(!attacker)
		return //no chance man, that's a town lynch

	if(attacker in darkened_players)
		host_role.send_message_to_player(span_userdanger("你在闪烁的房间里遭到了袭击。你在阴影中起舞，躲过了对方。"))
		return MAFIA_PREVENT_KILL

