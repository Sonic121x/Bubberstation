/datum/species/android
	name = "仿生人"
	id = SPECIES_ANDROID
	examine_limb_id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_GENELESS,
		TRAIT_LIMBATTACHMENT,
		TRAIT_LIVERLESS_METABOLISM,
		TRAIT_NOBLOOD,
		TRAIT_NOBREATH,
		TRAIT_NOCRITDAMAGE,
		TRAIT_NOFIRE,
		TRAIT_NOHUNGER,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_NO_UNDERWEAR,
		TRAIT_OVERDOSEIMMUNE,
		TRAIT_PIERCEIMMUNE,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_TOXIMMUNE,
	)

	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	exotic_bloodtype = /datum/blood_type/oil
	meat = null
	mutantbrain = /obj/item/organ/brain/cybernetic
	mutanttongue = /obj/item/organ/tongue/robot
	mutantstomach = null
	mutantappendix = null
	mutantheart = null
	mutantliver = null
	mutantlungs = null
	mutanteyes = /obj/item/organ/eyes/robotic
	mutantears = /obj/item/organ/ears/cybernetic
	species_language_holder = /datum/language_holder/synthetic
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/android,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/android,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/robot/android,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/robot/android,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/android,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/android,
	)

/datum/species/android/get_physical_attributes()
	return "仿生人几乎与完全义体化的人类一模一样，但又不完全相同。\
	与那些人不同，他们对毒素伤害完全免疫，没有血液和内脏（除了头部），不会感到饥饿，还能自行接回肢体！\
	不过，EMP 会重创他们，而且他们无法代谢任何化学物质。"

/datum/species/android/get_species_description()
	return "仿生人是一个完全合成的种族。"

/datum/species/android/get_species_lore()
	return list(
		"仿生人是纳米传讯创造的合成种族，充当人类与半机械人之间的中间形态。"
	)

/datum/species/android/create_pref_traits_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHIELD_ALT,
		SPECIES_PERK_NAME = "仿生人天赋",
		SPECIES_PERK_DESC = "作为合成生命体，仿生人对人类易受的多种伤害免疫。\
			火焰、寒冷、高温、压力、辐射和毒素都对他们无效。\
			他们也不会药物过量，不需要呼吸或进食，不会着火，并且免疫穿刺。",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_COGS,
		SPECIES_PERK_NAME = "模块化生命体",
		SPECIES_PERK_DESC = "仿生人的肢体是模块化的，可以轻松接回断开的身体部位。",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_DNA,
		SPECIES_PERK_NAME = "终究不是人类",
		SPECIES_PERK_DESC = "仿生人的眼中没有任何人性，因此他们没有可供基因改造的 DNA。",
	))
	return perks

/datum/species/android/create_pref_unique_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHIELD_HEART,
		SPECIES_PERK_NAME = "部分组件可选",
		SPECIES_PERK_DESC = "仿生人的内部器官极少。虽然缺少许多器官也能存活，\
			但也无法从这些器官获得任何好处。",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_ROBOT,
		SPECIES_PERK_NAME = "合成体",
		SPECIES_PERK_DESC = "作为合成体，仿生人容易受到 EMP 的影响。",
	))
	return perks
