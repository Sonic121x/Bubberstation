// Normal strength

/datum/round_event_control/meteor_wave
	name = "陨石波：普通"
	typepath = /datum/round_event/meteor_wave
	weight = 4
	min_players = 15
	max_occurrences = 3
	earliest_start = 25 MINUTES
	category = EVENT_CATEGORY_SPACE
	description = "一场普通的陨石波。"
	map_flags = EVENT_SPACE_ONLY

/datum/round_event/meteor_wave
	start_when = 6
	end_when = 66
	announce_when = 1
	var/list/wave_type
	var/wave_name = "normal"

/datum/round_event/meteor_wave/New()
	..()
	if(!wave_type)
		determine_wave_type()

/datum/round_event/meteor_wave/proc/determine_wave_type()
	if(!wave_name)
		wave_name = pick_weight(list(
			"normal" = 50,
			"threatening" = 40,
			"catastrophic" = 10))
	switch(wave_name)
		if("normal")
			wave_type = GLOB.meteors_normal
		if("threatening")
			wave_type = GLOB.meteors_threatening
		if("catastrophic")
			if(check_holidays(HALLOWEEN))
				wave_type = GLOB.meteorsSPOOKY
			else
				wave_type = GLOB.meteors_catastrophic
		if("meaty")
			wave_type = GLOB.meateors
		if("space dust")
			wave_type = GLOB.meteors_dust
		if("halloween")
			wave_type = GLOB.meteorsSPOOKY
		else
			WARNING("Wave name of [wave_name] not recognised.")
			kill()

/datum/round_event/meteor_wave/announce(fake)
	priority_announce("检测到陨石正沿碰撞航线飞向空间站。", "陨石警报", ANNOUNCER_METEORS)

/datum/round_event/meteor_wave/tick()
	if(ISMULTIPLE(activeFor, 3))
		spawn_meteors(5, wave_type) //meteor list types defined in gamemode/meteor/meteors.dm

/datum/round_event_control/meteor_wave/threatening
	name = "陨石波：威胁级"
	typepath = /datum/round_event/meteor_wave/threatening
	weight = 5
	min_players = 20
	max_occurrences = 3
	earliest_start = 35 MINUTES
	description = "一场出现大型陨石概率更高的陨石波。"

/datum/round_event/meteor_wave/threatening
	wave_name = "threatening"

/datum/round_event_control/meteor_wave/catastrophic
	name = "陨石波：灾难级"
	typepath = /datum/round_event/meteor_wave/catastrophic
	weight = 7
	min_players = 25
	max_occurrences = 3
	earliest_start = 45 MINUTES
	description = "一场可能召唤通古斯级陨石的陨石波。"

/datum/round_event/meteor_wave/catastrophic
	wave_name = "catastrophic"

/datum/round_event_control/meteor_wave/meaty
	name = "陨石波：肉块"
	typepath = /datum/round_event/meteor_wave/meaty
	weight = 2
	max_occurrences = 1
	description = "一场由肉组成的陨石波。"

/datum/round_event/meteor_wave/meaty
	wave_name = "meaty"

/* BUBBER EDIT REMOVAL BEGIN - moved to modular_zubbers/code/modules/events/meteor_wave.dm
/datum/round_event/meteor_wave/meaty/announce(fake)
	priority_announce("Meaty ores have been detected on collision course with the station.", "Oh crap, get the mop.", ANNOUNCER_METEORS)
*/// BUBBER EDIT REMOVAL FINISH

/datum/round_event_control/meteor_wave/dust_storm
	name = "大型太空尘埃"
	typepath = /datum/round_event/meteor_wave/dust_storm
	weight = 14
	description = "空间站被沙尘拍打。"
	earliest_start = 15 MINUTES
	min_wizard_trigger_potency = 4
	max_wizard_trigger_potency = 7

/datum/round_event/meteor_wave/dust_storm
	announce_chance = 85
	wave_name = "space dust"

/datum/round_event/meteor_wave/dust_storm/announce(fake)
	var/list/reasons = list()

	reasons += "[station_name()] 正穿过一片碎片云，外部装置和配件 \
		可能会出现轻微损伤。"

	reasons += "纳米传讯超级武器部正在测试一种新型原型 \
		[pick("场域","投影","新星","超级碰撞","反应式")] \
		[pick("加农炮","火炮","坦克","巡洋舰","\[已删节\]")]， \
		预计会有少量轻微碎片。"

	reasons += "邻近的空间站正在朝你们扔石头。（也许他们 \
		已经受够了你发的消息。）"

	reasons += "[station_name()] 的轨道正穿过一片来自小行星 \
		采矿作业的残骸云。预计会出现轻微的船体损伤。"

	reasons += "一颗正拦截 [station_name()] 的大型流星体已被摧毁。 \
		残留碎片可能会撞击空间站外壳。"

	reasons += "[station_name()] 撞上了一片格外崎岖的太空区域。 \
		请注意可能出现的颠簸或碎片造成的损伤。"

	priority_announce(pick(reasons), "碰撞警报")
