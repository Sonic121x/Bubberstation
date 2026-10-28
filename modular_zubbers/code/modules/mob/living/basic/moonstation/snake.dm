/datum/ai_controller/basic_controller/coded_moonsnake
	behavior_tree_json = "modular_zubbers/code/modules/mob/living/basic/moonstation/coded_moonsnake.bt.json"

	ai_movement = /datum/ai_movement/basic_avoidance
	blackboard = list(
		BB_ALWAYS_IGNORE_FACTION = FALSE,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_BASIC_MOB_STOP_FLEEING = TRUE, //We only flee from scary fishermen
	)


/mob/living/basic/mining/moonsnake

	name = "有毒编码月蛇"
	desc = "学名为 serpens lunaeprogramma 的有毒编码月蛇，是一种仅分布于本月亮较炎热地区的领地性水蛇。\
	它的食谱包括卡萨多的卵，整颗吞入后会由特化的胃仔细提取其中的毒素，据为己用。\
	据说这种蛇的肉吃起来和鸡肉一模一样。"

	icon = 'modular_zubbers/icons/mob/simple/snake.dmi'
	icon_state = "moonsnake"
	icon_living = "moonsnake"
	icon_dead = "moonsnake_dead"

	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	speed = 2
	movement_type = GROUND
	move_force = MOVE_FORCE_VERY_WEAK
	move_resist = MOVE_FORCE_VERY_WEAK
	pull_force = MOVE_FORCE_VERY_WEAK

	health = 20
	maxHealth = 20
	damage_coeff = list(BRUTE = 1, BURN = 0.75, TOX = 0.25, STAMINA = 1, OXY = 1)
	mob_biotypes = MOB_ORGANIC|MOB_REPTILE|MOB_AQUATIC|MOB_BEAST
	basic_mob_flags = IMMUNE_TO_GETTING_WET
	status_flags = NONE

	habitable_atmos = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 1, "min_co2" = 0, "max_co2" = 10, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = T0C
	maximum_survivable_temperature = T0C + 120
	unsuitable_atmos_damage = 3
	unsuitable_cold_damage = 3
	unsuitable_heat_damage = 3

	friendly_verb_continuous = "对着嘶嘶作响"
	friendly_verb_simple = "嘶嘶作响"
	response_help_continuous = "轻抚"
	response_help_simple = "轻抚"
	response_disarm_continuous = "轻轻拨开"
	response_disarm_simple = "轻轻拨开"
	speak_emote = list("嘶嘶作响")

	combat_mode = TRUE
	melee_attack_cooldown = 1 SECONDS
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	melee_damage_lower = 5
	melee_damage_upper = 6

	attack_vis_effect = ATTACK_EFFECT_MECHTOXIN
	attack_sound = 'sound/items/weapons/pierce.ogg'
	attack_verb_continuous = "啃咬"
	attack_verb_simple = "咬"

	throw_blocked_message = "被灵巧地闪开，未能伤及"

	ai_controller = /datum/ai_controller/basic_controller/coded_moonsnake

	butcher_results = list(/obj/item/reagent_containers/cup/tube/cazador_venom = 1)
	guaranteed_butcher_results = list(/obj/item/food/meat/slab/chicken = 1)

	var/static/list/edibles = list(
		/obj/item/food/egg
	)

	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/basic/mining/moonsnake/Initialize(mapload)

	. = ..()

	add_traits(list(TRAIT_NODROWN, TRAIT_SWIMMER, TRAIT_RESISTHEAT, TRAIT_RADIMMUNE, TRAIT_VENTCRAWLER_ALWAYS), INNATE_TRAIT)

	AddElement(/datum/element/basic_eating, heal_amt = 2, food_types = edibles)
	AddElement(/datum/element/venomous, /datum/reagent/toxin/cazador, 1, injection_flags = INJECT_CHECK_PENETRATE_THICK)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_SNAKE, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

	ai_controller.set_blackboard_key(BB_BASIC_FOODS, typecacheof(edibles))
