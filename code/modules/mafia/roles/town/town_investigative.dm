/datum/mafia_role/detective
	name = "侦探"
	desc = "你每夜可以调查一人，得知其所属阵营。"
	revealed_outfit = /datum/outfit/mafia/detective
	role_type = TOWN_INVEST
	winner_award = /datum/award/achievement/mafia/detective

	hud_icon = SECHUD_DETECTIVE
	revealed_icon = "detective"

	role_unique_actions = list(/datum/mafia_ability/investigate)

/datum/mafia_role/psychologist
	name = "心理医生"
	desc = "你每局可以探访某人一次，在次日早晨揭露其真实身份！"
	revealed_outfit = /datum/outfit/mafia/psychologist
	role_type = TOWN_INVEST
	winner_award = /datum/award/achievement/mafia/psychologist

	hud_icon = SECHUD_PSYCHOLOGIST
	revealed_icon = "psychologist"

	role_unique_actions = list(/datum/mafia_ability/reveal_role)

/datum/mafia_role/coroner
	name = "法医"
	desc = "你每夜可以对死者进行尸检，查明其身份。"
	revealed_outfit = /datum/outfit/mafia/coroner
	role_type = TOWN_INVEST
	hud_icon = SECHUD_CORONER
	revealed_icon = "coroner"
	winner_award = /datum/award/achievement/mafia/coroner

	role_unique_actions = list(/datum/mafia_ability/autopsy)
