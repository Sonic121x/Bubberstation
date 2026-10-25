/**
 * On use in hand, heals you over time and removes injury movement debuffs. Also makes you a bit sad.
 * On use when implanted, fully heals. Automatically fully heals if you would enter crit.
 */
/obj/item/organ/monster_core/regenerative_core
	name = "再生核心"
	desc = "虫巢领主残留下来的全部。可用于维持你的身体运作，但它会迅速腐坏至毫无用处。"
	desc_preserved = "虫巢领主残留下来的全部。它已被保存，你可以用它完全治愈自己而无需担心腐坏。"
	desc_inert = "虫巢领主残留下来的全部。它已经腐坏，完全无用。"
	user_status = /datum/status_effect/regenerative_core
	actions_types = list(/datum/action/cooldown/monster_core_action/regenerative_core)
	icon_state = "hivelord_core"
	icon_state_inert = "hivelord_core_decayed"

/obj/item/organ/monster_core/regenerative_core/preserve(implanted = FALSE)
	if (implanted)
		SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "implanted"))
	else
		SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "stabilizer"))
	return ..()

/obj/item/organ/monster_core/regenerative_core/go_inert()
	. = .. ()
	if (!.)
		return
	SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "inert"))

/obj/item/organ/monster_core/regenerative_core/on_life(seconds_per_tick)
	. = ..()
	if (owner.health <= owner.crit_threshold)
		trigger_organ_action(TRIGGER_FORCE_AVAILABLE)

/obj/item/organ/monster_core/regenerative_core/on_triggered_internal()
	owner.revive(HEAL_ALL & ~HEAL_REFRESH_ORGANS)
	qdel(src)

/// Log applications and apply moodlet.
/obj/item/organ/monster_core/regenerative_core/apply_to(mob/living/target, mob/user)
	target.add_mood_event("legion_core", /datum/mood_event/healsbadman)
	if (target != user)
		target.visible_message(span_notice("[user] 强行把 [src] 用在 [target] 身上……黑色触须将 [target] 缠绕并加固！"))
		SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "other"))
	else
		to_chat(user, span_notice("你开始把 [src] 涂抹在自己身上。恶心的触须把你拼合起来，让你得以继续行动，但还能撑多久呢？"))
		SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "self"))
	return ..()

/// Different graphics/desc for the lavaland legion
/obj/item/organ/monster_core/regenerative_core/legion
	desc = "一块噼啪作响、蕴含力量的奇特岩石。可用于完全治愈，但它会迅速腐坏至毫无用处。"
	desc_preserved = "核心已被稳定，你可以用它完全治愈自己而无需担心腐坏。"
	desc_inert = "核心已经腐坏，完全无用。"
	icon_state = "legion_core"
	icon_state_inert = "legion_core_decayed"
	icon_state_preserved = "legion_core_stable"

/// Action used by the regenerative core
/datum/action/cooldown/monster_core_action/regenerative_core
	name = "再生"
	desc = "完全再生你的身体，此过程会消耗你的再生核心。 \
		如果你身受重伤，此过程会自动触发。"
	button_icon_state = "legion_core_stable"
