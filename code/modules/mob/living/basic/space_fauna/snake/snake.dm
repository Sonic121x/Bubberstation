
/mob/living/basic/snake
	name = "蛇"
	desc = "一条滑溜溜的蛇。这些没有腿的爬行动物既是老鼠的克星，也是冒险者的克星。"
	icon_state = "snake"
	icon_living = "snake"
	icon_dead = "snake_dead"
	speak_emote = list("嘶嘶作响")

	health = 20
	maxHealth = 20
	melee_damage_lower = 5
	melee_damage_upper = 6
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	//how many units of venom are injected in target per attack
	var/venom_dose = 4

	attack_verb_continuous = "咬"
	attack_verb_simple = "咬"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE

	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "驱赶"
	response_disarm_simple = "驱赶"
	response_harm_continuous = "踩"
	response_harm_simple = "踩"

	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL

	faction = list(FACTION_HOSTILE)
	mob_biotypes = MOB_ORGANIC | MOB_BEAST | MOB_REPTILE
	gold_core_spawnable = FRIENDLY_SPAWN

	ai_controller = /datum/ai_controller/basic_controller/snake

	/// List of stuff (mice) that we want to eat
	var/static/list/edibles = list(
		/mob/living/basic/mouse,
		/obj/item/food/deadmouse,
	)

/mob/living/basic/snake/Initialize(mapload, special_reagent)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_SNAKE, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

	AddElement(/datum/element/basic_eating, heal_amt = 2, food_types = edibles)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, typecacheof(edibles))

	AddComponent(\
		/datum/component/tameable,\
		food_types = list(/obj/item/food/deadmouse),\
		tame_chance = 75,\
		bonus_tame_chance = 10,\
	) // snakes are really fond of food, especially in the cold darkness of space :)

	if(isnull(special_reagent))
		special_reagent = /datum/reagent/toxin

	AddElement(/datum/element/venomous, special_reagent, venom_dose)

/mob/living/basic/snake/befriend(mob/living/new_friend)
	. = ..()
	if(!.)
		return
	visible_message("[src] 愉快地嘶叫着，似乎与 [new_friend] 建立起了情谊。")

/// Snakes are primarily concerned with getting those tasty, tasty mice, but aren't afraid to strike back at those who attack them
/datum/ai_controller/basic_controller/snake
	behavior_tree_json = "code/modules/mob/living/basic/space_fauna/snake/snake.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("嘶嘶嘶", "嘶——嘶嘶嘶……", "嘶——"),
			BB_EMOTE_HEAR = list("发出嘶嘶声。"),
			BB_EMOTE_SEE = list("四处滑行。", "瞥了一眼。", "盯着看。"),
			BB_EMOTE_SOUND = list('sound/mobs/non-humanoids/snake/snake_hissing1.ogg', 'sound/mobs/non-humanoids/snake/snake_hissing2.ogg'),
			BB_SPEAK_CHANCE = 5,
		),
	)

	ai_traits = DEFAULT_AI_FLAGS | STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
