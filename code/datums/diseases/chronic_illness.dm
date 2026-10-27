/datum/disease/chronic_illness
	name = "遗传性流形病"
	max_stages = 5
	spread_text = "无"
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	disease_flags = CHRONIC
	infectable_biotypes = MOB_ORGANIC | MOB_MINERAL | MOB_ROBOTIC
	process_dead = TRUE
	stage_prob = 0.25
	cure_text = "可用以下药物缓解：" + /datum/reagent/medicine/sansufentanyl::name
	cures = list(/datum/reagent/medicine/sansufentanyl)
	infectivity = 0
	agent = "量子纠缠"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "一种在英特戴恩实验室中发现的疾病，由接受时间流校正技术引起。 \
		此病无法彻底治愈，但可通过治疗逆转病程，且不具传染性。 \
		若不治疗，患者将出现多种症状， \
		包括但不限于眩晕、恶心、心悸，并在最终阶段死亡。"
	bypasses_immunity = TRUE // BUBBER EDIT ADD
	severity = DISEASE_SEVERITY_UNCURABLE
	bypasses_immunity = TRUE
	var/being_stealthy = TRUE // BUBBER EDIT ADD

/datum/disease/chronic_illness/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			carrier = FALSE // Go fuck yourself
			being_stealthy = TRUE // BUBBER EDIT ADD
		if(2)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_warning("你感到眩晕。"))
				affected_mob.adjust_confusion(6 SECONDS)
				being_stealthy = FALSE // BUBBER EDIT ADD
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_notice("你望向自己的手，视线模糊了。"))
				affected_mob.set_eye_blur_if_lower(10 SECONDS)
				being_stealthy = FALSE // BUBBER EDIT ADD
		if(3)
			var/need_mob_update = FALSE
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的胸口一阵剧烈刺痛！"))
				being_stealthy = FALSE // BUBBER EDIT ADD
				if(prob(45))
					affected_mob.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = 20)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("[pick("你感觉心跳正在放缓……", "你放松下来，心跳减慢了。")]"))
				need_mob_update += affected_mob.adjust_stamina_loss(70, updating_stamina = FALSE)
				being_stealthy = FALSE // BUBBER EDIT ADD
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感觉脑中嗡嗡作响。"))
				SEND_SOUND(affected_mob, sound('sound/items/weapons/flash_ring.ogg'))
				being_stealthy = FALSE // BUBBER EDIT ADD
			if(SPT_PROB(0.5, seconds_per_tick))
				need_mob_update += affected_mob.adjust_brute_loss(1, updating_health = FALSE)
			if(need_mob_update)
				affected_mob.updatehealth()
		if(4)
			var/need_mob_update = FALSE
			if(prob(30))
				affected_mob.playsound_local(affected_mob, 'sound/effects/singlebeat.ogg', 100, FALSE, use_reverb = FALSE)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的胸口疼得可怕！"))
				if(prob(75))
					affected_mob.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = 45)
			if(SPT_PROB(1, seconds_per_tick))
				need_mob_update += affected_mob.adjust_stamina_loss(100, updating_stamina = FALSE)
				affected_mob.visible_message(span_warning("[affected_mob]倒下了！"))
				if(prob(30))
					to_chat(affected_mob, span_danger("你眼前一片模糊，昏了过去！"))
					affected_mob.AdjustSleeping(1 SECONDS)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("[pick("你感觉自己的原子正在原地加速。", "你感觉自己正被撕碎！")]"))
				affected_mob.emote("scream")
				need_mob_update += affected_mob.adjust_brute_loss(10, updating_health = FALSE)
			if(need_mob_update)
				affected_mob.updatehealth()
		if(5)
			switch(rand(1,2))
				if(1)
					to_chat(affected_mob, span_notice("你感觉自己的原子开始重新排列。你安全了。暂时如此。"))
					update_stage(1)
				if(2)
					to_chat(affected_mob, span_boldwarning("这条时间线容不下你。"))
					affected_mob.adjust_stamina_loss(100, forced = TRUE)
					playsound(affected_mob.loc, 'sound/effects/magic/repulse.ogg', 100, FALSE)
					affected_mob.emote("scream")
					for(var/mob/living/viewers in viewers(3, affected_mob.loc))
						viewers.flash_act()
					new /obj/effect/decal/cleanable/plasma(affected_mob.loc)
					new /obj/effect/decal/cleanable/ash(affected_mob.loc)
					affected_mob.visible_message(span_warning("[affected_mob]被从时间线上抹去了！"), span_userdanger("你被从时间线上撕扯了出去！"))
					affected_mob.investigate_log("has been dusted / deleted by [name].", INVESTIGATE_DEATHS)
					affected_mob.ghostize(can_reenter_corpse = FALSE)
					qdel(affected_mob)

//BUBBER EDIT BEGIN - Costly warning if it sneaks through to stage four.
/datum/disease/chronic_illness/update_stage(new_stage)
	. = ..()
	if(new_stage == 4 && being_stealthy)
		to_chat(affected_mob, span_danger("[pick("你感觉自己的原子正在原地加速。", "你感觉自己正被撕碎！")]"))
		affected_mob.emote("scream")
		affected_mob.adjust_brute_loss(10)
		being_stealthy = FALSE
// BUBBER EDIT END
