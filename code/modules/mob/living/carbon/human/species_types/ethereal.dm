/datum/species/ethereal
	name = "\improper 以太人"
	id = SPECIES_ETHEREAL
	meat = /obj/item/food/meat/slab/human/mutant/ethereal
	mutantlungs = /obj/item/organ/lungs/ethereal
	smoker_lungs = /obj/item/organ/lungs/ethereal/ethereal_smoker
	mutantstomach = /obj/item/organ/stomach/ethereal
	mutanttongue = /obj/item/organ/tongue/ethereal
	mutantheart = /obj/item/organ/heart/ethereal
	exotic_bloodtype = BLOOD_TYPE_ETHEREAL
	siemens_coeff = 0.5 //They thrive on energy
	payday_modifier = 1.0
	inherent_traits = list(
		// TRAIT_NO_UNDERWEAR, // SKYRAT EDIT - LET THEM WEAR PANTIES //TRAIT_AGENDER - BUBBER EDIT
		TRAIT_MUTANT_COLORS,
		TRAIT_FIXED_MUTANT_COLORS,
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_cookie = /obj/item/food/energybar
	species_language_holder = /datum/language_holder/ethereal
	sexes = FALSE //no fetish content allowed
	// Body temperature for ethereals is much higher than humans as they like hotter environments
	bodytemp_normal = (BODYTEMP_NORMAL + 50)
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD // about 150C
	// Cold temperatures hurt faster as it is harder to move with out the heat energy
	bodytemp_cold_damage_limit = (T20C - 10) // about 10c
	hair_color_mode = USE_MUTANT_COLOR
	hair_alpha = 140
	facial_hair_alpha = 140

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/ethereal,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/ethereal,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ethereal,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ethereal,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ethereal,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ethereal,
	)

/datum/species/ethereal/on_species_gain(mob/living/carbon/human/new_ethereal, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	if(!ishuman(new_ethereal))
		return
	var/obj/item/organ/heart/ethereal/ethereal_heart = new_ethereal.get_organ_slot(ORGAN_SLOT_HEART)
	ethereal_heart.set_ethereal_color(new_ethereal.dna.features[FEATURE_MUTANT_COLOR])
	// Trigger a refresh as lazy attached limbs do not cause those
	var/datum/status_effect/grouped/bodypart_effect/ethereal_glow/glow_status = new_ethereal.has_status_effect(/datum/status_effect/grouped/bodypart_effect/ethereal_glow)
	if (!isnull(glow_status))
		glow_status.refresh_light_color()

/datum/species/ethereal/randomize_features()
	var/list/features = ..()
	features[FEATURE_MUTANT_COLOR] = GLOB.color_list_ethereal[pick(GLOB.color_list_ethereal)]
	return features

/datum/species/ethereal/prepare_human_for_preview(mob/living/carbon/human/human)
	human.dna.features[FEATURE_MUTANT_COLOR] = GLOB.color_list_ethereal["Green"]

/datum/species/ethereal/get_features()
	var/list/features = ..()
	features += "feature_ethcolor"
	return features

/datum/species/ethereal/get_physical_attributes()
	return "以太人以电力而非食物作为能量来源，并对电流有一定抗性。\
		他们依靠自己的水晶核心（相当于人类的心脏）做到这一点；若他们死亡，水晶核心还会将他们封入复苏水晶之中。\
		然而，他们的皮肤非常薄，很容易被钝击武器刺穿。"

/datum/species/ethereal/get_species_description()
	return "神权统治的以太人来自斯普劳特星，\
		其社会按种姓划分阶层，并信奉扶助弱小与 \
		受压迫者的教义。"

/datum/species/ethereal/get_species_lore()
	return list(
		"以太人是原生栖息于斯普劳特星的种族。\
		最初被发现时，他们的科技水平尚处于中世纪阶段，\
		但由于天生适应电力，他们在纳米传讯的大型设施中生活得十分自在。",
	)

/datum/species/ethereal/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bolt",
			SPECIES_PERK_NAME = "电击美味",
			SPECIES_PERK_DESC = "以太人可以从 APC 汲取电力充饥，除此之外无需进食。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "lightbulb",
			SPECIES_PERK_NAME = "迪斯科球",
			SPECIES_PERK_DESC = "以太人会自行发出微光。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "gem",
			SPECIES_PERK_NAME = "水晶核心",
			SPECIES_PERK_DESC = "以太人死后，其心脏会将其封入水晶之中，一段时间后令其复活—— \
				代价是永久性的脑部创伤。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "fist-raised",
			SPECIES_PERK_NAME = "元素打击者",
			SPECIES_PERK_DESC = "以太人的拳头造成灼烧伤害而非钝击伤害。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "biohazard",
			SPECIES_PERK_NAME = "饥饿艺术家",
			SPECIES_PERK_DESC = "以太人在饥饿时会受到毒素伤害。",
		),
	)

	return to_add

/datum/species/ethereal/lustrous //Ethereal pirates with an inherent bluespace prophet trauma.
	name = "璀璨者"
	id = SPECIES_ETHEREAL_LUSTROUS
	examine_limb_id = SPECIES_ETHEREAL
	mutantbrain = /obj/item/organ/brain/lustrous
	mutanttongue = /obj/item/organ/tongue/ethereal/lustrous
	changesource_flags = MIRROR_BADMIN | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | ERT_SPAWN
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_FIXED_MUTANT_COLORS,
		TRAIT_AGENDER,
		TRAIT_NOBREATH,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_VIRUSIMMUNE,
	)
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ethereal/lustrous,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/ethereal,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/ethereal,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ethereal,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ethereal,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ethereal,
	)

/datum/species/ethereal/lustrous/get_physical_attributes()
	return "璀璨者是吸食秘药后残存下来的以太人。\
		他们免疫压力与病毒，能看见现实中的蓝空间裂痕，尖叫声也极为怪异，但仍会因物理伤害而受伤。"

/datum/species/ethereal/lustrous/randomize_features()
	var/list/features = ..()
	features[FEATURE_MUTANT_COLOR] = GLOB.color_list_lustrous[pick(GLOB.color_list_lustrous)]
	return features
