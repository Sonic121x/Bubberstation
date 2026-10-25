/datum/mafia_role/fugitive
	name = "逃犯"
	desc = "你正在逃亡。你可以使用两次背心，在当夜免疫一切伤害，并以与任何人一起存活到游戏结束为胜利条件。"
	win_condition = "与任何人一起存活到游戏结束"
	revealed_outfit = /datum/outfit/mafia/fugitive
	team = MAFIA_TEAM_SOLO
	role_type = NEUTRAL_DISRUPT
	special_ui_theme = "neutral"
	hud_icon = "hudfugitive"
	revealed_icon = "fugitive"
	winner_award = /datum/award/achievement/mafia/fugitive

	role_unique_actions = list(/datum/mafia_ability/vest)

/datum/mafia_role/fugitive/New(datum/mafia_controller/game)
	. = ..()
	RegisterSignal(game, COMSIG_MAFIA_GAME_END, PROC_REF(survived))

/datum/mafia_role/fugitive/proc/survived(datum/mafia_controller/game)
	SIGNAL_HANDLER

	if(game_status == MAFIA_ALIVE)
		game.award_role(winner_award, src)
		game.send_message("<span class='big comradio'>！！逃犯胜利！！</span>")
