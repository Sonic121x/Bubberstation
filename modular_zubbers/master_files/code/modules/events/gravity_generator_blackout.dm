/datum/round_event/gravity_generator_blackout
	announce_when = 3
	start_when = 1
	announce_chance = 100

/datum/round_event/gravity_generator_blackout/announce(fake)
	priority_announce("检测到 [station_name()] 质量分配系统出现反馈浪涌。系统重新初始化期间，人工重力已禁用。需要手动重置重力发生器。", "[command_name()] 工程部", ANNOUNCER_GRAVGENBLACKOUT)
