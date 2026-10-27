/// Space antagonist that murders everyone in space and nearby it using the power of loads of fire
/datum/antagonist/sunwalker
	name = "\improper 逐日者"
	antagpanel_category = ANTAG_GROUP_ABOMINATIONS
	pref_flag = ROLE_SUNWALKER

	show_in_antagpanel = TRUE
	antagpanel_category = "Voidwalker"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	ui_name = "AntagInfoSunwalker"
	suicide_cry = "为了太阳！！"

/datum/antagonist/sunwalker/greet()
	. = ..()
	owner.announce_objectives()

/datum/antagonist/sunwalker/on_gain()
	. = ..()

	forge_objectives()

/datum/antagonist/sunwalker/forge_objectives()
	var/datum/objective/sunwalker/objective = new
	objective.owner = owner
	objectives += objective

/datum/objective/sunwalker

/datum/objective/sunwalker/New()
	var/list/explanation_texts = list(
		"让他们学会畏惧虚空。用你的光辉吞没他们，然后传授自焚的真理。你要做的是毁灭，而非启迪。",
	)
	explanation_text = pick(explanation_texts)

	if(prob(5))
		explanation_text = "天哪，我真是太爱玻璃了。"
	..()

/datum/objective/sunwalker/check_completion()
	return owner.current.stat != DEAD
