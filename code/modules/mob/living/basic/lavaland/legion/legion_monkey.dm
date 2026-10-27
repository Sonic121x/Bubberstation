/// Weak mob spawned if a legion infests a monkey
/mob/living/basic/mining/legion/monkey
	name = "暴民"
	desc = "在翻涌的腐化团块之下，你能看出那曾经是一只猴子。它的生物量不足以进行繁殖。"
	icon_state = "legion_monkey"
	pass_flags = PASSTABLE
	speed = 5
	maxHealth = 40
	health = 40
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "撕咬"
	attack_verb_simple = "撕咬"
	attack_vis_effect = ATTACK_EFFECT_BITE
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("吱吱尖叫")
	corpse_type = /obj/effect/mob_spawn/corpse/human/monkey
	ai_controller = /datum/ai_controller/basic_controller/legion_monkey

/mob/living/basic/mining/legion/monkey/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	AddComponent(/datum/component/regenerator, outline_colour = COLOR_SOFT_RED)

/mob/living/basic/mining/legion/monkey/assign_abilities()
	return

/mob/living/basic/mining/legion/monkey/get_loot_list()
	return

/// Icebox variant
/mob/living/basic/mining/legion/monkey/snow
	name = "雪地暴民"
	desc = "在压实厚重的雪层下，你能看出那曾经是一只猴子。它看起来可不太友好。"
	icon = 'icons/mob/simple/icemoon/icemoon_monsters.dmi'
	icon_state = "snow_monkey"
	has_emissive = FALSE

/mob/living/basic/mining/legion/monkey/snow/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/appearance_on_aggro, aggro_state = "snow_monkey_alive") // Surprise! I was real!

/// Opportunistically hops in and out of vents, if it can find one and is not biting someone.
/datum/ai_controller/basic_controller/legion_monkey
	behavior_tree_json = "code/modules/mob/living/basic/lavaland/legion/legion_monkey.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_VENTCRAWL_COOLDOWN = 20 SECONDS,
		BB_TIME_TO_GIVE_UP_ON_VENT_PATHING = 30 SECONDS,
	)

	ai_traits = DEFAULT_AI_FLAGS | STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
