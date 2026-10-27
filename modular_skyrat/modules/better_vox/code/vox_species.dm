/datum/species/vox_primalis
	name = "沃克斯"
	id = SPECIES_VOX_PRIMALIS
	can_augment = FALSE
	digitigrade_customization = DIGITIGRADE_NEVER // We have our own unique sprites!
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	mutantlungs = /obj/item/organ/lungs/nitrogen/vox
	mutantbrain = /obj/item/organ/brain/cybernetic/cortical/vox //BUBBER EDIT - new brain dropped
	mutanteyes = /obj/item/organ/eyes/vox_primalis
	mutant_bodyparts = list()
	meat = /obj/item/food/meat/slab/chicken/human //item file in teshari module
	mutanttongue = /obj/item/organ/tongue/vox
	payday_modifier = 1.0
	outfit_important_for_life = /datum/outfit/vox
	species_language_holder = /datum/language_holder/vox
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT

	// Vox are cold resistant, but also heat sensitive
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 15) // being cold resistant, should make you heat sensitive actual effect ingame isn't much
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 30)

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/vox_primalis,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/vox_primalis,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/vox_primalis,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/vox_primalis,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/vox_primalis,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/vox_primalis,
	)
	custom_worn_icons = list(
		OFFSET_HEAD = VOX_PRIMALIS_HEAD_ICON,
		OFFSET_FACEMASK = VOX_PRIMALIS_MASK_ICON,
		OFFSET_SUIT = VOX_PRIMALIS_SUIT_ICON,
		OFFSET_UNIFORM = VOX_PRIMALIS_UNIFORM_ICON,
		OFFSET_GLOVES =  VOX_PRIMALIS_GLOVES_ICON,
		OFFSET_SHOES = VOX_PRIMALIS_FEET_ICON,
		OFFSET_GLASSES = VOX_PRIMALIS_EYES_ICON,
		OFFSET_BELT = VOX_PRIMALIS_BELT_ICON,
		OFFSET_BACK = VOX_PRIMALIS_BACK_ICON,
		OFFSET_EARS = VOX_PRIMALIS_EARS_ICON,
	)

/datum/species/vox_primalis/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Vox Primalis Tail", FALSE),
	)

/datum/species/vox_primalis/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only)
	. = ..()
	if(job?.vox_outfit)
		equipping.equipOutfit(job.vox_outfit, visuals_only)
	else
		give_important_for_life(equipping)

/datum/species/vox_primalis/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_better_vox

/datum/species/vox_primalis/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_better_vox = icon

/datum/species/vox_primalis/get_species_description()
	return list(
		"在那些不知情者的描述中，沃克斯似乎是一个游牧的鸟形生物种族，依照“疯狂而做梦的神明”的吩咐，在人类太空及其周边活动。\
		真正的沃克斯是完全与世隔绝的沃克斯·奥拉利斯，是强大无比的灵能者与生物工程师。即便在最好的时候，他们也与人疏远。\
		这些沃克斯，即原始沃克斯，是奥拉利斯用来维持方舟舰运转的劳役下层，沿着一条曲折的踪迹穿行于银河。"
	)

/datum/species/vox_primalis/get_species_lore()
	return list(
		"沃克斯是一个由沃克斯·奥拉利斯领导的神权国家。所有在其之下被工程化培育的物种都极度倾向于追随奥拉利斯，他们必须绝对服从。\
		沃克斯或许是银河中最古老的种族之一，他们乘坐庞大的方舟舰在群星间漂泊，常常散布于广袤宇宙各处。\
		奥拉利斯甚至曾与银河中的各种势力签约，利用原始沃克斯来换取持续的资源供应。\
		然而，奥拉利斯对银河大众而言几乎完全不为人知，因为“沃克斯”这一称谓几乎只落在原始沃克斯身上。",
		"原始沃克斯不仅仅是肉体形态，更是一种被称为“皮层堆栈”的生物机械实体。没有堆栈的身体不过是一具空壳。\
		协调方舟舰上可用堆栈的任务交给“顶点”，一台编织进舰船系统的强大生物计算机。\
		普通的原始沃克斯是爬行类的鸟形生物，头顶长有坚硬、半刚性的角质棘刺，尾巴长而能卷握，鸟喙中排着成列的斜生牙齿。\
		他们通常有两条舌头，一条在上颚，一条在下颌，这让他们能轻松说出复杂的沃克斯语。\
		原始沃克斯一般并不需要过节俭的生活，尽管他们天生倾向于如此。",
		"原始沃克斯的身高差异极大，小到仅 3 英尺，大到 10 英尺，可充当重型设备的活体搬运工。只要皮层堆栈完好无损，\
		死亡就只是一种不便。堆栈可以在数分钟到数小时内转移到新的身体，并且几乎立刻就能恢复运作。如果堆栈受损，\
		沃克斯就会经历自我死亡，即其“真正的死亡”。即便到了这一步堆栈还能修复，人格也无法恢复。原始沃克斯生来就有其用途，\
		皮层堆栈中灌注了所需的技能。原始沃克斯仍需练习手艺、磨练技能，尽管与人类相比他们往往称得上天赋异禀。\
		沃克斯过着刻板的生活，在一个人人各安其位、皆受阿玛利斯——一个专为战斗而生的种姓——统辖的社会里，晋升空间十分有限。",
		"阿玛利斯完全依赖“顶点”的灵能网络才能运作，很像 AI 与它的半机械人们。\
		因此，阿玛利斯永远无法远离自己的舰船，否则一切高级脑功能实际上都会停止。他们并未被赐予自由意志。\
		方舟舰所需不多，但他们仍有商贸的需求。沃克斯的生物工程水平无人能及，这使其成为换取研究的绝佳筹码，\
		而方舟舰往往愿意用零散的知识来换取资源援助与工程协助。",
	)

/datum/species/vox_primalis/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	var/vox_color = human_who_gained_species.dna.features["vox_bodycolor"]
	if(!vox_color || vox_color == "default")
		return
	for(var/obj/item/bodypart/limb as anything in human_who_gained_species.bodyparts)
		limb.limb_id = "[SPECIES_VOX_PRIMALIS]_[vox_color]"
	human_who_gained_species.update_body()

/obj/item/organ/eyes/vox_primalis
	name = "沃克斯眼睛"
	eye_icon = 'modular_skyrat/modules/better_vox/icons/bodyparts/vox_eyes.dmi'
