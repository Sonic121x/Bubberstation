///Tracking reasons
/datum/antagonist/heretic_monster
	name = "\improper 邪异恐魔"
	roundend_category = "Heretics"
	antagpanel_category = ANTAG_GROUP_HORRORS
	antag_moodlet = /datum/mood_event/heretics
	pref_flag = ROLE_HERETIC
	antag_hud_name = "heretic_beast"
	suicide_cry = "我的主人正对我微笑！！"
	show_in_antagpanel = FALSE
	stinger_sound = 'sound/music/antag/heretic/heretic_gain.ogg'
	/// Our master (a heretic)'s mind.
	var/datum/mind/master

/datum/antagonist/heretic_monster/on_removal()
	if(!silent)
		if(master?.current)
			to_chat(master.current, span_warning("你的仆从[owner]的气息从你的脑海中淡去了。"))
		if(owner.current)
			to_chat(owner.current, span_deconversion_message("你的脑海开始变得模糊——[master ? "[master]不再是你的主人" : "你不再受主人支配"]，你自由了！"))
			owner.current.visible_message(span_deconversion_message("[owner.current]似乎挣脱了漫宿的枷锁！"), ignored_mobs = owner.current)

	master = null
	return ..()

/datum/antagonist/heretic_monster/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/target = mob_override || owner.current
	ADD_TRAIT(target, TRAIT_HERETIC_SUMMON, REF(src))

/datum/antagonist/heretic_monster/remove_innate_effects(mob/living/mob_override)
	var/mob/living/target = mob_override || owner.current
	REMOVE_TRAIT(target, TRAIT_HERETIC_SUMMON, REF(src))
	return ..()

/*
 * Set our [master] var to a new mind.
 */
/datum/antagonist/heretic_monster/proc/set_owner(datum/mind/master)
	src.master = master
	owner.enslave_mind_to_creator(master.current)

	var/datum/objective/master_obj = new()
	master_obj.owner = owner
	master_obj.explanation_text = "协助你的主人。"
	master_obj.completed = TRUE

	objectives += master_obj
	owner.announce_objectives()
	to_chat(owner, span_boldnotice("你是[ishuman(owner.current) ? "通过漫宿之门重返此位面的蹒跚尸体" : "通过漫宿之门来到此位面的恐怖造物"]。"))
	to_chat(owner, span_notice("你的主人是[master]。竭尽全力协助其达成目标。"))
