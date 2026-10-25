/mob/living/basic/ant
	name = "巨型蚂蚁"
	desc = "一团蠕动的蚂蚁粘在一起，凑成了一只可爱的小宠物！"
	icon = 'icons/mob/simple/pets.dmi'
	icon_state = "ant"
	icon_living = "ant"
	icon_dead = "ant_dead"
	speak_emote = list("嗡嗡叫", "吱吱叫")
	gender = PLURAL // We are Ven-ant
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	obj_damage = 5
	melee_damage_lower = 5
	melee_damage_upper = 10
	attack_verb_continuous = "咬"
	attack_verb_simple = "咬"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	butcher_results = list(/obj/effect/decal/cleanable/ants = 3) //It's just a bunch of ants glued together into a larger ant
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推到一边"
	response_disarm_simple = "轻轻推到一边"
	response_harm_continuous = "踢"
	response_harm_simple = "踢"
	gold_core_spawnable = FRIENDLY_SPAWN
	faction = list(FACTION_NEUTRAL)
	health = 100
	maxHealth = 100
	light_range = 1.5 // Bioluminescence!
	minimum_survivable_temperature = T20C - 100
	maximum_survivable_temperature = T20C + 120
	light_color = "#d43229" // The ants that comprise the giant ant still glow red despite the sludge.

	ai_controller = /datum/ai_controller/basic_controller/ant

/datum/emote/ant
	abstract_type = /datum/emote/ant
	mob_type_allowed_typecache = /mob/living/basic/ant
	mob_type_blacklist_typecache = list()

/datum/emote/ant/clack
	key = "clack"
	key_third_person = "clacks"
	message = "开心地咔嗒作响！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/mob/living/basic/ant/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	AddElement(/datum/element/pet_bonus, "clack")
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW)
	AddElement(/datum/element/basic_allergenic_attack, allergen = BUGS, allergen_chance = 20, histamine_add = 5)

/datum/ai_controller/basic_controller/ant
	behavior_tree_json = "code/modules/mob/living/basic/space_fauna/ant.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
