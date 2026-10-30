//Subtype of human
/datum/species/human/felinid
	name = "猫人"
	id = SPECIES_FELINE
	examine_limb_id = SPECIES_HUMAN
	mutantbrain = /obj/item/organ/brain/felinid
	mutanttongue = /obj/item/organ/tongue/cat
	/* SKYRAT EDIT REMOVAL - CUSTOMIZATION
	mutantears = /obj/item/organ/ears/cat
	mutanteyes = /obj/item/organ/eyes/felinid
	mutant_organs = list(
		/obj/item/organ/tail/cat = "Cat",
		/obj/item/organ/fangs/cat,
	)
	*/ // SKYRAT EDIT REMOVAL END
	inherent_traits = list(
		TRAIT_HATED_BY_DOGS,
		TRAIT_USES_SKINTONES,
		TRAIT_WATER_HATER,
		TRAIT_KNOW_ADVANCED_SMITHING, //BUBBER EDIT
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/felinid
	payday_modifier = 1.0
	family_heirlooms = list(/obj/item/toy/cattoy)
	/// When false, this is a felinid created by mass-purrbation
	var/original_felinid = TRUE
	/// Yummy!
	species_cookie = /obj/item/food/nugget

/datum/species/human/felinid/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons = TRUE, replace_missing = TRUE)
	if(!pref_load) //Hah! They got forcefully purrbation'd. Force default felinid parts on them if they have no mutant parts in those areas!
		if(human_who_gained_species.dna.features[FEATURE_TAIL_CAT] == SPRITE_ACCESSORY_NONE)
			human_who_gained_species.dna.features[FEATURE_TAIL_CAT] = get_consistent_feature_entry(SSaccessories.feature_list[FEATURE_TAIL_CAT])
		if(human_who_gained_species.dna.features[FEATURE_EARS] == SPRITE_ACCESSORY_NONE)
			human_who_gained_species.dna.features[FEATURE_EARS] = get_consistent_feature_entry(SSaccessories.feature_list[FEATURE_EARS])

	// Swapping out feline ears for normal ol' human ears if they have invisible cat ears.
	if(human_who_gained_species.dna.features[FEATURE_EARS] == SPRITE_ACCESSORY_NONE)
		mutantears = /obj/item/organ/ears
	return ..()

/proc/mass_purrbation()
	for(var/mob in GLOB.human_list)
		purrbation_apply(mob)
		CHECK_TICK

/proc/mass_remove_purrbation()
	for(var/mob in GLOB.human_list)
		purrbation_remove(mob)
		CHECK_TICK

/proc/purrbation_toggle(mob/living/carbon/human/target_human, silent = FALSE)
	if(!ishuman(target_human))
		return
	if(!istype(target_human.get_organ_slot(ORGAN_SLOT_EARS), /obj/item/organ/ears/cat))
		purrbation_apply(target_human, silent = silent)
		. = TRUE
	else
		purrbation_remove(target_human, silent = silent)
		. = FALSE

