
/datum/reagent/thermite
	name = "铝热剂"
	description = "铝热剂会发生被称为铝热反应的铝热还原反应，可用于熔化墙壁。"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	color = "#550000"
	taste_description = "带甜味的金属"

/datum/reagent/thermite/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume >= 1)
		exposed_turf.AddComponent(/datum/component/thermite, reac_volume)

/datum/reagent/thermite/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_fire_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
		return UPDATE_MOB_HEALTH

/datum/reagent/nitroglycerin
	name = "硝化甘油"
	description = "硝化甘油是一种沉重、无色、油状的液体，由甘油硝化制得。\
		它常用于治疗心脏病，但也用于制造炸药。"
	color = COLOR_GRAY
	taste_description = "油"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/nitroglycerin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_HEART, -0.5 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), required_organ_flag = affected_organ_flags))
		return UPDATE_MOB_HEALTH

/datum/reagent/nitroglycerin/on_spark_act(power_charge, spark_flags)
	reagent_explode(holder, volume, strengthdiv = 2, clear_holder_reagents = FALSE, flame_factor = 1)
	return SPARK_ACT_DESTRUCTIVE | SPARK_ACT_CLEAR_ALL

/datum/reagent/stabilizing_agent
	name = "稳定剂"
	description = "使不稳定化学品保持稳定。并非对所有化学品都有效。"
	color = COLOR_YELLOW
	taste_description = "金属"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

//It has stable IN THE NAME. IT WAS MADE FOR THIS MOMENT.
/datum/reagent/stabilizing_agent/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.myseed?.adjust_instability(-round(volume))

