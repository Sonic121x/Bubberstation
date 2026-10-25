/datum/species/abductor
	name = "绑架者"
	id = SPECIES_ABDUCTOR
	sexes = TRUE // BUBBER EDIT: Lets abductors have pronouns. Abductors are asexual/agender, but they still can present however they wish for cosmetic purposes.
	can_have_genitals = TRUE // BUBBER EDIT: Lets abductors have genitals.
	inherent_traits = list(
		TRAIT_MUTANT_COLORS, //BUBBER EDIT: Lets abductors change their skin color
		TRAIT_ABDUCTOR_HUD,
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
		TRAIT_NEVER_WOUNDED,
		TRAIT_NOBLOOD,
		TRAIT_NOBREATH,
		TRAIT_NODISMEMBER,
		TRAIT_NOHUNGER,
		//TRAIT_NO_UNDERWEAR, -- BUBBER EDIT: Allows abductors to wear underwear.
		TRAIT_VIRUSIMMUNE,
	)
	mutanttongue = /obj/item/organ/tongue/abductor
	mutantstomach = null
	mutanteyes = /obj/item/organ/eyes/abductor // BUBBER EDIT: Moves abductor eyes to their own separate thing
	mutantheart = null
	mutantlungs = null
	mutantbrain = /obj/item/organ/brain/abductor
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/abductor,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/abductor,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/abductor,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/abductor,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/abductor,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/abductor,
	)

/datum/species/abductor/get_physical_attributes()
	return "绑架者不需要呼吸、进食，没有血液、心脏、胃和肺，也不会感染人类病毒。\
		他们强韧的体质使皮肤不会受伤，也不会被截断肢体，但粗大的三指之手让他们难以操作人类的设备。"

/datum/species/abductor/get_species_description()
	return "绑架者，俗称“灰人”（或“小灰人”），\
		是三指、肤色苍白、充满好奇的外星人，无法与普通船员顺畅交流。"

/datum/species/abductor/get_species_lore()
	return list(
		"人们对绑架者知之甚少。\
		虽然已知他们会绑架其他“智力较低”的种族用于实验，\
		但偶尔也有记录显示，他们会出于未知的原因与那些被自己绑架的种族合作。",
	)

/datum/species/abductor/create_pref_traits_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_WIND,
		SPECIES_PERK_NAME = "肺脏非必需",
		SPECIES_PERK_DESC = "绑架者不需要呼吸，但暴露在真空中仍然危险。",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHIELD,
		SPECIES_PERK_NAME = "强韧皮肤",
		SPECIES_PERK_DESC = "绑架者灰白的皮肤坚韧且抗性出众。\
			常规手段无法使他们受伤或被截断肢体。",
	))
	return perks

/datum/species/abductor/create_pref_unique_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SYRINGE,
		SPECIES_PERK_NAME = "疾病免疫",
		SPECIES_PERK_DESC = "绑架者对空间站上自然存在的所有病毒感染免疫。",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK, // It may be a stretch to call nohunger a neutral perk but the Abductor's tongue describes it as much, so.
		SPECIES_PERK_ICON = FA_ICON_UTENSILS,
		SPECIES_PERK_NAME = "渴求知识",
		SPECIES_PERK_DESC = "绑架者对知识的渴求远胜于食物，因此无需进食。\
			这也算幸运，因为他们的言语基质使他们无法进食。",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_VOLUME_XMARK,
		SPECIES_PERK_NAME = "超语言基质",
		SPECIES_PERK_DESC = "绑架者无法用天然的舌头发声说话。\
			他们天生以心灵感应与其他绑架者交流，其他种族都听不到。\
			很适合密谈，但从酒吧点单就不太方便了。",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_HANDSHAKE_SLASH,
		SPECIES_PERK_NAME = "三指之手",
		SPECIES_PERK_DESC = "绑架者的手并非为人类设备而设计，使用空间站上的设备对他们来说很困难。",
	))
	return perks
