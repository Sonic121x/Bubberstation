//Darude sandstorm starts playing
/datum/weather/sand_storm
	name = "severe sandstorm"
	desc = "猛烈的沙尘暴吞没了此地，对毫无防护者造成严重伤害。"

	telegraph_message = span_danger("你看到地平线上升起了一片沙尘云。这可不是什么好兆头……")
	telegraph_duration = 30 SECONDS
	telegraph_overlay = "dust_med"
	telegraph_sound = 'sound/effects/siren.ogg'

	weather_message = span_userdanger("<i>灼热的风沙猛烈抽打着你！快进室内！</i>")
	weather_duration_lower = 1 MINUTES
	weather_duration_upper = 2 MINUTES
	weather_overlay = "dust_high"

	end_message = span_bolddanger("呼啸的狂风卷走了最后的沙尘，恢复了平日的低吟。现在外面应该安全了。")
	end_duration = 30 SECONDS
	end_overlay = "dust_med"

	area_type = /area
	target_trait = ZTRAIT_SANDSTORM
	immunity_type = TRAIT_SANDSTORM_IMMUNE
	probability = 90

	weather_flags = (WEATHER_MOBS | WEATHER_BAROMETER)

/datum/weather/sand_storm/get_playlist_ref()
	return GLOB.sand_storm_sounds

/datum/weather/sand_storm/telegraph()
	GLOB.sand_storm_sounds.Cut()
	for(var/area/impacted_area as anything in impacted_areas)
		GLOB.sand_storm_sounds[impacted_area] = /datum/looping_sound/weak_outside_ashstorm
	return ..()

/datum/weather/sand_storm/start()
	GLOB.sand_storm_sounds.Cut()
	for(var/area/impacted_area as anything in impacted_areas)
		GLOB.sand_storm_sounds[impacted_area] = /datum/looping_sound/active_outside_ashstorm
	return ..()

/datum/weather/sand_storm/wind_down()
	GLOB.sand_storm_sounds.Cut()
	for(var/area/impacted_area as anything in impacted_areas)
		GLOB.sand_storm_sounds[impacted_area] = /datum/looping_sound/weak_outside_ashstorm
	return ..()

/datum/weather/sand_storm/weather_act_mob(mob/living/victim)
	victim.adjust_brute_loss(5, required_bodytype = BODYTYPE_ORGANIC)
	return ..()

/datum/weather/sand_storm/harmless
	name = "sandfall"
	desc = "掠过的沙尘暴为此地覆上了一层沙子。"

	telegraph_message = span_danger("风势开始增强，将地面的沙子卷了起来……")
	telegraph_overlay = "dust_low"
	telegraph_sound = null

	weather_message = span_notice("细沙像怪异的雪花般飘落在你周围。风暴似乎与你擦肩而过……")
	weather_overlay = "dust_med"

	end_message = span_notice("落沙逐渐减少，终于停止。你脚下的台地又多了一层沙子。")
	end_overlay = "dust_low"

	probability = 10
	weather_flags = parent_type::weather_flags & ~WEATHER_MOBS