/datum/reagent/clf3
	name = "三氟化氯"
	description = "一种极易燃的液体，甚至能烧穿空间站的外壳。生成时会爆燃成火球。"
	color = "#FFC8C8"
	metabolization_rate = 10 * REAGENTS_METABOLISM
	taste_description = "灼烧感"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/clf3/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_fire_stacks(0.1 * metabolization_ratio * seconds_per_tick)
	if(affected_mob.adjust_fire_loss(0.015 * max(affected_mob.fire_stacks, 1) * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
		return UPDATE_MOB_HEALTH

/datum/reagent/clf3/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(isplatingturf(exposed_turf))
		var/turf/open/floor/plating/target_plating = exposed_turf
		if(prob(10 + target_plating.burnt + 5*target_plating.broken)) //broken or burnt plating is more susceptible to being destroyed
			target_plating.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	if(isfloorturf(exposed_turf) && prob(reac_volume))
		var/turf/open/floor/target_floor = exposed_turf
		target_floor.make_plating()
	else if(prob(reac_volume))
		exposed_turf.burn_tile()
	if(isfloorturf(exposed_turf))
		for(var/turf/nearby_turf in RANGE_TURFS(1, exposed_turf))
			if(!locate(/obj/effect/hotspot) in nearby_turf)
				new /obj/effect/hotspot(nearby_turf)

/datum/reagent/clf3/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	exposed_mob.adjust_fire_stacks(min(reac_volume/5, 10))
	exposed_mob.ignite_mob()
	if(!locate(/obj/effect/hotspot) in exposed_mob.loc)
		new /obj/effect/hotspot(exposed_mob.loc)

/datum/reagent/sorium
	name = "索里姆"
	description = "将一切从爆炸点向外抛飞。"
	color = "#5A64C8"
	taste_description = "空气与苦涩"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/sorium/on_spark_act(power_charge, spark_flags)
	var/range = clamp(sqrt(volume), 1, 6)
	goonchem_vortex(get_turf(holder.my_atom), 1, range)
	return SPARK_ACT_NON_DESTRUCTIVE

/datum/reagent/liquid_dark_matter
	name = "液态暗物质"
	description = "将一切吸入爆炸点。"
	color = "#210021"
	taste_description = "压缩的苦涩"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/liquid_dark_matter/on_spark_act(power_charge, spark_flags)
	var/range = clamp(sqrt(volume / 2), 1, 6)
	goonchem_vortex(get_turf(holder.my_atom), 0, range)
	return SPARK_ACT_NON_DESTRUCTIVE

/datum/reagent/gunpowder
	name = "火药"
	description = "会爆炸。剧烈地爆炸。"
	color = COLOR_BLACK
	metabolization_rate = 0.125 * REAGENTS_METABOLISM
	taste_description = "盐"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/gunpowder/on_new(data)
	. = ..()
	if(holder?.my_atom)
		RegisterSignal(holder.my_atom, COMSIG_ATOM_EX_ACT, PROC_REF(on_ex_act))

/datum/reagent/gunpowder/Destroy()
	if(holder?.my_atom)
		UnregisterSignal(holder.my_atom, COMSIG_ATOM_EX_ACT)
	return ..()

/datum/reagent/gunpowder/proc/on_ex_act(atom/source, severity, target)
	SIGNAL_HANDLER
	if(source.flags_1 & PREVENT_CONTENTS_EXPLOSION_1)
		return
	var/location = get_turf(holder.my_atom)
	var/datum/effect_system/reagents_explosion/expl = new(location, 1 + round(volume / 6, 1), message = FALSE)
	expl.start(holder.my_atom)
	holder.clear_reagents()

/datum/reagent/gunpowder/on_spark_act(power_charge, spark_flags)
	// Gunpowder doesn't blow in presence of stabilizing agent but instead consumes it every time it'd get triggered
	var/agent_volume = holder.get_reagent_amount(/datum/reagent/stabilizing_agent)
	if (agent_volume)
		var/sapped_amt = 0.1 + round(power_charge / (0.1 * STANDARD_CELL_CHARGE), 0.01)
		holder.remove_reagent(/datum/reagent/stabilizing_agent, sapped_amt)
		if (agent_volume > sapped_amt)
			return

	if (power_charge >= STANDARD_CELL_CHARGE || holder.chem_temp >= 474)
		reagent_explode(holder, volume, modifier = 5, strengthdiv = 10, clear_holder_reagents = FALSE, flame_factor = 1)
		return SPARK_ACT_DESTRUCTIVE | SPARK_ACT_CLEAR_ALL

	holder.my_atom.visible_message(span_boldnotice("火花开始在火药周围飞溅！"))
	if (!(spark_flags & SPARK_ACT_ENCLOSED))
		do_sparks(2, TRUE, get_turf(holder.my_atom))
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(reagent_explode), holder, volume, 5, 10), rand(5 SECONDS, 10 SECONDS))
	return SPARK_ACT_NON_DESTRUCTIVE // just wait a bit...

/datum/reagent/rdx
	name = "RDX"
	description = "军用级炸药"
	color = COLOR_WHITE
	taste_description = "盐"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/rdx/on_spark_act(power_charge, spark_flags)
	if (power_charge)
		// Okay but what if we made a REALLY big boom?
		var/power_coeff = log(2, power_charge / STANDARD_CELL_CHARGE)
		reagent_explode(holder, volume, modifier = min(2 * power_coeff, 8), strengthdiv = 7 / min(power_coeff, 4), clear_holder_reagents = FALSE, flame_factor = 1)
	else if (holder.chem_temp >= 474)
		reagent_explode(holder, volume, modifier = 2, strengthdiv = 7, clear_holder_reagents = FALSE, flame_factor = 1)
	else
		reagent_explode(holder, volume, strengthdiv = 8, clear_holder_reagents = FALSE, flame_factor = 1)
	return SPARK_ACT_DESTRUCTIVE | SPARK_ACT_CLEAR_ALL

