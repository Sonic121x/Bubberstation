/mob/living/basic/pet/bumbles
	name = "邦布尔斯"
	desc = "邦布尔斯，一只非常谦逊的熊蜂。"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "bumbles"
	icon_living = "bumbles"
	icon_dead = "bumbles_dead"
	maxHealth = 15
	health = 15
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "拨开"
	response_help_simple = "拨开"
	response_harm_continuous = "压扁"
	response_harm_simple = "压扁"
	speak_emote = list("嗡嗡叫")
	friendly_verb_continuous = "嗡嗡"
	friendly_verb_simple = "嗡嗡"
	butcher_results = list(/obj/item/food/honeycomb = 2)
	density = FALSE
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN
	verb_say = "嗡嗡道"
	verb_ask = "好奇地嗡嗡道"
	verb_exclaim = "剧烈地嗡嗡道"
	verb_yell = "剧烈地嗡嗡道"
	unique_name = TRUE
	ai_controller = /datum/ai_controller/basic_controller/bumbles

	/// List of flower types that can be attacked to smell, or are targetted by AI.
	var/list/flower_types = list(
		/obj/item/bouquet,
		/obj/item/food/grown/flower/poppy,
		/obj/item/food/grown/flower/sunflower,
		/obj/item/food/grown/flower/moonflower,
		/obj/item/food/grown/flower/rose,
		/obj/item/food/grown/flower/harebell,
	)

/mob/living/basic/pet/bumbles/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/simple_flying)
	add_verb(src, /mob/living/proc/toggle_resting)

	ai_controller.set_blackboard_key(BB_BASIC_FOODS, typecacheof(flower_types))

	RegisterSignal(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, PROC_REF(smell_flower))

/mob/living/basic/pet/bumbles/update_resting()
	if(stat == DEAD)
		return ..()

	if (resting)
		icon_state = "[icon_living]_rest"

		ai_controller.set_blackboard_key(BB_BUMBLES_RESTING, TRUE)

		manual_emote(pick("在身下的表面上蜷成一团。", "看起来非常困。", "开心地嗡嗡叫。", "四处张望，想找朵花睡一觉。"))
		REMOVE_TRAIT(src, TRAIT_MOVE_FLYING, ROUNDSTART_TRAIT)
	else
		icon_state = "[icon_living]"

		ai_controller.clear_blackboard_key(BB_BUMBLES_RESTING)

		manual_emote(pick("带着笑意嗡嗡地醒来。", "翻了个身才醒过来。", "停止了休息。"))
		ADD_TRAIT(src, TRAIT_MOVE_FLYING, ROUNDSTART_TRAIT)

	regenerate_icons()
	return ..()

/mob/living/basic/pet/bumbles/bee_friendly()
	return TRUE // treaty signed at the Beeneeva convention

/mob/living/basic/pet/bumbles/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	. = ..()
	if(!. || !proximity_flag || combat_mode)
		return

	smell_flower(src, attack_target)

/**
 * Smell a flower, either via AI or unarmed attack.
 *
 * Arguments:
 * * source - Signal source. Will be the same as src.
 * * target - The thing being attacked.
 */
/mob/living/basic/pet/bumbles/proc/smell_flower(atom/source, atom/target)
	if(!is_type_in_list(target, flower_types))
		return

	manual_emote(pick("闻了闻 [target]。", "嗅了嗅 [target]。", "采集了一些花蜜。"))

	// Clear the target, if any or we'll stunlock on a flower.

	return TRUE

/mob/living/basic/pet/bumbles/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()

	if(resting)
		set_resting(FALSE)

///////////////////////////////
// Bumbles AI below.
///////////////////////////////

// Bumble AI controller that adds find flowers, resting, and buzzing subtrees.
/datum/ai_controller/basic_controller/bumbles
	behavior_tree_json = "modular_skyrat/master_files/code/modules/mob/living/simple_animal/friendly/bumbles.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/allow_items,
		BB_BASIC_MOB_MELEE_DELAY = 30 SECONDS,
	)

	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/bumbles_rest
	time_between_perform = 200 SECONDS

/datum/bt_node/ai_behavior/bumbles_rest/setup(datum/ai_controller/controller)
	. = ..()
	var/mob/living/living_pawn = controller.pawn
	if(!istype(living_pawn) || living_pawn.buckled)
		return FALSE

/datum/bt_node/ai_behavior/bumbles_rest/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	if(!istype(living_pawn))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	living_pawn.set_resting(!living_pawn.resting)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/// Buzz
/datum/bt_node/ai_behavior/random_speech/bumbles
	speech_chance = 1

	emote_hear = list("嗡嗡叫。", "发出一声响亮的嗡嗡声。", "开心地嗡嗡叫。")
	emote_see = list("翻滚了几圈。")

