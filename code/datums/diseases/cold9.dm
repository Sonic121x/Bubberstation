/datum/disease/cold9
	name = "寒冰感冒"
	max_stages = 3
	spread_text = "皮肤接触"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = /datum/reagent/medicine/spaceacillin::name + "或普通感冒抗体"
	cures = list(/datum/reagent/medicine/spaceacillin)
	agent = "ICE9 鼻病毒"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "普通感冒的变种，危险性稍高。 \
		若不治疗，患者行动会变慢，仿佛身体被部分冻结。"
	severity = DISEASE_SEVERITY_HARMFUL
	required_organ = ORGAN_SLOT_LUNGS

/datum/disease/cold9/cure(add_resistance)
	// buy one, get one free
	if(add_resistance && affected_mob)
		LAZYOR(affected_mob.disease_resistances, "[/datum/disease/cold]")
	return ..()

/datum/disease/cold9/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			affected_mob.adjust_bodytemperature(-5 * seconds_per_tick)
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("sneeze")
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的喉咙酸痛。"))
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感到身体僵硬。"))
			if(SPT_PROB(0.05, seconds_per_tick))
				to_chat(affected_mob, span_notice("你感觉好些了。"))
				cure()
				return FALSE
		if(3)
			affected_mob.adjust_bodytemperature(-10 * seconds_per_tick)
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("sneeze")
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的喉咙酸痛。"))
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感到身体僵硬。"))
