//Augmented Eyesight: Gives you X-ray vision or protection from flashes. Also, high DNA cost because of how powerful it is.
//Possible todo: make a custom message for directing a penlight/flashlight at the eyes - not sure what would display though.

/datum/action/changeling/augmented_eyesight
	name = "强化视觉"
	desc = "在我们的眼中生成更多感光杆状细胞，使我们的视线能够穿透大多数遮挡物。\
		在未激活时保护我们的视觉免受闪光影响。"
	helptext = "赋予我们 X 光视觉或闪光防护。\
		当 X 光视觉激活时，我们会更容易受到闪光装置的伤害。"
	button_icon_state = "augmented_eyesight"
	category = "utility"
	chemical_cost = 0
	dna_cost = 2
	// Active = Flash weakness and x-ray
	// Inactive = Flash protection and no x-ray
	active = FALSE

/datum/action/changeling/augmented_eyesight/on_purchase(mob/user) //The ability starts inactive, so we should be protected from flashes.
	. = ..()
	var/obj/item/organ/eyes/ling_eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	RegisterSignal(user, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(eye_implanted))
	RegisterSignal(user, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(eye_removed))
	if(!isnull(ling_eyes))
		ling_eyes.flash_protect = FLASH_PROTECTION_WELDER //Adjust the user's eyes' flash protection
		to_chat(user, span_changeling("我们调整双眼，以保护它们免受强光伤害。"))

/datum/action/changeling/augmented_eyesight/sting_action(mob/living/carbon/user)
	if(!istype(user))
		return FALSE

	var/obj/item/organ/eyes/ling_eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(isnull(ling_eyes))
		user.balloon_alert(user, "没有眼睛！")
		return FALSE

	..()

	if(active)
		active = FALSE
		REMOVE_TRAIT(user, TRAIT_XRAY_VISION, REF(src))
		ling_eyes.flash_protect = max(ling_eyes.flash_protect += 3, FLASH_PROTECTION_WELDER)
		to_chat(user, span_changeling("我们调整双眼，以保护它们免受强光伤害。"))

	else
		active = TRUE
		ADD_TRAIT(user, TRAIT_XRAY_VISION, REF(src))
		ling_eyes.flash_protect = max(ling_eyes.flash_protect += -3, FLASH_PROTECTION_HYPER_SENSITIVE)
		to_chat(user, span_changeling("我们调整双眼，以便穿透墙壁感知猎物。"))

	user.update_sight()
	return TRUE

/datum/action/changeling/augmented_eyesight/Remove(mob/user)
	var/obj/item/organ/eyes/ling_eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(!isnull(ling_eyes))
		ling_eyes.flash_protect = initial(ling_eyes.flash_protect)

	REMOVE_TRAIT(user, TRAIT_XRAY_VISION, REF(src))
	user.update_sight()

	UnregisterSignal(user, list(COMSIG_CARBON_GAIN_ORGAN, COMSIG_CARBON_LOSE_ORGAN))
	return ..()

/// Signal proc to grant the correct level of flash sensitivity
/datum/action/changeling/augmented_eyesight/proc/eye_implanted(mob/living/source, obj/item/organ/gained, special)
	SIGNAL_HANDLER

	var/obj/item/organ/eyes/ling_eyes = gained
	if(!istype(ling_eyes))
		return
	if(active)
		ling_eyes.flash_protect = max(ling_eyes.flash_protect += -3, FLASH_PROTECTION_HYPER_SENSITIVE)
	else
		ling_eyes.flash_protect = max(ling_eyes.flash_protect += 3, FLASH_PROTECTION_WELDER)

/// Signal proc to remove flash sensitivity when the eyes are removed
/datum/action/changeling/augmented_eyesight/proc/eye_removed(mob/living/source, obj/item/organ/removed, special)
	SIGNAL_HANDLER

	var/obj/item/organ/eyes/ling_eyes = removed
	if(!istype(ling_eyes))
		return
	ling_eyes.flash_protect = initial(ling_eyes.flash_protect)
	// We don't need to bother about removing or adding x-ray vision, fortunately, because they can't see anyways
