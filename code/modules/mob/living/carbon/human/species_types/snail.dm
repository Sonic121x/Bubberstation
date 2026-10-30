/datum/species/snail
	name = "\improper 蜗牛人"
	plural_form = "蜗牛人"
	id = SPECIES_SNAIL
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		// TRAIT_NO_UNDERWEAR, //SKYRAT EDIT REMOVAL - Roundstart Snails - Snails deserve to wear underwear
		TRAIT_NO_SLIP_ALL,
		TRAIT_NODROWN, //SKYRAT EDIT ADDITION - Roundstart Snails - Sea snails exist, and land snails can weather being underwater for almost a day.
	)

	coldmod = 0.5 //snails only come out when its cold and wet
	siemens_coeff = 2 //snails are mostly water
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP
	sexes = FALSE //snails are hermaphrodites

	mutanteyes = /obj/item/organ/eyes/snail
	mutanttongue = /obj/item/organ/tongue/snail
	mutantliver = /obj/item/organ/liver/snail
	exotic_bloodtype = /datum/blood_type/snail

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/snail,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/snail,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/snail,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/snail,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/snail,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/snail
	)

/datum/species/snail/prepare_human_for_preview(mob/living/carbon/human/human)
	human.dna.features[FEATURE_MUTANT_COLOR] = COLOR_BEIGE
	human.update_body(is_creating = TRUE)

/datum/species/snail/get_physical_attributes()
	return "蜗牛人在地面爬行时会分泌黏滑的黏液，他们爬行的速度比其他物种略快一些。\
		他们的身体几乎完全由水构成，因此极易受到电击，盐分也会对他们造成严重灼伤。"

/datum/species/snail/get_species_description()
	return "蜗牛人是黏稠湿滑的生物，背上长着一只壳。"

/datum/species/snail/get_species_lore()
	return list(
		"通常来说，蜗牛人是基因实验出错的产物，但他们后来已成为被认可的独立物种，\
		与猫人类似。",
	)

/datum/species/snail/create_pref_unique_perks()
	var/list/to_add = list()
	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_RUNNING,
		SPECIES_PERK_NAME = "涡轮加速",
		SPECIES_PERK_DESC = "蜗牛人走路和奔跑都非常慢，但爬行时速度极快。爬行时他们会在身后留下一道湿滑的黏液痕迹。",
	))
	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHRIMP,
		SPECIES_PERK_NAME = "有壳",
		SPECIES_PERK_DESC = "蜗牛人的背上覆盖着带装甲的壳，实际上相当于一个无法卸下的背包。\
			它有利于防止物品被偷，但不利于穿戴 MOD 外骨骼或进行伪装。",
	))
	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SKULL_CROSSBONES,
		SPECIES_PERK_NAME = "怕盐",
		SPECIES_PERK_DESC = "蜗牛人由蜗牛进化而来，对盐极为敏感，盐会灼伤他们。",
	))
	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_HAND_FIST,
		SPECIES_PERK_NAME = "软塌塌",
		SPECIES_PERK_DESC = "蜗牛人又软又黏，使他们的拳脚攻击远不如其他物种有效。",
	))
	return to_add

/datum/species/snail/on_species_gain(mob/living/carbon/new_snailperson, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	var/obj/item/storage/backpack/bag = new_snailperson.get_item_by_slot(ITEM_SLOT_BACK)
	if(!istype(bag, /obj/item/storage/backpack/snail))
		new_snailperson.equip_to_slot_or_del(new /obj/item/storage/backpack/snail(new_snailperson), ITEM_SLOT_BACK)

/datum/species/snail/on_species_loss(mob/living/carbon/former_snailperson, datum/species/new_species, pref_load)
	. = ..()
	var/obj/item/storage/backpack/bag = former_snailperson.get_item_by_slot(ITEM_SLOT_BACK)
	if(istype(bag, /obj/item/storage/backpack/snail))
		bag.emptyStorage()
		former_snailperson.temporarilyRemoveItemFromInventory(bag, TRUE)
		qdel(bag)

/obj/item/storage/backpack/snail
	name = "蜗牛壳"
	desc = "蜗牛将其穿在身上，作为护甲与储物舱。"
	icon_state = "snailshell"
	inhand_icon_state = null
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	armor_type = /datum/armor/backpack_snail
	max_integrity = 200
	resistance_flags = FIRE_PROOF | ACID_PROOF
	drop_sound = null
	pickup_sound = null
	equip_sound = null


// SKYRAT EDIT ADDITION - CLARIFICATION - Roundstart Snails - These armor values don't actually do any protection of the wearer, this is for checking direct damage to the backpack. Damage resistance stuff is in their heart file.
/datum/armor/backpack_snail
	melee = 40
	bullet = 30
	laser = 30
	energy = 10
	bomb = 25
	acid = 50

/obj/item/storage/backpack/snail/dropped(mob/user, silent)
	. = ..()
	emptyStorage()
	if(!QDELETED(src))
		qdel(src)

/obj/item/storage/backpack/snail/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)
