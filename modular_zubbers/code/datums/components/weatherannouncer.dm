/datum/component/weather_announcer
	var/warning_range_low = 60
	var/warning_range_high = TIME_BLOODSUCKER_DAY_WARN

/datum/component/weather_announcer/Initialize(
	state_normal,
	state_warning,
	state_danger,
	radar_z_trait,
)
	. = ..()
	RegisterSignal(SSsunlight, COMSIG_SOL_NEAR_START, PROC_REF(on_daylight_warning))

/datum/component/weather_announcer/proc/on_daylight_warning(datum/controller/subsystem/processing/sunlight)
	var/variability = rand(warning_range_low, warning_range_high)
	addtimer(CALLBACK(src, PROC_REF(warn_user)), variability)

/datum/component/weather_announcer/proc/warn_user()
	var/list/messages = list(
		"检测到太阳活动。易受影响者请寻找掩蔽处。",
		"警告：检测到太阳耀斑将在 [TIME_BLOODSUCKER_DAY_WARN] 秒内到达。",
		"太阳活动将在 [TIME_BLOODSUCKER_DAY_WARN] 秒内到来。请寻找掩蔽处。",
	)
	var/atom/movable/speaker = parent
	speaker?.say(pick(messages))
