/datum/species/shadow
	// Humans cursed to stay in the darkness, lest their life forces drain. They regain health in shadow and die in light.
	name = "暗影人"
	plural_form = "暗影人"
	id = SPECIES_SHADOW
	sexes = FALSE
	meat = /obj/item/food/meat/slab/human/mutant/shadow
	inherent_traits = list(
		TRAIT_NOBREATH,
		TRAIT_RADIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOBLOOD,
		TRAIT_NODISMEMBER,
		TRAIT_NEVER_WOUNDED
	)
	inherent_factions = list(FACTION_FAITHLESS)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC

	mutantbrain = /obj/item/organ/brain/shadow
	mutanteyes = /obj/item/organ/eyes/shadow
	mutanttongue = /obj/item/organ/tongue/shadow
	mutantheart = null
	mutantlungs = null

	species_language_holder = /datum/language_holder/shadowpeople
	examine_limb_id = SPECIES_SHADOW // SKYRAT EDIT: Fixing Shadowpeople
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/shadow,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/shadow,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/shadow,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/shadow,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/shadow,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/shadow,
	)

/datum/species/shadow/on_species_gain(mob/living/carbon/carbon_mob, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	RegisterSignal(carbon_mob, COMSIG_MOB_FLASH_OVERRIDE_CHECK, PROC_REF(on_flashed))

/datum/species/shadow/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(human, COMSIG_MOB_FLASH_OVERRIDE_CHECK)

/datum/species/shadow/check_roundstart_eligible()
	if(check_holidays(HALLOWEEN))
		return TRUE
	return ..()

/datum/species/shadow/get_physical_attributes()
	return "这些被诅咒的生物在黑暗中治愈，在光明中却会遭受严重得多的痛苦。他们的眼睛能让他们在黑暗中视物如白昼。"

/datum/species/shadow/get_species_description()
	return "他们是早已灭绝的外星生物的受害者。他们的血肉是病态的 \
		半透明丝状物，纠缠的内脏清晰可见。他们的形态 \
		是对生命的嘲弄，这使他们在正常情况 \
		下大多无法与他人共事。"

/datum/species/shadow/get_species_lore()
	return list(
		"很久以前，顺旋星区曾栖息着可怕的外星生物，因其对黑暗的掌控以及把受害者绑架进幽暗维护管道的习性，\
		他们被恰如其分地称为“暗影灵”。\
		约在 2558 年，纳米传讯对这些太空恐怖发动的长期战役以暗影灵彻底灭绝告终。",

		"被绑架的受害者会变成没有心智的奴仆，通过手术可以让他们摆脱暗影灵的控制。\
		那些更不幸的人则会被暗影灵改造整个身体，以便更好地执行绑架。\
		与低等控制所用的脑瘤不同，这些高阶奴仆无法被逆转。",

		"暗影灵早已消亡，他们的意志重归自己。但他们的身体并未复原，一暴露在光下便会灼烧。\
		纳米传讯向受害者保证正在寻找治疗方法。然而多年过去，也没有更进一步的消息。\
		如今大多数暗影人认为纳米传讯早已搁置了这个项目。",
	)

/datum/species/shadow/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "moon",
			SPECIES_PERK_NAME = "暗影之躯",
			SPECIES_PERK_DESC = "他们的皮肤在黑暗中焕发生机。只要没有光，\
				任何种类的伤害无论多么严重，都会随时间痊愈。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "eye",
			SPECIES_PERK_NAME = "夜视",
			SPECIES_PERK_DESC = "他们的眼睛适应了夜晚，能在黑暗中毫无困难地视物。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "sun",
			SPECIES_PERK_NAME = "光灼",
			SPECIES_PERK_DESC = "他们的血肉在光下枯萎。任何光照对暗影人来说 \
				都痛苦无比，会烧焦他们的皮肤。",
		),
	)

	return to_add

/obj/item/organ/eyes/shadow
	name = "燃烧的红眼"
	desc = "即便离开了那个暗影般的主人，注视着这对眼睛仍会让你心生恐惧。"
	icon = 'icons/obj/medical/organs/shadow_organs.dmi'
	iris_overlay = null
	color_cutoffs = list(20, 10, 40)
	pepperspray_protect = TRUE
	flash_protect = FLASH_PROTECTION_SENSITIVE

/// the key to none of their powers
/obj/item/organ/brain/shadow
	name = "暗影灵肿瘤"
	desc = "这曾是大脑的一部分，在暗影灵的改造下重塑成形。它已不可逆地适应了黑暗。"
	icon = 'icons/obj/medical/organs/shadow_organs.dmi'
	shade_color = "grey-ish"

/datum/species/shadow/proc/on_flashed(source, mob/living/carbon/flashed, flash, deviation)
	SIGNAL_HANDLER

	if(deviation == DEVIATION_FULL) //If no deviation, we can assume it's a non-assembly flash and should do max flash damage.
		flashed.apply_damage(16, BURN, attacking_item = flash)
		flashed.adjust_confusion_up_to(3 SECONDS, 6 SECONDS)
	else //If it's anything less than a full hit, it does less than stellar damage. Bear in mind that this damage is dished out much faster since flashes have a quicker cooldown on clicks.
		flashed.apply_damage(8, BURN, attacking_item = flash)
		flashed.adjust_confusion_up_to(1 SECONDS, 3 SECONDS)

	INVOKE_ASYNC(flashed, TYPE_PROC_REF(/mob, emote), "scream")
	flashed.visible_message(span_danger("[flashed] 因一道闪光烧焦了血肉而痛苦哀号！"), \
		span_danger("突如其来的闪光烧焦了你的血肉，你痛苦地哀号！"), \
		span_danger("有什么东西在痛苦地哀号！听起来像只可怕的怪物！幸好你看不见它，不然现在大概已经吓坏了。"))

	return FLASH_OVERRIDDEN
