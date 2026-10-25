/datum/mafia_role/hos
	name = "安保主管"
	desc = "你可以在夜间决定处决某人，将其杀死并揭露其身份。如果对方是无辜者，你将在下一夜开始时死亡。"
	role_type = TOWN_KILLING
	role_flags = ROLE_CAN_KILL | ROLE_UNIQUE
	revealed_outfit = /datum/outfit/mafia/hos
	revealed_icon = "headofsecurity"
	hud_icon = SECHUD_HEAD_OF_SECURITY
	winner_award = /datum/award/achievement/mafia/hos

	role_unique_actions = list(/datum/mafia_ability/attack_player/execution)

/datum/mafia_role/warden
	name = "典狱长"
	desc = "你可以在夜间封锁一次，杀死所有来访者，包括镇民。"

	role_type = TOWN_KILLING
	role_flags = ROLE_CAN_KILL
	revealed_outfit = /datum/outfit/mafia/warden
	revealed_icon = "warden"
	hud_icon = SECHUD_WARDEN
	winner_award = /datum/award/achievement/mafia/warden

	role_unique_actions = list(/datum/mafia_ability/attack_visitors)
