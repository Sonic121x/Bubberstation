/datum/disease/cryptococcus
	name = "隐球菌性脑膜炎"
	max_stages = 4
	stage_prob = 1.75
	spread_text = "空气传播"
	spreading_modifier = 0.75
	cure_text = "氟哌啶醇"
	cures = list(/datum/reagent/medicine/haloperidol)
	agent = "格特隐球菌"
	viable_mobtypes = list(/mob/living/carbon/human)
	cure_chance = 25
	desc = "一种攻击患者肌肉和大脑、试图夺取控制权的真菌感染。会引起发热、头痛、肌肉痉挛和疲劳。"
	severity = DISEASE_SEVERITY_BIOHAZARD

/datum/disease/cryptococcus/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感到脑子昏昏沉沉。这不对劲。"))
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你头痛欲裂。天花板一直都在这样晃动吗？"))
		if(2)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.emote("twitch")
				to_chat(affected_mob, span_danger("你不由自主地抽搐。这不对劲。"))
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("你嗅了嗅，闻到了绿色黏液的气味。绿色也有气味吗？"))
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("你头痛欲裂。天花板一直都在这样晃动吗？"))
		if(3)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("你看什么都有四重影子！"))
				affected_mob.set_dizzy_if_lower(10 SECONDS)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("你突然感到筋疲力尽，动作开始变得僵硬。情况很不对劲……"))
				affected_mob.adjust_stamina_loss(30, FALSE)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("你好热，非常热。肌肉短暂地舒服了一会儿，疼痛却又回来了。"))
				affected_mob.adjust_bodytemperature(20)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("你感到空气痛苦地挤出肺部。你并没打算呼气，肺部似乎在自行痉挛。"))
				affected_mob.adjust_oxy_loss(25, FALSE)
				affected_mob.emote("gasp")
		if(4)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("[pick("你的肌肉痉挛了！", "你瘫倒了！")]"))
				affected_mob.adjust_stamina_loss(50, FALSE)
				affected_mob.Paralyze(40, FALSE)
				affected_mob.adjust_brute_loss(5) //It's damaging the muscles
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_stamina_loss(100, FALSE)
				affected_mob.visible_message(span_warning("[affected_mob]昏倒了！"), span_userdanger("你放弃了抵抗，感到一片安宁……"))
				affected_mob.AdjustSleeping(100)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("你的心神放松下来，思绪开始飘远！"))
				affected_mob.adjust_confusion(10 SECONDS)
				affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 10)
			if(SPT_PROB(10, seconds_per_tick))
				to_chat(affected_mob, span_danger("[pick("你热得难受……", "你想拉开连体服的拉链", "你想脱掉几件衣服……")]"))
				affected_mob.adjust_bodytemperature(30)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.vomit(vomit_flags = VOMIT_CATEGORY_DEFAULT, lost_nutrition = 20)

/datum/reagent/cryptococcus_spores
	name = "格特隐球菌微生物"
	description = "活性真菌孢子。"
	color = "#92D17D"
	chemical_flags = NONE
	taste_description = "黏液"
	penetrates_skin = NONE

/datum/reagent/cryptococcus_spores/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT)) || ((methods & VAPOR) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/cryptococcus(), FALSE, TRUE)
