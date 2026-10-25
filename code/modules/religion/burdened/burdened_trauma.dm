///Burdened grants some mutations upon injuring yourself sufficiently
/datum/brain_trauma/special/burdened
	name = "自笞强迫症"
	desc = "患者感到被强迫以各种致残而骇人的方式伤害自己。\
		在顺从这些强迫行为的过程中，似乎有一种奇特的基因“序列”正逐渐表达出来。"
	scan_desc = "额叶受损"
	symptoms = "会经历难以抑制的自残冲动，常做出导致严重身体伤害的行为。\
		这种冲动源于一种强烈的心理需求——渴望感受痛苦与折磨，\
		并相信通过这种自我伤害，自己能更深刻地理解宇宙真理与存在的本质。"
	gain_text = span_notice("你感到负担加身！")
	lose_text = span_warning("你不再有加负于自己的冲动！")
	random_gain = FALSE
	/// goes from 0 to 9 (but can be beyond 9, just does nothing) and gives rewards. increased by disabling yourself with debuffs
	var/burden_level = 0
	/// Static list of organ slots that add burden when lost
	var/static/list/burden_organ_slots = list(
		ORGAN_SLOT_BRAIN,
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_TONGUE,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
	)

/datum/brain_trauma/special/burdened/on_gain()
	RegisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(organ_added_burden))
	RegisterSignal(owner, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(organ_removed_burden))

	RegisterSignal(owner, COMSIG_CARBON_ATTACH_LIMB, PROC_REF(limbs_added_burden))
	RegisterSignal(owner, COMSIG_CARBON_REMOVE_LIMB, PROC_REF(limbs_removed_burden))

	RegisterSignal(owner, COMSIG_CARBON_GAIN_ADDICTION, PROC_REF(addict_added_burden))
	RegisterSignal(owner, COMSIG_CARBON_LOSE_ADDICTION, PROC_REF(addict_removed_burden))

	RegisterSignal(owner, COMSIG_CARBON_GAIN_MUTATION, PROC_REF(mutation_added_burden))
	RegisterSignal(owner, COMSIG_CARBON_LOSE_MUTATION, PROC_REF(mutation_removed_burden))

	RegisterSignal(owner, COMSIG_CARBON_GAIN_TRAUMA, PROC_REF(trauma_added_burden))
	RegisterSignal(owner, COMSIG_CARBON_LOSE_TRAUMA, PROC_REF(trauma_removed_burden))

	for (var/burden_slot in burden_organ_slots)
		if (!owner.get_organ_slot(burden_slot) && is_burdensome_organ(owner, burden_slot, null, FALSE))
			update_burden(TRUE, silent = TRUE)

	var/list/missing_limbs = owner.get_missing_limbs()
	for (var/i in 1 to length(missing_limbs) + length(owner.mind?.active_addictions))
		update_burden(TRUE, silent = TRUE)

	if (owner.dna)
		for (var/datum/mutation/mutation in owner.dna.mutations)
			if (mutation.quality == NEGATIVE)
				update_burden(TRUE, silent = TRUE)

	for (var/datum/brain_trauma/severe/trauma in owner.get_traumas())
		update_burden(TRUE, silent = TRUE)

	return ..()

/datum/brain_trauma/special/burdened/on_lose()
	UnregisterSignal(owner, list(
		COMSIG_CARBON_GAIN_ORGAN,
		COMSIG_CARBON_LOSE_ORGAN,
		COMSIG_CARBON_ATTACH_LIMB,
		COMSIG_CARBON_REMOVE_LIMB,
		COMSIG_CARBON_GAIN_ADDICTION,
		COMSIG_CARBON_LOSE_ADDICTION,
		COMSIG_CARBON_GAIN_MUTATION,
		COMSIG_CARBON_LOSE_MUTATION,
		COMSIG_CARBON_GAIN_TRAUMA,
		COMSIG_CARBON_LOSE_TRAUMA,
	))

	for (var/i in 1 to burden_level)
		update_burden(FALSE, silent = TRUE)

	return ..()

/**
 * Called by hooked signals whenever burden_level var needs to go up or down by 1.
 * Sends messages on burden level, gives powers and takes them if needed, etc
 *
 * Arguments:
 * * increase: whether to tick burden_level up or down 1
 * * silent: if TRUE, this does not print out any to_chats
 */
