#define VENOMOUS_BITE_DAMAGE 5
#define VENOMOUS_BITE_WOUND_CHANCE 20
#define VENOMOUS_BITE_WOUND_BONUS 40

/datum/action/cooldown/mob_cooldown/venomous_bite
	name = "注入毒液"
	desc = "用尖牙咬住他人，注入你的毒液。对穿戴护甲的人无效。"

	button_icon = 'modular_zubbers/icons/mob/actions/quirks/venomous_bite.dmi'
	button_icon_state = "venom"

	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_pickturf.dmi'

	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED | AB_CHECK_HANDS_BLOCKED // cant use it if cuffed

	/// The reagent we will inject.
	var/datum/reagent/reagent_typepath
	/// How much of [reagent_typepath] we will inject.
	var/to_inject = 0

/datum/action/cooldown/mob_cooldown/venomous_bite/New(Target, original, datum/reagent/our_reagent, quantity_override = null)
	. = ..()
	set_reagent(our_reagent, quantity_override)

/datum/action/cooldown/mob_cooldown/venomous_bite/proc/set_reagent(datum/reagent/new_reagent, quantity_override = null, cooldown_override = null)
	reagent_typepath = new_reagent
	var/list/reagent_spec = /datum/preference/choiced/venomous_bite_venom::venomous_bite_choice_specs[new_reagent]
	to_inject = quantity_override || reagent_spec[1]
	cooldown_time = cooldown_override || reagent_spec[2]

/datum/action/cooldown/mob_cooldown/venomous_bite/set_click_ability(mob/on_who)
	. = ..()
	if (!.)
		return
	owner.visible_message(span_warning("[owner]露出了尖牙……"), span_notice("你露出了尖牙……"))

/datum/action/cooldown/mob_cooldown/venomous_bite/Activate(atom/target_atom)
	if (!isliving(target_atom))
		return FALSE

	if (astype(owner, /mob/living/carbon)?.is_mouth_covered())
		owner.balloon_alert(owner, "嘴部被遮住了！")
		return FALSE

	if (!owner.Adjacent(target_atom))
		owner.balloon_alert(owner, "太远了！")
		return FALSE

	if (target_atom == owner)
		owner.balloon_alert(owner, "不能咬自己！")
		return FALSE

	log_combat(owner, target_atom, "started to bite", null, "with venom: [reagent_typepath::name]")
	owner.visible_message(span_warning("[owner]开始咬[target_atom]！"), span_warning("你开始咬[target_atom]！"), ignored_mobs = target_atom)
	to_chat(target_atom, span_userdanger("[owner]开始咬你！"))
	owner.balloon_alert_to_viewers("咬住……")
	if (!do_after(owner, 0.5 SECONDS, target_atom, IGNORE_HELD_ITEM))
		return FALSE

	. = ..()

	if (try_bite(target_atom))
		inject(target_atom)
	return TRUE

/// Does NOT inject reagents; represents the initial bite. Can end in your teeth being broken by armor. Dumbass.
/datum/action/cooldown/mob_cooldown/venomous_bite/proc/try_bite(mob/living/target)
	PRIVATE_PROC(TRUE)
	var/target_zone = check_zone(owner.zone_selected)
	var/armor = target.run_armor_check(target_zone, MELEE)
	var/obj/item/bodypart/part = target.get_bodypart(target_zone)

	var/text = "[owner]将尖牙刺入[target]的[chinese_body_zone_display(target.parse_zone_with_bodypart(target_zone))]！"
	var/self_message = "你将尖牙刺入[target]的[chinese_body_zone_display(target.parse_zone_with_bodypart(target_zone))]！"
	var/victim_message = "[owner]将尖牙刺入你的[chinese_body_zone_display(target.parse_zone_with_bodypart(target_zone))]！"

	var/covered = FALSE
	if (ishuman(target))
		for (var/obj/item/clothing/iter_clothing as anything in astype(target, /mob/living/carbon/human).get_clothing_on_part(part))
			if (iter_clothing.clothing_flags & THICKMATERIAL)
				covered = TRUE
				text = "[owner]试图咬[target]，却被[target]的衣物崩断了牙！哎哟！"
				self_message = "你试图咬[target]，却被对方的衣物崩断了牙！哎哟！"
				victim_message = "[owner]试图咬你，却被你的衣物崩断了牙！哎哟！"
				owner.emote("scream")
				astype(owner, /mob/living)?.apply_damage(1, BRUTE, BODY_ZONE_HEAD)
				break

	owner.visible_message(span_warning(text), span_warning(self_message), ignored_mobs = list(target))
	to_chat(target, span_userdanger(victim_message))

	owner.do_attack_animation(target, ATTACK_EFFECT_BITE)
	playsound(owner, 'sound/items/weapons/bite.ogg', 60, TRUE)
	if (covered)
		return FALSE
	var/wound_bonus = prob(VENOMOUS_BITE_WOUND_CHANCE) ? VENOMOUS_BITE_WOUND_BONUS : 0
	target.apply_damage(VENOMOUS_BITE_DAMAGE, BRUTE, target_zone, armor, wound_bonus = wound_bonus, sharpness = SHARP_POINTY)
	log_combat(owner, target, "successfully bit", null, "with venom: [reagent_typepath::name]")
	if (iscarbon(owner))
		var/mob/living/carbon/carbon_owner = owner
		for (var/datum/disease/our_disease as anything in carbon_owner.diseases)
			if ((our_disease.spread_flags & DISEASE_SPREAD_CONTACT_FLUIDS) || (our_disease.spread_flags & DISEASE_SPREAD_CONTACT_SKIN))
				target.ContactContractDisease(our_disease, target_zone)

		if (iscarbon(target))
			var/mob/living/carbon/carbon_target = target
			for (var/datum/disease/their_disease as anything in carbon_target.diseases)
				if ((their_disease.spread_flags & DISEASE_SPREAD_CONTACT_FLUIDS) || (their_disease.spread_flags & DISEASE_SPREAD_CONTACT_SKIN))
					carbon_owner.ContactContractDisease(their_disease, target_zone)
	return TRUE

/datum/action/cooldown/mob_cooldown/venomous_bite/proc/inject(mob/living/target)
	if (!target.try_inject(owner, check_zone(owner.zone_selected)))
		return FALSE

	add_reagents(target.reagents)
	return TRUE

/datum/action/cooldown/mob_cooldown/venomous_bite/proc/add_reagents(datum/reagents/target)
	var/temp = astype(owner, /mob/living/carbon/human)?.coretemperature
	var/datum/reagent/local_typepath = reagent_typepath

	target.add_reagent(local_typepath, to_inject, reagtemp = temp)
	return TRUE

#undef VENOMOUS_BITE_DAMAGE
#undef VENOMOUS_BITE_WOUND_BONUS
#undef VENOMOUS_BITE_WOUND_CHANCE
