/**
 * Autopsy
 *
 * During the night, choose someone to check their role.
 */
/datum/mafia_ability/autopsy
	name = "尸检"
	ability_action = "解剖"
	use_flags = CAN_USE_ON_OTHERS|CAN_USE_ON_DEAD

/datum/mafia_ability/autopsy/perform_action_target(datum/mafia_controller/game, datum/mafia_role/day_target)
	. = ..()
	if(!.)
		return FALSE

	to_chat(host_role.body, span_warning("你对 [target_role.body.real_name] 的尸检报告 \
		显示其身份是 <b>[target_role.name]<b>。"))
	return TRUE
