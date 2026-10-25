/*
* ## Killer Tomatoes
*
* Side effect from when you try to play God through genetic engineering. Feisty fuckers that want to eat you. Dangerous.
*/

/mob/living/basic/killer_tomato
	name = "杀手番茄"
	desc = "这是一颗大得吓人的牛肉番茄，而且它还额外加了牛肉！"
	icon_state = "tomato"
	icon_living = "tomato"
	icon_dead = "tomato_dead"
	mob_biotypes = MOB_ORGANIC | MOB_PLANT
	gender = NEUTER
	speed = 1 // if you wanna touch this, keep in mind we want to incentivize people growing really good botany plants in order to make these buggers faster.
	maxHealth = 30
	health = 30
	butcher_results = list(/obj/item/food/meat/slab/killertomato = 2)
	response_help_continuous = "戳"
	response_help_simple = "戳"
	response_disarm_continuous = "推到一边"
	response_disarm_simple = "推到一边"
	response_harm_continuous = "拍打"
	response_harm_simple = "拍打"
	melee_damage_lower = 8
	melee_damage_upper = 12
	attack_verb_continuous = "猛砸"
	attack_verb_simple = "猛砸"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	faction = list(FACTION_PLANTS)

	habitable_atmos = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = T0C - 130
	maximum_survivable_temperature = T0C + 230
	gold_core_spawnable = HOSTILE_SPAWN

	ai_controller = /datum/ai_controller/basic_controller/killer_tomato

/mob/living/basic/killer_tomato/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/datum/ai_controller/basic_controller/killer_tomato
	behavior_tree_json = "code/modules/mob/living/basic/space_fauna/killer_tomato.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_HEAR = list("龇牙低吼。", "低声咆哮。", "呜咽咆哮。"),
			BB_EMOTE_SEE = list("流着口水。"),
			BB_SPEAK_CHANCE = 3,
		),
	)

	ai_movement = /datum/ai_movement/basic_avoidance
