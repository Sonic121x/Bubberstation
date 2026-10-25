/datum/action/changeling/resonant_shriek
	name = "共振尖啸"
	desc = "我们的肺与声带发生移位，得以发出一种使非变形怪耳聋、混乱的噪音，令其部分失去对动作的控制。\
		最适合用来阻止猎物逃跑。在真空中效果不佳。消耗 20 点化学物质。"
	helptext = "发出高频声音，使人类混乱、耳聋从而妨碍其行动，同时烧毁附近的灯具并使半机械人的传感器过载。"
	button_icon_state = "resonant_shriek"
	category = "combat"
	chemical_cost = 20
	dna_cost = 1
	req_human = TRUE
	disabled_by_fire = FALSE

//A flashy ability, good for crowd control and sowing chaos.
/datum/action/changeling/resonant_shriek/sting_action(mob/user)
	..()
	if(user.movement_type & VENTCRAWLING)
		user.balloon_alert(user, "不能在管道里尖啸！")
		return FALSE
	playsound(user, 'sound/effects/screech.ogg', 100)
	for(var/mob/living/living in get_hearers_in_view(4, user))
		if(IS_CHANGELING(living) || !living.soundbang_act(SOUNDBANG_MASSIVE, stun_pwr = 0, damage_pwr = 0, deafen_pwr = 1 MINUTES, ignore_deafness = TRUE, send_sound = FALSE))
			continue
		if(issilicon(living))
			living.Paralyze(rand(10 SECONDS, 20 SECONDS))
			continue
		living.adjust_confusion(25 SECONDS)
		living.set_jitter_if_lower(100 SECONDS)

	for(var/obj/machinery/light/light in range(4, user))
		light.on = TRUE
		light.break_light_tube()
		stoplag()
	return TRUE

/datum/action/changeling/dissonant_shriek
	name = "噬械尖啸"
	desc = "我们调整声带，释放出能过载附近电子设备的高频声音。会破坏耳机与摄像头，有时还能破坏激光武器、门与 MOD 外骨骼。消耗 20 点化学物质。"
	button_icon_state = "technophagic_shriek"
	category = "combat"
	chemical_cost = 20
	dna_cost = 1
	disabled_by_fire = FALSE
	COOLDOWN_DECLARE(dissonant_shriek_cooldown) //BUBBER EDIT: DECLARES A COOLDOWN

/datum/action/changeling/dissonant_shriek/sting_action(mob/user)
	..()
	if(user.movement_type & VENTCRAWLING)
		user.balloon_alert(user, "不能在管道里尖啸！")
		return FALSE
	//BUBBER EDIT: NO PULSE IF YOU'RE ON COOLDOWN
	if(!COOLDOWN_FINISHED(src, dissonant_shriek_cooldown))
		user.balloon_alert(user, "喉咙嘶哑了！")
		return FALSE
	//BUBBER EDIT: NO PULSE IF YOU'RE ON COOLDOWN
	empulse(get_turf(user), 2, 5, 1, emp_source = src)
	for(var/obj/machinery/light/L in range(5, usr))
		L.on = TRUE
		L.break_light_tube()
		stoplag()
		COOLDOWN_START(src, dissonant_shriek_cooldown, 10 SECONDS) //BUBBER EDIT: ADDS A COOLDOWN TO DISSONANT SHRIEK

	return TRUE
