/datum/disease/anxiety
	name = "严重焦虑"
	form = "病症"
	max_stages = 4
	spread_text = "皮肤接触"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = /datum/reagent/consumable/ethanol::name + "（液体勇气）"
	cures = list(/datum/reagent/consumable/ethanol)
	agent = "鳞翅目杀虫剂过量"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "一种已有充分记录的病症，会让患者肚子里真的出现蝴蝶，而且经常被吐出来。"
	severity = DISEASE_SEVERITY_MINOR


/datum/disease/anxiety/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2) //also changes say, see say.dm
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_notice("你感到焦虑。"))
		if(3)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_notice("你的胃里一阵扑腾。"))
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_notice("你感到惊慌。"))
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("恐慌吞没了你！"))
				affected_mob.adjust_confusion(rand(2 SECONDS, 3 SECONDS))
		if(4)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感觉胃里有蝴蝶在飞。"))
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.visible_message(span_danger("[affected_mob]惊慌失措地跌跌撞撞。"), \
												span_userdanger("你的惊恐发作了！"))
				affected_mob.adjust_confusion(rand(6 SECONDS, 8 SECONDS))
				affected_mob.adjust_jitter(rand(12 SECONDS, 16 SECONDS))
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.visible_message(span_danger("[affected_mob]咳出了蝴蝶！"), \
													span_userdanger("你咳出了蝴蝶！"))
				new /mob/living/basic/butterfly(affected_mob.loc)
				new /mob/living/basic/butterfly(affected_mob.loc)
