/datum/round_event_control/wizard/magical_rain
	name = "魔法雨"
	weight = 3
	typepath = /datum/round_event/wizard/magical_rain
	max_occurrences = 5
	earliest_start = 0 MINUTES
	description = "一场魔法雷暴在下方降下大雨，任何被困其中的人都会被神秘的雨水浇透。"
	min_wizard_trigger_potency = 2
	max_wizard_trigger_potency = 7

/datum/round_event/wizard/magical_rain
	end_when = 0
	var/started = FALSE

/datum/round_event/wizard/magical_rain/start()
	for(var/mob/living/wizard in GLOB.alive_mob_list)
		// give it to all wizards even if there are multiple
		if(IS_WIZARD(wizard) && !HAS_TRAIT_FROM(wizard, TRAIT_RAINSTORM_IMMUNE, MAGIC_TRAIT))
			ADD_TRAIT(wizard, TRAIT_RAINSTORM_IMMUNE, MAGIC_TRAIT)
			to_chat(wizard, span_reallybig(span_hypnophrase("你感到一股魔法力量赋予了你对雨水的抗性！")))

	if(!started)
		started = TRUE
		SSweather.run_weather(/datum/weather/particle/rain_storm/wizard)

/datum/round_event/wizard/magical_rain/end()
	for(var/mob/living/wizard in GLOB.alive_mob_list)
		if(IS_WIZARD(wizard) && HAS_TRAIT_FROM(wizard, TRAIT_RAINSTORM_IMMUNE, MAGIC_TRAIT))
			REMOVE_TRAIT(wizard, TRAIT_RAINSTORM_IMMUNE, MAGIC_TRAIT)
			to_chat(wizard, span_notice("你感到自己对雨水的魔法抗性消退了！"))
