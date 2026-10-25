/**
 * Stabilising serum prevents monster organs from decaying before you can use them.
 */
/obj/item/mining_stabilizer
	name = "稳定血清"
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "bottle19"
	desc = "将这种稳定剂注入特定种类的怪物器官，可防止其迅速腐坏。"
	w_class = WEIGHT_CLASS_TINY

/obj/item/mining_stabilizer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isorgan(interacting_with))
		return NONE
	var/obj/item/organ/monster_core/target_core = interacting_with
	if (!istype(target_core))
		balloon_alert(user, "目标无效！")
		return ITEM_INTERACT_BLOCKING

	if (!target_core.preserve())
		balloon_alert(user, "器官已腐坏！")
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "器官已稳定")
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/**
 * Useful organs which drop as loot from a mining creature.
 * Generalised behaviour is that they will decay and become useless unless provided with serum.
 * These should usually do something both when used in-hand, or when implanted into someone.
 */
/obj/item/organ/monster_core
	name = "怪物核心"
	desc = "一只怪物残留下来的全部。这件抽象物品不应自然生成。 \
		它会迅速腐坏至毫无用处。不过别担心，因为它本来就没用。"
	icon = 'icons/obj/medical/organs/mining_organs.dmi'
	icon_state = "hivelord_core"
	actions_types = list(/datum/action/cooldown/monster_core_action)

	item_flags = NOBLUDGEON
	slot = ORGAN_SLOT_MONSTER_CORE
	organ_flags = ORGAN_ORGANIC
	force = 0
	/// Set to true if this organ has decayed into uselessness.
	var/inert = FALSE
	/// ID of the timer which will decay this organ
	var/decay_timer
	/// Time after which organ should become useless
	var/time_to_decay = 4 MINUTES
	/// Icon state to apply when preserved
	var/icon_state_preserved
	/// Description to use once organ has been preserved
	var/desc_preserved
	/// Icon state to apply when inert
	var/icon_state_inert
	/// Description to use once organ is inert
	var/desc_inert
	/// Status effect applied by this organ
	var/datum/status_effect/user_status

/obj/item/organ/monster_core/Initialize(mapload)
	. = ..()
	decay_timer = addtimer(CALLBACK(src, PROC_REF(go_inert)), time_to_decay, TIMER_STOPPABLE)
	AddElement(/datum/element/above_mob_drop)

/obj/item/organ/monster_core/examine(mob/user)
	. = ..()
	if(!decay_timer)
		return
	var/estimated_time_left = round(timeleft(decay_timer), 1 MINUTES)
	switch(estimated_time_left)
		if(4 MINUTES)
			. += span_notice("它很新鲜，仍带着生命最后残迹的搏动。")
		if(3 MINUTES)
			. += span_notice("看上去仍然相当新鲜。")
		if(2 MINUTES)
			. += span_notice("它已经不那么新鲜了。")
		if(1 MINUTES)
			. += span_notice("腐坏的迹象开始显现。它恐怕撑不了多久了。")
		if(0 SECONDS to 1 MINUTES)
			. += span_warning("腐坏迹象已经出现，但看上去仍有生机。它大概很快就会彻底不能用了。")

/obj/item/organ/monster_core/Destroy(force)
	deltimer(decay_timer)
	return ..()

/obj/item/organ/monster_core/on_mob_insert(mob/living/carbon/target_carbon, special = FALSE, movement_flags)
	. = ..()

	if (inert)
		to_chat(target_carbon, span_notice("[src] 在你试图植入时崩解了。"))
		qdel(src)
		return FALSE
	if (!decay_timer)
		return TRUE
	preserve(TRUE)
	target_carbon.visible_message(span_notice("[src] 在植入后稳定了下来。"))
	return TRUE

/obj/item/organ/monster_core/on_mob_remove(mob/living/carbon/target_carbon, special, movement_flags)
	if (!inert && !special)
		target_carbon?.visible_message(span_notice("[src] 在取出后迅速腐坏了。"))
		go_inert()
	return ..()

