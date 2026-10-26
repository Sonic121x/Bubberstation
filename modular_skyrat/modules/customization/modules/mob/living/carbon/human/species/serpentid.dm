#define BASE_CLOTH_X_1 1
#define BASE_CLOTH_Y_1 1

#define SERPENTID_COLD_THRESHOLD_1 180
#define SERPENTID_COLD_THRESHOLD_2 140
#define SERPENTID_COLD_THRESHOLD_3 100

#define SERPENTID_HEAT_THRESHOLD_1 300
#define SERPENTID_HEAT_THRESHOLD_2 440
#define SERPENTID_HEAT_THRESHOLD_3 600

/datum/species/gas
	name = "\improper 巨型装甲蛇形虫"
	id = SPECIES_GAS
	eyes_icon = 'modular_skyrat/modules/organs/icons/serpentid_eyes.dmi'
	can_augment = FALSE

	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
		TRAIT_PUSHIMMUNE,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_MUTANT_COLORS,
		TRAIT_NO_UNDERWEAR,
		TRAIT_NO_SLIP_ALL,
	)

	no_equip_flags = ITEM_SLOT_FEET | ITEM_SLOT_OCLOTHING | ITEM_SLOT_SUITSTORE
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	no_gender_shaping = TRUE

	always_customizable = FALSE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 10)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 25)

	mutantbrain = /obj/item/organ/brain/serpentid
	mutanteyes = /obj/item/organ/eyes/serpentid
	mutantlungs = /obj/item/organ/lungs/serpentid
	mutantheart = /obj/item/organ/heart/serpentid
	mutantliver = /obj/item/organ/liver/serpentid
	mutantears = /obj/item/organ/ears/serpentid
	mutanttongue = /obj/item/organ/tongue/synth/serpentid
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/serpentid,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/serpentid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/serpentid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/serpentid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/serpentid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/serpentid,
	)
	custom_worn_icons = list(
		LOADOUT_ITEM_HEAD = SERPENTID_HEAD_ICON,
		LOADOUT_ITEM_MASK = SERPENTID_MASK_ICON,
		LOADOUT_ITEM_UNIFORM = SERPENTID_UNIFORM_ICON,
		LOADOUT_ITEM_HANDS = SERPENTID_HANDS_ICON,
		LOADOUT_ITEM_GLASSES = SERPENTID_EYES_ICON,
		LOADOUT_ITEM_BELT = SERPENTID_BELT_ICON,
		LOADOUT_ITEM_MISC = SERPENTID_BACK_ICON,
		LOADOUT_ITEM_EARS = SERPENTID_EARS_ICON
	)

/datum/species/gas/randomize_features()
	var/list/features = ..()
	var/main_color
	var/random = rand(1, 6)
	switch(random)
		if(1)
			main_color = "#44FF77"
		if(2)
			main_color = "#227900"
		if(3)
			main_color = "#c40000"
		if(4)
			main_color = "#660000"
		if(5)
			main_color = "#c0ad00"
		if(6)
			main_color = "#e6ff03"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = main_color
	features[FEATURE_MUTANT_COLOR_THREE] = main_color
	return features

/datum/species/gas/prepare_human_for_preview(mob/living/carbon/human/serpentid)
	var/serpentid_color = "#00ac1d"
	serpentid.dna.features[FEATURE_MUTANT_COLOR] = serpentid_color
	serpentid.dna.features[FEATURE_MUTANT_COLOR_TWO] = serpentid_color
	serpentid.dna.features[FEATURE_MUTANT_COLOR_THREE] = serpentid_color
	regenerate_organs(serpentid, src, visual_only = TRUE)
	serpentid.update_body(TRUE)

/datum/species/gas/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHIELD,
		SPECIES_PERK_NAME = "坚韧甲壳",
		SPECIES_PERK_DESC = "巨型装甲蛇形虫的甲壳极为坚韧，能保护它们免受压力与低温危害，同时还提供不错的钝击抗性。"
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_WEIGHT_HANGING,
		SPECIES_PERK_NAME = "沉重骨骼",
		SPECIES_PERK_DESC = "巨型装甲蛇形虫体型庞大而沉重，这使它们极擅长避免滑倒和被抓住。"
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_USER_NINJA,
		SPECIES_PERK_NAME = "主动伪装",
		SPECIES_PERK_DESC = "巨型装甲蛇形虫体内的细胞能在一定程度上自我伪装，使 GAS 在肉眼看来呈半透明状。"
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_EYE,
		SPECIES_PERK_NAME = "遮蔽式眼睛",
		SPECIES_PERK_DESC = "巨型装甲蛇形虫的眼睛十分敏感，所幸它们有眼罩可以弥补这一点。"
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_FACE_ANGRY,
		SPECIES_PERK_NAME = "威吓展示",
		SPECIES_PERK_DESC = "巨型装甲蛇形虫不擅长交流，但它们可以做出威吓展示，表示自己想要攻击某人。"
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "特化身体",
		SPECIES_PERK_DESC = "巨型装甲蛇形虫的身体并非人形，无法穿戴大多数衣物。"
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_TEMPERATURE_HALF,
		SPECIES_PERK_NAME = "冷血",
		SPECIES_PERK_DESC = "巨型装甲蛇形虫是冷血物种，容易受到所处环境温度变化的影响。"
	))

	return perk_descriptions

