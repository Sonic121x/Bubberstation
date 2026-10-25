/datum/mutation/aoe_moodlet
	name = "奇丑无比"
	desc = "受试者的身体，尤其是面容，丑陋得异乎寻常，令周围的人感到不适。\
		佩戴面具可以减弱效果。"
	quality = NEGATIVE
	instability = NEGATIVE_STABILITY_MINI
	text_gain_indication = span_warning("你觉得自己有一种独特的美。")
	text_lose_indication = span_notice("你不再那么在意自己的外表了。")
	difficulty = 12

/datum/mutation/aoe_moodlet/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	if(!.)
		return
	RegisterSignal(acquirer, COMSIG_ATOM_EXAMINE, PROC_REF(on_examined))
	RegisterSignal(acquirer, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))

/datum/mutation/aoe_moodlet/on_losing(mob/living/carbon/human/owner)
	. = ..()
	if(.)
		return
	UnregisterSignal(owner, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

/datum/mutation/aoe_moodlet/proc/on_examined(datum/source, mob/examiner, ...)
	SIGNAL_HANDLER

	if(examiner == owner || !isliving(examiner) || HAS_TRAIT(owner, TRAIT_FACE_COVERED))
		return
	apply_other_moodlet(examiner)

/datum/mutation/aoe_moodlet/proc/on_moved(datum/source, ...)
	SIGNAL_HANDLER

	var/obj/structure/mirror/mirror = locate() in owner.loc
	if(isnull(mirror))
		return
	apply_own_moodlet()

/datum/mutation/aoe_moodlet/on_life(seconds_per_tick)
	if(HAS_TRAIT(owner, TRAIT_FACE_COVERED))
		return // this is applied by newspapers, and i think it would be funny if newspapers specifically blocked 100% of the effect.

	for(var/mob/living/nearby in viewers(3, owner))
		if(nearby == owner)
			continue
		apply_other_moodlet(nearby)

/datum/mutation/aoe_moodlet/proc/apply_own_moodlet()
	owner.add_mood_event(type, /datum/mood_event/seen_ugly_mutation/self, owner)

/datum/mutation/aoe_moodlet/proc/apply_other_moodlet(mob/living/other)
	other.add_mood_event(type, get_moodlet(), owner)

/datum/mutation/aoe_moodlet/proc/get_moodlet()
	return (owner.obscured_slots & HIDEFACE) ? /datum/mood_event/seen_ugly_mutation/weak : /datum/mood_event/seen_ugly_mutation

/datum/mutation/aoe_moodlet/positive
	name = "貌美非凡"
	desc = "受试者的身体，尤其是面容，美丽得异乎寻常，令周围的人心情愉悦。\
		佩戴面具可以减弱效果。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MINOR
	text_gain_indication = span_notice("你觉得自己有一种独特的美。")
	text_lose_indication = span_notice("你不再那么在意自己的外表了。")
	difficulty = 12

/datum/mutation/aoe_moodlet/positive/apply_own_moodlet()
	owner.add_mood_event(type, /datum/mood_event/seen_pretty_mutation/self, owner)

/datum/mutation/aoe_moodlet/positive/get_moodlet()
	return (owner.obscured_slots & HIDEFACE) ? /datum/mood_event/seen_pretty_mutation/weak : /datum/mood_event/seen_pretty_mutation

// Negative version
/datum/mood_event/seen_ugly_mutation
	description = "那家伙看起来太不对劲了！"
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/seen_ugly_mutation/can_effect_mob(datum/mood/home, mob/living/who, ...)
	if(HAS_PERSONALITY(who, /datum/personality/compassionate) || HAS_PERSONALITY(who, /datum/personality/empathetic))
		return FALSE

	return ..()

/datum/mood_event/seen_ugly_mutation/add_effects(mob/mutant)
	description = "[mutant || "那家伙"]看起来太不对劲了！"

/datum/mood_event/seen_ugly_mutation/weak
	description = "那家伙看起来有点不对劲。"
	mood_change = -1

/datum/mood_event/seen_ugly_mutation/weak/add_effects(mob/mutant)
	description = "[mutant || "那家伙"]看起来有点不对劲。"

/datum/mood_event/seen_ugly_mutation/self
	description = "……我居然长这样？！"
	mood_change = -2
	timeout = 5 MINUTES

// Positive version
/datum/mood_event/seen_pretty_mutation
	description = "那个人真好看——肯定是换了新发型之类的。"
	mood_change = 3
	timeout = 2 MINUTES

/datum/mood_event/seen_pretty_mutation/can_effect_mob(datum/mood/home, mob/living/who, ...)
	if(HAS_PERSONALITY(who, /datum/personality/misanthropic) || HAS_PERSONALITY(who, /datum/personality/callous))
		return FALSE

	return ..()

/datum/mood_event/seen_pretty_mutation/add_effects(mob/mutant)
	description = "[mutant || "那个人"]真好看——肯定是换了新发型之类的。"

/datum/mood_event/seen_pretty_mutation/weak
	description = "那个人看着还不错——一定是这里的灯光衬托得好。"
	mood_change = 1

/datum/mood_event/seen_pretty_mutation/weak/add_effects(mob/mutant)
	description = "[mutant || "那个人"]看着还不错——一定是这里的灯光衬托得好。"

/datum/mood_event/seen_pretty_mutation/self
	description = "我真好看！"
	mood_change = 2
	timeout = 5 MINUTES
