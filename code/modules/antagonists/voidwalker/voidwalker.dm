/// Space antagonist that harasses people near space and cursed them if they get the chance
/datum/antagonist/voidwalker
	name = "\improper 虚空行者"
	antagpanel_category = ANTAG_GROUP_ABOMINATIONS
	pref_flag = ROLE_VOIDWALKER

	show_in_antagpanel = TRUE
	antagpanel_category = "Voidwalker"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	ui_name = "AntagInfoVoidwalker"
	suicide_cry = "为了虚空！！"

/datum/antagonist/voidwalker/greet()
	. = ..()
	owner.announce_objectives()

/datum/antagonist/voidwalker/on_gain()
	. = ..()

	forge_objectives()

/datum/antagonist/voidwalker/get_preview_icon()
	var/mob/living/basic/voidwalker/walker_type = /mob/living/basic/voidwalker
	var/datum/universal_icon/icon = uni_icon(walker_type::icon, walker_type::icon_state)
	icon.crop(5, 18, 30, 44)
	return finish_preview_icon(icon)

/datum/antagonist/voidwalker/forge_objectives()
	var/datum/objective/voidwalker_objective/objective = new
	objective.owner = owner
	objectives += objective

/datum/objective/voidwalker_objective

/datum/objective/voidwalker_objective/New()
	var/list/explanation_texts = list(
		"向他们展示虚空之美。将他们拖入宇宙的深渊，然后把虚空的真理传授给他们。你要做的是启迪，而非毁灭。",
		"他们必须看见你所看见的。他们必须走上你所走过的路。把他们带到虚空中，向他们展示真理。死者无法知晓你所知晓的一切。",
		"寻回你失去的一切。把你的孩子们带进那浓墨般的黑暗，让他们重归你的族群。",
	)
	explanation_text = pick(explanation_texts)

	if(prob(5))
		explanation_text = "天哪，我真是太爱玻璃了。"
	..()

/datum/objective/voidwalker_objective/check_completion()
	return owner.current && owner.current.stat != DEAD
