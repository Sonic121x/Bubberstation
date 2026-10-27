/datum/species/human/cursekin
	name = "\improper 咒裔"
	plural_form = "\improper 咒裔"
	id = SPECIES_CURSEKIN
	inherent_traits = list(
		TRAIT_LYCAN,
		TRAIT_MUTANT_COLORS, // More customization options.
	)
	mutantbrain = /obj/item/organ/brain/lycan
	var/lycanthropy_species = /datum/species/lycan

/datum/species/human/cursekin/get_species_description()
	return list(
		"与其说是一个种族，不如说是一群共受同一诅咒之人的集合。咒裔的起源很大程度上 \
		仍然未知，不过许多不同的文化似乎都为这种苦难起了自己的名字、编出了自己的神话，这也让人更加相信 \
		这道诅咒已经存在了相当长的时间。",
		"所有受苦者共有的主要特征，是他们能变形成更具兽性的形态，以及他们的身体排斥 \
		一切无机物。受诅咒折磨的人似乎对是否变形、何时变形有着不同程度的控制力。"
	)

/datum/species/human/cursekin/get_species_lore()
	return list(placeholder_lore)

/datum/species/human/cursekin/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_ROBOT,
			SPECIES_PERK_NAME = "无机排斥",
			SPECIES_PERK_DESC = "折磨咒裔的诅咒使他们的身体无法植入义体器官 \
			或植入物。"
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_CLOUD_MOON,
			SPECIES_PERK_NAME = "白银弱点",
			SPECIES_PERK_DESC = "银会灼伤你，尤其是相关的试剂。当处于狼人形态时，这种效果会被大幅放大。"
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_MOON,
			SPECIES_PERK_NAME = "狼人变形",
			SPECIES_PERK_DESC = "由于诅咒，咒裔能够变形成狼人，并承受该形态的所有好处与 \
			缺陷。详见狼人种族页面。",
		),
	)

	return to_add

/datum/species/human/cursekin/prepare_human_for_preview(mob/living/carbon/human/cursekin)
	var/main_color = "#362d23"
	var/secondary_color = "#9c5852"
	var/tertiary_color = "#CCF6E2"
	cursekin.set_species(lycanthropy_species)
	cursekin.dna.features["mcolor"] = main_color
	cursekin.dna.features["mcolor2"] = secondary_color
	cursekin.dna.features["mcolor3"] = tertiary_color
	cursekin.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	cursekin.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	cursekin.dna.features["legs"] = "Digitigrade Legs"
	regenerate_organs(cursekin, src, visual_only = TRUE)
	cursekin.update_body(TRUE)

/mob/living/carbon/human/species/cursekin
	race = /datum/species/human/cursekin

/datum/species/human/cursekin/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	gainer.AddElement(/datum/element/inorganic_rejection)

/datum/species/human/cursekin/on_species_loss(mob/living/carbon/human/loser, datum/species/new_species, pref_load)
	. = ..()
	loser.RemoveElement(/datum/element/inorganic_rejection)
