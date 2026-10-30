/datum/spacevine_mutation
	/// Displayed name of mutation
	var/name = ""
	/// Description of mutation, shown in the plant analyzer
	var/description = ""
	/// Severity of mutation in terms of gameplay, affects appearance chance and how many mutations can be on the same vine
	var/severity = 1
	/// The mutation's contribution to a given vine's color
	var/hue
	/// The quality of our mutation (how good or bad is it?)
	var/quality
	/// The flavor text to add to the venus flytrap ghost role spawners
	var/venus_flavor_text = ""

/datum/spacevine_mutation/proc/add_mutation_to_vinepiece(obj/structure/spacevine/vine)
	vine.mutations |= src
	vine.add_atom_colour(hue, FIXED_COLOUR_PRIORITY)

/datum/spacevine_mutation/proc/on_buckle(obj/structure/spacevine/vine, mob/living/buckled)
	SHOULD_CALL_PARENT(TRUE)
	buckled.layer = SPACEVINE_MOB_LAYER
	RegisterSignal(buckled, COMSIG_MOB_UNBUCKLED, PROC_REF(on_unbuckle), override=TRUE)

/datum/spacevine_mutation/proc/on_unbuckle(datum/source)
	SHOULD_CALL_PARENT(TRUE)
	SIGNAL_HANDLER
	if(!isliving(source))
		return
	var/mob/living/buckled = source
	buckled.layer = initial(buckled.layer)
	UnregisterSignal(buckled, COMSIG_MOB_UNBUCKLED)

/datum/spacevine_mutation/proc/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	return

/datum/spacevine_mutation/proc/process_mutation(obj/structure/spacevine/vine)
	return

/datum/spacevine_mutation/proc/on_birth(obj/structure/spacevine/vine)
	return

/datum/spacevine_mutation/proc/on_grow(obj/structure/spacevine/vine)
	return

/datum/spacevine_mutation/proc/on_death(obj/structure/spacevine/vine)
	return

