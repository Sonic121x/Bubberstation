/datum/mafia_role/mafia
	name = "变形怪"
	desc = "你是变形怪巢群的一员。在夜晚阶段交谈以与盟友协调行动，并杀死所有非变形怪。"
	team = MAFIA_TEAM_MAFIA
	role_type = MAFIA_REGULAR
	role_flags = ROLE_CAN_KILL
	hud_icon = "hudchangeling"
	revealed_icon = "changeling"
	winner_award = /datum/award/achievement/mafia/changeling

	revealed_outfit = /datum/outfit/mafia/changeling
	special_ui_theme = "syndicate"
	win_condition = "人数超过镇民并成为多数，且没有任何独行杀手能阻止他们。"

	role_unique_actions = list(/datum/mafia_ability/changeling_kill)

/datum/mafia_role/mafia/New(datum/mafia_controller/game)
	. = ..()
	RegisterSignal(game, COMSIG_MAFIA_SUNDOWN, PROC_REF(mafia_text))

/datum/mafia_role/mafia/proc/mafia_text(datum/mafia_controller/source)
	SIGNAL_HANDLER

	to_chat(body, "<b>投票决定今晚要杀谁。杀手将从投票者中随机选出。</b>")

/datum/mafia_role/mafia/thoughtfeeder
	name = "噬思者"
	desc = "你是以他人记忆为食的变形怪变体。在夜晚阶段交谈以与盟友协调行动，\
		并杀死所有非变形怪，善用你探查他人职业的能力。"
	role_type = MAFIA_SPECIAL
	hud_icon = "hudthoughtfeeder"
	winner_award = /datum/award/achievement/mafia/thoughtfeeder

	role_unique_actions = list(/datum/mafia_ability/changeling_kill, /datum/mafia_ability/thoughtfeeder)
