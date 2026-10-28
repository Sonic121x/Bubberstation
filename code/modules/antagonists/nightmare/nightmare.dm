/datum/antagonist/nightmare
	name = "\improper 梦魇"
	antagpanel_category = ANTAG_GROUP_ABOMINATIONS
	pref_flag = ROLE_NIGHTMARE
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	ui_name = "AntagInfoNightmare"
	suicide_cry = "为了黑暗！！"
	preview_outfit = /datum/outfit/nightmare

/datum/antagonist/nightmare/greet()
	. = ..()
	owner.announce_objectives()

/datum/antagonist/nightmare/on_gain()
	forge_objectives()
	. = ..()
	owner.set_assigned_role(SSjob.get_job_type(/datum/job/nightmare))

/datum/antagonist/nightmare/apply_innate_effects(mob/living/mob_override)
	var/mob/living/nightmare = mob_override || owner.current
	nightmare.mob_mood.mood_modifier -= 1

/datum/antagonist/nightmare/remove_innate_effects(mob/living/mob_override)
	var/mob/living/nightmare = mob_override || owner.current
	nightmare.mob_mood.mood_modifier += 1

/datum/outfit/nightmare
	name = "梦魇（仅供预览）"

/datum/outfit/nightmare/post_equip(mob/living/carbon/human/human, visuals_only)
	human.set_species(/datum/species/shadow/nightmare)

/datum/objective/nightmare_fluff

/datum/objective/nightmare_fluff/New()
	var/list/explanation_texts = list(
		"吞噬空间站中最后一缕光芒。",
		"对白日行者降下审判。",
		"熄灭这片地狱景象中的火焰。",
		"揭示阴影的真实本质。",
		"自阴影之中，万物皆将消亡。",
		"以刀刃或火焰召来夜幕。",
		"将黑暗带到光明之中。"
	)
	explanation_text = pick(explanation_texts)
	..()

/datum/objective/nightmare_fluff/check_completion()
	return owner.current && owner.current.stat != DEAD

/datum/antagonist/nightmare/forge_objectives()
	var/datum/objective/nightmare_fluff/objective = new
	objective.owner = owner
	objectives += objective
