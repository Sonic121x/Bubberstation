/datum/round_event_control/grid_check
	name = "电网检查"
	typepath = /datum/round_event/grid_check
	weight = 10
	max_occurrences = 3
	category = EVENT_CATEGORY_ENGINEERING
	description = "关闭所有 APC 一段时间，直到它们被手动重启。"
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 4
	/// Cooldown for the announement associated with this event.
	/// Necessary due to the fact that this event is player triggerable.
	COOLDOWN_DECLARE(announcement_spam_protection)

/datum/round_event/grid_check
	announce_when = 1
	start_when = 1

/datum/round_event/grid_check/announce(fake)
	var/datum/round_event_control/grid_check/controller = control
	if(!fake)
		if(!controller)
			CRASH("event started without controller!")
		if(!COOLDOWN_FINISHED(controller, announcement_spam_protection))
			return
	priority_announce("检测到 [station_name()] 的电网出现异常活动。作为预防措施，空间站的电力将被切断一段不确定的时间。", "严重电力故障", ANNOUNCER_POWEROFF)
	if(!fake) // Only start the CD if we're real
		COOLDOWN_START(controller, announcement_spam_protection, 30 SECONDS)

/datum/round_event/grid_check/start()
	power_fail(60, 240) // 1 to 4 minutes
