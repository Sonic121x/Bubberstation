/**
 * Thoughtfeeding
 *
 * During the night, thoughtfeeding will reveal the person's exact role.
 */
/datum/mafia_ability/thoughtfeeder
	name = "噬思"
	ability_action = "吞噬"

/datum/mafia_ability/thoughtfeeder/perform_action_target(datum/mafia_controller/game, datum/mafia_role/day_target)
	. = ..()
	if(!.)
		return FALSE

	if((target_role.role_flags & ROLE_UNDETECTABLE))
		host_role.send_message_to_player(span_warning("[target_role.body.real_name] 的记忆显示，其身份是 [pick(game.all_roles - target_role)]。"))
	else
		host_role.send_message_to_player(span_warning("[target_role.body.real_name] 的记忆显示，其身份是 [target_role.name]。"))
	return TRUE
