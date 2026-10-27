// A type of antagonist created by the moon ascension
/datum/antagonist/lunatic
	name = "\improper 月狂者"
	hijack_speed = 0
	antagpanel_category = ANTAG_GROUP_HORRORS
	show_in_antagpanel = FALSE
	suicide_cry = "赞美头目！！"
	antag_moodlet = /datum/mood_event/heretics/lunatic
	antag_hud_name = "lunatic"
	can_assign_self_objectives = FALSE
	hardcore_random_bonus = FALSE
	// The mind of the ascended heretic who created us
	var/datum/mind/ascended_heretic
	// The body of the ascended heretic who created us
	var/mob/living/carbon/human/ascended_body
	// Our objective
	var/datum/objective/lunatic/lunatic_obj
	// Actions granted by this datum, tracked for proper cleanup on body transfer
	var/datum/action/cooldown/lunatic_track/moon_track
	var/datum/action/cooldown/spell/touch/mansus_grasp/mad_touch

/datum/antagonist/lunatic/on_gain()
	owner.current.log_message("成为了月狂者！", LOG_ATTACK, color="red")
	// Masters gain an objective before so we dont want duplicates
	. = ..()
	for(var/objective in objectives)
		if(!istype(objective, /datum/objective/lunatic))
			continue
		return ..()
	var/datum/objective/lunatic/loony = new()
	objectives += loony
	lunatic_obj = loony
	moon_track = new(owner)
	mad_touch = new(owner)
	mad_touch.Grant(owner.current)
	moon_track.Grant(owner.current)

/datum/antagonist/lunatic/on_removal()
	QDEL_NULL(moon_track)
	QDEL_NULL(mad_touch)
	return ..()

/datum/antagonist/lunatic/on_removal()
	owner?.current?.log_message("失去了月狂者身份！", LOG_ATTACK, color="red")
	return ..()

/// Runs when the moon heretic creates us, used to give the lunatic a master
/datum/antagonist/lunatic/proc/set_master(datum/mind/heretic_master, mob/living/carbon/human/heretic_body)
	src.ascended_heretic = heretic_master
	src.ascended_body = heretic_body

	lunatic_obj.master = heretic_master
	lunatic_obj.update_explanation_text()

	to_chat(owner, span_boldnotice("毁灭谎言，通过服从头目[heretic_master]来拯救真相！"))

/datum/antagonist/lunatic/apply_innate_effects(mob/living/mob_override)
	var/mob/living/our_mob = mob_override || owner.current
	handle_clown_mutation(our_mob, "来自月亮的古老知识让你克服了小丑天性，使你能够使用武器而不伤害自己。")
	our_mob.add_faction(FACTION_HERETIC)
	add_team_hud(our_mob, /datum/antagonist/lunatic)
	ADD_TRAIT(our_mob, TRAIT_MADNESS_IMMUNE, REF(src))

/datum/antagonist/lunatic/remove_innate_effects(mob/living/mob_override)
	var/mob/living/our_mob = mob_override || owner.current
	handle_clown_mutation(our_mob, removing = FALSE)
	our_mob.remove_faction(FACTION_HERETIC)
	REMOVE_TRAIT(our_mob, TRAIT_MADNESS_IMMUNE, REF(src))

// Mood event given to moon acolytes
/datum/mood_event/heretics/lunatic
	description = "真相已显，谎言已灭。"
	mood_change = 10

/datum/objective/lunatic
	explanation_text = "协助你的头目。如果你看到这段文字，请向上翻聊天记录确认头目是谁，并报告此问题"
	var/datum/mind/master
	// If the person with this objective is a lunatic master
	var/is_master = FALSE

/datum/objective/lunatic/update_explanation_text()
	. = ..()
	if(is_master)
		explanation_text = "率领你的月狂者们推进你自己的目标！"
		return
	explanation_text = "协助你的头目[master]，不要伤害其他月狂者"

// Lunatic master
/datum/antagonist/lunatic/master
	name = "\improper 头目"
	antag_hud_name = "lunatic_master"

/datum/antagonist/lunatic/master/on_gain()
	var/datum/objective/lunatic/loony = new()
	objectives += loony
	loony.is_master = TRUE
	loony.update_explanation_text()
	return ..()

/datum/antagonist/lunatic/master/apply_innate_effects(mob/living/mob_override)
	var/mob/living/our_mob = mob_override || owner.current
	add_team_hud(our_mob, /datum/antagonist/lunatic)

/datum/antagonist/lunatic/master/remove_innate_effects(mob/living/mob_override)
	return
