/datum/disease/adrenal_crisis
	form = "病症"
	name = "肾上腺危象"
	max_stages = 2
	cure_text = "创伤（肾上腺素 / \"" + /datum/reagent/determination::name + "\"）"
	cures = list(/datum/reagent/determination)
	cure_chance = 10
	agent = "克隆卡因滥用"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 1
	desc = "一种因持续滥用克隆卡因引起的罕见病症。 \
		若不治疗，患者将出现嗜睡、头晕和间歇性意识丧失。"
	severity = DISEASE_SEVERITY_MEDIUM
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	spread_text = "无"
	visibility_flags = HIDDEN_PANDEMIC
	bypasses_immunity = TRUE

/datum/disease/adrenal_crisis/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_warning(pick("你感到头晕目眩。", "你感到浑身乏力。")))
		if(2)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.Unconscious(40)

			if(SPT_PROB(10, seconds_per_tick))
				affected_mob.adjust_slurring(14 SECONDS)

			if(SPT_PROB(7, seconds_per_tick))
				affected_mob.set_dizzy_if_lower(20 SECONDS)

			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_warning(pick("你感到一阵疼痛沿双腿向下蔓延！", "你感觉自己随时都会昏倒。", "你感到非常眩晕。")))
