/datum/quirk/drunkhealing
	name = "Drunken Resilience"
	desc = "没有什么比一杯美酒更能让你飘飘欲仙。喝醉时，你的伤势会缓慢恢复。"
	icon = FA_ICON_WINE_BOTTLE
	value = 8
	gain_text = span_notice("你觉得喝一杯会对自己有好处。")
	lose_text = span_danger("你不再觉得喝酒能缓解疼痛。")
	medical_record_text = "患者肝脏代谢效率异常高，可通过饮用酒精饮料缓慢修复伤口。"
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_PROCESSES
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/booze)

/datum/quirk/drunkhealing/process(seconds_per_tick)
	var/need_mob_update = FALSE
	switch(quirk_holder.get_drunk_amount())
		if (6 to 40)
			need_mob_update += quirk_holder.adjust_brute_loss(-0.1 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
			need_mob_update += quirk_holder.adjust_fire_loss(-0.05 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
		if (41 to 60)
			need_mob_update += quirk_holder.adjust_brute_loss(-0.4 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
			need_mob_update += quirk_holder.adjust_fire_loss(-0.2 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
		if (61 to INFINITY)
			need_mob_update += quirk_holder.adjust_brute_loss(-0.8 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
			need_mob_update += quirk_holder.adjust_fire_loss(-0.4 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
	if(need_mob_update)
		quirk_holder.updatehealth()
