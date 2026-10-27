/datum/disease/brainrot
	name = "脑腐病"
	max_stages = 4
	spread_text = "皮肤接触"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = /datum/reagent/medicine/mannitol::name
	cures = list(/datum/reagent/medicine/mannitol)
	agent = "宇宙隐球菌"
	viable_mobtypes = list(/mob/living/carbon/human)
	cure_chance = 7.5 //higher chance to cure, since two reagents are required
	desc = "一种攻击脑细胞、引发脑雾的疾病，但本身并不致命。"
	required_organ = ORGAN_SLOT_BRAIN
	severity = DISEASE_SEVERITY_HARMFUL
	bypasses_immunity = TRUE

/datum/disease/brainrot/stage_act(seconds_per_tick) //Removed toxloss because damaging diseases are pretty horrible. Last round it killed the entire station because the cure didn't work -- Urist -ACTUALLY Removed rather than commented out, I don't see it returning - RR
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("blink")
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("yawn")
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感觉自己变得不像自己了。"))
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1, 170)
		if(3)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("stare")
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("drool")
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 2, 170)
				if(prob(2))
					to_chat(affected_mob, span_danger("你试图想起一件重要的事……却怎么也想不起来。"))

		if(4)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("stare")
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("drool")
			if(SPT_PROB(7.5, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 3, 170)
				if(prob(2))
					to_chat(affected_mob, span_danger("奇怪的嗡鸣充斥着你的脑袋，抹去了所有思绪。"))
			if(SPT_PROB(1.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你失去了意识……"))
				affected_mob.visible_message(span_warning("[affected_mob]突然倒下了！"), \
											span_userdanger("你突然倒下了！"))
				affected_mob.Unconscious(rand(100, 200))
				if(prob(1))
					affected_mob.emote("snore")
			if(SPT_PROB(7.5, seconds_per_tick))
				affected_mob.adjust_stutter(6 SECONDS)
