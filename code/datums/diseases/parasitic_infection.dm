/datum/disease/parasite
	form = "寄生虫"
	name = "寄生虫感染"
	max_stages = 4
	cure_text = "手术切除肝脏"
	agent = "食源性寄生虫"
	spread_text = "无"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 1
	desc = "一种未知寄生虫感染了患者的肝脏，很可能来自处理不当的食物。 \
		若不治疗，患者会持续流失营养，最终失去肝脏。"
	severity = DISEASE_SEVERITY_HARMFUL
	disease_flags = CAN_CARRY|CAN_RESIST
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	required_organ = ORGAN_SLOT_LIVER
	bypasses_immunity = TRUE

/datum/disease/parasite/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("cough")
		if(2)
			if(SPT_PROB(5, seconds_per_tick))
				if(prob(50))
					to_chat(affected_mob, span_notice("你已经感觉到自己瘦了！"))
				affected_mob.adjust_nutrition(-3)
		if(3)
			if(SPT_PROB(10, seconds_per_tick))
				if(prob(20))
					to_chat(affected_mob, span_notice("你……真的开始感到体重下降了。"))
				affected_mob.adjust_nutrition(-6)
		if(4)
			if(SPT_PROB(16, seconds_per_tick))
				if(affected_mob.nutrition >= 100)
					if(prob(10))
						to_chat(affected_mob, span_warning("你感觉自己的体重正在飞速下降！"))
					affected_mob.adjust_nutrition(-12)
				else
					to_chat(affected_mob, span_warning("你感觉自己轻了好多、好多！"))
					affected_mob.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = 20)
					// disease code already checks if the liver exists otherwise it is cured
					var/obj/item/organ/liver/affected_liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
					affected_liver.Remove(affected_mob)
					affected_liver.forceMove(get_turf(affected_mob))
					cure()
					return FALSE
