/datum/species/shadekin
	name = "\improper 影裔"
	id = SPECIES_SHADEKIN
	mutanttongue = /obj/item/organ/tongue/shadekin
	mutantears = /obj/item/organ/ears/shadekin
	mutantbrain = /obj/item/organ/brain/shadekin
	mutanteyes = /obj/item/organ/eyes/shadekin
	mutant_bodyparts = list()
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/shadekin,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/shadekin,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/shadekin,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/shadekin,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/shadekin,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/shadekin,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_NODROWN,
		TRAIT_SLICK_SKIN,
		TRAIT_MUTANT_COLORS,
		TRAIT_NIGHT_VISION,
		TRAIT_NOBREATH

	)
	species_language_holder = /datum/language_holder/shadekin


/datum/species/shadekin/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "lightbulb",
		SPECIES_PERK_NAME = "黑暗再生",
		SPECIES_PERK_DESC = "影裔在黑暗中会再生身体伤口。"
	))

	return to_add

/datum/species/shadekin/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Shadekin", TRUE),
		"snout" = list("None", FALSE),
		"ears" = list("Shadekin", TRUE),
		"legs" = list("Normal Legs", TRUE),
	)

/datum/species/shadekin/randomize_features()
	var/list/features = ..()
	var/main_color
	var/secondary_color
	var/tertiary_color
	var/random = rand(1, 4)
	switch(random)
		if(1)
			main_color = "#202020"
			secondary_color = "#505050"
			tertiary_color = "#3f3f3f"
		if(2)
			main_color = "#CF3565"
			secondary_color = "#d93554"
			tertiary_color = "#fbc2dd"
		if(3)
			main_color = "#FFC44D"
			secondary_color = "#FFE85F"
			tertiary_color = "#FFF9D6"
		if(4)
			main_color = "#DB35DE"
			secondary_color = "#BE3AFE"
			tertiary_color = "#F5E2EE"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	return features

/datum/species/shadekin/prepare_human_for_preview(mob/living/carbon/human/shadekin)
	var/main_color = "#222222"
	var/secondary_color = "#b8b8b8"
	var/tertiary_color = "#b8b8b8"
	shadekin.dna.features[FEATURE_MUTANT_COLOR] = main_color
	shadekin.dna.features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	shadekin.dna.features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	shadekin.dna.mutant_bodyparts[FEATURE_EARS] = list(MUTANT_INDEX_NAME = "Shadekin", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts[FEATURE_SNOUT] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts[FEATURE_TAIL_GENERIC] = list(MUTANT_INDEX_NAME = "Shadekin", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.set_eye_color("#5ec7e4")
	regenerate_organs(shadekin, src, visual_only = TRUE)
	shadekin.update_body(TRUE)

/datum/species/shadekin/get_species_description()
	return list(
		"影裔最初就像床底积聚的灰尘团一样诞生，集体意识中 \
		“欢迎，同胞，”是他们在思想之海中感受到的第一句话，引导他们建立最初的连接",
		"影裔不进行呼吸，他们的身体会在黑暗中重塑，尽管十分脆弱。"
	)

/datum/species/shadekin/get_species_lore()
	return list(
		"目前尚不清楚影裔最初究竟何时诞生，但据推测是相对晚近的发展。\
		他们形成于无人目击的黑暗废弃之处——被观察会驱散他们的创生。\
		当过程完成时，影裔从周围的心灵中收集到移动肢体和沟通的能力，\
		最后形成了第一个念头：意识到自己活着。",

		"影裔是获得形态的漆黑。光似乎会穿过他们的身体，这令他们疲惫。他们不会投下影子。\
		影裔在体型和外观上难以定义，因为没有两个影裔是相同的——他们往往会借用周围物种的特征，\
		那些特征本不会被视为属于他们。例如，在提兹拉诞生的影裔往往有角或褶边状的耳朵。\
		普通影裔比人类略矮，寿命相近。不采用其他种族命名习惯的影裔，\
		往往会依据自己在社群中的位置来命名，比如职业或社会职能。",

		"影裔能够进行有性繁殖，但他们的心智需要多样化的环境才能正常发育，因此他们相当自主。\
		尽管如此，影裔很容易找到属于自己的位置，并成为社群中不可或缺的一员。他们比其他种族更善于表达，以弥补灵能连接的缺失。\
		他们的语言“玛瑞什”纯粹依靠共情传递，精神病态者无法说出。他们的眼睛颜色是生物学上的重要部分，因为能显示性情。",

		"然而，影裔从不真正孤单，因为许多影裔已在险恶的卫星尼奥玛上成形，那里黑暗而与世隔绝。\
		虽然影裔没有中央政府，但这里已是他们最接近母星的地方；由于环绕极端炽热的世界卢辛运行，尼奥玛表面接近宜居，却没有光。\
		在少数可居住区域，这里已成为著名的旅游景点。尼奥玛还承担着保存影裔社会及其巫团集体知识的重要功能。",

		"巫团是由影裔组成的群体，用于维持自身、记录自身的存在，并在新影裔成长时加以引导。\
		它们很少仅与意识形态相关，而更多与概念及其含义相关；巫团内部还有“小团”，即巫团中针对特定方面的兴趣小组。\
		从这个意义上说，巫团本身就是社会，以某种部落方式组织。巫团并不只存在于尼奥玛，它们遍布宇宙，\
		但大多数巫团至少在这颗卫星上设有档案馆，称为“心灵信托”。",
	)

/obj/item/organ/brain/shadekin
	name = "影裔大脑"
	desc = "一个神秘的大脑。"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-x-d"
	var/applied_status = /datum/status_effect/shadekin_regeneration

/obj/item/organ/brain/shadekin/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/turf/owner_turf = owner.loc
	if(!isturf(owner_turf))
		return
	var/light_amount = owner_turf.get_lumcount()

	if (light_amount < SHADOW_SPECIES_LIGHT_THRESHOLD) // heal in the dark
		owner.apply_status_effect(applied_status)
	else
		return

/datum/status_effect/shadekin_regeneration
	id = "shadekin_regeneration"
	duration = 2 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/shadekin_regeneration

/datum/status_effect/shadekin_regeneration/on_apply()
	. = ..()
	if (!.)
		return FALSE
	heal_owner()
	return TRUE

/datum/status_effect/shadekin_regeneration/refresh(effect)
	. = ..()
	heal_owner()

/datum/status_effect/shadekin_regeneration/proc/heal_owner()
	owner.heal_overall_damage(brute = 0.5, burn = 0.5, required_bodytype = BODYTYPE_ORGANIC)

/atom/movable/screen/alert/status_effect/shadekin_regeneration
	name = "黑暗再生"
	desc = "你感到皮毛上传来家的牵引，一股舒缓的暖意前来减轻你的负担。"
	icon_state = "lightless"
