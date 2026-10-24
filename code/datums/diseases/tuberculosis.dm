/datum/disease/tuberculosis
	form = "真菌"
	name = "真菌性结核病"
	max_stages = 5
	spread_text = "空气传播"
	cure_text = /datum/reagent/medicine/spaceacillin::name + " & " + /datum/reagent/medicine/c2/convermol::name
	cures = list(/datum/reagent/medicine/spaceacillin, /datum/reagent/medicine/c2/convermol)
	agent = "宇宙真菌性结核杆菌"
	viable_mobtypes = list(/mob/living/carbon/human)
	cure_chance = 2.5 //like hell are you getting out of hell
	desc = "一种罕见、传播性极强的致病真菌。 \
		现存样本极少，据传由秘密生化武器专家精心培育。 \
		会引发发热、吐血、肺损伤、体重下降、疲劳，并最终导致死亡。"
	required_organ = ORGAN_SLOT_LUNGS
	severity = DISEASE_SEVERITY_BIOHAZARD
	bypasses_immunity = TRUE // TB primarily impacts the lungs; it's also bacterial or fungal in nature; viral immunity should do nothing.

/datum/disease/tuberculosis/stage_act(seconds_per_tick) //it begins
	. = ..()
	if(!.)
		return

	if(SPT_PROB(stage * 2, seconds_per_tick))
		affected_mob.emote("cough")
		to_chat(affected_mob, span_danger("你的胸口很痛。"))

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的胃剧烈地咕噜作响！"))
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你开始冒冷汗。"))
		if(4)
			var/need_mob_update = FALSE
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("你看什么都有四重影子！"))
				affected_mob.set_dizzy_if_lower(10 SECONDS)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的下胸部一阵刺痛！"))
				need_mob_update += affected_mob.adjust_oxy_loss(5, updating_health = FALSE)
				affected_mob.emote("gasp")
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感觉空气正从肺里泄出，疼痛难忍。"))
				need_mob_update += affected_mob.adjust_oxy_loss(25, updating_health = FALSE)
				affected_mob.emote("gasp")
			if(need_mob_update)
				affected_mob.updatehealth()
		if(5)
			var/need_mob_update = FALSE
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("[pick("你感觉心跳正在放缓……", "你放松下来，心跳减慢了。")]"))
				need_mob_update += affected_mob.adjust_stamina_loss(70, updating_stamina = FALSE)
			if(SPT_PROB(5, seconds_per_tick))
				need_mob_update += affected_mob.adjust_stamina_loss(100, updating_stamina = FALSE)
				affected_mob.visible_message(span_warning("[affected_mob]昏倒了！"), span_userdanger("你放弃了抵抗，感到一片安宁……"))
				affected_mob.AdjustSleeping(10 SECONDS)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("你感觉心神松弛，思绪渐渐飘散！"))
				affected_mob.adjust_confusion_up_to(8 SECONDS, 100 SECONDS)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.vomit(VOMIT_CATEGORY_DEFAULT, lost_nutrition = 20)
			if(SPT_PROB(1.5, seconds_per_tick))
				to_chat(affected_mob, span_warning("<i>[pick("你的胃无声地蠕动着……", "你的胃先是紧缩，随后瘫软，肌肉死气沉沉、毫无生机。", "你饿得连蜡笔都想吃。")]</i>"))
				affected_mob.overeatduration = max(affected_mob.overeatduration - (200 SECONDS), 0)
				affected_mob.adjust_nutrition(-100)
			if(SPT_PROB(7.5, seconds_per_tick))
				if(ishuman(affected_mob))
					var/mob/living/carbon/human/human_victim = affected_mob
					to_chat(human_victim, span_danger("[human_victim.w_uniform? pick("你热得很难受……", "你想拉开连体服的拉链……", "你想脱掉几件衣服……") : "你热得很难受……"]"))
				else
					to_chat(affected_mob, span_danger("你热得很难受……"))
				affected_mob.adjust_bodytemperature(40)
			if(need_mob_update)
				affected_mob.updatehealth()
