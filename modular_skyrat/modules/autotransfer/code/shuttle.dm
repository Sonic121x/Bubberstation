/datum/controller/subsystem/shuttle
	var/endvote_passed = FALSE

/datum/controller/subsystem/shuttle/proc/autoEnd()
	if(EMERGENCY_IDLE_OR_RECALLED)
		SSshuttle.emergency.request()
		log_game("回合结束投票已通过，穿梭机已被自动呼叫。")
		message_admins("回合结束投票已通过，穿梭机已被自动呼叫。")
	emergency_no_recall = TRUE
	endvote_passed = TRUE