/datum/brain_trauma/special/burdened/proc/update_burden(increase, silent = FALSE)
	var/datum/dna/dna = owner?.dna
	if(!dna)
		qdel(src)
		return
	//adjust burden
	burden_level = increase ? burden_level + 1 : burden_level - 1
	if(burden_level < 0)
		burden_level = 0
	//send a message and handle rewards
	switch(burden_level)
		if(0)
			if (!silent)
				to_chat(owner, span_warning("你感觉肩上毫无重量。你感受不到 [GLOB.deity] 的苦难。"))
		if(1)
			if (!silent)
				if(increase)
					to_chat(owner, span_notice("你开始感觉到 [GLOB.deity] 身上的伤疤。你必须继续给自己加负。"))
				else
					to_chat(owner, span_warning("肩上的重量似乎轻了些。你几乎感受不到 [GLOB.deity] 的苦难了。"))
		if(2)
			if(increase)
				if (!silent)
					to_chat(owner, span_notice("你对 [GLOB.deity] 的理解已经颇有进展。你即将迎来一次突破。"))
			else
				if (!silent)
					to_chat(owner, span_warning("肩上的重量似乎轻了些。你失去了一些宇宙真理。"))
				dna.remove_mutation(/datum/mutation/telepathy, MUTATION_SOURCE_BURDENED_TRAUMA)
				dna.remove_mutation(/datum/mutation/unintelligible, MUTATION_SOURCE_BURDENED_TRAUMA)
				owner.remove_filter("burden_outline")
		if(3)
			if(increase)
				if (!silent)
					to_chat(owner, span_notice("你的苦难只是 [GLOB.deity] 的一小部分，然而宇宙真理正逐渐向你显现。"))
				dna.add_mutation(/datum/mutation/telepathy, MUTATION_SOURCE_BURDENED_TRAUMA)
				dna.add_mutation(/datum/mutation/unintelligible, MUTATION_SOURCE_BURDENED_TRAUMA)
				owner.add_filter("burden_outline", 9, list("type" = "outline", "color" = "#6c6eff"))
			else
				if (!silent)
					to_chat(owner, span_warning("肩上的重量似乎轻了些。你觉得自己快要忘记了。"))
		if(4)
			if (!silent)
				if(increase)
					to_chat(owner, span_notice("很痛，每一分痛苦都是一则教诲。[GLOB.deity] 是如何承受这份重量的？"))
				else
					to_chat(owner, span_warning("肩上的重量似乎轻了些。你离目标越来越远了。"))
		if(5)
			if(increase)
				if (!silent)
					to_chat(owner, span_notice("你的身体是一幅写满失去的画布。你即将迎来一次突破。"))
			else
				if (!silent)
					to_chat(owner, span_warning("肩上的重量似乎轻了些。你失去了一些宇宙真理。"))
				dna.remove_mutation(/datum/mutation/telekinesis, MUTATION_SOURCE_BURDENED_TRAUMA)
				dna.remove_mutation(/datum/mutation/mindreader, MUTATION_SOURCE_BURDENED_TRAUMA)
		if(6)
			if(increase)
				if (!silent)
					to_chat(owner, span_notice("你的苦难充满敬意，你的伤疤完美无瑕。更多宇宙真理变得清晰，但你仍未完全理解。"))
				dna.add_mutation(/datum/mutation/telekinesis, MUTATION_SOURCE_BURDENED_TRAUMA)
				dna.add_mutation(/datum/mutation/mindreader, MUTATION_SOURCE_BURDENED_TRAUMA)
			else
				if (!silent)
					to_chat(owner, span_warning("肩上的重量似乎轻了些。你觉得自己快要忘记了。"))
		if(7)
			if (!silent)
				if(increase)
					to_chat(owner, span_notice("你肩上的重量无比巨大。[GLOB.deity] 已碎裂散落于宇宙各处。"))
				else
					to_chat(owner, span_warning("肩上的重量似乎轻了些。你离目标越来越远了。"))
		if(8)
			if (!silent)
				if(increase)
					to_chat(owner, span_notice("你正处在又一次突破的边缘。[GLOB.deity] 失去了一切。"))
				else
					to_chat(owner, span_warning("肩上的重量似乎轻了些。你失去了一些宇宙真理。"))
		if(9)
			if(increase)
				if (!silent)
					to_chat(owner, span_notice("你终于把自己折磨得足够彻底，从而理解了 [GLOB.deity]。一切都变得如此清晰。"))
				var/mob/living/carbon/human/knower = owner
				if(!istype(knower))
					return
				INVOKE_ASYNC(knower, TYPE_PROC_REF(/mob/living/carbon/human, slow_psykerize))

