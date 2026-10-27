/datum/species/pod
	// A mutation caused by a human being ressurected in a revival pod. These regain health in light, and begin to wither in darkness.
	name = "\improper 豆荚人"
	plural_form = "豆荚人"
	id = SPECIES_PODPERSON
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_PLANT_SAFE,
		TRAIT_REQUIRED_ADV_HEALTH_SCANNER,
		TRAIT_KNOW_ADVANCED_SMITHING, //BUBBER EDIT
	)
	mutant_organs = list(
		// /obj/item/organ/pod_hair = "None", // SKYRAT EDIT REMOVAL - Customization
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID | MOB_PLANT
	inherent_factions = list(FACTION_PLANTS, FACTION_VINES)

	heatmod = 1.5
	payday_modifier = 1.0
	meat = /obj/item/food/meat/slab/human/mutant/plant
	exotic_bloodtype = BLOOD_TYPE_H2O
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/plant

	mutantappendix = /obj/item/organ/appendix/pod
	mutantbrain = /obj/item/organ/brain/pod
	mutantears = /obj/item/organ/ears/pod
	mutanteyes = /obj/item/organ/eyes/pod
	mutantheart = /obj/item/organ/heart/pod
	mutantliver = /obj/item/organ/liver/pod
	mutantlungs = /obj/item/organ/lungs/pod
	mutantstomach = /obj/item/organ/stomach/pod
	mutanttongue = /obj/item/organ/tongue/pod

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/pod,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/pod,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/pod,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/pod,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/pod,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/pod,
	)

/datum/species/pod/prepare_human_for_preview(mob/living/carbon/human/human)
	human.dna.features[FEATURE_MUTANT_COLOR] = "#886600"
	human.dna.features[FEATURE_POD_HAIR] = "Rose"
	human.update_body(is_creating = TRUE)

/datum/species/pod/get_physical_attributes()
	return "豆荚人在许多方面与暗影人相反：在光明中治愈，在黑暗中枯萎。\
		他们的身体如同火绒，极易烧焦。"

/datum/species/pod/get_species_description()
	return "豆荚人主要是和平的植物类生命体，外形如同由叶片、花朵与藤蔓构成的人形。"

/datum/species/pod/get_species_lore()
	return list(
		"关于豆荚人的起源，人们所知不多。\
		许多人认为他们是某个早已被遗忘的植物学实验的产物，在漫长的岁月中缓慢变异，最终成为如今的模样。\
		自很久以前被发现以来，他们的同类便出现在银河各处的空间站与行星上，\
		常在水培舱、厨房或科研部门工作，照料植物与其他植物类生命体。",
	)

/datum/species/pod/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "lightbulb",
		SPECIES_PERK_NAME = "光合作用",
		SPECIES_PERK_DESC = "只要保持清醒并处于照明良好的区域，你就会缓慢治愈钝击、灼烧、毒素与缺氧伤害并获得营养——而且永远不会发胖！ \
		不过，若你的营养水平很低，你会持续受到钝击伤害，直到死亡或再次回到光亮中。"
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "biohazard",
		SPECIES_PERK_NAME = "除草剂易感性",
		SPECIES_PERK_DESC = "作为花卉类生命体，你对除花剂十分敏感，会因此受到额外的毒素伤害！"
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "briefcase-medical",
		SPECIES_PERK_NAME = "半复杂生物学",
		SPECIES_PERK_DESC = "你的生理结构极为复杂，普通健康扫描仪无法扫描你。请确保为你治疗的医生手上有 \
		植物分析仪或高级健康扫描仪！"
	))

	return to_add
