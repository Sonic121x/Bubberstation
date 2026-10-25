ADMIN_VERB(run_weather, R_ADMIN|R_FUN, "运行天气", "在你选择的 Z 层上触发特定天气。", ADMIN_CATEGORY_EVENTS)

	var/list/weather_choices = list()
	if(!length(weather_choices))
		for(var/datum/weather/weather_type as anything in valid_subtypesof(/datum/weather))
			weather_choices["[chinese_weather_display(weather_type::name)] ([initial(weather_type.type)])"] = weather_type

	var/datum/weather/weather_choice = tgui_input_list(user, "选择要运行的天气", "天气", weather_choices)
	if(!weather_choice)
		return
	weather_choice = weather_choices[weather_choice]

	var/turf/current_turf = get_turf(user.mob)
	var/z_level = tgui_input_number(user, "目标 Z 层", "Z 层", min_value = 1, max_value = world.maxz, default = current_turf?.z)
	if(!isnum(z_level))
		return

	var/static/list/custom_options = list("Default", "Custom", "Cancel")
	var/custom_choice = tgui_alert(user, "你想以何种方式应用天气设置？", "自定义天气", custom_options)
	switch(custom_choice)
		if("Default")
			SSweather.run_weather(weather_choice, z_level) // default settings
			message_admins("[key_name_admin(user)] 在 Z 层 [z_level] 启动了一场类型为 [weather_choice] 的天气。")
			log_admin("[key_name(user)] 在 Z 层 [z_level] 启动了一场类型为 [weather_choice] 的天气。")
			BLACKBOX_LOG_ADMIN_VERB("Run Weather")
			return
		if("Cancel")
			return

	var/list/area_choices = list()
	for(var/area/area_instance as anything in GLOB.areas)
		area_choices[area_instance.type] ||= list()
		area_choices[area_instance.type] |= area_instance

	var/area/area_choice = tgui_input_list(user, "选择天气影响的目标区域", "目标区域", area_choices)
	if(!area_choice)
		return
	area_choice = area_choices[area_choice]

	var/weather_bitflags = input_bitfield(
		user,
		"天气标志 - 为你的天气事件选择标志",
		"weather_flags",
		weather_choice::weather_flags,
	)

	var/datum/reagent/reagent_choice
	if((weather_bitflags & (WEATHER_TURFS|WEATHER_MOBS)))
		var/static/list/reagent_options = list("Yes", "No", "Cancel")
		var/reagent_option = tgui_alert(user, "你想让这场天气使用自定义试剂吗？", "天气试剂", reagent_options)
		switch(reagent_option)
			if("Cancel")
				return
			if("Yes")
				var/static/list/reagent_choices = list()
				if(!length(reagent_choices))
					for(var/datum/reagent/reagent_type as anything in subtypesof(/datum/reagent))
						reagent_choices[initial(reagent_type.type)] = reagent_type

				reagent_choice = tgui_input_list(user, "选择降雨所使用的试剂", "降雨试剂", reagent_choices)
				if(!reagent_choice)
					return
				reagent_choice = reagent_choices[reagent_choice]

	var/thunder_value
	if(weather_bitflags & (WEATHER_THUNDER))
		var/static/list/thunder_choices = GLOB.thunder_chance_options

		var/thunder_choice = tgui_input_list(user, "你想要多少雷声", "雷声", thunder_choices)
		if(!thunder_choice)
			return
		thunder_value = GLOB.thunder_chance_options[thunder_choice]

	var/list/weather_data = list(
		WEATHER_FORCED_AREAS = area_choice,
		WEATHER_FORCED_FLAGS = weather_bitflags,
		WEATHER_FORCED_THUNDER = thunder_value,
		WEATHER_FORCED_REAGENT = reagent_choice,
	)

	SSweather.run_weather(weather_choice, z_level, weather_data)

	message_admins("[key_name_admin(user)] 在 Z 层 [z_level] 启动了一场类型为 [weather_choice] 的天气。")
	log_admin("[key_name(user)] 在 Z 层 [z_level] 启动了一场类型为 [weather_choice] 的天气。")
	BLACKBOX_LOG_ADMIN_VERB("Run Weather")

ADMIN_VERB(stop_weather, R_ADMIN|R_DEBUG, "停止所有活动天气", "停止当前所有活动的天气。", ADMIN_CATEGORY_EVENTS)
	log_admin("[key_name(user)] 停止了当前所有活动的天气。")
	message_admins("[key_name_admin(user)] 停止了当前所有活动的天气。")
	for(var/datum/weather/current_weather as anything in SSweather.processing)
		if(current_weather in SSweather.processing)
			current_weather.end()
	BLACKBOX_LOG_ADMIN_VERB("Stop All Active Weather")
