/mob/living/carbon/proc/protean_main_ui()
	var/datum/species/protean/species = dna.species
	if(!istype(species))
		return
	species.ui_interact(src)

/mob/living/carbon/proc/protean_heal()
	var/obj/item/organ/brain/protean/brain = get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(brain))
		return

	var/datum/species/protean/species = dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	if(incapacitated && loc != suit)
		balloon_alert(src, "无法行动！")
		return

	brain.replace_limbs()

/mob/living/carbon/proc/lock_suit()
	var/datum/species/protean/species = dna.species

	if(!istype(species))
		return

	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	species.species_modsuit.toggle_lock()
	to_chat(src, span_notice("你<b>[suit.modlocked ? "锁定" : "解锁"]</b>了外骨骼[isprotean(suit.wearer) || loc == suit ? "" : "，将其固定在 [suit.wearer] 身上"]"))
	playsound(src, 'sound/machines/click.ogg', 25)

/mob/living/carbon/proc/suit_transformation(forced = FALSE)
	var/obj/item/organ/brain/protean/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		return
	var/datum/species/protean/species = dna.species
	if(loc == species.species_modsuit)
		brain.leave_modsuit()
	else if(isturf(loc))
		if(!incapacitated)
			brain.go_into_suit(forced)
		else
			balloon_alert(src, "无法行动！")

/mob/living/carbon/proc/low_power()
	var/datum/species/protean/species = dna.species
	if(!istype(species))
		return
	var/obj/item/organ/stomach/protean/stomach = get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach))
		to_chat(src, span_warning("你缺少胃，无法开启低功率模式"))
		return
	if(loc == species.species_modsuit)
		to_chat(src, span_notice("处于外骨骼形态时无法切换低功率模式！"))
		return
	if(!do_after(src, 2.5 SECONDS)) // Long enough to where our stomach can process inbetween activations
		src.loc.balloon_alert(src, "切换被打断")
		return
	var/datum/status_effect/protean_low_power_mode/effect = /datum/status_effect/protean_low_power_mode/low_power
	if(istype(has_status_effect(effect), effect))
		remove_status_effect(effect)
	else
		if(species.species_modsuit.active)
			species.species_modsuit.toggle_activate(usr, TRUE)
		// Preventing low power slowdown being removed by reform cooldown
		if(has_status_effect(/datum/status_effect/protean_low_power_mode))
			remove_status_effect(/datum/status_effect/protean_low_power_mode)
		apply_status_effect(effect)

