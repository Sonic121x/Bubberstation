/datum/mafia_role/traitor
	name = "叛徒"
	desc = "你是一名独行叛徒。你对夜间击杀免疫，每夜都能杀人，并以人数超过其他所有人为胜利条件。"
	win_condition = "杀光所有人。"
	team = MAFIA_TEAM_SOLO
	role_type = NEUTRAL_KILL
	role_flags = ROLE_CAN_KILL
	winner_award = /datum/award/achievement/mafia/traitor
	revealed_outfit = /datum/outfit/mafia/traitor
	revealed_icon = "traitor"
	hud_icon = "hudtraitor"
	special_ui_theme = "neutral"

	role_unique_actions = list(/datum/mafia_ability/attack_player)

/datum/mafia_role/traitor/New(datum/mafia_controller/game)
	. = ..()
	RegisterSignal(src, COMSIG_MAFIA_ON_KILL, PROC_REF(nightkill_immunity))

/datum/mafia_role/traitor/proc/nightkill_immunity(datum/source,datum/mafia_controller/game,datum/mafia_role/attacker,lynch)
	SIGNAL_HANDLER

	if(game.phase == MAFIA_PHASE_NIGHT && !lynch)
		to_chat(body,span_userdanger("你遭到了袭击，但想放倒你还得更努力些。"))
		return MAFIA_PREVENT_KILL

/datum/mafia_role/nightmare
	name = "梦魇"
	desc = "你是一只无法被侦探类职业侦测到的独行怪物。每夜你可以让另一个房间的灯光闪烁，从而免疫这些职业的攻击。你也可以选择狩猎，杀光闪烁房间里的所有人。杀光所有人即可获胜。"
	win_condition = "杀光所有人。"
	revealed_outfit = /datum/outfit/mafia/nightmare
	role_flags = ROLE_UNDETECTABLE | ROLE_CAN_KILL
	team = MAFIA_TEAM_SOLO
	role_type = NEUTRAL_KILL
	special_ui_theme = "neutral"
	hud_icon = "hudnightmare"
	revealed_icon = "nightmare"
	winner_award = /datum/award/achievement/mafia/nightmare

	role_unique_actions = list(/datum/mafia_ability/flicker_rampage)

/datum/mafia_role/nightmare/special_reveal_equip()
	body.set_species(/datum/species/shadow)
	body.update_body()
