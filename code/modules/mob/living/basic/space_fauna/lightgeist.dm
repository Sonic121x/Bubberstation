/**
 * ## Lightgeists
 *
 * Small critters meant to heal other living mobs and unable to interact with almost everything else.
 *
 */
/mob/living/basic/lightgeist
	name = "光灵"
	desc = "这种漂浮着的小生物是一种完全未知的生命形式……靠近它会让你感到一片宁静。"
	icon_state = "lightgeist"
	icon_living = "lightgeist"
	icon_dead = "butterfly_dead"
	response_help_continuous = "挥手赶开"
	response_help_simple = "挥手赶开"
	response_disarm_continuous = "拂到一边"
	response_disarm_simple = "拂到一边"
	response_harm_continuous = "扰乱"
	response_harm_simple = "扰乱"
	speak_emote = list("明灭摇曳")
	maxHealth = 2
	health = 2
	melee_damage_lower = 5
	melee_damage_upper = 5
	melee_attack_cooldown = 5 SECONDS
	friendly_verb_continuous = "轻触"
	friendly_verb_simple = "轻触"
	density = FALSE
	basic_mob_flags = DEL_ON_DEATH
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	gold_core_spawnable = HOSTILE_SPAWN
	verb_say = "扭曲着说"
	verb_ask = "好奇地飘着问"
	verb_exclaim = "噼啪放电地说"
	verb_yell = "砰然作响地喊"
	initial_language_holder = /datum/language_holder/lightbringer
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, STAMINA = 1, OXY = 0)
	light_range = 4
	faction = list(FACTION_NEUTRAL)
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500
	obj_damage = 0
	pull_force = MOVE_FORCE_NONE
	environment_smash = ENVIRONMENT_SMASH_NONE

	ai_controller = /datum/ai_controller/basic_controller/lightgeist

/mob/living/basic/lightgeist/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_VENTCRAWLER_ALWAYS, TRAIT_MEDICAL_HUD, TRAIT_EMOTEMUTE), INNATE_TRAIT)
	AddElement(/datum/element/simple_flying)
	AddComponent(\
		/datum/component/healing_touch,\
		heal_brute = melee_damage_upper,\
		heal_burn = melee_damage_upper,\
		heal_time = 0,\
		valid_targets_typecache = typecacheof(list(/mob/living)),\
		action_text = "%SOURCE% 开始修复 %TARGET% 的伤口",\
		complete_text = "%TARGET% 的伤口愈合了。",\
	)

/mob/living/basic/lightgeist/melee_attack(atom/target, list/modifiers, ignore_cooldown = FALSE)
	. = ..()
	if (. && isliving(target))
		add_ally(target) // Anyone we heal will treat us as a friend

/mob/living/basic/lightgeist/ghost()
	. = ..()
	if(.)
		death()

/datum/ai_controller/basic_controller/lightgeist
	behavior_tree_json = "code/modules/mob/living/basic/space_fauna/lightgeist.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/lightgeist,
	)

	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance

/// Attack only mobs who have damage that we can heal, I think this is specific enough not to be a generic type
/datum/targeting_strategy/lightgeist
	/// Types of mobs we can heal, not in a blackboard key because there is no point changing this at runtime because the component will already exist
	var/heal_biotypes = MOB_ORGANIC | MOB_MINERAL
	/// Type of limb we can heal
	var/required_bodytype = BODYTYPE_ORGANIC

/datum/targeting_strategy/lightgeist/is_valid_target(mob/living/living_mob, mob/living/target, vision_range, datum/ai_controller/controller = null)
	if (!isliving(target) || target.stat == DEAD)
		return FALSE
	if (!(heal_biotypes & target.mob_biotypes))
		return FALSE
	if (!iscarbon(target))
		return target.get_brute_loss() > 0 || target.get_fire_loss() > 0
	var/mob/living/carbon/carbon_target = target
	for (var/obj/item/bodypart/part in carbon_target.get_bodyparts())
		if (!part.brute_dam && !part.burn_dam)
			continue
		if (!(part.bodytype & required_bodytype))
			continue
		return TRUE
	return FALSE
