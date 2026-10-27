/mob/living/basic/bat
	name = "太空蝙蝠"
	desc = "一种栖居在飞船里的稀有蝙蝠，大概不是吸血鬼。"
	icon_state = "bat"
	icon_living = "bat"
	icon_dead = "bat_dead"
	icon_gib = "bat_dead"

	maxHealth = 15
	health = 15
	melee_damage_lower = 5
	melee_damage_upper = 6

	response_help_continuous = "拨开"
	response_help_simple = "拨开"
	response_disarm_continuous = "胡乱拍打"
	response_disarm_simple = "胡乱拍打"
	attack_verb_continuous = "啃咬"
	attack_verb_simple = "啃咬"
	verb_say = "吱吱叫"

	faction = list(FACTION_HOSTILE)
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	butcher_results = list(/obj/item/food/meat/slab = 1)
	pass_flags = PASSTABLE

	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	environment_smash = ENVIRONMENT_SMASH_NONE
	mob_size = MOB_SIZE_TINY
	obj_damage = 0
	unsuitable_atmos_damage = 0

	ai_controller = /datum/ai_controller/basic_controller/space_bat

/mob/living/basic/bat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/simple_flying)
	AddElement(/datum/element/ai_retaliate)
	add_traits(list(TRAIT_SPACEWALK, TRAIT_VENTCRAWLER_ALWAYS, TRAIT_NO_MIRROR_REFLECTION), INNATE_TRAIT)

///Controller for space bats, has nothing unique, just retaliation.
/datum/ai_controller/basic_controller/space_bat
	behavior_tree_json = "code/modules/mob/living/basic/vermin/space_bat.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance
