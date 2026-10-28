/mob/living/basic/mining/scorpion

	name = "巨型蝎子"
	desc = "一只巨大的变异蝎子，拥有坚硬的外骨骼甲壳。小心它那根尾刺！"

	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "scorpion"
	icon_living = "scorpion"
	icon_dead = "scorpion_d"

	mob_biotypes = MOB_ORGANIC|MOB_BUG
	maxHealth = 75
	health = 75
	physiology = list(BRUTE = 1, BURN = 0.75, TOX = 0.5, STAMINA = 1, OXY = 1)
	basic_mob_flags = FLAMMABLE_MOB
	status_flags = NONE

	habitable_atmos = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 1, "min_co2" = 0, "max_co2" = 10, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = T0C
	maximum_survivable_temperature = T0C + 120
	unsuitable_atmos_damage = 4
	unsuitable_cold_damage = 4
	unsuitable_heat_damage = 4

	friendly_verb_continuous = "友好地唧唧作响"
	friendly_verb_simple = "友好地唧唧作响"
	response_help_continuous = "轻抚"
	response_help_simple = "轻抚"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	speak_emote = list("唧唧作响")

	combat_mode = TRUE
	melee_attack_cooldown = 2 SECONDS
	obj_damage = 25
	melee_damage_lower = 10
	melee_damage_upper = 20

	attack_vis_effect = ATTACK_EFFECT_MECHTOXIN
	attack_sound = 'sound/items/weapons/pierce_slow.ogg'
	attack_verb_continuous = "蜇刺"
	attack_verb_simple = "蜇刺"

	throw_blocked_message = "撞在坚硬甲壳上，未能伤及"

	speed = 5
	movement_type = GROUND
	move_force = MOVE_FORCE_STRONG
	move_resist = MOVE_FORCE_STRONG
	pull_force = MOVE_FORCE_STRONG

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

	butcher_results = list(/obj/item/reagent_containers/cup/tube/scorpion_venom = 1)
	guaranteed_butcher_results = list(/obj/item/food/meat/slab/bugmeat = 4)

/mob/living/basic/mining/cazador/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_RESISTHEAT, TRAIT_RADIMMUNE), INNATE_TRAIT)
	AddElement(/datum/element/venomous, /datum/reagent/toxin/scorpion, 3, injection_flags = INJECT_CHECK_PENETRATE_THICK)

/datum/reagent/toxin/scorpion
	name = "蝎毒"
	toxpwr = 2
	description = "一种由巨型蝎子产生的毒性化学物质。会让你头晕目眩。"
	health_required = 20
	liver_damage_multiplier = 0

/datum/reagent/toxin/scorpion/on_mob_add(mob/living/carbon/affected_mob)
	. = ..()
	to_chat(affected_mob, span_danger("你感到有点头晕目眩……"))

/obj/item/reagent_containers/cup/tube/scorpion_venom
	name = "蝎毒药瓶"
	desc = "一个小药瓶。里面装着卡萨多毒液。"
	list_reagents = list(/datum/reagent/toxin/scorpion = 15)

/mob/living/simple_animal/hostile/scorpion
	gold_core_spawnable = NO_SPAWN

