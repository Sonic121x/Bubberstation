#define MONKEY_SPEC_ATTACK_BITE_MISS_CHANCE 25

/datum/species/monkey
	name = "\improper 猴子"
	id = SPECIES_MONKEY
	mutant_organs = list(
		/obj/item/organ/tail/monkey = "Monkey",
	)
	mutanttongue = /obj/item/organ/tongue/monkey
	mutantbrain = /obj/item/organ/brain/primate
	skinned_type = /obj/item/stack/sheet/animalhide/carbon/monkey
	meat = /obj/item/food/meat/slab/monkey
	knife_butcher_results = list(/obj/item/food/meat/slab/monkey = 5, /obj/item/stack/sheet/animalhide/carbon/monkey = 1)
	inherent_traits = list(
		TRAIT_NO_BLOOD_OVERLAY,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_UNDERWEAR,
		TRAIT_LESSER_HUMANOID,
		TRAIT_SIMIAN,
	)
	no_equip_flags = ITEM_SLOT_OCLOTHING | ITEM_SLOT_GLOVES | ITEM_SLOT_FEET | ITEM_SLOT_SUITSTORE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | ERT_SPAWN | SLIME_EXTRACT
	species_cookie = /obj/item/food/grown/banana
	inherent_factions = list(FACTION_MONKEY)
	sexes = FALSE
	species_language_holder = /datum/language_holder/monkey

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/monkey,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/monkey,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/monkey,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/monkey,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/monkey,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/monkey,
	)
	fire_overlay = "monkey"
	gib_anim = "gibbed-m"

//	payday_modifier = 1.5  BUBBER DUMB SHIT REMOVAL
	ai_controlled_species = TRUE

/datum/species/monkey/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	if (pref_load)
		ADD_TRAIT(human_who_gained_species, TRAIT_BORN_MONKEY, INNATE_TRAIT) // Not a species trait, you cannot escape your genetic destiny
	human_who_gained_species.dna.add_mutation(/datum/mutation/race, MUTATION_SOURCE_ACTIVATED)

/datum/species/monkey/on_species_loss(mob/living/carbon/human/C)
	. = ..()
	C.dna.remove_mutation(/datum/mutation/race, MUTATION_SOURCE_ACTIVATED)

/datum/species/monkey/check_roundstart_eligible()
	// STOP ADDING MONKEY SUBTYPES YOU HEATHEN
	// ok we killed monkey subtypes but we're keeping this in cause we can't trust you fuckers
	if(check_holidays(MONKEYDAY) && id == SPECIES_MONKEY)
		return TRUE
	return ..()

/datum/species/monkey/get_physical_attributes()
	return "猴子身形灵活，能爬进通风管道，而且比人类更灵巧……但仅限于偷东西的时候。\
		天生的猴子无法用爪子操作机械或大多数工具，但异常聪明的猴子，或是曾经是其他东西的猴子则可以。"

/datum/species/monkey/get_species_description()
	return "猴子是灵长类动物，在进化链上介于人类与动物之间。\
		每年猴子日，纳米传讯都会允许这些小家伙在站内自由活动，以此表达对他们的尊重。"

/datum/species/monkey/get_species_lore()
	return list(
		"在十三号空间站上，猴子常被用作实验对象。\
		可要是……有那么一天……猴子被允许来当科学家呢？\
		他们会想出什么实验？会不会（按刻板印象）在某种程度上与香蕉有关？\
		唯一的办法就是亲眼看看。",
	)

/datum/species/monkey/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "spider",
			SPECIES_PERK_NAME = "管道爬行",
			SPECIES_PERK_DESC = "猴子可以不穿任何衣物爬过通风管道与洗涤器管网。\
				别靠近厨房！",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "paw",
			SPECIES_PERK_NAME = "原始灵长类",
			SPECIES_PERK_DESC = "猴子是原始的人类，大多数人类能做的事他们都做不到。计算机对他们来说绝无可能，\
				复杂机械更是免谈，而且大多数衣服都穿不进你较小的身躯。",
		),
	)

	return to_add

