/datum/disease/magnitis
	name = "磁化症"
	max_stages = 4
	spread_text = "空气传播"
	cure_text = /datum/reagent/iron
	cures = list(/datum/reagent/iron)
	agent = "离奇神迹菌"
	viable_mobtypes = list(/mob/living/carbon/human)
	disease_flags = CAN_CARRY|CAN_RESIST|CURABLE
	spreading_modifier = 0.75
	desc = "这种疾病扰乱患者身体的磁场，使其像一块强力磁铁。 \
		注射铁有助于稳定磁场。"
	severity = DISEASE_SEVERITY_MEDIUM
	infectable_biotypes = MOB_ORGANIC|MOB_ROBOTIC
	bypasses_immunity = TRUE
	process_dead = TRUE


/datum/disease/magnitis/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的皮肤因能量流动而发麻。"))
			if(SPT_PROB(1, seconds_per_tick))
				for(var/obj/nearby_object in orange(2, affected_mob))
					if(nearby_object.anchored || !(nearby_object.obj_flags & CONDUCTS_ELECTRICITY))
						continue
					var/move_dir = get_dir(nearby_object, affected_mob)
					nearby_object.Move(get_step(nearby_object, move_dir), move_dir)
				for(var/mob/living/silicon/nearby_silicon in orange(2, affected_mob))
					if(isAI(nearby_silicon))
						continue
					var/move_dir = get_dir(nearby_silicon, affected_mob)
					nearby_silicon.Move(get_step(nearby_silicon, move_dir), move_dir)
		if(3)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的头发竖了起来。"))
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感觉一股微弱电流流过全身。"))
				for(var/obj/nearby_object in orange(4, affected_mob))
					if(nearby_object.anchored || !(nearby_object.obj_flags & CONDUCTS_ELECTRICITY))
						continue
					for(var/i in 1 to rand(1, 2))
						nearby_object.throw_at(affected_mob, 4, 3)
				for(var/mob/living/silicon/nearby_silicon in orange(4, affected_mob))
					if(isAI(nearby_silicon))
						continue
					for(var/i in 1 to rand(1, 2))
						nearby_silicon.throw_at(affected_mob, 4, 3)
		if(4)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("你开始思索奇迹的本质。"))
			if(SPT_PROB(4, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感觉一股强烈电流流过全身。"))
				for(var/obj/nearby_object in orange(6, affected_mob))
					if(nearby_object.anchored || !(nearby_object.obj_flags & CONDUCTS_ELECTRICITY))
						continue
					for(var/i in 1 to rand(1, 3))
						nearby_object.throw_at(affected_mob, 6, 5) // I really wanted to use addtimers to stagger out when everything gets thrown but it would probably cause a lot of lag.
				for(var/mob/living/silicon/nearby_silicon in orange(6, affected_mob))
					if(isAI(nearby_silicon))
						continue
					for(var/i in 1 to rand(1, 3))
						nearby_silicon.throw_at(affected_mob, 6, 5)
