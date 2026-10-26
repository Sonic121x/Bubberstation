/obj/item/reagent_containers/venom_milker
	name = "\improper 毒液抽取器"
	desc = "一台商用毒液抽取器，适用于较大型、通常为人类体型的动物。\
	内置试剂中和器，可抑制大部分抽取毒素的作用以便安全处理，但不能保证始终有效。"

	icon_state = "venom_milker"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'

	volume = 20

	initial_reagent_flags = OPENCONTAINER
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/venom_milker/Initialize(mapload)
	. = ..()

	var/filter_immune_string = /datum/preference/choiced/aphrodisiacal_bite_venom::filter_immune_string
	if (length(filter_immune_string))
		desc += span_notice("\n中和器无法过滤以下试剂：[filter_immune_string]")

/obj/item/reagent_containers/venom_milker/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()

	if (!can_milk(target_mob, user))
		return FALSE

	playsound(user, 'sound/effects/compressed_air/tank_insert_clunky.ogg', 50)
	user.balloon_alert_to_viewers("正在抽取……")

	var/text = span_purple("[user] 开始将 [src] 接到 [target_mob] 的毒牙上……")
	var/self_text = span_purple("你开始将 [src] 接到 [target_mob] 的毒牙上……")
	var/victim_text = span_purple("[user] 开始将 [src] 接到你的毒牙上……")

	user.visible_message(text, self_text, ignored_mobs = target_mob)
	to_chat(target_mob, victim_text)

	if (!do_after(user, 3 SECONDS, target_mob, IGNORE_HELD_ITEM, extra_checks = CALLBACK(src, PROC_REF(can_milk), target_mob, user)))
		return FALSE
	playsound(user, 'sound/effects/compressed_air/tank_remove_thunk.ogg', 50)

	siphon(target_mob, user)

	return TRUE

/**
 *
 * Checks if we can milk the target. Returns TRUE/FALSE.
 *
 * Args:
 * * mob/living/target: The target. Non-nullable.
 * * mob/living/user: The user. Nullable.
 * * silent = FALSE: If TRUE, will not give user any feedback.
 */
/obj/item/reagent_containers/venom_milker/proc/can_milk(mob/living/target, mob/living/user, silent = FALSE)
	var/datum/action/cooldown/mob_cooldown/aphrodisiacal_bite/bite = locate() in target.actions
	if (isnull(bite))
		if (!silent)
			user?.balloon_alert(user, "没有毒牙！")
		return FALSE
	if (!bite.IsAvailable())
		if (!silent)
			user?.balloon_alert(user, "毒牙已无毒液！")
		return FALSE
	if (reagents.holder_full())
		if (!silent)
			user?.balloon_alert(user, "抽取器已满！")
		return FALSE

	if (iscarbon(user))
		var/mob/living/carbon/carbon_target = target
		if (carbon_target.is_mouth_covered())
			if (!silent)
				user.balloon_alert(user, "嘴被遮住了！")
			return FALSE

	return TRUE

/**
 *
 * The actual siphon proc. Triggers the bite's effect, and puts its reagents in the milker.
 *
 * Args:
 * * mob/living/target: The target. Non-nullable.
 * * mob/living/user: The user. Nullable.
 *
 */
/obj/item/reagent_containers/venom_milker/proc/siphon(mob/living/target, mob/living/user)
	if (!can_milk(target, user))
		return FALSE
	var/datum/action/cooldown/mob_cooldown/aphrodisiacal_bite/bite = locate() in target.actions
	if (isnull(bite))
		return FALSE

	bite.StartCooldown()
	bite.add_reagents(reagents, TRUE)

	if (!isnull(user))
		user.balloon_alert_to_viewers("已抽取")
		var/text = span_purple("[user] 用 [src] 从 [target] 的毒牙中抽取了毒液！")
		var/self_text = span_purple("你用 [src] 从 [target] 的毒牙中抽取了毒液！")
		var/victim_text = span_purple("[user] 用 [src] 从你的毒牙中抽取了毒液！")

		user.visible_message(text, self_text, ignored_mobs = target)
		to_chat(target, victim_text)

	return TRUE

/**
 * If a reagent milked from someone with the venom quirk is NOT in /datum/preference/choiced/aphrodisiacal_bite_venom::milkable_venoms, it will be transformed into this
 * generic chem that has no effects.
 */
/datum/reagent/generic_milked_venom
	name = "已中和毒液"
	description = "毒液抽取器能削弱从生物体内抽取的大部分毒素。\
	这些毒素的效果通常会减弱，除非经过漫长的恢复过程。"