/datum/species/monkey/create_pref_language_perk()
	var/list/to_add = list()
	// Holding these variables so we can grab the exact names for our perk.
	var/datum/language/common_language = /datum/language/common
	var/datum/language/monkey_language = /datum/language/monkey

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "comment",
		SPECIES_PERK_NAME = "原始语言",
		SPECIES_PERK_DESC = "你或许能听懂 [initial(common_language.name)]，但无法说出它。 \
			你只能说 [initial(monkey_language.name)]。",
	))

	return to_add

/obj/item/organ/brain/primate //Ook Ook
	name = "灵长类大脑"
	desc = "这块肉很小，但枕叶发达，便于发现香蕉。"
	organ_traits = list(TRAIT_CAN_STRIP, TRAIT_PRIMITIVE, TRAIT_GUN_NATURAL) // No literacy or advanced tool usage.
	actions_types = list(/datum/action/item_action/organ_action/toggle_trip)
	/// Will this monkey stumble if they are crossed by a simple mob or a carbon in combat mode? Toggable by monkeys with clients, and is messed automatically set to true by monkey AI.
	var/tripping = TRUE

/obj/item/organ/brain/primate/get_replaceability(obj/item/organ/new_organ_type, obj/item/organ/expected_organ_type, datum/species/old_species, replace_current = TRUE)
	///Real monkeys retain their ape brains when humanized (further species change can override it). If old_species is null,
	if(HAS_TRAIT(owner, TRAIT_BORN_MONKEY) && (!old_species || istype(old_species, /datum/species/monkey)))
		return FALSE
	return ..()

/datum/action/item_action/organ_action/toggle_trip
	name = "切换绊倒"
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "lesser_form"
	background_icon_state = "bg_default_on"
	overlay_icon_state = "bg_default_border"

/datum/action/item_action/organ_action/toggle_trip/do_effect(trigger_flags)
	var/obj/item/organ/brain/primate/monkey_brain = target
	if(monkey_brain.tripping)
		monkey_brain.tripping = FALSE
		background_icon_state = "bg_default"
		to_chat(monkey_brain.owner, span_notice("你与处于战斗模式的人相撞时将不会再绊倒。"))
	else
		monkey_brain.tripping = TRUE
		background_icon_state = "bg_default_on"
		to_chat(monkey_brain.owner, span_notice("你与处于战斗模式的人相撞时将会绊倒。"))
	build_all_button_icons()
	return TRUE

/obj/item/organ/brain/primate/on_mob_insert(mob/living/carbon/primate)
	. = ..()
	RegisterSignal(primate, COMSIG_LIVING_MOB_BUMPED, PROC_REF(on_mob_bump))
	primate.AddElement(/datum/element/human_biter)

/obj/item/organ/brain/primate/on_mob_remove(mob/living/carbon/primate)
	. = ..()
	UnregisterSignal(primate, COMSIG_LIVING_MOB_BUMPED)
	primate.RemoveElement(/datum/element/human_biter)

/obj/item/organ/brain/primate/proc/on_mob_bump(mob/source, mob/living/crossing_mob)
	SIGNAL_HANDLER
	if(!tripping || !crossing_mob.combat_mode)
		return
	if(crossing_mob.mob_size < MOB_SIZE_HUMAN)
		return
	if(ishuman(crossing_mob))
		var/mob/living/carbon/human/crossing_humie = crossing_mob
		if(crossing_humie.mob_height <= HUMAN_HEIGHT_SHORTEST)
			return
	crossing_mob.knockOver(owner)

/obj/item/organ/brain/primate/get_attacking_limb(mob/living/carbon/human/target)
	if(!HAS_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER) || HAS_TRAIT(owner, TRAIT_FERAL_BITER))
		return owner.get_bodypart(BODY_ZONE_HEAD)
	return ..()

#undef MONKEY_SPEC_ATTACK_BITE_MISS_CHANCE
