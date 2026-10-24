/datum/disease/rhumba_beat
	name = "伦巴节拍"
	desc = "他们叫我古巴皮特——我是伦巴节拍之王——摇起沙锤，我就唱：奇奇嘣，奇奇嘣。"
	max_stages = 5
	spread_text = "皮肤接触"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "奇奇嘣！"
	cures = list(/datum/reagent/toxin/plasma)
	agent = "未知"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 1
	severity = DISEASE_SEVERITY_BIOHAZARD
	bypasses_immunity = TRUE
	visibility_flags = HIDDEN_BOOK

/datum/disease/rhumba_beat/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(26, seconds_per_tick))
				affected_mob.adjust_fire_loss(5)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感觉怪怪的……"))
		if(3)
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你有种跳舞的冲动……"))
			else if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("gasp")
			else if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你想来一段奇奇嘣……"))
		if(4)
			if(SPT_PROB(10, seconds_per_tick))
				if(prob(50))
					affected_mob.adjust_fire_stacks(2)
					affected_mob.ignite_mob()
				else
					affected_mob.emote("gasp")
					to_chat(affected_mob, span_danger("你感觉体内有炽热的节拍在跳动……"))
		if(5)
			to_chat(affected_mob, span_danger("你的身体已经容不下这伦巴节拍……"))
			if(SPT_PROB(29, seconds_per_tick))
				explosion(affected_mob, devastation_range = -1, light_impact_range = 2, flame_range = 2, flash_range = 3, adminlog = FALSE, explosion_cause = src) // This is equivalent to a lvl 1 fireball