/datum/species/gas/get_species_description()
	return list(
		"巨型装甲蛇形虫（通常简称 GAS）是来自提兹拉帝国某颗行星的大型昆虫类生物。\
		它们是出色的猎手，具备惊人的潜行能力，但在交流技巧上有所欠缺。"
	)

/datum/species/gas/get_species_lore()
	return list(
		"巨型装甲蛇形虫是提兹拉帝国一颗高重力星球上的古老昆虫类种族。\
		它们全身覆盖着交错的鳞片，以一对巨爪作为主要肢体，外形隐约类似地球的螳螂，但从地球人的角度来看，\
		它们与蛇及其他爬行动物的共同点更多。",
		"GAS 是纳米传讯对它们的称呼。它们以半蜂巢、半群落的方式生活，与大多数物种相比缺乏自我认同，\
		很少有名字。不过其他种族通常会无视这一点，为了便于交流，常常会给正在共事的个体起一个名字。\
		虽然它们与其他 GAS 一同生活在大型群落中，数量最多可达两百只、极少超过，但它们并不在意与多数个体的\
		身体接触，更希望独处并被给予私人空间，因此当其他物种的无知成员做出握手或拥抱这类正常举动时，\
		它们看起来甚至会显得具有攻击性。"
	)
/datum/species/gas/body_temperature_core(mob/living/carbon/human/humi, seconds_per_tick, times_fired)
	return

/obj/item/organ/ears/serpentid
	name = "触角"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "ears"

/obj/item/organ/heart/serpentid
	name = "蛇形虫心脏"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "heart"
	actions_types = list(/datum/action/cooldown/spell/toggle_active_camo)
	var/camouflaged = FALSE

/obj/item/organ/heart/serpentid/proc/toggle_camo()
	if(!camouflaged)
		owner.alpha = 100
		camouflaged = TRUE
	else
		owner.alpha = 255
		camouflaged = FALSE

/obj/item/organ/brain/serpentid
	name = "分布式神经系统"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "brain"
	actions_types = list(/datum/action/cooldown/spell/toggle_threat_display)

/obj/item/organ/eyes/serpentid
	name = "复眼"
	desc = "小小的橙色球体。"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "eyes"
	flash_protect = FLASH_PROTECTION_HYPER_SENSITIVE
	iris_overlay = null
	blink_animation = FALSE
	eye_icon = 'modular_skyrat/modules/organs/icons/serpentid_eyes.dmi'
	eye_icon_state = "eyes"
	actions_types = list(/datum/action/cooldown/spell/toggle_eye_shields)
	var/eyes_shielded

/obj/item/organ/lungs/serpentid
	name = "气管"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	icon_state = "lungs"

	cold_message = "你每次呼吸都受不了这种刺骨严寒！"
	cold_level_1_threshold = SERPENTID_COLD_THRESHOLD_1
	cold_level_2_threshold = SERPENTID_COLD_THRESHOLD_2
	cold_level_3_threshold = SERPENTID_COLD_THRESHOLD_3
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_1
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_damage_type = BRUTE


	hot_message = "你每次呼吸都受不了这种灼热高温！"
	heat_level_1_threshold = SERPENTID_HEAT_THRESHOLD_1
	heat_level_2_threshold = SERPENTID_HEAT_THRESHOLD_2
	heat_level_3_threshold = SERPENTID_HEAT_THRESHOLD_3
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

/obj/item/organ/liver/serpentid
	name = "毒素过滤器"
	icon_state = "liver"
	icon = 'modular_skyrat/modules/organs/icons/serpentid_organs.dmi'
	liver_resistance = 0.8 * LIVER_DEFAULT_TOX_RESISTANCE // -40%

/obj/item
	var/datum/greyscale_config/greyscale_config_worn_serpentid_fallback

/datum/species/gas/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_gas

/datum/species/gas/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_gas = icon

/datum/species/gas/get_custom_worn_config_fallback(item_slot, obj/item/item)
	return item.greyscale_config_worn_serpentid_fallback

/datum/species/gas/generate_custom_worn_icon(item_slot, obj/item/item, mob/living/carbon/human/human_owner)
	. = ..()
	if(.)
		return

	. = generate_custom_worn_icon_fallback(item_slot, item, human_owner)
	if(.)
		return

/obj/item/clothing/under
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid

/obj/item/clothing/neck
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/scarf

/obj/item/clothing/neck/cloak
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/cloak

/obj/item/clothing/neck/tie
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/tie

/obj/item/clothing/gloves
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/gloves

/obj/item/clothing/glasses
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/eyes

/obj/item/clothing/belt
	species_clothing_color_coords = list(list(BASE_CLOTH_X_1, BASE_CLOTH_Y_1))
	greyscale_config_worn_serpentid_fallback = /datum/greyscale_config/serpentid/belt

#undef BASE_CLOTH_X_1
#undef BASE_CLOTH_Y_1

#undef SERPENTID_COLD_THRESHOLD_1
#undef SERPENTID_COLD_THRESHOLD_2
#undef SERPENTID_COLD_THRESHOLD_3

#undef SERPENTID_HEAT_THRESHOLD_1
#undef SERPENTID_HEAT_THRESHOLD_2
#undef SERPENTID_HEAT_THRESHOLD_3
