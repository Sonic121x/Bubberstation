/datum/antagonist/pyro_slime
	name = "\improper 火山碎屑异常"
	antagpanel_category = ANTAG_GROUP_ABOMINATIONS
	show_in_roundend = FALSE
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	pref_flag = ROLE_PYROCLASTIC_SLIME

/datum/antagonist/pyro_slime/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/pyro_slime/greet()
	. = ..()
	owner.announce_objectives()

/datum/objective/pyro_slime
	explanation_text = "我是火焰。我是饥饿。寒冷即是痛苦。生者的脉搏中涌动着能量，他们的温暖滋养着我。死者只是躯壳，余烬早已熄灭。水即是死亡。火焰……火焰即是自由。"

/datum/objective/pyro_slime/check_completion()
	return owner.current && owner.current.stat != DEAD

/datum/antagonist/pyro_slime/forge_objectives()
	var/datum/objective/pyro_slime/objective = new
	objective.owner = owner
	objectives += objective
