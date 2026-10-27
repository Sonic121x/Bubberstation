/datum/species/fly
	name = "蝇人"
	plural_form = "蝇人"
	id = SPECIES_FLYPERSON
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	meat = /obj/item/food/meat/slab/human/mutant/fly
	mutanteyes = /obj/item/organ/eyes/fly
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/fly
	payday_modifier = 1.0

	mutanttongue = /obj/item/organ/tongue/fly
	mutantheart = /obj/item/organ/heart/fly
	mutantlungs = /obj/item/organ/lungs/fly
	mutantliver = /obj/item/organ/liver/fly
	mutantstomach = /obj/item/organ/stomach/fly
	mutantappendix = /obj/item/organ/appendix/fly
	mutant_organs = list(/obj/item/organ/fly, /obj/item/organ/fly/groin)

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/fly,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/fly,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/fly,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/fly,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/fly,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/fly,
	)

/datum/species/fly/get_physical_attributes()
	return "这些丑陋的生物对杀虫剂极为敏感，以废物为食，并且极易受到强光伤害。不过，他们确实有翅膀。"

/datum/species/fly/get_species_description()
	return "由于没有任何官方文献或关于该物种起源的资料，\
		他们对大多数人而言仍是个谜。纳米传讯员工之间流传的 \
		各种关于蝇人的传闻，往往会被高层人员或官员 \
		迅速压下。"

/datum/species/fly/get_species_lore()
	return list(
		"蝇人是一种奇特的物种，外形与昆虫纲中的双翅目（俗称苍蝇）极为相似。\
		他们的起源并无公开记载，据传蝇人是蓝空间旅行的副产物，\
		尽管纳米传讯官员另有说法。",

		"关于这个种族的起源所知甚少，\
		不过他们能够与巨型蜘蛛交流；这一能力最初发现于澳斯特拉利库斯星区，\
		如今由于辛迪加生物武器研究的突破，已成为黑市上的常见现象。",

		"蝇人常被其他物种畏惧或避而远之，他们的外貌常被形容为不洁，某些情况下甚至令人恐惧，\
		而他们的进食习惯更是如此，再加上一口让人难以忍受的口音。",
	)

/datum/species/fly/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "grin-tongue",
			SPECIES_PERK_NAME = "诡异的消化系统",
			SPECIES_PERK_DESC = "蝇人会将胃里的东西反刍出来，再从地板上喝下去，\
				以此进食饮水；他们不在意味道，偏爱恶心的食物。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fist-raised",
			SPECIES_PERK_NAME = "昆虫生物学",
			SPECIES_PERK_DESC = "苍蝇拍会对蝇人造成显著更高的伤害。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "sun",
			SPECIES_PERK_NAME = "放射状视觉",
			SPECIES_PERK_DESC = "蝇人会被来自各个角度的闪光晃到。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "briefcase-medical",
			SPECIES_PERK_NAME = "怪异器官",
			SPECIES_PERK_DESC = "治疗蝇人需要专门的医学知识。\
				他们的器官形态畸变，器官手术可能会相当有趣……",
		),
	)

	return to_add
