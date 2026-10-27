/datum/species/skeleton
	// 2spooky
	name = "阴森恐怖的骷髅"
	id = SPECIES_SKELETON
	sexes = FALSE
	meat = /obj/item/food/meat/slab/human/mutant/skeleton
	inherent_traits = list(
		TRAIT_EASYDISMEMBER,
		TRAIT_FAKEDEATH,
		TRAIT_GENELESS,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NOBLOOD,
		TRAIT_NOBREATH,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_UNDERWEAR,
		TRAIT_PIERCEIMMUNE,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_TOXIMMUNE,
		TRAIT_UNHUSKABLE,
		TRAIT_XENO_IMMUNE,
	)
	inherent_factions = list(FACTION_SKELETON)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID|MOB_SKELETAL
	mutanttongue = /obj/item/organ/tongue/bone
	mutantstomach = /obj/item/organ/stomach/bone
	mutantappendix = null
	mutantheart = null
	mutantliver = /obj/item/organ/liver/bone
	mutantlungs = null
	//They can technically be in an ERT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | ERT_SPAWN
	species_cookie = /obj/item/reagent_containers/condiment/milk
	species_language_holder = /datum/language_holder/skeleton

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/skeleton,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/skeleton,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/skeleton,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/skeleton,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/skeleton,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/skeleton,
	)

/datum/species/skeleton/check_roundstart_eligible()
	if(check_holidays(HALLOWEEN))
		return TRUE
	return ..()

/datum/species/skeleton/get_physical_attributes()
	return "这些“肱骨”之友没有任何血肉生理结构，因此能抵抗压力、温度、辐射、窒息甚至毒素。\
		然而也正因如此，治疗他们相当困难。常见太空牛奶中的钙质对治疗他们的伤口极为有效。\
		他们的肢体很容易从关节上脱落，但他们总能莫名其妙地把它装回去。"

/datum/species/skeleton/get_species_description()
	return "一具咔嗒作响的骷髅！他们每年都会降临十三号空间站，\
		吓唬船员们！“我跟你还有一笔‘骨头账’要算！”"

/datum/species/skeleton/get_species_lore()
	return list(
		"骷髅们想再次令人恐惧！他们在媒体中的形象已经被毁了，\
		至少他们自己是这么坚信的。在 RPG 里他们总是第一个被打的东西，\
		他们被塑造成了只会抖双关包袱的笑料，这真的开始让他们难以忍受。\
		可以说他们真的被“震”得不轻。哈。"
	)
