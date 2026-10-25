/mob/living/basic/spaceman
	name = "太空人"
	desc = "这到底是什么鬼……？"
	icon = 'icons/mob/simple/animal.dmi'
	icon_state = "old"
	icon_living = "old"
	icon_dead = "old_dead"
	icon_gib = "clown_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	gender = MALE
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "挥拳"
	response_harm_simple = "挥拳"
	combat_mode = TRUE
	maxHealth = 100
	health = 100
	speed = 0
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "击打"
	attack_verb_simple = "击打"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	ai_controller = /datum/ai_controller/basic_controller/spaceman

/mob/living/basic/spaceman/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)

/datum/ai_controller/basic_controller/spaceman
	behavior_tree_json = "code/modules/mob/living/basic/space_fauna/spaceman.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
