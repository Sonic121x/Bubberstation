

//////////////////////////////////////////////////////////////////////////////////////////
					// MEDICINE REAGENTS
//////////////////////////////////////////////////////////////////////////////////////

// where all the reagents related to medicine go.

/datum/reagent/medicine
	taste_description = "苦味"
	abstract_type = /datum/reagent/medicine

/datum/reagent/medicine/New()
	. = ..()
	// All medicine metabolizes out slower / stay longer if you have a better metabolism
	chemical_flags |= REAGENT_REVERSE_METABOLISM

/datum/reagent/medicine/leporazine
	name = "莱波拉嗪"
	description = "莱波拉嗪能有效调节患者的体温，确保其始终保持在安全范围内。"
	ph = 8.4
	color = "#DB90C6"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/leporazine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/target_temp = affected_mob.get_body_temp_normal(apply_change = FALSE)
	if(affected_mob.bodytemperature > target_temp)
		affected_mob.adjust_bodytemperature(-20 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, target_temp)
	else if(affected_mob.bodytemperature < (target_temp + 1))
		affected_mob.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, target_temp)
	if(ishuman(affected_mob))
		var/mob/living/carbon/human/affected_human = affected_mob
		if(affected_human.coretemperature > target_temp)
			affected_human.adjust_coretemperature(-20 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, target_temp)
		else if(affected_human.coretemperature < (target_temp + 1))
			affected_human.adjust_coretemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, target_temp)

/datum/reagent/medicine/adminordrazine //An OP chemical for admins
	name = "管理员嗪"
	description = "这是魔法。我们用不着解释。"
	color = "#E0BB00" //golden for the gods
	taste_description = "坏管理员"
	chemical_flags = REAGENT_DEAD_PROCESS
	metabolized_traits = list(TRAIT_ANALGESIA)
	/// Flags to fullheal every metabolism tick
	var/full_heal_flags = ~(HEAL_BRUTE|HEAL_BURN|HEAL_TOX|HEAL_RESTRAINTS|HEAL_ORGANS)

// The best stuff there is. For testing/debugging.
/datum/reagent/medicine/adminordrazine/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_waterlevel(round(volume))
	mytray.adjust_plant_health(round(volume))
	mytray.adjust_pestlevel(-rand(1,5))
	mytray.adjust_weedlevel(-rand(1,5))
	if(volume < 3)
		return

	switch(rand(100))
		if(66 to 100)
			mytray.mutatespecie()
		if(33 to 65)
			mytray.mutateweed()
		if(1 to 32)
			mytray.mutatepest()
		else
			if(prob(20))
				mytray.visible_message(span_warning("什么也没有发生……"))

