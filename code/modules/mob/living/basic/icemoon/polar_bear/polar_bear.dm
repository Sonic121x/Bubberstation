// The taxonomy of polar vs space bear left to imagination of the reader
/mob/living/basic/mining/polarbear
	name = "北极熊"
	desc = "一种攻击性极强的动物，会以惊人的力量保卫自己的领地。这些猛兽不会躲避敌人。"
	icon = 'icons/mob/simple/icemoon/icemoon_monsters.dmi'
	icon_state = "polarbear"
	icon_living = "polarbear"
	icon_dead = "polarbear_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST|MOB_MINING

	friendly_verb_continuous = "低吼着警告"
	friendly_verb_simple = "低吼着警告"
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	attack_verb_continuous = "挥爪"
	attack_verb_simple = "挥爪"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW

	habitable_atmos = null
	speed = 2
	maxHealth = 300
	health = 300
	obj_damage = 40
	melee_damage_lower = 25
	melee_damage_upper = 25
	wound_bonus = -5
	exposed_wound_bonus = 10
	sharpness = SHARP_EDGED

	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_VERY_STRONG
	pull_force = MOVE_FORCE_VERY_STRONG
	butcher_results = list(/obj/item/food/meat/slab/bear = 3, /obj/item/stack/sheet/bone = 2)
	guaranteed_butcher_results = list(/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 1)
	crusher_loot = /obj/item/crusher_trophy/bear_paw

	ai_controller = /datum/ai_controller/basic_controller/polar

/mob/living/basic/mining/polarbear/Initialize(mapload)
	. = ..()

	add_traits(list(TRAIT_SPACEWALK, TRAIT_SWIMMER, TRAIT_FENCE_CLIMBER, TRAIT_SNOWSTORM_IMMUNE), INNATE_TRAIT)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_BEAR, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	AddElement(/datum/element/change_force_on_death, move_force = MOVE_FORCE_DEFAULT, move_resist = MOVE_RESIST_DEFAULT, pull_force = PULL_FORCE_DEFAULT)
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_CLAW)

/mob/living/basic/mining/polarbear/lesser
	name = "魔法北极熊"
	desc = "它似乎有某种知觉。"
	faction = list(FACTION_NEUTRAL)

/datum/ai_controller/basic_controller/polar
	behavior_tree_json = "code/modules/mob/living/basic/icemoon/polar_bear/polar.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_AGGRO_RANGE = 2,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