/proc/purrbation_apply(mob/living/carbon/human/soon_to_be_felinid, silent = FALSE)
	if(!ishuman(soon_to_be_felinid) || isfelinid(soon_to_be_felinid))
		return
	if(ishumanbasic(soon_to_be_felinid))
		soon_to_be_felinid.set_species(/datum/species/human/felinid)
		var/datum/species/human/felinid/cat_species = soon_to_be_felinid.dna.species
		cat_species.original_felinid = FALSE
	else
		// This removes the spines if they exist
		var/obj/item/organ/spines/current_spines = soon_to_be_felinid.get_organ_slot(ORGAN_SLOT_EXTERNAL_SPINES)
		if(current_spines)
			current_spines.Remove(soon_to_be_felinid, special = TRUE)
			qdel(current_spines)

		// Without this line the tails would be invisible. This is because cat tail and ears default to None.
		// Humans get converted directly to felinids, and the key is handled in on_species_gain.
		// Now when we get mob.dna.features[feature_key], it returns None, which is why the tail is invisible.
		// stored_feature_id is only set once (the first time an organ is inserted), so this should be safe.
		var/obj/item/organ/ears/cat/kitty_ears = new
		kitty_ears.Insert(soon_to_be_felinid, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		if(should_visual_organ_apply_to(/obj/item/organ/tail/cat, soon_to_be_felinid)) //only give them a tail if they actually have sprites for it / are a compatible subspecies.
			var/obj/item/organ/tail/cat/kitty_tail = new
			kitty_tail.Insert(soon_to_be_felinid, special = TRUE, movement_flags = DELETE_IF_REPLACED)

	if(!silent)
		to_chat(soon_to_be_felinid, span_boldnotice("有什么东西不太喵~对劲。"))
		playsound(get_turf(soon_to_be_felinid), 'sound/effects/meow1.ogg', 50, TRUE, -1)

/proc/purrbation_remove(mob/living/carbon/human/purrbated_human, silent = FALSE)
	if(isfelinid(purrbated_human))
		var/datum/species/human/felinid/cat_species = purrbated_human.dna.species
		if(cat_species.original_felinid)
			return // Don't display the to_chat message
		purrbated_human.set_species(/datum/species/human)
	else if(ishuman(purrbated_human) && !ishumanbasic(purrbated_human))
		var/datum/species/target_species = purrbated_human.dna.species

		// From the previous check we know they're not a felinid, therefore removing cat ears and tail is safe
		var/obj/item/organ/tail/old_tail = purrbated_human.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
		if(istype(old_tail, /obj/item/organ/tail/cat))
			old_tail.Remove(purrbated_human, special = TRUE)
			qdel(old_tail)
			// Locate does not work on assoc lists, so we do it by hand
			for(var/external_organ in target_species.mutant_organs)
				if(!should_visual_organ_apply_to(external_organ, purrbated_human))
					continue
				if(ispath(external_organ, /obj/item/organ/tail))
					var/obj/item/organ/tail/new_tail = new external_organ()
					new_tail.Insert(purrbated_human, special = TRUE, movement_flags = DELETE_IF_REPLACED)
				// Don't forget the spines we removed earlier
				else if(ispath(external_organ, /obj/item/organ/spines))
					var/obj/item/organ/spines/new_spines = new external_organ()
					new_spines.Insert(purrbated_human, special = TRUE, movement_flags = DELETE_IF_REPLACED)

		var/obj/item/organ/ears/old_ears = purrbated_human.get_organ_slot(ORGAN_SLOT_EARS)
		if(istype(old_ears, /obj/item/organ/ears/cat))
			var/obj/item/organ/new_ears = new target_species.mutantears()
			new_ears.Insert(purrbated_human, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	if(!silent)
		to_chat(purrbated_human, span_boldnotice("你不再是一只猫了。"))

/datum/species/human/felinid/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.set_haircolor("#ffcccc", update = FALSE) // pink
	human_for_preview.set_hairstyle("Hime Cut", update = TRUE)


	/* // SKYRAT EDIT REMOVAL START - Making the species menu icons work better - ORIGINAL:
	var/obj/item/organ/ears/cat/cat_ears = human_for_preview.get_organ_by_type(/obj/item/organ/ears/cat)
	if (cat_ears)
		cat_ears.color = human_for_preview.hair_color
		human_for_preview.update_hair()
	*/ // SKYRAT EDIT REMOVAL END
	// SKYRAT EDIT ADDITION START
	regenerate_organs(human_for_preview, src, visual_only = TRUE)
	// SKYRAT EDIT ADDITION END

/datum/species/human/felinid/get_physical_attributes()
	return "猫人在几乎所有方面都与人类十分相似，最大的区别在于能够舔舐伤口，\
		以及对噪音更加敏感，这往往会带来不利影响。他们还相当喜欢吃橙子。"

/datum/species/human/felinid/get_species_description()
	return "猫人是人类精通基因科学之后所定制的众多基因\
		改造种类之一，也是最常见的种类之一。\
		喵？"

/datum/species/human/felinid/get_species_lore()
	return list(
		"猫人是生物工程最“猫”的成果，是人类掌握基因密码的巅峰范例。\
			作为众多“动物人”变体之一，猫人是最受欢迎、最常见的种类，也是 \
			基因改造领域争议最大的焦点之一。",

		"身体改造师热衷于拼接人类与猫科动物的 DNA，以追求耳朵、眼睛与尾巴这神圣三件套。\
			这些特征需求极高，而随之而来的发声与神经化学变化等副作用则被视为小小的不便。",

		"遗憾的是，对猫人而言这些绝非小事。他们被许多人视为非人的怪物而遭排斥，猫人（以及其他动物人）\
			于是前往殖民地寻找更美好的天地，聚居在与自己同类的社区中。\
			因此，人类外环星域拥有很高的动物人人口。",
	)

// Felinids are subtypes of humans.
// This shouldn't call parent or we'll get a buncha human related perks (though it doesn't have a reason to).
/datum/species/human/felinid/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "grin-tongue",
			SPECIES_PERK_NAME = "理毛",
			SPECIES_PERK_DESC = "猫人可以舔舐伤口以减少出血。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = FA_ICON_PERSON_FALLING,
			SPECIES_PERK_NAME = "猫般优雅",
			SPECIES_PERK_DESC = "猫人拥有猫一般的本能，能在落地时双脚站稳。  \
				从高处坠落时你不会被击倒，只会短暂减速。 \
				不过他们并没有猫的腿脚，坠落仍会造成额外伤害。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "assistive-listening-systems",
			SPECIES_PERK_NAME = "听觉灵敏",
			SPECIES_PERK_DESC = "猫人对闪光弹等响亮声音更加敏感。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "shower",
			SPECIES_PERK_NAME = "恐水症",
			SPECIES_PERK_DESC = "猫人不喜欢被水淋湿。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_ANGRY,
			SPECIES_PERK_NAME = "“战或逃”防御反应",
			SPECIES_PERK_DESC = "精神失常（且缺乏食物）的猫人会表现出 \
				对攻击者的极端“战或逃”反应。他们有时会咬人。非常暴力。",
		),
// SKYRAT EDIT ADDITION START
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "paw",
			SPECIES_PERK_NAME = "软着陆",
			SPECIES_PERK_DESC = "猫人从高处坠落不会受伤，并且能双脚落地。",
		),
// SKYRAT EDIT ADDITION END
	)
	return to_add