/datum/reagent/tatp
	name = "TaTP"
	description = "自杀级炸药"
	color = COLOR_WHITE
	taste_description = "死亡"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/tatp/on_spark_act(power_charge, spark_flags)
	reagent_explode(holder, volume, strengthdiv = 1.5 + rand() * 1.5, clear_holder_reagents = FALSE, flame_factor = 1)
	return SPARK_ACT_DESTRUCTIVE | SPARK_ACT_CLEAR_ALL

/datum/reagent/flash_powder
	name = "闪光粉"
	description = "产生一道极亮的闪光。"
	color = "#C8C8C8"
	taste_description = "盐"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/flash_powder/on_spark_act(power_charge, spark_flags)
	// Even weaker version of the normal flash effect
	var/turf/location = get_turf(holder.my_atom)
	if (!(spark_flags & SPARK_ACT_ENCLOSED))
		do_sparks(2, TRUE, location)
	else if (!(holder.flags & TRANSPARENT) || (!isturf(holder.my_atom.loc) && !ismob(holder.my_atom.loc))) // nope
		return SPARK_ACT_NON_DESTRUCTIVE

	var/range = round(volume / 15, 1)
	holder.my_atom.flash_lighting_fx(range = (range + 2))
	for(var/mob/living/victim in get_hearers_in_view(range, location))
		if(!victim.flash_act(affect_silicon = TRUE))
			continue
		var/distance = get_dist(location, victim)
		if(distance <= 4 || issilicon(victim))
			victim.Paralyze(max(2 SECONDS / max(1, distance), 0.5 SECONDS))
			victim.Knockdown(max(20 SECONDS / max(1, distance), 6 SECONDS))
		else
			victim.adjust_dizzy_up_to(max(20 SECONDS / max(1, distance), 0.5 SECONDS), 20 SECONDS)
		victim.dropItemToGround(victim.get_active_held_item())
		victim.dropItemToGround(victim.get_inactive_held_item())
	return SPARK_ACT_NON_DESTRUCTIVE

