/**
 * Sandstorm Event: Throws dust/sand at one side of the station. High-intensity and relatively short,
 * however the incoming direction is given along with time to prepare. Damages can be reduced or
 * mitigated with a few people actively working to fix things as the storm hits, but leaving the event to run on its own can lead to widespread breaches.
 *
 * Meant to be encountered mid-round, with enough spare manpower among the crew to properly respond.
 * Anyone with a welder or metal can contribute.
 */

/datum/round_event_control/sandstorm
	name = "沙尘暴：定向"
	typepath = /datum/round_event/sandstorm
	max_occurrences = 3
	min_players = 35
	earliest_start = 35 MINUTES
	category = EVENT_CATEGORY_SPACE
	description = "一阵太空尘埃持续磨损空间站的一侧。"
	min_wizard_trigger_potency = 6
	max_wizard_trigger_potency = 7
	admin_setup = list(/datum/event_admin_setup/listed_options/sandstorm)
	map_flags = EVENT_SPACE_ONLY

/datum/round_event/sandstorm
	start_when = 60
	end_when = 100
	announce_when = 1
	///Which direction the storm will come from.
	var/start_side

/datum/round_event/sandstorm/setup()
	start_when = rand(70, 90)
	end_when = rand(110, 140)

/datum/round_event/sandstorm/announce(fake)
	if(!start_side)
		start_side = pick(GLOB.cardinals)

	var/start_side_text = "未知"
	switch(start_side)
		if(NORTH)
			start_side_text = "前方"
		if(SOUTH)
			start_side_text = "后方"
		if(EAST)
			start_side_text = "右舷"
		if(WEST)
			start_side_text = "左舷"
		else
			stack_trace("Sandstorm event given [start_side] as unrecognized direction. Cancelling event...")
			kill()
			return

	priority_announce("一大波太空尘埃正从空间站的 [start_side_text] 侧逼近。\
		预计将在两分钟内撞击。鼓励所有员工尽可能协助维修并减轻损害。", "碰撞紧急警报")

/datum/round_event/sandstorm/tick()
	spawn_meteors(15, GLOB.meteors_sandstorm, start_side)

/**
 * The original sandstorm event. An admin-only disasterfest that sands down all sides of the station
 * Uses space dust, meaning walls/rwalls are quickly chewed up very quickly.
 *
 * Super dangerous, super funny, preserved for future admin use in case the new event reminds
 * them that this exists. It is unchanged from its original form and is arguably perfect.
 */

/datum/round_event_control/sandstorm_classic
	name = "沙尘暴：经典"
	typepath = /datum/round_event/sandstorm_classic
	weight = 0
	max_occurrences = 0
	earliest_start = 0 MINUTES
	category = EVENT_CATEGORY_SPACE
	description = "空间站被从四面八方而来的海量尘埃连续拍打数分钟。破坏性极强，且很可能造成卡顿。使用风险自负。"
	map_flags = EVENT_SPACE_ONLY

/datum/round_event/sandstorm_classic
	start_when = 1
	end_when = 150 // ~5 min //I don't think this actually lasts 5 minutes unless you're including the lag it induces
	announce_when = 0
	fakeable = FALSE

/datum/round_event/sandstorm_classic/tick()
	spawn_meteors(10, GLOB.meteors_dust)

/datum/event_admin_setup/listed_options/sandstorm
	input_text = "选择要强力喷砂的一侧？"
	normal_run_option = "随机沙尘暴方向"

/datum/event_admin_setup/listed_options/sandstorm/get_list()
	return list("Up", "Down", "Right", "Left")

/datum/event_admin_setup/listed_options/sandstorm/apply_to_event(datum/round_event/sandstorm/event)
	switch(chosen)
		if("Up")
			event.start_side = NORTH
		if("Down")
			event.start_side = SOUTH
		if("Right")
			event.start_side = EAST
		if("Left")
			event.start_side = WEST
