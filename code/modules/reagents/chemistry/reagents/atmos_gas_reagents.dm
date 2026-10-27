/datum/reagent/freon
	name = "氟利昂"
	description = "一种强效吸热剂。"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM  // Because nitrium/freon/hypernoblium are handled through gas breathing, metabolism must be lower for breathcode to keep up
	color = "90560B"
	taste_description = "灼烧感"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/freon/on_mob_metabolize(mob/living/breather)
	. = ..()
	breather.add_movespeed_modifier(/datum/movespeed_modifier/reagent/freon)

/datum/reagent/freon/on_mob_end_metabolize(mob/living/breather)
	. = ..()
	breather.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/freon)

/datum/reagent/halon
	name = "哈龙"
	description = "一种灭火气体，会移除氧气并降低周围温度"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	color = "90560B"
	taste_description = "薄荷味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_RESISTHEAT)

/datum/reagent/halon/on_mob_metabolize(mob/living/breather)
	. = ..()
	breather.add_movespeed_modifier(/datum/movespeed_modifier/reagent/halon)

/datum/reagent/halon/on_mob_end_metabolize(mob/living/breather)
	. = ..()
	breather.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/halon)

/datum/reagent/healium
	name = "愈合气"
	description = "一种强效催眠气体，兼具治疗效果"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	color = "90560B"
	taste_description = "橡胶味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/healium/on_mob_end_metabolize(mob/living/breather)
	. = ..()
	breather.SetSleeping(1 SECONDS)

/datum/reagent/healium/on_mob_life(mob/living/breather, seconds_per_tick, metabolization_ratio)
	. = ..()
	breather.SetSleeping(30 SECONDS)
	var/need_mob_update
	need_mob_update = breather.adjust_fire_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += breather.adjust_tox_loss(-5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += breather.adjust_brute_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/hypernoblium
	name = "超惰性气体"
	description = "一种抑制性气体，会阻止吸入者体内的气体反应。"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM // Because nitrium/freon/hyper-nob are handled through gas breathing, metabolism must be lower for breathcode to keep up
	color = "90560B"
	taste_description = "刺骨寒冷"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/hypernoblium/on_mob_life(mob/living/carbon/breather, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(isplasmaman(breather))
		breather.set_timed_status_effect(10 SECONDS * metabolization_ratio * seconds_per_tick, /datum/status_effect/hypernob_protection)

/datum/reagent/nitrium_high_metabolization
	name = "亚硝酰质粒"
	description = "一种高活性副产物，会阻止你入睡，并随时间造成越来越多的毒素伤害。"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM  // Because nitrium/freon/hypernoblium are handled through gas breathing, metabolism must be lower for breathcode to keep up
	color = "E1A116"
	taste_description = "酸味"
	ph = 1.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	addiction_types = list(/datum/addiction/stimulants = 50)
	metabolized_traits = list(TRAIT_SLEEPIMMUNE)

/datum/reagent/nitrium_high_metabolization/on_mob_life(mob/living/carbon/breather, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	need_mob_update = breather.adjust_stamina_loss(-4 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
	need_mob_update += breather.adjust_tox_loss(0.1 * (current_cycle-1) * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype) // 1 toxin damage per cycle at cycle 10
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/nitrium_low_metabolization
	name = "氮素气"
	description = "一种高活性气体，会让你感觉更快。"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM // Because nitrium/freon/hypernoblium are handled through gas breathing, metabolism must be lower for breathcode to keep up
	color = "90560B"
	taste_description = "灼烧感"
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/nitrium_low_metabolization/on_mob_metabolize(mob/living/breather)
	. = ..()
	breather.add_movespeed_modifier(/datum/movespeed_modifier/reagent/nitrium)

/datum/reagent/nitrium_low_metabolization/on_mob_end_metabolize(mob/living/breather)
	. = ..()
	breather.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/nitrium)

/datum/reagent/pluoxium
	name = "富氧气"
	description = "一种在肺部扩散方面效率是氧气八倍的气体，对睡眠中的患者具有器官治疗作用。"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	color = COLOR_GRAY
	taste_description = "受辐射的空气"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/pluoxium/on_mob_life(mob/living/carbon/breather, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!IS_UNCONSCIOUS(breather))
		return

	for(var/obj/item/organ/organ_being_healed as anything in breather.organs)
		if(!organ_being_healed.damage)
			continue

		if(organ_being_healed.apply_organ_damage(-0.5 * metabolization_ratio * seconds_per_tick, required_organ_flag = ORGAN_ORGANIC))
			. = UPDATE_MOB_HEALTH

/datum/reagent/zauker
	name = "灼蚀气"
	description = "一种不稳定的气体，对所有生物都有毒。"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	color = "90560B"
	taste_description = "苦味"
	chemical_flags = REAGENT_NO_RANDOM_RECIPE
	affected_biotype = MOB_ORGANIC | MOB_MINERAL | MOB_PLANT // "toxic to all living beings"

/datum/reagent/zauker/on_mob_life(mob/living/breather, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	need_mob_update = breather.adjust_brute_loss(6 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += breather.adjust_oxy_loss(1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += breather.adjust_fire_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += breather.adjust_tox_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH
