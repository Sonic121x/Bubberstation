/// Max number of atoms a broom can sweep at once
#define BROOM_PUSH_LIMIT 20

/obj/item/pushbroom
	name = "推扫帚"
	desc = "这是我的扫帚棍！它既可以直接使用，也可以双手握持，让你在移动时清扫物品。它配有可伸缩的手柄，便于紧凑收纳。"
	icon = 'icons/obj/service/janitor.dmi'
	icon_state = "broom0"
	base_icon_state = "broom"
	icon_angle = 135
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	force = 8
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("扫过", "拂去", "重砸", "猛抽")
	attack_verb_simple = list("扫", "拂", "砸", "抽")
	resistance_flags = FLAMMABLE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	// BUBBER EDIT ADDITION START - implanted broom variant
	/// How many items this broom can move in one sweep
	var/push_limit = BROOM_PUSH_LIMIT
	/// Skips the two handed grip and leaves sweeping to the subtype
	var/always_braced = FALSE
	// BUBBER EDIT ADDITION END

/obj/item/pushbroom/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/jousting, damage_boost_per_tile = 1)
	if(!always_braced) // BUBBER EDIT ADDITION - implanted broom variant
		AddComponent(/datum/component/two_handed, \
			force_unwielded = 8, \
			force_wielded = 12, \
			icon_wielded = "[base_icon_state]1", \
			wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
			unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
		)
	AddComponent(/datum/component/walking_aid)

/obj/item/pushbroom/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/**
 * Handles registering the sweep proc when the broom is wielded
 *
 * Arguments:
 * * source - The source of the on_wield proc call
 * * user - The user which is wielding the broom
 */
/obj/item/pushbroom/proc/on_wield(obj/item/source, mob/user)
	to_chat(user, span_notice("你将[src]抵住地面，摆出稳健的清扫姿势。"))
	RegisterSignal(user, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(sweep))

/**
 * Handles unregistering the sweep proc when the broom is unwielded
 *
 * Arguments:
 * * source - The source of the on_unwield proc call
 * * user - The user which is unwielding the broom
 */
/obj/item/pushbroom/proc/on_unwield(obj/item/source, mob/user)
	UnregisterSignal(user, COMSIG_MOVABLE_PRE_MOVE)

/obj/item/pushbroom/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	sweep(user, interacting_with)
	return NONE // I guess

/**
 * Attempts to push up to push_limit atoms from a given location the user's faced direction // BUBBER EDIT
 *
 * Arguments:
 * * user - The user of the pushbroom
 * * A - The atom which is located at the location to push atoms from
 */
/obj/item/pushbroom/proc/sweep(mob/user, atom/atom)
	SIGNAL_HANDLER

	do_sweep(src, user, atom, user.dir, push_limit) // BUBBER EDIT CHANGE - ORIGINAL: do_sweep(src, user, atom, user.dir)

/**
* Sweep objects in the direction we're facing towards our direction
* Arguments
* * broomer - The object being used for brooming
* * user - The person who is brooming
* * target - The object or tile that's target of a broom click or being moved into
* * sweep_dir - The directions in which we sweep objects
* * push_limit - How many items we can move at once // BUBBER EDIT
*/
/proc/do_sweep(obj/broomer, mob/user, atom/target, sweep_dir, push_limit = BROOM_PUSH_LIMIT) // BUBBER EDIT CHANGE - ORIGINAL: /proc/do_sweep(obj/broomer, mob/user, atom/target, sweep_dir)
	var/turf/current_item_loc = isturf(target) ? target : target.loc
	if (!isturf(current_item_loc))
		return
	var/turf/new_item_loc = get_step(current_item_loc, sweep_dir)

	var/list/items_to_sweep = list()
	var/i = 1
	for (var/obj/item/garbage in current_item_loc.contents)
		if(garbage.anchored)
			continue
		items_to_sweep += garbage
		i++
		if(i > push_limit) // BUBBER EDIT CHANGE - ORIGINAL: if(i > BROOM_PUSH_LIMIT)
			break

	SEND_SIGNAL(new_item_loc, COMSIG_TURF_RECEIVE_SWEEPED_ITEMS, broomer, user, items_to_sweep)

	if(!length(items_to_sweep))
		return

	for (var/obj/item/garbage in items_to_sweep)
		garbage.Move(new_item_loc, sweep_dir)

	playsound(current_item_loc, 'sound/items/weapons/thudswoosh.ogg', 30, TRUE, -1)

#undef BROOM_PUSH_LIMIT