/**
 * Preserves the organ so that it will not decay.
 * Returns true if successful.
 * * Implanted - If true, organ has just been inserted into someone.
 */
/obj/item/organ/monster_core/proc/preserve(implanted = FALSE)
	if (inert)
		return FALSE
	deltimer(decay_timer)
	decay_timer = null
	update_appearance()
	return TRUE

/**
 * Decays the organ, it is now useless.
 */
/obj/item/organ/monster_core/proc/go_inert()
	if (inert)
		return FALSE
	inert = TRUE
	deltimer(decay_timer)
	decay_timer = null
	name = "腐坏的 [name]"
	update_appearance()
	return TRUE

/obj/item/organ/monster_core/update_desc()
	if (inert)
		desc = desc_inert ? desc_inert : initial(desc)
		return ..()
	if (!decay_timer)
		desc = desc_preserved ? desc_preserved : initial(desc)
		return ..()
	desc = initial(desc)
	return ..()

/obj/item/organ/monster_core/update_icon_state()
	if (inert)
		icon_state = icon_state_inert ? icon_state_inert : initial(icon_state)
		return ..()
	if (!decay_timer)
		icon_state = icon_state_preserved ? icon_state_preserved : initial(icon_state)
		return ..()
	icon_state = initial(icon_state)
	return ..()

/obj/item/organ/monster_core/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE

	try_apply(interacting_with, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/organ/monster_core/attack_self(mob/user)
	if (!user.can_perform_action(src, FORBID_TELEKINESIS_REACH|ALLOW_RESTING))
		return
	try_apply(user, user)

/**
 * Tries to apply organ effect to target.
 * Usually you should not need to override this, only apply_to.
 * Arguments
 * * target - Person you are applying this to.
 * * user - Person who is doing the applying.
 */
/obj/item/organ/monster_core/proc/try_apply(atom/target, mob/user)
	if (!isliving(target))
		balloon_alert(user, "目标无效！")
		return
	if (inert)
		balloon_alert(user, "器官已腐坏！")
		return
	var/mob/living/live_target = target
	if (live_target.stat == DEAD)
		balloon_alert(user, "目标已死亡！")
		return
	balloon_alert(user, "已应用器官")
	apply_to(target, user)

/**
 * Applies the effect of this organ to the target.
 * Arguments
 * * target - Person you are applying this to.
 * * user - Person who is doing the applying.
 */
/obj/item/organ/monster_core/proc/apply_to(mob/living/target, mob/user)
	if (user_status)
		target.apply_status_effect(user_status)
	qdel(src)

/**
 * Utility proc to find the associated monster organ action and trigger it.
 * Call this instead of on_triggered_internal() if the action needs to trigger automatically, or the cooldown won't happen.
 */
/obj/item/organ/monster_core/proc/trigger_organ_action(trigger_flags)
	var/datum/action/cooldown/monster_core_action/action = locate() in actions
	action?.Trigger(trigger_flags = trigger_flags)

/**
 * Called when activated while implanted inside someone.
 * This could be via clicking the associated action button or through the above method.
 */
/obj/item/organ/monster_core/proc/on_triggered_internal()
	SHOULD_CALL_PARENT(FALSE)
	CRASH("Someone forgot to make their organ do something when you implant it.")

/obj/item/organ/monster_core/feel_for_damage(self_aware)
	return ""

/**
 * Boilerplate to set the name and icon of the cooldown action.
 * Makes it call 'ui_action_click' when the action is activated.
 */
/datum/action/cooldown/monster_core_action
	check_flags = AB_CHECK_CONSCIOUS
	button_icon = 'icons/obj/medical/organs/mining_organs.dmi'
	button_icon_state = "hivelord_core_2"

/datum/action/cooldown/monster_core_action/Activate(trigger_flags)
	. = ..()
	if (!target)
		return
	var/obj/item/organ/monster_core/organ = target
	if (!istype(organ))
		return
	organ.on_triggered_internal()
