#define TESHARI_TEMP_OFFSET -10 // K, added to comfort/damage limit etc
#define TESHARI_HEATMOD 1.3
#define TESHARI_COLDMOD 0.67 // Except cold.

/datum/species/teshari
	name = "Teshari"
	plural_form = "Teshari"
	id = SPECIES_TESHARI
	no_gender_shaping = TRUE // Female uniform shaping breaks Teshari worn sprites, so this is disabled. This will not affect anything else in regards to gender however.
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
		TRAIT_NO_UNDERWEAR,
	)
	digitigrade_customization = DIGITIGRADE_NEVER
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 1.0
	mutanttongue = /obj/item/organ/tongue/teshari
	mutanteyes = /obj/item/organ/eyes/teshari
	custom_worn_icons = list(
		OFFSET_HEAD = TESHARI_HEAD_ICON,
		OFFSET_FACEMASK = TESHARI_MASK_ICON,
		OFFSET_NECK = TESHARI_NECK_ICON,
		OFFSET_SUIT = TESHARI_SUIT_ICON,
		OFFSET_UNIFORM = TESHARI_UNIFORM_ICON,
		OFFSET_GLOVES =  TESHARI_HANDS_ICON,
		OFFSET_SHOES = TESHARI_FEET_ICON,
		OFFSET_GLASSES = TESHARI_EYES_ICON,
		OFFSET_BELT = TESHARI_BELT_ICON,
		OFFSET_BACK = TESHARI_BACK_ICON,
		OFFSET_ACCESSORY = TESHARI_ACCESSORIES_ICON,
		OFFSET_EARS = TESHARI_EARS_ICON
	)
	coldmod = TESHARI_COLDMOD
	heatmod = TESHARI_HEATMOD
	bodytemp_normal = BODYTEMP_NORMAL + TESHARI_TEMP_OFFSET
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + TESHARI_TEMP_OFFSET)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT + TESHARI_TEMP_OFFSET)
	species_language_holder = /datum/language_holder/teshari
	mutantears = /obj/item/organ/ears/teshari
	mutantlungs = /obj/item/organ/lungs/adaptive/cold
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/teshari,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/teshari,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/teshari,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/teshari,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/teshari,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/teshari,
	)
	meat = /obj/item/food/meat/slab/chicken/human

/datum/species/teshari/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Teshari (Default)", TRUE),
		"ears" = list("Teshari Regular", TRUE),
		"legs" = list("Normal Legs", FALSE),
	)

/obj/item/organ/tongue/teshari
	name = "特沙利舌头"
	liked_foodtypes = SEAFOOD | VEGETABLES | NUTS
	disliked_foodtypes = GROSS | GRAIN
	emote_sounds = list(
		/datum/emote/living/scream::key = 'modular_skyrat/modules/emotes/sound/emotes/raptorscream.ogg'
	)

/obj/item/organ/eyes/teshari
	name = "特沙利眼睛"
	eye_icon = 'modular_skyrat/modules/organs/icons/teshari_eyes.dmi'
	blink_animation = FALSE

/datum/species/teshari/prepare_human_for_preview(mob/living/carbon/human/tesh)
	var/base_color = "#c0965f"
	var/ear_color = "#e4c49b"

	tesh.dna.features[FEATURE_MUTANT_COLOR] = base_color
	tesh.dna.mutant_bodyparts[FEATURE_EARS] = list(MUTANT_INDEX_NAME = "Teshari Feathers Upright", MUTANT_INDEX_COLOR_LIST = list(ear_color, ear_color, ear_color))
	tesh.dna.mutant_bodyparts[FEATURE_TAIL_GENERIC] = list(MUTANT_INDEX_NAME = "Teshari (Default)", MUTANT_INDEX_COLOR_LIST = list(base_color, base_color, ear_color))
	regenerate_organs(tesh, src, visual_only = TRUE)
	tesh.update_body(TRUE)

/datum/species/teshari/on_species_gain(mob/living/carbon/human/new_teshari, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	ADD_TRAIT(new_teshari, TRAIT_PASSTABLE, SPECIES_TRAIT)

/datum/species/teshari/on_species_loss(mob/living/carbon/C, datum/species/new_species, pref_load)
	. = ..()
	REMOVE_TRAIT(C, TRAIT_PASSTABLE, SPECIES_TRAIT)

/datum/species/teshari/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_RUNNING,
		SPECIES_PERK_NAME = "桌上奔行",
		SPECIES_PERK_DESC = "你身手极为敏捷，只要跑向桌子就能跃上桌面！"
	))

	return perk_descriptions

/datum/species/teshari/get_species_description()
	return list(
		"来自热带星球西里赛的鸟形种族。他们彻底毁灭了自己的压迫者，\
		以此登上银河舞台，而那些压迫者如今已消散在历史中。",
		"轻盈的体重赋予他们极高的敏捷性，但中空的骨骼也使他们更容易受伤。"
	)

/datum/species/teshari/get_species_lore()
	return list(
		"特沙利是来自热带世界西里赛的鸟形种族，通常身高约1.04至1.22米，\
		身体轻盈，长有丰满的羽毛和退化的翅膀。他们通常具有口鼻部，\
		但随着西里赛走出冰河时代，部分个体逐渐演化出喙状口鼻。特沙利色彩丰富，长有用于听觉的大耳朵。\
		他们通常在60至70岁时自然死亡，医疗护理可以显著延长寿命。\
		特沙利是杂食者，喜爱鱼类而不喜欢谷物，也偏爱坚果和植物。",
		"特沙利对社交的需求根植于基因，长时间完全不社交会令他们身体不适，\
		因此形成了称为“群落”的社会团体。他们通常没有固定的父母角色，而是\
		由集体共同抚养。成年后，他们会强烈地想离开出生的群落，寻找或建立新的群落。\
		初入新的社交环境时，他们往往内向安静；融入后则健谈热情，常喜欢发出或模仿各种声音。",
		"西里赛是一个热带世界，平均气温在20至30摄氏度之间。\
		星球上有三条主要山脉，是仅有的常年可见积雪的地方，最低气温可达零下15摄氏度。\
		整颗星球的生物多样性很高，相比许多有人居住的星球，生态也更加纯净。",
		"特沙利的现代史始于另一个种族发现并启蒙了他们，那个种族居住在西里赛曾经环绕的行星上。\
		多年遭受压迫、被当作劳动力贩卖后，特沙利发出最后通牒：服从，或毁灭。对方似乎没有认真对待威胁，\
		最终整颗行星被摧毁，种族随之灭绝。西里赛上已发现他们的化石；虽然尚无正式学名，\
		特沙利群落会议已通过民主表决，用特沙利语中“混蛋”一词为该种族命名。\
		不用说，这很快促成了关系正常化，并获得了当时NRI的正式承认。",
	)
