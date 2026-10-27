/datum/disease/transformation_race
	name = "种族转化"
	max_stages = 5
	spread_text = "急性"
	spread_flags = DISEASE_SPREAD_SPECIAL
	cure_text = "信仰"
	agent = "恶作剧"
	viable_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/alien)
	severity = DISEASE_SEVERITY_BIOHAZARD
	stage_prob = 5
	visibility_flags = HIDDEN_SCANNER|HIDDEN_PANDEMIC
	disease_flags = CURABLE
	bypasses_immunity = TRUE
	var/list/stage1 = list("你感觉自己平平无奇。")
	var/list/stage2 = list("你感觉自己很无趣。")
	var/list/stage3 = list("你感觉自己毫无特色。")
	var/list/stage4 = list("你感觉自己像白面包一样平淡。")
	var/list/stage5 = list("啊，这人类之躯！")
	var/race = /datum/species/human

/datum/disease/transformation_race/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(length(stage1) && SPT_PROB(stage_prob, seconds_per_tick))
				to_chat(affected_mob, pick(stage1))
		if(2)
			if(length(stage2) && SPT_PROB(stage_prob, seconds_per_tick))
				to_chat(affected_mob, pick(stage2))
		if(3)
			if(length(stage3) && SPT_PROB(stage_prob * 2, seconds_per_tick))
				to_chat(affected_mob, pick(stage3))
		if(4)
			if(length(stage4) && SPT_PROB(stage_prob * 2, seconds_per_tick))
				to_chat(affected_mob, pick(stage4))
		if(5)
			var/datum/species/species_type = race
			affected_mob.set_species(species_type, icon_update = TRUE, pref_load = FALSE)
			to_chat(affected_mob, span_warning("你变成了[LOWER_TEXT(initial(species_type.name))]！"))
			cure()

/datum/disease/transformation_race/synthetic
	name = "合成人转化纳米机器人"
	cure_text = "注射铜。"
	cures = list(/datum/reagent/copper)
	cure_chance = 2.5
	agent = "C3P0 纳米机器人"
	desc = "一种会将感染者转化为合成生命体的急性纳米机器人感染。"
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list()
	stage2 = list(span_danger ("你的关节感到僵硬。"))
	stage3 = list(
		span_danger("你感觉有什么东西在动……在体内。"),
		span_danger("你的关节感到十分僵硬。"),
		span_warning("你的皮肤感到松弛。"),
	)
	stage4 = list(span_danger("你感觉……有什么东西……在你体内。"), span_danger("你的皮肤感到十分松弛。"),)
	stage5 = list(span_danger("你的皮肤仿佛就要爆裂开来！"))
	race = /datum/species/synthetic
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD|MOB_ROBOTIC

/datum/disease/transformation_race/android
	name = "仿生人转化纳米机器人"
	cure_text = "注射铜。"
	cures = list(/datum/reagent/copper)
	cure_chance = 2.5
	agent = "BB-8 纳米机器人"
	desc = "一种会将感染者转化为仿生人的急性纳米机器人感染。"
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list()
	stage2 = list(span_danger ("你的关节感到僵硬。"))
	stage3 = list(
		span_danger("你感觉有什么东西在动……在体内。"),
		span_danger("你的关节感到十分僵硬。"),
		span_warning("你的皮肤感到松弛。"),
	)
	stage4 = list(span_danger("你感觉……有什么东西……在你体内。"), span_danger("你的皮肤感到十分松弛。"),)
	stage5 = list(span_danger("你的皮肤仿佛就要爆裂开来！"))
	race = /datum/species/android
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD|MOB_ROBOTIC

/datum/disease/transformation/xeno
	new_form = /mob/living/carbon/alien/adult/skyrat/drone
