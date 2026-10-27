/mob/living/basic/pet/chinchilla
	name = "龙猫"
	desc = "它们像老鼠，但来自澳大利亚。"

	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	held_lh = 'modular_skyrat/master_files/icons/mob/inhands/pets_held_lh.dmi'
	held_rh = 'modular_skyrat/master_files/icons/mob/inhands/pets_held_rh.dmi'
	icon_state = "chinchilla_white"
	icon_living = "chinchilla_white"
	icon_dead = "chinchilla_white_dead"

	maxHealth = 10
	health = 10
	mob_size = MOB_SIZE_TINY

	speed = 1.25 //speedy little fuckers
	see_in_dark = 6

	butcher_results = list(/obj/item/food/meat/slab = 1)

	response_help_continuous = "摸了摸"
	response_help_simple = "摸一摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "踢了"
	response_harm_simple = "踢"

	gold_core_spawnable = FRIENDLY_SPAWN

	held_w_class = WEIGHT_CLASS_TINY
	held_state = "chinchilla_white"

	///In the case 'melee_damage_upper' is somehow raised above 0
	attack_verb_continuous = "咬"
	attack_verb_simple = "咬"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE

	ai_controller = /datum/ai_controller/basic_controller/chinchilla

	/// The color (i.e. "black" or "white") of this chinchilla, to determine the `icon_state`s to use for
	/// this specific instance. `null` by default, which makes it pick a valid value at random in
	/// Initialize()`.
	var/body_color

/mob/living/basic/pet/chinchilla/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "开心地吱吱叫！")

	if(isnull(body_color))
		body_color = pick("black", "white")

	held_state = "chinchilla_[body_color]" // not handled by variety element
	AddElement(/datum/element/animal_variety, "chinchilla", body_color, FALSE)

	AddElement(/datum/element/can_be_held)

//ai behavior

/datum/ai_controller/basic_controller/chinchilla
	behavior_tree_json = "modular_skyrat/modules/basic_mobs/code/chinchilla.bt.json"
	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/subtree/roll_in_dust
	behavior_tree_json = "modular_skyrat/modules/basic_mobs/code/roll_in_dust.bt.json"

/// Dust piles chinchillas will look for to roll around in.
/datum/target_source/oview_typed/dust_bath
	typecache = list(/obj/effect/decal/cleanable/ash, /obj/effect/decal/cleanable/food/flour)

/datum/target_source/oview_typed/dust_bath/New()
	. = ..()
	typecache = typecacheof(typecache)

/datum/bt_node/ai_behavior/hunt_target/dust_roll
	hunt_cooldown = 20 SECONDS

/datum/bt_node/ai_behavior/hunt_target/dust_roll/target_caught(mob/living/basic/pet/hunter, obj/effect/decal/cleanable/dust)
	hunter.balloon_alert_to_viewers("在尘土里打滚", null, 5)
	hunter.spin(10, 1)
	qdel(dust)

/datum/bt_node/ai_behavior/random_speech/chinchilla
	speech_chance = 5
	emote_hear = list(
		"吱吱叫着。",
		"唧唧叫着。",
	)
	emote_see = list(
		"四处嗅闻。",
		"四处蹦跳。",
	)

//subtypes

/mob/living/basic/pet/chinchilla/white
	body_color = "white"

/mob/living/basic/pet/chinchilla/black
	body_color = "black"
