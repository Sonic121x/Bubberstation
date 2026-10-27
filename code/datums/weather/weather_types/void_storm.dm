/datum/weather/void_storm
	name = "void storm"
	desc = "罕见且极度异常的事件，往往伴随着撕裂时空连续体的未知实体。我们建议你赶快逃跑。"

	telegraph_duration = 2 SECONDS
	telegraph_overlay = "light_snow"

	weather_message = span_hypnophrase("你感到周围的空气渐渐变冷……还有虚空那甜美的拥抱……")
	weather_overlay = "light_snow"
	weather_color = COLOR_BLACK
	weather_duration_lower = 1 MINUTES
	weather_duration_upper = 2 MINUTES

	use_glow = FALSE

	end_duration = 10 SECONDS

	area_type = /area
	target_trait = ZTRAIT_VOIDSTORM

	weather_flags = (WEATHER_INDOORS | WEATHER_BAROMETER | WEATHER_ENDLESS)
