/// Caused by dirty food. Makes you vomit stars.
/datum/disease/nebula_nausea
	name = "星云恶心症"
	desc = "你的身体容不下宇宙的绚丽之美。"
	form = "病症"
	agent = "星辰"
	cure_text = /datum/reagent/space_cleaner::name
	spread_text = "无"
	cures = list(/datum/reagent/space_cleaner)
	viable_mobtypes = list(/mob/living/carbon/human)
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	severity = DISEASE_SEVERITY_MEDIUM
	required_organ = ORGAN_SLOT_STOMACH
	max_stages = 5

/datum/disease/advance/nebula_nausea/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(affected_mob))
				to_chat(affected_mob, span_warning("宇宙的绚丽之美似乎扰乱了你的平衡感。"))
		if(3)
			if(SPT_PROB(1, seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(affected_mob))
				to_chat(affected_mob, span_warning("你的胃里翻涌着人眼从未见过的色彩。"))
		if(4)
			if(SPT_PROB(1, seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(affected_mob))
				to_chat(affected_mob, span_warning("你感觉自己正漂浮在天体色彩形成的漩涡之中。"))
		if(5)
			if(SPT_PROB(1, seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(affected_mob))
				to_chat(affected_mob, span_warning("你的胃变成了一团动荡的星云，万花筒般的图案不断翻涌。"))
			else
				affected_mob.vomit(vomit_flags = (MOB_VOMIT_MESSAGE | MOB_VOMIT_HARM), vomit_type = /obj/effect/decal/cleanable/vomit/nebula, lost_nutrition = 10, distance = 2)
