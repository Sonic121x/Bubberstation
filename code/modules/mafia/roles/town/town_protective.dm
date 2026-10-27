/datum/mafia_role/medical_doctor
	name = "医生"
	desc = "你每夜可以保护一人免遭杀害。你可以治疗自己一次。"
	revealed_outfit = /datum/outfit/mafia/md
	role_type = TOWN_PROTECT
	hud_icon = SECHUD_MEDICAL_DOCTOR
	revealed_icon = "medicaldoctor"
	winner_award = /datum/award/achievement/mafia/md

	role_unique_actions = list(/datum/mafia_ability/heal)

/datum/mafia_role/security_officer
	name = "安保官"
	desc = "你每夜可以保护一人。若其遭到袭击，你会反击，与袭击者同归于尽。你可以保护自己一次。"
	revealed_outfit = /datum/outfit/mafia/security
	revealed_icon = "securityofficer"
	hud_icon = SECHUD_SECURITY_OFFICER
	role_type = TOWN_PROTECT
	role_flags = ROLE_CAN_KILL
	winner_award = /datum/award/achievement/mafia/officer

	role_unique_actions = list(/datum/mafia_ability/heal/defend)
