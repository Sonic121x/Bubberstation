/**
 * Investigate
 *
 * During the night, Investigating will reveal the person's faction.
 */
/datum/mafia_ability/investigate
	name = "调查"
	ability_action = "调查"

/datum/mafia_ability/investigate/perform_action_target(datum/mafia_controller/game, datum/mafia_role/day_target)
	. = ..()
	if(!.)
		return FALSE

	var/fluff = "一名空间站成员，或者非常擅长伪装。"
	if(!(target_role.role_flags & ROLE_UNDETECTABLE))
		switch(target_role.team)
			if(MAFIA_TEAM_MAFIA)
				fluff = "一个毫无感情、面目可憎的变形怪！"
			if(MAFIA_TEAM_SOLO)
				fluff = "一个独行者，有着自己的目标……"

	host_role.send_message_to_player(span_warning("你的调查显示 [target_role.body.real_name] 是[fluff]"))
	return TRUE
