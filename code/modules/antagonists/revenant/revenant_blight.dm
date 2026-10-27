/datum/disease/revblight
	name = "非自然消瘦"
	desc = "一种奇怪的病症，会让患者感觉自己正在消瘦，尽管其身体其他方面（几乎）完全健康。"
	form = "病症"
	max_stages = 5
	stage_prob = 5
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	cure_text = /datum/reagent/water/holywater::name + " 或休息"
	spread_text = "无"
	cures = list(/datum/reagent/water/holywater)
	cure_chance = 30 //higher chance to cure, because revenants are assholes
	agent = "邪恶力量"
	viable_mobtypes = list(/mob/living/carbon/human)
	disease_flags = CURABLE
	spreading_modifier = 1
	severity = DISEASE_SEVERITY_HARMFUL
	var/stagedamage = 0 //Highest stage reached.
	var/finalstage = 0 //Because we're spawning off the cure in the final stage, we need to check if we've done the final stage's effects.

/datum/disease/revblight/cure(add_resistance = FALSE)
	if(affected_mob)
		affected_mob.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, "#1d2953")
		if(affected_mob.dna && affected_mob.dna.species)
			affected_mob.set_haircolor(null, override = TRUE)
		to_chat(affected_mob, span_notice("你感觉好多了。"))
	..()


/datum/disease/revblight/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	if(!finalstage)
		var/need_mob_update = FALSE
		if(affected_mob.body_position == LYING_DOWN && SPT_PROB(3 * stage, seconds_per_tick))
			cure()
			return FALSE
		if(SPT_PROB(1.5 * stage, seconds_per_tick))
			to_chat(affected_mob, span_revennotice("你突然感到[pick("又病又累", "分不清方向", "又累又困惑", "恶心", "虚弱", "头晕")]……"))
			affected_mob.adjust_confusion(8 SECONDS)
			need_mob_update += affected_mob.adjust_stamina_loss(20, updating_stamina = FALSE)
			new /obj/effect/temp_visual/revenant(affected_mob.loc)
		if(stagedamage < stage)
			stagedamage++
			need_mob_update += affected_mob.adjust_tox_loss(1 * stage * seconds_per_tick, updating_health = FALSE) //should, normally, do about 30 toxin damage.
			new /obj/effect/temp_visual/revenant(affected_mob.loc)
		if(SPT_PROB(25, seconds_per_tick))
			need_mob_update += affected_mob.adjust_stamina_loss(stage, updating_stamina = FALSE)
		if(need_mob_update)
			affected_mob.updatehealth()

	switch(stage)
		if(2)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("pale")
		if(3)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.emote(pick("pale","shiver"))
		if(4)
			if(SPT_PROB(7.5, seconds_per_tick))
				affected_mob.emote(pick("pale","shiver","cries"))
		if(5)
			if(!finalstage)
				finalstage = TRUE
				to_chat(affected_mob, span_revenbignotice("你觉得[pick("一切都不再值得", "从来没人需要过你的帮助", "你所做的一切都无关紧要", "你尝试做的一切都毫无价值")]。"))
				affected_mob.adjust_stamina_loss(22.5 * seconds_per_tick, updating_stamina = FALSE)
				new /obj/effect/temp_visual/revenant(affected_mob.loc)
				if(affected_mob.dna && affected_mob.dna.species)
					affected_mob.set_haircolor("#1d2953", override = TRUE)
				affected_mob.visible_message(span_warning("[affected_mob]看起来消瘦得可怕……"), span_revennotice("你突然觉得自己的皮肤<i>不对劲</i>……"))
				affected_mob.add_atom_colour("#1d2953", TEMPORARY_COLOUR_PRIORITY)
				addtimer(CALLBACK(src, PROC_REF(cure)), 10 SECONDS)
