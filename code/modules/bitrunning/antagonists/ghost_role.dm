/datum/antagonist/domain_ghost_actor
	name = "虚拟域角色"
	antagpanel_category = ANTAG_GROUP_GLITCH
	pref_flag = ROLE_GLITCH
	show_to_ghosts = TRUE
	suicide_cry = "致命错误"
	ui_name = "AntagInfoGlitch"

/datum/antagonist/domain_ghost_actor/on_gain()
	. = ..()
	owner.current.AddComponent(/datum/component/npc_friendly) //Just in case
	forge_objectives()

/datum/antagonist/domain_ghost_actor/forge_objectives()
	var/datum/objective/bitrunner_ghost_fluff/objective = new()
	objective.owner = owner
	objectives += objective

/datum/objective/bitrunner_ghost_fluff

/datum/objective/bitrunner_ghost_fluff/New()
	explanation_text = "保卫你的虚拟域，击退入侵者！"
