/**Spontaneous Combustion
 * No effect to stealth.
 * No effect to resistance.
 * Decreases stage speed slightly.
 * Decreases transmittability greatly.
 * Fatal level
 * Bonus: Ignites infected mob.
 */

/datum/symptom/fire
	name = "自燃"
	desc = "病毒将脂肪转化为极易燃的化合物，并提高体温，使宿主突然自燃。"
	illness = "自燃症"
	stealth = 0
	resistance = 0
	stage_speed = -1
	transmittable = -2
	level = 6
	severity = 5
	base_message_chance = 20
	symptom_delay = 47.5
	symptom_cure = /datum/reagent/medicine/leporazine // See, this one's tricky. You gotta convince them you don't have fever or chills in the same virus.
	var/infective = FALSE
	threshold_descs = list(
		"阶段速度 4" = "增强火焰强度。",
		"阶段速度 8" = "进一步增强火焰强度。",
		"传染性 8" = "宿主起火时会通过皮屑传播病毒。",
		"隐蔽性 4" = "症状在发作前不会显露。",
	)

/datum/symptom/fire/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStageSpeed() >= 4)
		power = 1.5
	if(A.totalStageSpeed() >= 8)
		power = 2
	if(A.totalStealth() >= 4)
		suppress_warning = TRUE
	if(A.totalTransmittable() >= 8) //burning skin spreads the virus through smoke
		infective = TRUE

/datum/symptom/fire/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/living_mob = A.affected_mob
	switch(A.stage)
		if(1 to 2)
			return
		if(3)
			if(prob(base_message_chance) && !suppress_warning)
				warn_mob(living_mob)
		else
			var/advanced_stage = A.stage > 4
			living_mob.adjust_fire_stacks((advanced_stage ? 3 : 1) * power)
			living_mob.take_overall_damage(burn = ((advanced_stage ? 5 : 3) * power), required_bodytype = BODYTYPE_ORGANIC)
			living_mob.ignite_mob(silent = TRUE)
			if(living_mob.on_fire) //check to make sure they actually caught on fire, or if it was prevented cause they were wet.
				living_mob.visible_message(span_warning("[living_mob]着火了！"), ignored_mobs = living_mob)
				to_chat(living_mob, span_userdanger((advanced_stage ? "你的皮肤燃起熊熊烈焰！" : "你的皮肤突然起火了！")))
				living_mob.emote("scream")
			else if(!suppress_warning)
				warn_mob(living_mob)

			if(infective)
				A.airborne_spread(advanced_stage ? 4 : 2)

/datum/symptom/fire/proc/warn_mob(mob/living/living_mob)
	if(prob(33.33))
		living_mob.show_message(span_hear("你听到噼啪声。"), type = MSG_AUDIBLE)
	else
		if(HAS_TRAIT(living_mob, TRAIT_ANOSMIA)) //Anosmia quirk holder can't smell anything.
			to_chat(living_mob, span_warning("你感到很热。"))
		else
			to_chat(living_mob, span_warning("[pick("你感到很热。", "你闻到了烟味。")]"))

/*
Alkali perspiration
	Hidden.
	Lowers resistance.
	Decreases stage speed.
	Decreases transmissibility.
	Fatal Level.
Bonus
	Ignites infected mob.
	Explodes mob on contact with water.
*/

/datum/symptom/alkali

	name = "碱性汗液"
	desc = "病毒附着在汗腺上，合成一种遇水即燃的化学物质，导致自焚。"
	illness = "脆皮症"
	stealth = 2
	resistance = -2
	stage_speed = -2
	transmittable = -2
	level = 7
	severity = 6
	base_message_chance = 100
	symptom_delay = 60
	symptom_cure = /datum/reagent/consumable/frostoil
	cure_color = "red"
	var/chems = FALSE
	var/explosion_power = 1
	threshold_descs = list(
		"抗性 9" = "自燃强度翻倍，但降低此症状所有效果的触发频率。",
		"阶段速度 8" = "宿主潮湿时，增加爆炸半径和对宿主造成的爆炸伤害。",
		"传染性 8" = "额外在宿主体内合成三氟化氯和凝固汽油。若达到抗性 9 阈值，合成量将增加。"
	)

/datum/symptom/alkali/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalResistance() >= 9) //intense but sporadic effect
		power = 2
		symptom_delay = 95
	if(A.totalStageSpeed() >= 8) //serious boom when wet
		explosion_power = 2
	if(A.totalTransmittable() >= 8) //extra chemicals
		chems = TRUE

/datum/symptom/alkali/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(3)
			if(prob(base_message_chance))
				to_chat(M, span_warning("[pick("你的血管在沸腾。", "你感到很热。", "你闻到了烤肉味。")]"))
		if(4)
			if(M.fire_stacks < 0)
				M.visible_message(span_warning("[M]的汗液一遇水就嘶嘶作响，噼啪迸溅！"))
				explosion(M, devastation_range = -1, heavy_impact_range = (-1 + explosion_power), light_impact_range = (2 * explosion_power), explosion_cause = src)
			Alkali_fire_stage_4(M, A)
			M.ignite_mob()
			to_chat(M, span_userdanger("你的汗液突然燃烧起来！"))
			M.emote("scream")
		if(5)
			if(M.fire_stacks < 0)
				M.visible_message(span_warning("[M]的汗液一遇水就嘶嘶作响，噼啪迸溅！"))
				explosion(M, devastation_range = -1, heavy_impact_range = (-1 + explosion_power), light_impact_range = (2 * explosion_power), explosion_cause = src)
			Alkali_fire_stage_5(M, A)
			M.ignite_mob()
			to_chat(M, span_userdanger("你的皮肤燃起熊熊烈焰！"))
			M.emote("scream")

/datum/symptom/alkali/proc/Alkali_fire_stage_4(mob/living/M, datum/disease/advance/A)
	var/get_stacks = 6 * power
	M.adjust_fire_stacks(get_stacks)
	M.take_overall_damage(burn = get_stacks / 2, required_bodytype = BODYTYPE_ORGANIC)
	if(chems)
		M.reagents.add_reagent(/datum/reagent/clf3, 2 * power)
	return 1

/datum/symptom/alkali/proc/Alkali_fire_stage_5(mob/living/M, datum/disease/advance/A)
	var/get_stacks = 8 * power
	M.adjust_fire_stacks(get_stacks)
	M.take_overall_damage(burn = get_stacks, required_bodytype = BODYTYPE_ORGANIC)
	if(chems)
		M.reagents.add_reagent_list(list(/datum/reagent/napalm = 4 * power, /datum/reagent/clf3 = 4 * power))
	return 1
