/datum/heretic_knowledge/spell/paranoias_eye
	name = "妄念之眼"
	desc = "迫使附近的异信者产生幻觉，将周围所有人（包括你）看作危险的异教徒。完全掩盖身份，持续一分钟。（无需施法媒介）"
	gain_text = "敞开之路的耀眼光芒使他们失明。若非意志坚定，我也会失明。"
	drafting_tier = 1
	action_to_add = /datum/action/cooldown/spell/paranoias_eye

/datum/action/cooldown/spell/paranoias_eye
	name = "妄念之眼"
	desc = "迫使附近的异信者产生幻觉，将周围所有人（包括你）看作危险的异教徒。范围广且能穿墙，持续一分钟。（无需施法媒介）"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "gaze"
	cooldown_time = 2 MINUTES

	sound = null
	school = SCHOOL_EVOCATION
	antimagic_flags = MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND
	invocation_type = INVOCATION_NONE // sneaky spell
	spell_requirements = NONE
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS
	focusless_inhibitable = TRUE

/datum/action/cooldown/spell/paranoias_eye/cast(atom/cast_on)
	. = ..()

	for (var/mob/living/iter_living in get_hearers_in_range(20, owner)) // large range
		if (IS_HERETIC_OR_MONSTER(iter_living))
			continue
		if (iter_living.can_block_magic(antimagic_flags))
			to_chat(iter_living, span_warning("你感到一股邪异力量侵入心智却被弹开，不禁打了个寒战。"))
			iter_living.emote("shiver")
			continue
		iter_living.cause_hallucination(/datum/hallucination/delusion/paranoias_eye, "Heretic Hallucination Spell", duration = 1 MINUTES)
		iter_living.adjust_eye_blur_up_to(20 SECONDS, 30 SECONDS)
		to_chat(iter_living, span_hypnophrase("光从门缝中渗出。我的灵魂与肉身皆已失明。"))
	to_chat(owner, span_warning("你做出细微的秘符手势。通路已然敞开。"))

/datum/hallucination/delusion/paranoias_eye
	dynamic_delusion = TRUE
	random_hallucination_weight = 0
	affects_others = TRUE
	affects_us = FALSE
	delusion_name = "光芒使你失明。"

/datum/hallucination/delusion/paranoias_eye/make_delusion_image(mob/over_who)
	delusion_appearance = get_dynamic_human_appearance(
		outfit_path = /datum/outfit/heretic_hallucination,
		species_path = /datum/species/skeleton,
		bloody_slots = ALL,
	)
	return ..()

/datum/hallucination/delusion/paranoias_eye/start()
	. = ..()

	ADD_TRAIT(hallucinator, TRAIT_BLOCK_SECHUD, REF(src))
	ADD_TRAIT(hallucinator, TRAIT_PARANOIAS_EYE, REF(src))

/datum/hallucination/delusion/paranoias_eye/Destroy()
	REMOVE_TRAIT(hallucinator, TRAIT_PARANOIAS_EYE, REF(src))
	REMOVE_TRAIT(hallucinator, TRAIT_BLOCK_SECHUD, REF(src))
	return ..()
