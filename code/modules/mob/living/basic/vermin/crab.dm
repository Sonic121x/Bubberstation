//Look Sir, free crabs!
/mob/living/basic/crab
	name = "螃蟹"
	desc = "免费螃蟹！"
	icon_state = "crab"
	icon_living = "crab"
	icon_dead = "crab_dead"

	speak_emote = list("发出咔嗒声")
	melee_damage_lower = 2
	melee_damage_upper = 2
	mob_biotypes = MOB_ORGANIC|MOB_CRUSTACEAN|MOB_AQUATIC
	butcher_results = list(/obj/item/food/meat/slab/rawcrab = 2)
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "踩踏"
	response_harm_simple = "踩踏"
	friendly_verb_continuous = "夹住"
	friendly_verb_simple = "夹住"
	gold_core_spawnable = FRIENDLY_SPAWN
	mob_size = MOB_SIZE_SMALL
	///In the case 'melee_damage_upper' is somehow raised above 0
	attack_verb_continuous = "剪切"
	attack_verb_simple = "剪切"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	ai_controller = /datum/ai_controller/basic_controller/crab

/mob/living/basic/crab/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_NODROWN, TRAIT_SWIMMER, TRAIT_VENTCRAWLER_ALWAYS), INNATE_TRAIT)
	AddElement(/datum/element/sideway_movement)
	AddElement(/datum/element/tiny_mob_hunter, MOB_SIZE_TINY)
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/ai_flee_while_injured)
	AddComponent(/datum/component/speechmod, replacements = strings("crustacean_replacement.json", "crustacean"))

//COFFEE! SQUEEEEEEEEE!
/mob/living/basic/crab/coffee
	name = "咖啡"
	real_name = "咖啡"
	desc = "这是咖啡，另一只宠物！"
	gender = FEMALE
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/crab/jon //holodeck crab
	name = "乔恩"
	real_name = "乔恩"
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/crab/evil
	name = "邪恶螃蟹"
	real_name = "邪恶螃蟹"
	desc = "让人不安，对吧？它一定在谋划什么邪恶的事……"
	icon_state = "evilcrab"
	icon_living = "evilcrab"
	icon_dead = "evilcrab_dead"
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/basic/crab/kreb
	name = "克雷布"
	desc = "这才是真正的螃蟹。其他螃蟹不过是伪装起来的冒牌货！"
	real_name = "克雷布"
	icon_state = "kreb"
	icon_living = "kreb"
	icon_dead = "kreb_dead"
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/crab/evil/kreb
	name = "邪恶克雷布"
	real_name = "邪恶克雷布"
	icon_state = "evilkreb"
	icon_living = "evilkreb"
	icon_dead = "evilkreb_dead"
	gold_core_spawnable = NO_SPAWN

///The basic ai controller for crabs
/datum/ai_controller/basic_controller/crab
	behavior_tree_json = "code/modules/mob/living/basic/vermin/crab.bt.json"
	blackboard = list(
		BB_ALWAYS_IGNORE_FACTION = TRUE,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/of_size/smaller,
		BB_FLEE_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_traits = DEFAULT_AI_FLAGS | STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
