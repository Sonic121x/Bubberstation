/datum/round_event_control/anomaly/anomaly_weather
	name = "异常：天气"
	typepath = /datum/round_event/anomaly/anomaly_weather

	max_occurrences = 2
	weight = 10
	description = "该异常会使天气效果在室内显现。 \
		它可能造成完全无害的天气，如小雨，也可能造成会伤害未受防护者的天气，如暴风雪。 \
		注意，同时触发多个很可能会破坏天气音效。"
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 5
	admin_setup = list(
		/datum/event_admin_setup/set_location/anomaly,
		/datum/event_admin_setup/listed_options/weather_anomaly,
		/datum/event_admin_setup/listed_options/weather_thunder,
	)

/datum/round_event_control/anomaly/anomaly_weather/can_spawn_event(players_amt, allow_magic = FALSE)
	// weathers have some funky global state that may break if multiple are running. better safe than sorry.
	return ..() && !length(SSweather.processing)

/datum/round_event/anomaly/anomaly_weather
	start_when = ANOMALY_START_HARMFUL_TIME
	announce_when = ANOMALY_ANNOUNCE_HARMFUL_TIME
	anomaly_path = /obj/effect/anomaly/weather

	var/forced_weather_type = null
	var/forced_thunder_chance = null

/datum/round_event/anomaly/anomaly_weather/announce(fake)
	if(isnull(impact_area))
		impact_area = placer.findValidArea()
	priority_announce("在 [ANOMALY_ANNOUNCE_HARMFUL_TEXT] [impact_area.name] 检测到气压异常。", "异常警报")

/datum/round_event/anomaly/anomaly_weather/make_anomaly(turf/anomaly_turf)
	return new anomaly_path(anomaly_turf, null, null, forced_weather_type, forced_thunder_chance)

/datum/round_event_control/anomaly/anomaly_weather/thundering
	name = "异常：雷暴天气"
	typepath = /datum/round_event/anomaly/anomaly_weather/thundering

	max_occurrences = 1
	weight = 5
	description = "该异常会使更危险的天气效果在室内显现，如伴随频繁落雷的雷暴。 \
		此版本会引发落雷，可对人员和设备造成相当的损害。"
	min_wizard_trigger_potency = 2
	max_wizard_trigger_potency = 7

/datum/round_event/anomaly/anomaly_weather/thundering
	start_when = ANOMALY_START_DANGEROUS_TIME
	announce_when = ANOMALY_ANNOUNCE_DANGEROUS_TIME
	anomaly_path = /obj/effect/anomaly/weather/thundering

/datum/round_event/anomaly/anomaly_weather/thundering/announce(fake)
	if(isnull(impact_area))
		impact_area = placer.findValidArea()
	priority_announce("在 [ANOMALY_ANNOUNCE_DANGEROUS_TEXT] [impact_area.name] 检测到严重气压异常。", "异常警报")

/datum/event_admin_setup/listed_options/weather_anomaly
	input_text = "天气类型？请务必小心那些危险的类型！"
	normal_run_option = "默认"

/datum/event_admin_setup/listed_options/weather_anomaly/get_list()
	return valid_subtypesof(/datum/weather)

/datum/event_admin_setup/listed_options/weather_anomaly/apply_to_event(datum/round_event/anomaly/anomaly_weather/event)
	event.forced_weather_type = chosen

/datum/event_admin_setup/listed_options/weather_thunder
	input_text = "落雷概率？请小心高数值！"
	normal_run_option = "默认"

/datum/event_admin_setup/listed_options/weather_thunder/get_list()
	return GLOB.thunder_chance_options.Copy()

/datum/event_admin_setup/listed_options/weather_thunder/apply_to_event(datum/round_event/anomaly/anomaly_weather/event)
	event.forced_thunder_chance = GLOB.thunder_chance_options[chosen]
