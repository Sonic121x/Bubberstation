/*
* ## Lizards
*
* Green things that crawl around and eat bugs. Not to be confused with the human species lizardpersons, these are just small little fellas.
*/

/mob/living/basic/lizard
	name = "蜥蜴"
	desc = "一只可爱的小蜥蜴。"
	icon_state = "lizard"
	icon_living = "lizard"
	icon_dead = "lizard_dead"
	icon_gib = "lizard_gib"
	speak_emote = list("发出嘶声")
	health = 10
	maxHealth = 10
	faction = list(FACTION_LIZARD)
	attack_verb_continuous = "啃咬"
	attack_verb_simple = "啃咬"
	melee_damage_lower = 1
	melee_damage_upper = 2
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "驱赶"
	response_disarm_simple = "驱赶"
	response_harm_continuous = "踩踏"
	response_harm_simple = "踩踏"
	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST|MOB_REPTILE
	gold_core_spawnable = FRIENDLY_SPAWN
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	held_w_class = WEIGHT_CLASS_TINY
	held_lh = 'icons/mob/inhands/animal_item_lefthand.dmi'
	held_rh = 'icons/mob/inhands/animal_item_righthand.dmi'
	worn_slot_flags = ITEM_SLOT_HEAD
	head_icon = 'icons/mob/clothing/head/pets_head.dmi'
	ai_controller = /datum/ai_controller/basic_controller/lizard

	/// Typecache of things that we seek out to eat. Yummy.
	var/static/list/edibles = typecacheof(list(
		/mob/living/basic/butterfly,
		/mob/living/basic/cockroach,
	))

/datum/emote/lizard
	abstract_type = /datum/emote/lizard
	mob_type_allowed_typecache = /mob/living/basic/lizard
	mob_type_blacklist_typecache = list()

/datum/emote/lizard/whicker
	key = "tongue"
	message = "满足地吐出舌头！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/mob/living/basic/lizard/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	AddElement(/datum/element/pet_bonus, "tongue")
	AddElement(/datum/element/can_be_held)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_LIZARD, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	AddElement(/datum/element/basic_eating, heal_amt = 5, food_types = edibles)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, typecacheof(edibles))

/datum/ai_controller/basic_controller/lizard
	behavior_tree_json = "code/modules/mob/living/basic/vermin/lizard.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance

//Subtypes of lizards follow.

/// Lizards that can survive in space.
/mob/living/basic/lizard/space
	name = "太空蜥蜴"
	desc = "一只戴着小小太空头盔的可爱小蜥蜴。"
	icon_state = "lizard_space"
	icon_living = "lizard_space"
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = TCMB
	maximum_survivable_temperature = T0C + 40

/// Janitor's pet lizard.
/mob/living/basic/lizard/wags_his_tail
	name = "摇尾巴"
	desc = "清洁部可靠的宠物蜥蜴。"

/// Another pet lizard for the janitor.
/mob/living/basic/lizard/eats_the_roaches
	name = "吃蟑螂"
	desc = "清洁部不太可靠的宠物蜥蜴。"
