/obj/item/organ/fangs
	name = "尖牙"
	desc = "硕大尖锐的牙齿，用来咬东西。"
	icon_state = "fangs"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_FANGS
	attack_verb_continuous = list("咀嚼", "咬", "啃咬", "啮咬", "撕咬")
	attack_verb_simple = list("咀嚼", "咬", "啃咬", "啮咬", "撕咬")
	organ_traits = list(TRAIT_REFINED_BITER)
	// Vars for improving the head limb's unarmed potential, which is how we apply our fangs as a weapon.
	// Low force for our bite
	var/bite_low = 4
	// High force for our bite.
	var/bite_high = 7
	// Bite effectivesnss, which improved accuracy and penetration.
	var/bite_effectiveness = 10
	// How much extra damage gained from biting a grabbed target.
	var/bite_pummeling_bonus = 0.5
	// The attack effect of our bite.
	var/bite_attack_effect = ATTACK_EFFECT_BITE
	// The sharpness of our bite.
	var/bite_sharpness = SHARP_EDGED

/obj/item/organ/fangs/on_bodypart_insert(obj/item/bodypart/head)
	. = ..()
	head.unarmed_damage_low += bite_low
	head.unarmed_damage_high += bite_high
	head.unarmed_effectiveness += bite_effectiveness
	head.unarmed_pummeling_bonus += bite_pummeling_bonus
	head.unarmed_attack_effect = bite_attack_effect
	head.unarmed_sharpness = bite_sharpness

/obj/item/organ/fangs/on_bodypart_remove(obj/item/bodypart/head)
	. = ..()
	head.unarmed_damage_low -= bite_low
	head.unarmed_damage_high -= bite_high
	head.unarmed_effectiveness -= bite_effectiveness
	head.unarmed_pummeling_bonus -= bite_pummeling_bonus
	head.unarmed_attack_effect = initial(head.unarmed_attack_effect)
	head.unarmed_sharpness = initial(head.unarmed_sharpness)

/obj/item/organ/fangs/cat
	name = "猫科尖牙"
	organ_traits = null
	actions_types = list(/datum/action/item_action/organ_action/go_feral)
	var/feral_mode = FALSE

/obj/item/organ/fangs/cat/on_bodypart_insert(obj/item/bodypart/head)
	. = ..()
	if(feral_mode)
		add_organ_trait(TRAIT_FERAL_BITER)

/obj/item/organ/fangs/cat/on_bodypart_remove(obj/item/bodypart/head)
	. = ..()
	remove_organ_trait(TRAIT_FERAL_BITER)

/obj/item/organ/fangs/cat/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	RegisterSignal(receiver, COMSIG_HUMAN_PUNCHED, PROC_REF(nommies))

/obj/item/organ/fangs/cat/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(organ_owner, COMSIG_HUMAN_PUNCHED)

/obj/item/organ/fangs/cat/proc/toggle_feral()
	feral_mode = !feral_mode
	if(feral_mode)
		add_organ_trait(TRAIT_FERAL_BITER)
	else
		remove_organ_trait(TRAIT_FERAL_BITER)

/obj/item/organ/fangs/cat/proc/nommies(mob/living/source, mob/living/target, damage, attack_type, atk_effect, obj/item/bodypart/affecting, final_armor_block, limb_sharpness)
	SIGNAL_HANDLER

	if(source != target && atk_effect == ATTACK_EFFECT_BITE && (target.mob_biotypes & MOB_ORGANIC)) //Good for you. You probably just ate someone alive.
		var/datum/reagents/tasty_meal = new()
		tasty_meal.add_reagent(/datum/reagent/consumable/nutriment/protein, round(damage/3, 1))
		tasty_meal.trans_to(source, tasty_meal.total_volume, transferred_by = source, methods = INGEST)

/obj/item/organ/fangs/lizard
	name = "蜥蜴尖牙"

/obj/item/organ/fangs/lizard/ash
	name = "腐化蜥蜴尖牙"
	bite_high = 12
	bite_effectiveness = 15
	bite_pummeling_bonus = 0.5

/obj/item/organ/fangs/cybernetic
	name = "机械尖牙"
	desc = "一组用塑钛制成的尖牙，极为致命。"
	icon_state = "fangs_cyber"
	organ_flags = ORGAN_ROBOTIC
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.25, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.5)
	bite_low = 9
	bite_high = 15
	bite_effectiveness = 15
	bite_pummeling_bonus = 0.5

/obj/item/organ/fangs/cat/cybernetic
	name = "机械猫科尖牙"
	desc = "一组用塑钛制成的尖牙，极为致命。看起来适合猫人使用。可能会让你觉得有点……野性难驯。"
	icon_state = "fangs_cyber_cat"
	organ_flags = ORGAN_ROBOTIC
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.25, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.5)
	bite_low = /obj/item/organ/fangs/cybernetic::bite_low
	bite_high = /obj/item/organ/fangs/cybernetic::bite_high
	bite_effectiveness = /obj/item/organ/fangs/cybernetic::bite_effectiveness
	bite_pummeling_bonus = /obj/item/organ/fangs/cybernetic::bite_pummeling_bonus

/obj/item/organ/fangs/cat/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	var/obj/item/organ/tongue/tongue_to_bite = owner?.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(tongue_to_bite)
		to_chat(owner, span_danger("你咬到了自己的舌头！"))
		tongue_to_bite.apply_organ_damage(bite_high)