/datum/spacevine_mutation/proc/on_hit(obj/structure/spacevine/vine, obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	return

/datum/spacevine_mutation/proc/on_cross(obj/structure/spacevine/vine, mob/crosser)
	return

/datum/spacevine_mutation/proc/on_chem(obj/structure/spacevine/vine, datum/reagent/chem)
	return

/datum/spacevine_mutation/proc/on_eat(obj/structure/spacevine/vine, mob/living/eater)
	return

/datum/spacevine_mutation/proc/on_spread(obj/structure/spacevine/vine, turf/target)
	return

/datum/spacevine_mutation/proc/on_explosion(severity, target, obj/structure/spacevine/vine)
	return FALSE

/datum/spacevine_mutation/proc/additional_atmos_processes(obj/structure/spacevine/vine, datum/gas_mixture/air)
	return

/datum/spacevine_mutation/aggressive_spread/proc/aggrospread_act(obj/structure/spacevine/vine, mob/living/M)
	return

/datum/spacevine_mutation/light
	name = "发光"
	description = "发出光亮。"
	hue = "#B2EA70"
	quality = POSITIVE
	severity = SEVERITY_TRIVIAL
	venus_flavor_text = "发光——你的身体会发出光芒"

/datum/spacevine_mutation/light/on_grow(obj/structure/spacevine/vine)
	if(vine.growth_stage)
		vine.set_light(LIGHT_MUTATION_BRIGHTNESS, 0.3)

/datum/spacevine_mutation/light/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	venus_trap.glow = venus_trap.mob_light(LIGHT_MUTATION_BRIGHTNESS, 0.3)

/datum/spacevine_mutation/toxicity
	name = "毒性"
	description = "被触碰或食用时释放毒素。"
	hue = "#9B3675"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE
	venus_flavor_text = "毒素抗性——免疫化学除草剂和毒素"
	var/required_coverage = HEAD|CHEST|GROIN|LEGS|FEET|ARMS|HANDS

/datum/spacevine_mutation/toxicity/on_cross(obj/structure/spacevine/vine, mob/living/crosser)
	if(isvineimmune(crosser) || issilicon(crosser))
		return
	if(!prob(TOXICITY_MUTATION_PROB))
		return

	var/datum/spacevine_mutation/thorns/thorns = locate() in vine.mutations

	if(thorns)
		to_chat(crosser, span_alert("你被荆棘刺到，感到一阵奇异的感觉。"))
		crosser.apply_damage(20, TOX)
		return

	var/body_parts_covered = 0
	for(var/obj/item/clothing/worn_item in crosser.get_equipped_items())
		if(!(worn_item.clothing_flags & THICKMATERIAL))
			continue
		body_parts_covered |= worn_item.body_parts_covered

		if((body_parts_covered & required_coverage) == required_coverage)
			return

	to_chat(crosser, span_alert("你不小心碰到了藤蔓，感到一阵奇异的感觉。"))
	crosser.apply_damage(20, TOX)

/datum/spacevine_mutation/toxicity/on_eat(obj/structure/spacevine/vine, mob/living/eater)
	if(!isvineimmune(eater))
		eater.apply_damage(20, TOX)

/datum/spacevine_mutation/toxicity/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	ADD_TRAIT(venus_trap, TRAIT_TOXIMMUNE, INNATE_TRAIT)

/datum/spacevine_mutation/explosive  // JC IT'S A BOMB
	name = "爆炸"
	description = "被摧毁时引发爆炸。"
	hue = "#D83A56"
	quality = NEGATIVE
	severity = SEVERITY_MAJOR
	venus_flavor_text = "爆炸——你死亡时会发生猛烈爆炸"

/datum/spacevine_mutation/explosive/on_explosion(explosion_severity, target, obj/structure/spacevine/vine)
	if(explosion_severity >= EXPLODE_DEVASTATE)
		QDEL_IN(vine, 0.5 SECONDS)
		return TRUE

	qdel(vine)
	return FALSE

/datum/spacevine_mutation/explosive/on_death(obj/structure/spacevine/vine, mob/hitter, obj/item/item)
	explosion(vine, light_impact_range = EXPLOSION_MUTATION_IMPACT_RADIUS, adminlog = FALSE)

/datum/spacevine_mutation/explosive/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	RegisterSignal(venus_trap, COMSIG_LIVING_DEATH, PROC_REF(on_venus_trap_death), override=TRUE)

/datum/spacevine_mutation/explosive/proc/on_venus_trap_death(mob/living/spawned_mob, mob/mob_possessor, apply_prefs)
	SIGNAL_HANDLER

	explosion(spawned_mob, light_impact_range = EXPLOSION_MUTATION_IMPACT_RADIUS, adminlog = FALSE)

/datum/spacevine_mutation/fire_proof
	name = "防火"
	description = "免疫高温和灼烧伤害。"
	hue = "#FF616D"
	quality = MINOR_NEGATIVE
	severity = SEVERITY_ABOVE_AVERAGE
	venus_flavor_text = "耐热——免疫极端高温和火焰"

/datum/spacevine_mutation/fire_proof/on_hit(obj/structure/spacevine/vine, obj/item/item,  mob/living/hitter, list/modifiers, list/attack_modifiers)
	if(item?.damtype == BURN)
		MODIFY_ATTACK_FORCE_MULTIPLIER(attack_modifiers, 0)
	return ..()

/datum/spacevine_mutation/fire_proof/on_grow(obj/structure/spacevine/vine)
	vine.resistance_flags |= FIRE_PROOF

/datum/spacevine_mutation/fire_proof/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	venus_trap.unsuitable_heat_damage = 0
	venus_trap.resistance_flags |= FIRE_PROOF
	ADD_TRAIT(venus_trap, TRAIT_RESISTHEAT, INNATE_TRAIT)

/datum/spacevine_mutation/cold_proof
	name = "防寒"
	description = "免疫寒冷伤害。"
	hue = "#0BD5D9"
	quality = MINOR_NEGATIVE
	severity = SEVERITY_AVERAGE
	venus_flavor_text = "耐寒——免疫严寒"

/datum/spacevine_mutation/cold_proof/on_grow(obj/structure/spacevine/vine)
	vine.resistance_flags |= FREEZE_PROOF

/datum/spacevine_mutation/cold_proof/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	venus_trap.unsuitable_cold_damage = 0
	venus_trap.resistance_flags |= FREEZE_PROOF
	ADD_TRAIT(venus_trap, TRAIT_RESISTCOLD, INNATE_TRAIT)

/datum/spacevine_mutation/temp_stabilisation
	name = "温度稳定"
	description = "稳定周围区域的温度。"
	hue = "#B09856"
	quality = POSITIVE
	severity = SEVERITY_MINOR

/datum/spacevine_mutation/temp_stabilisation/add_mutation_to_vinepiece(obj/structure/spacevine/vine)
	. = ..()
	vine.always_atmos_process = TRUE

/datum/spacevine_mutation/temp_stabilisation/additional_atmos_processes(obj/structure/spacevine/vine, datum/gas_mixture/air)
	var/heat_capacity = air.heat_capacity()
	if(!heat_capacity) // No heating up space or vacuums
		return
	var/energy_used = min(abs(air.temperature - T20C) * heat_capacity, TEMP_STABILISATION_MUTATION_MAXIMUM_ENERGY)
	var/delta_temperature = energy_used / heat_capacity
	if(delta_temperature < 0.1)
		return
	if(air.temperature > T20C)
		delta_temperature *= -1
	air.temperature += delta_temperature
	vine.air_update_turf(FALSE, FALSE)

/datum/spacevine_mutation/vine_eating
	name = "食藤"
	description = "蔓延时摧毁其他葛藤。"
	hue = "#F4A442"
	quality = MINOR_NEGATIVE
	severity = SEVERITY_MINOR
	venus_flavor_text = "吞食藤蔓——站在藤蔓上时恢复更快"

/// Destroys any vine on spread-target's tile. The checks for if this should be done are in the spread() proc.
/datum/spacevine_mutation/vine_eating/on_spread(obj/structure/spacevine/vine, turf/target)
	for(var/obj/structure/spacevine/prey in target)
		qdel(prey)

/datum/spacevine_mutation/vine_eating/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	venus_trap.weed_heal = initial(venus_trap.weed_heal) * 2

/datum/spacevine_mutation/aggressive_spread  //very OP, but im out of other ideas currently
	name = "侵略性蔓延"
	description = "蔓延或缠住生物时造成严重伤害。"
	hue = "#316b2f"
	severity = SEVERITY_MAJOR
	quality = NEGATIVE
	venus_flavor_text = "强势扩张——可离开藤蔓更远才会受到伤害"

/// Checks mobs on spread-target's turf to see if they should be hit by a damaging proc or not.
/datum/spacevine_mutation/aggressive_spread/on_spread(obj/structure/spacevine/vine, turf/turf, mob/living)
	for(var/mob/living/victim in turf)
		aggrospread_act(vine, victim)

/// What happens if an aggr spreading vine buckles a mob.
/datum/spacevine_mutation/aggressive_spread/on_buckle(obj/structure/spacevine/vine, mob/living/buckled)
	. = ..()
	aggrospread_act(vine, buckled)

/// Hurts mobs. To be used when a vine with aggressive spread mutation spreads into the mob's tile or buckles them.
/datum/spacevine_mutation/aggressive_spread/aggrospread_act(obj/structure/spacevine/vine, mob/living/living_mob)
	if(isvineimmune(living_mob) || living_mob.stat == DEAD)
		return

	if(!iscarbon(living_mob))
		living_mob.apply_damage(75, BRUTE, blocked = living_mob.run_armor_check(attack_flag = MELEE, silent = TRUE))
		playsound(living_mob, 'sound/items/weapons/whip.ogg', 50, TRUE, -1)
		living_mob.visible_message(span_danger("[living_mob] 被 [vine] 残忍地抽打！"), \
		span_userdanger("你被 [vine] 残忍地抽打！"))
		log_combat(vine, living_mob, "侵略性蔓延至") //You aren't being attacked by the vines. You just happen to stand in their way.
		return

	var/mob/living/carbon/victim = living_mob
	var/obj/item/bodypart/limb = victim.get_bodypart(victim.get_random_valid_zone(even_weights = TRUE))
	var/armor = victim.run_armor_check(def_zone = limb, attack_flag = MELEE)

	if(!HAS_TRAIT(victim, TRAIT_PIERCEIMMUNE))
		var/datum/spacevine_mutation/thorns/thorn = locate() in vine.mutations

		if(thorn && prob(40)) //If we found the thorns mutation there is now a chance to get stung instead of lashed or smashed.
			victim.apply_damage(50, BRUTE, def_zone = limb, wound_bonus = rand(-20,10), sharpness = SHARP_POINTY) //This one gets a bit lower damage because it ignores armor.
			victim.Stun(1 SECONDS) //Stopped in place for a moment.
			playsound(living_mob, 'sound/items/weapons/pierce.ogg', 50, TRUE, -1)
			living_mob.visible_message(span_danger("[living_mob] 被尖锐的荆棘贯穿！"), \
			span_userdanger("你被尖锐的荆棘贯穿！"))
			log_combat(vine, living_mob, "侵略性刺穿") //"Aggressively" for easy ctrl+F'ing in the attack logs.
			return

		if(prob(80))
			victim.apply_damage(60, BRUTE, def_zone = limb, blocked = armor, wound_bonus = rand(-20,10), sharpness = SHARP_EDGED)
			victim.Knockdown(2 SECONDS)
			playsound(victim, 'sound/items/weapons/whip.ogg', 50, TRUE, -1)
			living_mob.visible_message(span_danger("[living_mob] 被骤然爆发的藤蔓割伤！"), \
			span_userdanger("你被骤然爆发的藤蔓割伤！"))
			log_combat(vine, living_mob, "侵略性割伤")
			return

	victim.apply_damage(60, BRUTE, def_zone = limb, blocked = armor, wound_bonus = rand(-20,10), sharpness = NONE)
	victim.Knockdown(3 SECONDS)
	var/atom/throw_target = get_edge_target_turf(living_mob, get_dir(vine, get_step_away(living_mob, vine)))
	victim.throw_at(throw_target, 3, 6)
	playsound(victim, 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	living_mob.visible_message(span_danger("[living_mob] 被粗大的藤蔓砸飞！"), \
	span_userdanger("你被粗大的藤蔓砸飞！"))
	log_combat(vine, living_mob, "侵略性砸击")

/datum/spacevine_mutation/aggressive_spread/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	venus_trap.kudzu_off_distance_range = 2

/datum/spacevine_mutation/transparency
	name = "透明"
	description = "允许光线透过。"
	hue = ""
	quality = POSITIVE
	severity = SEVERITY_TRIVIAL
	venus_flavor_text = "透明——你的身体是透明的"

/datum/spacevine_mutation/transparency/on_birth(obj/structure/spacevine/vine)
	vine.light_state = PASS_LIGHT
	vine.alpha = 125
	vine.unblock_sunlight()

/datum/spacevine_mutation/transparency/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	venus_trap.alpha = initial(venus_trap.alpha) * 0.5

/datum/spacevine_mutation/gas_eater
	abstract_type = /datum/spacevine_mutation/gas_eater
	/// Type of gas consumed by this mutation
	var/datum/gas/gas_type = null

/datum/spacevine_mutation/gas_eater/process_mutation(obj/structure/spacevine/vine)
	if(isnull(gas_type))
		stack_trace("gas_type not set for gas_eater mutation [type]")
		return

	var/turf/open/floor/turf = vine.loc
	if(!istype(turf))
		return

	var/datum/gas_mixture/gas_mix = turf.air
	if(!gas_mix.moles[gas_type])
		return

	gas_mix.set_gas(gas_type, max(gas_mix.moles[gas_type] - GAS_MUTATION_REMOVAL_MULTIPLIER * vine.growth_stage, 0))
	gas_mix.garbage_collect()

/datum/spacevine_mutation/gas_eater/oxy_eater
	name = "消耗氧气"
	description = "消耗周围区域的氧气。"
	hue = "#28B5B5"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE
	gas_type = /datum/gas/oxygen

/datum/spacevine_mutation/gas_eater/nitro_eater
	name = "消耗氮气"
	description = "消耗周围区域的氮气。"
	hue = "#FF7B54"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE
	gas_type = /datum/gas/nitrogen

/datum/spacevine_mutation/gas_eater/carbondioxide_eater
	name = "消耗二氧化碳"
	description = "消耗周围区域的二氧化碳。"
	hue = "#798777"
	severity = SEVERITY_MINOR
	quality = POSITIVE
	gas_type = /datum/gas/carbon_dioxide

/datum/spacevine_mutation/gas_eater/plasma_eater
	name = "消耗等离子"
	description = "消耗周围区域的等离子。"
	hue = "#9074b6"
	severity = SEVERITY_AVERAGE
	quality = POSITIVE
	gas_type = /datum/gas/plasma

/datum/spacevine_mutation/thorns
	name = "多刺"
	description = "击打或穿过藤蔓时造成伤害。"
	hue = "#9ECCA4"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE
	venus_flavor_text = "荆棘——物理攻击伤害降低，但会造成创伤"

/datum/spacevine_mutation/thorns/on_cross(obj/structure/spacevine/vine, mob/living/crosser)
	if(isvineimmune(crosser) || HAS_TRAIT(crosser, TRAIT_PIERCEIMMUNE))
		return
	if(prob(THORN_MUTATION_CUT_PROB))
		var/mob/living/victim = crosser
		if(victim.apply_damage(15, BRUTE, blocked = victim.run_armor_check(attack_flag = MELEE, silent = TRUE), spread_damage = TRUE))
			to_chat(victim, span_danger("你被带刺的藤蔓割伤了。"))

/datum/spacevine_mutation/thorns/on_hit(obj/structure/spacevine/vine, obj/item/item,  mob/living/hitter, list/modifiers, list/attack_modifiers)
	if(isvineimmune(hitter) || HAS_TRAIT(hitter, TRAIT_PIERCEIMMUNE) || HAS_TRAIT(hitter, TRAIT_PLANT_SAFE))
		return

	if(iscarbon(hitter))
		var/mob/living/carbon/carbon_victim = hitter
		for(var/obj/item/clothing/worn_item in carbon_victim.get_equipped_items())
			if((worn_item.body_parts_covered & HANDS) && (worn_item.clothing_flags & THICKMATERIAL))
				return

	if(prob(THORN_MUTATION_CUT_PROB))
		var/mob/living/victim = hitter
		if(victim.apply_damage(15, BRUTE, blocked = victim.run_armor_check(attack_flag = MELEE, silent = TRUE), spread_damage = TRUE))
			to_chat(victim, span_danger("你被带刺的藤蔓割伤了。"))

/datum/spacevine_mutation/thorns/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	venus_trap.melee_damage_lower = initial(venus_trap.melee_damage_lower) * 0.5
	venus_trap.melee_damage_upper = initial(venus_trap.melee_damage_upper) * 0.5
	venus_trap.obj_damage = initial(venus_trap.obj_damage) * 0.5
	venus_trap.wound_bonus = 5
	venus_trap.exposed_wound_bonus = 15
	venus_trap.sharpness = SHARP_POINTY

/datum/spacevine_mutation/hardened
	name = "硬化"
	description = "提高对切割攻击的抗性，使藤蔓更加坚韧，并阻挡光线透过。"
	hue = "#997700"
	quality = NEGATIVE
	severity = SEVERITY_ABOVE_AVERAGE
	venus_flavor_text = "硬化——生命值提高"

/datum/spacevine_mutation/hardened/on_grow(obj/structure/spacevine/vine)
	if(vine.growth_stage)
		vine.set_density(TRUE)
	vine.modify_max_integrity(initial(vine.max_integrity) * 2)

/datum/spacevine_mutation/hardened/on_hit(obj/structure/spacevine/vine, obj/item/item,  mob/living/hitter, list/modifiers, list/attack_modifiers)
	if(item?.get_sharpness())
		MODIFY_ATTACK_FORCE_MULTIPLIER(attack_modifiers, 0.5)

/datum/spacevine_mutation/hardened/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	venus_trap.health = initial(venus_trap.health) * 2
	venus_trap.maxHealth = initial(venus_trap.maxHealth) * 2

/datum/spacevine_mutation/timid
	name = "胆小"
	description = "使藤蔓隐藏在结构下方，并避免缠住生物。"
	hue = "#a4a9ac"
	quality = POSITIVE
	severity = SEVERITY_MINOR
	venus_flavor_text = "胆怯——无法再向目标发射缠绕藤蔓"

//This specific mutation only covers floors instead of structures, items, mobs and cant tangle mobs
/datum/spacevine_mutation/timid/on_birth(obj/structure/spacevine/vine)
	SET_PLANE_IMPLICIT(vine, FLOOR_PLANE)
	vine.layer = ABOVE_OPEN_TURF_LAYER
	vine.light_state = PASS_LIGHT
	vine.can_tangle = FALSE

/datum/spacevine_mutation/timid/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	var/datum/action/cooldown/mob_cooldown/projectile_attack/vine_tangle/tangle_action
	tangle_action = locate(/datum/action/cooldown/mob_cooldown/projectile_attack/vine_tangle) in venus_trap.actions
	tangle_action.Remove(venus_trap)

/datum/spacevine_mutation/flowering
	name = "开花"
	description = "使藤蔓长出花蕾，完全长成后会生成食人植物。"
	hue = "#66DE93"
	quality = NEGATIVE
	severity = SEVERITY_MAJOR

/datum/spacevine_mutation/flowering/on_grow(obj/structure/spacevine/vine)
	if(locate(/obj/structure/alien/resin/flower_bud) in range(5, vine))
		return
	if(vine.growth_stage == 2 && prob(FLOWERING_MUTATION_SPAWN_PROB))
		var/obj/structure/alien/resin/flower_bud/spawned_flower_bud = new(vine.loc)
		spawned_flower_bud.mutations = vine.mutations

/datum/spacevine_mutation/flowering/on_cross(obj/structure/spacevine/vine, mob/living/crosser)
	if(prob(25))
		vine.entangle(crosser)

/datum/spacevine_mutation/slippery
	name = "湿滑"
	description = "使藤蔓变得湿滑"
	hue = "#a5980c"
	quality = NEGATIVE
	severity = SEVERITY_AVERAGE

/datum/spacevine_mutation/slippery/on_grow(obj/structure/spacevine/vine)
	vine.AddComponent(/datum/component/slippery, 5 SECONDS, NO_SLIP_WHEN_WALKING|SLIDE)

/datum/spacevine_mutation/slippery/on_hit(obj/structure/spacevine/vine, obj/item/item,  mob/living/hitter, list/modifiers, list/attack_modifiers)
	if(isvineimmune(hitter) || HAS_TRAIT(hitter, TRAIT_PLANT_SAFE))
		return

	if(prob(20))
		item?.AddComponent(/datum/component/slippery_item, fall_chance=25, fall_catch_chance=25, duration=5 SECONDS)

/datum/spacevine_mutation/slippery/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	RegisterSignal(venus_trap, COMSIG_ATOM_ATTACKBY, PROC_REF(on_venus_hit), override=TRUE)

/datum/spacevine_mutation/slippery/proc/on_venus_hit(mob/living/basic/venus_human_trap/venus_trap, obj/item/attacking_item, mob/living/attacker, params)
	SIGNAL_HANDLER

	if(isvineimmune(attacker) || HAS_TRAIT(attacker, TRAIT_PLANT_SAFE))
		return

	if(prob(20))
		attacking_item?.AddComponent(/datum/component/slippery_item, fall_chance=25, fall_catch_chance=25, duration=5 SECONDS)

/datum/spacevine_mutation/conductive
	name = "导电"
	description = "使长在电缆上的藤蔓带电"
	hue = "#ad5c00"
	quality = NEGATIVE
	severity = SEVERITY_MINOR

/datum/spacevine_mutation/conductive/proc/attempt_shock(obj/structure/spacevine/vine, mob/living/victim, obj/item/attacking_item)
	if(isvineimmune(victim) || HAS_TRAIT(victim, TRAIT_PLANT_SAFE))
		return
	if(attacking_item && !(attacking_item.obj_flags & CONDUCTS_ELECTRICITY))
		return

	var/turf/vine_loc = get_turf(vine)
	if(vine_loc.overfloor_placed)
		return
	var/obj/structure/cable/cable = vine_loc.get_cable_node()
	if(isnull(cable))
		return

	vine.shock(victim, 100, cable)

/datum/spacevine_mutation/conductive/on_hit(obj/structure/spacevine/vine, obj/item/item,  mob/living/hitter, list/modifiers, list/attack_modifiers)
	attempt_shock(vine, hitter, item)

/datum/spacevine_mutation/conductive/on_buckle(obj/structure/spacevine/vine, mob/living/buckled)
	. = ..()
	attempt_shock(vine, buckled)

/datum/spacevine_mutation/radioactive
	name = "放射性"
	description = "使藤蔓带有放射性"
	hue = "#09b82f"
	quality = NEGATIVE
	severity = SEVERITY_MAJOR

/datum/spacevine_mutation/radioactive/on_birth(obj/structure/spacevine/vine)
	vine.AddElement(/datum/element/radioactive, chance = DEFAULT_RADIATION_CHANCE / 3)

/datum/spacevine_mutation/radioactive/equip_venus_trap(mob/living/basic/venus_human_trap/venus_trap)
	RegisterSignal(venus_trap, COMSIG_ATOM_ATTACKBY, PROC_REF(on_venus_hit), override=TRUE)

/datum/spacevine_mutation/radioactive/proc/on_venus_hit(mob/living/basic/venus_human_trap/venus_trap, obj/item/attacking_item, mob/living/attacker, params)
	SIGNAL_HANDLER

	if(isvineimmune(attacker) || HAS_TRAIT(attacker, TRAIT_PLANT_SAFE))
		return
	if(!SSradiation.can_irradiate_basic(attacker))
		return
	if(ishuman(attacker) && SSradiation.wearing_rad_protected_clothing(attacker))
		return

	radiation_pulse(
		venus_trap,
		max_range = 1,
		threshold = RAD_VERY_LIGHT_INSULATION,
		chance = (DEFAULT_RADIATION_CHANCE / 3),
		minimum_exposure_time = 3 SECONDS,
	)