/datum/reagent/smoke_powder
	name = "烟雾粉"
	description = "产生一大团可携带试剂的烟雾。"
	color = "#C8C8C8"
	taste_description = "烟味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/smoke_powder/on_spark_act(power_charge, spark_flags)
	// Can't really make a cloud of smoke if we're inside of an enclosed container
	// ...unless we're a mob, in which case this is pretty cursed
	if ((spark_flags & SPARK_ACT_ENCLOSED) && !ismob(holder.my_atom))
		return
	var/location = get_turf(holder.my_atom)
	playsound(location, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	if (iscarbon(holder.my_atom))
		var/mob/living/carbon/victim = holder.my_atom
		if (victim.stat != DEAD)
			victim.visible_message(span_warning("[victim] 开始剧烈地咳出烟雾！"))
		victim.adjust_organ_loss(ORGAN_SLOT_LUNGS, volume / 15)
	do_chem_smoke(amount = volume / 1.5, holder = holder.my_atom, location = location, carry = holder, silent = FALSE, log = TRUE)
	return SPARK_ACT_NON_DESTRUCTIVE | SPARK_ACT_CLEAR_ALL

/datum/reagent/sonic_powder
	name = "声波粉"
	description = "发出震耳欲聋的噪音。"
	color = "#C8C8C8"
	taste_description = "吵闹的声响"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/sonic_powder/on_spark_act(power_charge, spark_flags)
	// Even weaker version of the normal flash effect
	var/turf/location = get_turf(holder.my_atom)
	var/range = round(volume / 15, 1)
	for(var/mob/living/victim in get_hearers_in_view(range, location))
		victim.soundbang_act(1, 10 SECONDS, rand(0, 0.5 SECONDS))
	return SPARK_ACT_NON_DESTRUCTIVE

/datum/reagent/phlogiston
	name = "燃素"
	description = "使你着火并点燃你。"
	color = "#FA00AF"
	taste_description = "灼烧感"
	self_consuming = TRUE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/phlogiston/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	exposed_mob.adjust_fire_stacks(1)
	var/burndmg = max(0.3 * exposed_mob.fire_stacks * (1 - touch_protection), 0.3)
	if(burndmg)
		exposed_mob.adjust_fire_loss(burndmg, 0)
	exposed_mob.ignite_mob()

/datum/reagent/phlogiston/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, metabolization_ratio)
	. = ..()
	metabolizer.adjust_fire_stacks(0.5 * metabolization_ratio * seconds_per_tick)
	if(metabolizer.adjust_fire_loss(0.15 * max(metabolizer.fire_stacks, 0.15) * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
		return UPDATE_MOB_HEALTH

/datum/reagent/phlogiston/on_spark_act(power_charge, spark_flags)
	if ((spark_flags & SPARK_ACT_ENCLOSED) && !ismob(holder.my_atom))
		if (!holder.my_atom.uses_integrity)
			return
		// Spicy!
		holder.my_atom.take_damage(volume / 3, BURN, FIRE, FALSE)
		return SPARK_ACT_NON_DESTRUCTIVE | SPARK_ACT_KEEP_REAGENT

	var/turf/our_turf = get_turf(holder.my_atom)
	our_turf?.hotspot_expose(holder.chem_temp * 50, volume)
	return SPARK_ACT_NON_DESTRUCTIVE

/datum/reagent/napalm
	name = "凝固汽油"
	description = "极易燃。"
	color = "#FA00AF"
	taste_description = "灼烧感"
	self_consuming = TRUE
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// why, just why
/datum/reagent/napalm/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	if(!(mytray.myseed?.resistance_flags & FIRE_PROOF))
		mytray.adjust_plant_health(-round(volume * 6))
		mytray.adjust_toxic(round(volume * 7))

	mytray.adjust_weedlevel(-rand(5,9)) //At least give them a small reward if they bother.

/datum/reagent/napalm/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_fire_stacks(0.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/napalm/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(istype(exposed_mob) && (methods & (TOUCH|VAPOR|PATCH)))
		exposed_mob.adjust_fire_stacks(min(reac_volume / 4, 20))

/datum/reagent/napalm/on_spark_act(power_charge, spark_flags)
	if ((spark_flags & SPARK_ACT_ENCLOSED) && !ismob(holder.my_atom))
		if (!holder.my_atom.uses_integrity)
			return
		// Spicy!
		holder.my_atom.take_damage(volume / 5, BURN, FIRE, FALSE)
		return SPARK_ACT_NON_DESTRUCTIVE | SPARK_ACT_KEEP_REAGENT

	var/turf/our_turf = get_turf(holder.my_atom)
	our_turf?.hotspot_expose(round(holder.chem_temp * 30 * (1 + sqrt(power_charge / STANDARD_CELL_CHARGE)), 1), volume)
	return SPARK_ACT_NON_DESTRUCTIVE

#define CRYO_SPEED_PREFACTOR 0.4
#define CRYO_SPEED_CONSTANT 0.1

/datum/reagent/cryostylane
	name = "冰晶烷"
	description = "使患者器官进入类似低温休眠的状态，防止其死亡后腐坏。但在患者体内会减慢手术速度。与氧气反应时会缓慢消耗氧气，并将容器温度降至 0K。喷洒 5u 时还会伤害史莱姆类简单生物。"
	color = "#0000DC"
	ph = 8.6
	metabolization_rate = 0.05 * REAGENTS_METABOLISM
	taste_description = "冰冷的苦涩"
	purity = REAGENT_STANDARD_PURITY
	self_consuming = TRUE
	inverse_chem_val = 0.5
	inverse_chem = /datum/reagent/inverse/cryostylane
	burning_volume = 0.05
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED | REAGENT_DEAD_PROCESS
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/cryostylane/burn(datum/reagents/holder)
	if(holder.has_reagent(/datum/reagent/oxygen))
		burning_temperature = 0//king chilly
		return
	burning_temperature = null

/datum/reagent/cryostylane/on_mob_add(mob/living/affected_mob, amount)
	. = ..()
	// Between a 1.1x and a 1.5x to surgery time depending on purity
	affected_mob.add_surgery_speed_mod(type, 1 + ((CRYO_SPEED_PREFACTOR * (1 - creation_purity)) + CRYO_SPEED_CONSTANT), min(amount * 1 MINUTES, 5 MINUTES))
	affected_mob.color = COLOR_CYAN

/datum/reagent/cryostylane/on_mob_delete(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_surgery_speed_mod(type)
	affected_mob.color = COLOR_WHITE

//Pauses decay! Does do something, I promise.
/datum/reagent/cryostylane/on_mob_dead(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	metabolization_rate = 0.125 * REAGENTS_METABOLISM //slower consumption when dead

/datum/reagent/cryostylane/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	metabolization_rate = 0.625 * REAGENTS_METABOLISM //faster consumption when alive
	if(affected_mob.reagents.has_reagent(/datum/reagent/oxygen))
		affected_mob.reagents.remove_reagent(/datum/reagent/oxygen, 1 * metabolization_ratio * seconds_per_tick)
		affected_mob.adjust_bodytemperature(-30 * metabolization_ratio * seconds_per_tick)
		if(ishuman(affected_mob))
			var/mob/living/carbon/human/humi = affected_mob
			humi.adjust_coretemperature(-30 * metabolization_ratio * seconds_per_tick)

/datum/reagent/cryostylane/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume < 5)
		return
	for(var/mob/living/basic/slime/exposed_slime in exposed_turf)
		exposed_slime.adjust_tox_loss(rand(15,30))

#undef CRYO_SPEED_PREFACTOR
#undef CRYO_SPEED_CONSTANT

/datum/reagent/pyrosium
	name = "炽热素"
	description = "在 20K 时形成。只要有足够的氧气供其反应，炽热素就会缓慢加热容器中的所有其他试剂。"
	color = "#64FAC8"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "苦涩"
	self_consuming = TRUE
	burning_temperature = null
	burning_volume = 0.05
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/pyrosium/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(holder.has_reagent(/datum/reagent/oxygen))
		holder.remove_reagent(/datum/reagent/oxygen, 0.5 * metabolization_ratio * seconds_per_tick)
		affected_mob.adjust_bodytemperature(15 * metabolization_ratio * seconds_per_tick)
		if(ishuman(affected_mob))
			var/mob/living/carbon/human/affected_human = affected_mob
			affected_human.adjust_coretemperature(15 * metabolization_ratio * seconds_per_tick)

/datum/reagent/pyrosium/burn(datum/reagents/holder)
	if(holder.has_reagent(/datum/reagent/oxygen))
		burning_temperature = 3500
		return
	burning_temperature = null

/datum/reagent/teslium //Teslium. Causes periodic shocks, and makes shocks against the target much more effective.
	name = "特斯拉素"
	description = "一种不稳定的带电金属浆液。会周期性地电击受害者，并使针对他们的电击更加致命。过度加热特斯拉素会导致危险的不稳定化。切勿让它接触水。"
	color = "#20324D" //RGB: 32, 50, 77
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "带电的金属"
	self_consuming = TRUE
	var/shock_timer = 0
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/teslium/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	shock_timer++
	if(shock_timer >= rand(5, 30)) //Random shocks are wildly unpredictable
		shock_timer = 0
		affected_mob.electrocute_act(rand(5, 20), "体内的特斯拉素", 1, SHOCK_NOGLOVES) //SHOCK_NOGLOVES because it's caused from INSIDE of you
		playsound(affected_mob, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/teslium/used_on_fish(obj/item/fish/fish)
	if(HAS_TRAIT_FROM(fish, TRAIT_FISH_ELECTROGENESIS, FISH_TRAIT_DATUM))
		return FALSE
	fish.add_traits(list(TRAIT_FISH_ON_TESLIUM, TRAIT_FISH_ELECTROGENESIS), type)
	addtimer(TRAIT_CALLBACK_REMOVE(fish, TRAIT_FISH_ON_TESLIUM, type), fish.feeding_frequency * 0.75, TIMER_UNIQUE|TIMER_OVERRIDE)
	addtimer(TRAIT_CALLBACK_REMOVE(fish, TRAIT_FISH_ELECTROGENESIS, type), fish.feeding_frequency * 0.75, TIMER_UNIQUE|TIMER_OVERRIDE)
	return TRUE

/datum/reagent/teslium/on_mob_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	if(!ishuman(affected_mob))
		return
	var/mob/living/carbon/human/affected_human = affected_mob
	affected_human.physiology.siemens_coeff *= 2

/datum/reagent/teslium/on_mob_end_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	if(!ishuman(affected_mob))
		return
	var/mob/living/carbon/human/affected_human = affected_mob
	affected_human.physiology.siemens_coeff *= 0.5

/datum/reagent/teslium/on_spark_act(power_charge, spark_flags)
	tesla_zap(source = holder.my_atom, zap_range = round(volume / 5, 1), power = volume * 20 + power_charge, cutoff = 1 KILO JOULES, zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE | ZAP_MOB_STUN | ZAP_LOW_POWER_GEN)
	playsound(holder.my_atom, 'sound/machines/defib/defib_zap.ogg', 50, TRUE)
	return SPARK_ACT_NON_DESTRUCTIVE

/datum/reagent/teslium/energized_jelly
	name = "充能凝胶"
	description = "带电荷的凝胶。能增强果冻人的神经系统，但对其他生命体只会造成电击。"
	color = "#CAFF43"
	taste_description = "果冻"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/teslium/energized_jelly/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	if(!(affected_mob.mob_biotypes & MOB_SLIME)) //everyone but jellypeople get shocked as normal.
		return ..()
	affected_mob.AdjustAllImmobility(-20  * metabolization_ratio * seconds_per_tick)
	if(affected_mob.adjust_stamina_loss(-5 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE))
		. = UPDATE_MOB_HEALTH
	if(is_species(affected_mob, /datum/species/jelly/luminescent))
		var/mob/living/carbon/human/affected_human = affected_mob
		var/datum/species/jelly/luminescent/slime_species = affected_human.dna.species
		slime_species.extract_cooldown = max(slime_species.extract_cooldown - (1 SECONDS * metabolization_ratio * seconds_per_tick), 0)

/datum/reagent/firefighting_foam
	name = "消防泡沫"
	description = "一种历史悠久的灭火剂。人们最初认为它只是排开氧气使火焰窒息，但它实际上会干扰燃烧反应本身。远优于纳米传讯舰船上常见的廉价水基灭火器。"
	color = "#A6FAFF55"
	taste_description = "灭火器内部的味道"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/firefighting_foam/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if (!istype(exposed_turf))
		return

	if(reac_volume >= 1)
		var/obj/effect/particle_effect/fluid/foam/firefighting/foam = (locate(/obj/effect/particle_effect/fluid/foam) in exposed_turf)
		if(!foam)
			foam = new(exposed_turf)
		else if(istype(foam))
			foam.lifetime = initial(foam.lifetime) //reduce object churn a little bit when using smoke by keeping existing foam alive a bit longer

	var/obj/effect/hotspot/hotspot = (locate(/obj/effect/hotspot) in exposed_turf)
	if(hotspot && !isspaceturf(exposed_turf) && exposed_turf.air)
		var/datum/gas_mixture/air = exposed_turf.air
		if(air.temperature > T20C)
			air.temperature = max(air.temperature/2,T20C)
		air.react(src)
		qdel(hotspot)

/datum/reagent/firefighting_foam/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	exposed_obj.extinguish()

/datum/reagent/firefighting_foam/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(methods & (TOUCH|VAPOR))
		exposed_mob.extinguish_mob() //All stacks are removed
