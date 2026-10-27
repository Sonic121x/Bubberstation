/datum/species/vox
	// Bird-like humanoids
	name = "原始沃克斯"
	plural_form = "原始沃克斯"
	id = SPECIES_VOX
	can_augment = FALSE
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutanttongue = /obj/item/organ/tongue/vox
	mutantlungs = /obj/item/organ/lungs/nitrogen/vox
	mutantbrain = /obj/item/organ/brain/cybernetic/cortical/vox
	mutanteyes = /obj/item/organ/eyes/vox
	mutant_bodyparts = list()
	payday_modifier = 1.0
	outfit_important_for_life = /datum/outfit/vox
	species_language_holder = /datum/language_holder/vox
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	// Vox are cold resistant, but also heat sensitive
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 15) // being cold resistant, should make you heat sensitive actual effect ingame isn't much
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 30)
	digitigrade_customization = DIGITIGRADE_FORCED
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/vox,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/vox,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/vox,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/vox,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/vox,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/vox,
	)
	custom_worn_icons = list(
		OFFSET_HEAD = VOX_HEAD_ICON,
		OFFSET_FACEMASK = VOX_MASK_ICON,
		OFFSET_SUIT = VOX_SUIT_ICON,
		OFFSET_UNIFORM = VOX_UNIFORM_ICON,
		OFFSET_GLOVES =  VOX_HANDS_ICON,
		OFFSET_SHOES = VOX_FEET_ICON,
		OFFSET_GLASSES = VOX_EYES_ICON,
		OFFSET_BELT = VOX_BELT_ICON,
		OFFSET_BACK = VOX_BACK_ICON,
		OFFSET_EARS = VOX_EARS_ICON
	)

	meat = /obj/item/food/meat/slab/chicken/human //item file in teshari module

/datum/species/vox/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Vox Tail", FALSE),
		"legs" = list(DIGITIGRADE_LEGS,FALSE),
		"snout" = list("Vox Snout", FALSE),
		"spines" = list("Vox Bands", TRUE),
	)

/datum/species/vox/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only)
	. = ..()
	if(job?.vox_outfit)
		equipping.equipOutfit(job.vox_outfit, visuals_only)
	else
		give_important_for_life(equipping)

/datum/species/vox/randomize_features()
	var/list/features = ..()
	features[FEATURE_MUTANT_COLOR] = pick("#77DD88", "#77DDAA", "#77CCDD", "#77DDCC")
	features[FEATURE_MUTANT_COLOR_TWO] = pick("#EEDD88", "#EECC88")
	features[FEATURE_MUTANT_COLOR_THREE] = pick("#222222", "#44EEFF", "#44FFBB", "#8844FF", "#332233")
	return features

/datum/species/vox/get_random_body_markings(list/passed_features)
	var/name = pick(list("Vox", "Vox Hive", "Vox Nightling", "Vox Heart", "Vox Tiger"))
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/vox/get_custom_worn_icon(item_slot, obj/item/item)
	// snowflakey but vox legs weird.
	if(item_slot == OFFSET_SHOES)
		var/obj/item/bodypart/leg = bodypart_overrides[BODY_ZONE_L_LEG] || bodypart_overrides[BODY_ZONE_R_LEG]
		if(initial(leg?.limb_id) != "digitigrade")
			// normal legs, use normal human shoes
			return DEFAULT_SHOES_FILE

	return item.worn_icon_vox

/datum/species/vox/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_vox = icon

/datum/species/vox/get_species_description()
	return list(
		"在不知情者看来，沃克斯似乎是一支游牧的鸟形生物种族，受“疯狂、做梦的神祇”驱使，在人类太空及其周边活动。\
		真正的沃克斯是完全隐居的沃克斯·奥拉利斯——极为强大的灵能者与生物工程师。即便在最好的情况下，他们也是极为疏远的种族。\
		原始沃克斯是奥拉利斯用来维持方舟舰运转的劳役下层，沿着一条曲折的路线穿越银河。"
	)

/datum/species/vox/get_species_lore()
	return list(
		"沃克斯是一个由沃克斯·奥拉利斯领导的神权国家。他们麾下所有被工程化改造的物种都极度倾向于追随奥拉利斯，必须绝对服从他们。\
		沃克斯或许是银河中最古老的种族之一，乘坐巨大的方舟舰漂流于群星之间，常常散布在广袤的宇宙各处。\
		然而，奥拉利斯对整个银河而言几乎完全未知，因为“沃克斯”这一称谓几乎只落在原始沃克斯身上。",
		"原始沃克斯不仅是形体，更是一种被称为“皮层堆栈”的生物机械实体。没有堆栈的身体不过是一具空壳。\
		在方舟舰上协调可用堆栈的任务交给至高者——一台编织进舰船系统的强大生物计算机。\
		普通的原始沃克斯是爬行类鸟形生物，头顶长着僵硬、半刚性的角质羽刺，有一条长而可卷握的尾巴，喙中排列着倾斜的牙齿。\
		它们通常有两条舌头，一条位于口腔顶部，另一条位于下颌，使它们能轻松说出复杂的沃克斯语。\
		原始沃克斯通常并不需要过节俭的生活，尽管它们倾向于如此。",
		"原始沃克斯的身高差异极大，小至三英尺，大到十英尺——后者是活体搬运重型设备的个体。只要皮层堆栈完好无损，\
		死亡便只是一种不便。堆栈可在数分钟至数小时内转移到新的身体，几乎立刻就能运作。若堆栈受损，\
		沃克斯便会经历自我消亡，即其“真正的死亡”。即使此时堆栈还能修复，人格也无法恢复。原始沃克斯是为特定目的而创造的，\
		皮层堆栈中灌注了所需的技能。原始沃克斯仍须练习手艺、磨练技能，尽管与人类相比它们总是天生的奇才。\
		沃克斯的生活刻板僵硬，在这个万物各安其位、皆处于阿玛利斯种姓之下的社会里几乎没有晋升余地，阿玛利斯是为战斗而生的种姓。",
		"阿玛利斯完全依赖至高者的灵能网络才能运作，颇似人工智能与其半机械人。\
		因此，阿玛利斯永远无法远离自己的舰船，因为所有高级脑功能都会实际停止。它们并未被赋予自由意志这一恩赐。\
		方舟舰所需不多，但仍有用得着贸易的地方。沃克斯的生物工程无出其右，使其成为换取研究的绝佳筹码，\
		而方舟舰往往愿意用零散的知识换取资源援助与工程协助。奥拉利斯甚至会与银河中的实体签约，让原始沃克斯\
		为其持续供应资源，尽管这常被视为近乎薪资奴役的剥削。"
	)

/datum/species/vox/prepare_human_for_preview(mob/living/carbon/human/vox)
	vox.dna.features[FEATURE_MUTANT_COLOR] = "#77DD88"
	vox.dna.features[FEATURE_MUTANT_COLOR_TWO] = "#EEDD88"
	vox.dna.features[FEATURE_MUTANT_COLOR_THREE] = "#222222"
	vox.dna.mutant_bodyparts[FEATURE_SNOUT] = list(MUTANT_INDEX_NAME = "Vox Snout", MUTANT_INDEX_COLOR_LIST = list("#EEDD88"))
	regenerate_organs(vox, src, visual_only = TRUE)
	vox.update_body(TRUE)

/obj/item/organ/eyes/vox
	name = "沃克斯眼睛"
	eye_icon = 'modular_skyrat/modules/organs/icons/vox_eyes.dmi'