/datum/brain_trauma/special/burdened/proc/is_burdensome_organ(mob/burdened, organ_slot, obj/item/organ/organ, special)
	if(special) //aheals
		return
	if(!ishuman(burdened))
		return //mobs that don't care about organs
	var/mob/living/carbon/human/burdened_human = burdened
	var/datum/species/burdened_species = burdened_human.dna?.species
	if(!burdened_species)
		return

	/// only organs that are slotted in these count. because there's a lot of useless organs to cheese with.
	var/list/critical_slots = burden_organ_slots.Copy()
	if(!burdened_species.mutantheart)
		critical_slots -= ORGAN_SLOT_HEART
	if(!burdened_species.mutanttongue)
		critical_slots -= ORGAN_SLOT_TONGUE
	if(!burdened_species.mutantlungs)
		critical_slots -= ORGAN_SLOT_LUNGS
	if(!burdened_species.mutantstomach)
		critical_slots -= ORGAN_SLOT_STOMACH
	if(!burdened_species.mutantliver)
		critical_slots -= ORGAN_SLOT_LIVER

	if(!(organ_slot in critical_slots))
		return FALSE
	if(istype(organ, /obj/item/organ/eyes))
		var/obj/item/organ/eyes/eyes = organ
		if(eyes.tint < TINT_BLIND) //unless you were already blinded by them (flashlight eyes), this is adding burden!
			return TRUE
		return FALSE
	return TRUE

/// Signal to decrease burden_level (see update_burden proc) if an organ is added
/datum/brain_trauma/special/burdened/proc/organ_added_burden(mob/burdened, obj/item/organ/new_organ, special)
	SIGNAL_HANDLER

	if(is_burdensome_organ(burdened, new_organ.slot, new_organ, special))
		update_burden(increase = FALSE)//working organ

/// Signal to increase burden_level (see update_burden proc) if an organ is removed
/datum/brain_trauma/special/burdened/proc/organ_removed_burden(mob/burdened, obj/item/organ/old_organ, special)
	SIGNAL_HANDLER

	if(is_burdensome_organ(burdened, old_organ.slot, old_organ, special))
		update_burden(increase = TRUE) //lost organ

/// Signal to decrease burden_level (see update_burden proc) if a limb is added
/datum/brain_trauma/special/burdened/proc/limbs_added_burden(datum/source, obj/item/bodypart/new_limb, special)
	SIGNAL_HANDLER

	if(special) //something we don't wanna consider, like instaswapping limbs
		return
	update_burden(increase = FALSE)

/// Signal to increase burden_level (see update_burden proc) if a limb is removed
/datum/brain_trauma/special/burdened/proc/limbs_removed_burden(datum/source, obj/item/bodypart/old_limb, special, dismembered)
	SIGNAL_HANDLER

	if(special) //something we don't wanna consider, like instaswapping limbs
		return
	update_burden(increase = TRUE)

/// Signal to increase burden_level (see update_burden proc) if an addiction is added
/datum/brain_trauma/special/burdened/proc/addict_added_burden(datum/addiction/new_addiction, datum/mind/addict_mind)
	SIGNAL_HANDLER

	update_burden(increase = TRUE)

/// Signal to decrease burden_level (see update_burden proc) if an addiction is removed
/datum/brain_trauma/special/burdened/proc/addict_removed_burden(datum/addiction/old_addiction, datum/mind/nonaddict_mind)
	SIGNAL_HANDLER

	update_burden(increase = FALSE)

/// Signal to increase burden_level (see update_burden proc) if a mutation is added
/datum/brain_trauma/special/burdened/proc/mutation_added_burden(mob/living/carbon/burdened, datum/mutation/mutation_type, class)
	SIGNAL_HANDLER

	if(initial(mutation_type.quality) == NEGATIVE)
		update_burden(increase = TRUE)

/// Signal to decrease burden_level (see update_burden proc) if a mutation is removed
/datum/brain_trauma/special/burdened/proc/mutation_removed_burden(mob/living/carbon/burdened, datum/mutation/mutation_type)
	SIGNAL_HANDLER

	if(initial(mutation_type.quality) == NEGATIVE)
		update_burden(increase = FALSE)

/// Signal to increase burden_level (see update_burden proc) if a trauma is added
/datum/brain_trauma/special/burdened/proc/trauma_added_burden(mob/living/carbon/burdened, datum/brain_trauma/trauma_added)
	SIGNAL_HANDLER

	if(istype(trauma_added, /datum/brain_trauma/severe))
		update_burden(increase = TRUE)

/// Signal to decrease burden_level (see update_burden proc) if a trauma is removed
/datum/brain_trauma/special/burdened/proc/trauma_removed_burden(mob/living/carbon/burdened, datum/brain_trauma/trauma_removed)
	SIGNAL_HANDLER

	if(istype(trauma_removed, /datum/brain_trauma/severe))
		update_burden(increase = FALSE)
