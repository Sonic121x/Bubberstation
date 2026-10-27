/datum/disease/dna_retrovirus
	name = "逆转录病毒"
	max_stages = 4
	spread_text = "接触传播"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = /datum/reagent/medicine/mutadone::name + "或休息"
	cure_chance = 3
	agent = "病毒"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "一种改变 DNA 的逆转录病毒，会不断扰乱宿主的结构酶和特异酶。"
	severity = DISEASE_SEVERITY_HARMFUL
	spreading_modifier = 0.4
	stage_prob = 1
	var/restcure = 0
	bypasses_immunity = TRUE

/datum/disease/dna_retrovirus/New()
	..()
	agent = "病毒类别 [pick("A","B","C","D","E","F")][pick("A","B","C","D","E","F")]-[rand(50,300)]"
	if(prob(40))
		cures = list(/datum/reagent/medicine/mutadone)
	else
		restcure = 1

/datum/disease/dna_retrovirus/Copy()
	var/datum/disease/dna_retrovirus/D = ..()
	D.restcure = restcure
	return D

/datum/disease/dna_retrovirus/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(4, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的头很痛。"))
			if(SPT_PROB(4.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的胸口一阵刺麻。"))
			if(SPT_PROB(4.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感到愤怒。"))
			if(restcure && affected_mob.body_position == LYING_DOWN && SPT_PROB(16, seconds_per_tick))
				to_chat(affected_mob, span_notice("你感觉好些了。"))
				cure()
				return FALSE
		if(2)
			if(SPT_PROB(4, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的皮肤感觉松弛了。"))
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感觉非常奇怪。"))
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的头一阵刺痛！"))
				affected_mob.Unconscious(40)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的胃一阵翻腾。"))
			if(restcure && affected_mob.body_position == LYING_DOWN && SPT_PROB(10, seconds_per_tick))
				to_chat(affected_mob, span_notice("你感觉好些了。"))
				cure()
				return FALSE
		if(3)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的整个身体都在颤动。"))
			if(SPT_PROB(19, seconds_per_tick))
				switch(rand(1,3))
					if(1)
						scramble_dna(affected_mob, 1, 0, 0, rand(15,45))
					if(2)
						scramble_dna(affected_mob, 0, 1, 0, rand(15,45))
					if(3)
						scramble_dna(affected_mob, 0, 0, 1, rand(15,45))
			if(restcure && affected_mob.body_position == LYING_DOWN && SPT_PROB(10, seconds_per_tick))
				to_chat(affected_mob, span_notice("你感觉好些了。"))
				cure()
				return FALSE
		if(4)
			if(SPT_PROB(37, seconds_per_tick))
				switch(rand(1,3))
					if(1)
						scramble_dna(affected_mob, 1, 0, 0, rand(50,75))
					if(2)
						scramble_dna(affected_mob, 0, 1, 0, rand(50,75))
					if(3)
						scramble_dna(affected_mob, 0, 0, 1, rand(50,75))
			if(restcure && affected_mob.body_position == LYING_DOWN && SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_notice("你感觉好些了。"))
				cure()
				return FALSE
