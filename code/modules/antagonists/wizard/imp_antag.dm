/**
 * ## Imps
 *
 * Imps used to be summoned by a devil ascending to their final form, but now they're just
 * kinda sitting in limbo... Well, whatever! They're kinda cool anyways!
 */
/datum/antagonist/imp
	name = "\improper 小恶魔"
	show_in_antagpanel = FALSE
	show_in_roundend = FALSE
	ui_name = "AntagInfoDemon"
	antagpanel_category = ANTAG_GROUP_WIZARDS

/datum/antagonist/imp/on_gain()
	. = ..()
	give_objectives()

/datum/antagonist/imp/proc/give_objectives()
	var/datum/objective/newobjective = new
	newobjective.explanation_text = "试着晋升到更高的恶魔阶级。"
	newobjective.owner = owner
	objectives += newobjective

/datum/antagonist/imp/ui_static_data(mob/user)
	var/list/data = list()
	data["fluff"] = "你是一只小恶魔，由凝固的罪孽构成的低等存在，被召唤来为地狱的等级体系效力。"
	data["objectives"] = get_objectives()
	return data