/datum/reagent/medicine/adminordrazine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.heal_bodypart_damage(brute = 2.5 * metabolization_ratio * seconds_per_tick, burn = 2.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	affected_mob.adjust_tox_loss(-2.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, forced = TRUE, required_biotype = affected_biotype)
	// Heal everything! That we want to. But really don't heal reagents. Otherwise we'll lose ... us.
	affected_mob.fully_heal(full_heal_flags & ~HEAL_ALL_REAGENTS) // there is no need to return UPDATE_MOB_HEALTH because this proc calls updatehealth()

/datum/reagent/medicine/adminordrazine/quantum_heal
	name = "量子药物"
	description = "稀有而实验性的粒子，据说能将使用者的身体与另一个维度中完全健康的身体互换。"
	taste_description = "科学"
	full_heal_flags = ~(HEAL_ADMIN|HEAL_BRUTE|HEAL_BURN|HEAL_TOX|HEAL_RESTRAINTS|HEAL_ALL_REAGENTS|HEAL_ORGANS)

/datum/reagent/medicine/synaptizine
	name = "突触嗪"
	description = "提高对击晕的抗性，同时减轻困倦与幻觉。"
	color = COLOR_MAGENTA
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/synaptizine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustAllImmobility(-10 * metabolization_ratio * seconds_per_tick)

	if(holder.has_reagent(/datum/reagent/toxin/mindbreaker))
		holder.remove_reagent(/datum/reagent/toxin/mindbreaker, 2.5 * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_hallucinations(-10 SECONDS * metabolization_ratio * seconds_per_tick)
	if(SPT_PROB(16, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/medicine/synaphydramine
	name = "苯海拉明-突触嗪"
	description = "减轻困倦、幻觉，并清除体内的组胺。"
	color = "#EC536D" // rgb: 236, 83, 109
	ph = 5.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/synaphydramine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	if(holder.has_reagent(/datum/reagent/toxin/mindbreaker))
		holder.remove_reagent(/datum/reagent/toxin/mindbreaker, 2.5 * metabolization_ratio * seconds_per_tick)
	if(holder.has_reagent(/datum/reagent/toxin/histamine))
		holder.remove_reagent(/datum/reagent/toxin/histamine, 2.5 * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_hallucinations(-10 SECONDS * metabolization_ratio * seconds_per_tick)
	if(SPT_PROB(16, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/medicine/sansufentanyl
	name = "桑苏芬太尼"
	description = "暂时的副作用包括：恶心、头晕、运动协调能力受损。"
	color = "#07e4d1"
	ph = 6.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/sansufentanyl/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_confusion_up_to(1.5 SECONDS * metabolization_ratio * seconds_per_tick, 5 SECONDS)
	affected_mob.adjust_dizzy_up_to(3 SECONDS * metabolization_ratio * seconds_per_tick, 12 SECONDS)
	if(affected_mob.adjust_stamina_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE))
		. = UPDATE_MOB_HEALTH

	if(SPT_PROB(10, seconds_per_tick))
		to_chat(affected_mob, "你感到困惑而迷失方向。")
		if(prob(30))
			SEND_SOUND(affected_mob, sound('sound/items/weapons/flash_ring.ogg'))

/datum/reagent/medicine/cryoxadone
	name = "冷冻沙酮"
	description = "一种几乎具有魔法般治疗能力的化学混合物。其主要限制在于患者的体温必须低于 270K 才能正常代谢。"
	color = "#0000C8"
	taste_description = "蓝色"
	ph = 11
	burning_temperature = 20 //cold burning
	burning_volume = 0.1
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/cryoxadone/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	metabolization_rate = REAGENTS_METABOLISM * (0.00001 * (affected_mob.bodytemperature ** 2) + 0.5)
	if(affected_mob.bodytemperature >= T0C)
		return
	var/power = -0.00003 * (affected_mob.bodytemperature ** 2) + 3
	if(IS_UNCONSCIOUS(affected_mob)) //Significantly more effective when unconscious
		power *= 2
	var/need_mob_update
	need_mob_update = affected_mob.adjust_oxy_loss(-1.5 * power * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_brute_loss(-0.5 * power * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(-0.5 * power * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_tox_loss(-0.5 * power * metabolization_ratio * seconds_per_tick, updating_health = FALSE, forced = TRUE, required_biotype = affected_biotype) //heals TOXINLOVERs
	for(var/i in affected_mob.all_wounds)
		var/datum/wound/iter_wound = i
		iter_wound.on_xadone(0.5 * power * metabolization_ratio * seconds_per_tick)
	var/obj/item/bodypart/head = affected_mob.get_bodypart(BODY_ZONE_HEAD)
	if (head)
		REMOVE_TRAIT(head, TRAIT_DISFIGURED, TRAIT_GENERIC) //fixes common causes for disfiguration
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

// Healing
/datum/reagent/medicine/cryoxadone/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(round(volume * 3))
	mytray.adjust_toxic(-round(volume * 3))

/datum/reagent/medicine/pyroxadone
	name = "炽热沙酮"
	description = "冷冻沙酮与史莱姆凝胶的混合物，显然将其激活条件反转了。"
	color = "#f7832a"
	taste_description = "辛辣凝胶"
	ph = 12
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/pyroxadone/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.bodytemperature <= BODYTEMP_HEAT_DAMAGE_LIMIT)
		return
	var/power = 0
	switch(affected_mob.bodytemperature)
		if(BODYTEMP_HEAT_DAMAGE_LIMIT to 400)
			power = 2
		if(400 to 460)
			power = 3
		else
			power = 5
	if(affected_mob.on_fire)
		power *= 2

	var/need_mob_update
	need_mob_update = affected_mob.adjust_oxy_loss(-1 * power * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_brute_loss(-0.5 * power * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(-0.75 * power * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_tox_loss(-0.5 * power * metabolization_ratio * seconds_per_tick, updating_health = FALSE, forced = TRUE, required_biotype = affected_biotype)
	if(need_mob_update)
		. = UPDATE_MOB_HEALTH
	for(var/i in affected_mob.all_wounds)
		var/datum/wound/iter_wound = i
		iter_wound.on_xadone(0.5 * power * metabolization_ratio * seconds_per_tick)
	var/obj/item/bodypart/head = affected_mob.get_bodypart(BODY_ZONE_HEAD)
	if (head)
		REMOVE_TRAIT(head, TRAIT_DISFIGURED, TRAIT_GENERIC)

/datum/reagent/medicine/rezadone
	name = "复生沙酮"
	description = "由鱼毒素提取的粉末，复生沙酮能有效恢复被烧成焦壳的尸体，也能治疗轻伤。过量使用会引起剧烈恶心和轻微毒素伤害。"
	color = "#669900" // rgb: 102, 153, 0
	overdose_threshold = 30
	ph = 12.2
	taste_description = "鱼"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.25
	inverse_chem = /datum/reagent/inverse/rezadone

// Rezadone is almost never used in favor of cryoxadone. Hopefully this will change that. // No such luck so far // with clone damage gone, someone will find a better use for rezadone... right?
/datum/reagent/medicine/rezadone/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.heal_bodypart_damage(
		brute = 0.5 * metabolization_ratio * seconds_per_tick,
		burn = 0.5 * metabolization_ratio * seconds_per_tick,
		updating_health = FALSE,
		required_bodytype = affected_biotype
	))
		. = UPDATE_MOB_HEALTH
	var/obj/item/bodypart/head = affected_mob.get_bodypart(BODY_ZONE_HEAD)
	if (head)
		REMOVE_TRAIT(head, TRAIT_DISFIGURED, TRAIT_GENERIC)

/datum/reagent/medicine/rezadone/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		. = UPDATE_MOB_HEALTH
	affected_mob.set_dizzy_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/medicine/rezadone/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if(!iscarbon(exposed_mob))
		return

	var/functional_react_volume = reac_volume * (1 - touch_protection)

	var/mob/living/carbon/patient = exposed_mob
	if(functional_react_volume >= 5 && HAS_TRAIT(patient, TRAIT_HUSK) && patient.get_fire_loss() < UNHUSK_DAMAGE_THRESHOLD) //One carp yields 12u rezadone. // BUBBER EDIT CHANGE - Synthflesh works on ling husks - Original: HAS_TRAIT_FROM(patient, TRAIT_HUSK, BURN)
		patient.cure_husk() // BUBBER EDIT CHANGE - Synthflesh works on ling husks - Original: patient.cure_husk(BURN)
		patient.visible_message(span_nicegreen("[patient] 的身体迅速从环境中吸收水分，气色显得健康了许多。"))

/datum/reagent/medicine/spaceacillin
	name = "太空青霉素"
	description = "太空青霉素能提供有限的疾病与寄生虫抗性，也能减轻严重烧伤的感染。"
	color = "#E1F2E6"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	ph = 8.1
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.3
	inverse_chem = /datum/reagent/inverse/spaceacillin
	added_traits = list(TRAIT_VIRUS_RESISTANCE)

//Goon Chems. Ported mainly from Goonstation. Easily mixable (or not so easily) and provide a variety of effects.

/datum/reagent/medicine/oxandrolone
	name = "氧雄龙"
	description = "促进严重烧伤的愈合。对严重烧伤愈合极快，对轻伤则较慢。过量使用会加重现有烧伤。"
	color = "#1E8BFF"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 25
	ph = 10.7
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.3
	inverse_chem = /datum/reagent/inverse/oxandrolone

/datum/reagent/medicine/oxandrolone/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(affected_mob.get_fire_loss() > 25)
		need_mob_update = affected_mob.adjust_fire_loss(-4 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), updating_health = FALSE, required_bodytype = affected_bodytype) //Twice as effective as AIURI for severe burns
	else
		need_mob_update = affected_mob.adjust_fire_loss(-0.5 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), updating_health = FALSE, required_bodytype = affected_bodytype) //But only a quarter as effective for more minor ones
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/oxandrolone/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_fire_loss()) //It only makes existing burns worse
		if(affected_mob.adjust_fire_loss(4.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_biotype)) // it's going to be healing either 4 or 0.5
			return UPDATE_MOB_HEALTH

/datum/reagent/medicine/salglu_solution
	name = "葡萄糖盐水"
	description = "每个代谢周期有 33% 的概率治疗钝击和烧伤。可作为临时血液替代品，并缓慢加快血液再生。"
	color = "#DCDCDC"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 60
	taste_description = "甜味与咸味"
	ph = 5.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

	/// Add about half this much extra blood regen per second.
	var/extra_regen = 0.25

	/// Add many extra units of blood per unit of saline.
	var/dilution_per_unit = 5

	/// Doesn't dilute blood beyond this point.
	var/dilution_cap = BLOOD_VOLUME_NORMAL

	/// Only supplements blood types that use this restoration chem.
	var/required_restoration_chem = /datum/reagent/iron

/datum/reagent/medicine/salglu_solution/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update = FALSE

	if(SPT_PROB(18, seconds_per_tick))
		need_mob_update = affected_mob.adjust_brute_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_bodytype = affected_biotype)
		need_mob_update += affected_mob.adjust_fire_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_bodytype = affected_biotype)

	// Regen is handled here, dilution is handled in [living/proc/get_blood_volume]
	var/datum/blood_type/blood_type = affected_mob.get_bloodtype()
	if(blood_type?.restoration_chem == required_restoration_chem)
		affected_mob.adjust_blood_volume(1 * extra_regen * metabolization_ratio * seconds_per_tick)

	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/salglu_solution/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(SPT_PROB(1.5, seconds_per_tick))
		if(holder)
			to_chat(affected_mob, span_warning("你感到嘴里发咸。"))
			holder.add_reagent(/datum/reagent/consumable/salt, 1)
			holder.remove_reagent(/datum/reagent/medicine/salglu_solution, 0.5)
	else if(SPT_PROB(1.5, seconds_per_tick))
		if(holder)
			to_chat(affected_mob, span_warning("你感到嘴里发甜。"))
			holder.add_reagent(/datum/reagent/consumable/sugar, 1)
			holder.remove_reagent(/datum/reagent/medicine/salglu_solution, 0.5)
	if(SPT_PROB(18, seconds_per_tick))
		need_mob_update = affected_mob.adjust_brute_loss(0.5 * metabolization_ratio, updating_health = FALSE, required_bodytype = affected_biotype)
		need_mob_update += affected_mob.adjust_fire_loss(0.5 * metabolization_ratio, updating_health = FALSE, required_bodytype = affected_biotype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/mine_salve
	name = "矿工药膏"
	description = "强效止痛药。能恢复瘀伤和烧伤，同时让患者误以为自己已经完全痊愈。在紧急情况下也非常适合处理严重烧伤。"
	color = "#6D6374"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	ph = 2.6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_AFFECTS_WOUNDS
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_ANALGESIA)

/datum/reagent/medicine/mine_salve/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	need_mob_update = affected_mob.adjust_brute_loss(-0.3125 * metabolization_ratio * seconds_per_tick, FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(-0.3125 * metabolization_ratio * seconds_per_tick, FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/mine_salve/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if(!iscarbon(exposed_mob) || (exposed_mob.stat == DEAD))
		return

	if(methods & (INGEST|VAPOR|INJECT|INHALE))
		var/miner_cramps = 5 * (1 - touch_protection)
		if(miner_cramps)
			exposed_mob.adjust_nutrition(-miner_cramps)
			if(show_message)
				to_chat(exposed_mob, span_warning("你的胃空空如也，还一阵抽搐！"))

	if(methods & (PATCH|TOUCH))
		exposed_mob.add_surgery_speed_mod(type, 0.9, min(reac_volume * 1 MINUTES, 5 MINUTES))
		if(show_message)
			to_chat(exposed_mob, span_danger("你感觉自己的伤痛全都消失了！") )

/datum/reagent/medicine/mine_salve/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/medicine/mine_salve/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/medicine/mine_salve/on_burn_wound_processing(datum/wound/burn/flesh/burn_wound)
	burn_wound.sanitization += 0.3
	burn_wound.flesh_healing += 0.5

/datum/reagent/medicine/omnizine
	name = "全能嗪"
	description = "缓慢治疗所有伤害类型。过量使用则会改为造成所有类型的伤害。"
	color = "#DCDCDC"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/healing = 0.5

/datum/reagent/medicine/omnizine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/heal = -2 * healing * metabolization_ratio * seconds_per_tick
	var/need_mob_update
	need_mob_update = affected_mob.adjust_tox_loss(heal, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_oxy_loss(heal, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_brute_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/omnizine/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/hurt = 3 * metabolization_ratio * seconds_per_tick
	var/need_mob_update
	need_mob_update = affected_mob.adjust_tox_loss(hurt, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_oxy_loss(hurt, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_brute_loss(hurt, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(hurt, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/omnizine/protozine
	name = "原型嗪"
	description = "全能嗪的一种更不环保、效果也稍弱的变体。"
	color = "#d8c7b7"
	healing = 0.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/calomel
	name = "甘汞"
	description = "迅速清除体内除自身以外的所有化学物质。人的生命值越高，\
		造成的毒素伤害越多；当生命值足够低时，它则能治疗毒素伤害。"
	color = "#c85319"
	taste_description = "酸味"
	overdose_threshold = 20
	ph = 1.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/calomel/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	for(var/datum/reagent/target_reagent as anything in affected_mob.reagents.reagent_list)
		if(istype(target_reagent, /datum/reagent/medicine/calomel))
			continue
		affected_mob.reagents.remove_reagent(target_reagent.type, 1.5 * target_reagent.purge_multiplier * metabolization_ratio * seconds_per_tick)
	var/toxin_amount = round(affected_mob.health / 40, 0.1)
	if(affected_mob.adjust_tox_loss(0.5 * toxin_amount * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/calomel/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.reagents.remove_reagent(type, 1 * metabolization_ratio * seconds_per_tick)
	if(affected_mob.adjust_tox_loss(1.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/ammoniated_mercury
	name = "氨化汞"
	description = "迅速清除体内的有毒化学物质。当一个人状态良好、没有钝击和烧伤时，\
		它能治疗毒素伤害。当受到钝击或烧伤时，它可能造成大量毒素伤害。\
		当体内没有毒素时，它会开始缓慢清除自身。"
	color = "#f3f1f0"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	taste_description = "金属味"
	overdose_threshold = 10
	ph = 7
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.50
	inverse_chem = /datum/reagent/inverse/ammoniated_mercury

/datum/reagent/medicine/ammoniated_mercury/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/toxin_chem_amount = 0
	for(var/datum/reagent/toxin/target_reagent in affected_mob.reagents.reagent_list)
		toxin_chem_amount += 1
		affected_mob.reagents.remove_reagent(target_reagent.type, 25 * target_reagent.purge_multiplier * metabolization_ratio * seconds_per_tick)
	var/toxin_amount = round(affected_mob.get_brute_loss() / 15, 0.1) + round(affected_mob.get_fire_loss() / 30, 0.1) - 3
	if(affected_mob.adjust_tox_loss(5 * toxin_amount * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		. = UPDATE_MOB_HEALTH
	if(toxin_chem_amount == 0)
		for(var/datum/reagent/medicine/ammoniated_mercury/target_reagent in affected_mob.reagents.reagent_list)
			affected_mob.reagents.remove_reagent(target_reagent.type, 5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/medicine/ammoniated_mercury/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_tox_loss(15 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/potass_iodide
	name = "碘化钾"
	description = "在患者受到辐射时治疗轻度毒素伤害，并中止辐射的伤害效果。"
	color = "#BAA15D"
	metabolization_rate = 2 * REAGENTS_METABOLISM
	ph = 12 //It's a reducing agent
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_HALT_RADIATION_EFFECTS)

/datum/reagent/medicine/potass_iodide/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(HAS_TRAIT(affected_mob, TRAIT_IRRADIATED))
		if(affected_mob.adjust_tox_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/medicine/pen_acid
	name = "喷替酸"
	description = "降低大量毒素伤害，同时清除体内的其他化学物质。"
	color = "#E6FFF0"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	ph = 1 //One of the best buffers, NEVERMIND!
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.4
	inverse_chem = /datum/reagent/inverse/pen_acid
	metabolized_traits = list(TRAIT_HALT_RADIATION_EFFECTS)

/datum/reagent/medicine/pen_acid/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_tox_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		. = UPDATE_MOB_HEALTH
	for(var/datum/reagent/reagent as anything in affected_mob.reagents.reagent_list)
		if(reagent != src)
			affected_mob.reagents.remove_reagent(reagent.type, 2 * reagent.purge_multiplier * metabolization_ratio * seconds_per_tick)

/datum/reagent/medicine/sal_acid
	name = "水杨酸"
	description = "促进严重瘀伤的愈合。对严重瘀伤愈合极快，对轻伤则较慢。过量使用会加重现有瘀伤。"
	color = "#D2D2D2"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 25
	ph = 2.1
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.3
	inverse_chem = /datum/reagent/inverse/sal_acid

/datum/reagent/medicine/sal_acid/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(affected_mob.get_brute_loss() > 25)
		need_mob_update = affected_mob.adjust_brute_loss(-4 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), updating_health = FALSE, required_bodytype = affected_bodytype)
	else
		need_mob_update = affected_mob.adjust_brute_loss(-0.5 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/sal_acid/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_brute_loss()) //It only makes existing bruises worse
		if(affected_mob.adjust_brute_loss(4.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)) // it's going to be healing either 4 or 0.5
			return UPDATE_MOB_HEALTH

/datum/reagent/medicine/salbutamol
	name = "舒喘宁"
	description = "迅速恢复缺氧状态，并在一定程度上防止进一步缺氧。"
	color = COLOR_CYAN
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.25
	inverse_chem = /datum/reagent/inverse/salbutamol

/datum/reagent/medicine/salbutamol/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	need_mob_update = affected_mob.adjust_oxy_loss(-6 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	affected_mob.losebreath = max(0, affected_mob.losebreath - (4 * metabolization_ratio * seconds_per_tick))
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/albuterol
	name = "沙丁胺醇"
	description = "一种强效支气管扩张剂，能增加肺部吸入的气体量。对中止哮喘发作极为有效，\
		但仅在吸入时有效。过量使用会导致过度扩张，使肺功能下降。"
	taste_description = "苦涩而咸的空气"
	overdose_threshold = 30
	color = "#8df5f0"
	metabolization_rate = REAGENTS_METABOLISM
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/inhaler_canister

	/// The decrement we will apply to the received_pressure_mult of our targets lungs.
	var/pressure_mult_increment = 0.4
	/// After this many cycles of overdose, we activate secondary effects.
	var/secondary_overdose_effect_cycle_threshold = 40
	/// We stop increasing stamina damage once we reach this number.
	var/maximum_od_stamina_damage = 80

/datum/reagent/medicine/albuterol/on_mob_metabolize(mob/living/affected_mob)
	. = ..()

	if (!iscarbon(affected_mob))
		return

	// has additional effects on asthma, but that's handled in the quirk

	RegisterSignal(affected_mob, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(holder_lost_organ))
	RegisterSignal(affected_mob, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(holder_gained_organ))
	var/mob/living/carbon/carbon_mob = affected_mob
	var/obj/item/organ/lungs/holder_lungs = carbon_mob.get_organ_slot(ORGAN_SLOT_LUNGS)
	holder_lungs?.adjust_received_pressure_mult(pressure_mult_increment)

/datum/reagent/medicine/albuterol/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()

	if (!iscarbon(affected_mob))
		return

	UnregisterSignal(affected_mob, list(COMSIG_CARBON_LOSE_ORGAN, COMSIG_CARBON_GAIN_ORGAN))
	var/mob/living/carbon/carbon_mob = affected_mob
	var/obj/item/organ/lungs/holder_lungs = carbon_mob.get_organ_slot(ORGAN_SLOT_LUNGS)
	holder_lungs?.adjust_received_pressure_mult(-pressure_mult_increment)

/datum/reagent/medicine/albuterol/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()

	if (!iscarbon(affected_mob))
		return

	var/mob/living/carbon/carbon_mob = affected_mob
	if (SPT_PROB(25, seconds_per_tick))
		carbon_mob.adjust_jitter_up_to(2 SECONDS, 20 SECONDS)
	if (SPT_PROB(35, seconds_per_tick))
		if (prob(60))
			carbon_mob.losebreath += 1
			to_chat(affected_mob, span_danger("你的膈肌一阵痉挛，你发现自己无法呼吸！"))
		else
			carbon_mob.breathe(seconds_per_tick)
			to_chat(affected_mob, span_danger("你的膈肌一阵痉挛，你不由自主地吸了口气！"))

	if (current_cycle > secondary_overdose_effect_cycle_threshold)
		if (SPT_PROB(30, seconds_per_tick))
			carbon_mob.adjust_eye_blur_up_to(6 SECONDS, 30 SECONDS)
		if (carbon_mob.get_stamina_loss() < maximum_od_stamina_damage)
			carbon_mob.adjust_stamina_loss(seconds_per_tick)

/datum/reagent/medicine/albuterol/proc/holder_lost_organ(datum/source, obj/item/organ/lost)
	SIGNAL_HANDLER

	if (istype(lost, /obj/item/organ/lungs))
		var/obj/item/organ/lungs/holder_lungs = lost
		holder_lungs.adjust_received_pressure_mult(-pressure_mult_increment)

/datum/reagent/medicine/albuterol/proc/holder_gained_organ(datum/source, obj/item/organ/gained)
	SIGNAL_HANDLER

	if (istype(gained, /obj/item/organ/lungs))
		var/obj/item/organ/lungs/holder_lungs = gained
		holder_lungs.adjust_received_pressure_mult(pressure_mult_increment)

/datum/reagent/medicine/ephedrine
	name = "麻黄碱"
	description = "提高对警棍的抗性并提升移动速度，但会让你的手抽筋。过量使用会造成毒素伤害并抑制呼吸。"
	color = "#D2FFFA"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 30
	ph = 12
	purity = REAGENT_STANDARD_PURITY
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	addiction_types = list(/datum/addiction/stimulants = 150)
	inverse_chem = /datum/reagent/inverse/corazargh
	inverse_chem_val = 0.4
	metabolized_traits = list(TRAIT_BATON_RESISTANCE, TRAIT_STIMULATED)

/datum/reagent/medicine/ephedrine/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/ephedrine)
	var/purity_movespeed_accounting = -0.375 * normalise_creation_purity()
	affected_mob.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/reagent/ephedrine, TRUE, purity_movespeed_accounting)

/datum/reagent/medicine/ephedrine/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/ephedrine)

/datum/reagent/medicine/ephedrine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/active_held_item = affected_mob.get_active_held_item()
	if(SPT_PROB(10 * (1.5-creation_purity), seconds_per_tick) && iscarbon(affected_mob) && active_held_item?.w_class > WEIGHT_CLASS_SMALL)
		if(active_held_item && affected_mob.dropItemToGround(active_held_item))
			to_chat(affected_mob, span_notice("你的双手猛地一抽，把拿着的东西掉了！"))
			affected_mob.set_jitter_if_lower(20 SECONDS)

	affected_mob.AdjustAllImmobility(-20 * metabolization_ratio * seconds_per_tick * normalise_creation_purity())
	affected_mob.adjust_stamina_loss(-4 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), updating_stamina = FALSE)

	return UPDATE_MOB_HEALTH

/datum/reagent/medicine/ephedrine/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(1 * (1 + (1-normalise_creation_purity())), seconds_per_tick) && iscarbon(affected_mob))
		affected_mob.apply_status_effect(/datum/status_effect/heart_attack)
		to_chat(affected_mob, span_userdanger("你很确定自己刚才心跳停了一瞬……"))
		affected_mob.playsound_local(affected_mob, 'sound/effects/singlebeat.ogg', 100, 0)

	if(SPT_PROB(3.5 * (1 + (1-normalise_creation_purity())), seconds_per_tick))
		to_chat(affected_mob, span_notice("[pick("你的头阵阵作痛。", "你感到胸口一阵闷痛。", "你发现自己很难保持不动。", "你感觉心脏几乎要跳出胸腔。")]"))

	if(SPT_PROB(18 * (1 + (1-normalise_creation_purity())), seconds_per_tick))
		affected_mob.adjust_tox_loss(1 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype)
		affected_mob.losebreath++
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/diphenhydramine
	name = "苯海拉明"
	description = "迅速清除体内的组胺并减轻颤抖。有较小概率引起困倦。"
	color = "#64FFE6"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	ph = 11.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/diphenhydramine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick))
		affected_mob.adjust_drowsiness(2 SECONDS)
	affected_mob.adjust_jitter(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	holder.remove_reagent(/datum/reagent/toxin/histamine, 2 * metabolization_ratio * seconds_per_tick)

/datum/reagent/medicine/morphine
	name = "吗啡"
	description = "一种止痛药，能让患者即使受伤也全速移动。高剂量会引起困倦并最终失去意识。过量使用会引起从轻微到致命的各种效果。"
	color = "#A9FBFB"
	taste_description = "带香水味的苦涩香草"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 30
	ph = 8.96
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	addiction_types = list(/datum/addiction/opioids = 30)
	metabolized_traits = list(TRAIT_ANALGESIA)

/datum/reagent/medicine/morphine/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/morphine/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/morphine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(current_cycle > 5)
		affected_mob.add_mood_event("numb", /datum/mood_event/narcotic_medium, name)
	if(affected_mob.disgust < DISGUST_LEVEL_VERYGROSS && SPT_PROB(50 * (2 - creation_purity), seconds_per_tick))
		affected_mob.adjust_disgust(1.5 * metabolization_ratio)

	switch(current_cycle)
		if(16) //~3u
			to_chat(affected_mob, span_warning("你开始感到疲倦……"))
			affected_mob.adjust_eye_blur(2 SECONDS * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(66, seconds_per_tick))
				affected_mob.emote("yawn")

		if(24 to 36) // 5u to 7.5u
			if(SPT_PROB(66 * (2 - creation_purity), seconds_per_tick))
				affected_mob.adjust_drowsiness_up_to(2 SECONDS * metabolization_ratio, 12 SECONDS)

		if(36 to 48) // 7.5u to 10u
			affected_mob.adjust_drowsiness_up_to(2 SECONDS * metabolization_ratio * seconds_per_tick, 12 SECONDS)

		if(48 to INFINITY) //10u onward
			affected_mob.adjust_drowsiness_up_to(3 SECONDS * metabolization_ratio * seconds_per_tick, 20 SECONDS)
			// doesn't scale from purity - at this point it tries to guarantee sleep
			if(SPT_PROB(30 * (48 - current_cycle), seconds_per_tick))
				affected_mob.Sleeping(4 SECONDS * metabolization_ratio)

/datum/reagent/medicine/morphine/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(18, seconds_per_tick))
		affected_mob.drop_all_held_items()
		affected_mob.set_dizzy_if_lower(4 SECONDS)
		affected_mob.set_jitter_if_lower(4 SECONDS)


/datum/reagent/medicine/oculine
	name = "眼明素"
	description = "迅速恢复眼部损伤，治愈近视，并有机会让失明者恢复视力。"
	color = "#404040" //oculine is dark grey, inacusiate is light grey
	overdose_threshold = 30
	taste_description = "泥土般的苦味"
	purity = REAGENT_STANDARD_PURITY
	ph = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem = /datum/reagent/inverse/oculine
	inverse_chem_val = 0.45
	///The lighting alpha that the mob had on addition
	var/delta_light

/datum/reagent/medicine/oculine/on_mob_add(mob/living/affected_mob)
	if(!iscarbon(affected_mob))
		return
	RegisterSignal(affected_mob, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_gained_organ))
	RegisterSignal(affected_mob, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_removed_organ))
	var/obj/item/organ/eyes/eyes = affected_mob.get_organ_slot(ORGAN_SLOT_EYES)
	if(!eyes)
		return
	improve_eyesight(affected_mob, eyes)


/datum/reagent/medicine/oculine/proc/improve_eyesight(mob/living/carbon/affected_mob, obj/item/organ/eyes/eyes)
	delta_light = creation_purity*10
	eyes.lighting_cutoff += delta_light
	affected_mob.update_sight()

/datum/reagent/medicine/oculine/proc/restore_eyesight(mob/living/carbon/affected_mob, obj/item/organ/eyes/eyes)
	eyes.lighting_cutoff -= delta_light
	affected_mob.update_sight()

/datum/reagent/medicine/oculine/proc/on_gained_organ(mob/affected_mob, obj/item/organ/organ)
	SIGNAL_HANDLER
	if(!istype(organ, /obj/item/organ/eyes))
		return
	var/obj/item/organ/eyes/affected_eyes = organ
	improve_eyesight(affected_mob, affected_eyes)

/datum/reagent/medicine/oculine/proc/on_removed_organ(mob/prev_affected_mob, obj/item/organ/organ)
	SIGNAL_HANDLER
	if(!istype(organ, /obj/item/organ/eyes))
		return
	var/obj/item/organ/eyes/eyes = organ
	restore_eyesight(prev_affected_mob, eyes)

/datum/reagent/medicine/oculine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/normalized_purity = normalise_creation_purity()
	affected_mob.adjust_temp_blindness(-2 SECONDS * metabolization_ratio * seconds_per_tick * normalized_purity)
	affected_mob.adjust_eye_blur(-2 SECONDS * metabolization_ratio * seconds_per_tick * normalized_purity)
	var/obj/item/organ/eyes/eyes = affected_mob.get_organ_slot(ORGAN_SLOT_EYES)
	if(eyes)
		// Healing eye damage will cure nearsightedness and blindness from ... eye damage
		if(eyes.apply_organ_damage(-1 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), required_organ_flag = affected_organ_flags))
			. = UPDATE_MOB_HEALTH
		// If our eyes are seriously damaged, we have a probability of causing eye blur while healing depending on purity
		if(eyes.damage >= eyes.low_threshold && IS_ORGANIC_ORGAN(eyes) && SPT_PROB(16 - min(normalized_purity * 6, 12), seconds_per_tick))
			// While healing, gives some eye blur
			if(affected_mob.is_blind_from(EYE_DAMAGE))
				to_chat(affected_mob, span_warning("你的视觉缓缓恢复了……"))
				affected_mob.adjust_eye_blur(20 SECONDS)
			else if(affected_mob.is_nearsighted_from(EYE_DAMAGE))
				to_chat(affected_mob, span_warning("你余光中的黑暗开始消退。"))
				affected_mob.adjust_eye_blur(5 SECONDS)

/datum/reagent/medicine/oculine/on_mob_delete(mob/living/affected_mob)
	. = ..()
	var/obj/item/organ/eyes/eyes = affected_mob.get_organ_slot(ORGAN_SLOT_EYES)
	if(!eyes)
		return
	restore_eyesight(affected_mob, eyes)

/datum/reagent/medicine/oculine/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_EYES, 0.75 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags))
		. = UPDATE_MOB_HEALTH

/datum/reagent/medicine/oculine/flumpuline
	name = "菌柄素"
	description = "常被误认为眼明素或其变体，甚至被当作眼明素出售。它会缓慢将患者的眼睛变成怪异的菌柄——不过你再也不用戴眼镜了。"
	color = "#6c596d"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 5
	taste_description = "真菌"
	purity = 1
	ph = 0.01
	chemical_flags = REAGENT_DEAD_PROCESS|REAGENT_IGNORE_STASIS|REAGENT_NO_RANDOM_RECIPE|REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_MAINTENANCE_PILL
	inverse_chem = /datum/reagent/inverse
	inverse_chem_val = 0
	var/static/list/eye_types = list(/obj/item/organ/eyes/snail, /obj/item/organ/eyes/night_vision/mushroom)

/datum/reagent/medicine/oculine/flumpuline/improve_eyesight(mob/living/carbon/affected_mob, obj/item/organ/eyes/eyes)
	delta_light = 200 //2x better than pure oculine
	eyes.lighting_cutoff += delta_light
	affected_mob.update_sight()

/datum/reagent/medicine/oculine/flumpuline/restore_eyesight(mob/living/carbon/affected_mob, obj/item/organ/eyes/eyes)
	eyes.lighting_cutoff -= delta_light
	affected_mob.update_sight()

/datum/reagent/medicine/oculine/flumpuline/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/eyes/eyes = affected_mob.get_organ_slot(ORGAN_SLOT_EYES)
	// if no eyes or inorganic do nothing. we let already changed eyes go because funny
	if(!eyes || !IS_ORGANIC_ORGAN(eyes))
		return .

	if(!prob(2))
		return .

	flump_eyes(affected_mob, eyes)

// Overdose causes constant eye popping
/datum/reagent/medicine/oculine/flumpuline/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!prob(25))
		return
	var/obj/item/organ/eyes/eyes = affected_mob.get_organ_slot(ORGAN_SLOT_EYES)

	flump_eyes(affected_mob, eyes)

/datum/reagent/medicine/oculine/flumpuline/proc/flump_eyes(mob/affected_mob, obj/eyes)
	var/obj/item/organ/eyes/new_eyes = pick(eye_types)
	new_eyes = new new_eyes(affected_mob)
	new_eyes.Insert(affected_mob)
	playsound(affected_mob, 'sound/effects/cartoon_sfx/cartoon_pop.ogg', 50, TRUE)
	affected_mob.visible_message(span_danger("[affected_mob] 的 [eyes ? eyes : "眼眶"] 突然长出菌柄，变成了 [new_eyes]！"))
	ASYNC
		affected_mob.emote("scream")
		sleep(5 SECONDS)
		if(!QDELETED(eyes))
			eyes.visible_message(span_danger("[eyes] 迅速化为灰尘。"))
			eyes.dust()

/datum/reagent/medicine/inacusiate
	name = "复聪素"
	description = "迅速修复患者耳部的损伤以治愈耳聋，前提是耳聋的原因不是基因突变、慢性耳聋或耳朵完全缺失。" //by "chronic" deafness, we mean people with the "deaf" quirk
	color = "#606060" // ditto
	ph = 2
	purity = REAGENT_STANDARD_PURITY
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.3
	inverse_chem = /datum/reagent/impurity/inacusiate

/datum/reagent/medicine/inacusiate/on_mob_add(mob/living/affected_mob, amount)
	. = ..()
	if(creation_purity >= 1)
		ADD_TRAIT(affected_mob, TRAIT_GOOD_HEARING, type)
		if(!HAS_TRAIT(affected_mob, TRAIT_DEAF))
			to_chat(affected_mob, span_nicegreen("你能感觉到自己的听力大幅提升！"))

/datum/reagent/medicine/inacusiate/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/ears/ears = affected_mob.get_organ_slot(ORGAN_SLOT_EARS)
	if(!ears)
		return
	var/multiplier = normalise_creation_purity() * metabolization_ratio * seconds_per_tick
	ears.apply_organ_damage(-2 * multiplier)
	ears.adjust_temporary_deafness(-4 * multiplier)
	return UPDATE_MOB_HEALTH

/datum/reagent/medicine/inacusiate/on_mob_delete(mob/living/affected_mob)
	. = ..()
	REMOVE_TRAIT(affected_mob, TRAIT_GOOD_HEARING, type)
	if(!HAS_TRAIT(affected_mob, TRAIT_DEAF))
		to_chat(affected_mob, span_notice("你的听力恢复到正常灵敏度。"))

/datum/reagent/medicine/atropine
	name = "阿托品"
	description = "若患者处于危急状态，能迅速治疗所有伤害类型并调节体内氧气。非常适合稳定重伤患者，据说还能中和潜伏特工体内由血液激活的内置爆炸物。"
	color = "#1D3535" //slightly more blue, like epinephrine
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 35
	ph = 12
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.35
	inverse_chem = /datum/reagent/inverse/atropine
	added_traits = list(TRAIT_NOCRITDAMAGE, TRAIT_PREVENT_IMPLANT_AUTO_EXPLOSION)

/datum/reagent/medicine/atropine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.health <= affected_mob.crit_threshold)
		var/need_mob_update
		need_mob_update = affected_mob.adjust_tox_loss(-4 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_brute_loss(-4 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_fire_loss(-4 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_oxy_loss(-10 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			. = UPDATE_MOB_HEALTH
	affected_mob.losebreath = 0
	if(SPT_PROB(10, seconds_per_tick))
		affected_mob.set_dizzy_if_lower(10 SECONDS)
		affected_mob.set_jitter_if_lower(10 SECONDS)

/datum/reagent/medicine/atropine/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_tox_loss(1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		. = UPDATE_MOB_HEALTH
	affected_mob.set_dizzy_if_lower(4 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.set_jitter_if_lower(4 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/medicine/epinephrine
	name = "肾上腺素"
	description = "稳定并缓慢治疗处于危急状态的患者，同时减缓窒息。\
		还会提供极微小的眩晕抗性加成。过量使用会导致虚弱和毒素伤害。"
	color = "#D2FFFA"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30
	ph = 10.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_NOCRITDAMAGE)

/datum/reagent/medicine/epinephrine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(holder.has_reagent(/datum/reagent/toxin/lexorin))
		if(SPT_PROB(10, seconds_per_tick))
			holder.add_reagent(/datum/reagent/toxin/histamine, 4)
		return

	var/need_mob_update
	if(affected_mob.health <= affected_mob.crit_threshold)
		var/heal = -1 * metabolization_ratio * seconds_per_tick
		need_mob_update = affected_mob.adjust_tox_loss(heal, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_brute_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_fire_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_oxy_loss(heal, updating_health = FALSE, required_biotype = affected_biotype)
	affected_mob.losebreath = max(0, affected_mob.losebreath - (4 * metabolization_ratio * seconds_per_tick))
	need_mob_update += affected_mob.adjust_stamina_loss(-4 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE)
	if(SPT_PROB(10, seconds_per_tick))
		affected_mob.AdjustAllImmobility(-20)
		need_mob_update = TRUE
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/epinephrine/metabolize_reagent(mob/living/carbon/affected_mob, seconds_per_tick, metabolized_volume)
	if(holder.has_reagent(/datum/reagent/toxin/lexorin))
		// REM is intentional here
		holder.remove_reagent(/datum/reagent/toxin/lexorin, 1 * REM * metabolized_volume * seconds_per_tick)
		holder.remove_reagent(/datum/reagent/medicine/epinephrine, 0.5 * REM * metabolized_volume * seconds_per_tick)
	return ..()

/datum/reagent/medicine/epinephrine/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(18, seconds_per_tick))
		var/need_mob_update
		need_mob_update = affected_mob.adjust_stamina_loss(5 * metabolization_ratio, updating_stamina = FALSE)
		need_mob_update += affected_mob.adjust_tox_loss(2 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype)
		affected_mob.losebreath++
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/medicine/strange_reagent
	name = "奇异试剂"
	description = "一种能起死回生的奇迹药物。通常外敷起效，但若解剖结构复杂则需口服。无法复活生命值低于 -%MAXHEALTHRATIO% 的目标。"
	color = "#A0E85E"
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	taste_description = "磁铁"
	ph = 0.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	/// The amount of damage a single unit of this will heal
	var/healing_per_reagent_unit = 5
	/// The ratio of the excess reagent used to contribute to excess healing
	var/excess_healing_ratio = 0.8
	/// Do we instantly revive
	var/instant = FALSE
	/// The maximum amount of damage we can revive from, as a ratio of max health
	var/max_revive_damage_ratio = 2

// To override for subtypes.
/datum/reagent/medicine/strange_reagent/proc/pre_rez_check(atom/thing_to_rez)
	return TRUE

/datum/reagent/medicine/strange_reagent/instant
	name = "更奇异试剂"
	instant = TRUE
	chemical_flags = NONE

/datum/reagent/medicine/strange_reagent/New()
	. = ..()
	description = replacetext(description, "%MAXHEALTHRATIO%", "[max_revive_damage_ratio * 100]%")
	if(instant)
		description += " 它似乎散发着温暖的粉色光芒。"

// FEED ME SEYMOUR
/datum/reagent/medicine/strange_reagent/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.spawnplant()

/// Calculates the amount of reagent to at a bare minimum make the target not dead
/datum/reagent/medicine/strange_reagent/proc/calculate_amount_needed_to_revive(mob/living/benefactor)
	var/their_health = benefactor.getMaxHealth() - (benefactor.get_brute_loss() + benefactor.get_fire_loss())
	if(their_health > 0)
		return 1

	return round(-their_health / healing_per_reagent_unit, DAMAGE_PRECISION)

/// Calculates the amount of reagent that will be needed to both revive and full heal the target. Looks at healing_per_reagent_unit and excess_healing_ratio
/datum/reagent/medicine/strange_reagent/proc/calculate_amount_needed_to_full_heal(mob/living/benefactor)
	var/their_health = benefactor.get_brute_loss() + benefactor.get_fire_loss()
	var/max_health = benefactor.getMaxHealth()
	if(their_health >= max_health)
		return 1

	var/amount_needed_to_revive = calculate_amount_needed_to_revive(benefactor)
	var/expected_amount_to_full_heal = round(max_health / healing_per_reagent_unit, DAMAGE_PRECISION) / excess_healing_ratio
	return amount_needed_to_revive + expected_amount_to_full_heal

/datum/reagent/medicine/strange_reagent/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	if(exposed_mob.stat != DEAD || !(exposed_mob.mob_biotypes & MOB_ORGANIC))
		return ..()

	if(HAS_TRAIT(exposed_mob, TRAIT_SUICIDED)) //they are never coming back
		exposed_mob.visible_message(span_warning("[exposed_mob] 的身体没有任何反应……"))
		return

	if(iscarbon(exposed_mob) && !(methods & (INGEST|INHALE))) //simplemobs can still be splashed
		return ..()

	if(HAS_TRAIT(exposed_mob, TRAIT_HUSK))
		exposed_mob.visible_message(span_warning("[exposed_mob] 的身体冒出一阵烟雾……"))
		return

	if((exposed_mob.get_brute_loss() + exposed_mob.get_fire_loss()) > (exposed_mob.getMaxHealth() * max_revive_damage_ratio))
		exposed_mob.visible_message(span_warning("[exposed_mob] 的身体剧烈抽搐，随后归于静止……"))
		return

	var/needed_to_revive = calculate_amount_needed_to_revive(exposed_mob)
	if(reac_volume < needed_to_revive)
		exposed_mob.visible_message(span_warning("[exposed_mob] 的身体微微抽搐，随后再次归于静止。"))
		exposed_mob.do_jitter_animation(10)
		return

	if(!pre_rez_check(exposed_mob))
		exposed_mob.visible_message(span_warning("[exposed_mob] 的身体轻轻抽动了一下。"))
		exposed_mob.do_jitter_animation(1)
		return

	exposed_mob.visible_message(span_warning("[exposed_mob] 的身体开始抽搐！"))
	exposed_mob.notify_revival("你的身体正被奇异试剂复活！")
	exposed_mob.do_jitter_animation(10)

	// we factor in healing needed when determing if we do anything
	var/healing = needed_to_revive * healing_per_reagent_unit
	// but excessive healing is penalized, to reward doctors who use the perfect amount
	reac_volume -= needed_to_revive
	healing += (reac_volume * healing_per_reagent_unit) * excess_healing_ratio

	// during unit tests, we want it to happen immediately
	if(instant)
		exposed_mob.do_strange_reagent_revival(healing)
	else
		// jitter immediately, after four seconds, and after eight seconds
		addtimer(CALLBACK(exposed_mob, TYPE_PROC_REF(/mob/living, do_jitter_animation), 1 SECONDS), 4 SECONDS)
		addtimer(CALLBACK(exposed_mob, TYPE_PROC_REF(/mob/living, do_strange_reagent_revival), healing), 7 SECONDS)
		addtimer(CALLBACK(exposed_mob, TYPE_PROC_REF(/mob/living, do_jitter_animation), 1 SECONDS), 8 SECONDS)

	return ..()

/datum/reagent/medicine/strange_reagent/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/damage_at_random = rand(0, 250)/100 //0 to 2.5
	var/need_mob_update
	need_mob_update = affected_mob.adjust_brute_loss(0.4 * damage_at_random * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(0.4 * damage_at_random * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/strange_reagent/fishy_reagent
	name = "鱼类试剂"
	description = "这种试剂的化学成分与奇异试剂极为相似，但它似乎只对……鱼类起作用。或者至少是对水生生物。"
	color = "#5ee8b3"
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	taste_description = "带磁性的鳞片"
	ph = 0.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// only revives fish.
/datum/reagent/medicine/strange_reagent/fishy_reagent/pre_rez_check(atom/thing_to_rez)
	if(ismob(thing_to_rez))
		var/mob/living/mob_to_rez = thing_to_rez
		if(mob_to_rez.mob_biotypes & MOB_AQUATIC)
			return TRUE
		return FALSE
	if(isfish(thing_to_rez))
		return TRUE
	return FALSE

/datum/reagent/medicine/mannitol
	name = "甘露醇"
	description = "高效恢复脑损伤。"
	taste_description = "怡人的甜味"
	color = "#A0A0A0" //mannitol is light grey, neurine is lighter grey
	ph = 10.4
	overdose_threshold = 15
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	purity = REAGENT_STANDARD_PURITY
	inverse_chem = /datum/reagent/inverse
	inverse_chem_val = 0.45
	metabolized_traits = list(TRAIT_TUMOR_SUPPRESSED) //Having mannitol in you will pause the brain damage from brain tumor (so it heals an even 2 brain damage instead of 1.8)

/datum/reagent/medicine/mannitol/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, -1 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), required_organ_flag = affected_organ_flags))
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/mannitol/overdose_start(mob/living/affected_mob, metabolization_ratio)
	. = ..()
	to_chat(affected_mob, span_notice("你突然感到<span class='purple'>茅塞顿开！</span>"))

/datum/reagent/medicine/mannitol/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(65, seconds_per_tick))
		return
	var/list/tips
	if(SPT_PROB(50, seconds_per_tick))
		tips = world.file2list("strings/tips.txt")
	if(SPT_PROB(50, seconds_per_tick))
		tips = world.file2list("strings/sillytips.txt")
	else
		tips = world.file2list("strings/chemistrytips.txt")
	var/message = pick(tips)
	send_tip_of_the_round(affected_mob, message, source = "化学诱导的智慧")

/datum/reagent/medicine/neurine
	name = "神经碱"
	description = "与神经组织发生反应，帮助重建受损的连接。可治愈轻微创伤。"
	color = COLOR_SILVER //ditto
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED | REAGENT_DEAD_PROCESS
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	purity = REAGENT_STANDARD_PURITY
	inverse_chem_val = 0.5
	inverse_chem = /datum/reagent/inverse/neurine
	added_traits = list(TRAIT_ANTICONVULSANT)
	self_consuming = TRUE
	///brain damage level when we first started taking the chem
	var/initial_bdamage = 200

/datum/reagent/medicine/neurine/on_mob_add(mob/living/affected_mob, amount)
	. = ..()
	if(!iscarbon(affected_mob))
		return
	var/mob/living/carbon/affected_carbon = affected_mob
	if(creation_purity >= 1)
		initial_bdamage = affected_carbon.get_organ_loss(ORGAN_SLOT_BRAIN)

/datum/reagent/medicine/neurine/on_mob_delete(mob/living/affected_mob)
	. = ..()
	if(!iscarbon(affected_mob))
		return
	var/mob/living/carbon/affected_carbon = affected_mob
	if(initial_bdamage < affected_carbon.get_organ_loss(ORGAN_SLOT_BRAIN))
		affected_carbon.set_organ_loss(ORGAN_SLOT_BRAIN, initial_bdamage)

/datum/reagent/medicine/neurine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(holder.has_reagent(/datum/reagent/consumable/ethanol/neurotoxin))
		holder.remove_reagent(/datum/reagent/consumable/ethanol/neurotoxin, 2.5 * metabolization_ratio * seconds_per_tick * normalise_creation_purity())
	if(SPT_PROB(8 * normalise_creation_purity(), seconds_per_tick))
		affected_mob.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)

/datum/reagent/medicine/neurine/on_mob_dead(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, -0.5 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), required_organ_flag = affected_organ_flags))
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/mutadone
	name = "去突变药"
	description = "消除颤抖并修复基因缺陷。"
	color = "#5096C8"
	taste_description = "酸味"
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/mutadone/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if (!ishuman(affected_mob))
		return
	var/mob/living/carbon/human/human_mob = affected_mob
	if (ismonkey(human_mob))
		if (!HAS_TRAIT(human_mob, TRAIT_BORN_MONKEY))
			//This is the only time mutadone should remove monkeyism
			human_mob.dna.remove_mutation(/datum/mutation/race, GLOB.standard_mutation_sources)
	else if (HAS_TRAIT(human_mob, TRAIT_BORN_MONKEY))
		human_mob.monkeyize()


/datum/reagent/medicine/mutadone/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.remove_status_effect(/datum/status_effect/jitter)
	if(affected_mob.has_dna())
		var/list/mutations = affected_mob.dna.mutations
		if(LAZYLEN(mutations)) // Don't need to be doing this at all if there are no mutations
			affected_mob.dna.remove_mutation_group(mutations - affected_mob.dna.get_mutation(/datum/mutation/race), GLOB.standard_mutation_sources)
		affected_mob.dna.scrambled = FALSE

/datum/reagent/medicine/antihol
	name = "解酒素"
	description = "清除患者体内的酒精物质并消除其副作用。"
	color = "#00B4C8"
	taste_description = "生鸡蛋"
	ph = 4
	purity = REAGENT_STANDARD_PURITY
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.35
	inverse_chem = /datum/reagent/inverse/antihol
	/// All status effects we remove on metabolize.
	/// Does not include drunk (despite what you may thing) as that's decresed gradually
	var/static/list/status_effects_to_clear = list(
		/datum/status_effect/confusion,
		/datum/status_effect/dizziness,
		/datum/status_effect/drowsiness,
		/datum/status_effect/speech/slurring/drunk,
	)

/datum/reagent/medicine/antihol/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	for(var/effect in status_effects_to_clear)
		affected_mob.remove_status_effect(effect)
	affected_mob.reagents.remove_reagent(/datum/reagent/consumable/ethanol, 4 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), include_subtypes = TRUE)
	if(affected_mob.adjust_tox_loss(-0.1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		. = UPDATE_MOB_HEALTH
	affected_mob.adjust_drunk_effect(-5 * metabolization_ratio * seconds_per_tick * normalise_creation_purity())

/datum/reagent/medicine/antihol/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (TOUCH|VAPOR|PATCH)))
		return

	exposed_mob.add_surgery_speed_mod(type, 1.1, min(reac_volume * 1 MINUTES, 5 MINUTES))

/datum/reagent/medicine/stimulants
	name = "兴奋剂"
	description = "提高对警棍的抗性和移动速度，同时恢复轻微伤害与虚弱状态。过量使用会导致虚弱和毒素伤害。"
	color = "#78008C"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 60
	ph = 8.7
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	addiction_types = list(/datum/addiction/stimulants = 150)
	metabolized_traits = list(TRAIT_BATON_RESISTANCE, TRAIT_ANALGESIA, TRAIT_STIMULATED)

/datum/reagent/medicine/stimulants/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)

/datum/reagent/medicine/stimulants/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)

/datum/reagent/medicine/stimulants/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(affected_mob.health < 50 && affected_mob.health > 0)
		var/heal = -1 * metabolization_ratio * seconds_per_tick
		need_mob_update += affected_mob.adjust_oxy_loss(heal, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_tox_loss(heal, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_brute_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_fire_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)

	affected_mob.AdjustAllImmobility(-60  * metabolization_ratio * seconds_per_tick)
	need_mob_update += affected_mob.adjust_stamina_loss(-12 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/stimulants/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(18, seconds_per_tick))
		affected_mob.adjust_stamina_loss(2.5 * metabolization_ratio, updating_stamina = FALSE, required_biotype = affected_biotype)
		affected_mob.adjust_tox_loss(1 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype)
		affected_mob.losebreath++
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/insulin
	name = "胰岛素"
	description = "提高糖分消耗速率。"
	color = "#FFFFF0"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	ph = 6.7
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/insulin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	holder.remove_reagent(/datum/reagent/consumable/sugar, 3 * metabolization_ratio * seconds_per_tick)

//Trek Chems, used primarily by medibots. Only heals a specific damage type, but is very efficient.

/datum/reagent/medicine/inaprovaline //is this used anywhere?
	name = "伊纳普罗林"
	description = "稳定患者的呼吸。对危急状态的患者很有用。"
	color = "#A4D8D8"
	ph = 8.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/inaprovaline/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.losebreath >= 5)
		affected_mob.losebreath -= 2.5 * metabolization_ratio * seconds_per_tick
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/regen_jelly
	name = "再生凝胶"
	description = "逐渐再生所有类型的伤害，且不会伤害史莱姆的解剖结构。"
	color = "#CC23FF"
	taste_description = "凝胶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	affected_biotype = MOB_ORGANIC | MOB_MINERAL | MOB_PLANT // no healing ghosts

/datum/reagent/medicine/regen_jelly/expose_mob(mob/living/exposed_mob, reac_volume)
	. = ..()
	if(!ishuman(exposed_mob) || (reac_volume < 0.5))
		return

	var/mob/living/carbon/human/exposed_human = exposed_mob
	exposed_human.set_facial_haircolor(color, update = FALSE)
	exposed_human.set_haircolor(color, update = TRUE)

/datum/reagent/medicine/regen_jelly/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/heal = -0.75 * metabolization_ratio * seconds_per_tick
	var/need_mob_update
	need_mob_update = affected_mob.adjust_brute_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(heal, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_oxy_loss(heal, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_tox_loss(heal, updating_health = FALSE, forced = TRUE, required_biotype = affected_biotype) //heals TOXINLOVERs
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/syndicate_nanites //Used exclusively by Syndicate medical cyborgs
	name = "修复纳米机器人"
	description = "微型医疗机器人，能迅速修复身体损伤。"
	color = "#555555"
	overdose_threshold = 30
	ph = 11
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/syndicate_nanites/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	need_mob_update = affected_mob.adjust_brute_loss(-2.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE) //A ton of healing - this is a 50 telecrystal investment.
	need_mob_update += affected_mob.adjust_fire_loss(-2.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
	need_mob_update += affected_mob.adjust_oxy_loss(-7.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
	need_mob_update += affected_mob.adjust_tox_loss(-2.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, forced = TRUE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, -7.5 * metabolization_ratio * seconds_per_tick)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/syndicate_nanites/overdose_process(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio) //wtb flavortext messages that hint that you're vomitting up robots
	. = ..()
	if(SPT_PROB(13, seconds_per_tick))
		affected_mob.reagents.remove_reagent(type, 5 * metabolization_rate) // ~5 units at a rate of 0.4 but i wanted a nice number in code
		affected_mob.vomit(vomit_flags = VOMIT_CATEGORY_DEFAULT, vomit_type = /obj/effect/decal/cleanable/vomit/nanites, lost_nutrition = 20) // nanite safety protocols make your body expel them to prevent harmies

/datum/reagent/medicine/earthsblood //Created by ambrosia gaia plants
	name = "大地之血"
	description = "源自一种极其强大的植物。对恢复伤势极有效，但对大脑负担略重。出于某种奇怪的原因，饮用它的人会暂时变得和平主义，而过量饮用者则会陷入半永久性的和平主义。"
	color = "#FFAF00"
	overdose_threshold = 25
	ph = 11
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	addiction_types = list(/datum/addiction/hallucinogens = 90)
	metabolized_traits = list(TRAIT_PACIFISM)

/datum/reagent/medicine/earthsblood/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(current_cycle < 25) //10u has to be processed before u get into THE FUN ZONE
		need_mob_update = affected_mob.adjust_brute_loss(-0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_fire_loss(-0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_oxy_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_tox_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_stamina_loss(-1 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.5 * metabolization_ratio * seconds_per_tick, 150, affected_organ_flags) //This does, after all, come from ambrosia, and the most powerful ambrosia in existence, at that!
	else
		need_mob_update = affected_mob.adjust_brute_loss(-2.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype) //slow to start, but very quick healing once it gets going
		need_mob_update += affected_mob.adjust_fire_loss(-2.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_oxy_loss(-1.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_tox_loss(-1.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_stamina_loss(-4 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1 * metabolization_ratio * seconds_per_tick, 150, affected_organ_flags)
		affected_mob.adjust_jitter_up_to(3 SECONDS * metabolization_ratio * seconds_per_tick, 1 MINUTES)
		if(SPT_PROB(5, seconds_per_tick))
			affected_mob.say(return_hippie_line(), forced = /datum/reagent/medicine/earthsblood)
	affected_mob.adjust_drugginess_up_to(10 SECONDS * metabolization_ratio * seconds_per_tick, 15 SECONDS * metabolization_ratio * seconds_per_tick)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/earthsblood/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_hallucinations_up_to(5 SECONDS * metabolization_ratio * seconds_per_tick, 120 SECONDS)
	var/need_mob_update
	if(current_cycle > 26)
		need_mob_update = affected_mob.adjust_tox_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		if(current_cycle > 101) //podpeople get out reeeeeeeeeeeeeeeeeeeee
			need_mob_update += affected_mob.adjust_tox_loss(3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	if(iscarbon(affected_mob))
		var/mob/living/carbon/hippie = affected_mob
		hippie.gain_trauma(/datum/brain_trauma/severe/pacifism)

	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/// Returns a hippie-esque string for the person affected by the reagent to say.
/datum/reagent/medicine/earthsblood/proc/return_hippie_line()
	var/static/list/earthsblood_lines = list(
		"我真高兴他被冻在里面而我们在这外面，而且他是治安官，而我们被冻在这外面，而且我们在那里面，我刚想起来，我们在这外面。我想知道的是：那个穴居人去哪了？",
		"你相信年轻女孩心中的魔法吗？",
		"那不是我，那不是我……",
		"要做爱，不要战争！",
		"停下，嘿，那是什么声音？大家快看看发生了什么……",
		"是啊，呃，你知道，那只是，呃，你的看法，老兄。",
	)

	return pick(earthsblood_lines)

/datum/reagent/medicine/haloperidol
	name = "氟哌啶醇"
	description = "提高大多数兴奋/致幻药物的消耗速率。减轻药物效应与颤抖。严重的耐力恢复惩罚，会引起困倦。有小概率造成脑损伤。"
	color = "#27870a"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	ph = 4.3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/haloperidol/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	for(var/datum/reagent/drug/reagent in affected_mob.reagents.reagent_list)
		affected_mob.reagents.remove_reagent(reagent.type, 2.5 * reagent.purge_multiplier * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(5 SECONDS * metabolization_ratio * seconds_per_tick)

	if(affected_mob.get_timed_status_effect_duration(/datum/status_effect/jitter) >= 6 SECONDS)
		affected_mob.adjust_jitter(-7.5 SECONDS * metabolization_ratio * seconds_per_tick)

	if (affected_mob.get_timed_status_effect_duration(/datum/status_effect/hallucination) >= 10 SECONDS)
		affected_mob.adjust_hallucinations(-12.5 SECONDS * metabolization_ratio * seconds_per_tick)

	if(affected_mob.get_stamina_loss() >= 100)
		affected_mob.reagents.remove_reagent(type, 1.25 * metabolization_rate * metabolization_ratio * seconds_per_tick)

	var/need_mob_update = FALSE
	if(SPT_PROB(10, seconds_per_tick))
		need_mob_update += affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1, 50, affected_organ_flags)
	need_mob_update += affected_mob.adjust_stamina_loss(3.125 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

//used for changeling's adrenaline power
/datum/reagent/medicine/changelingadrenaline
	name = "变形怪肾上腺素"
	description = "缩短失去意识、倒地与眩晕的持续时间。恢复耐力，但过量使用会造成毒素伤害。"
	color = "#C1151D"
	overdose_threshold = 30
	chemical_flags = REAGENT_NO_RANDOM_RECIPE

/datum/reagent/medicine/changelingadrenaline/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, metabolization_ratio)
	. = ..()
	metabolizer.AdjustAllImmobility(-10 * metabolization_ratio * seconds_per_tick)
	if(metabolizer.adjust_stamina_loss(-15 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE))
		. = UPDATE_MOB_HEALTH
	metabolizer.set_jitter_if_lower(10 SECONDS * metabolization_ratio * seconds_per_tick)
	metabolizer.set_dizzy_if_lower(10 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/medicine/changelingadrenaline/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_traits(list(TRAIT_SLEEPIMMUNE, TRAIT_BATON_RESISTANCE), type)
	affected_mob.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	RegisterSignal(affected_mob, COMSIG_LIVING_ENTER_STAMCRIT, PROC_REF(on_stamcrit))

/datum/reagent/medicine/changelingadrenaline/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_traits(list(TRAIT_SLEEPIMMUNE, TRAIT_BATON_RESISTANCE), type)
	affected_mob.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	affected_mob.remove_status_effect(/datum/status_effect/dizziness)
	affected_mob.remove_status_effect(/datum/status_effect/jitter)
	UnregisterSignal(affected_mob, COMSIG_LIVING_ENTER_STAMCRIT)

/datum/reagent/medicine/changelingadrenaline/proc/on_stamcrit(mob/living/affected_mob)
	SIGNAL_HANDLER
	affected_mob?.set_stamina_loss(90, updating_stamina = TRUE)
	to_chat(affected_mob, span_changeling("我们的基因刺激剂爆发了！我们精力充沛，但药效正在消退。"))
	volume -= (min(volume, 1))
	return STAMCRIT_CANCELLED

/datum/reagent/medicine/changelingadrenaline/overdose_process(mob/living/metabolizer, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(metabolizer.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/changelinghaste
	name = "变形怪急速"
	description = "大幅提升移动速度，但会造成毒素伤害。"
	color = "#AE151D"
	metabolization_rate = 2.5 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/changelinghaste/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/changelinghaste)

/datum/reagent/medicine/changelinghaste/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/changelinghaste)

/datum/reagent/medicine/changelinghaste/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(metabolizer.adjust_tox_loss(4 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/higadrite
	name = "肝保素"
	description = "一种用于治疗病弱肝脏的药物。"
	color = "#FF3542"
	self_consuming = TRUE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STABLELIVER)

/datum/reagent/medicine/cordiolis_hepatico
	name = "心肝灵"
	description = "一种奇特的、漆黑如墨的试剂，似乎会吸收所有光线。效果未知。"
	color = COLOR_BLACK
	self_consuming = TRUE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/cordiolis_hepatico/on_mob_add(mob/living/affected_mob)
	. = ..()
	affected_mob.add_traits(list(TRAIT_STABLELIVER, TRAIT_STABLEHEART), type)

/datum/reagent/medicine/cordiolis_hepatico/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_traits(list(TRAIT_STABLELIVER, TRAIT_STABLEHEART), type)

/datum/reagent/medicine/muscle_stimulant
	name = "肌肉兴奋剂"
	description = "一种强效化学物质，能让受其影响的人在承受剧痛时仍保持全部体能。"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_ANALGESIA)

/datum/reagent/medicine/muscle_stimulant/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/muscle_stimulant/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/modafinil
	name = "莫达非尼"
	description = "长效睡眠抑制剂，能极轻微地缩短眩晕和倒地时间。过量使用有可怕的副作用，会造成致命的缺氧伤害，若不处理会让你失去意识。"
	color = "#BEF7D8" // palish blue white
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 20 // with the random effects this might be awesome or might kill you at less than 10u (extensively tested)
	taste_description = "盐" // it actually does taste salty
	ph = 7.89
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SLEEPIMMUNE)
	/// To track overdose progress
	var/overdose_progress = 0

/datum/reagent/medicine/modafinil/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(overdosed) // We do not want any effects on OD
		return
	overdose_threshold = overdose_threshold + 5 * ((rand(-10, 10) / 10) * metabolization_ratio * seconds_per_tick) // for extra fun
	metabolizer.AdjustAllImmobility(-25 * metabolization_ratio * seconds_per_tick)
	metabolizer.adjust_stamina_loss(-15 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
	metabolizer.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)
	metabolization_rate = 0.005 * REAGENTS_METABOLISM * rand(5, 20) // randomizes metabolism between 0.02 and 0.08 per second
	return UPDATE_MOB_HEALTH

/datum/reagent/medicine/modafinil/overdose_start(mob/living/affected_mob, metabolization_ratio)
	. = ..()
	to_chat(affected_mob, span_userdanger("你感到极度气喘吁吁、浑身发抖！"))
	metabolization_rate = 0.025 * REAGENTS_METABOLISM // sets metabolism to 0.005 per second on overdose

/datum/reagent/medicine/modafinil/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	overdose_progress++
	var/need_mob_update
	switch(overdose_progress)
		if(1 to 40)
			affected_mob.adjust_jitter_up_to(40 SECONDS * metabolization_ratio * seconds_per_tick, 20 SECONDS)
			affected_mob.adjust_stutter_up_to(40 SECONDS * metabolization_ratio * seconds_per_tick, 20 SECONDS)
			affected_mob.set_dizzy_if_lower(200 SECONDS * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(30, seconds_per_tick))
				affected_mob.losebreath++
				need_mob_update = TRUE
		if(41 to 80)
			need_mob_update = affected_mob.adjust_oxy_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
			need_mob_update += affected_mob.adjust_stamina_loss(2 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
			affected_mob.adjust_jitter_up_to(40 SECONDS * metabolization_ratio * seconds_per_tick, 40 SECONDS)
			affected_mob.adjust_stutter_up_to(40 SECONDS * metabolization_ratio * seconds_per_tick, 40 SECONDS)
			affected_mob.set_dizzy_if_lower(400 SECONDS * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(30, seconds_per_tick))
				affected_mob.losebreath++
				need_mob_update = TRUE
			if(SPT_PROB(10, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("你突然发作起来！"))
				affected_mob.emote("moan")
				affected_mob.Paralyze(20) // you should be in a bad spot at this point unless epipen has been used
		if(81)
			to_chat(affected_mob, span_userdanger("你感到精疲力竭，再也撑不下去了！")) // at this point you will eventually die unless you get charcoal
			need_mob_update = affected_mob.adjust_oxy_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
			need_mob_update += affected_mob.adjust_stamina_loss(2 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(82 to INFINITY)
			REMOVE_TRAIT(affected_mob, TRAIT_SLEEPIMMUNE, type)
			affected_mob.Sleeping(200 SECONDS * metabolization_ratio * seconds_per_tick)
			need_mob_update += affected_mob.adjust_oxy_loss(30 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
			need_mob_update += affected_mob.adjust_stamina_loss(30 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/psicodine
	name = "心定宁"
	description = "抑制焦虑及其他形式的精神痛苦。过量使用会引起幻觉和轻微毒素伤害。"
	color = "#07E79E"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30
	ph = 9.12
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_FEARLESS)

/datum/reagent/medicine/psicodine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_jitter(-24 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_dizzy(-24 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_confusion(-12 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.disgust = max(affected_mob.disgust - (12 * metabolization_ratio * seconds_per_tick), 0)
	if(affected_mob.mob_mood != null && affected_mob.mob_mood.sanity <= SANITY_NEUTRAL) // only take effect if in negative sanity and then...
		affected_mob.mob_mood.adjust_sanity(10 * metabolization_ratio * seconds_per_tick, maximum = SANITY_NEUTRAL) // set minimum to prevent unwanted spiking over neutral

/datum/reagent/medicine/psicodine/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_hallucinations_up_to(20 SECONDS * metabolization_ratio * seconds_per_tick, 120 SECONDS)
	if(affected_mob.adjust_tox_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/metafactor
	name = "促分裂代谢因子"
	description = "这种酶催化将营养食物转化为治疗性肽的过程。"
	metabolization_rate = 0.0625  * REAGENTS_METABOLISM //slow metabolism rate so the patient can self heal with food even after the troph has metabolized away for amazing reagent efficency.
	color = "#FFBE00"
	overdose_threshold = 10
	inverse_chem_val = 0.1 //Shouldn't happen - but this is so looking up the chem will point to the failed type
	inverse_chem = /datum/reagent/impurity/probital_failed
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/metafactor/overdose_start(mob/living/carbon/affected_mob, metabolization_ratio)
	. = ..()
	metabolization_rate = 2 * REAGENTS_METABOLISM

/datum/reagent/medicine/metafactor/overdose_process(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(13, seconds_per_tick))
		affected_mob.vomit(VOMIT_CATEGORY_KNOCKDOWN)

/datum/reagent/medicine/silibinin
	name = "水飞蓟宾"
	description = "一种从蓟草中提取的保肝黄酮木脂素混合物，有助于逆转肝脏损伤。"
	color = "#FFFFD0"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/silibinin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_LIVER, -0.67 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)) // Add a chance to cure liver trauma once implemented.
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/polypyr  //This is intended to be an ingredient in advanced chems.
	name = "聚吡喃鎓低聚物"
	description = "一种由短聚电解质链组成的紫色混合物，在实验室中不易合成。作为合成前沿药物的中间体而备受重视。"
	color = "#9423FF"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 50
	taste_description = "令人麻木的苦味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/polypyr/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio) //I wanted a collection of small positive effects, this is as hard to obtain as coniine after all.
	. = ..()
	var/need_mob_update
	need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_LUNGS, -0.5 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)
	need_mob_update += affected_mob.adjust_brute_loss(-0.7 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/polypyr/expose_mob(mob/living/carbon/human/exposed_human, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (TOUCH|VAPOR)) || !ishuman(exposed_human) || (reac_volume < 0.5))
		return
	exposed_human.set_facial_haircolor("#9922ff", update = FALSE)
	exposed_human.set_haircolor(color) //this will call update_body_parts()

/datum/reagent/medicine/polypyr/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_LUNGS, 1 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags))
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/granibitaluri
	name = "格拉尼比妥" //achieve "GRANular" amounts of C2
	description = "一种温和的止痛药，可用作更强效药物的添加剂。能加速小伤口和烧伤的愈合，但对严重损伤无效。极大剂量具有毒性，最终可能导致肝衰竭。"
	color = "#E0E0E0"
	overdose_threshold = 50
	metabolization_rate = 0.5 * REAGENTS_METABOLISM //same as C2s
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_ANALGESIA)

/datum/reagent/medicine/granibitaluri/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/healamount = max(1.5 - round(0.01 * (affected_mob.get_brute_loss() + affected_mob.get_fire_loss()), 0.2), 0.5) //base of 1.5 healing per cycle and loses 0.2 healing for every 10 combined brute/burn damage you have
	var/need_mob_update
	need_mob_update = affected_mob.adjust_brute_loss(-1 * healamount * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(-1 * healamount * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/granibitaluri/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_LIVER, 0.2 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)
	need_mob_update += affected_mob.adjust_tox_loss(0.2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype) //Only really deadly if you eat over 100u
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

// helps bleeding wounds clot faster
/datum/reagent/medicine/coagulant
	name = "凝血石"
	description = "一种专有凝血剂，能帮助出血的伤口更快结痂。会被肝素清除。"
	color = "#bb2424"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 20
	/// The bloodiest wound that the patient has will have its blood_flow reduced by about half this much each second
	var/clot_rate = 0.3
	/// While this reagent is in our bloodstream, we reduce all bleeding by this factor
	var/passive_bleed_modifier = 0.7
	/// For tracking when we tell the person we're no longer bleeding
	var/was_working
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_COAGULATING)

/datum/reagent/medicine/coagulant/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if(ishuman(affected_mob))
		var/mob/living/carbon/human/blood_boy = affected_mob
		blood_boy.physiology?.bleed_mod *= passive_bleed_modifier

/datum/reagent/medicine/coagulant/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	if(was_working)
		to_chat(affected_mob, span_warning("使你的血液变稠的药物失效了！"))
	if(ishuman(affected_mob))
		var/mob/living/carbon/human/blood_boy = affected_mob
		blood_boy.physiology?.bleed_mod /= passive_bleed_modifier

/datum/reagent/medicine/coagulant/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.coagulant_effect(METABOLIZE_FREE_CONSTANT(0.5) * clot_rate * metabolization_ratio * seconds_per_tick))
		if(!was_working)
			to_chat(affected_mob, span_green("你能感觉到流动的血液开始变稠！"))
			was_working = TRUE

	else if(was_working)
		was_working = FALSE

/datum/reagent/medicine/coagulant/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!CAN_HAVE_BLOOD(affected_mob))
		return

	// SKYRAT EDIT CHANGE BEGIN -- Adds check for owner_flags
	var/owner_flags
	if (iscarbon(affected_mob))
		var/mob/living/carbon/carbon_mob = affected_mob
		owner_flags = carbon_mob.dna.species.reagent_flags
	if (!isnull(owner_flags) && !(owner_flags & PROCESS_ORGANIC))
		return
	// SKYRAT EDIT CHANGE END
	if(SPT_PROB(7.5, seconds_per_tick))
		affected_mob.losebreath += rand(2, 4)
		affected_mob.adjust_oxy_loss(METABOLIZE_FREE_CONSTANT(1) * rand(1, 3) * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype)
		if(prob(30))
			to_chat(affected_mob, span_danger("你能感觉到血液在血管里凝结成块！"))
		else if(prob(10))
			to_chat(affected_mob, span_userdanger("你感觉血液已经停止流动了！"))
			affected_mob.adjust_oxy_loss(METABOLIZE_FREE_CONSTANT(0.5) * rand(3, 4) * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype)

		if(prob(50))
			var/obj/item/organ/lungs/our_lungs = affected_mob.get_organ_slot(ORGAN_SLOT_LUNGS)
			our_lungs.apply_organ_damage(METABOLIZE_FREE_CONSTANT(0.5) * metabolization_ratio)
		else
			var/obj/item/organ/heart/our_heart = affected_mob.get_organ_slot(ORGAN_SLOT_HEART)
			our_heart.apply_organ_damage(METABOLIZE_FREE_CONSTANT(0.5) * metabolization_ratio)

		return UPDATE_MOB_HEALTH

// i googled "natural coagulant" and a couple of results came up for banana peels, so after precisely 30 more seconds of research, i now dub grinding banana peels good for your blood
/datum/reagent/medicine/coagulant/banana_peel
	name = "香蕉皮糊"
	description = "古老的“小丑传说”说，捣烂的香蕉皮对你的血液有好处，但你真的要听一个小丑关于香蕉的医疗建议吗？"
	color = "#50531a" // rgb: 175, 175, 0
	taste_description = "极其多丝、苦涩的果肉"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	clot_rate = 0.2
	passive_bleed_modifier = 0.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/glass_style/drinking_glass/banana_peel
	required_drink_type = /datum/reagent/medicine/coagulant/banana_peel
	name = "一杯香蕉皮糊"
	desc = "古老的“小丑传说”说，捣烂的香蕉皮对你的血液有好处，\
		但你真的要听一个小丑关于香蕉的医疗建议吗？"

/datum/reagent/medicine/coagulant/seraka_extract
	name = "塞拉卡提取物"
	description = "一种存在于塞拉卡蘑菇中、含量稀少的深色油脂。可作为有效的血液凝结剂，但过量阈值很低。"
	color = "#00767C"
	taste_description = "极为浓郁的咸鲜苦味"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	clot_rate = 0.4 //slightly better than regular coagulant
	passive_bleed_modifier = 0.5
	overdose_threshold = 10 //but easier to overdose on

/datum/glass_style/drinking_glass/seraka_extract
	required_drink_type = /datum/reagent/medicine/coagulant/seraka_extract
	name = "一杯塞拉卡提取物"
	desc = "味道浓郁鲜美、略带苦涩，还会让你的血液在血管里凝结。总的来说是杯好饮料。"

/datum/reagent/medicine/ondansetron
	name = "昂丹司琼"
	description = "防止恶心和呕吐。可能引起困倦和疲惫。"
	color = "#74d3ff"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	ph = 10.6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/ondansetron/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(8, seconds_per_tick))
		affected_mob.adjust_drowsiness(2 SECONDS * metabolization_ratio)
	if(SPT_PROB(15, seconds_per_tick) && !affected_mob.get_stamina_loss())
		if(affected_mob.adjust_stamina_loss(10 * metabolization_ratio, updating_stamina = FALSE))
			. = UPDATE_MOB_HEALTH
	affected_mob.adjust_disgust(-10 * metabolization_ratio * seconds_per_tick)

/datum/reagent/medicine/naloxone
	name = "纳洛酮"
	description = "阿片类拮抗剂，能清除患者的困倦与麻醉剂，恢复呼吸损失并加速成瘾恢复。"
	color = "#f5f5dc"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	ph = 4
	penetrates_skin = TOUCH|VAPOR
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_ADDICTIONRESILIENT)
	var/static/list/opiates_to_clear = list(
		/datum/reagent/medicine/morphine,
		/datum/reagent/impedrezene,
		/datum/reagent/toxin/fentanyl,
		/datum/reagent/drug/krokodil,
		/datum/reagent/inverse/krokodil,
	)

/datum/reagent/medicine/naloxone/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	for(var/opiate in opiates_to_clear)
		holder.remove_reagent(opiate, 3 * metabolization_ratio * seconds_per_tick)

	if(affected_mob.mob_mood?.get_mood_event("numb"))
		affected_mob.clear_mood_event("numb")
		affected_mob.add_mood_event("not numb", /datum/mood_event/antinarcotic_medium)

	if(affected_mob.mob_mood?.get_mood_event("smacked out"))
		affected_mob.clear_mood_event("smacked out")
		affected_mob.add_mood_event("not smacked out", /datum/mood_event/antinarcotic_heavy)

	affected_mob.adjust_drowsiness(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	if(affected_mob.losebreath >= 1)
		affected_mob.losebreath -= 1 * metabolization_ratio * seconds_per_tick
		return UPDATE_MOB_HEALTH
