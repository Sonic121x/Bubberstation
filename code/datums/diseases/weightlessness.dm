/datum/disease/weightlessness
	name = "局部失重障碍"
	max_stages = 4
	spread_text = "皮肤接触"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = /datum/reagent/liquid_dark_matter::name
	cures = list(/datum/reagent/liquid_dark_matter)
	agent = "亚量子 DNA 排斥"
	viable_mobtypes = list(/mob/living/carbon/human)
	disease_flags = CAN_CARRY|CAN_RESIST|CURABLE
	spreading_modifier = 0.5
	cure_chance = 4
	desc = "这种疾病会从底层改写患者的生物电特征，使其排斥“重量”这一现象。摄入液态暗物质通常能稳定该力场。"
	severity = DISEASE_SEVERITY_MEDIUM
	infectable_biotypes = MOB_ORGANIC


/datum/disease/weightlessness/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("你一瞬间几乎失去了平衡。"))
		if(2)
			if(SPT_PROB(3, seconds_per_tick) && !HAS_TRAIT_FROM(affected_mob, TRAIT_MOVE_FLOATING, NO_GRAVITY_TRAIT))
				to_chat(affected_mob, span_danger("你感觉自己离开了地面。"))
				affected_mob.reagents.add_reagent(/datum/reagent/gravitum, 1)

		if(4)
			if(SPT_PROB(3, seconds_per_tick) && !affected_mob.has_quirk(/datum/quirk/spacer_born))
				to_chat(affected_mob, span_danger("周围开始天旋地转，你感到一阵恶心。"))
				affected_mob.adjust_confusion(3 SECONDS)
			if(SPT_PROB(8, seconds_per_tick) && !HAS_TRAIT_FROM(affected_mob, TRAIT_MOVE_FLOATING, NO_GRAVITY_TRAIT))
				to_chat(affected_mob, span_danger("你突然飘离了地面。"))
				affected_mob.reagents.add_reagent(/datum/reagent/gravitum, 5)

/datum/disease/weightlessness/cure(add_resistance)
	. = ..()
	affected_mob.vomit(VOMIT_CATEGORY_DEFAULT, lost_nutrition = 95, purge_ratio = 0.4)
	to_chat(affected_mob, span_danger("你的身体不再排斥重力，你摔到了地板上。"))
