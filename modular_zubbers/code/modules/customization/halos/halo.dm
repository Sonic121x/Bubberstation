/obj/item/organ/halo
	name = "光环"
	desc = "一种无实体的光之图样，在主人头顶上方显现。它无法被触摸，也没有任何可感知的物理体积，当主人失去意识时会逐渐消散。除此之外，它的本质仍是个谜。"
	mutantpart_key = "halo"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Messenger Halo", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_HALO
	organ_flags = ORGAN_EXTERNAL | ORGAN_UNREMOVABLE
	bodypart_overlay = /datum/bodypart_overlay/mutant/halo

/obj/item/organ/halo/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	RegisterSignals(organ_owner, list(SIGNAL_ADDTRAIT(TRAIT_KNOCKEDOUT), SIGNAL_REMOVETRAIT(TRAIT_KNOCKEDOUT)), PROC_REF(on_consciousness_change))

/obj/item/organ/halo/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(organ_owner, list(SIGNAL_ADDTRAIT(TRAIT_KNOCKEDOUT), SIGNAL_REMOVETRAIT(TRAIT_KNOCKEDOUT)))

// knockedout covers sleep, knockouts, hard crit and death, so this one pair catches every fade and return
/obj/item/organ/halo/proc/on_consciousness_change(mob/living/carbon/source)
	SIGNAL_HANDLER

	source.update_body_parts()

/datum/bodypart_overlay/mutant/halo
	feature_key = "halo"
	layers = list(EXTERNAL_FRONT = BODY_FRONT_LAYER, EXTERNAL_BEHIND = BODY_BEHIND_LAYER)
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/halo/override_color(rgb_value)
	return draw_color

// halos always glow
/datum/bodypart_overlay/mutant/halo/build_emissive_eligibility(list/emissive_eligibility)
	emissive_eligibility_by_color_index = list(TRUE)

/datum/bodypart_overlay/mutant/halo/color_images(list/image/overlays, obj/item/bodypart/limb, layer_index)
	. = ..()
	if(sprite_datum?.color_src)
		return
	for(var/image/overlay as anything in overlays)
		overlay.color = null

// the halo only manifests while its owner is conscious
/datum/bodypart_overlay/mutant/halo/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner)
	var/mob/living/carbon/halo_owner = owner || bodypart_owner.owner
	if(halo_owner && IS_UNCONSCIOUS(halo_owner))
		return FALSE
	return ..()
